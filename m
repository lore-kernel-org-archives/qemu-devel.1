Received: from eggs.gnu.org ([2001:4830:134:3::10]:35462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWOlz-0007iH-M7
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWOlv-0003ul-LC
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:51:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:10712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWOlu-0003u9-C7
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:51:07 -0500
Date: Mon, 10 Dec 2018 14:50:57 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181210165057.GD4669@habkost.net>
References: <20181210114654.31433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210114654.31433-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] target/i386/kvm.c: Don't mark cpuid_data
 as QEMU_PACKED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Dec 10, 2018 at 11:46:54AM +0000, Peter Maydell wrote:
> clang complains about taking the address of a packed
> member of a struct:
> 
> target/i386/kvm.c:1245:27: warning: taking address of packed member 'cpuid' of class or structure '' may result in an unaligned pointer value [-Waddress-of-packed-member]
>     c = cpuid_find_entry(&cpuid_data.cpuid, 1, 0);
>                           ^~~~~~~~~~~~~~~~
> target/i386/kvm.c:1297:31: warning: taking address of packed member 'cpuid' of class or structure '' may result in an unaligned pointer value [-Waddress-of-packed-member]
>         c = cpuid_find_entry(&cpuid_data.cpuid, kvm_base, 0);
>                               ^~~~~~~~~~~~~~~~
> 
> The kernel's definitions of struct kvm_cpuid2 and struct
> kvm_cpuid_entry2 are carefully set up with padding fields
> so that there is no between-struct padding anyway, so
> the QEMU_PACKED annotation is unnecessary and might result
> in the compiler generating worse code. Drop it, and instead
> assert at build time that there is no stray padding.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Queued, thanks.

-- 
Eduardo
