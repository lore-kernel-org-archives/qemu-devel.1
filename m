Received: from eggs.gnu.org ([2001:4830:134:3::10]:57314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbuwB-0002eA-Gy
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 15:03:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbuw7-0005mK-18
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 15:03:27 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cbuw6-0005m3-Rj
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 15:03:22 -0500
Received: by mail-pg0-x241.google.com with SMTP id v184so1111050pgv.1
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 12:03:22 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1486668676-24680-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9fd4e2f7-c2e3-2354-028e-f7ee6c2801e3@twiddle.net>
Date: Thu, 9 Feb 2017 12:03:11 -0800
MIME-Version: 1.0
In-Reply-To: <1486668676-24680-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cputlb: Don't assume
 do_unassigned_access() never returns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 02/09/2017 11:31 AM, Peter Maydell wrote:
> In get_page_addr_code(), if the guest PC doesn't correspond to RAM
> then we currently run the CPU's do_unassigned_access() hook if it has
> one, and otherwise we give up and exit QEMU with a more-or-less
> useful message.  This code assumes that the do_unassigned_access hook
> will never return, because if it does then we'll plough on attempting
> to use a non-RAM TLB entry to get a RAM address and will abort() in
> qemu_ram_addr_from_host_nofail().  Unfortunately some CPU
> implementations of this hook do return: Microblaze, SPARC and the ARM
> v7M.
>
> Change the code to call report_bad_exec() if the hook returns, as
> well as if it didn't have one.  This means we can tidy it up to use
> the cpu_unassigned_access() function which wraps the "get the CPU
> class and call the hook if it has one" work, since we aren't trying
> to distinguish "no hook" from "hook existed and returned" any more.
>
> This brings the handling of this hook into line with the handling
> used for data accesses, where "hook returned" is treated the
> same as "no hook existed" and gets you the default behaviour.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Review from somebody who understands how the unassigned_access
> hooks are supposed to work appreciated.
>
>  cputlb.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

The unassigned_access hook was (unfortunately) designed after the 
unaligned_access hook.  The later *can* usefully return to indicate that the 
cpu bit that enforces alignment traps is off.

Any unassigned_access hook that doesn't longjmp could be considered buggy.

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
