Received: from eggs.gnu.org ([2001:4830:134:3::10]:55069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dY7ya-0000K9-Ia
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dY7yZ-00026r-Pj
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:42:32 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dY7yZ-00026g-I1
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:42:31 -0400
Received: by mail-wr0-x229.google.com with SMTP id v105so38245720wrb.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 02:42:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717185830.GD31820@work-vm>
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-iWRqhNhrJsrvODRunkwMGTUsTMfhdHZw3aCjoc3p1Mg@mail.gmail.com>
	<CAJy5ezpvpohU5x48WrKz57k9+s39hkSCUm+f_u2qf7E0Zin7Mw@mail.gmail.com>
	<20170717185830.GD31820@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2017 10:42:09 +0100
Message-ID: <CAFEAcA-yt=fkPrGL_6X_A8n=+u5YuX1+V82Sc7+2MeuA38kH0A@mail.gmail.com>
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

On 17 July 2017 at 19:58, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> * Edgar E. Iglesias (edgar.iglesias@gmail.com) wrote:
>> Is there a way we can prevent migration of the RAMBlock?
>
> Not yet, I think we'd have to:
>    a) Add a flag to the RAMBlock
>    b) Set it/clear it on registration
>    c) Have a RAMBLOCK_FOREACH_MIGRATABLE macro
>    d) Replace all of the RAMBLOCK_FOREACH (and the couple of hand coded
>    cases) with the RAMBLOCK_FOREACH_MIGRATABLE
>    e) Worry about the corner cases!
>
> I've got a few worries about what happens when the kernel tries to
> do dirty yncing - I'm not sure if we have to change anything on that
> interface to skip those RAMBlocks.

OK, so what should we do for 2.10 ?

We could:
 * implement the changes you suggest above, and mark only
   vmstate_register_ram'd blocks as migratable
   (would probably need to fix some places which buggily
   don't call vmstate_register_ram)
 * implement the changes above, but special case mmio-interface
   so only its ramblock is marked unmigratable
 * postpone the changes above until 2.11, and for 2.10 register
   a migration-blocker in mmio-interface so that we at least
   give the user a useful error rather than having it fail
   obscurely on vmload (and release note this)

(Or something else?)

I do think we definitely need to fix this for 2.11 at latest.

thanks
-- PMM
