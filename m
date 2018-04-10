Received: from eggs.gnu.org ([2001:4830:134:3::10]:59344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5hVl-0007jk-UC
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 20:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5hVk-0001b4-Rj
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 20:51:50 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:39642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f5hVk-0001ad-KA
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 20:51:48 -0400
Received: by mail-pf0-x22a.google.com with SMTP id c78so6809804pfj.6
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 17:51:48 -0700 (PDT)
References: <20180409091320.12504.35329.stgit@pasha-VirtualBox>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7216567c-f6ae-4357-1f90-9a46f856a42d@linaro.org>
Date: Tue, 10 Apr 2018 10:51:36 +1000
MIME-Version: 1.0
In-Reply-To: <20180409091320.12504.35329.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] icount: fix cpu_restore_state_from_tb for
 non-tb-exit cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, crosthwaite.peter@gmail.com, kbastian@mail.uni-paderborn.de, green@moxielogic.com, laurent@vivier.eu, jcmvbkbc@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pbonzini@redhat.com, edgar.iglesias@gmail.com, shorne@gmail.com, yongbok.kim@mips.com, aurelien@aurel32.net, rth@twiddle.net

On 04/09/2018 07:13 PM, Pavel Dovgalyuk wrote:
> In icount mode instructions, that access io memory spaces in the middle
> of the translation blocks, invoke TB recompilation.
> After recompilation such instructions become last in the TB and are
> allowed to access io memory spaces.
> When the code includes instruction like i386 'xchg eax, 0xffffd080'
> which accesses APIC, QEMU goes into the infinite loop of the recompilation.
> This instruction includes two memory accesses - one read and one write.
> After first access APIC calls cpu_report_tpr_access, which restores
> the CPU state to get the current eip. But cpu_restore_state_from_tb
> resets cpu->can_do_io flag and makes second memory access invalid.
> Therefore second memory access causes a recompilation of the block.
> Then these operations repeat again and again.
> 
> This patch moves resetting cpu->can_do_io flag from cpu_restore_state_from_tb
> to cpu_loop_exit* functions. It also adds a parameter for cpu_restore_state*()
> which controls restoring icount. There is no need in restoring icount,
> when we only query CPU state without breaking the TB. Restoring it in such
> cases leads to the incorrect flow of the virtual time.
> 
> In most cases new parameter is true (icount should be recalculated).
> But there are two cases in i386 and openrisc when the CPU state is only
> queued without the need to break the TB. This patch fixes both
> of these cases.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---

Thanks for the patch and the detailed description.  I've applied this (with
some editing of the english in the description) to my tcg branch for 2.12.


r~
