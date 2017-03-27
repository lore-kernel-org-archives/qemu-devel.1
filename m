Received: from eggs.gnu.org ([2001:4830:134:3::10]:49252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1csYQj-0007zN-1C
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1csYQf-0000L5-Mu
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:27:45 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1csYQf-0000Kl-De
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:27:41 -0400
Received: by mail-wr0-x242.google.com with SMTP id w43so12393080wrb.1
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 10:27:41 -0700 (PDT)
Date: Mon, 27 Mar 2017 18:27:38 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170327172738.GG28620@stefanha-x1.localdomain>
References: <1490583036-3683-1-git-send-email-Ashish.Mittal@veritas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yQbNiKLmgenwUfTN"
Content-Disposition: inline
In-Reply-To: <1490583036-3683-1-git-send-email-Ashish.Mittal@veritas.com>
Subject: Re: [Qemu-devel] [PATCH v10 1/2] block/vxhs.c: Add support for a
 new block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashish Mittal <ashmit602@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com, jcody@redhat.com, famz@redhat.com, ashish.mittal@veritas.com, Ketan.Nilangekar@veritas.com, jferlan@redhat.com, Buddhi.Madhav@veritas.com, Suraj.Singh@veritas.com, Nitin.Jerath@veritas.com, peter.maydell@linaro.org, venkatesha.mg@veritas.com, Abhijit.Dey@veritas.com


--yQbNiKLmgenwUfTN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 26, 2017 at 07:50:35PM -0700, Ashish Mittal wrote:

Have you tested live migration?

If live migration is not supported then a migration blocker should be
added using migrate_add_blocker().

> v10 changelog:
> (1) Implemented accepting TLS creds per block device via the CLI
>     (see 3rd e.g in commit log). Corresponding changes made to the
>     libqnio library.
> (2) iio_open() changed to accept TLS creds and use these internally
>     to set up SSL connections.
> (3) Got rid of hard-coded VXHS_UUID_DEF. qemu_uuid is no longer used
>     for authentication in any way.

Why does the code still access qemu_uuid and pass the UUID string to
iio_init()?

In libqnio.git (66698ca47bc594a9f623c240d63ea535f5a42b47) the 'instance'
field is unused and not sent over the wire.  Please drop it.

> diff --git a/block/vxhs.c b/block/vxhs.c
> new file mode 100644
> index 0000000..b98b535
> --- /dev/null
> +++ b/block/vxhs.c
> @@ -0,0 +1,595 @@
> +/*
> + * QEMU Block driver for Veritas HyperScale (VxHS)
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include <qnio/qnio_api.h>
> +#include <sys/param.h>
> +#include "block/block_int.h"
> +#include "qapi/qmp/qerror.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qstring.h"
> +#include "trace.h"
> +#include "qemu/uri.h"
> +#include "qapi/error.h"
> +#include "qemu/uuid.h"
> +#include "crypto/tlscredsx509.h"
> +
> +#define VXHS_OPT_FILENAME           "filename"
> +#define VXHS_OPT_VDISK_ID           "vdisk-id"
> +#define VXHS_OPT_SERVER             "server"
> +#define VXHS_OPT_HOST               "host"
> +#define VXHS_OPT_PORT               "port"
> +
> +QemuUUID qemu_uuid __attribute__ ((weak));
> +
> +static uint32_t vxhs_ref;

It would be nice to add:
/* Only accessed under QEMU global mutex */

> +/*
> + * Parse the incoming URI and populate *options with the host information.
> + * URI syntax has the limitation of supporting only one host info.
> + * To pass multiple host information, use the JSON syntax.

References to multiple hosts are out of date.  The driver only supports
a single host now.

> + */
> +static int vxhs_parse_uri(const char *filename, QDict *options)
> +{
> +    URI *uri = NULL;
> +    char *hoststr, *portstr;
> +    char *port;
> +    int ret = 0;
> +
> +    trace_vxhs_parse_uri_filename(filename);
> +    uri = uri_parse(filename);
> +    if (!uri || !uri->server || !uri->path) {
> +        uri_free(uri);
> +        return -EINVAL;
> +    }
> +
> +    hoststr = g_strdup(VXHS_OPT_SERVER".host");
> +    qdict_put(options, hoststr, qstring_from_str(uri->server));
> +    g_free(hoststr);
> +
> +    portstr = g_strdup(VXHS_OPT_SERVER".port");
> +    if (uri->port) {
> +        port = g_strdup_printf("%d", uri->port);
> +        qdict_put(options, portstr, qstring_from_str(port));
> +        g_free(port);
> +    }
> +    g_free(portstr);

The g_strdup()/g_free() isn't necessary for the qdict_put() key
argument.  The key belongs to the caller so we can pass a string
literal:

  qdict_put(options, VXHS_OPT_SERVER ".host", qstring_from_str(uri->server));
  if (uri->port) {
      port = g_strdup_printf("%d", uri->port);
      qdict_put(options, VXHS_OPT_SERVER ".port", qstring_from_str(port));
      g_free(port);
  }

> +
> +    if (strstr(uri->path, "vxhs") == NULL) {

What does this check do?

> +static int vxhs_open(BlockDriverState *bs, QDict *options,
> +                     int bdrv_flags, Error **errp)
> +{
> +    BDRVVXHSState *s = bs->opaque;
> +    void *dev_handlep = NULL;
> +    QDict *backing_options = NULL;
> +    QemuOpts *opts, *tcp_opts;
> +    char *of_vsa_addr = NULL;
> +    Error *local_err = NULL;
> +    const char *vdisk_id_opt;
> +    const char *server_host_opt;
> +    char *str = NULL;
> +    int ret = 0;
> +    char *cacert = NULL;
> +    char *client_key = NULL;
> +    char *client_cert = NULL;
> +
> +    ret = vxhs_init_and_ref();
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    /* Create opts info from runtime_opts and runtime_tcp_opts list */
> +    opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
> +    tcp_opts = qemu_opts_create(&runtime_tcp_opts, NULL, 0, &error_abort);
> +
> +    qemu_opts_absorb_qdict(opts, options, &local_err);
> +    if (local_err) {
> +        ret = -EINVAL;
> +        goto out;
> +    }
> +
> +    /* vdisk-id is the disk UUID */
> +    vdisk_id_opt = qemu_opt_get(opts, VXHS_OPT_VDISK_ID);
> +    if (!vdisk_id_opt) {
> +        error_setg(&local_err, QERR_MISSING_PARAMETER, VXHS_OPT_VDISK_ID);
> +        ret = -EINVAL;
> +        goto out;
> +    }
> +
> +    /* vdisk-id may contain a leading '/' */
> +    if (strlen(vdisk_id_opt) > UUID_FMT_LEN + 1) {
> +        error_setg(&local_err, "vdisk-id cannot be more than %d characters",
> +                   UUID_FMT_LEN);
> +        ret = -EINVAL;
> +        goto out;
> +    }
> +
> +    s->vdisk_guid = g_strdup(vdisk_id_opt);
> +    trace_vxhs_open_vdiskid(vdisk_id_opt);
> +
> +    /* get the 'server.' arguments */
> +    str = g_strdup_printf(VXHS_OPT_SERVER".");
> +    qdict_extract_subqdict(options, &backing_options, str);

g_strdup_printf() is unnecessary.  You can eliminate the 'str' local
variable and just do:

  qdict_extract_subqdict(options, &backing_options, VXHS_OPT_SERVER ".");

> +
> +    qemu_opts_absorb_qdict(tcp_opts, backing_options, &local_err);
> +    if (local_err != NULL) {
> +        ret = -EINVAL;
> +        goto out;
> +    }
> +
> +    server_host_opt = qemu_opt_get(tcp_opts, VXHS_OPT_HOST);
> +    if (!server_host_opt) {
> +        error_setg(&local_err, QERR_MISSING_PARAMETER,
> +                   VXHS_OPT_SERVER"."VXHS_OPT_HOST);
> +        ret = -EINVAL;
> +        goto out;
> +    }
> +
> +    if (strlen(server_host_opt) > MAXHOSTNAMELEN) {
> +        error_setg(&local_err, "server.host cannot be more than %d characters",
> +                   MAXHOSTNAMELEN);
> +        ret = -EINVAL;
> +        goto out;
> +    }
> +
> +    /* check if we got tls-creds via the --object argument */
> +    s->tlscredsid = g_strdup(qemu_opt_get(opts, "tls-creds"));
> +    if (s->tlscredsid) {
> +        vxhs_get_tls_creds(s->tlscredsid, &cacert, &client_key,
> +                           &client_cert, &local_err);
> +        if (local_err != NULL) {
> +            ret = -EINVAL;
> +            goto out;
> +        }
> +        trace_vxhs_get_creds(cacert, client_key, client_cert);
> +    }
> +
> +    s->vdisk_hostinfo.host = g_strdup(server_host_opt);
> +    s->vdisk_hostinfo.port = g_ascii_strtoll(qemu_opt_get(tcp_opts,
> +                                                          VXHS_OPT_PORT),
> +                                                          NULL, 0);
> +
> +    trace_vxhs_open_hostinfo(s->vdisk_hostinfo.host,
> +                             s->vdisk_hostinfo.port);
> +
> +    of_vsa_addr = g_strdup_printf("of://%s:%d",
> +                                  s->vdisk_hostinfo.host,
> +                                  s->vdisk_hostinfo.port);
> +
> +    /*
> +     * Open qnio channel to storage agent if not opened before
> +     */
> +    dev_handlep = iio_open(of_vsa_addr, s->vdisk_guid, 0,
> +                           cacert, client_key, client_cert);
> +    if (dev_handlep == NULL) {
> +        trace_vxhs_open_iio_open(of_vsa_addr);
> +        ret = -ENODEV;
> +        goto out;
> +    }
> +    s->vdisk_hostinfo.dev_handle = dev_handlep;
> +
> +out:
> +    g_free(str);
> +    g_free(of_vsa_addr);
> +    QDECREF(backing_options);
> +    qemu_opts_del(tcp_opts);
> +    qemu_opts_del(opts);
> +    g_free(cacert);
> +    g_free(client_key);
> +    g_free(client_cert);
> +
> +    if (ret < 0) {
> +        vxhs_unref();
> +        error_propagate(errp, local_err);
> +        g_free(s->vdisk_hostinfo.host);
> +        g_free(s->vdisk_guid);
> +        g_free(s->tlscredsid);
> +        s->vdisk_guid = NULL;
> +        errno = -ret;

.bdrv_open() does not promise anything about errno.  This line can be
dropped.

> +    }
> +
> +    return ret;
> +}
> +
> +static const AIOCBInfo vxhs_aiocb_info = {
> +    .aiocb_size = sizeof(VXHSAIOCB)
> +};
> +
> +/*
> + * This allocates QEMU-VXHS callback for each IO
> + * and is passed to QNIO. When QNIO completes the work,
> + * it will be passed back through the callback.
> + */
> +static BlockAIOCB *vxhs_aio_rw(BlockDriverState *bs, int64_t sector_num,
> +                               QEMUIOVector *qiov, int nb_sectors,
> +                               BlockCompletionFunc *cb, void *opaque,
> +                               VDISKAIOCmd iodir)
> +{
> +    VXHSAIOCB *acb = NULL;
> +    BDRVVXHSState *s = bs->opaque;
> +    size_t size;
> +    uint64_t offset;
> +    int iio_flags = 0;
> +    int ret = 0;
> +    void *dev_handle = s->vdisk_hostinfo.dev_handle;
> +
> +    offset = sector_num * BDRV_SECTOR_SIZE;
> +    size = nb_sectors * BDRV_SECTOR_SIZE;
> +    acb = qemu_aio_get(&vxhs_aiocb_info, bs, cb, opaque);
> +
> +    /*
> +     * Initialize VXHSAIOCB.
> +     */
> +    acb->err = 0;
> +    acb->qiov = qiov;

This field is unused, please remove it.

> +static BlockDriver bdrv_vxhs = {
> +    .format_name                  = "vxhs",
> +    .protocol_name                = "vxhs",
> +    .instance_size                = sizeof(BDRVVXHSState),
> +    .bdrv_file_open               = vxhs_open,
> +    .bdrv_parse_filename          = vxhs_parse_filename,
> +    .bdrv_close                   = vxhs_close,
> +    .bdrv_getlength               = vxhs_getlength,
> +    .bdrv_aio_readv               = vxhs_aio_readv,
> +    .bdrv_aio_writev              = vxhs_aio_writev,

Missing .bdrv_aio_flush().  Does VxHS promise that every completed write
request is persistent?

In that case it may be better to disable the emulated disk write cache
so the guest operating system and application know not to send flush
commands.

--yQbNiKLmgenwUfTN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY2UuJAAoJEJykq7OBq3PIyWUH/0NLQndCYVyclpPo2CrYO6Tk
nP+e4qFqa5ZQXRwYztFquN8k2oQaH37qACmqrkwD1eqwIQYPiroPDdvcNuyPJJn2
Cq5Zs71rwZQs1RVcsJJmwUVBs/n0u3PfhwMvvCkmK3dGJr1ZJX9FXGThzAhTYVCo
tUMfEnaDmNoTK8zE2O3MV53+ycI+VsMgxQTF8JhNweu6q0N5GIR/K4SXVOsBFv6o
Z0To0gysK32ACa8SygBLisDppkQy+vNuI68xVIWI8HRvS6mWDe4u/NTvERw+8khn
RhqdDTl/H2gpZYFH9zNdmgIwDJ2mGqJb8tjMIlrr51VGiyV+N3eBB2jvI7QWvNk=
=SbRE
-----END PGP SIGNATURE-----

--yQbNiKLmgenwUfTN--
