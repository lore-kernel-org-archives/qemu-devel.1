Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D965C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:54:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A4E22242
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4/grAGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A4E22242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX2xO-0007jk-3P
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2ug-0005hM-9T
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2uU-0001kp-PO
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603720297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ob7I2v7tihJ+Ya7kABtYFVTkhG6Yuwi+uJlwIdIRBjE=;
 b=X4/grAGJ56WwrqVhMFZyvyeucSTielQY/i8zHG20bGnuUEdhkRHzMhFJqe08ue4lrQxovJ
 pnhmGzz1IyEiaLMvGvCzqVuoWQxvUHifiJXDB5OEI3LnhMu3U+MZD2Ivbd7hbgE40iZPIQ
 PhF3TDXGi7MXzerrZ2G0b0yEdCLWIaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-70T3oXR4MvOzvx5kNmpLsA-1; Mon, 26 Oct 2020 09:51:36 -0400
X-MC-Unique: 70T3oXR4MvOzvx5kNmpLsA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17DCE102090B
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 13:51:35 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDF6B6EF40;
 Mon, 26 Oct 2020 13:51:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/17] Remove deprecated -no-kvm option
Date: Mon, 26 Oct 2020 09:51:21 -0400
Message-Id: <20201026135131.3006712-8-pbonzini@redhat.com>
In-Reply-To: <20201026135131.3006712-1-pbonzini@redhat.com>
References: <20201026135131.3006712-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The option has never been mentioned in our documentation, it's been
deprecated since years, it's marked with QEMU_ARCH_I386 (which does
not make sense anymore since KVM is available on other architectures,
too), it does not do anything by default in upstream QEMU (since TCG
is the default here anyway), and we're spending too much precious time
each year discussing whether it makes sense to keep this option as a
nice suger or not... let's finally put an end on this and remove it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20201020160504.62460-1-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/deprecated.rst | 11 ++++++-----
 qemu-options.hx            |  3 ---
 softmmu/vl.c               |  4 ----
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 905628f3a0..895433c356 100644
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
 
@@ -504,6 +499,12 @@ System emulator command line arguments
 The ``name`` parameter of the ``-net`` option was a synonym
 for the ``id`` parameter, which should now be used instead.
 
+``-no-kvm`` (removed in 5.2)
+''''''''''''''''''''''''''''
+
+The ``-no-kvm`` argument was a synonym for setting ``-machine accel=tcg``.
+
+
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
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
index 14fc527fc6..09b033ff73 100644
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
2.26.2



