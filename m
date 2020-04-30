Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83059C8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C8082082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIrAYwE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8082082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5oE-0004RZ-CL
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5l4-00069O-Gi
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5l2-0003nC-Qd
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33584
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jU5l2-0003lr-8h
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588239927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fhQQ8QBSLPwSkt9wL8aI6TPILnPxIljSnPQDzSYdRYE=;
 b=dIrAYwE/iZJiwzF4ZjeYWzweAkMEXIzmvqLmu/Okp/AAeukiQ2Ftg6U1QTf3YblriPlEj/
 xrwjnr9TEZelyE/Vo/XuasvtXJGqPrm0khpakg0YTAlLHeOvp4re0G7ivqsqq9sjwuXP1R
 Juqf3ZN3ZFfFd2twSqGX/Ocn8lN9cXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-aYgTwB6rNyqYqeajakgoyw-1; Thu, 30 Apr 2020 05:45:25 -0400
X-MC-Unique: aYgTwB6rNyqYqeajakgoyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7B1519200C0;
 Thu, 30 Apr 2020 09:45:23 +0000 (UTC)
Received: from localhost (ovpn-112-226.ams2.redhat.com [10.36.112.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54CDB5EDE2;
 Thu, 30 Apr 2020 09:45:23 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/20] s390x: protvirt: KVM intercept changes
Date: Thu, 30 Apr 2020 11:44:32 +0200
Message-Id: <20200430094445.25943-8-cohuck@redhat.com>
In-Reply-To: <20200430094445.25943-1-cohuck@redhat.com>
References: <20200430094445.25943-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

Protected VMs no longer intercept with code 4 for an instruction
interception. Instead they have codes 104 and 108 for protected
instruction interception and protected instruction notification
respectively.

The 104 mirrors the 4 interception.

The 108 is a notification interception to let KVM and QEMU know that
something changed and we need to update tracking information or
perform specific tasks. It's currently taken for the following
instructions:

* spx (To inform about the changed prefix location)
* sclp (On incorrect SCCB values, so we can inject a IRQ)
* sigp (All but "stop and store status")
* diag308 (Subcodes 0/1)

Of these exits only sclp errors, state changing sigps and diag308 will
reach QEMU. QEMU will do its parts of the job, while the ultravisor
has done the instruction part of the job.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200319131921.2367-7-frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index b2b14bde2b25..1988809ec2e7 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -115,6 +115,8 @@
 #define ICPT_CPU_STOP                   0x28
 #define ICPT_OPEREXC                    0x2c
 #define ICPT_IO                         0x40
+#define ICPT_PV_INSTR                   0x68
+#define ICPT_PV_INSTR_NOTIFICATION      0x6c
=20
 #define NR_LOCAL_IRQS 32
 /*
@@ -1698,6 +1700,8 @@ static int handle_intercept(S390CPU *cpu)
             (long)cs->kvm_run->psw_addr);
     switch (icpt_code) {
         case ICPT_INSTRUCTION:
+        case ICPT_PV_INSTR:
+        case ICPT_PV_INSTR_NOTIFICATION:
             r =3D handle_instruction(cpu, run);
             break;
         case ICPT_PROGRAM:
--=20
2.21.1


