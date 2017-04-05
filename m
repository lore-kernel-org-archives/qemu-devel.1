Received: from eggs.gnu.org ([2001:4830:134:3::10]:42751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvkIo-0001jY-8p
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvkIk-0001rI-8h
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:44:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cvkIj-0001po-WF
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:44:42 -0400
References: <20170405081209.26814-1-pbonzini@redhat.com>
	<10ed2863-e925-a0cc-46a2-52f752f37218@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6c7f116-cc33-053e-17c6-fa277c4c17f7@redhat.com>
Date: Wed, 5 Apr 2017 14:44:34 +0200
MIME-Version: 1.0
In-Reply-To: <10ed2863-e925-a0cc-46a2-52f752f37218@redhat.com>
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
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: Paulo Alcantara <pcacjr@gmail.com>, Paulo Alcantara <pcacjr@zytor.com>



On 05/04/2017 11:30, Laszlo Ersek wrote:
> CC Paulo
>=20
> On 04/05/17 10:12, Paolo Bonzini wrote:
>> This behavior is not indicated in the datasheet and can confuse the OS=
.
>=20
> * The message of commit 920557971b60 ("ich9: add TCO interface
> emulation", 2015-06-28) says
>=20
>> ... This patch adds support to TCO watchdog logic and few other
>> features like mapping NMIs to SMIs (NMI2SMI_EN bit), system intruder
>> detection, etc. are not implemented yet.
>=20
> (Terrible punctuation -- "and" should have been replaced by a full stop
> -- but the intent is clear.)
>=20
> Looking at the ICH9 spec,
>=20
> - TCO1_STS has a bit called NMI2SMI_STS, where value 1 means "Set by th=
e
> ICH9 when an SMI# occurs because an event occurred that would
> otherwise have caused an NMI (because NMI2SMI_EN is set)."
>=20
> - TCO1_CNT contains the bit called NMI2SMI_EN, where value 0 correspond=
s
> to "Normal NMI functionality."
>=20
> These do appear to suggest that the normal timeout action for the
> watchdog is to inject and NMI, don't they?

They do, but that's not the normal timeout action.  There is evidence
through the ICH9 spec, but you need multiple clues to understand what's
really going on.

If you look at Table 5-28 (Causes of SMI# and SCI), you have the
following entries:

TCO SMI Logic
		enabled by TCO_EN=3D1, reported in TCO_STS
TCO SMI =E2=80=94 TCO TIMEROUT
		no additional enables, reported in TIMEOUT
TCO SMI =E2=80=94 NMI occurred (and NMIs mapped to SMI)
		enabled by NMI2SMI_EN=3D1, reported in NMI2SMI_STS


The NMI2SMI_STS bit in TCO1_STS is read-only (unlike TIMEOUT and others)
and it says (13.9.4):

0 =3D Cleared by clearing the associated NMI status bit.
1 =3D Set by the ICH9 when an SMI# occurs because an event occurred that
	would otherwise have caused an NMI (because NMI2SMI_EN is set).


"Otherwise" is the key word here, and is confirmed by two other parts of
the manual.  In 13.9.6, NMI2SMI_EN is described like this:

0 =3D Normal NMI functionality.
1 =3D Forces all NMIs to instead cause SMIs.


In Table 5-23, the following NMI sources are listed:

- SERR# goes active (either internally, externally via SERR# signal, or
via message from (G)MCH)

- IOCHK# goes active via SERIRQ# stream (ISA system Error)

Ignoring the acronym soup, the right column is interesting: "Can instead
be routed to generate an SCI, through the NMI2SCI_EN bit (Device
31:Function 0, TCO Base + 08h, bit 11)".  There is _no_ NMI2SCI_EN bit;
that bit is "TCO Timer Halt" while NMI2SMI_EN is bit 9 in TCOBASE+08h.

The typo has been propagated in pretty much every Intel southbridge
manual including ICH2 (year 2000) and X79 (aka Patsburg, year 2013), but
a plausible way to read it is "Can instead be routed to generate an SMI,
through the NMI2SMI_EN bit (Device 31:Function 0, TCO Base + 08h, bit 9)"=
.

So if you put all these together:

- NMI2SMI_EN refers to system error NMIs (SERR#/IOCHK#).  The SERR/IOCHK
status bits in port 61h (ICH9 datasheet 13.7.1) are the "associated NMI
status bits" mentioned in the documentation for NMI2SMI_STS

- both watchdog SMIs and "mapped NMI" SMIs are enabled by TCO_EN

- even if firmware needed TCO SMIs, it would not necessarily prevent the
operating system from using the TCO watchdog.  As long as the firmware's
TCO SMI handler does not touch TCO_RLD, the extra SMI is not an issue
(of course, in the real world many firmwares do).

> * Does this patch keep "tests/tco-test.c" in working shape?

Yes, tco-test only tests the registers and the watchdog actions, not the
interrupts.

> * Would blacklisting the iTCO_wdt module in the guest be a suitable
> counter-measure? Should OS installers be modified to blacklist
> "iTCO_wdt" by default if they detect a KVM guest?

No, on the contrary I'd like to use iTCO_wdt :) but right now the
unexpected NMI causes a "dazed and confused" message on Linux.  If I
disable both NMI and SMI (and pass "-global ICH9-LPC.noreboot=3Dfalse" so
that the watchdog does reboot the machine), everything works without
ugly messages.

> (Idea taken from "Documentation/sysctl/kernel.txt", near "nmi_watchdog"
> -- "The NMI watchdog is disabled by default if the kernel is running as
> a guest in a KVM virtual machine.")

The Linux NMI watchdog is something else, it is obtained by programming
a hardware performance counter on every processor.  On Linux,
performance counters raise NMIs.

Paolo

>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  hw/acpi/tco.c          | 2 --
>>  hw/isa/lpc_ich9.c      | 5 -----
>>  include/hw/i386/ich9.h | 1 -
>>  3 files changed, 8 deletions(-)
>>
>> diff --git a/hw/acpi/tco.c b/hw/acpi/tco.c
>> index b4adac8..05b9d7b 100644
>> --- a/hw/acpi/tco.c
>> +++ b/hw/acpi/tco.c
>> @@ -75,8 +75,6 @@ static void tco_timer_expired(void *opaque)
>> =20
>>      if (pm->smi_en & ICH9_PMIO_SMI_EN_TCO_EN) {
>>          ich9_generate_smi();
>> -    } else {
>> -        ich9_generate_nmi();
>>      }
>>      tr->tco.rld =3D tr->tco.tmr;
>>      tco_timer_reload(tr);
>> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
>> index 59930dd..a0866c3 100644
>> --- a/hw/isa/lpc_ich9.c
>> +++ b/hw/isa/lpc_ich9.c
>> @@ -312,11 +312,6 @@ void ich9_generate_smi(void)
>>      cpu_interrupt(first_cpu, CPU_INTERRUPT_SMI);
>>  }
>> =20
>> -void ich9_generate_nmi(void)
>> -{
>> -    cpu_interrupt(first_cpu, CPU_INTERRUPT_NMI);
>> -}
>> -
>>  static int ich9_lpc_sci_irq(ICH9LPCState *lpc)
>>  {
>>      switch (lpc->d.config[ICH9_LPC_ACPI_CTRL] &
>> diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
>> index 18dcca7..673d13d 100644
>> --- a/include/hw/i386/ich9.h
>> +++ b/include/hw/i386/ich9.h
>> @@ -21,7 +21,6 @@ void ich9_lpc_pm_init(PCIDevice *pci_lpc, bool smm_e=
nabled);
>>  I2CBus *ich9_smb_init(PCIBus *bus, int devfn, uint32_t smb_io_base);
>> =20
>>  void ich9_generate_smi(void);
>> -void ich9_generate_nmi(void);
>> =20
>>  #define ICH9_CC_SIZE (16 * 1024) /* 16KB. Chipset configuration regis=
ters */
>> =20
>>
>=20
