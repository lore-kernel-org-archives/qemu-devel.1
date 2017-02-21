Received: from eggs.gnu.org ([2001:4830:134:3::10]:53009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cg9xM-0000Cq-8A
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:54:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cg9xJ-0004fC-4X
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:54:12 -0500
Received: from [45.249.212.188] (port=2932 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cg9xI-0004eG-H0
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:54:09 -0500
References: <1486531462-13882-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1486531462-13882-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58AC384D.4090408@huawei.com>
Date: Tue, 21 Feb 2017 20:53:33 +0800
MIME-Version: 1.0
In-Reply-To: <1486531462-13882-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V7 1/2] Add a new qmp command to start/stop
 replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>
Cc: xuquan8@huawei.com, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, "eddie . dong" <eddie.dong@intel.com>, Wen Congyang <wencongyang@gmail.com>, bian naimeng <biannm@cn.fujitsu.com>

On 2017/2/8 13:24, Zhang Chen wrote:
> We can call this qmp command to start/stop replication outside of qemu.
> Like Xen colo need this function.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
>

Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

> ---
>   migration/colo.c | 23 +++++++++++++++++++++++
>   qapi-schema.json | 25 +++++++++++++++++++++++++
>   2 files changed, 48 insertions(+)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index 93c85c5..6fc2ade 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -19,6 +19,8 @@
>   #include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "migration/failover.h"
> +#include "replication.h"
> +#include "qmp-commands.h"
>
>   #define COLO_BUFFER_BASE_SIZE (4 * 1024 * 1024)
>
> @@ -104,6 +106,27 @@ void colo_do_failover(MigrationState *s)
>       }
>   }
>
> +void qmp_xen_set_replication(bool enable, bool primary,
> +                             bool has_failover, bool failover,
> +                             Error **errp)
> +{
> +    ReplicationMode mode = primary ?
> +                           REPLICATION_MODE_PRIMARY :
> +                           REPLICATION_MODE_SECONDARY;
> +
> +    if (has_failover && enable) {
> +        error_setg(errp, "Parameter 'failover' is only for"
> +                   " stopping replication");
> +        return;
> +    }
> +
> +    if (enable) {
> +        replication_start_all(mode, errp);
> +    } else {
> +        replication_stop_all(failover, failover ? NULL : errp);
> +    }
> +}
> +
>   static void colo_send_message(QEMUFile *f, COLOMessage msg,
>                                 Error **errp)
>   {
> diff --git a/qapi-schema.json b/qapi-schema.json
> index cbdffdd..9445b93 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -5906,6 +5906,31 @@
>   { 'command': 'xen-load-devices-state', 'data': {'filename': 'str'} }
>
>   ##
> +# @xen-set-replication:
> +#
> +# Enable or disable replication.
> +#
> +# @enable: true to enable, false to disable.
> +#
> +# @primary: true for primary or false for secondary.
> +#
> +# @failover: #optional true to do failover, false to stop. but cannot be
> +#            specified if 'enable' is true. default value is false.
> +#
> +# Returns: nothing.
> +#
> +# Example:
> +#
> +# -> { "execute": "xen-set-replication",
> +#      "arguments": {"enable": true, "primary": false} }
> +# <- { "return": {} }
> +#
> +# Since: 2.9
> +##
> +{ 'command': 'xen-set-replication',
> +  'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' } }
> +
> +##
>   # @GICCapability:
>   #
>   # The struct describes capability for a specific GIC (Generic
>
