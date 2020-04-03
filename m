Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A3AC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D83A206F6
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfzZt9qr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D83A206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKPb2-00040q-Kz
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 12:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKPaR-0003Yh-E2
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKPaQ-0005M3-0R
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:54:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50560
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKPaP-0005LN-Rn
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585932868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=o1XD0Qodnbges3d/qyEnRtQpf1zDSXoUMfhIfOe0AOQ=;
 b=bfzZt9qrfpwPKPAXFklKdLSPDxKCWYjqdajR8vmTWWzIFXcnBX+/TTJwyqPTZjN8MxGv3F
 gRU5+fiuR3k7cMhAShfHLXE6nfhfuYqvm9Uh4dVpKKfXnv0OuM5cue4Xa2QS6ev/3u4EaB
 pTsUnp3vR720jh4lUeUXk1sm8vu2J6o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-a_ggHFCmN56V7ZsJ1oK2Rg-1; Fri, 03 Apr 2020 12:54:26 -0400
X-MC-Unique: a_ggHFCmN56V7ZsJ1oK2Rg-1
Received: by mail-wm1-f70.google.com with SMTP id w8so3030292wmk.5
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 09:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZymZDW6hnWGsTglc2odogyoM9NQtmfDEskQEt3SBLUM=;
 b=mJfSDl6XeqG/l4Dh1HQuO58sApI+SbKsaOBfmZBHJBta/TCpAwoF62vs5ri2l8msZt
 GUSlDqr8yxg5jJwuL2oS5XRA1AzUYYLIWeHSBhUroDyD3+8mVTOtOOCrhr5gRTOP7KKC
 2+TjumikAWTrAQxmyEoAPpiRd0mLkPY8qUX6VEN0Qscb+IHzIIUVr/jD65Rt/oqBcEvW
 aQzIMDWqLqE8WerjDF4NhAANBwI7dWoEO9n7pbjDdt6gd2gOc5Uj711hsprIYUJCSRuu
 7c++jp0qSB6VqRRI1vgvyEXr5Z3PIJueaz5SnrpfT0ku5D3LTayURhwhPR48LKhuXDlt
 mnhg==
X-Gm-Message-State: AGi0PuY/SgC7eB2FhtBXOSM/oit4RUd0APCWggJRYEqguknS9t89MPTz
 LTMLxJR+xn4R4Dtw75apQUo9dSBL30ZOn88epVyCgp/Jcp8v81a2G0hO36sigUZETR+gKznP8Tt
 P10OkoTw28flX0AA=
X-Received: by 2002:a5d:6a4e:: with SMTP id t14mr10346881wrw.101.1585932865358; 
 Fri, 03 Apr 2020 09:54:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypIZzvGHnIBFgWKNJMjMmTW6do5oNqimaOYH6s/cNQD6fC3XZYNWYg4orRWfImPCtsU0SzuifQ==
X-Received: by 2002:a5d:6a4e:: with SMTP id t14mr10346868wrw.101.1585932865140; 
 Fri, 03 Apr 2020 09:54:25 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a13sm12568593wrh.80.2020.04.03.09.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 09:54:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH-for-5.0?] configure: Do not leave sphinx in-tree artifacts
Date: Fri,  3 Apr 2020 18:54:22 +0200
Message-Id: <20200403165422.21714-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When ./configure checks the sphinx version is new enough, it leaves
the docs/sphinx/__pycache__/ directory. Avoid this by using the '-B'
option (don't write .py[co] files on import) via the
PYTHONDONTWRITEBYTECODE environment variable.

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 22870f3867..ed524399c7 100755
--- a/configure
+++ b/configure
@@ -4936,7 +4936,7 @@ has_sphinx_build() {
     # sphinx-build doesn't exist at all or if it is too old.
     mkdir -p "$TMPDIR1/sphinx"
     touch "$TMPDIR1/sphinx/index.rst"
-    "$sphinx_build" -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMP=
DIR1/sphinx/out" >/dev/null 2>&1
+    PYTHONDONTWRITEBYTECODE=3Dyes "$sphinx_build" -c "$source_path/docs" -=
b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
 }
=20
 # Check if tools are available to build documentation.
--=20
2.21.1


