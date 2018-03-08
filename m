Received: from eggs.gnu.org ([2001:4830:134:3::10]:58911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etskm-0008Ga-VB
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:26:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etskh-0008Vu-0o
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:26:28 -0500
References: <1520413694-1271-1-git-send-email-thuth@redhat.com>
	<3aaac650-2934-c4ab-3f58-c022b1510e81@reactos.org>
	<950d4782-e1ca-816a-f13c-3dade56a7e7f@redhat.com>
	<CAFEAcA-bXBfc44y5FV9BOB14KMsJGNj3YEYSDxyAfVGpQooWjg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <48bc8ae3-97d9-3fba-5c58-a44c20a4a8d4@redhat.com>
Date: Thu, 8 Mar 2018 11:26:16 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-bXBfc44y5FV9BOB14KMsJGNj3YEYSDxyAfVGpQooWjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 08.03.2018 11:07, Peter Maydell wrote:
> On 8 March 2018 at 07:09, Thomas Huth <thuth@redhat.com> wrote:
>> It's the third case. The "generic" code was just removed with commit
>> 1454509726719e0933 since it was considered as a big hack. The generic
>> code should not have to guess to which SCSI adapter a SCSI drive shoul=
d
>> be attached to. That's the job of the board init code, and this is wha=
t
>> this patch is doing now for the 40p machine.
>>
>> Other boards like the "pseries" machine were doing this since a long
>> time already (see the spapr_vscsi_create() function in
>> hw/scsi/spapr_vscsi.c for example).
>>
>>> You just fixed 40p and MIPS Jazz machines, but sparc/SS-10 (and other=
)
>>> also have the same problem...
>>
>> I also posted a patch for the Sparc machines, you can find it here:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg01830.html
>=20
> Are we sure this is the entire list of machines that use this?

Yes. The problem only occurs for boards that are using
block_default_type =3D IF_SCSI.

$ grep -rl IF_SCSI hw/
hw/arm/versatilepb.c
hw/arm/realview.c
hw/mips/mips_jazz.c
hw/ppc/prep.c
hw/ppc/spapr.c
hw/scsi/scsi-bus.c
hw/sparc/sun4m.c
hw/hppa/machine.c

versatilepb, realview and the hppa machine were already using
lsi53c895a_create() that takes care of this already. spapr is properly
using scsi_bus_legacy_handle_cmdline() in spapr_vscsi_create(). And for
jazz, prep and sun4m, I sent the patches to the list yesterday.

> Can we in general try to avoid removing generic code features
> until we've checked and fixed everything that relies on them? x86 pc
> is not the only system we support...

Sure. You know, I'm a ppc / s390x guy, so I am very aware of other
platforms, too. In this case it was just a bad misunderstanding - I did
not expect that the code would still be used on other platforms, too.
Sorry for that.

The problem is rather that we still need more automatic regression tests
for stuff like this. I already have got something in mind for a new
qtest: If "mkisofs" or "genisoimage" is available, we could create a
boot CD-ROM automatically using the boot code from tests/boot-sector.c.
Then the test could try to boot from that CD-ROM to check whether
"--cdrom" is still working as expected. What do you think, does that
sound reasonable?

 Thomas
