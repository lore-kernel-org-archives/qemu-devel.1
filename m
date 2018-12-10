Received: from eggs.gnu.org ([2001:4830:134:3::10]:41560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWNPm-00054g-JL
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:24:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWNPj-0006Dr-Az
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:24:10 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWNPj-0006DC-0A
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:24:07 -0500
Received: by mail-oi1-x243.google.com with SMTP id i6so9247765oia.6
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 07:24:06 -0800 (PST)
References: <20181210114654.31433-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1740a92d-70d7-69a3-4a7b-b42b83f0f160@linaro.org>
Date: Mon, 10 Dec 2018 09:24:02 -0600
MIME-Version: 1.0
In-Reply-To: <20181210114654.31433-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, patches@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 12/10/18 5:46 AM, Peter Maydell wrote:
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
> ---
>  target/i386/kvm.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
