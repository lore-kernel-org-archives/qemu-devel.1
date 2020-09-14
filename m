Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,DRUGS_ERECTILE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MORE_SEX,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F224C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A5A21548
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYizEkT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A5A21548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHioF-0007A2-CF
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHikW-0008Io-Py
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:18:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48392
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHikS-000258-53
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600067879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OedqaSrMbC/g7nsuHcpHvPKTfIEqNmmOhsXzluS4k+4=;
 b=fYizEkT6ZYaUAXbgTxOTg9dBuKkavbVfGpSuUhTbiKWLVvyIBDD2n5EVjnejmFacZduQ/v
 4Hhu8GeNqsPcHTVodKyVHfXOsE5xEoAkcKlA8qnaeTtza9u+mTi6ZW/48XTEmoCrqjXede
 Yy9pdd9qqh4ny5mcFq8u4Z+ZwbN0zHE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-bpCgXOTwPhe31i_WzDbDDQ-1; Mon, 14 Sep 2020 03:17:51 -0400
X-MC-Unique: bpCgXOTwPhe31i_WzDbDDQ-1
Received: by mail-wr1-f69.google.com with SMTP id r16so6497803wrm.18
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 00:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OedqaSrMbC/g7nsuHcpHvPKTfIEqNmmOhsXzluS4k+4=;
 b=Ny740IYtDitCZkAbVyFLfCo2A5xBxCxXZ7XXn2mk91rGDHOicBtRttdBkhob36VcJ9
 cZfbf5wWAXm+KinDb67TDiMLY31mSJTC+0tWfgmg9KjTCMlPEGU0aYVIOLUuIsYkjiPc
 ZJypnVtcoG43a+BGu5ECJmNLROezucBh24x0sQxJgD1RkWJYpBfbdW6i5vNMyy5GoS6S
 Zsa9ItWeCv2yhMt8Q5UDajW+wjR+ZsudEw6XzTUUklKI2vvGsgWLzas/pxVNhu7u2oJ4
 I1CkpxsZbkv8O+jL/LpDw+g/nlvC8GBDA+BOEoL8N/TxoudRxwjiJsicnkxrs/WZfNpp
 IxzQ==
X-Gm-Message-State: AOAM532js0Fb6/MnWHDc4+6+uy3pATPd3GGoKt+2ItyXK/3ml84bXoDm
 cY5xCUn40eWNGQkcRqZHpmFe4khvRboGttkVg6fKlO0bRE+HOdwbA5u+zep39dYp1tTytUphCXh
 ViyuiUkMdl+ukAOo=
X-Received: by 2002:a05:600c:204e:: with SMTP id
 p14mr13083923wmg.182.1600067868879; 
 Mon, 14 Sep 2020 00:17:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8UWDLZERiQ7AHtH/5Hh5CCo1AR6k4cSUfS+zJPQnry6ouAgLVXyR2Gb//dCY+MICKYDvtXQ==
X-Received: by 2002:a05:600c:204e:: with SMTP id
 p14mr13083819wmg.182.1600067867245; 
 Mon, 14 Sep 2020 00:17:47 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id l19sm17604634wmi.8.2020.09.14.00.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 00:17:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/10] roms/edk2: update submodule from edk2-stable201905 to
 edk2-stable202008
Date: Mon, 14 Sep 2020 09:17:15 +0200
Message-Id: <20200914071720.1099898-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914071720.1099898-1-philmd@redhat.com>
References: <20200914071720.1099898-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.006
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:39:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 DRUGS_ERECTILE=1.994, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laszlo Ersek <lersek@redhat.com>

Update the edk2 submodule from release edk2-stable201905 to
edk2-stable202008. The release notes can be read at

  https://github.com/tianocore/edk2/releases/tag/edk2-stable201908
  https://github.com/tianocore/edk2/releases/tag/edk2-stable201911
  https://github.com/tianocore/edk2/releases/tag/edk2-stable202002
  https://github.com/tianocore/edk2/releases/tag/edk2-stable202005
  https://github.com/tianocore/edk2/releases/tag/edk2-stable202008

The update brings in a new submodule (cmocka), and replaces three bundled
libraries with submodules (one instance of Oniguruma and two instances of
Brotli):

- 0eb522987fcd ("UnitTestFrameworkPkg/Library: Add library instances",
  2020-02-07) [edk2-stable202002]

- 48b6c60cc6a2 ("MdeModulePkg/RegularExpressionDxe: Make oniguruma a
  submodule in edk2.", 2020-04-13) [edk2-stable202005]

- 58802e02c41b ("MdeModulePkg/BrotliCustomDecompressLib: Make brotli a
  submodule", 2020-04-16) [edk2-stable202005]

- 06033f5abad3 ("BaseTools: Make brotli a submodule", 2020-04-16)
  [edk2-stable202005]

Our firmware binaries include code from none of these, therefore we're not
going to modify the "licenses" list in "roms/Makefile.edk2".
(Consequently, "pc-bios/edk2-licenses.txt" will not change either).

Shortlog below (using the mailmap updates posted at
<http://mid.mail-archive.com/20200907193102.30535-1-lersek@redhat.com> aka
<https://edk2.groups.io/g/devel/message/65096>):

$ git shortlog edk2-stable201905..edk2-stable202008

> Aaron Antone (1):
>       MdeModulePkg/ConSplitterDxe: Optimize the ConSplitterTextOutSetMode
>
> Abdul Lateef Attar (1):
>       MdeModulePkg: Sets the Cursor to selected BootOption.
>
> Abner Chang (39):
>       MdeModulePkg: Update to support SmBios 3.3.0
>       MdePkg/Include: Update to support SmBios 3.3.0
>       ShellPkg/UefiShellDebug1CommandsLib: Update to support SmBios 3.3.0
>       FatPkg: Add RISC-V architecture for EDK2 CI.
>       FmpDevicePkg: Add RISC-V architecture for EDK2 CI.
>       NetworkPkg: Add RISC-V architecture for EDK2 CI.
>       NetworkPkg/HttpBootDxe: Add RISC-V architecture for EDK2 CI.
>       CryptoPkg: Add RISC-V architecture for EDK2 CI.
>       MdePkg/Include: Add RISC-V related definitions EDK2 CI.
>       SecurityPkg: Security package changes for RISC-V EDK2 CI.
>       ShellPkg: Shell package changes for RISC-V EDK2 CI.
>       UnitTestFrameworkPkg: Add RISC-V architecture for RISC-V EDK2 CI.
>       MdeModulePkg: Use LockBoxNullLib for RISC-V
>       .python/SpellCheck: Add "RISCV" to "words" section
>       BaseTools: BaseTools changes for RISC-V platform.
>       BaseTools: BaseTools changes for RISC-V platform.
>       BaseTools: BaseTools changes for RISC-V platform.
>       BaseTools: Enable RISC-V architecture for RISC-V EDK2 CI.
>       .azurepipelines: Add RISC-V architecture on RISC-V EDK2 CI.
>       .pytool: Add RISC-V architecture on RISC-V EDK2 CI.
>       MdePkg: Add RISC-V RISCV64 binding
>       MdePkg/Include: RISC-V definitions.
>       MdePkg/BaseLib: BaseLib for RISCV64 architecture
>       MdePkg/BaseCacheMaintenanceLib: RISC-V cache maintenance implementation.
>       MdePkg/BaseIoLibIntrinsic: Rename IoLibArm.c=>IoLibNoIo.c
>       MdePkg/BasePeCoff: Add RISC-V PE/Coff related code.
>       MdePkg/BaseCpuLib: RISC-V Base CPU library implementation.
>       MdePkg/BaseSynchronizationLib: RISC-V cache related code.
>       MdePkg/BaseSafeIntLib: Add RISCV64 arch for BaseSafeIntLib.
>       MdeModulePkg/Logo:Add RISCV64 architecture
>       MdeModulePkg/CapsuleRuntimeDxe: Add RISCV64 architecture
>       MdeModulePkg/DxeIplPeim : RISC-V platform level DxeIPL
>       NetworkPkg: Add RISCV64 architecture
>       BaseTools: Add external definitions for RISC-V assembly build
>       BaseTools/PeCoffLoaderEx: Remove the unused local variable
>       BaseLib:Fix RISC-V Supervisor mode (S-Mode) trap handler reentry issue.
>       CryptoPkg/Library: Remove the redundant build option
>       EmbeddedPkg/libfdt: Add strncmp macro to use AsciiStrnCmp
>       MdePkg/Include: Add missing definition of SMBIOS type 42h in SmBios.h
>
> Agrawal, Sachin (1):
>       MdeModulePkg/Ufs: Fix UFS flag read from Query Resp UPIU
>
> Albecki, Mateusz (24):
>       MdeModulePkg/UfsPassThruDxe: Refactor UFS device presence detection
>       MdeModulePkg/UfsPassThruDxe: Fix unaligned data transfer handling
>       MdeModulePkg/SdMmcOverride: Add GetOperatingParam notify phase
>       MdeModulePkg/SdMmcHcDxe: Implement revision 3 of SdMmcOverrideProtocol
>       MdeModulePkg: Add definition of the EDKII_UFS_HC_PLATFORM_PROTOCOL
>       MdeModulePkg/UfsPassThruDxe: Refactor UfsExecUicCommand function
>       MdeModulePkg/UfsPassThruDxe: Refactor private data to use UfsHcInfo
>       MdeModulePkg/UfsPassThruDxe: Implement EDKII_UFS_HC_PLATFORM_PROTOCOL
>       MdeModulePkg/SdMmcPciHcDxe: Remove clock stop from HS200 switch
>       MdeModulePkg/SdMmcPciHcDxe: Fix bus timing switch sequence
>       MdeModulePkg/SdMmcPciHcDxe: Fix SdMmcMmcLegacy bus timing handling
>       MdeModulePkg/SdMmcPciHcDxe: Hook SwitchClockFreq after SD clock start
>       MdeModulePkg/SdMmcPciHcDxe: Add function to start SD clock
>       MdeModulePkg/SdMmcPciHcDxe: Fix unknown doxygen tag error
>       MdeModulePkg/SdMmcPciHcDxe: Fix DAT lane SW reset
>       MdeModulePkg/SdMmcPciHcDxe: Refactor command error detection
>       MdeModulePkg/SdMmcPciHcDxe: Add retries for sync commands
>       MdeModulePkg/SdMmcPciHcDxe: Add retries for async commands
>       MdeModulePkg/SdMmcPciHcDxe: Send SEND_STATUS at lower frequency
>       MdeModulePkg/SdMmcPciHcDxe: Enhance driver traces
>       MdeModulePkg/SdMmcPciHcDxe: Read response on command completion
>       MdeModulePkg/SdMmcPciHcDxe: Refactor data transfer completion
>       MdeModulePkg/SdMmcPciHcDxe: Do not map memory for non DMA transfer
>       MdeModulePkg/SdMmcPciHcDxe: Fix PIO transfer mode
>
> Alex James (1):
>       MdePkg: Use __builtin_offset with CLANGPDB toolchain
>
> Alexander Graf (1):
>       ArmPlatformPkg: Actually disable PL031 interrupts
>
> Amol N Sukerkar (4):
>       CryptoPkg: Add CryptoPkg Token Space GUID
>       CryptoPkg/BaseHashApiLib: Implement Unified Hash Calculation API
>       CryptoPkg/BaseHashApiLib: Align BaseHashApiLib with TPM 2.0 Implementation
>       CryptoPkg/BaseHashApiLib: Change PcdHashApiLibPolicy type to FixedAtBuild
>
> Andrei Warkentin (1):
>       ArmPlatformPkg/PrePi: fix IS_XIP
>
> Andrew Fish (7):
>       EmulatorPkg/Unix/Host: Disable inline/optimizations for XCODE5
>       EmulatorPkg: Fix XCODE5 lldb issues
>       EmulatorPkg/Unix/Host: Initialize field in BerkeleyPacketFilter.c
>       EmulatorPkg/Unix/Host: Remove debug code from BerkeleyPacketFilter.c
>       EmulatorPkg: Disable TftpDynamicCommand and LogoDxe for XCODE5
>       EmulatorPkg/Sec: Change scope of PpiArray[10]
>       BaseTools/tools_def.template: Add -gdwarf to XCODE5 X64
>
> Anthony PERARD (46):
>       MdeModulePkg: Introduce EDKII_SERIAL_PORT_LIB_VENDOR_GUID
>       ArmVirtPkg/PlatformBootManagerLib: Use EDKII_SERIAL_PORT_LIB_VENDOR_GUID
>       ArmPkg/PlatformBootManagerLib: Use EDKII_SERIAL_PORT_LIB_VENDOR_GUID from MdeModulePkg
>       UefiPayloadPkg/PlatformBootManagerLib: Use EDKII_SERIAL_PORT_LIB_VENDOR_GUID from MdeModulePkg
>       OvmfPkg/XenBusDxe: Close XenIoProtocol openned by children
>       OvmfPkg/XenBusDxe: Don't call DisconnectController in Stop()
>       OvmfPkg/ResetSystemLib: Add missing dependency on PciLib
>       OvmfPkg: Create platform OvmfXen
>       OvmfPkg: Introduce XenResetVector
>       OvmfPkg: Introduce XenPlatformPei
>       OvmfPkg/OvmfXen: Creating an ELF header
>       OvmfPkg/XenResetVector: Add new entry point for Xen PVH
>       OvmfPkg/XenResetVector: Saving start of day pointer for PVH guests
>       OvmfPkg/XenResetVector: Allow jumpstart from either hvmloader or PVH
>       OvmfPkg/OvmfXen: use a TimerLib instance that depends only on the CPU
>       OvmfPkg/XenPlatformPei: Detect OVMF_INFO from hvmloader
>       OvmfPkg/XenPlatformPei: Use mXenHvmloaderInfo to get E820
>       OvmfPkg/XenPlatformPei: Grab RSDP from PVH guest start of day struct
>       OvmfPkg/Library/XenPlatformLib: New library
>       OvmfPkg/AcpiPlatformDxe: Use XenPlatformLib
>       OvmfPkg/AcpiPlatformDxe: Use Xen PVH RSDP if it exist
>       OvmfPkg/XenHypercallLib: Enable it in PEIM
>       OvmfPkg/XenPlatformPei: Reinit XenHypercallLib
>       OvmfPkg/XenPlatformPei: Introduce XenHvmloaderDetected
>       OvmfPkg/XenPlatformPei: Setup HyperPages earlier
>       OvmfPkg/XenPlatformPei: Introduce XenPvhDetected
>       OvmfPkg: Import XENMEM_memory_map hypercall to Xen/memory.h
>       OvmfPkg/XenPlatformPei: no hvmloader: get the E820 table via hypercall
>       OvmfPkg/XenPlatformPei: Rework memory detection
>       OvmfPkg/XenPlatformPei: Reserve VGA memory region, to boot Linux
>       OvmfPkg/XenPlatformPei: Ignore missing PCI Host Bridge on Xen PVH
>       OvmfPkg/XenPlatformLib: Cache result for XenDetected
>       OvmfPkg/PlatformBootManagerLib: Use XenDetected from XenPlatformLib
>       OvmfPkg/PlatformBootManagerLib: Handle the absence of PCI bus on Xen PVH
>       OvmfPkg/OvmfXen: Override PcdFSBClock to Xen vLAPIC timer frequency
>       OvmfPkg/OvmfXen: Introduce XenTimerDxe
>       OvmfPkg/PlatformBootManagerLib: Use a Xen console for ConOut/ConIn
>       OvmfPkg: Introduce PcdXenGrantFrames
>       OvmfPkg: Introduce XenIoPvhDxe to initialize Grant Tables
>       OvmfPkg: Move XenRealTimeClockLib from ArmVirtPkg
>       OvmfPkg/OvmfXen: use RealTimeClockRuntimeDxe from EmbeddedPkg
>       OvmfPkg/OvmfXen: Remove DEBUG_ON_SERIAL_PORT
>       OvmfPkg/PlatformDebugLibIoPort: Reword QEMU to hypervisor
>       OvmfPkg/PlatformDebugLibIoPort: factor out debug port detection
>       OvmfPkg/PlatformDebugLibIoPort: Introduce a Nocheck variant
>       OvmfPkg/OvmfXen: Introduce DEBUG_ON_HYPERVISOR_CONSOLE build flag
>
> Antoine Cœur (79):
>       ArmPkg: Fix various typos
>       ArmPlatformPkg: Fix various typos
>       EmbeddedPkg: Fix various typos
>       BaseTools: Fix various typos
>       FmpDevicePkg: Fix various typos
>       Revert "FmpDevicePkg: Fix various typos"
>       IntelFsp2Pkg: Fix various typos
>       FmpDevicePkg: Fix various typos
>       IntelFsp2WrapperPkg: Fix various typos
>       CryptoPkg/OpensslLib: Fix few typos
>       EmbeddedPkg/VirtualKeyboard: Fix few typos
>       EmulatorPkg/Sec: Fix various typos
>       EmulatorPkg/Unix: Fix various typos
>       EmulatorPkg/Win: Fix various typos
>       FatPkg/EnhancedFatDxe: Fix various typos
>       FatPkg/FatPei: Fix few typos
>       MdeModulePkg/Application: Improve French translation
>       MdeModulePkg/Application: Fix various typos
>       MdeModulePkg/Bus/Ata: Fix various typos
>       MdeModulePkg/Bus/I2c: Fix few typos
>       MdeModulePkg/Bus/Isa: Fix various typos
>       MdeModulePkg/Bus/Scsi: Fix various typos
>       MdeModulePkg/Bus/Sd: Fix various typos
>       MdeModulePkg/Core/Pei: Fix various typos
>       MdeModulePkg/Core/PiSmmCore: Fix various typos
>       MdeModulePkg/UsbMass: Fix various typos
>       MdeModulePkg/UsbMouse: Fix few typos
>       MdeModulePkg/UsbBus: Fix various typos
>       MdeModulePkg/Usb: Fix various typos
>       MdePkg/IndustryStandard: Fix various typos
>       MdePkg/Library/Dxe: Fix various typos
>       MdePkg/Library/Pci: Fix various typos
>       MdePkg/Library/Smm: Fix various typos
>       MdePkg/Ppi: Fix various typos
>       MdePkg/Register: Fix various typos
>       NetworkPkg/ArpDxe: Fix various typos
>       NetworkPkg/Dhcp4Dxe: Fix various typos
>       NetworkPkg/Dhcp6Dxe: Fix various typos
>       NetworkPkg/DnsDxe: Fix various typos
>       NetworkPkg/DpcDxe: Fix few typos
>       NetworkPkg/HttpBootDxe: Fix various typos
>       NetworkPkg/HttpDxe: Fix various typos
>       NetworkPkg/Ip4Dxe: Fix various typos
>       NetworkPkg/Ip6Dxe: Fix various typos
>       NetworkPkg/IScsiDxe: Fix various typos
>       NetworkPkg/Library: Fix various typos
>       NetworkPkg/MnpDxe: Fix various typos
>       NetworkPkg/Mtftp4Dxe: Fix various typos
>       NetworkPkg/Mtftp6Dxe: Fix various typos
>       NetworkPkg/SnpDxe: Fix few typos
>       NetworkPkg/TcpDxe/Sock: Fix few typos
>       NetworkPkg/TcpDxe/Tcp: Fix various typos
>       NetworkPkg/Tls: Fix few typos
>       NetworkPkg/Udp4Dxe: Fix various typos
>       NetworkPkg/Udp6Dxe: Fix various typos
>       NetworkPkg/UefiPxeBcDxe: Fix various typos
>       NetworkPkg/VlanConfigDxe: Fix few typos
>       OvmfPkg/Acpi: Fix few typos
>       OvmfPkg/Csm: Fix various typos
>       OvmfPkg/Qemu: Fix various typos
>       OvmfPkg/Virtio: Fix few typos
>       OvmfPkg/Xen: Fix various typos
>       PcAtChipsetPkg: Fix few typos
>       SecurityPkg: Fix few typos
>       SecurityPkg/Hash2DxeCrypto: Fix few typos
>       SecurityPkg/Library/Tpm: Fix various typos
>       SecurityPkg/Tcg: Fix various typos
>       SecurityPkg/VariableAuthenticated: Fix few typos
>       ShellPkg/Application: Fix various typos
>       ShellPkg/DynamicCommand: Fix various typos
>       SignedCapsulePkg: Fix various typos
>       SignedCapsulePkg/Universal: Fix various typos
>       SourceLevelDebugPkg/DebugAgent: Fix various typos
>       SourceLevelDebugPkg/DebugCommunicationLib: Fix various typos
>       SourceLevelDebugPkg: Fix few typos
>       StandaloneMmPkg: Fix few typos
>       UefiCpuPkg/CpuDxe: Fix few typos
>       UefiCpuPkg/PiSmm: Fix various typos
>       UefiCpuPkg/Smm: Fix various typos
>
> Ard Biesheuvel (128):
>       EmbeddedPkg/PrePiLib: remove dead status code reporting code
>       BaseTools/GenFw AARCH64: fix up GOT based relative relocations
>       ArmVirtPkg/ArmVirtPrePiUniCoreRelocatable: revert to PIE linking
>       ShellPkg/ShellPkg.dsc AARCH64: enable stack protector
>       ArmVirtPkg: increase FD/FV size for NOOPT builds
>       StandaloneMmPkg: make package .DSC file build again
>       DynamicTablesPkg: include ARM intrinsics library to fix 32-bit build
>       BaseTools/GenFw AARCH64: disregard ADRP instructions that are patched already
>       EmbeddedPkg/NonCoherentDmaLib: implement support for DMA range limits
>       EmbeddedPkg: implement EDK2 IoMmu protocol wrapping DmaLib
>       Maintainers: assume co-maintainership of StandaloneMmPkg
>       ArmPkg/MmCommunicationDxe: relay architected PI events to MM context
>       OvmfPkg: reorganize TPM2 support in DSC/FDF files
>       OvmfPkg: use HII type PCDs for TPM2 config related variables
>       MdeModulePkg: remove EnterS3WithImmediateWake () from ResetSystemLib
>       PcAtChipsetPkg: remove EnterS3WithImmediateWake () from ResetSystemLib
>       UefiPayloadPkg: remove EnterS3WithImmediateWake () from ResetSystemLib
>       OvmfPkg: remove EnterS3WithImmediateWake () from ResetSystemLib
>       ArmVirtPkg: remove EnterS3WithImmediateWake () from ResetSystemLib
>       ArmPkg/ArmSmcPsciResetSystemLib: remove EnterS3WithImmediateWake ()
>       ArmPlatformPkg/PrePeiCore: enable VFP at startup
>       OvmfPkg/Tcg2ConfigPei: introduce a signalling PPI to depex on
>       ArmVirtPkg/PlatformPeiLib: make PcdLib dependency explicit in .INF
>       ArmVirtPkg/PlatformPeiLib: discover the TPM base address from the DT
>       ArmVirtPkg: implement ArmVirtPsciResetSystemPeiLib
>       ArmVirtPkg/ArmVirtQemu: add ResetSystem PEIM for upcoming TPM2 support
>       ArmVirtPkg/ArmVirtQemu: enable TPM2 support in the PEI phase
>       ArmVirtPkg; avoid DxeTpmMeasurementLib in shared .DSC
>       ArmVirtPkg: unshare TpmMeasurementLib resolution between platforms
>       ArmVirtPkg/ArmVirtQemu: enable the DXE phase TPM2 support module
>       ArmVirtPkg/ArmVirtQemu: enable the TPM2 configuration module
>       ArmVirtPkg/ArmVirtQemu: enable TPM2 based measured boot
>       OvmfPkg: add definition of LINUX_EFI_INITRD_MEDIA_GUID
>       OvmfPkg: add 'initrd' shell command to expose Linux initrd via device path
>       ArmVirtPkg: add the 'initrd' dynamic shell command
>       OvmfPkg: add the 'initrd' dynamic shell command
>       MdeModulePkg/DxeCore: defer PE/COFF emulator registration to StartImage
>       OvmfPkg IA32: add support for loading X64 images
>       OvmfPkg/LinuxInitrdDynamicShellCommand: bail if initrd already exists
>       ArmPkg/MmCommunicationDxe: fix logic bug in DXE driver entrypoint
>       OvmfPkg/LinuxInitrdDynamicShellCommand: fix uninitialized status return
>       ArmPlatformPkg/LcdGraphicsOutputDxe: add missing protocol dependency
>       ArmPlatformPkg/PrePeiCore: replace set/way cache ops with by-VA ones
>       OvmfPkg: add GUID for the QEMU kernel loader fs media device path
>       OvmfPkg: export abstract QEMU blob filesystem in standalone driver
>       OvmfPkg: introduce QemuLoadImageLib library class
>       OvmfPkg: provide a generic implementation of QemuLoadImageLib
>       ArmVirtPkg: incorporate the new QEMU kernel loader driver and library
>       ArmVirtPkg/PlatformBootManagerLib: switch to separate QEMU loader
>       OvmfPkg/QemuKernelLoaderFsDxe: don't expose kernel command line
>       OvmfPkg/QemuKernelLoaderFsDxe: add support for the kernel setup block
>       OvmfPkg: create protocol and GUID header for loaded x86 Linux kernels
>       OvmfPkg: implement QEMU loader library for X86 with legacy fallback
>       OvmfPkg: add new QEMU kernel image loader components
>       OvmfPkg/PlatformBootManagerLib: switch to QemuLoadImageLib
>       OvmfPkg/QemuKernelLoaderFsDxe: add support for new Linux initrd device path
>       OvmfPkg: use generic QEMU image loader for secure boot enabled builds
>       ArmPlatformPkg/PrePi: replace set/way cache ops with by-VA ones
>       ArmPkg/ArmMmuLib ARM: remove dummy constructor
>       ArmPkg/ArmMmuLib ARM: split ArmMmuLibCore.c into core and update code
>       ArmPkg/ArmMmuLib ARM: use AllocateAlignedPages() for alignment
>       ArmPkg/ArmMmuLib ARM: cache-invalidate initial page table entries
>       ArmPkg/ArmMmuLib AARCH64: cache-invalidate initial page table entries
>       ArmPkg/ArmLib: move set/way helper functions into private header
>       ArmPkg/ArmLib: clean up library includes
>       ArmPkg/ArmLib: remove bogus protocol declaration
>       ArmPkg/ArmLib: ASSERT on set/way cache ops being used with MMU on
>       ArmPkg/ArmMmuLib ARM: simplify assignment of TTBR0 system register
>       ArmPkg/ArmMmuLib ARM: drop memory type check for page tables
>       OvmfPkg/OvmfXen: fix build by providing QemuLoadImageLib resolution
>       OvmfPkg/QemuKernelLoaderFsDxe: drop tentative const object definition
>       ArmPkg/ArmMmuLib AARCH64: rewrite page table code
>       ArmPkg/ArmMmuLib AARCH64: invalidate page tables before populating them
>       ArmPkg/ArmMmuLib AARCH64: drop pointless page table memory type check
>       ArmPkg/ArmMmuLib AARCH64: cosmetic fixups
>       OvmfPkg/X86QemuLoadImageLib: add dummy assignment to work around GCC
>       ArmVirtPkg/PlatformPeiLib: add dummy assignment to work around older GCC
>       ArmPkg/ArmMmuLib AARCH64: limit recursion when freeing page tables
>       ArmPkg/ArmMmuLib AARCH64: use helpers to determine table entry types
>       ArmPkg/ArmMmuLib AARCH64: preserve attributes when replacing a table entry
>       OvmfPkg/GenericQemuLoadImageLib: Fix VS2019 UINT32 conversion error
>       Maintainers: switch to my Arm email address
>       ArmPkg/CpuDxe: use private copy of GetRootTranslationTableInfo()
>       ArmPkg/CpuDxe: move PageAttributeToGcdAttribute() out of ArmMmuLib
>       ArmPkg/ArmMmuLib: drop pointless LookupAddresstoRootTable() routine
>       ArmPkg/ArmMmuLib: get rid of GetRootTranslationTableInfo()
>       ArmPkg/ArmMmuLib: drop unused TT_ATTR_INDX_INVALID CPP macro
>       OvmfPkg: remove handling of properties table
>       MdeModulePkg: disable properties table generation but retain the code
>       MdePkg: remove PropertiesTable GUID
>       MdeModulePkg/DxeCore: merge properties table routines into MAT handling
>       MdeModulePkg/DeviceManagerUiLib: connect all before creating menu page
>       EmbeddedPkg: rename gEfiMmcHostProtocolGuid to gEmbeddedMmcHostProtocolGuid
>       EmbeddedPkg: remove DwEmmcDxe host controller driver
>       EmbeddedPkg: remove Lan91x network controller driver
>       EmbeddedPkg: remove Lan9118 network controller driver
>       EmbeddedPkg: remove SiI3132 SATA controller driver
>       EmbeddedPkg: remove ISP 1716 USB host controller driver
>       ArmPlatformPkg: remove PL180 SD controller driver
>       EmbeddedPkg/EmbeddedPkg.dsc: remove some stale component references
>       MdePkg: introduce MM communicate 2 protocol
>       MdeModulePkg/SmmIpl: expose MM communicate 2 protocol
>       ArmPkg/MmCommunicationDxe: expose MM Communicate 2 protocol
>       MdeModulePkg/VariableInfo: switch to MM communicate 2 protocol
>       MdeModulePkg/FaultTolerantWriteSmmDxe: switch to MM communicate 2
>       MdeModulePkg/VariableSmmRuntimeDxe: switch to MM communicate 2
>       StandaloneMmPkg: switch to MM communicate 2 protocol
>       ArmPkg/CompilerIntrinsicsLib: provide atomics intrinsics
>       ArmPkg/PlatformBootManagerLib: use static assertion for console type
>       ArmPkg/PlatformBootManagerLib: reject 'default' parity and stop bit count
>       ArmPkg/ArmPkg.dsc: set terminal type PCD to the right value
>       ArmPkg/PlatformBootManagerLib: connect non-discoverable USB hosts
>       ArmPkg/PlatformBootManagerLib: register 's' as UEFI Shell hotkey
>       ArmPkg/PlatformBootManagerLib: fall back to the UiApp on boot failure
>       MdeModulePkg/BootManagerUiLib: show inactive boot options
>       ArmPkg/PlatformBootManagerLib: hide UEFI Shell as a regular boot option
>       ArmPkg/PlatformBootManagerLib: don't connect all devices on each boot
>       ArmVirtPkg: add FDF rule for self-relocating PrePi
>       ArmVirtPkg/PrePi: use standard PeCoff routines for self-relocation
>       ArmVirtPkg: remove unused files
>       MdePkg/BasePrintLib: avoid absolute addresses for error strings
>       StandaloneMmPkg/Core: fix bogus FV pointer in DEBUG string
>       StandaloneMmPkg/Core: add missing GUID reference
>       StandaloneMmPkg: generate position independent code for StMM core
>       StandaloneMmPkg/StandaloneMmCoreEntryPoint: relocate StMM core on the fly
>       ArmPkg/PlatformBootManagerLib: regenerate boot options on boot failure
>       EmbeddedPkg/NonCoherentDmaLib: avoid dereferencing bogus buffer address
>       ArmVirtPkg/NorFlashQemuLib: disable NOR flash DT nodes upon discovery
>
> Ashish Singhal (7):
>       MdeModulePkg/XhciDxe: Fix Aligned Page Allocation
>       MdeModulePkg/XhciPei: Fix Aligned Page Allocation
>       EmbeddedPkg/DtPlatformDxe: Add DT/ACPI Default Flexibility
>       MdeModulePkg: Add EDK2 Platform Boot Manager Protocol
>       MdeModulePkg/BaseSerialPortLib16550: Fix Serial Port Ready
>       ShellPkg/UefiShellAcpiViewCommandLib: Fix FADT Parser
>       ArmPkg/ArmLib: Fix cache-invalidate initial page tables
>
> Bret Barkelew (11):
>       CryptoPkg: Add missing instance for build only
>       SourceLevelDebugPkg: Add missing instances for build only
>       MdeModulePkg: Add missing instances for build only
>       MdeModulePkg/CapsulePei: Optimize the CapsulePei
>       MdeModulePkg/PeiMain: PeiAllocatePool: output NULL if HOB creation fails
>       SecurityPkg: Add missing instances for build only
>       MdeModulePkg: Add a pcd to set the OS indications bit
>       ShellPkg/UefiShellLib: Set input pointer parameter to null if failure
>       MdePkg/Include/Library: Add UnitTestLib class
>       UnitTestFrameworkPkg: Add info to readme about working with UnitTests
>       UnitTestFrameworkPkg/Readme.md: Update documentation for latest features
>
> Brian R Haug (1):
>       MdeModulePkg/Setup: Update opcode number variable type to UINTN
>
> Burt Silverman (1):
>       BaseTools: Robustness for multiple build environments
>
> Chasel Chiu (15):
>       IntelFsp2Pkg/SplitFspBin.py: Support rebasing 1.x binary.
>       IntelFsp2Pkg: add TempRamExitPpi.h.
>       IntelFsp2Pkg: FSP Python scripts to support 3.x.
>       IntelFsp2Pkg: PeiService pointer not reset to 0 in SecMain
>       BaseTools/Scripts: Add GetUtcDateTime script.
>       UefiCpuPkg: support single EFI_PEI_CORE_FV_LOCATION_PPI in PpiList
>       MdeModulePkg: Enable/Disable S3BootScript dynamically.
>       IntelFsp2Pkg/SplitFspBin.py: Command crashed when FV almost full.
>       IntelFsp2Pkg/GenCfgOpt.py: Coverity scan flags issues.
>       IntelFsp2Pkg/SplitFspBin.py: Coverity scan flags issues.
>       IntelFsp2Pkg: Support Multi-Phase SiInit and debug handlers.
>       IntelFsp2Pkg: Add FunctionParametePtr to FspGlobalData.
>       IntelFsp2Pkg: Add Fsp22SecCoreS.inf to Dsc.
>       IntelFsp2Pkg: Add FSP*_ARCH_UPD.
>       IntelFsp2WrapperPkg: Add FSP*_ARCH_UPD.
>
> Ching JenX Cheng (3):
>       IntelFsp2Pkg: Improve FSP Python scripts to support 3.x.
>       Add VS2019 Toolchain def
>       Add VS2019 Support on ToolSetup Batches
>
> Christopher J Zurcher (7):
>       MdePkg: Implement SCSI commands for Security Protocol In/Out
>       MdeModulePkg/UfsPassThruDxe: Check for RPMB W-LUN (SecurityLun)
>       MdeModulePkg/ScsiBusDxe: Clean up Peripheral Type check
>       MdeModulePkg/ScsiDiskDxe: Support Storage Security Command Protocol
>       CryptoPkg/OpensslLib: Add "sort" keyword to header file parsing loop
>       CryptoPkg/OpensslLib: Remove "no-autoalginit" flag from OpenSSL build
>       MdePkg/UefiScsiLib: Set FUA bit for synchronous SCSI Write operations
>
> Cole Robinson (4):
>       BaseTools: Fix python3.8 SyntaxWarning
>       BaseTools: fix ucs-2 lookup on python 3.9
>       BaseTools: Work around array.array.tostring() removal in python 3.9
>       Add a stub CONTRIBUTING.md pointing to the wiki
>
> Cole, Deric (1):
>       UefiCpuPkg/SecCore: Add pre-memory AP vector
>
> Damian Nikodem (2):
>       UefiCpuPkg/PiSmmCpuDxeSmm: don't free page table pages that are required to handle current page fault
>       UefiCpuPkg: Fix potential spinLock issue in SmmStartupThisAp
>
> Dandan Bi (12):
>       ShellPkg/Debug1CommandsLib: Fix bugs in func DisplaySysEventLogData
>       Edk2: Remove nt32 related flag in bat files
>       Edk2Setup: Support different VS tool chain setup
>       EmbeddedPkg: Unload image on EFI_SECURITY_VIOLATION
>       MdeModulePkg/DxeCapsuleLibFmp: Unload image on EFI_SECURITY_VIOLATION
>       MdeModulePkg/UefiBootManager: Unload image on EFI_SECURITY_VIOLATION
>       MdeModulePkg/PlatformDriOverride: Unload image on EFI_SECURITY_VIOLATION
>       ShellPkg: Unload image on EFI_SECURITY_VIOLATION
>       MdeModulePkg/HiiDB: Remove configuration table when it's freed (CVE-2019-14586)
>       MdeModulePkg/String.c: Zero memory before free (CVE-2019-14558)
>       MdeModulePkg/DisplayEngine: Zero memory before free (CVE-2019-14558)
>       MdeModulePkg/DisplayEngine: Add Debug message to show mismatch menu info
>
> Daniel Pawel Banaszek (1):
>       MdePkg PciExpress21: PCI_REG_PCIE_DEVICE_CONTROL2 struct has 17 bits
>
> Daniel Schaefer (2):
>       MdeModulePkg: Use CopyMem instead of GUID assignment
>       MdePkg/DxeServicesLib: Add RISC-V architecture
>
> David Woodhouse (5):
>       OvmfPkg/Csm/LegacyBiosDxe: Fix Legacy16GetTableAddress call for E820 data
>       OvmfPkg/LegacyBios: set NumberBbsEntries to the size of BbsTable
>       OvmfPkg/LegacyBbs: Add boot entries for VirtIO and NVME devices
>       OvmfPkg: Don't build in QemuVideoDxe when we have CSM
>       OvmfPkg: don't assign PCI BARs above 4GiB when CSM enabled
>
> Derek Lin (2):
>       BaseTools: Fix an incremental build issue caused by macro in #include
>       SecurityPkg: Fix TPM2 ACPI measurement.
>
> Desimone, Nathaniel L (1):
>       BaseTools/Scripts: Add sendemail.transferEncoding to SetupGit.py
>
> Donald Kuo (1):
>       UefiCpuPkg: Adding a new TSC library by using CPUID(0x15) TSC leaf
>
> Dorapika Wu (1):
>       ShellPkg: Update timezone of 3 cities
>
> Eric Dong (41):
>       MdePkg: Add new MM MP Protocol definition.
>       UefiCpuPkg/PiSmmCpuDxeSmm: Enable MM MP Protocol
>       UefiCpuPkg/RegisterCpuFeaturesLib: Avoid AP calls PeiServices table.
>       UefiCpuPkg/RegisterCpuFeaturesLib: avoid use dynamic PCD.
>       UefiCpuPkg/Include/MpInitLib.h: Add MpInitLibStartupAllCPUs API.
>       UefiCpuPkg/MpInitLib: Add MpInitLibStartupAllCPUs API.
>       UefiCpuPkg/MpInitLibUp: Add MpInitLibStartupAllCPUs API.
>       UefiCpuPkg: Add new EDKII_PEI_MP_SERVICES2_PPI
>       UefiCpuPkg/CpuMpPei: Produce EDKII_PEI_MP_SERVICES2_PPI.
>       UefiCpuPkg/RegisterCpuFeaturesLib: Start all processors simultaneously.
>       UefiCpuPkg/MpInitLib: don't shadow the microcode patch twice.
>       UefiCpuPkg/RegisterCpuFeaturesLib: Remove debug message.
>       UefiCpuPkg/PiSmmCpuDxeSmm: Remove debug message.
>       OvmfPkg/PlatformPei: Change referenced MSR name.
>       UefiCpuPkg/RegisterCpuFeaturesLib: Clean up useless ConsoleLogLock spinlock.
>       UefiCpuPkg/PiSmmCpuDxeSmm: Clean up useless ConsoleLogLock spinlock.
>       UefiCpuPkg/RegisterCpuFeaturesLib: Add "Test Then Write" Macros.
>       UefiCpuPkg/PiSmmCpuDxeSmm: Combine CR read/write action.
>       UefiCpuPkg/PiSmmCpuDxeSmm: Supports test then write new value logic.
>       UefiCpuPkg/RegisterCpuFeaturesLib: Combine CR read/write action.
>       UefiCpuPkg/RegisterCpuFeaturesLib: Supports test then write new value logic.
>       UefiCpuPkg/CpuCommonFeaturesLib: Use new macros.
>       UefiCpuPkg/SecCore: get AllSecPpiList after SecPlatformMain.
>       UefiCpuPkg/CpuDxe: clean up PAGE_TABLE_LIB_PAGING_CONTEXT usage.
>       UefiCpuPkg/PiSmmCpuDxeSmm: Avoid allocate Token every time
>       UefiCpuPkg/PiSmmCpuDxeSmm: Remove dependence between APs
>       UefiCpuPkg/PiSmmCpuDxeSmm: Fix buffer overflow issue.
>       UefiCpuPkg/PiSmmCpuDxeSmm: Pre-allocate PROCEDURE_TOKEN buffer
>       Revert "UefiCpuPkg/PiSmmCpuDxeSmm: Fix buffer overflow issue."
>       UefiCpuPkg/PiSmmCpuDxeSmm: improve the coding style
>       UefiCpuPkg/PiSmmCpuDxeSmm: Add missed comments for parameter.
>       UefiCpuPkg/PiSmmCpuDxeSmm: Remove Used parameter.
>       UefiCpuPkg/PiSmmCpuDxeSmm: Remove useless code in ResetTokens.
>       UefiCpuPkg/MpInitLib: Restore IDT context for APs.
>       UefiCpuPkg/MpInitLib: Avoid ApInitReconfig in PEI.
>       Maintainers.txt: Add reviewers for Tcg related modules.
>       Maintainers.txt: Add reviewer for security boot modules.
>       Maintainers.txt: Add reviewer for UefiCpuPkg.
>       Maintainers.txt: Add reviewer for SEC related modules.
>       Maintainers.txt: Add reviewer for Pei Core.
>       IntelFsp2Pkg/FspSecCore: Use UefiCpuLib.
>
> Eric Jin (13):
>       BaseTools/Capsule: Supports multiple payloads and drivers in capsule
>       MdeModulePkg/EsrtFmpDxe: Enhance ESRT to support multiple controllers
>       FmpDevicePkg: Add UEFI_DRIVER support
>       FmpDevicePkg: Add APIs to FmpDeviceLib
>       FmpDEvicePkg/FmpDeviceLibNull: Implement new APIs
>       FmpDevicePkg/FmpDxe: Use new FmpDeviceLib APIs
>       FmpDevicePkg/FmpDxe: Different variable for each FMP Descriptor
>       FmpDevicePkg: Add Capsule Update Policy Protocol
>       FmpDevicePkg/FmpDxe: Improve all DEBUG() messages
>       FmpDevicePkg/FmpDxe: Add PcdFmpDeviceImageTypeIdGuid
>       FmpDevicePkg/FmpDxe: Add PcdFmpDeviceStorageAccessEnable
>       FmpDevicePkg/FmpDxe: Remove use of CatSprint()
>       BaseTools/Capsule: Tool to generate Windows Firmware Update Driver
>
> Eugene Cohen (2):
>       .mailmap: update description to account for job changes
>       .mailmap: add entry for Eugene Cohen reflecting email change
>
> Felix Polyudov (1):
>       MdePkg: Add PCI Express 5.0 Header File
>
> Feng, Bob C (60):
>       BaseTools: refine CreateAsBuiltInf function
>       BaseTools: Move Build Cache related function out of CreateAsBuiltInf
>       BaseTools: Fixed the issue of the CFlag for compile PcdValueInit.c
>       BaseTools: Detect the change of env variable used in tooldef.txt
>       BaseTools: Fixed the issue when ToolDefinitionFile is not generated
>       BaseTools: Create ".cache" folder when initialize Build object
>       BaseTools: Fixed the mis-using strip() function issue.
>       BaseTools: Sort file list in Makefile
>       BaseTools:Updata the output encoding of the Popen function
>       BaseTools: Fixed a typo in Trim.py
>       BaseTools: Singleton the object to handle build conf file
>       BaseTools: Split WorkspaceAutoGen._InitWorker into multiple functions
>       BaseTools: Add functions to get platform scope build options
>       BaseTools: Decouple AutoGen Objects
>       BaseTools: Enable Multiple Process AutoGen
>       BaseTools: Add shared data for processes
>       BaseTools: Add LogAgent to support multiple process Autogen
>       BaseTools: Move BuildOption parser out of build.py
>       BaseTools: Add the support for python 2
>       BaseTools: Enable block queue log agent.
>       BaseTools: Fixed an issue that build raise exception
>       BaseTools: Fix incremental build bug
>       BaseTools: Add "-" in a re to parse line in .map file
>       BaseTools: Move buildoptions.py to Common folder
>       BaseTools: Fixed issue of incorrect Module Unique Name
>       BaseTools: Fix incremental build genmake issue
>       BaseTools: Incorrect error message for library instance not found
>       BaseTools: fix an incremental build issue.
>       BaseTools: Fixed regression issue for building !x86 builds
>       BaseTools: Fix a bug for Hii Pcd override
>       BaseTools: Fixed build clean regression issue
>       BaseTools: Fixed issue for IgnoreAutoGen
>       BaseTools: Sort Pcd settings to make PcdTokenNumber be fixed
>       BaseTools: Fixed the bug of multi-thread genffs for override inf
>       BaseTools: Fixed the build fail on Linux with --genfds-multi-thread
>       BaseTools: Enable --genfds-multi-thread to default build
>       BaseTools: Fixed a bug of IgnoreAutoGen
>       BaseTools: Improve GetDependencyList function
>       BaseTools: remove unnecessary calls of os.exist
>       BaseTools:Remove the unnecessary operation of renaming a file.
>       BaseTools: init DependencyHeaderFileSet for each MakeFile class
>       BaseTools: Fix the lib order in static_library_files.lst
>       BaseTools: Fix a bug of genffs command generation
>       BaseTools: Enable MACRO for DSC Components section tag
>       BaseTools: Add build option for dependency file generation
>       BaseTools: Generate dependent files for ASL and ASM files
>       BaseTools: Update build_rule.txt to generate dependent files.
>       BaseTools: Enhance Basetool for incremental build
>       BaseTools: Fix build failure when multiple build targets given
>       BaseTools: Resolve a issue of Incremental build
>       BaseTools: Fixed a incremental build bug
>       BaseTools: Fixed a Incremental build issue
>       BaseTools: Remove invalid leading space before !INCLUDE in Makefile
>       OvmfPkg/LinuxInitrdDynamicShellCommand: Cast UNIT64 to UNITN in assignment
>       BaseTools: Warn user the file not found issue instead of break build.
>       BaseTools: Remove the file timestamp checking during parsing
>       Revert "BaseTools: Add gcc flag to warn on void* pointer arithmetic"
>       BaseTools: Improve the method of checking queue empty
>       BaseTools: Move CreateAsBuiltInf into AutoGenWorker for parallel
>       BaseTools/Ecc: Fix an issue of path separator compatibility
>
> Feng, YunhuaX (2):
>       BaseTools: Fix parse PCD GUID expression issue
>       BaseTools: Fix binary file not generate map file issue
>
> Gary Lin (14):
>       OvmfPkg/README: Update the network build flags
>       OvmfPkg: use DxeTpmMeasurementLib if and only if TPM2_ENABLE
>       OvmfPkg/OvmfPkg.dec: Adjust PcdMptScsiStallPerPollUsec token value
>       OvmfPkg/LsiScsiDxe: Create the empty driver
>       OvmfPkg/LsiScsiDxe: Install the skeleton of driver binding
>       OvmfPkg/LsiScsiDxe: Report the name of the driver
>       OvmfPkg/LsiScsiDxe: Probe PCI devices and look for LsiScsi
>       OvmfPkg/LsiScsiDxe: Install stubbed EXT_SCSI_PASS_THRU
>       OvmfPkg/LsiScsiDxe: Report Targets and LUNs
>       OvmfPkg/LsiScsiDxe: Open PciIo protocol and initialize the device
>       OvmfPkg/LsiScsiDxe: Map DMA buffer
>       OvmfPkg/LsiScsiDxe: Examine the incoming SCSI Request Packet
>       OvmfPkg/LsiScsiDxe: Process the SCSI Request Packet
>       Maintainers.txt: Add Gary Lin as the reviewer for LsiScsi driver
>
> Gary West (1):
>       CryptoPkg/BaseCryptLib: Wrap OpenSSL HKDF algorithm
>
> Gaurav Jain (3):
>       MdeModulePkg/Pci: Fixed Asserts in SCT PCIIO Protocol Test.
>       EmbeddedPkg/RealTimeClockRuntimeDxe: Drop ASSERTs on function arguments
>       EmbeddedPkg/MmcDxe: Added MaxBlock Transfer Limit 65535 in R/W.
>
> GregX Yeh (1):
>       MdeModulePkg/Setup: Check ConfigAccess protocol in case it's destroyed
>
> Gris87 (1):
>       MdeModulePkg: Add missing sourceX for Blt
>
> Guo Dong (4):
>       UefiPayloadPkg: Remove legacy PIC 8259 driver
>       UefiPayloadPkg/BootManager: Add PS2 keyboard support
>       UefiPayloadPkg:Fix NOOPT build failure
>       UefiPayloadPkg: Fix TerminalDxe build time configurable
>
> Guomin Jiang (31):
>       FmpDevicePkg/FmpDxe: Issues reported by ECC in EDK2.
>       MdeModulePkg: Issues reported by ECC in EDK2.
>       SecurityPkg: Issues reported by ECC in EDK2.
>       MdeModulePkg/SdDxe: Check the Token to avoid null pointer
>       MdePkg/UnitTestBaseLib: Add check for pointer BinData
>       UnitTestFrameworkPkg/UnitTestLib: Check Suite pointer before use.
>       UnitTestFrameworkPkg/ResultReportLib: Remove invalid index string indicator
>       UefiCpuPkg/MpInitLib: Add out attribute for parameter.
>       MdeModulePkg: Remove gEfiFormBrowserExProtocolGuid Protocol Guid
>       CryptoPkg/BaseCryptLibOnProtocolPpi: Add missing comments
>       CryptoPkg/BaseHashApiLib: Rename BaseHashApiLib by HashApiLib
>       MdeModulePkg/SmiHandlerProfileInfo: Overflowed Array Index
>       EmulatorPkg/WinHost: Add link flags for VS2019 tool chains.
>       EmulatorPkg: Add MagicPageLib header file declaration.
>       SecurityPkg/TPM: measure UEFI images without associated device paths again
>       SecurityPkg/DxeImageAuth: Mark the File parameter as OPTIONAL
>       SecurityPkg/DxeImageVerificationLib: Mark the File parameter as OPTIONAL
>       MdeModulePkg/SecurityManagementLib: Mark the File parameter as OPTIONAL
>       MdeModulePkg/SecurityStubDxe: Mark the File parameter as OPTIONAL
>       MdePkg/Security2: Mark the File parameter as OPTIONAL.
>       UnitTestFrameworkPkg/PersistenceLib: Correct the allocated size.
>       CryptoPkg/Pkcs7: Extend support for other OID types
>       BaseTools/Scripts: Ignore the CRLF check when upgrade submodule.
>       CryptoPkg/OpensslLib: Upgrade OpenSSL to 1.1.1g
>       MdeModulePkg: Add new PCD to control the evacuate temporary memory feature (CVE-2019-11098)
>       MdeModulePkg/Core: Create Migrated FV Info Hob for calculating hash (CVE-2019-11098)
>       SecurityPkg/Tcg2Pei: Use Migrated FV Info Hob for calculating hash (CVE-2019-11098)
>       UefiCpuPkg/CpuMpPei: Enable paging and set NP flag to avoid TOCTOU (CVE-2019-11098)
>       UefiCpuPkg: Correct some typos.
>       SecurityPkg/TcgPei: Use Migrated FV Info Hob for calculating hash (CVE-2019-11098)
>       Maintainers.txt: Add "Guomin Jiang" as reviewer for Crypto and Capsule
>
> Hao A Wu (36):
>       OvmfPkg: Drop build flag USE_LEGACY_ISA_STACK and legacy ISA stack
>       Maintainers.txt: Add maintainer for CSM components in OvmfPkg
>       OvmfPkg: Copy the required CSM components from framework packages
>       OvmfPkg/OvmfPkg.dec: Add definitions for CSM-related Guid & Protocol
>       OvmfPkg/OvmfPkg.dec: Add the new include folder for CSM header files
>       OvmfPkg/OvmfPkg.dec: Add PCD definitions used by copied CSM modules
>       OvmfPkg/Csm/VideoDxe: Update to make it build for OVMF
>       OvmfPkg/Csm/LegacyBiosDxe: Update to make it build for OVMF
>       OvmfPkg/Csm/LegacyBootMaintUiLib: Update to make it build for OVMF
>       OvmfPkg/Csm/LegacyBootManagerLib: Update to make it build for OVMF
>       OvmfPkg: Update DSC/FDF files to consume CSM components in OvmfPkg
>       OvmfPkg/PlatformPei: Remove redundant reference of framework pkg DEC
>       OvmfPkg/IncompatiblePciDeviceSupportDxe: Drop framework pkg dependency
>       OvmfPkg/Csm/CsmSupportLib: Drop IntelFrameworkPkg dependency
>       OvmfPkg: Refer to Shell app via its declared GUID
>       PcAtChipsetPkg: Remove framework modules
>       EmulatorPkg/MiscSubClassPlatformDxe: Remove this unused module
>       Remove IntelFrameworkModulePkg
>       Remove IntelFrameworkPkg
>       Maintainers.txt: Remove information for IntelFramework[Module]Pkg
>       Maintainers.txt: Drop deprecated SourceForge SVN link
>       Maintainers.txt: Fine-grained review ownership for MdeModulePkg
>       UefiCpuPkg/MpInitLib: Collect processors' CPUID & Platform ID info
>       UefiCpuPkg/MpInitLib: Reduce the size when loading microcode patches
>       UefiCpuPkg: Add definitions for EDKII microcode patch HOB
>       UefiCpuPkg/MpInitLib: Produce EDKII microcode patch HOB
>       UefiCpuPkg/MpInitLib: Relocate microcode patch fields in CPU_MP_DATA
>       UefiCpuPkg/MpInitLib: Remove redundant microcode fields in CPU_MP_DATA
>       UefiCpuPkg/MpInitLib: Fix possible uninitialized 'InitFlag' field
>       UefiCpuPkg/MpInitLib: Always get CPUID & PlatformID in MicrocodeDetect()
>       MdeModulePkg/PiDxeS3BootScriptLib: Fix potential numeric truncation (CVE-2019-14563)
>       Revert UefiCpuPkg/MpInitLib: Relocate microcode patch fields in CPU_MP_DATA
>       UefiCpuPkg/MpInitLib: Not pass microcode info between archs in CPU_MP_DATA
>       MdeModulePkg/SdMmcPciHcDxe: Fix double PciIo Unmap in TRB creation (CVE-2019-14587)
>       UefiCpuPkg/MpInitLib DXE: Add PCD to control AP status check interval
>       UefiCpuPkg/MpInitLib: Add missing explicit PcdLib dependency
>
> Heinrich Schuchardt (3):
>       ShellPkg/CommandLib: avoid NULL derefence and memory leak
>       ShellPkg/edit: typo "%d Lines Wrote"
>       MdeModulePkg: Make retval in UninstallMultipleProtocol follow Spec
>
> Heng Luo (1):
>       MdeModulePkg: Perform test only if not ignore memory test
>
> Heyi Guo (1):
>       ArmPkg/ArmExceptionLib: use static buffer for sp_el0
>
> Huang, Qing (1):
>       MdePkg-UefiSpec.h: Add UEFI 2.8 new memory attributes
>
> Igor Druzhinin (1):
>       OvmfPkg: End timer interrupt later to avoid stack overflow under load
>
> Imran Desai (9):
>       MdePkg/Protocol/Hash: introduce GUID for SM3
>       SecurityPkg: introduce the SM3 digest algorithm
>       SecurityPkg/HashLibBaseCryptoRouter: recognize the SM3 digest algorithm
>       SecurityPkg: set SM3 bit in TPM 2.0 hash mask by default
>       OvmfPkg: link SM3 support into Tcg2Pei and Tcg2Dxe
>       SecurityPkg: introduce the SM3 digest algorithm
>       SecurityPkg/HashLibBaseCryptoRouter: recognize the SM3 digest algorithm
>       SecurityPkg: set SM3 bit in TPM 2.0 hash mask by default
>       OvmfPkg: link SM3 support into Tcg2Pei and Tcg2Dxe
>
> Irene Park (2):
>       BaseTools/build.py: Exit with 1 when AutoGen error occurred
>       ArmPlatformPkg/PL011UartLib: Check PID2 if FiFoDepth is zero
>
> Jaben Carsey (1):
>       Maintainers.txt update for ShellPkg
>
> Jason Voelz (2):
>       MdePkg BaseLib.h: Update IA32_CR4 strut to include all public fields
>       UefiCpuPkg/CpuCommonFeaturesLib: SMXE bit of CR4 should set
>
> Javeed, Ashraf (5):
>       PciBusDxe: duplicate node insertion for every PPB device in the system
>       MdePkg/PciExpress21.h: Fix the PCI industry standard register defines
>       MdePkg/PciExpress40.h: DVSEC definition missing
>       MdePkg/Include/IndustryStandard: CXL 1.1 Registers
>       MdePkg/Include/IndustryStandard: Main CXL header
>
> Jayanth Raghuram (1):
>       MdePkg/DxeHstiLib: Added checks to improve error handling.
>
> Jeff Brasen (2):
>       ArmPlatformPkg/Ds5: Increase path length to 400
>       MdeModulePkg/DxeCorePerformanceLib: Switch to UnicodeStrnToAsciiStrS
>
> Jessica Clarke (1):
>       MdePkg Base.h: Delete prototype for __builtin_return_address
>
> Jian J Wang (25):
>       SecurityPkg: add definitions for OBB verification
>       SecurityPkg/FvReportPei: implement a common FV verifier and reporter
>       SecurityPkg: add FvReportPei.inf in dsc for build validation
>       Readme.md: add submodule policy and clone commands
>       CryptoPkg/OpensslLib: remove clone commands
>       SecurityPkg/SecurityPkg.uni: Add missing strings for new PCDs
>       Maintainers.txt: Unify one maintainer name
>       MdeModulePkg/DxeIplPeim: reserve page 0 for NULL pointer detection
>       MdeModulePkg/Core/Dxe: free page 0 after disabling NULL pointer detection
>       MdePkg: add null version of RngLib
>       CryptoPkg/BaseCryptLib: replace HmacXxxInit API with HmacXxxSetKey
>       CryptoPkg/BaseCryptLib: remove HmacXxxGetContextSize interface
>       SecurityPkg/DxeImageVerificationLib: Fix memory leaks (CVE-2019-14575)
>       SecurityPkg/DxeImageVerificationLib: reject CertStack.CertNumber==0 per DBX (CVE-2019-14575)
>       SecurityPkg/DxeImageVerificationLib: fix wrong fetch dbx in IsAllowedByDb (CVE-2019-14575)
>       SecurityPkg/DxeImageVerificationLib: avoid bypass in fetching dbx (CVE-2019-14575)
>       SecurityPkg/DxeImageVerificationLib: refactor db/dbx fetching code (CVE-2019-14575)
>       SecurityPkg/DxeImageVerificationLib: Differentiate error/search result (1) (CVE-2019-14575)
>       SecurityPkg/DxeImageVerificationLib: tighten default result (CVE-2019-14575)
>       SecurityPkg/DxeImageVerificationLib: Differentiate error/search result (2) (CVE-2019-14575)
>       SecurityPkg/DxeImageVerificationLib: change IsCertHashFoundInDatabase name (CVE-2019-14575)
>       SecurityPkg: add RpmcLib and VariableKeyLib public headers
>       SecurityPkg: add null version of RpmcLib
>       SecurityPkg: add null version of VariableKeyLib
>       Maintainers.txt: Remove invalid email address and a few other role changes
>
> Jiaxin Wu (6):
>       MdePkg/Include/Protocol/Tls.h: Add the data type of EfiTlsVerifyHost (CVE-2019-14553)
>       CryptoPkg/TlsLib: Add the new API "TlsSetVerifyHost" (CVE-2019-14553)
>       NetworkPkg/TlsDxe: Add the support of host validation to TlsDxe driver (CVE-2019-14553)
>       NetworkPkg/HttpDxe: Set the HostName for the verification (CVE-2019-14553)
>       Maintainers.txt: Change NetworkPkg maintainer role.
>       NetworkPkg/Ip4Dxe: Check the received package length (CVE-2019-14559).
>
> Jiewen Yao (29):
>       BaseTools: Add HOST_APPLICATION module type.
>       MdePkg/Include: correct Lasa in Tpm2Acpi.
>       SecurityPkg/dsc: Add PCD for Laml, Lasa for TPM2.
>       SecurityPkg/Tcg2: Add Support Laml, Lasa for TPM2 ACPI.
>       MdePkg/Include: Add DMTF SPDM definition.
>       MdeModulePkg/Include: Add DeviceSecurity.h
>       MdeModulePkg/dec: Add EdkiiDeviceSecurityProtocolGuid.
>       MdeModulePkg/Pci: Add DeviceSecurity support.
>       SecurityPkg/Tcg2Smm: Measure the table before patch.
>       MdePkg/Spdm: fix Nonce structure error.
>       MdePkg/Tcg: Add new definition in TCG PFP spec.
>       SecurityPkg/Guid: Add TCG 800-155 event GUID definition.
>       SecurityPkg/Tcg2Dxe: Add Tcg2Dxe to support 800-155 event.
>       MdeModulePkg/Smbios: Done measure Smbios multiple times.
>       MdeModulePkg/dec: add PcdTcgPfpMeasurementRevision PCD
>       MdeModulePkg/Smbios: Add TCG PFP rev 105 support.
>       SecurityPkg/Tcg2Pei: Add TCG PFP 105 support.
>       SecurityPkg/Tcg2Dxe: Add PcdTcgPfpMeasurementRevision in SpecId event.
>       SecurityPkg/Tcg2Pei: Add missing PCRIndex in FvBlob event.
>       SecurityPkg/TcgPpi: Add TcgPpi header file.
>       SecurityPkg/dec: Add TcgPpi.
>       SecurityPkg/Tcg: Add TcgPpi
>       SecurityPkg/Tcg2: Add TcgPpi
>       SecurityPkg/PeiTpmMeasurementLib: Add PEI instance.
>       SecurityPkg/dsc: Add PeiTpmMeasurementLib.
>       IntelFsp2WrapperPkg/FspMeasurementLib: Add header file.
>       IntelFsp2WrapperPkg/FspMeasurementLib: Add BaseFspMeasurementLib.
>       IntelFsp2WraperPkg/Fsp{m|s}WrapperPeim: Add FspBin measurement.
>       IntelFsp2Wrapper/dsc: Add FspTpmMeasurementLib and PcdFspMeasurementConfig.
>
> John E Lofgren (1):
>       UefiCpuPkg/CpuExceptionHandlerLib: Fix split lock
>
> Jonathan Watt (1):
>       ShellPkg/UefiShellBcfgCommandLib: Fix '-opt' option
>
> Jordan Justen (2):
>       EmulatorPkg/build.sh: Fix missing usage of -b BUILDTARGET parameter
>       EmulatorPkg/Unix: Convert timezone from seconds to minutes
>
> Julien Grall (1):
>       Maintainers.txt: Update my e-mail address
>
> Keysound Chang (1):
>       NetworkPkg/TlsAuthConfigDxe: Use HiiPopUp() instead of CreatePopUp()
>
> Kirkendall, Garrett (4):
>       PcAtChipsetPkg: PcAtChipsetPkg.dsc add UefiCpuLib LibraryClass
>       SourceLevelDebugPkg: SourceLevelDebugPkg.dsc add UefiCpuLib LibraryClass
>       UefiCpuPkg: Move StandardSignatureIsAuthenticAMD to BaseUefiCpuLib
>       UefiCpuPkg: PiSmmCpuDxeSmm skip MSR_IA32_MISC_ENABLE manipulation on AMD
>
> KrishnadasX Veliyathuparambil Prakashan (1):
>       MdeModulePkg: Upon BootOption failure, Destroy RamDisk memory before RSC.
>
> Krzysztof Koch (56):
>       DynamicTablesPkg: Add frame number validation to GTDT generator
>       DynamicTablesPkg: Add code for finding duplicate values in arrays
>       DynamicTablesPkg: Test for duplicate UIDs in MADT generator
>       DynamicTablesPkg: Test for duplicate GT Block frame numbers
>       DynamicTablesPkg: Add ACPI 6.3 SPE support to MADT generator
>       DynamicTablesPkg: Add dynamic PPTT table generation support
>       ShellPkg: acpiview: ACPI 6.3 update for MADT parser
>       MdePkg: Add Generic Initiator Affinity Structure definitions to SRAT
>       ShellPkg: acpiview: Improve PPTT table field validation
>       ShellPkg: acpiview: Remove '/?' from valid command line flags
>       ShellPkg: acpiview: Fix '\n\n' printing in Table Checksum reporting
>       ShellPkg: acpiview: Make DBG2 output consistent with other tables
>       ShellPkg: acpiview: Allow disabling consistency checks (-q flag)
>       ShellPkg: acpiview: Remove redundant IORT node types enum
>       ShellPkg: acpiview: Remove '-v' flag from allowed command line args
>       ShellPkg: acpiview: Remove duplicate indentation in IORT parser
>       ShellPkg: acpiview: Make '-h' option not require a parameter
>       ShellPkg: acpiview: RSDP: Remove redundant forward declarations
>       ShellPkg: acpiview: FADT: Remove redundant forward declarations
>       ShellPkg: acpiview: SPCR: Remove redundant forward declaration
>       ShellPkg: acpiview: SRAT: Remove redundant forward declarations
>       ShellPkg: acpiview: MADT: Remove redundant forward declarations
>       ShellPkg: acpiview: IORT: Remove redundant forward declarations
>       ShellPkg: acpiview: GTDT: Remove redundant forward declarations
>       ShellPkg: acpiview: DBG2: Remove redundant forward declarations
>       ShellPkg: acpiview: Allow passing buffer length to DumpGasStruct()
>       ShellPkg: acpiview: XSDT: Remove redundant ParseAcpi() call
>       ShellPkg: acpiview: RSDP: Make code consistent with other parsers
>       ShellPkg: acpiview: SRAT: Minor code style enhancements
>       ShellPkg: acpiview: MADT: Split structure length validation
>       ShellPkg: acpiview: IORT: Refactor PMCG node mapping count validation
>       ShellPkg: acpiview: DBG2: Prevent buffer overruns
>       ShellPkg: acpiview: GTDT: Prevent buffer overruns
>       ShellPkg: acpiview: IORT: Prevent buffer overruns
>       ShellPkg: acpiview: MADT: Prevent buffer overruns
>       ShellPkg: acpiview: PPTT: Prevent buffer overruns
>       ShellPkg: acpiview: SRAT: Prevent buffer overruns
>       ShellPkg: acpiview: Update SRAT parser to ACPI 6.3
>       ShellPkg: acpiview: Set ItemPtr to NULL for unprocessed table fields
>       ShellPkg: acpiview: RSDP: Validate global pointer before use
>       ShellPkg: acpiview: FADT: Validate global pointer before use
>       ShellPkg: acpiview: SLIT: Validate global pointer before use
>       ShellPkg: acpiview: SLIT: Validate System Locality count
>       ShellPkg: acpiview: SRAT: Validate global pointers before use
>       ShellPkg: acpiview: MADT: Validate global pointers before use
>       ShellPkg: acpiview: PPTT: Validate global pointers before use
>       ShellPkg: acpiview: IORT: Validate global pointers before use
>       ShellPkg: acpiview: GTDT: Validate global pointers before use
>       ShellPkg: acpiview: DBG2: Validate global pointers before use
>       MdePkg: Add PCCT table signature definition
>       ShellPkg: acpiview: Remove duplicate ACPI structure size definitions
>       ShellPkg: acpiview: Validate ACPI table 'Length' field
>       ShellPkg: acpiview: Prevent infinite loop if structure length is 0
>       ShellPkg: acpiview: Add -r parameter for table requirements validation
>       ShellPkg: acpiview: Add library for SBBR ACPI requirements validation
>       ShellPkg: acpiview: Check if SBBR mandatory ACPI tables are installed
>
> Kun Qin (2):
>       UnitTestFrameworkPkg/UnitTestLib: Correct dereferred pointer
>       FmpDevicePkg/FmpDxe: Fix uninitialized pointer dereference
>
> Laszlo Ersek (164):
>       MdeModulePkg/PciBusDxe: catch unimplemented extended config space reads
>       ArmVirtPkg: handle NETWORK_TLS_ENABLE in ArmVirtQemu*
>       Revert "OvmfPkg: link SM3 support into Tcg2Pei and Tcg2Dxe"
>       Revert "SecurityPkg: set SM3 bit in TPM 2.0 hash mask by default"
>       Revert "SecurityPkg/HashLibBaseCryptoRouter: recognize the SM3 digest algorithm"
>       Revert "SecurityPkg: introduce the SM3 digest algorithm"
>       Revert "MdePkg/Protocol/Hash: introduce GUID for SM3"
>       MdePkg/BaseLib: re-specify Base64Decode(), and add temporary stub impl
>       MdePkg/BaseLib: rewrite Base64Decode()
>       MdePkg/BaseLib: Base64Decode(): don't declare variables in nested blocks
>       Maintainers.txt: split out section "ArmVirtPkg: modules used on Xen"
>       Maintainers.txt: split out section "OvmfPkg: Xen-related modules"
>       Maintainers.txt: split out section "OvmfPkg: TCG- and TPM2-related modules"
>       Maintainers.txt: split out section "OvmfPkg: CSM modules"
>       ArmPkg: list module-internal header files in INF [Sources]
>       ArmPlatformPkg: list module-internal header files in INF [Sources]
>       CryptoPkg/BaseCryptLib: list module-internal header files in INF [Sources]
>       EmbeddedPkg: list module-internal header files in INF [Sources]
>       Revert "UefiCpuPkg/PiSmmCpu: Allow SMM access-out when static paging is OFF"
>       ArmVirtPkg/PlatformBootManagerLib: unload image on EFI_SECURITY_VIOLATION
>       OvmfPkg/EnrollDefaultKeys: clean up Base64Decode() retval handling
>       EmbeddedPkg: add missing EFIAPI calling convention specifiers
>       EmbeddedPkg/AndroidFastbootTransportTcpDxe: fix DestroyChild() call
>       EmbeddedPkg/Universal/MmcDxe: "fix" CloseProtocol() call in BindingStop()
>       EmulatorPkg/DxeTimerLib: drop superfluous cast
>       EmulatorPkg: stop abusing EFI_HANDLE for keystroke notify registration
>       MdeModulePkg: fix cast in GetModuleInfoFromHandle() calls
>       MdeModulePkg/UefiHiiLib: stop using EFI_HANDLE in place of EFI_HII_HANDLE
>       MdeModulePkg: stop abusing EFI_EVENT for protocol notify registration
>       MdeModulePkg/PlatformVarCleanupLib: fix HiiConstructConfigHdr() call
>       MdeModulePkg: document workaround for EFI_RUNTIME_EVENT_ENTRY PI spec bug
>       MdeModulePkg: stop abusing EFI_HANDLE for keystroke notify registration
>       MdeModulePkg: PEI Core: clean up "AprioriFile" handling in FindFileEx()
>       MdeModulePkg: fix UninstallMultipleProtocolInterfaces() calls
>       MdeModulePkg/PiSmmCore: make type punning consistent
>       MdeModulePkg/S3SaveState: cast Position for S3BootScriptLib explicitly
>       MdePkg/DxeServicesLib: remove bogus cast
>       NetworkPkg/DxeNetLib: fix type typo in NetLibGetMacAddress()
>       NetworkPkg: fix CloseProtocol & UninstallMultipleProtocolInterfaces calls
>       NetworkPkg/Ip4Dxe: fix NetLibDestroyServiceChild() call
>       NetworkPkg/TcpDxe: fix SockFreeFoo() parameter list
>       OvmfPkg/XenBusDxe: fix UninstallMultipleProtocolInterfaces() call
>       OvmfPkg/VirtioNetDxe: fix SignalEvent() call
>       OvmfPkg/PlatformDxe: fix EFI_HII_HANDLE parameters of internal functions
>       SecurityPkg: fix UninstallMultipleProtocolInterfaces() calls
>       SecurityPkg: stop abusing EFI_EVENT for protocol notify registration
>       ShellPkg/UefiShellDriver1CommandsLib: fix parameter list typo
>       ShellPkg: stop using EFI_HANDLE in place of EFI_HII_HANDLE
>       ShellPkg: stop taking EFI_HANDLE in place of SHELL_FILE_HANDLE
>       ShellPkg/UefiShellDebug1CommandsLib: fix ShellCloseFile() call
>       ShellPkg/UefiShellLib: clarify workaround for unfixable EdkShell bug
>       StandaloneMmPkg/Core: stop abusing EFI_HANDLE for FwVolHeader tracking
>       UefiPayloadPkg/BlSupportPei: fix MMCONFIG assignment from XSDT
>       UefiPayloadPkg/BlSupportDxe: fix ReserveResourceInGcd() calls
>       UefiCpuPkg/MpInitLib: expand comment on initial AP enumeration
>       UefiCpuPkg/MpInitLib: honor the platform's boot CPU count in AP detection
>       MdeModulePkg/BdsDxe: Fix calling PlatformBootManagerWaitCallback on 0
>       CryptoPkg/Crt: turn strchr() into a function (CVE-2019-14553)
>       CryptoPkg/Crt: satisfy "inet_pton.c" dependencies (CVE-2019-14553)
>       CryptoPkg/Crt: import "inet_pton.c" (CVE-2019-14553)
>       CryptoPkg/TlsLib: TlsSetVerifyHost: parse IP address literals as such (CVE-2019-14553)
>       MdeModulePkg/VariableSmmRuntimeDxe.inf: list local header "Variable.h"
>       CryptoPkg/OpensslLib: improve INF file consistency
>       CryptoPkg/OpensslLib.inf: list OpenSSL local header "ms/uplink.h"
>       MdeModulePkg/UefiBootManagerLib: log reserved mem allocation failure
>       NetworkPkg/HttpDxe: fix 32-bit truncation in HTTPS download
>       UefiCpuPkg/PiSmmCpuDxeSmm: fix 2M->4K page splitting regression for PDEs
>       OvmfPkg/OvmfXen.dsc: remove PcdCpu* dynamic defaults
>       OvmfPkg/IndustryStandard: define macros for QEMU's CPU hotplug registers
>       OvmfPkg/PlatformPei: rewrite MaxCpuCountInitialization() for CPU hotplug
>       SecurityPkg/DxeImageVerificationHandler: simplify "VerifyStatus"
>       SecurityPkg/DxeImageVerificationHandler: remove "else" after return/break
>       SecurityPkg/DxeImageVerificationHandler: keep PE/COFF info status internal
>       SecurityPkg/DxeImageVerificationHandler: narrow down PE/COFF hash status
>       SecurityPkg/DxeImageVerificationHandler: fix retval on memalloc failure
>       SecurityPkg/DxeImageVerificationHandler: remove superfluous Status setting
>       SecurityPkg/DxeImageVerificationHandler: unnest AddImageExeInfo() call
>       SecurityPkg/DxeImageVerificationHandler: eliminate "Status" variable
>       SecurityPkg/DxeImageVerificationHandler: fix retval for (FileBuffer==NULL)
>       SecurityPkg/DxeImageVerificationHandler: fix imgexec info on memalloc fail
>       SecurityPkg/DxeImageVerificationHandler: fix "defer" vs. "deny" policies
>       BaseTools/Conf/gitattributes: fix "--function-context" for C source code
>       OvmfPkg: introduce PcdQ35SmramAtDefaultSmbase
>       OvmfPkg/IndustryStandard: increase vertical whitespace in Q35 macro defs
>       OvmfPkg/IndustryStandard: add MCH_DEFAULT_SMBASE* register macros
>       OvmfPkg/PlatformPei: factor out Q35BoardVerification()
>       OvmfPkg/PlatformPei: detect SMRAM at default SMBASE (skeleton)
>       OvmfPkg/PlatformPei: assert there's no permanent PEI RAM at default SMBASE
>       OvmfPkg/PlatformPei: reserve the SMRAM at the default SMBASE, if it exists
>       OvmfPkg/SEV: don't manage the lifecycle of the SMRAM at the default SMBASE
>       OvmfPkg/SmmAccess: close and lock SMRAM at default SMBASE
>       OvmfPkg: introduce PcdCsmEnable feature flag
>       OvmfPkg/PlatformPei: detect SMRAM at default SMBASE (for real)
>       SecurityPkg/DxeImageVerificationLib: plug Data leak in IsForbiddenByDbx() (CVE-2019-14575)
>       OvmfPkg/QemuVideoDxe: unbreak "secondary-vga" and "bochs-display" support
>       MdeModulePkg/PiSmmCore: log SMM image start failure
>       UefiCpuPkg/PiSmmCpuDxeSmm: fix S3 Resume for CPU hotplug
>       OvmfPkg: clone SmmCpuPlatformHookLib from UefiCpuPkg
>       OvmfPkg: enable SMM Monarch Election in PiSmmCpuDxeSmm
>       OvmfPkg: enable CPU hotplug support in PiSmmCpuDxeSmm
>       OvmfPkg/CpuHotplugSmm: introduce skeleton for CPU Hotplug SMM driver
>       OvmfPkg/CpuHotplugSmm: add hotplug register block helper functions
>       OvmfPkg/CpuHotplugSmm: define the QEMU_CPUHP_CMD_GET_ARCH_ID macro
>       OvmfPkg/CpuHotplugSmm: add function for collecting CPUs with events
>       OvmfPkg/CpuHotplugSmm: collect CPUs with events
>       OvmfPkg/CpuHotplugSmm: introduce Post-SMM Pen for hot-added CPUs
>       OvmfPkg/CpuHotplugSmm: introduce First SMI Handler for hot-added CPUs
>       OvmfPkg/CpuHotplugSmm: complete root MMI handler for CPU hotplug
>       OvmfPkg: clone CpuS3DataDxe from UefiCpuPkg
>       OvmfPkg/CpuS3DataDxe: superficial cleanups
>       OvmfPkg/CpuS3DataDxe: enable S3 resume after CPU hotplug
>       ArmPkg: convert LFs to CRLF, expand hard TABs
>       ArmVirtPkg: convert LFs to CRLF
>       ArmPlatformPkg: convert LFs to CRLF, expand hard TABs
>       OvmfPkg/PlatformBootManagerLib: sync Timeout with PcdPlatformBootTimeOut
>       ArmVirtPkg/PlatformBootManagerLib: sync Timeout with PcdPlatformBootTimeOut
>       OvmfPkg/X86QemuLoadImageLib: fix "unused variable" error in X64 DXE builds
>       OvmfPkg: raise DXEFV size to 12 MB
>       OvmfPkg/QemuFlashFvbServicesRuntimeDxe: drop unused PCDs
>       OvmfPkg/QemuFlashFvbServices: factor out SetPcdFlashNvStorageBaseAddresses
>       OvmfPkg: set fixed FlashNvStorage base addresses with -D SMM_REQUIRE
>       OvmfPkg: include FaultTolerantWritePei and VariablePei with -D SMM_REQUIRE
>       OvmfPkg: improve SMM comms security with adaptive MemoryTypeInformation
>       OvmfPkg/PlatformPei: explain EFI_MEMORY_TYPE_INFORMATION page counts
>       OvmfPkg: give more telling names to some FDF include files
>       NetworkPkg/UefiPxeBcDxe: handle competing DHCP servers (more) gracefully
>       OvmfPkg: supply missing lib class declarations in the DEC file
>       MdeModulePkg/NonDiscoverablePciDeviceDxe: use standard PCI_MAX_BAR macro
>       OvmfPkg/ResetSystemLib: wrap long lines
>       OvmfPkg/ResetSystemLib: clean up library dependencies
>       OvmfPkg/ResetSystemLib: improve coding style in ResetSystem()
>       OvmfPkg/ResetSystemLib: factor out ResetShutdown()
>       OvmfPkg/ResetSystemLib: rename to BaseResetSystemLib
>       OvmfPkg/ResetSystemLib: introduce the DxeResetSystemLib instance
>       OvmfPkg: introduce QemuFwCfgSimpleParserLib
>       OvmfPkg/PlatformPei: parse "X-PciMmio64Mb" with QemuFwCfgSimpleParserLib
>       OvmfPkg/PlatformPei: use QemuFwCfgParseBool in UPDATE_BOOLEAN_PCD_FROM_...
>       OvmfPkg/QemuFwCfgDxeLib: allow UEFI_DRIVER modules
>       OvmfPkg: control PXEv4 / PXEv6 boot support from the QEMU command line
>       ArmVirtPkg/QemuFwCfgLib: allow UEFI_DRIVER modules
>       ArmVirtPkg: control PXEv4 / PXEv6 boot support from the QEMU command line
>       OvmfPkg/PlatformPei: don't track BS Code/Data in default MemTypeInfo HOB
>       OvmfPkg/PlatformPei: rewrite MemTypeInfo HOB production logic
>       OvmfPkg/PlatformPei: extract memory type info defaults to PCDs
>       OvmfPkg/PlatformPei: increase memory type info defaults
>       OvmfPkg/Tcg2ConfigPei: clean up some lib class dependencies
>       OvmfPkg/Tcg2ConfigPei: factor out InternalTpm12Detect()
>       OvmfPkg/Tcg2ConfigPei: skip TPM-1.2 detection when building for ARM/AARCH64
>       Maintainers.txt: retitle "MdeModulePkg: ACPI S3 modules"
>       Maintainers.txt: restore order of OvmfPkg sections
>       Maintainers.txt: move StandaloneMmPkg to the right spot
>       OvmfPkg/Tcg2ConfigPei: generalize TPM2-only file-top comments
>       OvmfPkg/Tcg2ConfigPei: restrict BaseLib class dependency to IA32 and X64
>       OvmfPkg/X86QemuLoadImageLib: handle EFI_ACCESS_DENIED from LoadImage()
>       OvmfPkg/GenericQemuLoadImageLib: log "Not Found" at INFO level
>       Revert "OvmfPkg: use generic QEMU image loader for secure boot enabled ..."
>       UefiCpuPkg/PiSmmCpuDxeSmm: pause in WaitForSemaphore() before re-fetch
>       OvmfPkg: fix DEC spec violation introduced by Bhyve addition
>       OvmfPkg/SmmControl2Dxe: negotiate ICH9_LPC_SMI_F_CPU_HOTPLUG
>       OvmfPkg/CpuHotplugSmm: fix CPU hotplug race just before SMI broadcast
>       OvmfPkg/CpuHotplugSmm: fix CPU hotplug race just after SMI broadcast
>       SecurityPkg/DxeImageVerificationLib: extract SecDataDirEnd, SecDataDirLeft
>       SecurityPkg/DxeImageVerificationLib: assign WinCertificate after size check
>       SecurityPkg/DxeImageVerificationLib: catch alignment overflow (CVE-2019-14562)
>
> Leendert van Doorn (1):
>       ArmVirtPkg: Include NVMe support in ArmVirtQemu*
>
> Leif Lindholm (38):
>       BaseTools: add centralized location for git config files
>       BaseTools: add script to configure local git options
>       ArmPlatformPkg: use UINT32 epoch second counter
>       EmbeddedPkg: improve TimeBaseLib type safety
>       Maintainers.txt: add Leif Lindholm as Package Reviewer of ArmVirtPkg
>       BaseTools: fix FCE build when edksetup not executed
>       Maintainers.txt: update for filesystem area descriptions
>       Maintainers.txt: add wildcard path association for Arm/AArch64
>       BaseTools: add GetMaintainer.py script
>       BaseTools: use stdint.h for GCC ProcessorBind.h typedefs
>       BaseTools: add missing newlines at end of files
>       EmbeddedPkg: add missing newline at end of TemplateResetSystemLib.inf
>       NetworkPkg: add missing newline at end of file
>       EmbeddedPkg: delete outdated FdtLib README.txt
>       BaseTools: fix line endings in SetupGit.py Conf files
>       DynamicTablesPkg: fix .dsc line ending
>       ArmPkg: ArmScmiDxe - convert .h to from 8859-x to 7-bit
>       BaseTools: correct line endings for ConvertFce Python script
>       EmbeddedPkg: convert Lauterbach README.txt to 7-bit safe Readme.md
>       ArmPkg: strip trailing whitespace
>       ArmPlatformPkg: strip trailing whitespace
>       BaseTools: strip trailing whitespace
>       EmulatorPkg: strip trailing whitespace
>       MdeModulePkg: strip trailing whitespace
>       OvmfPkg: strip trailing whitespace
>       UefiCpuPkg: strip trailing whitespace
>       SignedCapsulePkg: fix AARCH64 build
>       Readme.md: remove positional references from submodule description
>       Maintainers.txt: update email address for Leif Lindholm
>       ArmVirtPkg: fix ASSERT in ArmVirtGicArchLib with virtualization=on
>       ArmPkg: rename misleading local #define in CpuDxe
>       BaseTools: add handling for 'S:' flag to GetMaintainer.py
>       ArmPkg: only attempt buildin MmCommunicationDxe for AArch64
>       BaseTools/PatchCheck.py: add exception for diff orderfile
>       BaseTools: explicitly import email.header PatchCheck.py
>       BaseTools: convert diff.order to LF-only
>       EmbeddedPkg: fix gcc build errors in AndroidBootImgLib
>       Revert "BaseTools/PatchCheck.py: Add LicenseCheck"
>
> Leo Duran (2):
>       UefiCpuPkg/MpInitLib: Skip reading PlatformId on AMD processors.
>       UefiCpuPkg/MpInitLib: Remove Executable attribute from MpLib.h
>
> Li, Aaron (1):
>       BaseTools/Capsule: Add capsule dependency support
>
> Liming Gao (51):
>       Remove IntelSiliconPkg that has been moved to edk2-platform repo
>       Maintainers.txt: update it to remove IntelSiliconPkg maintainers
>       Revert "BaseTools/FCE: Change FCE script type in PosixLike"
>       Revert "BaseTools/BfmLib: Change BfmLib script type in PosixLike"
>       Revert "BaseTools/FMMT: Change FMMT script type in PosixLike"
>       Revert "BaseTools: fix FCE build when edksetup not executed"
>       Revert "BaseTools/FMMT: Add a tool FMMT"
>       Revert "BaseTools/FCE: Add a tool FCE"
>       Revert "BaseTools/BfmLib: Add a tool BfmLib"
>       MdeModulePkg RegularExpressionDxe: Update Oniguruma from v6.9.0 to v6.9.3
>       MdeModulePkg/RegularExpressionDxe: Add two missing null pointer checks
>       Readme.md: Remove tag release from Readme
>       BaseTools: Update GenFw tool to support -e -z option together
>       SecurityPkg Tcg2Config: Move common definitions to new Tcg2Internal.h
>       MdeModulePkg SerialDxe.inf: Fix wrong FILE_GUID format
>       Revert "BaseTools: Improve GetDependencyList function"
>       MdePkg Base.h: Define STATIC_ASSERT macro as empty for EBC arch
>       NetworkPkg: Move network related header files from MdeModulePkg to NetworkPkg
>       MdeModulePkg: Remove network related guid definitions from MdeModulePkg.dec
>       NetworkPkg: Add PcdTftpBlockSize in NetworkPkg.dec
>       NetworkPkg UefiPxeBcDxe: Consume PcdTftpBlockSize defined in NetworkPkg.dec
>       MdeModulePkg: Remove PCD gEfiMdeModulePkgTokenSpaceGuid.PcdTftpBlockSize
>       NetworkPkg: Remove unnecessary MdeModulePkg/MdeModulePkg.dec dependency in INF
>       Maintainers.txt: Move ShellBin maintainers to EDK II Releases section
>       SecurityPkg Tcg2Dxe: Add Variable Arch protocol dependency
>       BaseTools tools_def.template: Remove unnecessary $(DEST_DIR_DEBUG) path
>       BaseTools tools_def: Add CLANG9 tool chain to directly generate PE image
>       BaseTools GenFw: Fix the issue to update the wrong size as SectionSize
>       MdePkg Base.h: Add definition for CLANG9 tool chain
>       MdePkg BaseIoLibIntrinsic: Remove __inline__ attribute for IO functions
>       MdeModulePkg LzmaCustomDecompressLib: Update macro to be same in CLANG tool
>       MdeModulePkg RegularExpressionDxe: Disable warning for CLANG9 tool chain
>       CryptoPkg: Append options to make CLANG9 tool chain pass build
>       CryptoPkg IntrinsicLib: Make _fltused always be used
>       EmulatorPkg: Enable CLANG9 tool chain
>       OvmfPkg: Enable CLANG9 tool chain
>       BaseTools: Rename tool chain CLANG9 to CLANGPDB
>       MdeModulePkg RegularExpressionDxe: Update tool chain name to CLANGPDB
>       CryptoPkg CryptoLib: Update tool chain name to CLANGPDB
>       OvmfPkg DSC: Update tool chain name to CLANGPDB
>       EmulatorPkg DSC and WinHost.inf: Update tool chain name to CLANGPDB
>       MdePkg Base.h: Use correct style to check the defined macro
>       MdePkg Base.h: Use correct style to check macro _MSC_VER value
>       BaseTools tools_def.template: Add back -fno-pie option in GCC49 tool chain
>       OvmfPkg: Fix build failure with VS2015 tool chain
>       MdePkg: Add EFI_RT_PROPERTIES_TABLE
>       BaseTools GenFv: Report the correct spare FV image size
>       BaseTools: Move VS2019 env setting after VS2017 env setting
>       BaseTools: Fix the issue in VS prefix setting for VS2017/VS2019
>       BaseTools: Fix the issue in VS2017/VS2019 setting
>       Maintainers.txt: Update Liming mail address
>
> Liran Alon (20):
>       OvmfPkg/PvScsiDxe: Create empty driver
>       OvmfPkg/PvScsiDxe: Install DriverBinding protocol
>       OvmfPkg/PvScsiDxe: Report name of driver
>       OvmfPkg/PvScsiDxe: Probe PCI devices and look for PvScsi
>       OvmfPkg/PvScsiDxe: Install stubbed EXT_SCSI_PASS_THRU
>       OvmfPkg/PvScsiDxe: Report the number of targets and LUNs
>       OvmfPkg/PvScsiDxe: Translate Target & LUN to/from DevicePath
>       OvmfPkg/PvScsiDxe: Open PciIo protocol for later use
>       OvmfPkg/PvScsiDxe: Backup/Restore PCI attributes on Init/UnInit
>       OvmfPkg/PvScsiDxe: Enable MMIO-Space & Bus-Mastering in PCI attributes
>       OvmfPkg/PvScsiDxe: Define device interface structures and constants
>       OvmfPkg/PvScsiDxe: Reset adapter on init
>       OvmfPkg/PvScsiDxe: Setup requests and completions rings
>       OvmfPkg/PvScsiDxe: Introduce DMA communication buffer
>       OvmfPkg/PvScsiDxe: Support sending SCSI request and receive response
>       OvmfPkg/PvScsiDxe: Reset device on ExitBootServices()
>       OvmfPkg/PvScsiDxe: Enable device 64-bit DMA addresses
>       Maintainers.txt: Add Liran and Nikita as OvmfPkg/PvScsiDxe reviewers
>       OvmfPkg/PvScsiDxe: Fix VS2019 build error because of implicit cast
>       OvmfPkg/PvScsiDxe: Refactor setup of rings to separate function
>
> Maciej Rabeda (7):
>       NetworkPkg/SnpDxe: Add PCD to remove ExitBootServices event from SNP driver.
>       Maintainers.txt: Adding new NetworkPkg reviewer.
>       NetworkPkg: Fixes to static code analysis hits
>       Maintainers.txt: Update email address and role
>       NetworkPkg/Ip6Dxe: Improve Neightbor Discovery message validation.
>       ShellPkg: Fix 'ping' command Ip4 receive flow.
>       NetworkPkg/Ip6Dxe: Fix ASSERT logic in Ip6ProcessRouterAdvertise()
>
> Maggie Chu (7):
>       SecurityPkg/OpalPassword: Add PCD to skip password prompt
>       SecurityPkg/HddPassword: Add a PCD to skip Hdd password prompt
>       MdeModulePkg: Add definitions for NVM Express Passthru PPI
>       MdeModulePkg/NvmExpressPei: Produce NVM Express PassThru PPI
>       MdeModulePkg/NvmExpressPei: Fix Opal S3 unlock issue
>       SecurityPkg/OpalPassword: Remove dependency on EFI_BLOCK_IO_PROTOCOL
>       SecurityPkg: Change default value source
>
> Marc W Chen (3):
>       OvmfPkg/QemuVideoDxe: Shouldn't assume system in VGA alias mode.
>       MdePkg: Add PI 1.5 SmramMemoryReserve HOB file
>       MdePkg: Add MmAccess and MmControl definition.
>
> Marc-André Lureau (5):
>       OvmfPkg: rename TPM2 config prefix to TPM
>       OvmfPkg: detect TPM 1.2 in Tcg2ConfigPei
>       OvmfPkg: include TcgPei module
>       OvmfPkg: include TcgDxe module
>       OvmfPkg: plug DxeTpmMeasureBootLib into SecurityStubDxe
>
> Marcin Wojtas (1):
>       MdeModulePkg/UsbBusDxe: Return error when the device is not present
>
> Marvin Häuser (8):
>       WinHost: Add SimplePointer support
>       MdePkg/UefiDebugLibConOut: Pass the correct buffer size
>       MdePkg/UefiDebugLibStdErr: Pass the correct buffer size
>       MdePkg/UefiFileHandleLib: Fix potential NULL dereference
>       MdePkg/UefiFileHandleLib: Tolerate more Root handle FileNames
>       ShellPkg/Ls: Consider UEFI timezone may not be set
>       ShellPkg/Ls: Return empty content for all empty folders
>       ShellPkg/CommandLib: Use first found UC for unsupported PlatformLang
>
> Matt DeVillier (3):
>       MdeModulePkg/Usb/EfiKey: Fix endpoint selection
>       MdeModulePkg/Usb/UsbMouse: Fix endpoint selection
>       MdeModulePkg/UsbMouseAbsolutePointer: Fix endpoint selection
>
> Matthew Carlson (2):
>       BaseTools:Added arch output to build report
>       MdePkg/SmBios.h: Add two additional DWORD for smbios 3.3.0 type17
>
> Max Knutsen (1):
>       BaseTools:Add extra debugging message
>
> Michael D Kinney (93):
>       MdeModulePkg/PiSmmCore: Use unique structure signatures
>       ShellPkg/AcpiView: Fix IA32 link error
>       ShellPkg: Add shell with all commands integrated
>       EmulatorPkg: Fix VS2015 build when VS2017 also installed
>       EmulatorPkg/Unix/Host: Fix NetworkPkg dependencies
>       EmulatorPkg/Unix/Host: Fix XCODE5 IA32/X64 build failure
>       MdePkg/X64/ProcessorBind.h: Fix EmulatorPkg X64 XCODE5
>       BaseTools/PatchCheck: Ignore blank lines in diff
>       BaseTools/PatchCheck: Add copy from/to keywords
>       BaseTools/PatchCheck: Disable text conversion in 'git show'
>       EmulatorPkg: Fix VS20xx IA32 boot failure
>       EmulatorPkg: Remove UNIX_SEC_BUILD/WIN_SEC_BUILD
>       EmulatorPkg: Add -D DISABLE_NEW_DEPRECATED_INTERFACES
>       EmulatorPkg: Add support for NOOPT target
>       EmulatorPkg/Win/Host: Fix image unload regression
>       EmulatorPkg/Win/Host: Fix SecPrint() log line endings
>       SecurityPkg: Change EFI_D_INFO to DEBUG_INFO
>       Maintainers.txt: Add continuous integration(CI) directories
>       CryptoPkg: Add YAML file for CI builds
>       FatPkg: Add YAML file for CI builds
>       FmpDevicePkg: Add YAML file for CI builds
>       MdeModulePkg: Add YAML file for CI builds
>       MdePkg: Add YAML file for CI builds
>       NetworkPkg: Add YAML file for CI builds
>       PcAtChipsetPkg: Add YAML files for CI builds
>       SecurityPkg: Add YAML files for CI builds
>       ShellPkg: Add YAML file for CI builds
>       UefiCpuPkg: Add YAML file for CI builds
>       SignedCapsulePkg: Use BaseCryptLibNull to reduce package CI time
>       .mergify: Add Mergify YML pull request rules configuration file
>       Readme.md: Add CI build status badges
>       Readme.md: Update EDK II CI build status badge and links
>       Readme.md: Update EDK II CI build branch name
>       BaseTools/Scripts/PatchCheck: Address false error conditions
>       BaseTools/Scripts/PatchCheck.py: Remove submodule false positives
>       BaseTools/DscBuildData: Fix PCD autogen include file conflict
>       CryptoPkg/BaseCryptLibNull: Add missing HkdfSha256ExtractAndExpand()
>       BaseTools/Build: Do not use Common.lib in Structured PCD app
>       CryptoPkg/BaseCryptLib: Add X509ConstructCertificateStackV().
>       CryptoPkg: Add EDK II Crypto Protocols/PPIs/PCDs
>       CryptoPkg/Driver: Add Crypto PEIM, DXE, and SMM modules
>       CryptoPkg/Library: Add BaseCryptLibOnProtocolPpi instances
>       CryptoPkg/CryptoPkg.dsc: Add build of Crypto libraries/modules
>       .pytool: Add CI support for host based unit tests with results
>       BaseTools/Plugin: Add HostBasedUnitTestRunner plugin
>       UnitTestFrameworkPkg: Add public and private interfaces
>       UnitTestFrameworkPkg/Library: Add library instances
>       UnitTestFrameworkPkg/Test: Add unit test samples
>       UnitTestFrameworkPkg: Add DSC, DSC INC, and YAML files
>       MdePkg/Test: Add SafeIntLib and BaseLib Base64 unit tests
>       MdeModulePkg: Add DxeResetSystemLib unit test
>       .azurepipelines: Enable CI for UnitTestFrameworkPkg and host tests
>       Maintainers.txt: Add UnitTestFrameworkPkg
>       UnitTestFrameworkPkg/UnitTestLib: Fix XCODE parenthesis issues
>       UnitTestFrameworkPkg: Disable EBC in DSC file
>       MdePkg: Disable EBC for unit tests in MdePkg.dsc
>       MdePkg/BaseSafeIntLib: Fix VS20xx IA32 link failures
>       MdePkg/Test/BaseLib: Add SAFE_STRING_CONSTRAINT_CHECK unit test
>       MdeModulePkg/Variable/RuntimeDxe: Fix return status from Reclaim()
>       BaseTools/Python: Allow HOST_APPLICATION to use NULL libraries
>       MdePkg/BaseCpuLibNull: Add Null version of CpuLib for host testing
>       MdePkg/BaseCacheMaintenanceLibNull: Add Null instance for host testing
>       MdePkg/BaseLib: Break out IA32/X64 GCC inline privileged functions
>       MdePkg/Library/BaseLib: Add BaseLib instance for host based unit tests
>       UnitTestFrameworkPkg: Use host libraries from MdePkg
>       UnitTestFrameworkPkg: Enable source level debug for host tests
>       UnitTestFrameworkPkg: Set host application stack size to 256KB
>       UnitTestFrameworkPkg: Change target mode DebugLib mapping
>       UnitTestFrameworkPkg/UnitTestLib: Move print log into cleanup
>       UnitTestFrameworkPkg/UnitTestLib: Fix target mode log messages
>       UnitTestFrameworkPkg/UnitTestLib: Add checks for ASSERT()
>       MdePkg/Include: Hook DebugLib _ASSERT() for unit tests
>       MdePkg/Include: Add UT_EXPECT_ASSERT_FAILURE() to UnitTestLib
>       MdePkg/Library/BaseStackCheckLib: Fix PCD type in INF
>       UnitTestFramewokPkg/SampleUnitTest: Use UT_EXPECT_ASSERT_FAILURE()
>       MdePkg/Library/UnitTestHostBaseLib: Add missing services
>       UefiCpuPkg/CpuCommonFeaturesLib: Fix spelling mistake
>       BaseTools/GenSec: Fix spelling mistake
>       MdeModulePkg/EbcDxe: Fix spelling mistake
>       MdeModulePkg/BdsDxe: Fix spelling mistake
>       BaseTools/VolInfo: Fix spelling mistake
>       EmbeddedPkg/NonCoherentIoMmuDxe: Apply BSD-2-Clause-Patent
>       MdeModulePkg/PeCoffImageEmulator.h: Apply BSD-2-Clause-Patent
>       MdePkg/BaseMemoryLibOptDxe: Apply BSD-2-Clause-Patent
>       Readme.rst: List submodules and links to licenses
>       MdeModulePkg/CapsuleApp: Fix spelling mistake
>       SecurityPkg/OpalPassword: Fix spelling mistake
>       EmulatorPkg: Fix spelling mistake for occurred
>       MdeModulePkg: Fix spelling mistake for occurred
>       MdePkg: Fix spelling mistake for occurred
>       OvmfPkg: Fix spelling mistake for occurred
>       SecurityPkg: Fix spelling mistake for occurred
>       ShellPkg: Fix spelling mistake for occurred
>
> Michael Johnson (1):
>       EmulatorPkg/TimerLib: Add missing GetTimeInNanoSecond function
>
> Michael Kubacki (54):
>       BaseTools: Fix GenMake multi-workspace failure
>       MdeModulePkg/Variable: Consolidate common parsing functions
>       MdeModulePkg/Variable: Parameterize GetNextVariableInternal () stores
>       MdeModulePkg/Variable: Parameterize VARIABLE_INFO_ENTRY buffer
>       MdeModulePkg/Variable: Parameterize auth status in VariableParsing
>       MdeModulePkg/Variable: Add a file for NV variable functions
>       MdeModulePkg VariableInfo: Always consider RT DXE and SMM stats
>       MdeModulePkg/Variable: Add RT GetVariable() cache support
>       MdeModulePkg/Variable: Add RT GetNextVariableName() cache support
>       OvmfPkg: Disable variable runtime cache
>       MdeModulePkg: Enable variable runtime cache by default
>       MdeModulePkg/Variable: Fix volatile variable RT cache update logic
>       MdeModulePkg/Variable: Initialize local variable "Variable"
>       MdeModulePkg/Variable: Initialize local variable "RtPtrTrack"
>       MdeModulePkg PeiCore: Fix typos
>       MdeModulePkg PeiCore: Improve comment semantics
>       MdeModulePkg/Variable: Fix VarErrorFlag RT cache offset calculation
>       ArmPkg/ArmPkg.dsc: Add missing components
>       ArmPlatformPkg/ArmPlatformPkg.dsc: Add missing components
>       MdeModulePkg Variable: Return GetVariable() attr if EFI_BUFFER_TOO_SMALL
>       MdeModulePkg VariablePei: Return GetVariable() attr if EFI_BUFFER_TOO_SMALL
>       Revert "TlsAuthConfigDxe: fix TlsCaCertificate attributes retrieval"
>       NetworkPkg/SnpDxe: Register SnpNotifyExitBootServices at TPL_CALLBACK
>       NetworkPkg/SnpDxe: Prevent invalid PCI BAR access
>       NetworkPkg/Ip6Dxe: Validate source data record length
>       .python/SpellCheck: Increase SpellCheck plugin max failures
>       MdeModulePkg/ReportStatusCodeRouter: Clear RSC Data buffer if Data is NULL
>       MdeModulePkg/ReportStatusCodeRouter: Revert end pointer on out of resources
>       MdeModulePkg/ReportStatusCodeRouter: Take HeaderSize into Consideration
>       MdeModulePkg/ReportStatusCodeRouter: Update RSC Data on reallocation
>       MdePkg/BaseLib: Add linked list iteration macros
>       MdeModulePkg/EhciDxe: Use BaseLib linked list iteration macros
>       MdeModulePkg/EhciPei: Use BaseLib linked list iteration macros
>       MdeModulePkg/XhciDxe: Use BaseLib linked list iteration macros
>       MdeModulePkg/UfsPassThruDxe: Use BaseLib linked list iteration macros
>       MdeModulePkg/RamDiskDxe: Use BaseLib linked list iteration macros
>       SecurityPkg/HddPassword: Use BaseLib linked list iteration macros
>       SecurityPkg: Add PCD for SW SMI Command port
>       SecurityPkg Tcg: Use SW SMI IO port PCD in Tpm.asl
>       BaseTools/Ecc: Replace deprecated function time.clock()
>       UnitTestFrameworkPkg/UnitTestResultReportLib: Use AsciiStrnCpyS()
>       MdePkg/UnitTestLib.h: Drop FrameworkHandle param from SaveFrameworkState()
>       UnitTestFrameworkPkg/UnitTestLib: Update SaveFrameworkState() signature
>       MdeModulePkg/PeiCore: Enable T-RAM evacuation in PeiCore (CVE-2019-11098)
>       UefiCpuPkg/CpuMpPei: Add GDT migration support (CVE-2019-11098)
>       UefiCpuPkg/SecMigrationPei: Add initial PEIM (CVE-2019-11098)
>       FmpDevicePkg/FmpDependencyLib: Correct ValidateDependency() documentation
>       FmpDevicePkg/FmpDependencyLib: Fix "exression" typo
>       FmpDevicePkg/FmpDependencyLib: Handle version string overflow
>       FmpDevicePkg/FmpDependencyCheckLib: Return unsatisfied on handle failure
>       FmpDevicePkg/FmpDxe: Better warn of potential ImageTypeId misconfig
>       FmpDevicePkg/FmpDxe: Indicate ESRT GUID on invalid ImageIdName
>       FmpDevicePkg/FmpDxe: Improve function parameter validation
>       FmpDevicePkg/FmpDxe: Fix Clang build error
>
> Mike Turner (1):
>       MdeModulePkg DxeCore: Fix for missing Memory Attributes Table (MAT) update
>
> Ming Tan (7):
>       EmulatorPkg/PlatformSmbiosDxe: fix a spell error of platform.
>       MdeModulePkg/StatusCodeHandler: do not output \n\r for string data
>       MdeModulePkg.dec: Change PCDs for status code.
>       EmulatorPkg/EmulatorPkg.dsc: Change PCDs type about status code
>       UefiPayloadPkg/UefiPayloadPkgIa*.dsc: Change some PCDs type
>       OvmfPkg/OvmfPkg*.dsc: Change PCDs type about status code
>       IntelFsp2Pkg/Tools/GenCfgOpt.py: Fix a bug about parse macro
>
> Nickle Wang (2):
>       MdeModulePkg/SetupBrowserDxe: Fix IsZeroGuid() ASSERT.
>       EmulatorPkg/WinHost: Enable network support.
>
> Nikita Leshenko (12):
>       OvmfPkg/MptScsiDxe: Create empty driver
>       OvmfPkg/MptScsiDxe: Install DriverBinding Protocol
>       OvmfPkg/MptScsiDxe: Report name of driver
>       OvmfPkg/MptScsiDxe: Probe PCI devices and look for MptScsi
>       OvmfPkg/MptScsiDxe: Install stubbed EXT_SCSI_PASS_THRU
>       OvmfPkg/MptScsiDxe: Report targets and one LUN
>       OvmfPkg/MptScsiDxe: Build and decode DevicePath
>       OvmfPkg/MptScsiDxe: Open PciIo protocol for later use
>       OvmfPkg/MptScsiDxe: Set and restore PCI attributes
>       OvmfPkg/MptScsiDxe: Initialize hardware
>       OvmfPkg/MptScsiDxe: Implement the PassThru method
>       OvmfPkg/MptScsiDxe: Reset device on ExitBootServices()
>
> Oleksiy Yakovlev (17):
>       MdePkg: Extend SERIAL_IO with DeviceTypeGuid
>       BaseTools: REST style formset
>       MdePkg: REST style formset
>       BaseTools: Bootable NVDIMM namespaces
>       MdePkg: Bootable NVDIMM namespaces
>       MdePkg: Add UEFI Spec Revision 2.8
>       MdePkg: UEFI JSON Capsule Support
>       MdePkg: Add new CPER Notification types
>       MdePkg: Fix OUT parameters marked as IN OUT
>       MdePkg: Add FMP Capsule Image Header extension
>       MdeModulePkg: Add FMP Capsule Image Header extension
>       SignedCapsulePkg: Add FMP Capsule Image Header extension
>       MdePkg: Add Serial Terminal Device Type Guid
>       MdePkg: Add New Memory Attributes
>       MdeModulePkg: Add New Memory Attributes
>       UefiCpuPkg: Update EFI_MEMORY_CACHETYPE_MASK definition
>       UefiCpuPkg: Add New Memory Attributes
>
> Park, Aiden (1):
>       edksetup.bat stuck on unicode locale Windows
>
> Patrick Rudolph (1):
>       UefiPayloadPkg: Make TerminalDxe build time configurable
>
> Paul Grimes (1):
>       MdePkg: Correcting EFI_ACPI_DMA_TRANSFER_TYPE_16_BIT definition
>
> Pavana.K (1):
>       CryptoPkg: Support for SHA384 & SHA512 RSA signing schemes
>
> Pete Batard (7):
>       ArmPlatformPkg: Add missing header files in INF file
>       MdeModulePkg/BdsDxe: Also call PlatformBootManagerWaitCallback on 0
>       OvmfPkg/PlatformBootManagerLib: Don't update progress if Pcd is 0
>       ArmVirtPkg/PlatformBootManagerLib: Don't update progress if Pcd is 0
>       MdePkg/Include: Add DCC and BCM2835 SPCR UART types
>       EmbeddedPkg/AcpiLib: add GICC table init macro for ACPI 6.3
>       EmbeddedPkg/TimeBaseLib: Add macros to get build year/month/day
>
> Peter Jones (1):
>       OvmfPkg: Make SOURCE_DEBUG_ENABLE actually need to be set to TRUE
>
> Philippe Mathieu-Daudé (59):
>       ArmPkg: DebugPeCoffExtraActionLib: debugger commands are not errors
>       ArmPkg: DebugPeCoffExtraActionLib: fix trivial comment typos
>       MdeModulePkg DxeCore: Fix typo in function name
>       MdeModulePkg/PiSmmCore: Fix typo in function name
>       StandaloneMmPkg/Core: Fix typo in function name
>       NetworkPkg/Ip6Dxe: Fix typo in comment
>       .pytool: Avoid "is" with a literal Python 3.8 warnings in CI plugins
>       BaseTools: Avoid "is" with a literal Python 3.8 warnings
>       .mailmap: Add a stub with documentation
>       .mailmap: Add an entry for Aaron Li
>       .mailmap: Add an entry for Antoine Coeur
>       .mailmap: Add an entry for Ard Biesheuvel
>       .mailmap: Add an entry for Ashley DeSimone
>       .mailmap: Add an entry for Baraneedharan Anbazhagan
>       .mailmap: Add an entry for Chasel Chiu
>       .mailmap: Add an entry for Christopher J Zurcher
>       .mailmap: Add an entry for Eric Dong
>       .mailmap: Add an entry for Erik Bjorge
>       .mailmap: Add an entry for Hao Wu
>       .mailmap: Add an entry for Hot Tian
>       .mailmap: Add an entry for Jiewen Yao
>       .mailmap: Add an entry for Jim Dailey
>       .mailmap: Add an entry for Laszlo Ersek
>       .mailmap: Add an entry for Liming Gao
>       .mailmap: Add an entry for Maciej Rabeda
>       .mailmap: Add an entry for Marc-Andre Lureau
>       .mailmap: Add an entry for Marvin Haeuser
>       .mailmap: Add an entry for Maurice Ma
>       .mailmap: Add an entry for Michael Kubacki
>       .mailmap: Add an entry for Ming Tan
>       .mailmap: Add an entry for Nikolai Saoukh
>       .mailmap: Add an entry for Philippe Mathieu-Daude
>       .mailmap: Add an entry for Ray Ni
>       .mailmap: Add an entry for Samer El-Haj-Mahmoud
>       .mailmap: Add an entry for Shenglei Zhang
>       .mailmap: Add an entry for Star Zeng
>       .mailmap: Add an entry for Vitaly Cheptsov
>       .mailmap: Add an entry for Vladimir Olovyannikov
>       .mailmap: Add an entry for Yonghong Zhu
>       .mailmap: Add an entry for Yu-Chen Lin
>       BaseTools/PatchCheck.py: Ignore CR and LF characters in subject length
>       BaseTools/PatchCheck.py: Extract email check code to EmailAddressCheck
>       BaseTools/PatchCheck.py: Check the committer email address
>       BaseTools/PatchCheck.py: Let EmailAddressCheck describe email checked
>       BaseTools/PatchCheck.py: Check the patch author email address
>       BaseTools/Scripts: Add log.mailmap to SetupGit.py
>       BaseTools/Scripts/PatchCheck.py: Detect emails rewritten by Groups.Io
>       BaseTools/Scripts/PatchCheck.py: Do not use mailmap
>       SecurityPkg: Fix incorrect return value when File is NULL
>       EmbeddedPkg/VirtualKeyboard: Fix a typo in EFI_INVALID_PARAMETER
>       MdeModulePkg/UsbBusDxe: Fix a typo
>       NetworkPkg: Fix a typo
>       NetworkPkg/DnsDxe: Fix a typo
>       NetworkPkg/HttpBootDxe: Fix a typo in variable name
>       OvmfPkg/Csm/LegacyBios: Fix a typo
>       OvmfPkg/Xen: Fix a typo
>       StandaloneMmPkg: Fix a typo
>       ShellPkg: Document ParseCommandLineToArgs returns EFI_INVALID_PARAMETER
>       ShellPkg: Document UpdateArgcArgv returns EFI_INVALID_PARAMETER
>
> Pierre Gondois (44):
>       ShellPkg/acpiview: GTDT updates for ACPI 6.3
>       DynamicTablesPkg: GTDT updates for ACPI 6.3
>       MdePkg: Add AML OpCode definition for ExternalOp
>       BaseTools: Script for converting .aml to .hex
>       BaseTools: Rationalise makefile generation
>       BaseTools: Remove caret in NASM_INC macro
>       MdePkg: Add AML FieldList OpCode definitions
>       ArmPkg/ArmMmuLib: Fix implicit cast
>       BaseTools: PatchCheck: Exclude bash scripts from CRLF check
>       BaseTools: Generate multiple rules when multiple output files
>       BaseTools: Rename AmlToHex script to AmlToC
>       BaseTools: Compile AML bytecode arrays into .obj file
>       BaseTools: Fix string concatenation
>       BaseTools: Add gcc flag to warn on void* pointer arithmetic
>       BaseTools: Factorize GCC flags
>       EmbeddedPkg: Fix build error for MmcDxe
>       DynamicTablesPkg: Update ASL build options
>       DynamicTablesPkg: AmlLib definitions
>       DynamicTablesPkg: AML grammar definition
>       DynamicTablesPkg: AML node definitions
>       DynamicTablesPkg: AML tree interface
>       DynamicTablesPkg: AML tree enumerator
>       DynamicTablesPkg: AML tree traversal
>       DynamicTablesPkg: AML tree iterator
>       DynamicTablesPkg: AML tree/node cloning
>       DynamicTablesPkg: AML utility interfaces
>       DynamicTablesPkg: AML and ASL string helper
>       DynamicTablesPkg: AML serialise interface
>       DynamicTablesPkg: AML debug logging
>       DynamicTablesPkg: AML ACPI Namespace interface
>       DynamicTablesPkg: AML Parser
>       DynamicTablesPkg: AML resource data helper
>       DynamicTablesPkg: AML resource data parser
>       DynamicTablesPkg: AML Method parser
>       DynamicTablesPkg: AML Field list parser
>       DynamicTablesPkg: AML Codegen
>       DynamicTablesPkg: AML Resource Data Codegen
>       DynamicTablesPkg: AML Core interface
>       DynamicTablesPkg: AmlLib APIs
>       DynamicTablesPkg: Dynamic AML: Add AmlLib library
>       DynamicTablesPkg: SSDT Serial Port Fixup library
>       DynamicTablesPkg: SSDT Serial Port generator
>       DynamicTablesPkg: Add SSDT Serial port for SPCR
>       DynamicTablesPkg: Add SSDT Serial port for DBG2
>
> Qi Zhang (8):
>       SecurityPkg/Tpm2CommandLib: add a new function
>       SecurityPkg/Tcg2Config: remove TPM2_ChangEPS if it is not supported.
>       SecurityPkg/TcgEventLogRecordLib: add new lib for firmware measurement
>       SecurityPkg/dsc: add FvEventLogRecordLib
>       SecurityPkg/Tcg2: handle PRE HASH and LOG ONLY
>       IntelFsp2WrapperPkg/dsc: add HashLib, Tpm2CommandLib and Tpm2DeviceLib
>       IntelFsp2WrapperPkg/IntelFsp2WrapperPkg.dec: add FspMeasurementLib.h
>       MdeModulePkg/Library: add PEIM and SEC module type to TpmMeasurementLibNull
>
> Ray Ni (49):
>       UefiCpuPkg/MpInitLib: increase NumApsExecuting only for ApInitConfig
>       UefiCpuPkg/MpInitLib: Decrease NumApsExecuting only for ApInitConfig
>       IntelFspPkg&IntelFspWrapperPkg: Remove them
>       UefiCpuPkg/PiSmmCpu: Change variable names and comments to follow SDM
>       MdePkg/BaseLib.h: Update IA32_CR4 structure for 5-level paging
>       UefiCpuPkg/PiSmmCpu: Enable 5 level paging when CPU supports
>       Maintainers.txt: Remove maintainer info for IntelFsp[Wrapper]Pkg
>       Revert "UefiCpuPkg/PiSmmCpu: Enable 5 level paging when CPU supports"
>       Revert "MdePkg/BaseLib.h: Update IA32_CR4 structure for 5-level paging"
>       MdePkg/BaseLib.h: Update IA32_CR4 structure for 5-level paging
>       UefiCpuPkg/PiSmmCpu: Enable 5 level paging when CPU supports
>       UefiCpuPkg/PiSmmCpu: ReclaimPages: fix incorrect operator binding
>       UefiCpuPkg/PiSmmCpu: Allow SMM access-out when static paging is OFF
>       UefiCpuPkg/MpInitLib: Enable 5-level paging for AP when BSP's enabled
>       UefiCpuPkg/CpuDxe: Remove unnecessary macros
>       UefiCpuPkg/CpuDxe: Support parsing 5-level page table
>       MdeModulePkg/DxeIpl: Introduce PCD PcdUse5LevelPageTable
>       MdePkg/Cpuid.h: Move Cpuid.h from UefiCpuPkg to MdePkg
>       MdeModulePkg/DxeIpl: Create 5-level page table for long mode
>       UefiCpuPkg|MdePkg: Move Register/ folder to MdePkg/Include/
>       UefiCpuPkg: Update code to include register definitions from MdePkg
>       UefiCpuPkg: Add PcdCpuSmmRestrictedMemoryAccess
>       UefiCpuPkg/PiSmmCpu: Use new PCD PcdCpuSmmRestrictedMemoryAccess
>       UefiCpuPkg/PiSmmCpu: Restrict access per PcdCpuSmmRestrictedMemoryAccess
>       UefiCpuPkg: Explain relationship between several SMM PCDs
>       PcAtChipsetPkg: add PcdRealTimeClockUpdateTimeout
>       MdeModulePkg: Remove PcdRealTimeClockUpdateTimeout
>       IntelFsp2Pkg/FspSecCore: Remove unneeded MdeModulePkg dependency
>       IntelFsp2WrapperPkg: Remove unneeded MdeModulePkg dependency
>       MdePkg/BluetoothLeConfig.h: Add type EfiBluetoothSmpPeerAddressList
>       UefiCpuPkg/PiSmmCpu: Enable 5L paging only when phy addr line > 48
>       UefiCpuPkg: Remove PcdCpuSmmStaticPageTable
>       UefiCpuPkg/MpInitLib: Set X2ApicEnable flag from BSP
>       UefiCpuPkg/MpInitLib: Remove global variable X2ApicEnable
>       BaseTools: Fix build failure when using python38
>       UefiCpuPkg/CpuCommonFeaturesLib: Remove XD enable/disable logic
>       UefiCpuPkg/RegisterCpuFeature: Remove CPU_FEATURE_XD macro
>       UefiCpuPkg/RegisterCpuFeaturesLib: Delete CPU_FEATURE_[BEFORE|AFTER]
>       UefiCpuPkg/RegisterCpuFeaturesLib: Rename [Before|After]FeatureBitMask
>       UefiCpuPkg/CpuFeature: Introduce First to indicate 1st unit.
>       UefiCpuPkg/PiSmmCpuDxeSmm: Improve the performance of GetFreeToken()
>       UefiCpuPkg/MpService: GetProcessorInfo returns 6-level topology
>       MdePkg/PciSegmentInfoLib: Add missing EFIAPI to GetPciSegmentInfo()
>       UefiPayloadPkg/Pci: Use the PCIE Base Addr stored in AcpiBoardInfo HOB
>       UefiCpuPkg/MtrrLib: Remove unnecessary API MtrrGetVariableMtrr()
>       UefiCpuPkg/MtrrLib: Remove unnecessary API MtrrSetVariableMtrr()
>       UefiCpuPkg/MtrrLib: Remove unnecessary API MtrrSetFixedMtrr()
>       UefiCpuPkg/MtrrLib/UnitTest: Add host based unit test
>       UefiCpuPkg/MtrrLibUnitTest: Change to use static array for CI test
>
> Rebecca Cran (21):
>       Fix indentation in edksetup.sh SetupPython3
>       edksetup.sh: Use bash variable $PWD instead of executing pwd command
>       edksetup.sh: Use $SCRIPTNAME consistently instead of 'edksetup.sh'
>       edksetup.sh: when executing arithmetic commands, $ isn't needed
>       edksetup.sh: remove redundant -?, -h and --help in options parsing
>       OvmfPkg/build.sh: enable multitheaded build by default
>       OvmfPkg/build.sh: remove literal carriage return
>       OvmfPkg/build.sh: remove $ADD_QEMU_HDA
>       OvmfPkg/build.sh: use newer '-drive if=pflash' syntax when running qemu
>       OvmfPkg: replace old EFI_D_ debug levels with new DEBUG_ ones
>       OvmfPkg: Add bhyve support into AcpiTimerLib
>       OvmfPkg: Add VBE2 mode info structure to LegacyVgaBios.h
>       OvmfPkg: Add QemuFwCfgLibNull
>       OvmfPkg: Add BaseResetSystemLibBhyve
>       BaseTools: add repo name option to SetupGit.py
>       ShellPkg: smbiosview - print field values as unsigned integers
>       BaseTools: Update ReadMe.txt to match current functionality
>       BaseTools: rename ReadMe.txt to ReadMe.rst
>       Add BhyvePkg, to support the bhyve hypervisor
>       Maintainers.txt: Add bhyve reviewers
>       OvmfPkg/Bhyve: rename files to remove 'Pkg' infix
>
> Robert Phelps (4):
>       MdePkg: New Status Codes
>       MdePkg: Updates to PI 1.7 Revision numbers
>       MdePkg: Added header file for Delayed Dispatch PPI
>       MdePkg: Update structures for MpServices Protocol
>
> Rodriguez, Christian (3):
>       BaseTools: Add a checking for Sources section in INF file
>       BaseTools: Refactor hash tracking after checking for Sources section
>       BaseTools: Fix checking for Sources section in INF file
>
> Roman Bolshakov (1):
>       OvmfPkg: Skip initrd command on Xcode toolchain
>
> Samer El-Haj-Mahmoud (3):
>       MdeModulePkg: PcdAcpiExposedTableVersions default for Arm64 platforms
>       ArmVirtPkg/ArmVirtQemu: Revert "limit ACPI support to v5.0 and higher"
>       ShellPkg: smbiosview - Change some type 17 field values format
>
> Sami Mujawar (35):
>       DynamicTablesPkg: Fix line endings in dsc file
>       DynamicTablesPkg: Disable deprecated APIs
>       DynamicTablesPkg: Arm SRAT Table Generator
>       StandaloneMmPkg: Fix build failure - Bug 2253
>       ShellPkg: acpiview: Add support for parsing FACS
>       ShellPkg: acpiview: IORT Spec Rev D updates
>       ArmPkg: Dispatch deferred images after EndOfDxe
>       DynamicTablesPkg: Update FADT generator to ACPI 6.3
>       DynamicTablesPkg: Fix entry point param definition
>       DynamicTablesPkg: Fix missing local header warning
>       DynamicTablesPkg: Remove struct CM_ARM_CPU_INFO
>       DynamicTablesPkg: Fix serial port subtype warning
>       DynamicTablesPkg: Fix Proc node length assignment
>       DynamicTablesPkg: Fix GT Block length assignment
>       DynamicTablesPkg: Fix Boot arch flag width
>       DynamicTablesPkg: Fix ACPI table rev field width
>       DynamicTablesPkg: Fix unaligned pointers usage
>       DynamicTablesPkg: Serial debug port initialisation
>       DynamicTablesPkg: Remove redundant frame count check
>       DynamicTablesPkg: Fix IORT node length assignment
>       DynamicTablesPkg: IORT: Fix uninitialized memory usage
>       DynamicTablesPkg: PPTT: Fix uninitialized memory usage
>       DynamicTablesPkg: Remove erroneous use of EFIAPI
>       DynamicTablesPkg: Option for VS2017 static code analysis
>       DynamicTablesPkg: SRAT: Fix entry points
>       DynamicTablesPkg: SRAT: Fix uninitialized memory usage
>       BaseTools: Remove deprecated Visual Studio Option
>       DynamicTablesPkg: Fix issues reported by EDKII CI
>       DynamicTablesPkg: Add EDK2 Core CI support
>       DynamicTablesPkg: Update release build flags
>       DynamicTablesPkg: Introduction to Dynamic AML
>       DynamicTablesPkg: AML stream interface
>       DynamicTablesPkg: Add AsciiFromHex helper function
>       .pytool: CI Settings to support DynamicTablesPkg
>       .azurepipelines: Add DynamicTablesPkg to CI matrix
>
> Sean Brogan (35):
>       BaseTools:replace the chinese quotation mark with unicode "
>       BaseTools/Capsule: Add WindowsCapsuleSupportHelper
>       MdePkg: Add UefiFileHandleLib to DSC file
>       FatPkg: Fix spelling errors
>       PcAtChipsetPkg: Fix spelling errors
>       FmpDevicePkg: Fix spelling errors
>       SecurityPkg: Fix spelling errors
>       CryptoPkg: Add missing components to CryptoPkg.dsc
>       CryptoPkg: Add Null instance of the TlsLib class
>       UefiCpuPkg: Add missing components to UefiCpuPkg.dsc
>       CryptoPkg: Add Null instance of the BaseCryptLib class
>       NetworkPkg: Add missing components to DSC file
>       .gitignore: Ignore python compiled files, extdeps, and vscode
>       pip-requirements.txt: Add python pip requirements file
>       BaseTools: Add RC_PATH define for VS2017/2019
>       BaseTools: Add YAML files with path env and tool extdeps
>       BaseTools: Add BaseTools plugins to support CI
>       .pytool/Plugin: Add CI plugins
>       .pytool: Add CISettings.py and Readme.md
>       .azurepipelines: Add Azure Pipelines YML configuration files
>       MdeModulePkg/NvmExpressDxe: Fix wrong queue size for async IO queues
>       BaseTools/WindowsVsToolChain: Clean up Python source formatting
>       BaseTools/WindowsVsToolChain: Setup VS2017/VS2019 env
>       BaseTools/PcdValueCommon: Fix 64-bit host compiler error
>       BaseTools: Update Edk2ToolsBuild.py to use multiple threads on Linux
>       .azurepipelines: Update CI steps
>       .azurepipelines: Add Platform CI template
>       ArmVirtPkg: Add Platform CI and configuration for Core CI
>       EmulatorPkg: Add Platform CI and configuration for Core CI
>       OvmfPkg: Add Platform CI and configuration for Core CI
>       .pytool: Update CI Settings to support Emulator, ArmVirt, and Ovmf packages
>       .azurepipelines: Update Core CI build matrix to include platforms
>       ReadMe: Convert to rst and add Platform CI Status
>       .pytool/CISettings: Remove Windows only scope for host based unit tests
>       BaseTools/Plugin: Update HostBasedUnitTestRunner to support Linux
>
> Shenglei Zhang (103):
>       SecurityPkg/DxeDeferImageLoadLib: Remove DxeDeferImageLoadLib
>       SecurityPkg: Remove DxeDeferImageLoadLib in DSC
>       BaseTools/BfmLib: Add a tool BfmLib
>       BaseTools/FCE: Add a tool FCE
>       BaseTools/FMMT: Add a tool FMMT
>       BaseTools/FMMT: Change FMMT script type in PosixLike
>       BaseTools/BfmLib: Change BfmLib script type in PosixLike
>       BaseTools/FCE: Change FCE script type in PosixLike
>       MdeModulePkg: Fix typos and add periods
>       SecurityPkg/FvReportPei: Change HashAlgoId to HashAlgId
>       UefiCpuPkg/PiSmmCpuDxeSmm: Keep function comment and declaration adjacent
>       SecurityPkg/SecurityPkg.dec: Remove trailing white space
>       MdeModulePkg: Remove S3Lib.h and PeiS3LibNull
>       MdeModulePkg: Remove RecoveryLib.h and PeiRecoveryLibNull
>       UefiCpuPkg/PiSmmCpuDxeSmm: Add check for pointer Pml5Entry
>       UefiCpuPkg/PiSmmCpuDxeSmm: Make code consistent with comments
>       MdeModulePkg/DxeCapsuleLibFmp: Add missing description for parameter
>       MdeModulePkg: Add missing header files in INF files
>       MdePkg/BaseUefiDecompressLib: Add missing description for parameter
>       ShellPkg/UefiShellAcpiViewCommandLib: Add missing header files in INF
>       IntelFsp2Pkg/FspSecCore: Add missing header file in INF file
>       UefiCpuPkg/PiSmmCpuDxeSmm: Fix coding style
>       MdeModulePkg/DxeIplPeim: Relocate operation of PageMapLevel5Entry++
>       ShellPkg/UefiShellAcpiViewCommandLib: Remove the variable "Index"
>       NetworkPkg: Add Dpc protocol
>       NetworkPkg: Move Dpc.h from MdeModulePkg to NetworkPkg
>       MdeModulePkg/MdeModulePkg.dec: Remove gEfiDpcProtocolGuid
>       MdeModulePkg/DxeIplPeim: Initialize pointer PageMapLevel5Entry
>       CryptoPkg/OpensslLib: Add missing header files in INF file
>       ShellPkg/UefiShellAcpiViewCommandLib: Initialize local variables
>       UefiCpuPkg/Cpuid: Add description for parameter LeafFunction
>       CryptoPkg: Fix coding style
>       ShellPkg/UefiShellAcpiViewCommandLib: Replace shift logical left
>       MdePkg/MdePkg.dec: Update PciSegmentLib.h to S3PciSegmentLib.h
>       SecurityPkg/SecurityPkg.dec: Update TcgPpVendorLib.h to Tcg2PpVendorLib.h
>       EmulatorPkg/PeiEmuSerialPortLib: Update the INF file Guid
>       MdeModulePkg/SerialDxe: Update the file Guid in SerialDxe.inf
>       BaseTools/LzmaCompress: Add two switches
>       BaseTools/LzmaCompress: Fix the option "d" dictionary size
>       CryptoPkg/OpensslLib: Update process_files.pl to generate .h files
>       MdeModulePkg/Oniguruma: Remove redundant IF statement
>       MdeModulePkg/Variable/Pei: Update the condition in if statement
>       MdeModulePkg/HiiDatabaseDxe: ASSERT "Private->Attribute >> 4"
>       MdeModulePkg/SdBlockIoPei: Add check for DeviceIndex
>       MdeModulePkg/EhciPei: Initialize the variable Map
>       MdeModulePkg/UhciPei: Initialize the variable RequestMap
>       MdeModulePkg/Mem: Initialize the variable MapMemory
>       CryptoPkg: Upgrade OpenSSL to 1.1.1d
>       ShellPkg/Shell/FileHandleWrappers.c: Add check for MemFile->Buffer
>       MdeModulePkg/HiiDatabaseDxe: ASSERT StringPtr
>       MdeModulePkg/EsrtDxe: Add check for EsrtRepository
>       MdeModulePkg/SetupBrowserDxe: ASSERT GetBufferForValue(&Value)
>       MdeModulePkg/EbcDebugger: Add check for Entry and RetEntry
>       MdePkg: Update the comments of IsLanguageSupported
>       MdeModulePkg/MdeModulePkg.uni: Add missing strings for PCD
>       NetworkPkg/NetworkPkg.uni: Add missing strings for PCD
>       UefiCpuPkg/UefiCpuPkg.uni: Add missing strings for PCD
>       UefiCpuPkg: Update the coding styles
>       MdeModulePkg/RegularExpressionDxe: Make oniguruma a submodule in edk2.
>       pip-requirements.txt: Update extensions min version to 0.13.3
>       .azurepiplines/pr-gate-steps.yml: Update python to 3.8.x for ci build
>       BaseTools/WindowsVsToolChain.py: Update toolchain plugin
>       MdeModulePkg/BrotliCustomDecompressLib: Make brotli a submodule
>       BaseTools: Make brotli a submodule
>       NetworkPkg/IScsiDxe: Enhance the check for array boundary
>       .gitmodules: ignore untracked files in brotli
>       MdeModulePkg/RegularExpressionDxe: Optimize the code infrastructure
>       NetworkPkg/DxeNetLib: Change the order of conditions in IF statement
>       BaseTools/PatchCheck.py: Add LicenseCheck
>       BaseTools/PatchCheck.py: Skip length check for user name in xxx-by
>       .pytool/Plugin: Add a plugin LicenseCheck
>       FatPkg/FatPkg.ci.yaml: Add configuration for LicenseCheck
>       ArmVirtPkg/ArmVirtPkg.ci.yaml: Add configuration for LicenseCheck
>       CryptoPkg/CryptoPkg.ci.yaml: Add configuration for LicenseCheck
>       EmulatorPkg/EmulatorPkg.ci.yaml: Add configuration for LicenseCheck
>       FmpDevicePkg/FmpDevicePkg.ci.yaml: Add configuration for LicenseCheck
>       MdeModulePkg/MdeModulePkg.ci.yaml: Add configuration for LicenseCheck
>       MdePkg/MdePkg.ci.yaml: Add configuration for LicenseCheck
>       NetworkPkg/NetworkPkg.ci.yaml: Add configuration for LicenseCheck
>       OvmfPkg/OvmfPkg.ci.yaml: Add configuration for LicenseCheck
>       PcAtChipsetPkg/PcAtChipsetPkg.ci.yaml: Add configuration for LicenseCheck
>       SecurityPkg/SecurityPkg.ci.yaml: Add configuration for LicenseCheck
>       ShellPkg/ShellPkg.ci.yaml: Add configuration for LicenseCheck
>       UefiCpuPkg/UefiCpuPkg.ci.yaml: Add configuration for LicenseCheck
>       UnitTestFrameworkPkg: Add configuration for LicenseCheck in yaml file
>       pip-requirements.txt: Add Ecc required lib
>       .pytool/Plugin: Add a plugin EccCheck
>       MdeModulePkg/MdeModulePkg.ci.yaml: Add configuration for Ecc check
>       ArmVirtPkg/ArmVirtPkg.ci.yaml: Add configuration for Ecc check
>       CryptoPkg/CryptoPkg.ci.yaml: Add configuration for Ecc check
>       EmulatorPkg/EmulatorPkg.ci.yaml: Add configuration for Ecc check
>       FatPkg/FatPkg.ci.yaml: Add configuration for Ecc check
>       FmpDevicePkg/FmpDevicePkg.ci.yaml: Add configuration for Ecc check
>       MdePkg/MdePkg.ci.yaml: Add configuration for Ecc check
>       NetworkPkg/NetworkPkg.ci.yaml: Add configuration for Ecc check
>       OvmfPkg/OvmfPkg.ci.yaml: Add configuration for Ecc check
>       PcAtChipsetPkg/PcAtChipsetPkg.ci.yaml: Add configuration for Ecc check
>       SecurityPkg/SecurityPkg.ci.yaml: Add configuration for Ecc check
>       ShellPkg/ShellPkg.ci.yaml: Add configuration for Ecc check
>       UefiCpuPkg/UefiCpuPkg.ci.yaml: Add configuration for Ecc check
>       UnitTestFrameworkPkg: Add configuration for Ecc check in yaml file
>       .pytool/EccCheck: Disable Ecc error code 10014 for open CI
>       Revert ".pytool/EccCheck: Disable Ecc error code 10014 for open CI"
>
> Siyuan Fu (10):
>       Maintainers.txt: Change NetworkPkg maintainer role.
>       NetworkPkg/SnpDxe: Use PcdGetBool() instead of FixedPcdGetBool in Snp.c
>       UefiCpuPkg: Remove alignment check when calculate microcode size.
>       UefiCpuPkg: Always load microcode patch on AP processor.
>       MdePkg: Add header file for Firmware Interface Table specification.
>       UefiCpuPkg: Shadow microcode patch according to FIT microcode entry.
>       MdeModulePkg/Capsule: Remove RT restriction in UpdateCapsule service.
>       UefiCpuPkg: Remove FIT based microcode shadow logic from MpInitLib.
>       MdePkg: Remove FIT table industry standard header file.
>       NetworkPkg/ArpDxe: Recycle invalid ARP packets (CVE-2019-14559)
>
> Star Zeng (11):
>       UefiCpuPkg CpuCommFeaturesLib: Disable TraceEn at the beginning
>       UefiCpuPkg CpuCommFeaturesLib: Fix GP fault issue about ProcTrace
>       UefiCpuPkg CpuCommFeaturesLib: Fix ASSERT if LMCE is supported
>       UefiCpuPkg CpuCommFeaturesLib: Reduce to set MSR_IA32_CLOCK_MODULATION
>       UefiCpuPkg RegisterCpuFeaturesLib.h: Fix typo 'STRICK' to 'STRIKE'
>       MdeModulePkg SmbiosMeasurementDxe: Add Type4 Voltage field to blacklist
>       UefiCpuPkg RegisterCpuFeaturesLib: Fix an ASSERTION issue
>       UefiCpuPkg CpuCommonFeaturesLib: Enhance Ppin code
>       UefiCpuPkg DxeRegisterCpuFeaturesLib: Fix VS2012 build failure
>       SourceLevelDebugPkg DebugCommLibUsb3: Address NULL ptr dereference case
>       UefiCpuPkg RegisterCpuFeaturesLib: Match data type and format specifier
>
> Stephano Cetola (1):
>       EmulatorPkg: update HOST_TOOLS to xcode5
>
> Steven Shi (17):
>       BaseTools:Build cache cannot store the cache files for library package
>       BaseTools:Build Cache output notification message
>       BaseTools: Cannot store library cache of different arch together
>       BaseTools:Introduce CopyFileOnChange() function to copy cache files
>       BaseTools: Improve the cache hit in the edk2 build cache
>       BaseTools: Print first cache missing file for build cachle
>       BaseTools: Change the [Arch][Name] module key in Build cache
>       BaseTools: Add GenFds multi-thread support in build cache
>       BaseTools: Improve the file saving and copying reliability
>       BaseTools: Support long file path in windows for misc functions
>       BaseTools: Support more file types in build cache
>       BaseTools: Add more parameter checking for CopyFileOnChange()
>       BaseTools: store more complete output files in binary cache
>       BaseTools: enhance the CacheCopyFile method arg names
>       BaseTools: Leverage compiler output to optimize binary cache
>       BaseTools: Remove redundant binary cache file
>       BaseTools: Enhance call stack unwindability for CLANGPDB x64 binary
>
> Sunny Wang (1):
>       MdeModulePkg/BdsDxe: Fix PlatformRecovery issue
>
> Tom Lendacky (50):
>       UefiCpuPkg/CpuExceptionHandler: Make XCODE5 changes toolchain specific
>       OvmfPkg: Use toolchain appropriate CpuExceptionHandlerLib
>       UefiCpuPkg/CpuExceptionHandler: Revert CpuExceptionHandler binary patching
>       MdeModulePkg: Create PCDs to be used in support of SEV-ES
>       UefiCpuPkg: Create PCD to be used in support of SEV-ES
>       MdePkg: Add the MSR definition for the GHCB register
>       MdePkg: Add a structure definition for the GHCB
>       MdeModulePkg/DxeIplPeim: Support GHCB pages when creating page tables
>       MdePkg/BaseLib: Add support for the XGETBV instruction
>       MdePkg/BaseLib: Add support for the VMGEXIT instruction
>       UefiCpuPkg: Implement library support for VMGEXIT
>       OvmfPkg: Prepare OvmfPkg to use the VmgExitLib library
>       UefiPayloadPkg: Prepare UefiPayloadPkg to use the VmgExitLib library
>       UefiCpuPkg/CpuExceptionHandler: Add base support for the #VC exception
>       OvmfPkg/VmgExitLib: Implement library support for VmgExitLib in OVMF
>       OvmfPkg/VmgExitLib: Add support for IOIO_PROT NAE events
>       OvmfPkg/VmgExitLib: Support string IO for IOIO_PROT NAE events
>       OvmfPkg/VmgExitLib: Add support for CPUID NAE events
>       OvmfPkg/VmgExitLib: Add support for MSR_PROT NAE events
>       OvmfPkg/VmgExitLib: Add support for NPF NAE events (MMIO)
>       OvmfPkg/VmgExitLib: Add support for WBINVD NAE events
>       OvmfPkg/VmgExitLib: Add support for RDTSC NAE events
>       OvmfPkg/VmgExitLib: Add support for RDPMC NAE events
>       OvmfPkg/VmgExitLib: Add support for INVD NAE events
>       OvmfPkg/VmgExitLib: Add support for VMMCALL NAE events
>       OvmfPkg/VmgExitLib: Add support for RDTSCP NAE events
>       OvmfPkg/VmgExitLib: Add support for MONITOR/MONITORX NAE events
>       OvmfPkg/VmgExitLib: Add support for MWAIT/MWAITX NAE events
>       OvmfPkg/VmgExitLib: Add support for DR7 Read/Write NAE events
>       OvmfPkg/MemEncryptSevLib: Add an SEV-ES guest indicator function
>       OvmfPkg: Add support to perform SEV-ES initialization
>       OvmfPkg: Create a GHCB page for use during Sec phase
>       OvmfPkg/PlatformPei: Reserve GHCB-related areas if S3 is supported
>       OvmfPkg: Create GHCB pages for use during Pei and Dxe phase
>       OvmfPkg/PlatformPei: Move early GDT into ram when SEV-ES is enabled
>       UefiCpuPkg: Create an SEV-ES workarea PCD
>       OvmfPkg: Reserve a page in memory for the SEV-ES usage
>       OvmfPkg/PlatformPei: Reserve SEV-ES work area if S3 is supported
>       OvmfPkg/ResetVector: Add support for a 32-bit SEV check
>       OvmfPkg/Sec: Add #VC exception handling for Sec phase
>       OvmfPkg/Sec: Enable cache early to speed up booting
>       OvmfPkg/QemuFlashFvbServicesRuntimeDxe: Bypass flash detection with SEV-ES
>       UefiCpuPkg: Add a 16-bit protected mode code segment descriptor
>       UefiCpuPkg/MpInitLib: Add CPU MP data flag to indicate if SEV-ES is enabled
>       UefiCpuPkg: Allow AP booting under SEV-ES
>       OvmfPkg: Use the SEV-ES work area for the SEV-ES AP reset vector
>       OvmfPkg: Move the GHCB allocations into reserved memory
>       UefiCpuPkg/MpInitLib: Prepare SEV-ES guest APs for OS use
>       Maintainers.txt: Add reviewers for the OvmfPkg SEV-related files
>       UefiCpuPkg/MpInitLib: Always initialize the DoDecrement variable
>
> Tom Zhao (1):
>       MdePkg: UefiLib: Add a function to check if a language is supported
>
> Tomas Pilar (7):
>       ShellPkg/AcpiView: Move log reset to main method
>       ShellPkg/AcpiView: Refactor configuration
>       ShellPkg/AcpiView: Move table count reset
>       ShellPkg/AcpiView: Move parameter parsing
>       ShellPkg/AcpiView: Refactor DumpAcpiTableToFile
>       ShellPkg: Add AcpiViewCommandLib
>       ShellPkg/AcpiView: Add application wrapper
>
> Vijayenthiran Subramaniam (1):
>       ArmPkg/ArmSvcLib: prevent speculative execution beyond svc
>
> Vin Xue (1):
>       SignedCapsulePkg: Address NULL pointer dereference case.
>
> Vitaly Cheptsov (10):
>       MdePkg: Add STATIC_ASSERT macro
>       MdeModulePkg/ResetUtilityLib: Use STATIC_ASSERT macro
>       MdePkg: Use STATIC_ASSERT macro
>       MdePkg: Drop VERIFY_SIZE_OF in favour of STATIC_ASSERT
>       BaseTools: Do not call sys.setdefaultencoding with python 3
>       MdePkg: Do not use CreateEventEx unless required
>       BaseTools: Switch to GNU mode for CLANGPDB
>       OvmfPkg: Fix SMM/RT driver section alignment for XCODE5/CLANGPDB
>       BaseTools: Use SEH exceptions in CLANGPDB for IA32
>       MdePkg: Fix SafeString performing assertions on runtime checks
>
> Vladimir Olovyannikov (1):
>       MdePkg: UefiFileHandleLib: fix buffer overrun in FileHandleReadLine()
>
> Walon Li (1):
>       MdeModulePkg/SetupBrowserDxe: Do not reconnect driver with form-update
>
> Wasim Khan (1):
>       MdePkg: Include Acpi header file
>
> Wei6 Xu (29):
>       MdeModulePkg: Add Capsule On Disk related definition.
>       MdeModulePkg/CapsuleApp: Enhance Capsule-On-Disk related functions.
>       MdeModulePkg/BdsDxe: Support Capsule On Disk.
>       MdeModulePkg/CapsuleRuntimeDxe: Introduce PCD to control this feature.
>       MdeModulePkg/DxeIpl: Support Capsule On Disk.
>       MdeModulePkg: Add Capsule On Disk APIs into CapsuleLib.
>       MdeModulePkg: Add CapsuleOnDiskLoadPei PEIM.
>       MdeModulePkg/CapsuleApp: Enhance Capsule-On-Disk related functions.
>       MdeModulePkg: Add Capsule On Disk related definition.
>       MdeModulePkg/BdsDxe: Support Capsule On Disk.
>       MdeModulePkg/CapsuleRuntimeDxe: Introduce PCD to control this feature.
>       MdeModulePkg/DxeIpl: Support Capsule On Disk.
>       MdeModulePkg: Add Capsule On Disk APIs into CapsuleLib.
>       MdeModulePkg: Add CapsuleOnDiskLoadPei PEIM.
>       MdeModulePkg/DxeCapsuleLibFmp: Add missing NULL pointer check.
>       MdePkg/UefiDebugLibConOut: Add destructor to CloseEvent
>       MdePkg/UefiDebugLibDebugPortProtocol: Add destructor to CloseEvent
>       MdePkg/UefiDebugLibStdErr: Add destructor to CloseEvent
>       MdeModulePkg/CapsuleApp: Improve comparisons in CapsuleOnDisk.c
>       MdeModulePkg/DxeCapsuleLibFmp: Improve comparisons in CapsuleOnDisk.c
>       MdePkg: Add definition for Fmp Capsule Dependency.
>       MdeModulePkg/CapsuleApp: Enhance CapsuleApp for Fmp Capsule Dependency
>       FmdDevicePkg/FmpDxe: Support Fmp Capsule Dependency.
>       FmpDevicePkg: Add FmpDependency library class and BASE instance
>       FmpDevicePkg/Test: Add FmpDependencyLib unit test
>       FmpDevicePkg: Add FmpDependencyCheck library class and instances
>       FmpDevicePkg: Add FmpDependencyDevice library class and NULL instance
>       FmpDevicePkg/FmpDxe: Use new Fmp dependency libraries
>       Maintainers.txt: Add reviewer for FmpDevicePkg.
>
> XiaoyuX Lu (4):
>       CryptoPkg/BaseCryptLib: Wrap OpenSSL SM3 algorithm
>       CryptoPkg/OpensslLib: Fix CR/LF issue
>       CryptoPkg/OpensslLib: disable autoload-config for OpenSSL
>       CryptoPkg/OpensslLib: Exclude err_all.c in process_files.pl
>
> Ye Ting (1):
>       Change package reviewer of CryptoPkg.
>
> Yonghong Zhu (1):
>       Maintainers.txt: Remove Yonghong from BaseTools Reviewer
>
> Yuwei Chen (2):
>       BaseTools: Add Guid name support in GenFfs.
>       Maintainers.txt: Add 'Yuwei Chen' for BaseTools review
>
> Zhang, Chao B (2):
>       Revert "Capsule-on-Disk entire Patch
>       Maintainers.txt: Change SecurityPkg Maintainer Role
>
> Zhichao Gao (50):
>       MdeModulePkg/GraphicsConsoleDxe: Initialize the output mode
>       MdeMoudlePkg/CapsulePei: Fix coding style issue
>       MdeMoudlePkg/CapsulePei: Optimize AreCapsulesStaged
>       MdeMoudlePkg/CapsulePei: Optimize GetScatterGatherHeadEntries
>       MdeMoudlePkg/CapsulePei: No need to remain space for null-terminate
>       MdeModulePkg/CapsulePei: Add memory pointer check
>       UefiCpuPkg/MpInitLib: MicrocodeDetect: Ensure checked range is valid
>       MdeModulePkg/BdsDxe: Use a pcd to control PlatformRecovery
>       ShellPkg/Type.c: Add value check before (LoopVar - 1)
>       CryptoPkg/BaseCryptLib: Use cmp-operator for non-Boolean comparisons
>       ShellPkg/UefiShellLevel2CommansLib: Pointer Resonse should be checked
>       ShellPkg/UefiShellDriver1CommandsLib: Make array big enough
>       ShellPkg/Pci.c: Update supported link speed to PCI5.0
>       MdeModulePkg: Extend the support keyboard type of Terminal console
>       MdeModulePkg/TerminalDxe: Extend the terminal console support types
>       MdeModulePkg/BM_UI: Add the new terminal types to related menu
>       MdeModulePkg/TerminalDxe: Enhance the arrow keys support
>       MdePkg/SmBios.h: SMBIOS 3.3.0 add PCI gen4 values for type 9
>       MdePkg/SmBios.h: SMBIOS 3.3.0 add support for CXL Flexbus
>       MdePkg/SmBios.h: SMBIOS 3.3.0 Add value HBM and Die for type 17
>       MdePkg/SmBios.h: SMBIOS 3.3.0 Update Intel Persistent Memory string
>       ShellPkg/SmbiosView: SMBIOS 3.3.0 add PCI gen4 values for type 9
>       ShellPkg/SmbiosView: SMBIOS 3.3.0 add support for CXL Flexbus
>       ShellPkg/SmbiosView: SMBIOS 3.3.0 Add value HBM and Die for type 17
>       ShellPkg/SmbiosView: SMBIOS 3.3.0 Update "Intel persistent memory"
>       ShellPkg/UefiHandleParsingLib: Fix error allocate pool
>       ShellPkg/ShellProtocol: Return error code while fail parsing cmd-line
>       SecurityPkg/TcgPhysicalPresenceLib: Replace the ASSERT with error code
>       CryptoPkg/CryptoDxe: Add function to indicate the deprecated algorithm
>       CryptoPkg/BaseCrpytLib: Retire MD4 algorithm
>       CryptoPkg/OpensslLib: Set MD4 disable in OpensslLib
>       CryptoPkg/BaseCryptLib: Retire ARC4 algorithm
>       CryptoPkg/OpensslLib: Set ARC4 disable in OpensslLib
>       CryptoPkg/BaseCryptLib: Retire the TDES algorithm
>       CryptoPkg/OpensslLib: Set TDES disable in OpensslLib
>       CryptoPkg/BaseCryptLib: Retire Aes Ecb mode algorithm
>       CryptoPkg/OpensslLib: Remove the Aes Ecb file in the OpensslLib
>       CryptoPkg/BaseCryptLib: Retire HMAC MD5 algorithm
>       CryptoPkg/BaseCryptLib: Retire HMAC SHA1 algorithm
>       CryptoPkg/opensslconf.h: Covert the file ending to dos format
>       CryptoPkg/Crypto.h: Update the version of Crypto Driver
>       CryptoPkg/BaseCryptLib: Add MARCO to disable the deprecated MD5
>       CryptoPkg/BaseCryptLib: Add MARCO to disable the deprecated SHA1
>       MdeModulePkg/PartitionDxe: Correct the MBR last block value
>       MdeModulePkg/PartitionDxe: Skip the MBR that add for CD-ROM
>       MdeModulePkg/PartitionDxe: Add already start check for child hanldes
>       Maintainers.txt: Add reviewer for serial, disk and SMBIOS
>       MdeModulePkg/PartitionDxe: Put the UDF check ahead of MBR
>       MdeModulePkg/PartitionDxe: Revert changes for the special MBR
>       MdeModulePkg/PartitionDxe: Fix the incorrect LBA size in child hander
>
> Zhiguang Liu (14):
>       BaseTools: Add map file parsing support for CLANG9
>       BaseTools: Add support for parseing map files generated by CLANG9 in GenFv
>       MdeModulePkg: Unify the definitions of size_t
>       MdeModulePkg: LzmaCustomDecompressLib.inf don't support EBC anymore
>       MdeModulePkg: Add ARM/Aarch64 support which were missing
>       edksetup.bat: Simplify the step to use CLANGPDB
>       BaseTools: append -DNO_MSABI_VA_FUNCS option in CLANGPDB tool chain
>       MdePkg: Avoid using __clang__ to specify CLANGPDB
>       BaseTools: remove -DNO_MSABI_VA_FUNCS option in CLANGPDB tool chain
>       MdePkg DebugLib: Enable FILE NAME as DEBUG ASSERT for CLANG
>       MdePkg: add definitions for ACPI NVDIMM Device Path
>       Using LLVM compiler set to build BaseTools in Linux
>       Maintainers.txt: Add 'Zhiguang Liu' for MdePkg review
>       SecurityPkg: Initailize variable Status before it is consumed.
>
> Zhijux Fan (27):
>       BaseTools:Make BaseTools support new rules to generate RAW FFS FILE
>       BaseTools:Add import in FvImageSection
>       BaseTools:Add DetectNotUsedItem.py to Edk2\BaseTools\Scripts
>       BaseTools:Remove unused Edk2\BuildNotes2.txt
>       BaseTools:Linux changes the way the latest version is judged
>       BaseTools:Add the Judgment Method of "--exclude"
>       BaseTools: Update incorrect variable name 'DataPile'
>       BaseTools:Ecc handle another copyright format
>       BaseTools:ECC need to handle lower case 'static'
>       BaseTools:Replace PlatformInfo with PlatformAutoGen for Moudle
>       BaseTools:change some incorrect parameter defaults
>       BaseTools:Fix the issue that build report failed
>       BaseTools:"--exclude" don't apply if parameter ends with separator
>       BaseTools:Add [packages] section in dsc file
>       BaseTools:fix regression issue for platform .map file
>       BaseTools:Enhance the way to handling included dsc file
>       BaseTools:replaces the two offending quotes by ascii quotes
>       BaseTools:Change the case rules for ECC check pointer names
>       BaseTools:Fix GenFds issue for BuildOption replace GenFdsOption
>       BaseTools:fix Ecc tool issue for check StructPcd
>       BaseTools: Fixed build failure when using python38
>       BaseTools:build failure in CLANGPDB tool chain
>       BaseTools:copy the common PcdValueCommon.c to output directory
>       BaseTools:fix issue for decode the stdout/stderr byte arrays
>       BaseTools:Fix build tools print traceback info issue
>       BaseTools:GuidedSectionTools.txt is not generated correctly
>       BaseTools:Add the spare space FV image size checker

Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Ref: https://bugs.launchpad.net/qemu/+bug/1852196
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Philippe Mathieu-Daude <philmd@redhat.com>
Message-Id: <20200908072939.30178-6-lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 roms/edk2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/edk2 b/roms/edk2
index 20d2e5a125e..06dc822d045 160000
--- a/roms/edk2
+++ b/roms/edk2
@@ -1 +1 @@
-Subproject commit 20d2e5a125e34fc8501026613a71549b2a1a3e54
+Subproject commit 06dc822d045c2bb42e497487935485302486e151
-- 
2.26.2


