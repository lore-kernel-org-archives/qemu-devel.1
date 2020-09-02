Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE37C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C792720767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drj/S/Ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C792720767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDSWY-0000DL-Un
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMT-00068k-PB
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34382
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMR-00078G-08
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599051574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MpnvhkuY94YofkmT++ed5KWHesYrjJBLpFzTMzeP1+0=;
 b=drj/S/IeFxsRoazY61h/VPyc+3p8oI6mgDBeTtKGafOjwNSxAUjuwI2iZjwVFl2FG4d1XN
 pXFmL76Ccd++Fa0l2Jsx6/byPk234PFPMZezryODKGRny9qMnvDatKNrNEaOXiPHMpj/eu
 rEmoQnrVUBu2ZIXAjGnBH3BwQFh2vFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-GqS6OwEEOcuoaidG_mMbqg-1; Wed, 02 Sep 2020 08:59:31 -0400
X-MC-Unique: GqS6OwEEOcuoaidG_mMbqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E31F1008542
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:28 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D15F76E01;
 Wed,  2 Sep 2020 12:59:27 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/39] meson: convert vhost-user-bridge
Date: Wed,  2 Sep 2020 08:58:57 -0400
Message-Id: <20200902125917.26021-20-pbonzini@redhat.com>
In-Reply-To: <20200902125917.26021-1-pbonzini@redhat.com>
References: <20200902125917.26021-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200828110734.1638685-10-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include | 2 --
 tests/meson.build      | 9 +++++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index b68911833f..04ffda66a5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -65,8 +65,6 @@ tests/migration/initrd-stress.img: tests/migration/stress$(EXESUF)
 	rm $(INITRD_WORK_DIR)/init
 	rmdir $(INITRD_WORK_DIR)
 
-tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o $(test-util-obj-y) libvhost-user.a
-
 SPEED = quick
 
 # gtester tests, possibly with verbose output
diff --git a/tests/meson.build b/tests/meson.build
index bd5d13f6f9..8c6ace25ef 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -221,6 +221,15 @@ foreach test_name, extra: tests
        suite: ['unit'])
 endforeach
 
+
+if have_tools and 'CONFIG_VHOST_USER' in config_host
+  executable('vhost-user-bridge',
+             sources: files('vhost-user-bridge.c'),
+             link_with: [libvhost_user],
+             dependencies: [qemuutil],
+             build_by_default: false)
+endif
+
 if have_system and 'CONFIG_POSIX' in config_host
   subdir('qemu-iotests')
 endif
-- 
2.26.2



