Received: from eggs.gnu.org ([2001:4830:134:3::10]:35423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ceiYR-0003Ww-SK
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:26:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ceiYQ-0004d5-Ng
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:26:31 -0500
Date: Fri, 17 Feb 2017 14:26:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170217132621.GH5338@noname.redhat.com>
References: <cover.1485365834.git.jcody@redhat.com>
	<a252efad890c55d5d59e7fe77a9a9b994ee83074.1485365834.git.jcody@redhat.com>
	<20170207101359.GD19280@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170207101359.GD19280@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH v2 2/7] iscsi: Handle -iscsi user/password
 in bdrv_parse_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-block@nongnu.org

Am 07.02.2017 um 11:13 hat Fam Zheng geschrieben:
> On Wed, 01/25 12:42, Jeff Cody wrote:
> > From: Kevin Wolf <kwolf@redhat.com>
> > 
> > This splits the logic in the old parse_chap() function into a part that
> > parses the -iscsi options into the new driver-specific options, and
> > another part that actually applies those options (called apply_chap()
> > now).
> > 
> > Note that this means that username and password specified with -iscsi
> > only take effect when a URL is provided. This is intentional, -iscsi is
> > a legacy interface only supported for compatibility, new users should
> > use the proper driver-specific options.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Signed-off-by: Jeff Cody <jcody@redhat.com>
> > ---
> >  block/iscsi.c | 78 +++++++++++++++++++++++++++++++++--------------------------
> >  1 file changed, 44 insertions(+), 34 deletions(-)
> > 
> > diff --git a/block/iscsi.c b/block/iscsi.c
> > index 97cff30..fc91d0f 100644
> > --- a/block/iscsi.c
> > +++ b/block/iscsi.c
> > @@ -1236,29 +1236,14 @@ retry:
> >      return 0;
> >  }
> >  
> > -static void parse_chap(struct iscsi_context *iscsi, const char *target,
> > +static void apply_chap(struct iscsi_context *iscsi, QemuOpts *opts,
> >                         Error **errp)
> >  {
> > -    QemuOptsList *list;
> > -    QemuOpts *opts;
> >      const char *user = NULL;
> >      const char *password = NULL;
> >      const char *secretid;
> >      char *secret = NULL;
> >  
> > -    list = qemu_find_opts("iscsi");
> > -    if (!list) {
> > -        return;
> > -    }
> > -
> > -    opts = qemu_opts_find(list, target);
> > -    if (opts == NULL) {
> > -        opts = QTAILQ_FIRST(&list->head);
> > -        if (!opts) {
> > -            return;
> > -        }
> > -    }
> > -
> >      user = qemu_opt_get(opts, "user");
> >      if (!user) {
> >          return;
> > @@ -1587,6 +1572,41 @@ out:
> >      }
> >  }
> >  
> > +static void iscsi_parse_iscsi_option(const char *target, QDict *options)
> > +{
> > +    QemuOptsList *list;
> > +    QemuOpts *opts;
> > +    const char *user, *password, *password_secret;
> > +
> > +    list = qemu_find_opts("iscsi");
> > +    if (!list) {
> > +        return;
> > +    }
> > +
> > +    opts = qemu_opts_find(list, target);
> > +    if (opts == NULL) {
> > +        opts = QTAILQ_FIRST(&list->head);
> > +        if (!opts) {
> > +            return;
> > +        }
> > +    }
> > +
> > +    user = qemu_opt_get(opts, "user");
> > +    if (user) {
> > +        qdict_set_default_str(options, "user", user);
> > +    }
> > +
> > +    password = qemu_opt_get(opts, "password");
> > +    if (password) {
> > +        qdict_set_default_str(options, "password", password);
> > +    }
> > +
> > +    password_secret = qemu_opt_get(opts, "password-secret");
> > +    if (password_secret) {
> > +        qdict_set_default_str(options, "password-secret", password_secret);
> > +    }
> > +}
> > +
> >  /*
> >   * We support iscsi url's on the form
> >   * iscsi://[<username>%<password>@]<host>[:<port>]/<targetname>/<lun>
> > @@ -1625,6 +1645,9 @@ static void iscsi_parse_filename(const char *filename, QDict *options,
> >      qdict_set_default_str(options, "lun", lun_str);
> >      g_free(lun_str);
> >  
> > +    /* User/password from -iscsi take precedence over those from the URL */
> > +    iscsi_parse_iscsi_option(iscsi_url->target, options);
> > +
> 
> Isn't more natural to let the local option take precedence over the global one?

One would think so, but that's how the option work today, so we can't
change it without breaking compatibility. We can only newly define the
precedence of the new driver-specific options vs. the existing ones, and
there the local driver-specific ones do take precedence.

> >      if (iscsi_url->user[0] != '\0') {
> >          qdict_set_default_str(options, "user", iscsi_url->user);
> >          qdict_set_default_str(options, "password", iscsi_url->passwd);
> > @@ -1659,6 +1682,10 @@ static QemuOptsList runtime_opts = {
> >              .type = QEMU_OPT_STRING,
> >          },
> >          {
> > +            .name = "password-secret",
> > +            .type = QEMU_OPT_STRING,
> > +        },
> > +        {
> 
> I think this added password-secret is not the one looked up in
> iscsi_parse_iscsi_option(), which is from -iscsi
> (block/iscsi-opts.c:qemu_iscsi_opts). Is this intended? Or does it belong to a
> different patch?

It is the one that it put into the QDict by iscsi_parse_iscsi_option(),
which is supposed to be the value from -iscsi.

Why do you think it's not the one? Maybe I'm missing something.

Kevin
