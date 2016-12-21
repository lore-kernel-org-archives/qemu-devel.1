Received: from eggs.gnu.org ([2001:4830:134:3::10]:48605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cJUcJ-0000NA-Vp
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 19:18:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cJUcG-0000I1-Py
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 19:18:47 -0500
Received: from mail.kernel.org ([198.145.29.136]:54636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cJUcG-0000Hn-EP
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 19:18:44 -0500
Date: Tue, 20 Dec 2016 16:18:39 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1481856403-23599-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.10.1612201616530.13831@sstabellini-ThinkPad-X260>
References: <1481856403-23599-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1481856403-23599-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH for-2.9 V4 2/2] Add a new qmp command to do
 checkpoint, get replication error
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
> We can call this qmp command to do checkpoint outside of qemu.
> Like Xen colo need this function.
> 
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
> ---
>  docs/qmp-commands.txt | 24 ++++++++++++++++++++++++
>  migration/colo.c      | 10 ++++++++++
>  qapi-schema.json      | 22 ++++++++++++++++++++++
>  3 files changed, 56 insertions(+)
> 
> diff --git a/docs/qmp-commands.txt b/docs/qmp-commands.txt
> index a8e9eb6..093b7eb 100644
> --- a/docs/qmp-commands.txt
> +++ b/docs/qmp-commands.txt
> @@ -450,6 +450,30 @@ Example:
>       "arguments": {"enable": true, "primary": false} }
>  <- { "return": {} }
>  
> +xen-get-replication-error
> +-------------------------
> +
> +Get replication error that occurs when vm is running.
> +
> +Arguments: None.
> +
> +Example:
> +
> +-> { "execute": "xen-get-replication-error" }
> +<- { "return": {} }
> +
> +xen-do-checkpoint
> +-----------------
> +
> +Do checkpoint.
> +
> +Arguments: None.
> +
> +Example:
> +
> +-> { "execute": "xen-do-checkpoint" }
> +<- { "return": {} }

I don't know much about QMP, but shouldn't these two functions return a
success or failure at least? Especially xen-get-replication-error? How
does xen-get-replication-error actually return the error?

Please also write this info on the description of the commands
(docs/qmp-commands.txt, qapi-schema.json).


>  migrate
>  -------
>  
> diff --git a/migration/colo.c b/migration/colo.c
> index 6fc2ade..1e962f6 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -127,6 +127,16 @@ void qmp_xen_set_replication(bool enable, bool primary,
>      }
>  }
>  
> +void qmp_xen_get_replication_error(Error **errp)
> +    {
> +        replication_get_error_all(errp);
> +    }
> +
> +void qmp_xen_do_checkpoint(Error **errp)
> +    {
> +        replication_do_checkpoint_all(errp);
> +    }
> +
>  static void colo_send_message(QEMUFile *f, COLOMessage msg,
>                                Error **errp)
>  {
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 78802f4..79fe4dd 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -4695,6 +4695,28 @@
>    'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' } }
>  
>  ##
> +# @xen-get-replication-error
> +#
> +# Get replication error that occurs when the vm is running.
> +#
> +# Returns: nothing.
> +#
> +# Since: 2.9
> +##
> +{ 'command': 'xen-get-replication-error' }
> +
> +##
> +# @xen-do-checkpoint
> +#
> +# Do checkpoint.
> +#
> +# Returns: nothing.
> +#
> +# Since: 2.9
> +##
> +{ 'command': 'xen-do-checkpoint' }
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
