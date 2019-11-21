Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F9EC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 22:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98911206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 22:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="LHr/BOA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98911206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXvOA-0005zJ-MX
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 17:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1iXvLs-00048b-CR
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 17:55:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1iXvLq-0004aV-Ab
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 17:55:04 -0500
Received: from ma1-aaemail-dr-lapp03.apple.com ([17.171.2.72]:57348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1iXvLq-0004ZE-5i
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 17:55:02 -0500
Received: from pps.filterd (ma1-aaemail-dr-lapp03.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 xALMppVQ004638; Thu, 21 Nov 2019 14:54:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : mime-version :
 content-transfer-encoding; s=20180706;
 bh=hgGNnJQh4TNcIGTmg8mO7JRsuaL2R7iBTXF9PIpWx6k=;
 b=LHr/BOA4Gx8xkGOsf9/RXIWJ905LB/XZOOeCrSyGpdtsQgcJPFhXuz1v5DRUtO3wCqZm
 xmriqA5LTpMLF30tJ0KW6VYooL9iigUOl234ILcxvFalTPGWe7GDST7oR4VWLIfDORvz
 U2ALCp7ExzfPlcIHEeLT2Xf05obAcg6an0phbPdEAE/GVpHmGoaZ1lKWLLZtvLRD66DJ
 dw2JwAF/PAQjfYPoTWFgmmxIq9KCehRo9RxQ3lBnJgvhmux9h8vCpJaot9B4JApJyiun
 s+G3JxN1BflJ0a6Nrq2JwDyYsnyCpj30xX0q4qJeeLg7MB4BHu3cv1aglpC+Vmv1vFA5 +A== 
Received: from ma1-mtap-s02.corp.apple.com (ma1-mtap-s02.corp.apple.com
 [17.40.76.6])
 by ma1-aaemail-dr-lapp03.apple.com with ESMTP id 2wah00wd8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Thu, 21 Nov 2019 14:54:56 -0800
Received: from nwk-mmpp-sz11.apple.com
 (nwk-mmpp-sz11.apple.com [17.128.115.155]) by ma1-mtap-s02.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q1C00F8GCZFA3G0@ma1-mtap-s02.corp.apple.com>; Thu,
 21 Nov 2019 14:54:56 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz11.apple.com by
 nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q1C00J00CBT3A00@nwk-mmpp-sz11.apple.com>; Thu,
 21 Nov 2019 14:54:55 -0800 (PST)
X-Va-A: 
X-Va-T-CD: c56cc4374afe9162bf6a337f3d661529
X-Va-E-CD: 58435c279151d9bc975021d8ad7e82fa
X-Va-R-CD: 56ec2124625bc00b2f307d8ece216fe1
X-Va-CD: 0
X-Va-ID: eb450ccd-f3ca-4cd4-8f8a-f3653f1c154e
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: 58435c279151d9bc975021d8ad7e82fa
X-V-R-CD: 56ec2124625bc00b2f307d8ece216fe1
X-V-CD: 0
X-V-ID: 123ad1f8-9616-4e51-9404-8b88770b108f
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-11-21_06:,, signatures=0
Received: from pontoon.com (unknown [17.193.42.199]) by nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q1C00JWACZIHUA0@nwk-mmpp-sz11.apple.com>; Thu,
 21 Nov 2019 14:54:54 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 0/5] hvf: stability fixes for HVF
Date: Thu, 21 Nov 2019 14:54:49 -0800
Message-id: <cover.1574375668.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-21_06:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 17.171.2.72
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Cameron Esfahani <dirty@apple.com>
From: Cameron Esfahani via <qemu-devel@nongnu.org>

The following patches fix stability issues with running QEMU on Apple
Hypervisor Framework (HVF):
- non-RAM, non-ROMD areas need to trap so accesses can be correctly
  emulated.
- Current TSC synchronization implementation is insufficient: when
  running with more than 1 core, TSC values can go backwards.  Until
  a correct implementation can be written, remove calls to
  hv_vm_sync_tsc().  Pass through TSC to guest OS.
- Fix REX emulation in relation to legacy prefixes.
- More correctly match SDM when setting CR0 and PDPTE registers.
- Save away exception type as well as vector in hvf_store_events() so
  they can be correctly reinjected in hvf_inject_interrupts().  Under
  heavy loads, exceptions got misrouted.

Cameron Esfahani (5):
  hvf: non-RAM, non-ROMD memory ranges are now correctly mapped in
  hvf: remove TSC synchronization code because it isn't fully complete
  hvf: correctly handle REX prefix in relation to legacy prefixes
  hvf: more accurately match SDM when setting CR0 and PDPTE registers
  hvf: save away type as well as vector so we can reinject them

 target/i386/hvf/hvf.c        | 74 +++++++++++++++++++++++++-----------
 target/i386/hvf/vmx.h        | 18 +++++----
 target/i386/hvf/x86_decode.c | 55 ++++++++++++++-------------
 target/i386/hvf/x86_decode.h | 16 ++++----
 target/i386/hvf/x86_emu.c    |  3 --
 target/i386/hvf/x86hvf.c     | 26 +++++--------
 6 files changed, 108 insertions(+), 84 deletions(-)

-- 
2.24.0


