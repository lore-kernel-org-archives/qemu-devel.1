Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13358C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0285206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6m1T7C4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0285206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2SZ-0003Iz-TZ
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KT-0003W0-07
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53118
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KR-0006rH-4T
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598951505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YkZluKnU2LEONvXRPML5K7fgPraIgH8Jah/pV85hiIU=;
 b=L6m1T7C43mKlLjZAevEJBBn0nz8itfQ92XWzlU7VHsSxGFynkREdr9kE0J07NrALnMTrRs
 aDb8EAQZ/e1jSdBr5ujP4AxIIEt9E+EhpJz68UBA6jPZKHcVo4qyVUGSIdd/dkKt5CK2jv
 xTmP7920CC7LPEFq8eiJP8GM82qChls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-pTlvUROINMWTdgiWdotRkA-1; Tue, 01 Sep 2020 05:11:44 -0400
X-MC-Unique: pTlvUROINMWTdgiWdotRkA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5971D51B4
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2020 09:11:43 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED3B961177;
 Tue,  1 Sep 2020 09:11:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/24] meson: use meson mandir instead of qemu_mandir
Date: Tue,  1 Sep 2020 05:11:25 -0400
Message-Id: <20200901091132.29601-18-pbonzini@redhat.com>
In-Reply-To: <20200901091132.29601-1-pbonzini@redhat.com>
References: <20200901091132.29601-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 02:08:15
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When cross-compiling, by default qemu_mandir is 'c:\Program
Files\QEMU', which is not recognized as being an absolute path, and
meson will end up adding the prefix again.

Use the pre-prefixed meson mandir option instead.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200826110419.528931-8-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 1 -
 meson.build | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 1f478a46a9..b9e977f13d 100755
--- a/configure
+++ b/configure
@@ -6648,7 +6648,6 @@ echo "bindir=$bindir" >> $config_host_mak
 echo "libdir=$libdir" >> $config_host_mak
 echo "libexecdir=$libexecdir" >> $config_host_mak
 echo "includedir=$includedir" >> $config_host_mak
-echo "mandir=$mandir" >> $config_host_mak
 echo "sysconfdir=$sysconfdir" >> $config_host_mak
 echo "qemu_confdir=$qemu_confdir" >> $config_host_mak
 echo "qemu_datadir=$qemu_datadir" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 43e2c6e43d..a71b199c5e 100644
--- a/meson.build
+++ b/meson.build
@@ -1223,7 +1223,7 @@ if build_docs
                           output: man,
                           capture: true,
                           install: true,
-                          install_dir: config_host['mandir'] / 'man7',
+                          install_dir: get_option('mandir') / 'man7',
                           command: [pod2man, '--utf8', '--section=7', '--center=" "',
                                     '--release=" "', '@INPUT@'])
     endforeach
@@ -1242,7 +1242,7 @@ summary_info += {'include directory': config_host['includedir']}
 summary_info += {'config directory':  config_host['sysconfdir']}
 if targetos != 'windows'
   summary_info += {'local state directory': config_host['qemu_localstatedir']}
-  summary_info += {'Manual directory':      config_host['mandir']}
+  summary_info += {'Manual directory':      get_option('mandir')}
 else
   summary_info += {'local state directory': 'queried at runtime'}
 endif
-- 
2.26.2



