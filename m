Received: from eggs.gnu.org ([2001:4830:134:3::10]:56197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgA5B-0007kO-CM
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:02:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgA56-0007HP-JD
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:02:17 -0500
Received: from [45.249.212.187] (port=2536 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgA55-0007FJ-SV
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:02:12 -0500
References: <1486531462-13882-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1486531462-13882-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58AC3A15.7090800@huawei.com>
Date: Tue, 21 Feb 2017 21:01:09 +0800
MIME-Version: 1.0
In-Reply-To: <1486531462-13882-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V7 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
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
> We can call this qmp command to do checkpoint outside of qemu.
> Xen colo will need this function.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
> ---
>   migration/colo.c | 17 ++++++++++++++++
>   qapi-schema.json | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 77 insertions(+)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index 6fc2ade..2f98a33 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -127,6 +127,23 @@ void qmp_xen_set_replication(bool enable, bool primary,
>       }
>   }
>
> +ReplicationResult *qmp_query_xen_replication_status(Error **errp)
> +{
> +    Error *err = NULL;
> +    ReplicationResult *result = g_new0(ReplicationResult, 1);

Indent, line break.

> +    replication_get_error_all(&err);
> +    result->status = err ?
> +                     REPLICATION_STATUS_ERROR :
> +                     REPLICATION_STATUS_NORMAL;
> +    error_free(err);
> +    return result;
> +}
> +
> +void qmp_xen_do_checkpoint(Error **errp)
> +{
> +    replication_do_checkpoint_all(errp);
> +}
> +
>   static void colo_send_message(QEMUFile *f, COLOMessage msg,
>                                 Error **errp)
>   {
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 9445b93..719744a 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -5931,6 +5931,66 @@
>     'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' } }
>
>   ##
> +# @ReplicationStatus:
> +#
> +# Describe the status of replication.
> +#
> +# @error: Replication has an error.
> +#
> +# @normal: Replication is running normally.
> +#
> +# Since: 2.9
> +##
> +{ 'enum': 'ReplicationStatus',
> +  'data': [ 'error', 'normal' ] }
> +
> +##
> +# @ReplicationResult:
> +#
> +# The result format for 'query-xen-replication-status'.
> +#
> +# @status: enum of @ReplicationStatus, which shows current
> +#          replication error status
> +#
> +# Since: 2.9
> +##
> +{ 'struct': 'ReplicationResult',
> +  'data': { 'status': 'ReplicationStatus'} }
                                            ^ Space

> +
> +##
> +# @query-xen-replication-status:
> +#
> +# Query replication status while the vm is running.
> +#
> +# Returns: A @ReplicationResult objects showing the status.
> +#
> +# Example:
> +#
> +# -> { "execute": "query-xen-replication-status" }
> +# <- { "return": { "status": "normal" } }
> +#
> +# Since: 2.9
> +##
> +{ 'command': 'query-xen-replication-status',
> +  'returns': 'ReplicationResult' }
> +
> +##
> +# @xen-do-checkpoint:
> +#

Maybe use the name 'xen-checkpoint-notify' or 'xen-colo-checkpoint-notify' ?

> +# Xen uses this command to notify replication to trigger a checkpoint.
> +#
> +# Returns: nothing.
> +#
> +# Example:
> +#
> +# -> { "execute": "xen-do-checkpoint" }
> +# <- { "return": {} }
> +#
> +# Since: 2.9
> +##
> +{ 'command': 'xen-do-checkpoint' }
> +
> +##
>   # @GICCapability:
>   #
>   # The struct describes capability for a specific GIC (Generic
>
