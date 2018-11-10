Received: from eggs.gnu.org ([2001:4830:134:3::10]:51318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gLXxE-0005bO-PA
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 13:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gLXxA-0004iz-Ch
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 13:25:54 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gLXxA-0004hc-2K
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 13:25:52 -0500
Received: by mail-wr1-x444.google.com with SMTP id y3-v6so5118279wrh.10
	for <qemu-devel@nongnu.org>; Sat, 10 Nov 2018 10:25:51 -0800 (PST)
References: <20181108160818.5485-1-yuval.shaia@oracle.com>
	<20181108160818.5485-11-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <6dbdd27a-1686-c7c0-068a-a1c71adc7c79@gmail.com>
Date: Sat, 10 Nov 2018 20:25:46 +0200
MIME-Version: 1.0
In-Reply-To: <20181108160818.5485-11-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 10/22] json: Define new QMP message for
 pvrdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com



On 11/8/18 6:08 PM, Yuval Shaia wrote:
> pvrdma requires that the same GID attached to it will be attached to the
> backend device in the host.
>
> A new QMP messages is defined so pvrdma device can broadcast any change
> made to its GID table. This event is captured by libvirt which in turn
> will update the GID table in the backend device.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   MAINTAINERS           |  1 +
>   Makefile              |  3 ++-
>   Makefile.objs         |  4 ++++
>   qapi/qapi-schema.json |  1 +
>   qapi/rdma.json        | 38 ++++++++++++++++++++++++++++++++++++++
>   5 files changed, 46 insertions(+), 1 deletion(-)
>   create mode 100644 qapi/rdma.json
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e087d58ac6..a149f68a8f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2232,6 +2232,7 @@ F: hw/rdma/*
>   F: hw/rdma/vmw/*
>   F: docs/pvrdma.txt
>   F: contrib/rdmacm-mux/*
> +F: qapi/rdma.json
>   
>   Build and test automation
>   -------------------------
> diff --git a/Makefile b/Makefile
> index 94072776ff..db4ce60ee5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -599,7 +599,8 @@ qapi-modules = $(SRC_PATH)/qapi/qapi-schema.json $(SRC_PATH)/qapi/common.json \
>                  $(SRC_PATH)/qapi/tpm.json \
>                  $(SRC_PATH)/qapi/trace.json \
>                  $(SRC_PATH)/qapi/transaction.json \
> -               $(SRC_PATH)/qapi/ui.json
> +               $(SRC_PATH)/qapi/ui.json \
> +               $(SRC_PATH)/qapi/rdma.json
>   
>   qapi/qapi-builtin-types.c qapi/qapi-builtin-types.h \
>   qapi/qapi-types.c qapi/qapi-types.h \
> diff --git a/Makefile.objs b/Makefile.objs
> index cc7df3ad80..76d8028f2f 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -21,6 +21,7 @@ util-obj-y += qapi/qapi-types-tpm.o
>   util-obj-y += qapi/qapi-types-trace.o
>   util-obj-y += qapi/qapi-types-transaction.o
>   util-obj-y += qapi/qapi-types-ui.o
> +util-obj-y += qapi/qapi-types-rdma.o
>   util-obj-y += qapi/qapi-builtin-visit.o
>   util-obj-y += qapi/qapi-visit.o
>   util-obj-y += qapi/qapi-visit-block-core.o
> @@ -40,6 +41,7 @@ util-obj-y += qapi/qapi-visit-tpm.o
>   util-obj-y += qapi/qapi-visit-trace.o
>   util-obj-y += qapi/qapi-visit-transaction.o
>   util-obj-y += qapi/qapi-visit-ui.o
> +util-obj-y += qapi/qapi-visit-rdma.o
>   util-obj-y += qapi/qapi-events.o
>   util-obj-y += qapi/qapi-events-block-core.o
>   util-obj-y += qapi/qapi-events-block.o
> @@ -58,6 +60,7 @@ util-obj-y += qapi/qapi-events-tpm.o
>   util-obj-y += qapi/qapi-events-trace.o
>   util-obj-y += qapi/qapi-events-transaction.o
>   util-obj-y += qapi/qapi-events-ui.o
> +util-obj-y += qapi/qapi-events-rdma.o
>   util-obj-y += qapi/qapi-introspect.o
>   
>   chardev-obj-y = chardev/
> @@ -155,6 +158,7 @@ common-obj-y += qapi/qapi-commands-tpm.o
>   common-obj-y += qapi/qapi-commands-trace.o
>   common-obj-y += qapi/qapi-commands-transaction.o
>   common-obj-y += qapi/qapi-commands-ui.o
> +common-obj-y += qapi/qapi-commands-rdma.o
>   common-obj-y += qapi/qapi-introspect.o
>   common-obj-y += qmp.o hmp.o
>   endif
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 65b6dc2f6f..a650d80f83 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -94,3 +94,4 @@
>   { 'include': 'trace.json' }
>   { 'include': 'introspect.json' }
>   { 'include': 'misc.json' }
> +{ 'include': 'rdma.json' }
> diff --git a/qapi/rdma.json b/qapi/rdma.json
> new file mode 100644
> index 0000000000..804c68ab36
> --- /dev/null
> +++ b/qapi/rdma.json
> @@ -0,0 +1,38 @@
> +# -*- Mode: Python -*-
> +#
> +
> +##
> +# = RDMA device
> +##
> +
> +##
> +# @RDMA_GID_STATUS_CHANGED:
> +#
> +# Emitted when guest driver adds/deletes GID to/from device
> +#
> +# @netdev: RoCE Network Device name - char *
> +#
> +# @gid-status: Add or delete indication - bool
> +#
> +# @subnet-prefix: Subnet Prefix - uint64
> +#
> +# @interface-id : Interface ID - uint64
> +#
> +# Since: 3.2
> +#
> +# Example:
> +#
> +# <- {"timestamp": {"seconds": 1541579657, "microseconds": 986760},
> +#     "event": "RDMA_GID_STATUS_CHANGED",
> +#     "data":
> +#         {"netdev": "bridge0",
> +#         "interface-id": 15880512517475447892,
> +#         "gid-status": true,
> +#         "subnet-prefix": 33022}}
> +#
> +##
> +{ 'event': 'RDMA_GID_STATUS_CHANGED',
> +  'data': { 'netdev'        : 'str',
> +            'gid-status'    : 'bool',

'git-status' naming as of indication if we add or remove a gid
is a little odd, but I can't come up with something better.

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel

> +            'subnet-prefix' : 'uint64',
> +            'interface-id'  : 'uint64' } }
