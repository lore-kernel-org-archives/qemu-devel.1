Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F319C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CBE6206E9
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vzp8ylC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBE6206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJzx7-0005oc-70
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jJzvt-0004tb-V8
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jJzvs-0008Kl-0s
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:30:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25608
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jJzvr-0008IH-SB
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585834255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DXaa7dBYkhpDdkdhOr2hPd9u9KeJ9YsL4FsvLB37Wgs=;
 b=Vzp8ylC23zNnDG4b+4n+qtQQQKEy30sX0eVLueGpUc9qMYa6GDFsuWqt/1WNBvJwb4T1CU
 1p1yJgE9FNysI6gRKvLihkV+ZMLot1F/M9sricuXigsCsNzQNeeFht9vG4ZE1Pt4/q7fvp
 frwdc42/M23U+I1ZQyC/c5J7sM1cwfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-cV8IducBPHqWOeHRBm1OjQ-1; Thu, 02 Apr 2020 09:30:49 -0400
X-MC-Unique: cV8IducBPHqWOeHRBm1OjQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F1FD107ACCA;
 Thu,  2 Apr 2020 13:30:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22A24DA11A;
 Thu,  2 Apr 2020 13:30:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9442C11385E2; Thu,  2 Apr 2020 15:30:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Function-like macro with the same name as a typedef confuses
 Coccinelle
References: <87k12y5by1.fsf@dusky.pond.sub.org>
 <CAFEAcA8aBjWPVH7VsicTrKce1K-sOh0Sv+Ok-75zbtsJV=OBaA@mail.gmail.com>
Date: Thu, 02 Apr 2020 15:30:46 +0200
In-Reply-To: <CAFEAcA8aBjWPVH7VsicTrKce1K-sOh0Sv+Ok-75zbtsJV=OBaA@mail.gmail.com>
 (Peter Maydell's message of "Thu, 2 Apr 2020 13:21:29 +0100")
Message-ID: <87d08q3th5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 2 Apr 2020 at 13:06, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> I discovered that Vladimir's auto-propagated-errp.cocci leaves
>> hw/arm/armsse.c unchanged, even though it clearly should change it.
>> Running spatch with --debug prints (among lots of other things)
>
>> Clearly, Coccinelle is getting spooked to easily.
>
> Is it worth asking on the coccinelle mailing list about whether
> coccinelle could be made to be less picky in this area ?

I guess we owe them the feedback.  I'll look into minimizing the
reproducer.

>> Regardless, three questions:
>>
>> 1. Are ALL_CAPS typedef names a good idea?  We shout macros to tell
>> readers "beware, possibly magic".  Shouting other stuff as well
>> undermines that.
>>
>> 2. The compiler is quite cool with us using the same name for a
>> function-like macro and a not-function-like non-macro.  But is it a good
>> idea?
>
> Probably not a great idea, and if we really only do it 3 times
> it's not too hard to change I suppose. I think this basically
> arises when the natural name for the struct happens to be all
> uppercase already because the device name is an acronym. We
> don't usually titlecase acronyms in structure names (eg
> we say 'SCSIBus', not 'ScsiBus'), and (legacy exceptions aside)
> we don't usually tack on a trailing 'State' or 'Device'
> to the main device state struct these days -- so if your device's
> natural name is an acronym then the struct ends up all-caps.

Plausible.

> If we don't like all-caps struct names then ideally we'd
> adjust one or the other of those conventions so we have a
> consistent way to avoid them.

I don't like the State suffix, it's four characters carrying zero bits
of information.  The Device suffix at least tells me it's (supposedly)
an instance of TYPE_DEVICE.

I'd prefer title-casing acronyms when needed to avoid confusion with
macros.

> For 'ARMSSE' we could I suppose rename it 'ArmSSE', which would
> be in line with current corporate branding but out of line with
> most of the other places we use 'ARM' in a struct name :-)

Pick your poison :)

> Q: how many all-upper-case typedefs do we have in total (whether
> they have a clashing macro or not)? Your argument 1 would
> suggest we should look to change them all, not merely the ones
> Coccinelle trips over.

$ egrep -c '^[A-Z_]+\s+typedef' cxref
116
$ egrep '^[A-Z_]+\s+typedef' cxref=20
ACPIGPE          typedef     107 include/hw/acpi/acpi.h typedef struct ACPI=
GPE ACPIGPE;
ACPIREGS         typedef     108 include/hw/acpi/acpi.h typedef struct ACPI=
REGS ACPIREGS;
AES_KEY          typedef      11 include/crypto/aes.h typedef struct aes_ke=
y_st AES_KEY;
AHCI_SG          typedef     292 hw/ide/ahci_internal.h } QEMU_PACKED AHCI_=
SG;
ARMCPU           typedef      57 target/arm/cpu-qom.h typedef struct ARMCPU=
 ARMCPU;
ARMSSE           typedef     218 include/hw/arm/armsse.h } ARMSSE;
ARMSSECPUID      typedef      39 include/hw/misc/armsse-cpuid.h } ARMSSECPU=
ID;
ARMSSEMHU        typedef      42 include/hw/misc/armsse-mhu.h } ARMSSEMHU;
BD               typedef     147 hw/audio/ac97.c  } BD;
BIOS_TABLES_TEST typedef      77 tests/uefi-test-tools/UefiTestToolsPkg/Inc=
lude/Guid/BiosTablesTest.h } BIOS_TABLES_TEST;
CCID_BULK_IN     typedef     190 hw/usb/dev-smartcard-reader.c } CCID_BULK_=
IN;
CD               typedef     490 hw/arm/smmuv3-internal.h } CD;
CHS              typedef     515 tests/qtest/hd-geo-test.c } CHS;
CHST             typedef      49 tests/qtest/hd-geo-test.c } CHST;
CIW              typedef      40 include/hw/s390x/css.h } QEMU_PACKED CIW;
CMB              typedef      64 include/hw/s390x/css.h } QEMU_PACKED CMB;
CMBE             typedef      77 include/hw/s390x/css.h } QEMU_PACKED CMBE;
CMSDKAPBTIMER    typedef      37 include/hw/timer/cmsdk-apb-timer.h } CMSDK=
APBTIMER;
CMSDKAPBUART     typedef      45 include/hw/char/cmsdk-apb-uart.h } CMSDKAP=
BUART;
CMS_VTOC         typedef     188 pc-bios/s390-ccw/bootmap.h } __attribute__=
 ((packed)) CMS_VTOC;
CORE_ADDR        typedef    1647 disas/hppa.c     typedef unsigned int CORE=
_ADDR;
CPUTLB           typedef     222 include/exec/cpu-defs.h } CPUTLB;
CPUTLB           typedef     230 include/exec/cpu-defs.h typedef struct CPU=
TLB { } CPUTLB;
CRISCPU          typedef      53 target/cris/cpu-qom.h typedef struct CRISC=
PU CRISCPU;
CRW              typedef     201 include/hw/s390x/ioinst.h } CRW;
CURLAIOCB        typedef      97 block/curl.c     } CURLAIOCB;
DMAAIOCB         typedef      85 dma-helpers.c    } DMAAIOCB;
EHCI_STATES      typedef      69 hw/usb/hcd-ehci.c } EHCI_STATES;
FIS              typedef     355 tests/qtest/libqos/ahci.h } __attribute__(=
(__packed__)) FIS;
FM_OPL           typedef      90 hw/audio/fmopl.h } FM_OPL;
FPCR             typedef      41 linux-user/arm/nwfpe/fpsr.h typedef unsign=
ed int FPCR; /* type for floating point control register */
FPREG            typedef      56 linux-user/arm/nwfpe/fpa11.h } FPREG;
FPSR             typedef      40 linux-user/arm/nwfpe/fpsr.h typedef unsign=
ed int FPSR; /* type for floating point status register */
GA_WTSINFOA      typedef    1955 qga/commands-win32.c } GA_WTSINFOA;
GO               typedef     110 include/hw/s390x/event-facility.h } QEMU_P=
ACKED GO;
GUID             typedef      18 contrib/elf2dmp/pdb.h } GUID;
HPPACPU          typedef      50 target/hppa/cpu-qom.h typedef struct HPPAC=
PU HPPACPU;
IDEDMA           typedef      24 include/hw/ide/internal.h typedef struct I=
DEDMA IDEDMA;
IMAGE_DATA_DIRECTORY typedef      48 contrib/elf2dmp/pe.h } __attribute__ (=
(packed)) IMAGE_DATA_DIRECTORY;
IMAGE_DEBUG_DIRECTORY typedef     100 contrib/elf2dmp/pe.h } __attribute__ =
((packed)) IMAGE_DEBUG_DIRECTORY;
IMAGE_DOS_HEADER typedef      33 contrib/elf2dmp/pe.h } __attribute__ ((pac=
ked)) IMAGE_DOS_HEADER;
IMAGE_FILE_HEADER typedef      43 contrib/elf2dmp/pe.h } __attribute__ ((pa=
cked)) IMAGE_FILE_HEADER;
IPMIBT           typedef      66 include/hw/ipmi/ipmi_bt.h } IPMIBT;
IPMIKCS          typedef      69 include/hw/ipmi/ipmi_kcs.h } IPMIKCS;
IRB              typedef     132 include/hw/s390x/ioinst.h } IRB;
IRQMP            typedef      64 hw/intc/grlib_irqmp.c } IRQMP;
LDL_VTOC         typedef     156 pc-bios/s390-ccw/bootmap.h } __attribute__=
 ((packed)) LDL_VTOC;
LI               typedef      91 include/libdecnumber/decNumberLocal.h type=
def long int LI; /* for printf arguments only */
MDB              typedef     126 include/hw/s390x/event-facility.h } QEMU_P=
ACKED MDB;
MDBO             typedef     121 include/hw/s390x/event-facility.h } QEMU_P=
ACKED MDBO;
MDMSU            typedef     157 include/hw/s390x/event-facility.h } QEMU_P=
ACKED MDMSU;
MIPSCPU          typedef      55 target/mips/cpu-qom.h typedef struct MIPSC=
PU MIPSCPU;
MSGUID           typedef      81 block/vhdx.h     } MSGUID;
MTO              typedef      97 include/hw/s390x/event-facility.h } QEMU_P=
ACKED MTO;
NCQFIS           typedef     451 tests/qtest/libqos/ahci.h } __attribute__(=
(__packed__)) NCQFIS;
NFSRPC           typedef      76 block/nfs.c      } NFSRPC;
OPL_CH           typedef      54 hw/audio/fmopl.h } OPL_CH;
OPL_SLOT         typedef      38 hw/audio/fmopl.h }OPL_SLOT;
OPL_TIMERHANDLER typedef       5 hw/audio/fmopl.h typedef void (*OPL_TIMERH=
ANDLER)(void *param, int channel, double interval_Sec);
ORB              typedef     142 include/hw/s390x/ioinst.h } ORB;
PDB_DS_HEADER    typedef      34 contrib/elf2dmp/pdb.h } PDB_DS_HEADER;
PDB_DS_ROOT      typedef      48 contrib/elf2dmp/pdb.h } PDB_DS_ROOT;
PDB_DS_TOC       typedef      39 contrib/elf2dmp/pdb.h } PDB_DS_TOC;
PDB_STREAM_INDEXES typedef     193 contrib/elf2dmp/pdb.h } PDB_STREAM_INDEX=
ES;
PDB_STREAM_INDEXES_OLD typedef     179 contrib/elf2dmp/pdb.h } PDB_STREAM_I=
NDEXES_OLD;
PDB_SYMBOLS      typedef     170 contrib/elf2dmp/pdb.h } PDB_SYMBOLS;
PDB_SYMBOLS_OLD  typedef     149 contrib/elf2dmp/pdb.h } PDB_SYMBOLS_OLD;
PDB_SYMBOL_FILE  typedef     110 contrib/elf2dmp/pdb.h } PDB_SYMBOL_FILE;
PDB_SYMBOL_FILE_EX typedef     124 contrib/elf2dmp/pdb.h } PDB_SYMBOL_FILE_=
EX;
PDB_SYMBOL_IMPORT typedef     138 contrib/elf2dmp/pdb.h } PDB_SYMBOL_IMPORT=
;
PDB_SYMBOL_RANGE typedef      85 contrib/elf2dmp/pdb.h } PDB_SYMBOL_RANGE;
PDB_SYMBOL_RANGE_EX typedef      97 contrib/elf2dmp/pdb.h } PDB_SYMBOL_RANG=
E_EX;
PDB_SYMBOL_SOURCE typedef     130 contrib/elf2dmp/pdb.h } PDB_SYMBOL_SOURCE=
;
PDB_TYPES        typedef      75 contrib/elf2dmp/pdb.h } PDB_TYPES;
PDB_TYPES_OLD    typedef      57 contrib/elf2dmp/pdb.h } PDB_TYPES_OLD;
PMCW             typedef      98 include/hw/s390x/ioinst.h } PMCW;
PRD              typedef     473 tests/qtest/libqos/ahci.h } __attribute__(=
(__packed__)) PRD;
PSW              typedef      17 pc-bios/s390-ccw/s390-arch.h } __attribute=
__ ((aligned(8))) PSW;
PSW              typedef      46 target/s390x/cpu.h } PSW;
PTR              typedef      12 include/disas/dis-asm.h typedef void *PTR;
QEDAIOCB         typedef     150 block/qed.h      } QEDAIOCB;
QEMUBH           typedef      97 include/qemu/typedefs.h typedef struct QEM=
UBH QEMUBH;
QEMUFIFO         typedef      68 ui/console.c     } QEMUFIFO;
QFWCFG           typedef      18 tests/qtest/libqos/fw_cfg.h typedef struct=
 QFWCFG QFWCFG;
QJSON            typedef     109 include/qemu/typedefs.h typedef struct QJS=
ON QJSON;
QOHCI_PCI        typedef      17 tests/qtest/usb-hcd-ohci-test.c typedef st=
ruct QOHCI_PCI QOHCI_PCI;
QSDHCI           typedef      25 tests/qtest/libqos/sdhci.h typedef struct =
QSDHCI QSDHCI;
QSDHCI_PCI       typedef      27 tests/qtest/libqos/sdhci.h typedef struct =
QSDHCI_PCI QSDHCI_PCI;
QSDHCI_PCI       typedef      28 tests/qtest/libqos/x86_64_pc-machine.c typ=
edef struct QSDHCI_PCI QSDHCI_PCI;
RADOSCB          typedef      99 block/rbd.c      } RADOSCB;
RBDAIOCB         typedef      91 block/rbd.c      } RBDAIOCB;
RING_IDX         typedef      52 include/hw/xen/interface/io/ring.h typedef=
 unsigned int RING_IDX;
RISCVCPU         typedef     275 target/riscv/cpu.h } RISCVCPU;
RXCPU            typedef     118 target/rx/cpu.h  typedef struct RXCPU RXCP=
U;
SCCB             typedef      65 pc-bios/s390-ccw/sclp.h } __attribute__((p=
acked)) SCCB;
SCCB             typedef     181 include/hw/s390x/sclp.h } QEMU_PACKED SCCB=
;
SCHIB            typedef     124 include/hw/s390x/ioinst.h } QEMU_PACKED SC=
HIB;
SCSW             typedef      28 include/hw/s390x/ioinst.h } SCSW;
SDBFIS           typedef     389 hw/ide/ahci_internal.h } QEMU_PACKED SDBFI=
S;
SPARCCPU         typedef      56 target/sparc/cpu-qom.h typedef struct SPAR=
CCPU SPARCCPU;
STE              typedef     485 hw/arm/smmuv3-internal.h } STE;
SWIM             typedef      75 include/hw/block/swim.h } SWIM;
TCR              typedef     164 target/arm/cpu.h } TCR;
TPMPPI           typedef      21 hw/tpm/tpm_ppi.h } TPMPPI;
TZMPC            typedef      43 include/hw/misc/tz-mpc.h typedef struct TZ=
MPC TZMPC;
TZMSC            typedef      77 include/hw/misc/tz-msc.h } TZMSC;
TZPPC            typedef      75 include/hw/misc/tz-ppc.h typedef struct TZ=
PPC TZPPC;
UART             typedef      94 hw/char/grlib_apbuart.c } UART;
UHCI_QH          typedef     156 hw/usb/hcd-uhci.c } UHCI_QH;
UHCI_TD          typedef     151 hw/usb/hcd-uhci.c } UHCI_TD;
URI              typedef      77 include/qemu/uri.h } URI;
VFIOBAR          typedef      56 hw/vfio/pci.h    } VFIOBAR;
VFIOVGA          typedef      69 hw/vfio/pci.h    } VFIOVGA;
VXHSAIOCB        typedef      47 block/vxhs.c     } VXHSAIOCB;
XENCONS_RING_IDX typedef      30 include/hw/xen/interface/io/console.h type=
def uint32_t XENCONS_RING_IDX;
XHCITRB          typedef     144 hw/usb/hcd-xhci.c } XHCITRB;


