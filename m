Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1699AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 21:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D585F20787
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 21:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUCDV+6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D585F20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJO5B-0007gx-2j
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 17:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1jJO3s-00070y-8X
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 17:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1jJO3q-0003Qu-DC
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 17:04:40 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:34524)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1jJO3k-0003KU-LI
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 17:04:33 -0400
Received: by mail-ot1-x330.google.com with SMTP id m2so8898891otr.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 14:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:from:cc:user-agent:to
 :message-id:subject:date;
 bh=pWCXlz1PrUHqii6SGI1YtDTZX3zTur0XvZxPpco7o0k=;
 b=bUCDV+6MSJOUoF+zjEYy17JHGJyuZYRqyP/MEeI4sifLSF7lH6SgzOO+Xj5CitR4u2
 /KtGLgEjDychWJS/B/G+mMrgpuKSNEDz2uiltFtcok3OK6a0zm2QqQbdDNuyfZthMBaW
 ZoWAKtdjsT3q51A1OR+S7HWUhBZv70ZrZ0y3W09f/9ZxAgqhlWBJbg95L5B3XkLHHTYn
 sy3c00dnevXogIzFAN6iakkIWZM5pG2k6W8gI31m1rl1py94nAZvsMKtB7zUL+eWwLAz
 eD0RAZUTd6D9fhshK/iDoOggj6QeX/309sfC0/AyxDOJAe6orOXepJJ1UAsmMgVnVp1C
 PeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding
 :from:cc:user-agent:to:message-id:subject:date;
 bh=pWCXlz1PrUHqii6SGI1YtDTZX3zTur0XvZxPpco7o0k=;
 b=V/rJr3w/adQsiVfU+3ZpP+WddbVobdCPFtPQV0pW60OJop+xrQ6JTTm0LCOLnWUO5c
 U6MC/Cy8LR9bWaisE5DPGOXSHR3H8mVkvecPoY34Kom+X82R2n5ZCaltrm8mlbg1s6rx
 P6Is58hVEOwIm0MvFdZ4mo5olEdKWrPDVueezj+7kQ0mdPIV64Y8AgpHvvQV0/PLXECa
 ylEC1kN5yfXD/qEl7NMf1p+I9QibglQjtyQmyjXGQSe/I5qGCuArzKDXmEzjQsNdm1gD
 bhnRZ4G+JBoJ9Gh2uD303GMoJ2QNk3fiPpi1hr9nwKQ92+CNCOFBppgnCQIVR4shAfk2
 OPVg==
X-Gm-Message-State: ANhLgQ21u2C/OqxdoAML+d/qrFjPYijLOK35dQOvxtQORop3wMyR5ALC
 KR+xfMicG0h4F3JJzPHQb1I=
X-Google-Smtp-Source: ADFU+vvSVhAbn80a6ntVo35HnUdUSffYxendNQPTf4rttmi+gWvzj6q7p0OFvdzylqKWSRfe9hO37Q==
X-Received: by 2002:a4a:e9fc:: with SMTP id w28mr14483113ooc.98.1585688670478; 
 Tue, 31 Mar 2020 14:04:30 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id l188sm28696oib.44.2020.03.31.14.04.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 31 Mar 2020 14:04:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <158568866265.20966.3583703667420924155@sif>
Subject: [ANNOUNCE] QEMU 5.0.0-rc1 is now available
Date: Tue, 31 Mar 2020 16:04:22 -0500
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
second release candidate for the QEMU 5.0 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-5.0.0-rc1.tar.xz
  http://download.qemu-project.org/qemu-5.0.0-rc1.tar.xz.sig

You can help improve the quality of the QEMU 5.0 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/5.0

Please add entries to the ChangeLog for the 5.0 release below:

  http://wiki.qemu.org/ChangeLog/5.0

Thank you to everyone involved!

Changes since rc0:

2833ad487c: Update version for v5.0.0-rc1 release (Peter Maydell)
e82cdba394: vhost-vsock: fix double close() in the realize() error path (St=
efano Garzarella)
1153cf9f5b: qtest: add tulip test case (Li Qiang)
b88fb1247b: hw/net/allwinner-sun8i-emac.c: Fix REG_ADDR_HIGH/LOW reads (Pet=
er Maydell)
8ffb7265af: net: tulip: check frame size and r/w data length (Prasad J Pand=
it)
cca35ac4d1: net/colo-compare.c: Expose "expired_scan_cycle" to users (Zhang=
 Chen)
9cc43c94b3: net/colo-compare.c: Expose "compare_timeout" to users (Zhang Ch=
en)
767cc9a9c1: hw/net/can: Make CanBusClientInfo::can_receive() return a boole=
an (Philippe Mathieu-Daud=C3=A9)
b8c4b67e3e: hw/net: Make NetCanReceive() return a boolean (Philippe Mathieu=
-Daud=C3=A9)
3317db7439: hw/net/rtl8139: Update coding style to make checkpatch.pl happy=
 (Philippe Mathieu-Daud=C3=A9)
2fa3d2d401: hw/net/rtl8139: Simplify if/else statement (Philippe Mathieu-Da=
ud=C3=A9)
0002c3a696: hw/net/smc91c111: Let smc91c111_can_receive() return a boolean =
(Philippe Mathieu-Daud=C3=A9)
205ce5670f: hw/net/e1000e_core: Let e1000e_can_receive() return a boolean (=
Philippe Mathieu-Daud=C3=A9)
f22a57ac09: Fixed integer overflow in e1000e (Andrew Melnychenko)
a43790f2f6: hw/net/i82596.c: Avoid reading off end of buffer in i82596_rece=
ive() (Peter Maydell)
baba731bc6: hw/net/i82596: Correct command bitmask (CID 1419392) (Philippe =
Mathieu-Daud=C3=A9)
b412378785: decodetree: Use Python3 floor division operator (Philippe Mathi=
eu-Daud=C3=A9)
e20cb81d9c: tcg/i386: Fix INDEX_op_dup2_vec (Richard Henderson)
88828bf133: target/arm: fix incorrect current EL bug in aarch32 exception e=
mulation (Changbin Du)
660b4e7042: hw/arm/xlnx-zynqmp.c: Add missing error-propagation code (Peter=
 Maydell)
63fef6287e: hw/arm/xlnx-zynqmp.c: Avoid memory leak in error-return path (P=
eter Maydell)
e22684e34d: docs/conf.py: Raise ConfigError for bad Sphinx Python version (=
Peter Maydell)
34d8df2a1d: hw/misc/allwinner-h3-dramc: enforce 64-bit multiply when calcul=
ating row mirror address (Niek Linnenbank)
c251191eae: hw/arm/orangepi: check for potential NULL pointer when calling =
blk_is_available (Niek Linnenbank)
146902964d: linux-user: Support futex_time64 (Alistair Francis)
17e89077b7: acpi: add acpi=3DOnOffAuto machine property to x86 and arm virt=
 (Gerd Hoffmann)
9d283f85d7: fix vhost_user_blk_watch crash (Li Feng)
32a2d6b1f6: hw/i386/amd_iommu.c: Fix corruption of log events passed to gue=
st (Peter Maydell)
de38ed3007: virtio-iommu: avoid memleak in the unrealize (Pan Nengyuan)
cfaf757edd: virtio-blk: delete vqs on the error path in realize() (Pan Neng=
yuan)
a3ec4bb7e5: acpi: pcihp: fix left shift undefined behavior in acpi_pcihp_ej=
ect_slot() (Igor Mammedov)
0d930b870a: virtio-serial-bus: Plug memory leak on realize() error paths (P=
an Nengyuan)
6d7b25ad6e: MAINTAINERS: Add myself as virtio-balloon co-maintainer (David =
Hildenbrand)
1c3c9a8c5a: checkpatch: enforce process for expected files (Michael S. Tsir=
kin)
84878f4c00: target/mips: Fix loongson multimedia condition instructions (Ji=
axun Yang)
127814629b: configure: Support -static-pie if requested (Richard Henderson)
2c674109c2: configure: Override the os default with --disable-pie (Richard =
Henderson)
e6cbd75158: configure: Unnest detection of -z,relro and -z,now (Richard Hen=
derson)
b26341241b: configure: Always detect -no-pie toolchain support (Richard Hen=
derson)
d2cd29e307: configure: Do not force pie=3Dno for non-x86 (Richard Henderson)
64547a3bb6: tcg: Remove softmmu code_gen_buffer fixed address (Richard Hend=
erson)
ee5195ee0f: configure: Drop adjustment of textseg (Richard Henderson)
cbf4c9ac9c: cmd646-ide: use qdev gpio rather than qemu_allocate_irqs() (Mar=
k Cave-Ayland)
627a445ae0: via-ide: use qdev gpio rather than qemu_allocate_irqs() (Mark C=
ave-Ayland)
b938587569: via-ide: don't use PCI level for legacy IRQs (Mark Cave-Ayland)
d6ef883d9d: hw/ide/sii3112: Use qdev gpio rather than qemu_allocate_irqs() =
(Peter Maydell)
9e58f17270: fdc/i8257: implement verify transfer mode (Sven Schnelle)
df74b1d3df: qcow2: Remove unused fields from BDRVQcow2State (Kevin Wolf)
ce8cabbd17: mirror: Wait only for in-flight operations (Kevin Wolf)
9178f4fe5f: Revert "mirror: Don't let an operation wait for itself" (Kevin =
Wolf)
6fcc859fc2: nvme: Print 'cqid' for nvme_del_cq (Minwoo Im)
7a26df203c: block: fix bdrv_root_attach_child forget to unref child_bs (Vla=
dimir Sementsov-Ogievskiy)
34afc5c298: block/iscsi:use the flags in iscsi_open() prevent Clang warning=
 (Chen Qun)
41e1f0e225: .travis.yml: Add a KVM-only s390x job (Philippe Mathieu-Daud=C3=
=A9)
3e3207337b: tests/docker: Add libepoxy and libudev packages to the Fedora i=
mage (Philippe Mathieu-Daud=C3=A9)
6d8e7738b0: tests/docker: Use Python3 PyYAML in the Fedora image (Philippe =
Mathieu-Daud=C3=A9)
9274ae32c3: tests/docker: Install gcrypt devel package in Debian image (Phi=
lippe Mathieu-Daud=C3=A9)
cdb1a84cfe: tests/docker: Keep package list sorted (Philippe Mathieu-Daud=
=C3=A9)
a092a95547: configure: disable MTTCG for MIPS guests (Alex Benn=C3=A9e)
f01454ad17: tests/vm: fix basevm config (Alex Benn=C3=A9e)
2cc3e591b3: tests/vm: update NetBSD to 9.0 (Gerd Hoffmann)
610bd2cf2f: tests/vm: update FreeBSD to 12.1 (Gerd Hoffmann)
50a06452c7: tests/vm: move vga setup (Gerd Hoffmann)
698a64f948: tests/vm: write raw console log (Gerd Hoffmann)
f4ce3adf6b: qemu/atomic.h: add #ifdef guards for stdatomic.h (Alex Benn=C3=
=A9e)
a507c51790: iotests/138: Test leaks/corruptions fixed report (Max Reitz)
2f8bb28ff0: iotests: Add poke_file_[bl]e functions (Max Reitz)
1656324ec0: qemu-img: Fix check's leak/corruption fix report (Max Reitz)
ed04991063: sheepdog: Consistently set bdrv_has_zero_init_truncate (Eric Bl=
ake)
e7be13ad3f: qcow2: Avoid feature name extension on small cluster size (Eric=
 Blake)
bb40ebce2c: qcow2: List autoclear bit names in header (Eric Blake)
a951a631b9: qcow2: Comment typo fixes (Eric Blake)
5a5e7f8cd8: block: trickle down the fallback image creation function use to=
 the block drivers (Maxim Levitsky)
b92902dfea: block: pass BlockDriver reference to the .bdrv_co_create (Maxim=
 Levitsky)
66c8672d24: block/mirror: fix use after free of local_err (Vladimir Sements=
ov-Ogievskiy)
a52f5f87be: linux-user: Flush out implementation of gettimeofday (Richard H=
enderson)
bf02adcd88: linux-user: Add x86_64 vsyscall page to /proc/self/maps (Richar=
d Henderson)
b26491b4d4: linux-user/i386: Emulate x86_64 vsyscalls (Richard Henderson)
acf768a904: linux-user/i386: Split out gen_signal (Richard Henderson)
628460891d: target/i386: Renumber EXCP_SYSCALL (Richard Henderson)
91e5998f18: linux-user, configure: fix (again) syscall_nr.h dependencies cl=
eanup (Laurent Vivier)
7cd75cbdb8: migration: use "" instead of (null) for tls-authz (Mao Zhongyi)
b4a1733c5e: migration/ram: fix use after free of local_err (Vladimir Sement=
sov-Ogievskiy)
27d07fcfa7: migration/colo: fix use after free of local_err (Vladimir Semen=
tsov-Ogievskiy)
d96c4d5f19: vl.c: fix migration failure for 3.1 and older machine types (Ig=
or Mammedov)
e1cd92d95c: tools/virtiofsd/passthrough_ll: Fix double close() (Philippe Ma=
thieu-Daud=C3=A9)
d4ff109373: hmp/vnc: Fix info vnc list leak (Dr. David Alan Gilbert)
6d1da867e6: tests/migration: Reduce autoconverge initial bandwidth (Philipp=
e Mathieu-Daud=C3=A9)
06b1c6f8b7: xbzrle: update xbzrle doc (Mao Zhongyi)
33ee3d96c7: hmp-cmd: fix a missing_break warning (Pan Nengyuan)
95fad99cb2: hw/audio/fmopl: fix segmentation fault (Volker R=C3=BCmelin)
112c37a6a6: ui/input-linux: Do not ignore ioctl() return value (Philippe Ma=
thieu-Daud=C3=A9)

