Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A23C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 18:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD14227BF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 18:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyvZjEJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD14227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvPfb-0004yd-Hh
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 14:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jvPdY-0003Mm-Dx
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 14:26:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48818
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jvPdV-0006bE-1M
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 14:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594751185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4hEFeI+yErp3gnRhF8YSt7tPlJw3KO0jSTiOg7nJf4o=;
 b=gyvZjEJteJorw4G0n7zT1TMs5pv7ydsOhSYqqvd8braHd8kMCW1Y1XhlG8LjSPrenGZjVg
 KVln4SrxrZk7VNjRn0JHeOnxanSYxfhctHWeWPqjxSLM67WW7hV6bP7ybREqbQ/i/uu2WR
 rJxtYIbTY3qtKmoDderraNXOKnWYJDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-S6chrBQAOHOLHfT6mP-62g-1; Tue, 14 Jul 2020 14:26:21 -0400
X-MC-Unique: S6chrBQAOHOLHfT6mP-62g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 093D719200C2;
 Tue, 14 Jul 2020 18:26:20 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-232.ams2.redhat.com
 [10.36.112.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9DD45C679;
 Tue, 14 Jul 2020 18:26:18 +0000 (UTC)
Subject: Re: [RFC 0/3] x86: fix cpu hotplug with secure boot
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200710161704.309824-1-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <77f6d6c5-a10f-d863-48ef-a1d8d990bf1a@redhat.com>
Date: Tue, 14 Jul 2020 20:26:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200710161704.309824-1-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: boris.ostrovsky@oracle.com, liran.alon@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/10/20 18:17, Igor Mammedov wrote:
> CPU hotplug with Secure Boot was not really supported and firmware wasn't aware
> of hotplugged CPUs (which might lead to guest crashes). During 4.2 we introduced
> locked SMI handler RAM arrea to make sure that guest OS wasn't able to inject
> its own SMI handler and OVMF added initial CPU hotplug support.
>
> This series is QEMU part of that support [1] which lets QMVF tell QEMU that
> CPU hotplug with SMI broadcast enabled is supported so that QEMU would be able
> to prevent hotplug in case it's not supported and trigger SMI on hotplug when
> it's necessary.
>
> 1) CPU hotplug negotiation part was introduced later so it might not be
> in upstream OVMF yet or I might have missed the patch on edk2-devel
> (Laszlo will point out to it/post formal patch)
>
> Igor Mammedov (3):
>   x86: lpc9: let firmware negotiate CPU hotplug SMI feature
>   x86: cphp: prevent guest crash on CPU hotplug when broadcast SMI is in
>     use
>   x68: acpi: trigger SMI before scanning for hotplugged CPUs
>
>  include/hw/acpi/cpu.h  |  1 +
>  include/hw/i386/ich9.h |  1 +
>  hw/acpi/cpu.c          |  6 ++++++
>  hw/acpi/ich9.c         | 12 +++++++++++-
>  hw/i386/acpi-build.c   | 33 ++++++++++++++++++++++++++++++++-
>  hw/i386/pc.c           | 15 ++++++++++++++-
>  hw/isa/lpc_ich9.c      | 10 ++++++++++
>  7 files changed, 75 insertions(+), 3 deletions(-)
>

I applied the series on top of QEMU commit 20c1df5476e1,
plus the unrelated build fix that I proposed in:

  Re: [PULL 14/31] target/i386: reimplement f2xm1 using floatx80
  operation

at:

  https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04714.html
  (alternative link:
  <http://mid.mail-archive.com/a3302e58-c470-9305-b106-a2b6b2c52d39@redhat.com>)

I used the following command for hotplug:

$ virsh setvcpu ovmf.fedora.q35 3 --enable --live

Results:

  OVMF SMM_REQUIRE  edk2                machine type   result
  ----------------  ------------------  -------------  ----------------------------
  FALSE             9c6f3545aee0        pc-i440fx-5.0  hotplug accepted [1]
  FALSE             9c6f3545aee0        pc-i440fx-5.1  hotplug accepted [1]
  FALSE             9c6f3545aee0        pc-q35-5.0     hotplug accepted [1]
  FALSE             9c6f3545aee0        pc-q35-5.1     hotplug accepted [1]
  FALSE             9c6f3545aee0+patch  pc-i440fx-5.0  hotplug accepted [1]
  FALSE             9c6f3545aee0+patch  pc-i440fx-5.1  hotplug accepted [1]
  FALSE             9c6f3545aee0+patch  pc-q35-5.0     hotplug accepted [1]
  FALSE             9c6f3545aee0+patch  pc-q35-5.1     hotplug accepted [1]
  TRUE              9c6f3545aee0        pc-q35-5.0     hotplug rejected [2]
  TRUE              9c6f3545aee0        pc-q35-5.1     hotplug rejected [2]
  TRUE              9c6f3545aee0+BUG    pc-q35-5.1     negotiation rejected [3]
  TRUE              9c6f3545aee0+patch  pc-q35-5.0     hotplug rejected [2]
  TRUE              9c6f3545aee0+patch  pc-q35-5.1     hotplug accepted [4] [5] [6]

[1] In this case, i.e., when OVMF is built without -D SMM_REQUIRE, the
    firmware is not supposed to learn about CPU hotplug at OS runtime;
    only the OS should care. No SMI is raised in ACPI. So this is a
    regression-test for when SMM is not used at all.

[2] "error: internal error: unable to execute QEMU command 'device_add':
     cpu hotplug SMI was not enabled by firmware"

[3] In this test, I intentionally broke the firmware so that it would
    negotiate "CPU hotplug with SMI", but not "SMI broadcast". In this
    case, QEMU rejects the feature request, the firmware detects that,
    and hangs (intentionally, as this is a programming error in the
    firmware -- a failed assertion).

[4] Tested hotplug in Linux guest with "rdmsr -a 0x3a", "taskset -c X
    efibootmgr", and S3 suspend/resume, as described at
    https://github.com/tianocore/tianocore.github.io/wiki/Testing-SMM-with-QEMU,-KVM-and-libvirt#tests-to-perform-in-the-installed-guest-fedora-26-guest

[5] Also tested hotplug with Windows Server 2012 R2; checking the CPU
    count in the Task Manager | Logical Processors view, and in Device
    Manager | Processors. Tested S3 suspend/resume too.

[6] The S3 suspend/resume test is relevant in two forms -- first, after
    hot-adding CPUs, S3 suspend/resume continues to work.

    Second, during S3 resume, the "S3 boot script" re-selects the same
    SMI features originally negotiated during normal boot, so plugging a
    new CPU works after S3 resume too.

    Consider the following S3 boot script difference (executed during S3
    resume), taken between pc-q35-5.0 and pc-q35-5.1:

     ExecuteBootScript - 7BB67037
     EFI_BOOT_SCRIPT_MEM_WRITE_OPCODE
     BootScriptExecuteMemoryWrite - 0x7BB66018, 0x00000018, 0x00000000
     S3BootScriptWidthUint8 - 0x7BB66018 (0x00)
     S3BootScriptWidthUint8 - 0x7BB66019 (0x2B)
     S3BootScriptWidthUint8 - 0x7BB6601A (0x00)
     S3BootScriptWidthUint8 - 0x7BB6601B (0x18)
     S3BootScriptWidthUint8 - 0x7BB6601C (0x00)
     S3BootScriptWidthUint8 - 0x7BB6601D (0x00)
     S3BootScriptWidthUint8 - 0x7BB6601E (0x00)
     S3BootScriptWidthUint8 - 0x7BB6601F (0x08)
     S3BootScriptWidthUint8 - 0x7BB66020 (0x00)
     S3BootScriptWidthUint8 - 0x7BB66021 (0x00)
     S3BootScriptWidthUint8 - 0x7BB66022 (0x00)
     S3BootScriptWidthUint8 - 0x7BB66023 (0x00)
     S3BootScriptWidthUint8 - 0x7BB66024 (0x7B)
     S3BootScriptWidthUint8 - 0x7BB66025 (0xB6)
     S3BootScriptWidthUint8 - 0x7BB66026 (0x60)
     S3BootScriptWidthUint8 - 0x7BB66027 (0x28)
    -S3BootScriptWidthUint8 - 0x7BB66028 (0x01)
    +S3BootScriptWidthUint8 - 0x7BB66028 (0x03)
     S3BootScriptWidthUint8 - 0x7BB66029 (0x00)
     S3BootScriptWidthUint8 - 0x7BB6602A (0x00)
     S3BootScriptWidthUint8 - 0x7BB6602B (0x00)
     S3BootScriptWidthUint8 - 0x7BB6602C (0x00)
     S3BootScriptWidthUint8 - 0x7BB6602D (0x00)
     S3BootScriptWidthUint8 - 0x7BB6602E (0x00)
     S3BootScriptWidthUint8 - 0x7BB6602F (0x00)

    This is an fw_cfg DMA write preparation.

    - The first four bytes are "FWCfgDmaAccess.control" (which is big
      endian), performing a "select" (via bit#3 in value 0x18) for item
      0x2b, and initiating a "write" (bit#4 in value 0x18).

    - The next four bytes (BE) specify "FWCfgDmaAccess.length" = 8 --
      which is the size of the SMI guest features bitmask.

    - The next eight bytes (BE) are "FWCfgDmaAccess.address" =
      0x7BB66028.

    - The blob to transfer follows the FWCfgDmaAccess structure
      immediately, at 0x7BB66018 + 4 + 4 + 8 = 0x7BB66028. It consists
      of a little-endian uint64_t: the SMI guest  features bitmask. The
      diff shows that ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT (value 2) is
      re-selected during S3 resume, on "pc-q35-5.1".

    The firmware checks the result of the feature (re)selection during
    S3 resume too.

All of the test cases behaved as expected.

I understand this series is an RFC, and my own self requested updates,
but to capture the results thus far (for plug only):

Tested-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo


