Received: from eggs.gnu.org ([2001:4830:134:3::10]:48799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1csfZ6-0005ne-Qr
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 21:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1csfZ4-00038N-SH
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 21:04:52 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:36116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1csfZ4-00038J-M7
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 21:04:50 -0400
Received: by mail-it0-x243.google.com with SMTP id 190so538433itm.3
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 18:04:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170327172738.GG28620@stefanha-x1.localdomain>
References: <1490583036-3683-1-git-send-email-Ashish.Mittal@veritas.com>
	<20170327172738.GG28620@stefanha-x1.localdomain>
From: ashish mittal <ashmit602@gmail.com>
Date: Mon, 27 Mar 2017 18:04:49 -0700
Message-ID: <CAAo6VWPPjX2UfU55rnR375jzmpMojUOHfmMafwBiZqBa80aBeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <ashish.mittal@veritas.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, "Venkatesha M.G." <venkatesha.mg@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>

On Mon, Mar 27, 2017 at 10:27 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Sun, Mar 26, 2017 at 07:50:35PM -0700, Ashish Mittal wrote:
>
> Have you tested live migration?
>
> If live migration is not supported then a migration blocker should be
> added using migrate_add_blocker().
>

We do support live migration. We have been testing a fork of this code
(slightly different version) with live migration.

>> v10 changelog:
>> (1) Implemented accepting TLS creds per block device via the CLI
>>     (see 3rd e.g in commit log). Corresponding changes made to the
>>     libqnio library.
>> (2) iio_open() changed to accept TLS creds and use these internally
>>     to set up SSL connections.
>> (3) Got rid of hard-coded VXHS_UUID_DEF. qemu_uuid is no longer used
>>     for authentication in any way.
>
> Why does the code still access qemu_uuid and pass the UUID string to
> iio_init()?
>

I was of the opinion that knowing what instance (for qemu-kvm case)
was opening a block device could be a useful piece of information for
the block device to have in the future.

> In libqnio.git (66698ca47bc594a9f623c240d63ea535f5a42b47) the 'instance'
> field is unused and not sent over the wire.  Please drop it.
>

It is not used at present. I will drop it.

>> diff --git a/block/vxhs.c b/block/vxhs.c
>> new file mode 100644
>> index 0000000..b98b535
>> --- /dev/null
>> +++ b/block/vxhs.c
>> @@ -0,0 +1,595 @@
>> +/*
>> + * QEMU Block driver for Veritas HyperScale (VxHS)
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include <qnio/qnio_api.h>
>> +#include <sys/param.h>
>> +#include "block/block_int.h"
>> +#include "qapi/qmp/qerror.h"
>> +#include "qapi/qmp/qdict.h"
>> +#include "qapi/qmp/qstring.h"
>> +#include "trace.h"
>> +#include "qemu/uri.h"
>> +#include "qapi/error.h"
>> +#include "qemu/uuid.h"
>> +#include "crypto/tlscredsx509.h"
>> +
>> +#define VXHS_OPT_FILENAME           "filename"
>> +#define VXHS_OPT_VDISK_ID           "vdisk-id"
>> +#define VXHS_OPT_SERVER             "server"
>> +#define VXHS_OPT_HOST               "host"
>> +#define VXHS_OPT_PORT               "port"
>> +
>> +QemuUUID qemu_uuid __attribute__ ((weak));
>> +
>> +static uint32_t vxhs_ref;
>
> It would be nice to add:
> /* Only accessed under QEMU global mutex */
>
Will do.

>> +/*
>> + * Parse the incoming URI and populate *options with the host information.
>> + * URI syntax has the limitation of supporting only one host info.
>> + * To pass multiple host information, use the JSON syntax.
>
> References to multiple hosts are out of date.  The driver only supports
> a single host now.
>
Will change.

>> + */
>> +static int vxhs_parse_uri(const char *filename, QDict *options)
>> +{
>> +    URI *uri = NULL;
>> +    char *hoststr, *portstr;
>> +    char *port;
>> +    int ret = 0;
>> +
>> +    trace_vxhs_parse_uri_filename(filename);
>> +    uri = uri_parse(filename);
>> +    if (!uri || !uri->server || !uri->path) {
>> +        uri_free(uri);
>> +        return -EINVAL;
>> +    }
>> +
>> +    hoststr = g_strdup(VXHS_OPT_SERVER".host");
>> +    qdict_put(options, hoststr, qstring_from_str(uri->server));
>> +    g_free(hoststr);
>> +
>> +    portstr = g_strdup(VXHS_OPT_SERVER".port");
>> +    if (uri->port) {
>> +        port = g_strdup_printf("%d", uri->port);
>> +        qdict_put(options, portstr, qstring_from_str(port));
>> +        g_free(port);
>> +    }
>> +    g_free(portstr);
>
> The g_strdup()/g_free() isn't necessary for the qdict_put() key
> argument.  The key belongs to the caller so we can pass a string
> literal:

Will Change.

>
>   qdict_put(options, VXHS_OPT_SERVER ".host", qstring_from_str(uri->server));
>   if (uri->port) {
>       port = g_strdup_printf("%d", uri->port);
>       qdict_put(options, VXHS_OPT_SERVER ".port", qstring_from_str(port));
>       g_free(port);
>   }
>
>> +
>> +    if (strstr(uri->path, "vxhs") == NULL) {
>
> What does this check do?
>

Not sure about the history, but it's been there since first code
draft. Will check if it serves any purpose, or remove it.

>> +static int vxhs_open(BlockDriverState *bs, QDict *options,
>> +                     int bdrv_flags, Error **errp)
>> +{
>> +    BDRVVXHSState *s = bs->opaque;
>> +    void *dev_handlep = NULL;
>> +    QDict *backing_options = NULL;
>> +    QemuOpts *opts, *tcp_opts;
>> +    char *of_vsa_addr = NULL;
>> +    Error *local_err = NULL;
>> +    const char *vdisk_id_opt;
>> +    const char *server_host_opt;
>> +    char *str = NULL;
>> +    int ret = 0;
>> +    char *cacert = NULL;
>> +    char *client_key = NULL;
>> +    char *client_cert = NULL;
>> +
>> +    ret = vxhs_init_and_ref();
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    /* Create opts info from runtime_opts and runtime_tcp_opts list */
>> +    opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
>> +    tcp_opts = qemu_opts_create(&runtime_tcp_opts, NULL, 0, &error_abort);
>> +
>> +    qemu_opts_absorb_qdict(opts, options, &local_err);
>> +    if (local_err) {
>> +        ret = -EINVAL;
>> +        goto out;
>> +    }
>> +
>> +    /* vdisk-id is the disk UUID */
>> +    vdisk_id_opt = qemu_opt_get(opts, VXHS_OPT_VDISK_ID);
>> +    if (!vdisk_id_opt) {
>> +        error_setg(&local_err, QERR_MISSING_PARAMETER, VXHS_OPT_VDISK_ID);
>> +        ret = -EINVAL;
>> +        goto out;
>> +    }
>> +
>> +    /* vdisk-id may contain a leading '/' */
>> +    if (strlen(vdisk_id_opt) > UUID_FMT_LEN + 1) {
>> +        error_setg(&local_err, "vdisk-id cannot be more than %d characters",
>> +                   UUID_FMT_LEN);
>> +        ret = -EINVAL;
>> +        goto out;
>> +    }
>> +
>> +    s->vdisk_guid = g_strdup(vdisk_id_opt);
>> +    trace_vxhs_open_vdiskid(vdisk_id_opt);
>> +
>> +    /* get the 'server.' arguments */
>> +    str = g_strdup_printf(VXHS_OPT_SERVER".");
>> +    qdict_extract_subqdict(options, &backing_options, str);
>
> g_strdup_printf() is unnecessary.  You can eliminate the 'str' local
> variable and just do:
>
>   qdict_extract_subqdict(options, &backing_options, VXHS_OPT_SERVER ".");
>
Will do. Thanks!

>> +
>> +    qemu_opts_absorb_qdict(tcp_opts, backing_options, &local_err);
>> +    if (local_err != NULL) {
>> +        ret = -EINVAL;
>> +        goto out;
>> +    }
>> +
>> +    server_host_opt = qemu_opt_get(tcp_opts, VXHS_OPT_HOST);
>> +    if (!server_host_opt) {
>> +        error_setg(&local_err, QERR_MISSING_PARAMETER,
>> +                   VXHS_OPT_SERVER"."VXHS_OPT_HOST);
>> +        ret = -EINVAL;
>> +        goto out;
>> +    }
>> +
>> +    if (strlen(server_host_opt) > MAXHOSTNAMELEN) {
>> +        error_setg(&local_err, "server.host cannot be more than %d characters",
>> +                   MAXHOSTNAMELEN);
>> +        ret = -EINVAL;
>> +        goto out;
>> +    }
>> +
>> +    /* check if we got tls-creds via the --object argument */
>> +    s->tlscredsid = g_strdup(qemu_opt_get(opts, "tls-creds"));
>> +    if (s->tlscredsid) {
>> +        vxhs_get_tls_creds(s->tlscredsid, &cacert, &client_key,
>> +                           &client_cert, &local_err);
>> +        if (local_err != NULL) {
>> +            ret = -EINVAL;
>> +            goto out;
>> +        }
>> +        trace_vxhs_get_creds(cacert, client_key, client_cert);
>> +    }
>> +
>> +    s->vdisk_hostinfo.host = g_strdup(server_host_opt);
>> +    s->vdisk_hostinfo.port = g_ascii_strtoll(qemu_opt_get(tcp_opts,
>> +                                                          VXHS_OPT_PORT),
>> +                                                          NULL, 0);
>> +
>> +    trace_vxhs_open_hostinfo(s->vdisk_hostinfo.host,
>> +                             s->vdisk_hostinfo.port);
>> +
>> +    of_vsa_addr = g_strdup_printf("of://%s:%d",
>> +                                  s->vdisk_hostinfo.host,
>> +                                  s->vdisk_hostinfo.port);
>> +
>> +    /*
>> +     * Open qnio channel to storage agent if not opened before
>> +     */
>> +    dev_handlep = iio_open(of_vsa_addr, s->vdisk_guid, 0,
>> +                           cacert, client_key, client_cert);
>> +    if (dev_handlep == NULL) {
>> +        trace_vxhs_open_iio_open(of_vsa_addr);
>> +        ret = -ENODEV;
>> +        goto out;
>> +    }
>> +    s->vdisk_hostinfo.dev_handle = dev_handlep;
>> +
>> +out:
>> +    g_free(str);
>> +    g_free(of_vsa_addr);
>> +    QDECREF(backing_options);
>> +    qemu_opts_del(tcp_opts);
>> +    qemu_opts_del(opts);
>> +    g_free(cacert);
>> +    g_free(client_key);
>> +    g_free(client_cert);
>> +
>> +    if (ret < 0) {
>> +        vxhs_unref();
>> +        error_propagate(errp, local_err);
>> +        g_free(s->vdisk_hostinfo.host);
>> +        g_free(s->vdisk_guid);
>> +        g_free(s->tlscredsid);
>> +        s->vdisk_guid = NULL;
>> +        errno = -ret;
>
> .bdrv_open() does not promise anything about errno.  This line can be
> dropped.
>
Will do.

>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static const AIOCBInfo vxhs_aiocb_info = {
>> +    .aiocb_size = sizeof(VXHSAIOCB)
>> +};
>> +
>> +/*
>> + * This allocates QEMU-VXHS callback for each IO
>> + * and is passed to QNIO. When QNIO completes the work,
>> + * it will be passed back through the callback.
>> + */
>> +static BlockAIOCB *vxhs_aio_rw(BlockDriverState *bs, int64_t sector_num,
>> +                               QEMUIOVector *qiov, int nb_sectors,
>> +                               BlockCompletionFunc *cb, void *opaque,
>> +                               VDISKAIOCmd iodir)
>> +{
>> +    VXHSAIOCB *acb = NULL;
>> +    BDRVVXHSState *s = bs->opaque;
>> +    size_t size;
>> +    uint64_t offset;
>> +    int iio_flags = 0;
>> +    int ret = 0;
>> +    void *dev_handle = s->vdisk_hostinfo.dev_handle;
>> +
>> +    offset = sector_num * BDRV_SECTOR_SIZE;
>> +    size = nb_sectors * BDRV_SECTOR_SIZE;
>> +    acb = qemu_aio_get(&vxhs_aiocb_info, bs, cb, opaque);
>> +
>> +    /*
>> +     * Initialize VXHSAIOCB.
>> +     */
>> +    acb->err = 0;
>> +    acb->qiov = qiov;
>
> This field is unused, please remove it.
>
Yes! Thanks!

>> +static BlockDriver bdrv_vxhs = {
>> +    .format_name                  = "vxhs",
>> +    .protocol_name                = "vxhs",
>> +    .instance_size                = sizeof(BDRVVXHSState),
>> +    .bdrv_file_open               = vxhs_open,
>> +    .bdrv_parse_filename          = vxhs_parse_filename,
>> +    .bdrv_close                   = vxhs_close,
>> +    .bdrv_getlength               = vxhs_getlength,
>> +    .bdrv_aio_readv               = vxhs_aio_readv,
>> +    .bdrv_aio_writev              = vxhs_aio_writev,
>
> Missing .bdrv_aio_flush().  Does VxHS promise that every completed write
> request is persistent?
>

Yes, every acknowledged write request is persistent.

> In that case it may be better to disable the emulated disk write cache
> so the guest operating system and application know not to send flush
> commands.

We do pass "cache=none" on the qemu command line for every block
device. Are there any other code changes necessary? Any pointers will
help.

Thanks,
Ashish
