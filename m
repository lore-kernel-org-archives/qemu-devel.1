Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A5AC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB04B207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHKYWahf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB04B207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZEfS-0006OG-Sa
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:44:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZEZt-0000aq-IL
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:38:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZEZr-0007lq-Hh
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:38:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48141
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZEZp-0007hs-IV
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574689132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bCqTIRv4rNdiRxSSYNe+1CG0I+mTlFwCDHW4Yah4NRg=;
 b=LHKYWahf2PHGj7Jgfw0XMybtCPD0HpPOEXPe9iXw9XlZlDLzyAR+55JY3U6GtXe5aYcp+x
 mnhQas3FGvhf6v0gb6Fyn6r3+7cdbvF8pw2cNWgQZ+6tZjahyffjLoNLaeGQIyv2KzV94h
 QI6uiI3ERWMcBMV0rS0ZWd33MOcDRuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-WkZ3LYmuO06nFinX2KCT4A-1; Mon, 25 Nov 2019 08:38:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE5BA1801B88;
 Mon, 25 Nov 2019 13:38:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8813E5D6AE;
 Mon, 25 Nov 2019 13:38:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0803D11366CC; Mon, 25 Nov 2019 14:38:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] test-keyval: Tighten test of trailing crap after size
Date: Mon, 25 Nov 2019 14:38:46 +0100
Message-Id: <20191125133846.27790-3-armbru@redhat.com>
In-Reply-To: <20191125133846.27790-1-armbru@redhat.com>
References: <20191125133846.27790-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: WkZ3LYmuO06nFinX2KCT4A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-trivial@nongnu.org, tao3.xu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

test_keyval_visit_size() should test for trailing crap after size with
and without suffix.  It does test the latter: "sz2=3D16Gi" has size
"16G" followed by crap "i".  It fails to test the former "sz1=3D16E" is
a syntactically valid size that overflows uint64_t.  Replace by
"sz1=3D0Z".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-keyval.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index 09b0ae3c68..e331a84149 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -478,7 +478,7 @@ static void test_keyval_visit_size(void)
     visit_free(v);
=20
     /* Trailing crap */
-    qdict =3D keyval_parse("sz1=3D16E,sz2=3D16Gi", NULL, &error_abort);
+    qdict =3D keyval_parse("sz1=3D0Z,sz2=3D16Gi", NULL, &error_abort);
     v =3D qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
--=20
2.21.0


