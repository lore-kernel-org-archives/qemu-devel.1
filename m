Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FB6C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:17:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2343D20644
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2343D20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxXbu-0003Wn-ED
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 10:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37461)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hxXbW-00036Y-1v
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hxXbU-0000dv-2p
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:16:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44743)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hxXbT-0000d8-Qf
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:16:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A33D46F015;
 Tue, 13 Aug 2019 14:16:45 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-193.ams2.redhat.com
 [10.36.117.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA19217A98;
 Tue, 13 Aug 2019 14:16:42 +0000 (UTC)
To: edk2-devel-groups-io <devel@edk2.groups.io>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
Date: Tue, 13 Aug 2019 16:16:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 13 Aug 2019 14:16:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] CPU hotplug using SMM with QEMU+OVMF
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
Cc: Yingwen Chen <yingwen.chen@intel.com>,
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>, Jiewen Yao <jiewen.yao@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 edk2-rfc-groups-io <rfc@edk2.groups.io>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

this message is a problem statement, and an initial recommendation for
solving it, from Jiewen, Paolo, Yingwen, and others. I'm cross-posting
the thread starter to the <devel@edk2.groups.io>, <rfc@edk2.groups.io>
and <qemu-devel@nongnu.org> lists. Please use "Reply All" when
commenting.

In response to the initial posting, I plan to ask a number of questions.

The related TianoCore bugzillas are:

  https://bugzilla.tianocore.org/show_bug.cgi?id=1512
  https://bugzilla.tianocore.org/show_bug.cgi?id=1515

SMM is used as a security barrier between the OS kernel and the
firmware. When a CPU is plugged into a running system where this barrier
exists fine otherwise, the new CPU can be considered a means to attack
SMM. When the next SMI is raised (globally, or targeted at the new CPU),
the SMBASE for that CPU is still at 0x30000, which is normal RAM, not
SMRAM. Therefore the OS could place attack code in that area prior to
the SMI. Once in SMM, the new CPU would execute OS-owned code (from
normal RAM) with access to SMRAM and to other SMM-protected stuff, such
as flash. [I stole a few words from Paolo here.]

Jiewen summarized the problem as follows:

- Asset: SMM

- Adversary:

  - System Software Attacker, who can control any OS memory or silicon
    register from OS level, or read write BIOS data.

  - Simple hardware attacker, who can hot add or hot remove a CPU.

  - Non-adversary: The attacker cannot modify the flash BIOS code or
    read only BIOS data. The flash part itself is treated as TCB and
    protected.

- Threat: The attacker may hot add or hot remove a CPU, then modify
  system memory to tamper the SMRAM content, or trigger SMI to get the
  privilege escalation by executing code in SMM mode.

We'd like to solve this problem for QEMU/KVM and OVMF.

(At the moment, CPU hotplug doesn't work with OVMF *iff* OVMF was built
with -D SMM_REQUIRE. SMBASE relocation never happens for the new CPU,
the SMM infrastructure in edk2 doesn't know about the new CPU, and so
when the first SMI is broadcast afterwards, we crash. We'd like this
functionality to *work*, in the first place -- but securely at that, so
that an actively malicious guest kernel can't break into SMM.)

Yingwen and Jiewen suggested the following process.

Legend:

- "New CPU":  CPU being hot-added
- "Host CPU": existing CPU
- (Flash):    code running from flash
- (SMM):      code running from SMRAM

Steps:

(01) New CPU: (Flash) enter reset vector, Global SMI disabled by
     default.

(02) New CPU: (Flash) configure memory control to let it access global
     host memory.

(03) New CPU: (Flash) send board message to tell host CPU (GPIO->SCI) --
     I am waiting for hot-add message. (NOTE: Host CPU can only send
     instruction in SMM mode. -- The register is SMM only)

(04) Host CPU: (OS) get message from board that a new CPU is added.
     (GPIO -> SCI)

(05) Host CPU: (OS) All CPUs enter SMM (SCI->SWSMI) (NOTE: New CPU will
     not enter CPU because SMI is disabled)

(06) Host CPU: (SMM) Save 38000, Update 38000 -- fill simple SMM rebase
     code.

(07) Host CPU: (SMM) Send message to New CPU to Enable SMI.

(08) New CPU: (Flash) Get message - Enable SMI.

(09) Host CPU: (SMM) Send SMI to the new CPU only.

(10) New CPU: (SMM) Response first SMI at 38000, and rebase SMBASE to
     TSEG.

(11) Host CPU: (SMM) Restore 38000.

(12) Host CPU: (SMM) Update located data structure to add the new CPU
     information. (This step will involve CPU_SERVICE protocol)

===================== (now, the next SMI will bring all CPU into TSEG)

(13) New CPU: (Flash) run MRC code, to init its own memory.

(14) New CPU: (Flash) Deadloop, and wait for INIT-SIPI-SIPI.

(15) Host CPU: (OS) Send INIT-SIPI-SIPI to pull new CPU in.

Thanks
Laszlo

