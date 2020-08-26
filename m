Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DABDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C740C2080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iF25wRo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C740C2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtLE-0006Pw-3O
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAtGj-00075H-1n
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:07:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36468
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAtEm-00039M-Hm
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598439903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=STAiIOun13Xq9as09CTvKHfANgWUbmuNAt9hQQAyelE=;
 b=iF25wRo3Dhb4Xv5wHM7rNaLiAcQuCtqp5ViahzOuxBEGbEkgyGhUfBQ3oYij1eYgtdtHkg
 X988dYWY43R1WDdDPPPknK1bcqsIe4xfB6/0jR1Kt0ZUU91w5kAo60UDddNugyapFtDSo2
 Hye7wWWStMGwYnjAi8BKDZoKyOTiU/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-GynGley4M3iYXk0d_feBNQ-1; Wed, 26 Aug 2020 07:05:00 -0400
X-MC-Unique: GynGley4M3iYXk0d_feBNQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70220807339;
 Wed, 26 Aug 2020 11:04:59 +0000 (UTC)
Received: from localhost (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DDEA1002D47;
 Wed, 26 Aug 2020 11:04:52 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/8] meson: pass qemu_suffix option
Date: Wed, 26 Aug 2020 15:04:15 +0400
Message-Id: <20200826110419.528931-5-marcandre.lureau@redhat.com>
In-Reply-To: <20200826110419.528931-1-marcandre.lureau@redhat.com>
References: <20200826110419.528931-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:16:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: sw@weilnetz.de, berrange@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following patches will make use of it to fix installation paths.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configure         | 1 +
 meson_options.txt | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/configure b/configure
index e880e5676d..05b944fb8e 100755
--- a/configure
+++ b/configure
@@ -8223,6 +8223,7 @@ NINJA=$PWD/ninjatool $meson setup \
         --mandir "${pre_prefix}$mandir" \
         --sysconfdir "${pre_prefix}$sysconfdir" \
         --localstatedir "${pre_prefix}$local_statedir" \
+        -Dqemu_suffix="$qemu_suffix" \
         -Doptimization=$(if test "$debug" = yes; then echo 0; else echo 2; fi) \
         -Ddebug=$(if test "$debug_info" = yes; then echo true; else echo false; fi) \
         -Dwerror=$(if test "$werror" = yes; then echo true; else echo false; fi) \
diff --git a/meson_options.txt b/meson_options.txt
index c55f9cd94c..1ef822bab3 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -1,3 +1,5 @@
+option('qemu_suffix', type : 'string', value: '/qemu',
+       description: 'Suffix for QEMU data/modules/config directories (can be empty)')
 option('gettext', type : 'boolean', value : true)
 option('sdl', type : 'feature', value : 'auto')
 option('sdl_image', type : 'feature', value : 'auto')
-- 
2.26.2


