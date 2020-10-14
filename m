Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BB3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E6B2076D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GY7GXb2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E6B2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kShG2-0007CV-4q
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 09:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kShEY-0005ub-DR
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 09:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kShEW-0000bE-24
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 09:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602683661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T1x81FEWu1At/pWvIqcqcmRw9/755W+nf1vRmTcoeZY=;
 b=GY7GXb2mtMoIJElxhD7+/VRq0Jt2kXnIzT9vqXtG3z4rWxLqB3/qXfs2QtPCEafEp2QipZ
 3JA2Fnvb7wZFJLDMT00Gn/DM9sisqVv0yryxYIkixJmsUTCz+be37SRScR65Wek0PVDkJg
 pPuHEUuF4i8WXA7jz5Aifl/VRVkQrao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-pjXuoYdNMmaRI_1NSftltg-1; Wed, 14 Oct 2020 09:54:20 -0400
X-MC-Unique: pjXuoYdNMmaRI_1NSftltg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E41558CCB72;
 Wed, 14 Oct 2020 13:54:18 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E4B260C0F;
 Wed, 14 Oct 2020 13:54:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] tests/Makefile.include: unbreak non-tcg builds
Date: Wed, 14 Oct 2020 09:54:10 -0400
Message-Id: <20201014135416.1290679-2-pbonzini@redhat.com>
In-Reply-To: <20201014135416.1290679-1-pbonzini@redhat.com>
References: <20201014135416.1290679-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: berrange@redhat.com, alex.bennee@linaro.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove from check-block the requirement that all TARGET_DIRS are built.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5aca98e60c..4037490b69 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -140,7 +140,7 @@ QEMU_IOTESTS_HELPERS-$(CONFIG_LINUX) = tests/qemu-iotests/socket_scm_helper$(EXE
 check: check-block
 check-block: $(SRC_PATH)/tests/check-block.sh qemu-img$(EXESUF) \
 		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
-		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
+		$(filter qemu-system-%, $(ninja-targets-c_LINKER) $(ninja-targets-cpp_LINKER))
 	@$<
 endif
 
-- 
2.26.2



