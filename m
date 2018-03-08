Received: from eggs.gnu.org ([2001:4830:134:3::10]:34433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ett3j-0007mr-Nz
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:46:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ett3i-0000Ai-UR
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:46:03 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ett3i-0000AD-Oa
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:46:02 -0500
Received: by mail-oi0-x242.google.com with SMTP id c18so4005624oiy.9
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 02:46:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <48bc8ae3-97d9-3fba-5c58-a44c20a4a8d4@redhat.com>
References: <1520413694-1271-1-git-send-email-thuth@redhat.com>
	<3aaac650-2934-c4ab-3f58-c022b1510e81@reactos.org>
	<950d4782-e1ca-816a-f13c-3dade56a7e7f@redhat.com>
	<CAFEAcA-bXBfc44y5FV9BOB14KMsJGNj3YEYSDxyAfVGpQooWjg@mail.gmail.com>
	<48bc8ae3-97d9-3fba-5c58-a44c20a4a8d4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Mar 2018 10:45:41 +0000
Message-ID: <CAFEAcA8mYKZ7F0YE8=x-4Y8Ca9dn3GEOTNg0iV6U53ZvH1fL5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/prep: Fix implicit creation of
 "-drive if=scsi" devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 8 March 2018 at 10:26, Thomas Huth <thuth@redhat.com> wrote:
> On 08.03.2018 11:07, Peter Maydell wrote:
>> Are we sure this is the entire list of machines that use this?
>
> Yes. The problem only occurs for boards that are using
> block_default_type = IF_SCSI.
>
> $ grep -rl IF_SCSI hw/
> hw/arm/versatilepb.c
> hw/arm/realview.c
> hw/mips/mips_jazz.c
> hw/ppc/prep.c
> hw/ppc/spapr.c
> hw/scsi/scsi-bus.c
> hw/sparc/sun4m.c
> hw/hppa/machine.c
>
> versatilepb, realview and the hppa machine were already using
> lsi53c895a_create() that takes care of this already. spapr is properly
> using scsi_bus_legacy_handle_cmdline() in spapr_vscsi_create(). And for
> jazz, prep and sun4m, I sent the patches to the list yesterday.

Cool.

>> Can we in general try to avoid removing generic code features
>> until we've checked and fixed everything that relies on them? x86 pc
>> is not the only system we support...
>
> Sure. You know, I'm a ppc / s390x guy, so I am very aware of other
> platforms, too. In this case it was just a bad misunderstanding - I did
> not expect that the code would still be used on other platforms, too.
> Sorry for that.

Sorry for being grumpy -- I should have skipped sending that mail
til I'd had some more coffee.

> The problem is rather that we still need more automatic regression tests
> for stuff like this. I already have got something in mind for a new
> qtest: If "mkisofs" or "genisoimage" is available, we could create a
> boot CD-ROM automatically using the boot code from tests/boot-sector.c.
> Then the test could try to boot from that CD-ROM to check whether
> "--cdrom" is still working as expected. What do you think, does that
> sound reasonable?

That's probably a good plan, though it wouldn't be able to cover
boards like versatile/realview that can't boot from a cdrom.

thanks
-- PMM
