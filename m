Received: from eggs.gnu.org ([2001:4830:134:3::10]:58255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cvl5e-0004Pc-Vn
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cvl5b-0005D5-R3
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:35:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cvl5b-0005Cf-Fo
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:35:11 -0400
References: <20170405081209.26814-1-pbonzini@redhat.com>
	<10ed2863-e925-a0cc-46a2-52f752f37218@redhat.com>
	<d6c7f116-cc33-053e-17c6-fa277c4c17f7@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d54a867b-6d49-ee37-e182-431c1b611c7c@redhat.com>
Date: Wed, 5 Apr 2017 15:35:07 +0200
MIME-Version: 1.0
In-Reply-To: <d6c7f116-cc33-053e-17c6-fa277c4c17f7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9] tco: do not generate an NMI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Paulo Alcantara <pcacjr@gmail.com>, Paulo Alcantara <pcacjr@zytor.com>

On 04/05/17 14:44, Paolo Bonzini wrote:
>=20
>=20
> On 05/04/2017 11:30, Laszlo Ersek wrote:
>> CC Paulo
>>
>> On 04/05/17 10:12, Paolo Bonzini wrote:
>>> This behavior is not indicated in the datasheet and can confuse the O=
S.
>>
>> * The message of commit 920557971b60 ("ich9: add TCO interface
>> emulation", 2015-06-28) says
>>
>>> ... This patch adds support to TCO watchdog logic and few other
>>> features like mapping NMIs to SMIs (NMI2SMI_EN bit), system intruder
>>> detection, etc. are not implemented yet.
>>
>> (Terrible punctuation -- "and" should have been replaced by a full sto=
p
>> -- but the intent is clear.)
>>
>> Looking at the ICH9 spec,
>>
>> - TCO1_STS has a bit called NMI2SMI_STS, where value 1 means "Set by t=
he
>> ICH9 when an SMI# occurs because an event occurred that would
>> otherwise have caused an NMI (because NMI2SMI_EN is set)."
>>
>> - TCO1_CNT contains the bit called NMI2SMI_EN, where value 0 correspon=
ds
>> to "Normal NMI functionality."
>>
>> These do appear to suggest that the normal timeout action for the
>> watchdog is to inject and NMI, don't they?
>=20
> They do, but that's not the normal timeout action.  There is evidence
> through the ICH9 spec, but you need multiple clues to understand what's
> really going on.
>=20
> If you look at Table 5-28 (Causes of SMI# and SCI), you have the
> following entries:
>=20
> TCO SMI Logic
> 		enabled by TCO_EN=3D1, reported in TCO_STS
> TCO SMI =E2=80=94 TCO TIMEROUT
> 		no additional enables, reported in TIMEOUT
> TCO SMI =E2=80=94 NMI occurred (and NMIs mapped to SMI)
> 		enabled by NMI2SMI_EN=3D1, reported in NMI2SMI_STS
>=20
>=20
> The NMI2SMI_STS bit in TCO1_STS is read-only (unlike TIMEOUT and others=
)
> and it says (13.9.4):
>=20
> 0 =3D Cleared by clearing the associated NMI status bit.
> 1 =3D Set by the ICH9 when an SMI# occurs because an event occurred tha=
t
> 	would otherwise have caused an NMI (because NMI2SMI_EN is set).
>=20
>=20
> "Otherwise" is the key word here, and is confirmed by two other parts o=
f
> the manual.  In 13.9.6, NMI2SMI_EN is described like this:
>=20
> 0 =3D Normal NMI functionality.
> 1 =3D Forces all NMIs to instead cause SMIs.
>=20
>=20
> In Table 5-23, the following NMI sources are listed:
>=20
> - SERR# goes active (either internally, externally via SERR# signal, or
> via message from (G)MCH)
>=20
> - IOCHK# goes active via SERIRQ# stream (ISA system Error)
>=20
> Ignoring the acronym soup, the right column is interesting: "Can instea=
d
> be routed to generate an SCI, through the NMI2SCI_EN bit (Device
> 31:Function 0, TCO Base + 08h, bit 11)".  There is _no_ NMI2SCI_EN bit;
> that bit is "TCO Timer Halt" while NMI2SMI_EN is bit 9 in TCOBASE+08h.
>=20
> The typo has been propagated in pretty much every Intel southbridge
> manual including ICH2 (year 2000) and X79 (aka Patsburg, year 2013), bu=
t
> a plausible way to read it is "Can instead be routed to generate an SMI=
,
> through the NMI2SMI_EN bit (Device 31:Function 0, TCO Base + 08h, bit 9=
)".
>=20
> So if you put all these together:
>=20
> - NMI2SMI_EN refers to system error NMIs (SERR#/IOCHK#).  The SERR/IOCH=
K
> status bits in port 61h (ICH9 datasheet 13.7.1) are the "associated NMI
> status bits" mentioned in the documentation for NMI2SMI_STS

Yes, I did track it back to SERR#/IOCHK#.

What wasn't obvious to me why the TCO watchdog couldn't activate SERR#.

I guess I missed the "SERR#" explanation in Table-2.6 "PCI Interface
Signals", where it is described as

  System Error: SERR# can be pulsed active by any PCI device that
  detects a system error condition. Upon sampling SERR# active, the
  ICH9 has the ability to generate an NMI, SMI#, or interrupt.

... Well, I still don't see why the watchdog cannot activate SERR#. Why
can't it? :)

>=20
> - both watchdog SMIs and "mapped NMI" SMIs are enabled by TCO_EN
>=20
> - even if firmware needed TCO SMIs, it would not necessarily prevent th=
e
> operating system from using the TCO watchdog.  As long as the firmware'=
s
> TCO SMI handler does not touch TCO_RLD, the extra SMI is not an issue
> (of course, in the real world many firmwares do).
>=20
>> * Does this patch keep "tests/tco-test.c" in working shape?
>=20
> Yes, tco-test only tests the registers and the watchdog actions, not th=
e
> interrupts.

Ah okay, I genuinely missed that the watchdog actions are handled
separately in QEMU.

Where is the TCO watchdog hooked up to the general watchdog stuff (like,
to emitting a WATCHDOG event)?

... I see it now. It's the watchdog_perform_action() call in
tco_timer_expired(). And, it is indeed handled separately from the
interrupt injection.

>> * Would blacklisting the iTCO_wdt module in the guest be a suitable
>> counter-measure? Should OS installers be modified to blacklist
>> "iTCO_wdt" by default if they detect a KVM guest?
>=20
> No, on the contrary I'd like to use iTCO_wdt :) but right now the
> unexpected NMI causes a "dazed and confused" message on Linux.  If I
> disable both NMI and SMI

You mean "by applying is patch, and then not setting
ICH9_PMIO_SMI_EN_TCO_EN in the guest"?

> (and pass "-global ICH9-LPC.noreboot=3Dfalse"

This was confusing, but I see it un-gates the very
watchdog_perform_action() call that I just found above, via
(!lpc->pin_strap.spkr_hi). I also had to read commit 5add35bec1e2
("ich9: implement strap SPKR pin logic", 2015-06-28).

> so
> that the watchdog does reboot the machine), everything works without
> ugly messages.

Thanks for the explanation. I now wonder why Paulo decided to add the
NMI in the first place -- was he too confused by the SERR# definition?

>=20
>> (Idea taken from "Documentation/sysctl/kernel.txt", near "nmi_watchdog=
"
>> -- "The NMI watchdog is disabled by default if the kernel is running a=
s
>> a guest in a KVM virtual machine.")
>=20
> The Linux NMI watchdog is something else, it is obtained by programming
> a hardware performance counter on every processor.  On Linux,
> performance counters raise NMIs.

I understood that, yes. "Documentation/sysctl/kernel.txt" -- unlike the
other text files under Documentation/ that mention "nmi_watchdog" --
made it clear. My point was rather that we could follow this
(independent) example.

Namely, for whatever reason it was wrong to raise an NMI in a KVM guest
through those performance counters, the same reason would be enough to
not raise an NMI through the iTCO_wdt driver either.

If the culprit is the device model in QEMU though, then I agree the
driver should not be blacklisted.

So why is SERR# activation off-limits for the TCO watchdog? I think if I
can understand that, then I'll see that this patch is correct too.

Thanks,
Laszlo


>=20
> Paolo
>=20
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  hw/acpi/tco.c          | 2 --
>>>  hw/isa/lpc_ich9.c      | 5 -----
>>>  include/hw/i386/ich9.h | 1 -
>>>  3 files changed, 8 deletions(-)
>>>
>>> diff --git a/hw/acpi/tco.c b/hw/acpi/tco.c
>>> index b4adac8..05b9d7b 100644
>>> --- a/hw/acpi/tco.c
>>> +++ b/hw/acpi/tco.c
>>> @@ -75,8 +75,6 @@ static void tco_timer_expired(void *opaque)
>>> =20
>>>      if (pm->smi_en & ICH9_PMIO_SMI_EN_TCO_EN) {
>>>          ich9_generate_smi();
>>> -    } else {
>>> -        ich9_generate_nmi();
>>>      }
>>>      tr->tco.rld =3D tr->tco.tmr;
>>>      tco_timer_reload(tr);
>>> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
>>> index 59930dd..a0866c3 100644
>>> --- a/hw/isa/lpc_ich9.c
>>> +++ b/hw/isa/lpc_ich9.c
>>> @@ -312,11 +312,6 @@ void ich9_generate_smi(void)
>>>      cpu_interrupt(first_cpu, CPU_INTERRUPT_SMI);
>>>  }
>>> =20
>>> -void ich9_generate_nmi(void)
>>> -{
>>> -    cpu_interrupt(first_cpu, CPU_INTERRUPT_NMI);
>>> -}
>>> -
>>>  static int ich9_lpc_sci_irq(ICH9LPCState *lpc)
>>>  {
>>>      switch (lpc->d.config[ICH9_LPC_ACPI_CTRL] &
>>> diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
>>> index 18dcca7..673d13d 100644
>>> --- a/include/hw/i386/ich9.h
>>> +++ b/include/hw/i386/ich9.h
>>> @@ -21,7 +21,6 @@ void ich9_lpc_pm_init(PCIDevice *pci_lpc, bool smm_=
enabled);
>>>  I2CBus *ich9_smb_init(PCIBus *bus, int devfn, uint32_t smb_io_base);
>>> =20
>>>  void ich9_generate_smi(void);
>>> -void ich9_generate_nmi(void);
>>> =20
>>>  #define ICH9_CC_SIZE (16 * 1024) /* 16KB. Chipset configuration regi=
sters */
>>> =20
>>>
>>
