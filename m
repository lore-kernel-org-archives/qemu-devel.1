Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE569C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63A4A221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUN7gcrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A4A221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGSaI-0004sS-3y
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSZQ-0003AF-0Z
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:49:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32867
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSZO-0000Zg-Eb
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599767361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NEbuGLWmXSZT1rnL/wrgI6AbsDI0NcVYdH+yo7NF+Kc=;
 b=jUN7gcrO/vaVRpzBgUpaX6da7xJd52i+Ebe3IY1hNF0DhGCfVdkwYBRzYPSb+FFTuSOSGY
 4+5+BuOfoz57Gdns6Y8DpdtSVTqhBCZDlnWdtkQWJVxOLyf/mg5i6hq2WqMIDMpUldW8UT
 uw6Gptc24A6v2vgymi5ANAp0fs3AxR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-OlLIUpCuOIiGicyzktWjAg-1; Thu, 10 Sep 2020 15:49:18 -0400
X-MC-Unique: OlLIUpCuOIiGicyzktWjAg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8D6E100670D;
 Thu, 10 Sep 2020 19:49:17 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4D687ED65;
 Thu, 10 Sep 2020 19:49:17 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/18] chardev: Move ParallelChardev typedef to common code
Date: Thu, 10 Sep 2020 15:48:47 -0400
Message-Id: <20200910194903.4104696-3-ehabkost@redhat.com>
In-Reply-To: <20200910194903.4104696-1-ehabkost@redhat.com>
References: <20200910194903.4104696-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:38:09
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The struct itself may have a different definition on each OS, but
we can define the typedef in common code, outside the host OS #ifdefs.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 chardev/char-parallel.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c
index 390d03506c..e32aa2d226 100644
--- a/chardev/char-parallel.c
+++ b/chardev/char-parallel.c
@@ -47,16 +47,17 @@
 #include "chardev/char-fd.h"
 #include "chardev/char-parallel.h"
 
+typedef struct ParallelChardev ParallelChardev;
 #define PARALLEL_CHARDEV(obj) \
     OBJECT_CHECK(ParallelChardev, (obj), TYPE_CHARDEV_PARALLEL)
 
 #if defined(__linux__)
 
-typedef struct {
+struct ParallelChardev {
     Chardev parent;
     int fd;
     int mode;
-} ParallelChardev;
+};
 
 static int pp_hw_mode(ParallelChardev *s, uint16_t mode)
 {
@@ -177,10 +178,10 @@ static void qemu_chr_open_pp_fd(Chardev *chr,
 
 #if defined(__FreeBSD__) || defined(__FreeBSD_kernel__) || defined(__DragonFly__)
 
-typedef struct {
+struct ParallelChardev {
     Chardev parent;
     int fd;
-} ParallelChardev;
+};
 
 static int pp_ioctl(Chardev *chr, int cmd, void *arg)
 {
-- 
2.26.2


