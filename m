Received: from eggs.gnu.org ([2001:4830:134:3::10]:48716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cmox9-0008EW-7g
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 16:53:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cmox4-0002SH-Cr
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 16:53:31 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:33651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cmox4-0002Rj-6Z
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 16:53:26 -0500
Received: by mail-pf0-x241.google.com with SMTP id v190so14762889pfb.0
	for <qemu-devel@nongnu.org>; Sat, 11 Mar 2017 13:53:26 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170311183016.GA20514@ls3530.fritz.box>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ccf72219-1498-4434-8dd4-625c49afee7c@twiddle.net>
Date: Sun, 12 Mar 2017 07:53:18 +1000
MIME-Version: 1.0
In-Reply-To: <20170311183016.GA20514@ls3530.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Add TARGET_MAP_STACK and
 TARGET_MAP_HUGETLB for all remaining architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

On 03/12/2017 04:30 AM, Helge Deller wrote:
> Add the missing defines and for TARGET_MAP_STACK and TARGET_MAP_HUGETLB
> for alpha, mips, ppc and x86, and fix the mmap_flags translation table
> to translate those flags between host and target architecture.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index cec8428..03ed370 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -5875,6 +5875,8 @@ static bitmask_transtbl mmap_flags_tbl[] = {
>  	{ TARGET_MAP_LOCKED, TARGET_MAP_LOCKED, MAP_LOCKED, MAP_LOCKED },
>          { TARGET_MAP_NORESERVE, TARGET_MAP_NORESERVE, MAP_NORESERVE,
>            MAP_NORESERVE },
> +	{ TARGET_MAP_STACK, TARGET_MAP_STACK, MAP_STACK, MAP_STACK },
> +	{ TARGET_MAP_HUGETLB, TARGET_MAP_HUGETLB, MAP_HUGETLB, MAP_HUGETLB },

I don't see any point in this.  First, MAP_STACK is ignored by the kernel, and 
has been for some time.  Second, the size of huge pages varies widely between 
different targets, and we're not really able to map the sizes between guest and 
host.

I suppose we could pass it through and get lucky when the sizes do match.  But 
if they don't, is it better to succeed with small tlb entries or fail with -EINVAL?


r~
