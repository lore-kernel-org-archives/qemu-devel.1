Received: from eggs.gnu.org ([2001:4830:134:3::10]:47963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cJUXw-0006ru-Kp
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 19:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cJUXs-0007Q2-Ku
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 19:14:16 -0500
Received: from mail.kernel.org ([198.145.29.136]:54402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cJUXs-0007Pg-A0
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 19:14:12 -0500
Date: Tue, 20 Dec 2016 16:14:07 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1481856403-23599-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.10.1612201612170.13831@sstabellini-ThinkPad-X260>
References: <1481856403-23599-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1481856403-23599-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH for-2.9 V4 1/2] Add a new qmp command to
 start/stop replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Cc: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Changlong Xie <xiecl.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, Wen Congyang <wencongyang@gmail.com>, Bian Naimeng <biannm@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

On Fri, 16 Dec 2016, Zhang Chen wrote:
> We can call this qmp command to start/stop replication outside of qemu.
> Like Xen colo need this function.
> 
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
> ---
>  docs/qmp-commands.txt | 18 ++++++++++++++++++
>  migration/colo.c      | 23 +++++++++++++++++++++++
>  qapi-schema.json      | 19 +++++++++++++++++++
>  3 files changed, 60 insertions(+)
> 
> diff --git a/docs/qmp-commands.txt b/docs/qmp-commands.txt
> index abf210a..a8e9eb6 100644
> --- a/docs/qmp-commands.txt
> +++ b/docs/qmp-commands.txt
> @@ -432,6 +432,24 @@ Example:
>       "arguments": { "enable": true } }
>  <- { "return": {} }
>  
> +xen-set-replication
> +-------------------
> +
> +Enable or disable replication.
> +
> +Arguments:
> +
> +- "enable": Enable it or disable it.
> +- "primary": True for primary or false for secondary.
> +- "failover": Enable failover when stopping replication, but cannot be
> +              specified if 'enable' is true (optional, default false).
> +
> +Example:
> +
> +-> { "execute": "xen-set-replicate",

Shouldn't this be "xen-set-replication" ?


> +     "arguments": {"enable": true, "primary": false} }
> +<- { "return": {} }
> +
>  migrate
>  -------
>  
> diff --git a/migration/colo.c b/migration/colo.c
> index 93c85c5..6fc2ade 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -19,6 +19,8 @@
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "migration/failover.h"
> +#include "replication.h"
> +#include "qmp-commands.h"
>  
>  #define COLO_BUFFER_BASE_SIZE (4 * 1024 * 1024)
>  
> @@ -104,6 +106,27 @@ void colo_do_failover(MigrationState *s)
>      }
>  }
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
>  static void colo_send_message(QEMUFile *f, COLOMessage msg,
>                                Error **errp)
>  {
> diff --git a/qapi-schema.json b/qapi-schema.json
> index f3e9bfc..78802f4 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -4676,6 +4676,25 @@
>  { 'command': 'xen-load-devices-state', 'data': {'filename': 'str'} }
>  
>  ##
> +# @xen-set-replication
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
> +# Since: 2.9
> +##
> +{ 'command': 'xen-set-replication',
> +  'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' } }
> +
> +##
>  # @GICCapability:
>  #
>  # The struct describes capability for a specific GIC (Generic
> -- 
> 2.7.4
> 
> 
> 
> 
