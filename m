Received: from eggs.gnu.org ([2001:4830:134:3::10]:49999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eCTH8-00058i-87
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:32:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eCTH7-00071z-Gz
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:32:26 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171108153245.20740-1-alex.bennee@linaro.org>
	<20171108153245.20740-3-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <234690ff-ef05-9276-f6e9-2ecbb3d5964b@twiddle.net>
Date: Wed, 8 Nov 2017 17:32:14 +0100
MIME-Version: 1.0
In-Reply-To: <20171108153245.20740-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] target/*helper: don't check retaddr
 before calling cpu_restore_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, Alexander Graf <agraf@suse.de>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, "open list:S390" <qemu-s390x@nongnu.org>

On 11/08/2017 04:32 PM, Alex Bennée wrote:
> -        if (retaddr) {
> -            cpu_restore_state(cs, retaddr);
> -        }
> +        cpu_restore_state(cs, retaddr);
>          /* Exception index and error code are already set */
>          cpu_loop_exit(cs);

Not that this is wrong, but while we're cleaning things up,
this call combo is cpu_loop_exit_restore.

You create at least 8 of these pairs in this patch.

> +++ b/target/moxie/helper.c
> @@ -36,9 +36,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
>  
>      ret = moxie_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
>      if (unlikely(ret)) {
> -        if (retaddr) {
> -            cpu_restore_state(cs, retaddr);
> -        }
> +        cpu_restore_state(cs, retaddr);
>      }
>      cpu_loop_exit(cs);
>  }


This one *should* have been such a pair, but there's an existing bug in moxie
that should have restricted the cpu_loop_exit to inside the if.

All that said,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
