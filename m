Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F4AC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 05:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A47D206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 05:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GQt/VtOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A47D206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAoQz-0005sz-QV
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 01:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1kAoQ4-0004Po-Nf; Wed, 26 Aug 2020 01:56:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60852
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1kAoQ1-0005qd-Ct; Wed, 26 Aug 2020 01:56:24 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07Q5hNAr144099; Wed, 26 Aug 2020 01:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=rQP9eZ9PIHzNQsju74FXVxftsu6Fu/MNUF0W3wvDwcY=;
 b=GQt/VtOgpg3i0IdEjACbwccezPQaa0541s4RzUKlnRu6tNuXun/T36weC3OAPOQpC/5w
 Wqg3sT2BOjHXw36bs0E/VxR9LUdUZl4P+KArv7jgmHkIxzhWzvn1KNb7SVhFD2qUXW+b
 A8jSTYyGXAswBSqGzKJwevjTuEOsjC6YvyZolpFUmDzAn0wt5/TduOiz6RVFlLwOs+Nd
 43TBXNoO6vrmhCrygq1821R+sgwt5jMbtaxUR71wzceUR2CBKGXC5jypNKAenFP8jRHb
 Gqaurmzhh6nPmHrUG+GaXVMU8oYOYlQYr8z1QrxlEBu+dwmZb6lybdVujYy0uJoqNciE oA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 335hu3ga5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2020 01:55:54 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07Q5i40m145513;
 Wed, 26 Aug 2020 01:55:54 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 335hu3ga57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2020 01:55:54 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07Q5l4VZ028022;
 Wed, 26 Aug 2020 05:55:53 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma01dal.us.ibm.com with ESMTP id 332uttf3fn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2020 05:55:53 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07Q5tneu42467608
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2020 05:55:49 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E476C6063;
 Wed, 26 Aug 2020 05:55:52 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 202E7C6062;
 Wed, 26 Aug 2020 05:55:47 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.163.48.38])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2020 05:55:46 +0000 (GMT)
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v7 0/8] Generalize start-powered-off property from ARM
Date: Wed, 26 Aug 2020 02:55:27 -0300
Message-Id: <20200826055535.951207-1-bauerman@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-25_11:2020-08-25,
 2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260040
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=bauerman@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 01:49:04
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This version fixes `make check` failures in ppc/e500.c, mips/cps.c and
sparc/sun4m.c. This was done by moving the qdev_realize_and_unref() call as
close as possible to the object_new() call, in order to keep the CPU object
construction as similar as possible to the earlier version which used
cpu_create().

I also had to change the patch which removed the main_cpu_reset() function
from sparc/sun4m.c. It was causing a `make check` failure but I can't
really explain why. See this message for a few more details:

https://lists.nongnu.org/archive/html/qemu-ppc/2020-08/msg00419.html

I dropped the Reviewed-by's on the changed patches because of these
changes.

Original cover letter below, followed by changelog:

The ARM code has a start-powered-off property in ARMCPU, which is a
subclass of CPUState. This property causes arm_cpu_reset() to set
CPUState::halted to 1, signalling that the CPU should start in a halted
state. Other architectures also have code which aim to achieve the same
effect, but without using a property.

The ppc/spapr version has a bug where QEMU does a KVM_RUN on the vcpu
before cs->halted is set to 1, causing the vcpu to run while it's still in
an unitialized state (more details in patch 3).

Peter Maydell mentioned the ARM start-powered-off property and
Eduardo Habkost suggested making it generic, so this patch series does
that, for all cases which I was able to find via grep in the code.

The only problem is that I was only able to test these changes on a ppc64le
pseries KVM guest, so except for patches 2 and 3, all others are only
build-tested. Also, my grasp of QOM lifecycle is basically non-existant so
please be aware of that when reviewing this series.

The last patch may be wrong, as pointed out by Eduardo, so I marked it as
RFC. It may make sense to drop it.

Changes since v6:

Patch "ppc/e500: Use start-powered-off CPUState property"
Patch "mips/cps: Use start-powered-off CPUState property"
- Moved setting of start-powered-off property and qdev_realize_and_unref()
  to right after object_new(machine->cpu_type).
- Dropped Philippe's Reviewed-by due to this change.

Patch "sparc/sun4m: Remove main_cpu_reset()"
- Dropped.

Patch "sparc/sun4m: Don't set cs->halted = 0 in main_cpu_reset()"
- New patch.

Patch "sparc/sun4m: Use start-powered-off CPUState property"
- Merged secondary_cpu_reset() with main_cpu_reset().
- Dropped Philippe's Reviewed-by due to this change.

Changes since v5:

Patch "ppc/e500: Use start-powered-off CPUState property"
Patch "mips/cps: Use start-powered-off CPUState property"
Patch "sparc/sun4m: Remove main_cpu_reset()"
Patch "target/s390x: Use start-powered-off CPUState property"
- Added Philippe's Reviewed-by.

Patch "sparc/sun4m: Use start-powered-off CPUState property"
- Move call to qdev_realize_and_unref() right after object_property_set_bool(),
  as suggested by Philippe.

Changes since v4:

Patch "ppc/e500: Use start-powered-off CPUState property"
Patch "sparc/sun4m: Use start-powered-off CPUState property"
- Use qdev_realize_and_unref() instead of qdev_realize(), as suggested
  by Igor.
- Pass &error_fatal to qdev_realize_and_unref() instead of manually
  reporting the error and exiting QEMU, as suggested by Philippe.
- Changed object_property_set_bool() to use &error_fatal instead of
  &error_abort.

Patch "mips/cps: Use start-powered-off CPUState property"
- Use qdev_realize_and_unref() instead of qdev_realize(), as suggested
  by Igor.
- Use existing errp argument to propagate error back to the caller, as
  suggested by Philippe.
- Changed object_property_set_bool() to use existing errp argument to
  propagate error back to the caller instead of using &error_abort.

Changes since v3:

General:
- Added David's, Greg's and Cornelia's Reviewed-by and Acked-by to some
  of the patches.
- Rebased on top of dgibson/ppc-for-5.2.

Patch "ppc/e500: Use start-powered-off CPUState property"
Patch "mips/cps: Use start-powered-off CPUState property"
Patch "sparc/sun4m: Use start-powered-off CPUState property"
- Initialize CPU object with object_new() and qdev_realize() instead
  of cpu_create().
- Removed Reviewed-by's and Acked-by's from these patches because of
  these changes.

Changes since v2:

General:
- Added Philippe's Reviewed-by to some of the patches.

Patch "ppc/spapr: Use start-powered-off CPUState property"
- Set the CPUState::start_powered_off variable directly rather than using
  object_property_set_bool(). Suggested by Philippe.

Patch "sparc/sun4m: Remove main_cpu_reset()"
- New patch. Suggested by Philippe.

Patch "sparc/sun4m: Use start-powered-off CPUState property"
- Remove secondary_cpu_reset(). Suggested by Philippe.
- Remove setting of `cs->halted = 1` from cpu_devinit(). Suggested by Philippe.

Patch "Don't set CPUState::halted in cpu_devinit()"
- Squashed into previous patch. Suggested by Philippe.

Patch "sparc/sun4m: Use one cpu_reset() function for main and secondary CPUs"
- Dropped.

Patch "target/s390x: Use start-powered-off CPUState property"
- Set the CPUState::start_powered_off variable directly rather than using
  object_property_set_bool(). Suggested by Philippe.
- Mention in the commit message Eduardo's observation that before this
  patch, the code didn't set cs->halted on reset.

Thiago Jung Bauermann (8):
  target/arm: Move start-powered-off property to generic CPUState
  target/arm: Move setting of CPU halted state to generic code
  ppc/spapr: Use start-powered-off CPUState property
  ppc/e500: Use start-powered-off CPUState property
  mips/cps: Use start-powered-off CPUState property
  sparc/sun4m: Don't set cs->halted = 0 in main_cpu_reset()
  sparc/sun4m: Use start-powered-off CPUState property
  target/s390x: Use start-powered-off CPUState property

 exec.c                  |  1 +
 hw/core/cpu.c           |  2 +-
 hw/mips/cps.c           | 15 +++++++++++----
 hw/ppc/e500.c           | 13 +++++++++----
 hw/ppc/spapr_cpu_core.c | 10 +++++-----
 hw/sparc/sun4m.c        | 26 ++++++--------------------
 include/hw/core/cpu.h   |  4 ++++
 target/arm/cpu.c        |  4 +---
 target/arm/cpu.h        |  3 ---
 target/arm/kvm32.c      |  2 +-
 target/arm/kvm64.c      |  2 +-
 target/s390x/cpu.c      |  2 +-
 12 files changed, 41 insertions(+), 43 deletions(-)


