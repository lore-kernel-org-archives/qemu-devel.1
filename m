Received: from eggs.gnu.org ([2001:4830:134:3::10]:58311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpI4S-00014S-O3
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpI4O-0001Ch-0G
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:55:32 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:33511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpI4N-0001C2-M0
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 13:55:27 -0400
Received: by mail-wr0-x22b.google.com with SMTP id a43so10227119wrc.0
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 10:55:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170831103432.6007-25-marcandre.lureau@redhat.com>
References: <20170831103432.6007-1-marcandre.lureau@redhat.com>
	<20170831103432.6007-25-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 18:55:06 +0100
Message-ID: <CAFEAcA-BcuFQcw3gnotbN=Km7RWNr5=AwBRb2VUAsD7xkaTqhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 24/29] kvm: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 31 August 2017 at 11:34, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> I used the clang-tidy qemu-round check to generate the fix:
> https://github.com/elmarco/clang-tools-extra
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> ---
>  linux-headers/asm-x86/kvm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
> index c2824d02ba..1930b95bcb 100644
> --- a/linux-headers/asm-x86/kvm.h
> +++ b/linux-headers/asm-x86/kvm.h
> @@ -153,7 +153,7 @@ struct kvm_sregs {
>         __u64 cr0, cr2, cr3, cr4, cr8;
>         __u64 efer;
>         __u64 apic_base;
> -       __u64 interrupt_bitmap[(KVM_NR_INTERRUPTS + 63) / 64];
> +       __u64 interrupt_bitmap[DIV_ROUND_UP(KVM_NR_INTERRUPTS, 64)];
>  };
>
>  /* for KVM_GET_FPU and KVM_SET_FPU */

Hi -- I just noticed that this commit makes a change to linux-headers/.
This directory is for kernel headers which we keep in sync with the
upstream kernel via scripts/update-linux-headers.sh, so we shouldn't
be applying our code cleanups to it.

I'm going to revert it (206a0fc75d5f54886c1b3f3a65782a75e36b6b97).

thanks
-- PMM
