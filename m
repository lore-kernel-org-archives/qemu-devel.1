Received: from eggs.gnu.org ([2001:4830:134:3::10]:51419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1esshK-0005ga-Ot
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 11:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1esshJ-00072Q-P7
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 11:10:46 -0500
References: <20180305150529.11203-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0bf2b0c9-93ae-d816-b1ca-6a042340dcee@redhat.com>
Date: Mon, 5 Mar 2018 10:10:29 -0600
MIME-Version: 1.0
In-Reply-To: <20180305150529.11203-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: Fix NULL dereference on empty drive
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, qemu-devel@nongnu.org

On 03/05/2018 09:05 AM, Kevin Wolf wrote:
> blk_error_action() sends a BLOCK_IO_ERROR QMP event which includes the
> node name of its root node. If the BlockBackend represents an empty
> drive, there is no root node, so we should not try to access its node
> name. Make the field optional in the event and include it only when
> the BlockBackend isn't empty.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
> 
> Stefan, this is needed for your patch that reverts the workaround in the
> IDE flush code. Without it, make check seems to succeed, but if you look
> closer, qemu actually segfaults.
> 
> qapi/block-core.json  | 6 ++++--
>   block/block-backend.c | 5 +++--
>   2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 5c5921bfb7..00475f08d4 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3676,7 +3676,8 @@
>   #
>   # @node-name: node name. Note that errors may be reported for the root node
>   #             that is directly attached to a guest device rather than for the
> -#             node where the error occurred. (Since: 2.8)
> +#             node where the error occurred. The node name is not present if
> +#             the drive is empty. (Since: 2.8)

Making an output field change from always present to sometimes absent 
might break older clients that expected to be able to parse the field 
unconditionally.  Would it be better to keep the 'node-name' field 
mandatory in the output but make it an empty string?

Then again, since the field was not present prior to 2.8, but the event 
itself is older, we can argue that clients of older qemu have to be 
prepared for the field to not be present.  So I think I can live with 
this change as-is.

>   #
>   # @operation: I/O operation
>   #
> @@ -3707,7 +3708,8 @@
>   #
>   ##
>   { 'event': 'BLOCK_IO_ERROR',
> -  'data': { 'device': 'str', 'node-name': 'str', 'operation': 'IoOperationType',
> +  'data': { 'device': 'str', '*node-name': 'str',
> +            'operation': 'IoOperationType',
>               'action': 'BlockErrorAction', '*nospace': 'bool',
>               'reason': 'str' } }
>   

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
