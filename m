Received: from eggs.gnu.org ([2001:4830:134:3::10]:34801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEzjn-0003t0-Vw
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 09:31:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEzjk-0004Tv-SU
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 09:31:56 -0500
Date: Thu, 8 Dec 2016 15:31:35 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161208143135.GA11427@noname.str.redhat.com>
References: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
	<1481203391-9523-2-git-send-email-kwolf@redhat.com>
	<20161208141024.GI26641@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161208141024.GI26641@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] iscsi: Split URL into individual
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, pl@kamp.de, ptoscano@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, qemu-devel@nongnu.org

Am 08.12.2016 um 15:10 hat Daniel P. Berrange geschrieben:
> On Thu, Dec 08, 2016 at 02:23:06PM +0100, Kevin Wolf wrote:
> > This introduces a .bdrv_parse_filename handler for iscsi which parses an
> > URL if given and translates it to individual options.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/iscsi.c | 189 ++++++++++++++++++++++++++++++++++++++++++----------------
> >  1 file changed, 136 insertions(+), 53 deletions(-)
> > 
> > diff --git a/block/iscsi.c b/block/iscsi.c
> > index 0960929..7a6664e 100644
> > --- a/block/iscsi.c
> > +++ b/block/iscsi.c
> > @@ -1469,20 +1469,6 @@ static void iscsi_readcapacity_sync(IscsiLun *iscsilun, Error **errp)
> >      }
> >  }
> >  
> > -/* TODO Convert to fine grained options */
> > -static QemuOptsList runtime_opts = {
> > -    .name = "iscsi",
> > -    .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
> > -    .desc = {
> > -        {
> > -            .name = "filename",
> > -            .type = QEMU_OPT_STRING,
> > -            .help = "URL to the iscsi image",
> > -        },
> > -        { /* end of list */ }
> > -    },
> > -};
> > -
> >  static struct scsi_task *iscsi_do_inquiry(struct iscsi_context *iscsi, int lun,
> >                                            int evpd, int pc, void **inq, Error **errp)
> >  {
> > @@ -1604,20 +1590,98 @@ out:
> >   * We support iscsi url's on the form
> >   * iscsi://[<username>%<password>@]<host>[:<port>]/<targetname>/<lun>
> >   */
> > +static void iscsi_parse_filename(const char *filename, QDict *options,
> > +                                 Error **errp)
> > +{
> > +    struct iscsi_url *iscsi_url;
> > +    const char *transport_name;
> > +    char *lun_str;
> > +
> > +    iscsi_url = iscsi_parse_full_url(NULL, filename);
> > +    if (iscsi_url == NULL) {
> > +        error_setg(errp, "Failed to parse URL : %s", filename);
> > +        return;
> > +    }
> > +
> > +#if LIBISCSI_API_VERSION >= (20160603)
> > +    switch (iscsi_url->transport) {
> > +        case TCP_TRANSPORT:     transport_name = "tcp"; break;
> > +        case ISER_TRANSPORT:    transport_name = "iser"; break;
> > +        default:
> > +            error_setg(errp, "Unknown transport type (%d)",
> > +                       iscsi_url->transport);
> > +            return;
> > +    }
> > +#else
> > +    transport_name = "tcp";
> > +#endif
> 
> Here if the URI contained a transport "iser" and we're using
> an old libiscsi, we silently ignore that and use 'tcp'. IMHO
> we should be reporting "Unsupported transport type 'iser'"
> when using the old libiscsi API/

No, old libiscsi would error out in iscsi_parse_full_url(), so you get
the "Failed to parse URL" message from above. Not ideal, but with the
parsing in the library (which I consider a bad idea, but that's how it
works with libiscsi) that's all we can do.

(Okay, not quite true, we could create a context a pass that instead of
NULL, and then we would get access to a slightly better message from
libiscsi. Anyway, we do fail when we should fail, and improving error
messages is out of scope for this series.)

> > +    qdict_set_default_str(options, "transport", transport_name);
> > +    qdict_set_default_str(options, "portal", iscsi_url->portal);
> > +    qdict_set_default_str(options, "target", iscsi_url->target);
> > +
> > +    lun_str = g_strdup_printf("%d", iscsi_url->lun);
> > +    qdict_set_default_str(options, "lun", lun_str);
> > +    g_free(lun_str);
> > +
> > +    if (iscsi_url->user[0] != '\0') {
> > +        qdict_set_default_str(options, "user", iscsi_url->user);
> > +        qdict_set_default_str(options, "password", iscsi_url->passwd);
> 
> If the URI contains "user" but not "password", this stores bogus
> data in the "password" field I believe.

If any field isn't given, it is zeroed (i.e. an empty string); and if
iscsi_url->user is non-empty, iscsi_url->password is non-empty as well.

I basically just used the same condition as the original code, but I
checked it now once more against the libiscsi implementation to be sure.

> > +    }
> > +
> > +    iscsi_destroy_url(iscsi_url);
> > +}
> > +
> > +/* TODO Add -iscsi options */
> > +static QemuOptsList runtime_opts = {
> > +    .name = "iscsi",
> > +    .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
> > +    .desc = {
> > +        {
> > +            .name = "transport",
> > +            .type = QEMU_OPT_STRING,
> > +        },
> > +        {
> > +            .name = "portal",
> > +            .type = QEMU_OPT_STRING,
> > +        },
> > +        {
> > +            .name = "target",
> > +            .type = QEMU_OPT_STRING,
> > +        },
> > +        {
> > +            .name = "user",
> > +            .type = QEMU_OPT_STRING,
> > +        },
> > +        {
> > +            .name = "password",
> > +            .type = QEMU_OPT_STRING,
> > +        },
> > +        {
> > +            .name = "lun",
> > +            .type = QEMU_OPT_NUMBER,
> > +        },
> > +        { /* end of list */ }
> > +    },
> > +};
> > +
> >  static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
> >                        Error **errp)
> >  {
> >      IscsiLun *iscsilun = bs->opaque;
> >      struct iscsi_context *iscsi = NULL;
> > -    struct iscsi_url *iscsi_url = NULL;
> >      struct scsi_task *task = NULL;
> >      struct scsi_inquiry_standard *inq = NULL;
> >      struct scsi_inquiry_supported_pages *inq_vpd;
> >      char *initiator_name = NULL;
> >      QemuOpts *opts;
> >      Error *local_err = NULL;
> > -    const char *filename;
> > -    int i, ret = 0, timeout = 0;
> > +    const char *transport_name, *portal, *target;
> > +    const char *user, *password;
> > +#if LIBISCSI_API_VERSION >= (20160603)
> > +    enum iscsi_transport_type transport;
> > +#endif
> > +    int i, ret = 0, timeout = 0, lun;
> >  
> >      opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
> >      qemu_opts_absorb_qdict(opts, options, &local_err);
> > @@ -1627,18 +1691,41 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
> >          goto out;
> >      }
> >  
> > -    filename = qemu_opt_get(opts, "filename");
> > +    transport_name = qemu_opt_get(opts, "transport");
> > +    portal = qemu_opt_get(opts, "portal");
> > +    target = qemu_opt_get(opts, "target");
> > +    user = qemu_opt_get(opts, "user");
> > +    password = qemu_opt_get(opts, "password");
> > +    lun = qemu_opt_get_number(opts, "lun", 0);
> 
> Do we really want to default to '0' for LUN ?  With Linux tgtd at
> least this is not a valid LUN to use as a volume. It feels like
> we should be raising an error if 'lun' is not explcitly set by
> the user

I wasn't sure about this one. But it's mandatory in the URL, so I guess
you're right that making it mandatory here as well would make sense.

> >  
> > -    iscsi_url = iscsi_parse_full_url(iscsi, filename);
> > -    if (iscsi_url == NULL) {
> > -        error_setg(errp, "Failed to parse URL : %s", filename);
> > +    if (!transport_name || !portal || !target) {
> > +        error_setg(errp, "Need all of transport, portal and target options");
> > +        ret = -EINVAL;
> > +        goto out;
> > +    }
> > +    if (user && !password) {
> > +        error_setg(errp, "If a user name is given, a password is required");
> > +        ret = -EINVAL;
> > +        goto out;
> > +    }
> > +
> > +    if (!strcmp(transport_name, "tcp")) {
> > +#if LIBISCSI_API_VERSION >= (20160603)
> > +        transport = TCP_TRANSPORT;
> > +    } else if (!strcmp(transport_name, "iser")) {
> > +        transport = ISER_TRANSPORT;
> > +#else
> > +        /* TCP is what older libiscsi versions always use */
> 
> Again we should report an error if user set a transport_name
> of 'iser' here.

If you read the code carefully, we do. :-)

A value of "tcp" is ignored and everything else gets the error message
below in the else branch.

> > +#endif
> > +    } else {
> > +        error_setg(errp, "Unknown transport: %s", transport_name);
> >          ret = -EINVAL;
> >          goto out;
> >      }
> >  
> >      memset(iscsilun, 0, sizeof(IscsiLun));

Kevin
