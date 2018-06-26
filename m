Received: from eggs.gnu.org ([2001:4830:134:3::10]:45407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fXqsH-0002Lj-AK
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fXqsA-0001uX-WC
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:31:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44620 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1fXqsA-0001tm-QF
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:31:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4AEA181A4EAD
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 16:31:18 +0000 (UTC)
References: <20180626154028.11133-1-pbonzini@redhat.com>
	<20180626154028.11133-5-pbonzini@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <6f643a0b-71f4-4034-d8ec-c5a0a2f84ba6@redhat.com>
Date: Tue, 26 Jun 2018 18:31:16 +0200
MIME-Version: 1.0
In-Reply-To: <20180626154028.11133-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] pr-manager: add query-pr-managers QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 06/26/2018 05:40 PM, Paolo Bonzini wrote:
> This command lets you query the connection status of each pr-manager-helper
> object.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/scsi/pr-manager.h |  2 ++
>  qapi/block.json           | 27 +++++++++++++++++++++++
>  scsi/pr-manager-helper.c  | 13 +++++++++++
>  scsi/pr-manager.c         | 45 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 87 insertions(+)
> 
> diff --git a/include/scsi/pr-manager.h b/include/scsi/pr-manager.h
> index 5d2f13a5e4..adadca7954 100644
> --- a/include/scsi/pr-manager.h
> +++ b/include/scsi/pr-manager.h
> @@ -33,8 +33,10 @@ typedef struct PRManagerClass {
>  
>      /* <public> */
>      int (*run)(PRManager *pr_mgr, int fd, struct sg_io_hdr *hdr);
> +    bool (*is_connected)(PRManager *pr_mgr);
>  } PRManagerClass;
>  
> +bool pr_manager_is_connected(PRManager *pr_mgr);
>  BlockAIOCB *pr_manager_execute(PRManager *pr_mgr,
>                                 AioContext *ctx, int fd,
>                                 struct sg_io_hdr *hdr,
> diff --git a/qapi/block.json b/qapi/block.json
> index c694524002..dc3323c954 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -77,6 +77,33 @@
>  { 'struct': 'BlockdevSnapshotInternal',
>    'data': { 'device': 'str', 'name': 'str' } }
>  
> +##
> +# @PRManagerInfo:
> +#
> +# Information about a persistent reservation manager
> +#
> +# @id: the identifier of the persistent reservation manager
> +#
> +# @is-connected: whether the persistent reservation manager is connected to
> +#                the underlying storage or helper
> +#
> +# Since: 3.0
> +##
> +{ 'struct': 'PRManagerInfo',
> +  'data': {'id': 'str', 'is-connected': 'bool'} }
> +
> +##
> +# @query-pr-managers:
> +#
> +# Returns a list of information about each persistent reservation manager.
> +#
> +# Returns: a list of @PRManagerInfo for each persistent reservation manager
> +#
> +# Since: 3.0
> +##
> +{ 'command': 'query-pr-managers', 'returns': ['PRManagerInfo'] }
> +
> +
>  ##
>  # @blockdev-snapshot-internal-sync:
>  #
> diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
> index 0c0fe389b7..b11481be9e 100644
> --- a/scsi/pr-manager-helper.c
> +++ b/scsi/pr-manager-helper.c
> @@ -235,6 +235,18 @@ out:
>      return ret;
>  }
>  
> +static bool pr_manager_helper_is_connected(PRManager *p)
> +{
> +    PRManagerHelper *pr_mgr = PR_MANAGER_HELPER(p);
> +    bool result;
> +
> +    qemu_mutex_lock(&pr_mgr->lock);
> +    result = (pr_mgr->ioc != NULL);

I worry it is not that easy. pr_mgr->ioc is unset only when there's
PR_IN/PR_OUT command coming from the guest (in pr_manager_helper_run ->
pr_manager_helper_write). In fact, after 5/5 that is also the time when
the event is delivered. But that might be too late for mgmt app to
restart the helper process (although pr_manager_helper_run() tries to
reconnect for 5 seconds before giving up).

The patch is good code-wise though.

Michal
