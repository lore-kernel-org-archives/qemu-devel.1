Received: from eggs.gnu.org ([2001:4830:134:3::10]:50161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejo3M-0003sM-9B
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:24:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejo3L-0007o9-K1
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:24:00 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:43444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejo3L-0007mj-Ep
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:23:59 -0500
Received: by mail-ot0-x244.google.com with SMTP id q12so4645437otg.10
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 07:23:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180201205307.30343-1-christoffer.dall@linaro.org>
References: <20180201205307.30343-1-christoffer.dall@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2018 15:23:38 +0000
Message-ID: <CAFEAcA8JEHhE1eov8UhusZwshE-Y38v=HkJLEbNa1LcWY-xOQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm/kvm: gic: Prevent creating
 userspace GICv3 with KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoffer Dall <christoffer.dall@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alex Bennee <alex.bennee@linaro.org>

On 1 February 2018 at 20:53, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> KVM doesn't support emulating a GICv3 in userspace, only GICv2.  We
> currently attempt this anyway, and as a result a KVM guest doesn't
> receive interrupts and the user is left wondering why.  Report an error
> to the user if this particular combination is requested.
>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  target/arm/kvm_arm.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index ff53e9fafb..cfb7e5af72 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -234,6 +234,10 @@ static inline const char *gicv3_class_name(void)
>          exit(1);
>  #endif
>      } else {
> +        if (kvm_enabled()) {
> +            error_report("Userspace GICv3 is not supported with KVM");
> +            exit(1);
> +        }
>          return "arm-gicv3";
>      }



Applied to target-arm.next, thanks.

-- PMM
