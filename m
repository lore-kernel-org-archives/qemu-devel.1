Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8CCC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 05:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6882F206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 05:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rjQsN6fl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6882F206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAoSz-0000jB-LR
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 01:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1kAoQN-0004yX-Qf; Wed, 26 Aug 2020 01:56:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1kAoQL-0005tU-VM; Wed, 26 Aug 2020 01:56:43 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07Q5WPv3089178; Wed, 26 Aug 2020 01:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=WjA51qR1tJ1GnmzpyrD7tREwDezbUBrRItTnjm47UI4=;
 b=rjQsN6floAEUsqaA6zPWAFzhZ8JZ9isVf7QYqj3LP8DLJbqSbIAzVrRGsgeHa2x1sYEK
 pRz3MFwZ/ixeFCoyr2Jd2XNjm5yOCGiZHaez5iMqNykK0J0lo1ptilopbYGlO+tnq29H
 dS2rnwwRooX7kbZmlKfrjCTze/cLPd6eXkhIogv7r7E4+GaKaxC2AJCGSYxd2bBOv+jL
 1Msbf8ZvlpmaDHBEkyo+LNCeiuIZHchiUmebC5Cb16md5WB7f8US4gX/t1q2FOX64o7z
 vxJUCjKHqAaROwZtkfu9V2uCCQk+CuoUuVwyJHI0LhBZYAO4iAVLJFDI8dKIZRldpHOV +g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 335g80tprx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2020 01:56:17 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07Q5X8b7090711;
 Wed, 26 Aug 2020 01:56:17 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 335g80tpr7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2020 01:56:17 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07Q5mb4u023220;
 Wed, 26 Aug 2020 05:56:15 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma03wdc.us.ibm.com with ESMTP id 332utqy89h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2020 05:56:15 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07Q5uEA262390724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2020 05:56:14 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9308C6057;
 Wed, 26 Aug 2020 05:56:14 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4005C6055;
 Wed, 26 Aug 2020 05:56:09 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.163.48.38])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2020 05:56:09 +0000 (GMT)
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v7 4/8] ppc/e500: Use start-powered-off CPUState property
Date: Wed, 26 Aug 2020 02:55:31 -0300
Message-Id: <20200826055535.951207-5-bauerman@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200826055535.951207-1-bauerman@linux.ibm.com>
References: <20200826055535.951207-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-25_11:2020-08-25,
 2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 clxscore=1015 spamscore=0 mlxscore=0 suspectscore=1
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260040
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=bauerman@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 01:56:34
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

Instead of setting CPUState::halted to 1 in ppce500_cpu_reset_sec(), use
the start-powered-off property which makes cpu_common_reset() initialize it
to 1 in common code.

Also change creation of CPU object from cpu_create() to object_new() and
qdev_realize_and_unref() because cpu_create() realizes the CPU and it's not
possible to set a property after the object is realized.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 hw/ppc/e500.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index ab9884e315..ae39b9358e 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -704,9 +704,6 @@ static void ppce500_cpu_reset_sec(void *opaque)
 
     cpu_reset(cs);
 
-    /* Secondary CPU starts in halted state for now. Needs to change when
-       implementing non-kernel boot. */
-    cs->halted = 1;
     cs->exception_index = EXCP_HLT;
 }
 
@@ -865,7 +862,7 @@ void ppce500_init(MachineState *machine)
         CPUState *cs;
         qemu_irq *input;
 
-        cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
+        cpu = POWERPC_CPU(object_new(machine->cpu_type));
         env = &cpu->env;
         cs = CPU(cpu);
 
@@ -875,6 +872,14 @@ void ppce500_init(MachineState *machine)
             exit(1);
         }
 
+        /*
+         * Secondary CPU starts in halted state for now. Needs to change
+         * when implementing non-kernel boot.
+         */
+        object_property_set_bool(OBJECT(cs), "start-powered-off", i != 0,
+                                 &error_fatal);
+        qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
+
         if (!firstenv) {
             firstenv = env;
         }

