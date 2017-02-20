Received: from eggs.gnu.org ([2001:4830:134:3::10]:42810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfksJ-0003G1-8s
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfksF-0000Zn-UW
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:07:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cfksF-0000ZZ-MF
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:07:15 -0500
Date: Mon, 20 Feb 2017 10:07:05 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170220100705.GD15874@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1487543454-20373-1-git-send-email-Ashish.Mittal@veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1487543454-20373-1-git-send-email-Ashish.Mittal@veritas.com>
Subject: Re: [Qemu-devel] [PATCH v9 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashish Mittal <ashmit602@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, jcody@redhat.com, famz@redhat.com, ashish.mittal@veritas.com, stefanha@gmail.com, jferlan@redhat.com, Buddhi.Madhav@veritas.com, Suraj.Singh@veritas.com, Nitin.Jerath@veritas.com, peter.maydell@linaro.org, rakesh.ranjan@veritas.com, venkatesha.mg@veritas.com, Ketan.Nilangekar@veritas.com, Abhijit.Dey@veritas.com

On Sun, Feb 19, 2017 at 02:30:53PM -0800, Ashish Mittal wrote:
> Source code for the qnio library that this code loads can be downloaded from:
> https://github.com/VeritasHyperScale/libqnio.git
> 
> Sample command line using JSON syntax:
> ./x86_64-softmmu/qemu-system-x86_64 -name instance-00000008 -S -vnc 0.0.0.0:0
> -k en-us -vga cirrus -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x5
> -msg timestamp=on
> 'json:{"driver":"vxhs","vdisk-id":"c3e9095a-a5ee-4dce-afeb-2a59fb387410",
> "server":{"host":"172.172.17.4","port":"9999"}}'
> 
> Sample command line using URI syntax:
> qemu-img convert -f raw -O raw -n
> /var/lib/nova/instances/_base/0c5eacd5ebea5ed914b6a3e7b18f1ce734c386ad
> vxhs://192.168.0.1:9999/c6718f6b-0401-441d-a8c3-1f0064d75ee0
> 
> Signed-off-by: Ashish Mittal <Ashish.Mittal@veritas.com>
> ---
> 
> v9 changelog:
> (1) Fixes for all the review comments from v8. I have left the definition
>     of VXHS_UUID_DEF unchanged pending a better suggestion.
> (2) qcow2 tests now pass on the vxhs test server.
> (3) Packaging changes for libvxhs will be checked in to the git repo soon.
> (4) I have not moved extern QemuUUID qemu_uuid to a separate header file.
> 
> v8 changelog:
> (1) Security implementation for libqnio present in branch 'securify'.
>     Please use 'securify' branch for building libqnio and testing
>     with this patch.
> (2) Renamed libqnio to libvxhs.
> (3) Pass instance ID to libvxhs for SSL authentication.
> 
> v7 changelog:
> (1) IO failover code has moved out to the libqnio library.
> (2) Fixes for issues reported by Stefan on v6.
> (3) Incorporated the QEMUBH patch provided by Stefan.
>     This is a replacement for the pipe mechanism used earlier.
> (4) Fixes to the buffer overflows reported in libqnio.
> (5) Input validations in vxhs.c to prevent any buffer overflows for 
>     arguments passed to libqnio.
> 
> v6 changelog:
> (1) Added qemu-iotests for VxHS as a new patch in the series.
> (2) Replaced release version from 2.8 to 2.9 in block-core.json.
> 
> v5 changelog:
> (1) Incorporated v4 review comments.
> 
> v4 changelog:
> (1) Incorporated v3 review comments on QAPI changes.
> (2) Added refcounting for device open/close.
>     Free library resources on last device close.
> 
> v3 changelog:
> (1) Added QAPI schema for the VxHS driver.
> 
> v2 changelog:
> (1) Changes done in response to v1 comments.
> 
>  block/Makefile.objs  |   2 +
>  block/trace-events   |  16 ++
>  block/vxhs.c         | 527 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  configure            |  40 ++++
>  qapi/block-core.json |  20 +-
>  5 files changed, 603 insertions(+), 2 deletions(-)
>  create mode 100644 block/vxhs.c
> 

> diff --git a/block/vxhs.c b/block/vxhs.c
> new file mode 100644
> index 0000000..4f0633e
> --- /dev/null
> +++ b/block/vxhs.c
> @@ -0,0 +1,527 @@
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
> +
> +#define VXHS_OPT_FILENAME           "filename"
> +#define VXHS_OPT_VDISK_ID           "vdisk-id"
> +#define VXHS_OPT_SERVER             "server"
> +#define VXHS_OPT_HOST               "host"
> +#define VXHS_OPT_PORT               "port"
> +#define VXHS_UUID_DEF "12345678-1234-1234-1234-123456789012"

Hardcoding a default UUID like this is really dubious. If the
qemu_uuid is unset, and a UUID is required, then it should
simply report an error.=

> +QemuUUID qemu_uuid __attribute__ ((weak));

This is already defined in include/sysemu/system.h

> +
> +static uint32_t vxhs_ref;
> +
> +typedef enum {
> +    VDISK_AIO_READ,
> +    VDISK_AIO_WRITE,
> +} VDISKAIOCmd;
> +
> +/*
> + * HyperScale AIO callbacks structure
> + */
> +typedef struct VXHSAIOCB {
> +    BlockAIOCB common;
> +    int err;
> +    QEMUIOVector *qiov;
> +} VXHSAIOCB;
> +
> +typedef struct VXHSvDiskHostsInfo {
> +    void *dev_handle; /* Device handle */
> +    char *host; /* Host name or IP */
> +    int port; /* Host's port number */
> +} VXHSvDiskHostsInfo;
> +
> +/*
> + * Structure per vDisk maintained for state
> + */
> +typedef struct BDRVVXHSState {
> +    VXHSvDiskHostsInfo vdisk_hostinfo; /* Per host info */
> +    char *vdisk_guid;
> +} BDRVVXHSState;
> +
> +static void vxhs_complete_aio_bh(void *opaque)
> +{
> +    VXHSAIOCB *acb = opaque;
> +    BlockCompletionFunc *cb = acb->common.cb;
> +    void *cb_opaque = acb->common.opaque;
> +    int ret = 0;
> +
> +    if (acb->err != 0) {
> +        trace_vxhs_complete_aio(acb, acb->err);
> +        ret = (-EIO);
> +    }
> +
> +    qemu_aio_unref(acb);
> +    cb(cb_opaque, ret);
> +}
> +
> +/*
> + * Called from a libqnio thread
> + */
> +static void vxhs_iio_callback(void *ctx, uint32_t opcode, uint32_t error)
> +{
> +    VXHSAIOCB *acb = NULL;
> +
> +    switch (opcode) {
> +    case IRP_READ_REQUEST:
> +    case IRP_WRITE_REQUEST:
> +
> +        /*
> +         * ctx is VXHSAIOCB*
> +         * ctx is NULL if error is QNIOERROR_CHANNEL_HUP
> +         */
> +        if (ctx) {
> +            acb = ctx;
> +        } else {
> +            trace_vxhs_iio_callback(error);
> +            goto out;
> +        }
> +
> +        if (error) {
> +            if (!acb->err) {
> +                acb->err = error;
> +            }
> +            trace_vxhs_iio_callback(error);
> +        }
> +
> +        aio_bh_schedule_oneshot(bdrv_get_aio_context(acb->common.bs),
> +                                vxhs_complete_aio_bh, acb);
> +        break;
> +
> +    default:
> +        if (error == QNIOERROR_HUP) {
> +            /*
> +             * Channel failed, spontaneous notification,
> +             * not in response to I/O
> +             */
> +            trace_vxhs_iio_callback_chnfail(error, errno);
> +        } else {
> +            trace_vxhs_iio_callback_unknwn(opcode, error);
> +        }
> +        break;
> +    }
> +out:
> +    return;
> +}
> +
> +static QemuOptsList runtime_opts = {
> +    .name = "vxhs",
> +    .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
> +    .desc = {
> +        {
> +            .name = VXHS_OPT_FILENAME,
> +            .type = QEMU_OPT_STRING,
> +            .help = "URI to the Veritas HyperScale image",
> +        },
> +        {
> +            .name = VXHS_OPT_VDISK_ID,
> +            .type = QEMU_OPT_STRING,
> +            .help = "UUID of the VxHS vdisk",
> +        },
> +        { /* end of list */ }
> +    },
> +};
> +
> +static QemuOptsList runtime_tcp_opts = {
> +    .name = "vxhs_tcp",
> +    .head = QTAILQ_HEAD_INITIALIZER(runtime_tcp_opts.head),
> +    .desc = {
> +        {
> +            .name = VXHS_OPT_HOST,
> +            .type = QEMU_OPT_STRING,
> +            .help = "host address (ipv4 addresses)",
> +        },
> +        {
> +            .name = VXHS_OPT_PORT,
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "port number on which VxHSD is listening (default 9999)",
> +            .def_value_str = "9999"
> +        },
> +        { /* end of list */ }
> +    },
> +};
> +
> +/*
> + * Parse the incoming URI and populate *options with the host information.
> + * URI syntax has the limitation of supporting only one host info.
> + * To pass multiple host information, use the JSON syntax.
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
> +
> +    if (strstr(uri->path, "vxhs") == NULL) {
> +        qdict_put(options, "vdisk-id", qstring_from_str(uri->path));
> +    }
> +
> +    trace_vxhs_parse_uri_hostinfo(uri->server, uri->port);
> +    uri_free(uri);
> +
> +    return ret;
> +}
> +
> +static void vxhs_parse_filename(const char *filename, QDict *options,
> +                                Error **errp)
> +{
> +    if (qdict_haskey(options, "vdisk-id") || qdict_haskey(options, "server")) {
> +        error_setg(errp, "vdisk-id/server and a file name may not be specified "
> +                         "at the same time");
> +        return;
> +    }
> +
> +    if (strstr(filename, "://")) {
> +        int ret = vxhs_parse_uri(filename, options);
> +        if (ret < 0) {
> +            error_setg(errp, "Invalid URI. URI should be of the form "
> +                       "  vxhs://<host_ip>:<port>/<vdisk-id>");
> +        }
> +    }
> +}
> +
> +static int vxhs_init_and_ref(void)
> +{
> +    if (vxhs_ref == 0) {
> +        char out[UUID_FMT_LEN + 1];
> +        if (qemu_uuid_is_null(&qemu_uuid)) {

This is the wrong check - QEMU provides a 'qemu_uuid_set' boolean
to determine if 'qemu_uuid' is set or not. If it is not set, then
the code should return an error, not use a hardcoded uuid.

> +            if (iio_init(QNIO_VERSION, vxhs_iio_callback, VXHS_UUID_DEF)) {
> +                return -ENODEV;
> +            }
> +        } else {
> +            qemu_uuid_unparse(&qemu_uuid, out);
> +            if (iio_init(QNIO_VERSION, vxhs_iio_callback, out)) {
> +                return -ENODEV;
> +            }
> +        }
> +    }
> +    vxhs_ref++;
> +    return 0;
> +}


>  ##
> +# @BlockdevOptionsVxHS:
> +#
> +# Driver specific block device options for VxHS
> +#
> +# @vdisk-id:    UUID of VxHS volume
> +# @server:      vxhs server IP, port
> +#
> +# Since: 2.9
> +##
> +{ 'struct': 'BlockdevOptionsVxHS',
> +  'data': { 'vdisk-id': 'str',
> +            'server': 'InetSocketAddress' } }

This is still missing a flag to indicate whether to run in plain text
or TLS modes. Also missing a way to configure the certificates to be
used for the connection when in TLS mode.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
