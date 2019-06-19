Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C434FC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 16:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B8E2187F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 16:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3LpGS2of"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B8E2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hddQN-0004xq-Qm
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 12:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58817)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hddLb-0002YI-LR
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 12:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hddLa-0006eV-CV
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 12:22:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46640)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hddLa-0006ai-1G
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 12:22:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JGDiCt030793;
 Wed, 19 Jun 2019 16:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=EJg/eQRY7dvdItaKwOXuCd4DrcjzwAV7ihD2i/za9Pw=;
 b=3LpGS2ofD8lsvNodrlhVsiQwxKHC2OxTK73qmnr6ZPXnwPVv+7PfT0f69BuZfBCFUPbV
 HzuqKUuKjSsqlUZD9OTG7LEGSRddOpQvBGzOMJz7uOe0bd6/ClTH1QBBXX44EFHSnfwI
 ISiN266+JYEULkwvESyihR1CXjmFs+8xmMZJ0ScbndSrl97smC6YLC8+8+arCtu309oW
 EOjgVbb2nliaax99Addn+tleOS7SKweca6eHvc8SoHIdxeBkRyaJ8+JZBd2wB7WuF9SG
 goSWAZqlpUAJRFtYeSgt7xbitr/PdXoRscKFrj8ctLA81PvkTidqYLwTP8EhuYqM7HQU 6g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2t7809cejx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 16:22:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JGKTkS120439;
 Wed, 19 Jun 2019 16:22:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2t77ynxppg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 16:22:00 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5JGLxfY000685;
 Wed, 19 Jun 2019 16:21:59 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 19 Jun 2019 09:21:59 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 19:21:30 +0300
Message-Id: <20190619162140.133674-1-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=810
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=860 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190131
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [QEMU PATCH v4 0/10]: target/i386: kvm: Add support
 for save and restore of nested state
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, maran.wilson@oracle.com,
 mtosatti@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, rth@twiddle.net,
 jmattson@google.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series aims to add support for QEMU to be able to migrate VMs that
are running nested hypervisors. In order to do so, it utilizes the new
IOCTLs introduced in KVM commit 8fcc4b5923af ("kvm: nVMX: Introduce
KVM_CAP_NESTED_STATE") which was created for this purpose.

1st patch add a missed cleanup for deleting VMX migration blocker in
case vCPU init fails.

2st patch introduce kvm_arch_destroy_vcpu() to perform per-vCPU
destruction logic that is arch-dependent.

3st patch is just refactoring to use symbolic constants instead of hard-coded
numbers.

4st patch fixes QEMU to update DR6 when QEMU re-inject #DB to guest after
it was intercepted by KVM when guest is debugged.

5th patch adds migration blocker for vCPU exposed with either Intel VMX
or AMD SVM. Until now it was blocked only for Intel VMX.

6rd patch updates linux-headers to have updated struct kvm_nested_state.
The updated struct now have explicit fields for the data portion.

7rd patch add vmstate support for saving/restoring kernel integer types (e.g. __u16).

8th patch adds support for saving and restoring nested state in order to migrate
guests which run a nested hypervisor.

9th patch add support for KVM_CAP_EXCEPTION_PAYLOAD. This new KVM capability
allows userspace to properly distingiush between pending and injecting exceptions.

10th patch changes the nested virtualization migration blocker to only
be added when kernel lack support for one of the capabilities required
for correct nested migration. i.e. Either KVM_CAP_NESTED_STATE or
KVM_CAP_EXCEPTION_PAYLOAD.

Regards,
-Liran

v1->v2 changes:
* Add patch to fix bug when re-inject #DB to guest.
* Add support for KVM_CAP_EXCEPTION_PAYLOAD.
* Use explicit fields for struct kvm_nested_state data portion.
* Use vmstate subsections to save/restore nested state in order to properly
* support forward & backwards migration compatability.
* Remove VMX migration blocker.

v2->v3 changes:
* Add kvm_arch_destroy_vcpu().
* Use DR6_BS where appropriate.
* Add cpu_pre_save() logic to convert pending exception to injected
  exception if guest is running L2.
* Converted max_nested_state_len to int instead of uint32_t.
* Use kvm_arch_destroy_vcpu() to free nested_state.
* Add migration blocker for vCPU exposed with AMD SVM.
* Don't rely on CR4 or MSR_EFER to know if it is required to
migrate new VMState subsections.
* Signal if vCPU is in guest-mode in hflags as original intention by Paolo.

v3->v4 changes:
* Add delete of nested migration blocker in case vCPU init fail.
* Change detection of VMX/SVM to not consider CPU vendor.
* Modify linux-headers to not have SVM stubs and use constant for vmcs12 size.
* Wrapped definition of kernel integer vmstate macros with #ifdef CONFIG_LINUX.
* Add migration blocker in case vCPU is exposed with VMX/SVM and kernel
  is lacking one of the KVM caps required to migrate nested workloads.


