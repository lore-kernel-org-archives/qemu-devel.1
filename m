Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615FFC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B82C2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWDd9Lu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B82C2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThJl-0003zS-Ap
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh3H-0000WC-2f
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh2I-0004MF-IV
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:22:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46346
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTh2I-0004M5-5s
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588144897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cD8zki1D1EIAJAynicB/92D9YP+ssmVx79XfEZUiT4M=;
 b=UWDd9Lu7LSGeBsDAqFIKmTQDGj6/NTEkNtsL7ZqHOLAMkKoy5JjA2NoZUqxgi5scNFx0ip
 pCwibgDUGiu7omtQLxYmlpc3x7JNp5XPYKF/jHRtTrIEYlkYKGpJkka6STsUrymCAIVYap
 pu99VyjbzTu1JqW7y9lcyWWUeonVrSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134--_6VvPBLMkOUdryorqLXhg-1; Wed, 29 Apr 2020 03:20:54 -0400
X-MC-Unique: -_6VvPBLMkOUdryorqLXhg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B71C11009454
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 07:20:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8760566060;
 Wed, 29 Apr 2020 07:20:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4E69111358D3; Wed, 29 Apr 2020 09:20:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/32] tests/test-logging: Fix test for -dfilter
 0..0xffffffffffffffff
Date: Wed, 29 Apr 2020 09:20:38 +0200
Message-Id: <20200429072048.29963-23-armbru@redhat.com>
In-Reply-To: <20200429072048.29963-1-armbru@redhat.com>
References: <20200429072048.29963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: 58e19e6e7914354242a67442d0006f9e31684d1a
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200422130719.28225-13-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/test-logging.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/test-logging.c b/tests/test-logging.c
index 6387e4933f..8580b82420 100644
--- a/tests/test-logging.c
+++ b/tests/test-logging.c
@@ -73,10 +73,10 @@ static void test_parse_range(void)
     g_assert(qemu_log_in_addr_range(UINT64_MAX));
     g_assert_false(qemu_log_in_addr_range(UINT64_MAX - 1));
=20
-    qemu_set_dfilter_ranges("0..0xffffffffffffffff", &err);
+    qemu_set_dfilter_ranges("0..0xffffffffffffffff", &error_abort);
     g_assert(qemu_log_in_addr_range(0));
     g_assert(qemu_log_in_addr_range(UINT64_MAX));
-=20
+
     qemu_set_dfilter_ranges("2..1", &err);
     error_free_or_abort(&err);
=20
--=20
2.21.1


