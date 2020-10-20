Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BB8C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D6472224B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZuJ1meL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6472224B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUtyI-0001yJ-HY
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUtwj-0000wT-63
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:53:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUtwf-0003C3-6D
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603209184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=akgMhc7eR0i5BVCRcJnC/AoxoBb3HKoU16hj0AREpC0=;
 b=GZuJ1meLtJ9Zkwk5ZPZVDjyKd8ZB3k/Nemift36tRYq/n2PM3o86+sIqOCy6c7ouqX8W/K
 3nOQtrrFxsvQ9TTLHkLnIngPRUW6nbkBMCi3MKHds2WZ8C/zlAapOc2qrIG/kgRizvzPKt
 8rtMt+9IOIV8matWIxlcqW2F51i5sEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-ueAIFweAOMiyqQ_LHAD9KA-1; Tue, 20 Oct 2020 11:53:01 -0400
X-MC-Unique: ueAIFweAOMiyqQ_LHAD9KA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A78710866B8;
 Tue, 20 Oct 2020 15:53:00 +0000 (UTC)
Received: from thuth.com (dhcp-192-238.str.redhat.com [10.33.192.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C9ED27C2A;
 Tue, 20 Oct 2020 15:52:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Remove deprecated -no-kvm option
Date: Tue, 20 Oct 2020 17:52:54 +0200
Message-Id: <20201020155254.56589-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The option has never been mentioned in our documentation, it's been
deprecated since years, it's marked with QEMU_ARCH_I386 (which does
not make sense anymore since KVM is available on other architectures,
too), it does not do anything by default in upstream QEMU (since TCG
is the default here anyway), and we're spending too much precious time
each year discussing whether it makes sense to keep this option as a
nice suger or not... let's finally put an end on this and remove it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/deprecated.rst | 5 -----
 qemu-options.hx            | 3 ---
 softmmu/vl.c               | 4 ----
 3 files changed, 12 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 905628f3a0..66ef89b872 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -27,11 +27,6 @@ System emulator command line arguments
 The ``enforce-config-section`` parameter is replaced by the
 ``-global migration.send-configuration={on|off}`` option.
 
-``-no-kvm`` (since 1.3.0)
-'''''''''''''''''''''''''
-
-The ``-no-kvm`` argument is now a synonym for setting ``-accel tcg``.
-
 ``-usbdevice`` (since 2.10.0)
 '''''''''''''''''''''''''''''
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 1da52a269c..9e1ace04f7 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4351,9 +4351,6 @@ SRST
     Enable FIPS 140-2 compliance mode.
 ERST
 
-HXCOMM Deprecated by -accel tcg
-DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARCH_I386)
-
 DEF("msg", HAS_ARG, QEMU_OPTION_msg,
     "-msg [timestamp[=on|off]][,guest-name=[on|off]]\n"
     "                control error message format\n"
diff --git a/softmmu/vl.c b/softmmu/vl.c
index cb476aa70b..6f5b000f07 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3502,10 +3502,6 @@ void qemu_init(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
-             case QEMU_OPTION_no_kvm:
-                olist = qemu_find_opts("machine");
-                qemu_opts_parse_noisily(olist, "accel=tcg", false);
-                break;
             case QEMU_OPTION_accel:
                 accel_opts = qemu_opts_parse_noisily(qemu_find_opts("accel"),
                                                      optarg, true);
-- 
2.18.2


