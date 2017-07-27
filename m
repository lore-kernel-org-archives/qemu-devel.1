Received: from eggs.gnu.org ([2001:4830:134:3::10]:58117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dao8P-0001Ff-Fb
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 15:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dao8M-0001lX-7J
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 15:07:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dao8M-0001ie-11
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 15:07:42 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170721091337.GA2133@work-vm> (David Alan Gilbert's message of
	"Fri, 21 Jul 2017 10:13:39 +0100")
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-iWRqhNhrJsrvODRunkwMGTUsTMfhdHZw3aCjoc3p1Mg@mail.gmail.com>
	<CAJy5ezpvpohU5x48WrKz57k9+s39hkSCUm+f_u2qf7E0Zin7Mw@mail.gmail.com>
	<20170717185830.GD31820@work-vm>
	<CAFEAcA-yt=fkPrGL_6X_A8n=+u5YuX1+V82Sc7+2MeuA38kH0A@mail.gmail.com>
	<20170720100232.GA2456@work-vm>
	<408f467d-08dc-bb3e-0bfc-9825ca07107c@adacore.com>
	<20170721091337.GA2133@work-vm>
Reply-To: quintela@redhat.com
Date: Thu, 27 Jul 2017 21:07:39 +0200
Message-ID: <87wp6t7l6s.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * KONRAD Frederic (frederic.konrad@adacore.com) wrote:
>> 
>> 

>> 
>> Let's imagine somebody (eg: u-boot guest) wants to execute code
>> from the LQSPI area.
>> 
>> memory_region_request_mmio_ptr is called (the guest is not
>> running yet) it will create a mmio-interface which create the
>> ram memory region with a pointer provided by the device.
>> Then the guest can execute code from that and this somehow is
>> breaking migration because this ram memory region is migrated.
>> 
>> Now something is writing to the device.. The cache is no longer
>> valid, we have to drop this mmio-interface. This is done in an
>> async_safe work so cpu are stopped at this moment. So I think we
>> are safe for that.
>
> I don't fully understand the way memory_region_do_invalidate_mmio_ptr
> works; I see it dropping the memory region; if that's also dropping
> the RAMBlock then it will upset migration.   Even if the CPU is stopped
> I dont think that stops the migration thread walking through the list of
> RAMBlocks.

I made sure that we don't allow Memory hot[un]plug during migration.
Basically we were already assuming that RAMBlocks are static during
migration,  to relax that, we need to change other things, and it is too
late to investigate that.


> Even then, the problem is migration keeps a 'dirty_pages' count which is
> calculated at the start of migration and updated as we dirty and send
> pages; if we add/remove a RAMBlock then that dirty_pages count is wrong
> and we either never finish migration (since dirty_pages never reaches
> zero) or finish early with some unsent data.

Yeap, that is trouble.

> And then there's the 'received' bitmap currently being added for
> postcopy which tracks each page that's been received (that's not in yet
> though).

Later, Juan.
