Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEDBC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 02:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51DE020656
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 02:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DE020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hggTy-0008D4-DM
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 22:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50048)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hgg8N-0000lf-HF
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 21:57:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hgg8L-0000gK-OK
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 21:57:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45357)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hgg8L-0000eJ-I7
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 21:57:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CCAB13084266;
 Fri, 28 Jun 2019 01:57:00 +0000 (UTC)
Received: from localhost (ovpn-116-7.gru2.redhat.com [10.97.116.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09F0B60126;
 Fri, 28 Jun 2019 01:56:59 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu, 27 Jun 2019 22:55:57 -0300
Message-Id: <20190628015606.32107-21-ehabkost@redhat.com>
In-Reply-To: <20190628015606.32107-1-ehabkost@redhat.com>
References: <20190628015606.32107-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 28 Jun 2019 01:57:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 20/29] target/i386: fix feature check in
 hyperv-stub.c
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Roman Kagan <rkagan@virtuozzo.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Commit 2d384d7c8 broken the build when built with:

  configure --without-default-devices --disable-user

The reason was the conversion of cpu->hyperv_synic to
cpu->hyperv_synic_kvm_only although the rest of the patch introduces a
feature checking mechanism. So I've fixed the KVM_EXIT_HYPERV_SYNIC in
hyperv-stub to do the same feature check as in the real hyperv.c

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20190624123835.28869-1-alex.bennee@linaro.org>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/hyperv-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/hyperv-stub.c b/target/i386/hyperv-stub.c
index fe548cbae2..0028527e79 100644
--- a/target/i386/hyperv-stub.c
+++ b/target/i386/hyperv-stub.c
@@ -15,7 +15,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_e=
xit *exit)
 {
     switch (exit->type) {
     case KVM_EXIT_HYPERV_SYNIC:
-        if (!cpu->hyperv_synic) {
+        if (!hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
             return -1;
         }
=20
--=20
2.18.0.rc1.1.g3f1ff2140


