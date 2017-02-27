Received: from eggs.gnu.org ([2001:4830:134:3::10]:47791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciUJh-0002Ec-9g
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:02:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciUJg-0005ea-1v
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:02:53 -0500
Date: Mon, 27 Feb 2017 18:02:44 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170227230244.GN25637@localhost.localdomain>
References: <cover.1488220970.git.jcody@redhat.com>
	<12a16b28300f871052a49897ec7875a082fc63e3.1488220970.git.jcody@redhat.com>
	<c5869fe5-fa51-3f2f-26d6-26a733c15493@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5869fe5-fa51-3f2f-26d6-26a733c15493@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] block/rbd: add support for
 'mon_host', 'auth_supported' via QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, berrange@redhat.com

On Mon, Feb 27, 2017 at 04:47:54PM -0600, Eric Blake wrote:
> On 02/27/2017 12:58 PM, Jeff Cody wrote:
> > This adds support for two additional options that may be specified
> > by QAPI in blockdev-add:
> > 
> >     mon_host: servername and port
> >     auth_supported: either 'cephx' or 'none'
> 
> Please spell new options with '-'
> 

OK, thanks.

> > 
> > Signed-off-by: Jeff Cody <jcody@redhat.com>
> > ---
> >  block/rbd.c          | 39 +++++++++++++++++++++++++++++++++++++++
> >  qapi/block-core.json |  8 ++++++++
> >  2 files changed, 47 insertions(+)
> > 
> > diff --git a/block/rbd.c b/block/rbd.c
> > index e04a5e1..51e971e 100644
> > --- a/block/rbd.c
> > +++ b/block/rbd.c
> > @@ -394,6 +394,18 @@ static QemuOptsList runtime_opts = {
> >              .name = "keyvalue-pairs",
> >              .type = QEMU_OPT_STRING,
> >          },
> > +        {
> > +            .name = "server.host",
> > +            .type = QEMU_OPT_STRING,
> > +        },
> > +        {
> > +            .name = "server.port",
> > +            .type = QEMU_OPT_STRING,
> > +        },
> 
> See Dan's comment about supporting more than one server via an array in
> QAPI.
> 
> > +        {
> > +            .name = "auth_supported",
> 
> Should be auth-supported in QAPI.
> 
> 

OK

> > @@ -604,6 +620,29 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
> >          goto failed_shutdown;
> >      }
> >  
> > +    /* if mon_host was specified */
> > +    if (host) {
> > +        const char *hostname = host;
> > +        char *mon_host = NULL;
> > +
> > +        if (port) {
> > +            mon_host = g_strdup_printf("%s:%s", host, port);
> 
> Does Ceph care about IPv6 (in which case you may need [host]:port when
> host itself includes ':')?
> 

Good question - it looks like it can be enabled in the conf file at least,
from this: 

http://docs.ceph.com/docs/master/install/manual-deployment/


> > +            hostname = mon_host;
> > +        }
> > +        r = rados_conf_set(s->cluster, "mon_host", hostname);
> > +        g_free(mon_host);
> > +        if (r < 0) {
> > +            goto failed_shutdown;
> > +        }
> > +    }
> > +
> > +    if (auth_supported) {
> > +        r = rados_conf_set(s->cluster, "auth_supported", auth_supported);
> 
> Translating QAPI auth-supported to rados auth_supported is fine.
> 
> 
> > +++ b/qapi/block-core.json
> > @@ -2680,6 +2680,12 @@
> >  #
> >  # @user:               #optional Ceph id name.
> >  #
> > +# @server:             #optional Monitor host address and port.  This maps
> > +#                      to the "mon_host" Ceph option.
> > +#
> > +# @auth_supported:     #optional Authentication supported.
> > +#                      Either "cephx" or"none".
> 
> Missing a space.
> 
> If you're going to support only a finite set of strings, this should be
> a QAPI enum type, not 'str'.
>

OK, I'll make it an enum (and fix the space, of course).

> > +#
> >  # @password-secret:    #optional The ID of a QCryptoSecret object providing
> >  #                       the password for the login.
> >  #
> > @@ -2691,6 +2697,8 @@
> >              '*conf': 'str',
> >              '*snapshot': 'str',
> >              '*user': 'str',
> > +            '*server': 'InetSocketAddress',
> > +            '*auth_supported': 'str',
> >              '*password-secret': 'str' } }
> >  
> >  ##
> > 
> 
> Looks like we'll need a v3 to tweak this one.
>

Yep - working on that now.  Thanks!

-Jeff
