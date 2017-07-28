Received: from eggs.gnu.org ([2001:4830:134:3::10]:59853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1db1Pq-0004E2-Ny
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1db1Pp-00051x-UY
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:18:38 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:37119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1db1Pp-0004zi-ON
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:18:37 -0400
Received: by mail-wr0-x22b.google.com with SMTP id 33so96185444wrz.4
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 02:18:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-yt=fkPrGL_6X_A8n=+u5YuX1+V82Sc7+2MeuA38kH0A@mail.gmail.com>
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-iWRqhNhrJsrvODRunkwMGTUsTMfhdHZw3aCjoc3p1Mg@mail.gmail.com>
	<CAJy5ezpvpohU5x48WrKz57k9+s39hkSCUm+f_u2qf7E0Zin7Mw@mail.gmail.com>
	<20170717185830.GD31820@work-vm>
	<CAFEAcA-yt=fkPrGL_6X_A8n=+u5YuX1+V82Sc7+2MeuA38kH0A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jul 2017 10:18:14 +0100
Message-ID: <CAFEAcA_38JueOfxmgB_w=Pcy9suaX7y+bfunDTvdMwFpZy+jsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/7] MMIO Exec pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, KONRAD Frederic <frederic.konrad@adacore.com>, Juan Quintela <quintela@redhat.com>

On 20 July 2017 at 10:42, Peter Maydell <peter.maydell@linaro.org> wrote:
> OK, so what should we do for 2.10 ?
>
> We could:
>  * implement the changes you suggest above, and mark only
>    vmstate_register_ram'd blocks as migratable
>    (would probably need to fix some places which buggily
>    don't call vmstate_register_ram)
>  * implement the changes above, but special case mmio-interface
>    so only its ramblock is marked unmigratable
>  * postpone the changes above until 2.11, and for 2.10 register
>    a migration-blocker in mmio-interface so that we at least
>    give the user a useful error rather than having it fail
>    obscurely on vmload (and release note this)
>
> (Or something else?)

Talking to David about this on IRC, even "don't allow
migration" is a bit tricky, because you can't register
a migration-blocker if a migration is already in progress.
Two further options:
 * disable this mmio-exec-in-place entirely for 2.10 as
   being not completely baked yet, and fix it properly
   in 2.11
 * ditto, but allow the device to have an x-enable-exec-in-place
   property which turned on the not-baked feature (the
   property would go away in 2.11, which is OK because
   of the x- experimental prefix)

I'm leaning towards disable-entirely at the moment...

thanks
-- PMM
