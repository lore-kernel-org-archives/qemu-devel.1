Received: from eggs.gnu.org ([2001:4830:134:3::10]:41810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gML01-00047R-FX
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 17:48:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMKzz-0005Gl-BT
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 17:48:05 -0500
References: <20180809223117.7846-1-mreitz@redhat.com>
	<20180809223117.7846-6-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <195d32a1-7476-6b42-64df-91b06260c4d8@redhat.com>
Date: Mon, 12 Nov 2018 16:47:55 -0600
MIME-Version: 1.0
In-Reply-To: <20180809223117.7846-6-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [for 3.1? Qemu-devel] [PATCH v2 05/11] block: Fix
 check_to_replace_node()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 8/9/18 5:31 PM, Max Reitz wrote:
> Currently, check_to_replace_node() only allows mirror to replace a node
> in the chain of the source node, and only if it is the first non-filter
> node below the source.  Well, technically, the idea is that you can
> exactly replace a quorum child by mirroring from quorum.
> 
> This has (probably) two reasons:
> (1) We do not want to create loops.
> (2) @replaces and @device should have exactly the same content so
>      replacing them does not cause visible data to change.
> 
> This has two issues:
> (1) It is overly restrictive.  It is completely fine for @replaces to be
>      a filter.
> (2) It is not restrictive enough.  You can create loops with this as
>      follows:
> 
> $ qemu-img create -f qcow2 /tmp/source.qcow2 64M
> $ qemu-system-x86_64 -qmp stdio
> {"execute": "qmp_capabilities"}
> {"execute": "object-add",
>   "arguments": {"qom-type": "throttle-group", "id": "tg0"}}
> {"execute": "blockdev-add",
>   "arguments": {
>       "node-name": "source",
>       "driver": "throttle",
>       "throttle-group": "tg0",
>       "file": {
>           "node-name": "filtered",
>           "driver": "qcow2",
>           "file": {
>               "driver": "file",
>               "filename": "/tmp/source.qcow2"
>           } } } }
> {"execute": "drive-mirror",
>   "arguments": {
>       "job-id": "mirror",
>       "device": "source",
>       "target": "/tmp/target.qcow2",
>       "format": "qcow2",
>       "node-name": "target",
>       "sync" :"none",
>       "replaces": "filtered"
>   } }
> {"execute": "block-job-complete", "arguments": {"device": "mirror"}}
> 
> And qemu crashes because of a stack overflow due to the loop being
> created (target's backing file is source, so when it replaces filtered,
> it points to itself through source).

Sounds like good material for inclusion in 3.1.

> 
> (blockdev-mirror can be broken similarly.)
> 
> So let us make the checks for the two conditions above explicit, which
> makes the whole function exactly as restrictive as it needs to be.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
