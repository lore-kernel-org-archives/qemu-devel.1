Received: from eggs.gnu.org ([2001:4830:134:3::10]:52790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciRNB-0006B8-QR
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:54:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciRNA-00070C-ID
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:54:17 -0500
Date: Mon, 27 Feb 2017 19:54:03 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170227195403.GA23045@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.1488220970.git.jcody@redhat.com>
	<12a16b28300f871052a49897ec7875a082fc63e3.1488220970.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12a16b28300f871052a49897ec7875a082fc63e3.1488220970.git.jcody@redhat.com>
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
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com

On Mon, Feb 27, 2017 at 01:58:48PM -0500, Jeff Cody wrote:
> This adds support for two additional options that may be specified
> by QAPI in blockdev-add:
> 
>     mon_host: servername and port
>     auth_supported: either 'cephx' or 'none'
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/rbd.c          | 39 +++++++++++++++++++++++++++++++++++++++
>  qapi/block-core.json |  8 ++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/block/rbd.c b/block/rbd.c
> index e04a5e1..51e971e 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -394,6 +394,18 @@ static QemuOptsList runtime_opts = {
>              .name = "keyvalue-pairs",
>              .type = QEMU_OPT_STRING,
>          },
> +        {
> +            .name = "server.host",
> +            .type = QEMU_OPT_STRING,
> +        },
> +        {
> +            .name = "server.port",
> +            .type = QEMU_OPT_STRING,
> +        },
> +        {
> +            .name = "auth_supported",
> +            .type = QEMU_OPT_STRING,
> +        },
>          { /* end of list */ }
>      },
>  };
> @@ -559,6 +571,7 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
>  {
>      BDRVRBDState *s = bs->opaque;
>      const char *pool, *snap, *conf, *clientname, *name, *keypairs;
> +    const char *host, *port, *auth_supported;
>      const char *secretid;
>      QemuOpts *opts;
>      Error *local_err = NULL;
> @@ -580,6 +593,9 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
>      clientname     = qemu_opt_get(opts, "user");
>      name           = qemu_opt_get(opts, "image");
>      keypairs       = qemu_opt_get(opts, "keyvalue-pairs");
> +    host           = qemu_opt_get(opts, "server.host");
> +    port           = qemu_opt_get(opts, "server.port");
> +    auth_supported = qemu_opt_get(opts, "auth_supported");
>  
>      r = rados_create(&s->cluster, clientname);
>      if (r < 0) {
> @@ -604,6 +620,29 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
>          goto failed_shutdown;
>      }
>  
> +    /* if mon_host was specified */
> +    if (host) {
> +        const char *hostname = host;
> +        char *mon_host = NULL;
> +
> +        if (port) {
> +            mon_host = g_strdup_printf("%s:%s", host, port);
> +            hostname = mon_host;
> +        }
> +        r = rados_conf_set(s->cluster, "mon_host", hostname);
> +        g_free(mon_host);
> +        if (r < 0) {
> +            goto failed_shutdown;
> +        }
> +    }
> +
> +    if (auth_supported) {
> +        r = rados_conf_set(s->cluster, "auth_supported", auth_supported);
> +        if (r < 0) {
> +            goto failed_shutdown;
> +        }
> +    }
> +
>      if (qemu_rbd_set_auth(s->cluster, secretid, errp) < 0) {
>          r = -EIO;
>          goto failed_shutdown;
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 5b311ff..376512c 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2680,6 +2680,12 @@
>  #
>  # @user:               #optional Ceph id name.
>  #
> +# @server:             #optional Monitor host address and port.  This maps
> +#                      to the "mon_host" Ceph option.
> +#
> +# @auth_supported:     #optional Authentication supported.
> +#                      Either "cephx" or"none".
> +#
>  # @password-secret:    #optional The ID of a QCryptoSecret object providing
>  #                       the password for the login.
>  #
> @@ -2691,6 +2697,8 @@
>              '*conf': 'str',
>              '*snapshot': 'str',
>              '*user': 'str',
> +            '*server': 'InetSocketAddress',

This needs to be an array

> +            '*auth_supported': 'str',

IIUC, you're allowed to list multiple auth options too

>              '*password-secret': 'str' } }
>  


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
