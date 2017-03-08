Received: from eggs.gnu.org ([2001:4830:134:3::10]:43951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clZbW-0002mW-Pi
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:18:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clZbR-00020l-QV
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:18:02 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clZbR-00020d-MX
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:17:57 -0500
Received: by mail-qk0-x244.google.com with SMTP id v125so9783752qkh.1
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 03:17:57 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1488985872-22447-1-git-send-email-yang.zhong@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <eb781f48-a5cf-4790-f0e8-4ef083c1e1a4@amsat.org>
Date: Wed, 8 Mar 2017 08:17:53 -0300
MIME-Version: 1.0
In-Reply-To: <1488985872-22447-1-git-send-email-yang.zhong@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] memory: reduce heap Rss size around 3M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anthony.xu@intel.com

On 03/08/2017 12:11 PM, Yang Zhong wrote:
> Since cpu-memory and memory have same address space,one malloced
> memory is enough. This patch will skip memory malloc for memory
> address space,which will reduce around 3M physical memory in heap.
>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  memory.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/memory.c b/memory.c
> index 284894b..799ca4c 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2422,8 +2422,10 @@ AddressSpace *address_space_init_shareable(MemoryRegion *root, const char *name)
>      AddressSpace *as;
>
>      QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
> -        if (root == as->root && as->malloced) {
> -            as->ref_count++;
> +        if (root == as->root) {
> +            if (as->malloced) {
> +                as->ref_count++;
> +            }
>              return as;
>          }
>      }
>
