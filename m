Received: from eggs.gnu.org ([2001:4830:134:3::10]:56031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gB0bB-0003wN-Ms
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gB0bA-0000jN-Ko
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:47:37 -0400
References: <20181012115532.12645-1-kwolf@redhat.com>
	<20181012115532.12645-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <12e95cce-ab82-08e3-b0ae-2307fe94a392@redhat.com>
Date: Fri, 12 Oct 2018 11:47:18 -0500
MIME-Version: 1.0
In-Reply-To: <20181012115532.12645-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/8] block: Add auto-read-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

On 10/12/18 6:55 AM, Kevin Wolf wrote:
> If a management application builds the block graph node by node, the
> protocol layer doesn't inherit its read-only option from the format
> layer any more, so it must be set explicitly.
> 

> The documentation for this option is consciously phrased in a way that
> allows QEMU to switch to a better model eventually: Instead of trying
> when the image is first opened, making the read-only flag dynamic and
> changing it automatically whenever the first BLK_PERM_WRITE user is
> attached or the last one is detached would be much more useful
> behaviour.
> 
> Unfortunately, this more useful behaviour is also a lot harder to
> implement, and libvirt needs a solution now before it can switch to
> -blockdev, so let's start with this easier approach for now.

I agree both with the approach of getting the simpler implementation in 
now (always writable, even when we don't need to write) as well as 
wording the documentation to permit a future stricter approach (only 
writable at the points where we need to write).

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/block-core.json  |  6 ++++++
>   include/block/block.h |  2 ++
>   block.c               | 21 ++++++++++++++++++++-
>   block/vvfat.c         |  1 +
>   4 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index cfb37f8c1d..3a899298de 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3651,6 +3651,11 @@
>   #                 either generally or in certain configurations. In this case,
>   #                 the default value does not work and the option must be
>   #                 specified explicitly.
> +# @auto-read-only: if true, QEMU may ignore the @read-only option and
> +#                  automatically decide whether to open the image read-only or
> +#                  read-write (and switch between the modes later), e.g.
> +#                  depending on whether the image file is writable or whether a
> +#                  writing user is attached to the node (default: false).

Bike-shedding: Do we really want to ignore @read-only? Here's the table 
of 9 combinations ('t'rue, 'f'alse, 'o'mitted), with '*' on the rows 
that must be preserved for back-compat:

RO   Auto   effect
o    o      *open for write, fail if not possible
f    o      *open for write, fail if not possible
t    o      *open for read, no conversion to write
o    f      open for write, fail if not possible
f    f      open for write, fail if not possible
t    f      open for read, no conversion to write
o    t      attempt write but graceful fall back to read
f    t      attempt write but graceful fall back to read
t    t      ignore RO flag, attempt write anyway

That last row is weird, why not make it an explicit error instead of 
ignoring the implied difference in semantics between the two?

Or, another idea: is it worth trying to support a single tri-state 
member (via an alternative between bool and enum, since the existing 
code uses a JSON bool):

"read-only": false (open for write, fail if not possible)
"read-only": true (open read-only, no later switching)
"read-only": "auto" (switch as needed; or for initial implementation 
attempt for write with graceful fallback to read)
omitting read-only: same as "read-only":false for back-compat


> @@ -1328,6 +1338,11 @@ QemuOptsList bdrv_runtime_opts = {
>               .type = QEMU_OPT_BOOL,
>               .help = "Node is opened in read-only mode",
>           },
> +        {
> +            .name = BDRV_OPT_AUTO_READ_ONLY,
> +            .type = QEMU_OPT_BOOL,
> +            .help = "Node can become read-only if opening read-write fails",
> +        },

If we keep your current approach, is it worth mentioning that 
auto-read-only true overrides read-only true?

The code looks okay, but I'd like discussion on the bikeshed points 
before giving R-b.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
