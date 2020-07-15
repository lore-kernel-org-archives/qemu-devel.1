Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281E8C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 17:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC7F420656
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 17:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLVd1lR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7F420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvlUR-00072p-9w
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 13:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jvlTm-0006dq-VS
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 13:46:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46588
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jvlTk-0003dM-KX
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 13:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594835131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XcDqOAcaOIWuTC9kfHccRqMRlUxp2g0U9pd/5zxBeUE=;
 b=cLVd1lR0zoIHFHCArHk7lLc9gOKMdwzMjZD8qwtPQXA1ACo64wGEDWH28rmuj4CwVpGG5u
 WApzz340tZW/97ZTGmsaLE+o+1N35+CPyQY+oqFf4Cwnxv8tVxCqkXz/m+dxLwmlxqxtL6
 TXSNb91GrL6/d1D+NC7Ol16hGYk2ZRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-rq9J_sbtNgW-F8lF16A97g-1; Wed, 15 Jul 2020 13:45:29 -0400
X-MC-Unique: rq9J_sbtNgW-F8lF16A97g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E076B1800D42
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 17:45:28 +0000 (UTC)
Received: from localhost (unknown [10.40.208.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7FB56710A0;
 Wed, 15 Jul 2020 17:45:19 +0000 (UTC)
Date: Wed, 15 Jul 2020 19:45:13 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: unable to boot windows with 256 cpus
Message-ID: <20200715194513.5b19ca27@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.williamson@redhat.com,
 peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While testing ACPI cpu hotplug changes I stumbled on BSOD in case
QEMU is configured with 256 CPUs, Windows Server 2012R2x64 fails to boot
with bugcheck 5C


qemu-system-x86_64 -m 4G -smp 2,sockets=64,cores=4,maxcpus=256 -M q35,kernel-irqchip=split  -enable-kvm -device intel-iommu,intremap=on,eim=on ws2012r2x64DCchk.qcow2

Looking at stacktrace, it seems that is fails when trying to initialize iommu

hal_interrupt_remapping_setup_failure_nt!initbootprocessor

Any idea what to try to figure out what QEMU is missing wrt intremap?

PS:
WS2016 boots eventually, but CPU hotplug doesn't work, symptoms (unconfirmed yet) like SCI isn't being delivered.
With RHEL76 the same config works fine.


---
*******************************************************************************
*                                                                             *
*                        Bugcheck Analysis                                    *
*                                                                             *
*******************************************************************************
 
HAL_INITIALIZATION_FAILED (5c)
Arguments:
Arg1: 0000000000007000
Arg2: 0000000000000618
Arg3: ffffffffc00000bb
Arg4: 0000000000000000
 
Debugging Details:
------------------
 
 
DEFAULT_BUCKET_ID:  WIN8_DRIVER_FAULT
 
BUGCHECK_STR:  0x5C
 
CURRENT_IRQL:  0
 
ANALYSIS_VERSION: 6.3.9600.16384 (debuggers(dbg).130821-1623) amd64fre
 
DPC_STACK_BASE:  FFFFF80225BE3FB0
 
LAST_CONTROL_TRANSFER:  from fffff80221aa9714 to fffff80221c95801
 
STACK_TEXT:  
fffff802`25bdbcd8 fffff802`21aa9714 : fffff6fc`01114af8 fffff6fb`7e0088a0 fffff6fb`7dbf0040 fffff6fb`7dbedf80 : nt!DbgBreakPointWithStatus+0x1
fffff802`25bdbce0 fffff802`21aaabff : 00000000`00000004 00000000`00000000 00000000`00000000 ffffffff`c00000bb : nt!KiBugCheckDebugBreak+0x14
fffff802`25bdbd50 fffff802`21c8fb94 : 00000000`0000005c 00000000`00007000 00000000`00000618 ffffffff`c00000bb : nt!KeBugCheck2+0xdd7
fffff802`25bdc460 fffff802`2297c94a : 00000000`0000005c 00000000`00007000 00000000`00000618 ffffffff`c00000bb : nt!KeBugCheckEx+0x104
fffff802`25bdc4a0 fffff802`2297c9ac : fffff802`20c735d0 00000000`00000000 00000000`00000009 fffff802`20c735f0 : hal!HalpInitializeInterrupts+0x406
fffff802`25bdc4f0 fffff802`229728aa : fffff802`20c735d0 fffff802`229742ce fffff802`20c735d0 00000000`00000007 : hal!HalpInterruptInitDiscard+0x3c
fffff802`25bdc520 fffff802`2297221c : fffff802`00000008 00000000`00000000 fffff802`20c735d0 00000000`00000008 : hal!HalpInterruptInitSystem+0xf6
fffff802`25bdc560 fffff802`2297c537 : fffff802`00000006 fffff802`0000000c fffff802`20c735d0 fffff802`20c735d0 : hal!HalpInitSystemHelper+0x44
fffff802`25bdc5c0 fffff802`2285467d : fffff802`20c735d0 fffff802`20c735d0 fffff802`25bdc6f0 00000000`00010228 : hal!HalpInitSystemPhase0+0x1b
fffff802`25bdc5f0 fffff802`222d065f : fffff802`20c735d0 00000000`00000000 00000000`00000000 fffff802`21cf6180 : nt!InitBootProcessor+0x265
fffff802`25bdc870 fffff802`222e4073 : fffff802`222ae400 fffff802`222aeac0 fffff802`25bdd000 fffff802`21cf6180 : nt!KiInitializeKernel+0xd83
fffff802`25bdcc10 00000000`00000000 : 00000000`00000000 00000000`00000000 00000000`00000000 00000000`00000000 : nt!KiSystemStartup+0x193
 
 
STACK_COMMAND:  kb
 
FOLLOWUP_IP:
nt!InitBootProcessor+265
fffff802`2285467d 84c0            test    al,al
 
SYMBOL_STACK_INDEX:  9
 
SYMBOL_NAME:  nt!InitBootProcessor+265
 
FOLLOWUP_NAME:  MachineOwner
 
MODULE_NAME: nt
 
IMAGE_NAME:  ntkrnlmp.exe
 
DEBUG_FLR_IMAGE_TIMESTAMP:  5215d150
 
IMAGE_VERSION:  6.3.9600.16384
 
BUCKET_ID_FUNC_OFFSET:  265
 
FAILURE_BUCKET_ID:  0x5C_HAL_INTERRUPT_REMAPPING_SETUP_FAILURE_nt!InitBootProcessor
 
BUCKET_ID:  0x5C_HAL_INTERRUPT_REMAPPING_SETUP_FAILURE_nt!InitBootProcessor
 
ANALYSIS_SOURCE:  KM
 
FAILURE_ID_HASH_STRING:  km:0x5c_hal_interrupt_remapping_setup_failure_nt!initbootprocessor
 
FAILURE_ID_HASH:  {85a33624-5d0e-3044-bbaa-0bdba50d221b}


