Received: from eggs.gnu.org ([2001:4830:134:3::10]:38072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fdJqU-0006li-1m
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 14:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fdJqQ-0002hS-UM
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 14:28:10 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:50148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fdJqQ-0002h7-K7
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 14:28:06 -0400
References: <20180711164025.10924-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <515ab6e6-14b3-2687-18b9-582d63b82903@vivier.eu>
Date: Wed, 11 Jul 2018 20:27:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180711164025.10924-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: fix mmap_find_vma_reserved()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Riku Voipio <riku.voipio@iki.fi>

Le 11/07/2018 à 18:40, Laurent Vivier a écrit :
> The value given by mmap_find_vma_reserved() is used with mmap(),
> so it is needed to be aligned with the host page size.
> 
> Since commit 18e80c55bb, reserved_va is only aligned to TARGET_PAGE_SIZE,
> and it works well if this size is greater or equal to the host page size.
> 
> But ppc64 hosts have 64kB page size and when we start a 4kiB page size
> guest (like i386), it fails when it tries to mmap the stack:
> 
>     mmap stack: Invalid argument
> 
> Fixes: 18e80c55bb (linux-user: Tidy and enforce reserved_va initialization)
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Richard,

I think this fix could be merged into your "linux-user: Fix shmat
emulation by honoring host SHMLBA" patch, by adding something like this
instead:

--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -262,6 +262,8 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong
size, abi_ulong align)
     abi_ulong addr;
     int wrapped, repeat;

+    align = MAX(align, qemu_host_page_size);
+
     /* If 'start' == 0, then a default start address is used. */
     if (start == 0) {
         start = mmap_next_start;

Thanks,
Laurent
