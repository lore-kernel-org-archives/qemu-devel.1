Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D323C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510452063A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510452063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhArt-0005L8-I8
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoi-0008Gm-Gf
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:20 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:42897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoh-0006iw-1K
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:20 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N4Q4m-1izu7J2HVm-011VBZ; Fri, 05 Jun 2020 13:47:07 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 05/19] linux-user/mmap.c: fix integer underflow in target_mremap
Date: Fri,  5 Jun 2020 13:46:46 +0200
Message-Id: <20200605114700.1052050-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605114700.1052050-1-laurent@vivier.eu>
References: <20200605114700.1052050-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ga9jgcQO+kjdoOyWdWYM+CF0HEBsS0q9SxmybE2WV2mpG8z0Tnm
 q7tH18xVoj77aWbFCpvPmbqpzpdbGBGFAm8DLE4u9slcTmhh6qu0ZP+sjDF6wMEDTbI3iqR
 YSnhwKzuEJvGBVpH1WAvGvJjsPbdQr6/ujR7xxGuz8+3D5k1WAz6Pq7C4aXX6eY2a2hp4mJ
 S3u3CPE7r5XjVyvw5FD5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CYjl3Us4nIw=:8d2MiDOkbv1i/MkGhLxav3
 xeubtyWPGDyJmTnOAd1vP56SaWK4HRq0oB4Wh2h4qQ9zF/1iQUDXDKlu6v8ZkXafHV4CeVpYe
 0jgIzAswb+fd1xsIV6kxV6Dzvl4ogwJxbVu5mR3r0rfylAZBq5ImS2DIYx+6xEBZ2/V/kZuDf
 xbQoGj5aLVzCdkMlWtJcngc3fMHTSb2+eSzOj7dFp5kBtNT9NfEYZ3Cd5A9xJELldmx+oBLvC
 nc1+OPdQpFEMtnjpY59GByG0LGs9wPQfm/V22FmbnK97i+G5wUR040PugWK8mVe/W/3zxLXEX
 5L0aYGZqnmceV6QdLj62FSXbNnp/Gk0zAnbS9fBXMpRYWjBv8qn/DYzgGauzlxS+ABcQ8pe2U
 ueDOh8mQGbN/VZpFPEUZxpOlPBh+R/PMqgL/pBPdgC59UIoh5UyZu6UxrFLVS1VplHTOJrnx2
 A1af3+PvwfCesQ3fZWYlHv+p8J3Efk4EQCtdCYm5gj61g7nQhAyuhfPlLCMphmv/JhHcVRLqc
 VcxrLVWJvd6YknK+MJ3zK4WXonvIb+mJHBsBhVbo4jTCggGEhFi0PTXkWm6cUFceqqHhvx56G
 jpOCiYg2zZHx0U7zDZuF6PDuLapaFKhsX/sus5u3eXX4lEQstnnxwfNkInClw+eS2s/eeEqyQ
 GVzkzmTdCR0oVwPUgpQMgvw2ckInTRUbt4cnYZKGMjH7Wgfg6JS+K3NrCP5wLQrAsGu/XT2jN
 27uqFKMGQduHh4OEQK3jR+vYWCCZkvB46X31Pyz7tJmkydE11JQq2suMvUkmND8uPfeew30/v
 1xg5WllMrvzVRrAy0wSqgT+LadkKt+MiM7YZG4rk4waMTXGJ4IqVXczj065HxsVE1HPUf4L
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:47:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Jonathan Marler <johnnymarler@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jonathan Marler <johnnymarler@gmail.com>

Fixes: https://bugs.launchpad.net/bugs/1876373

This code path in mmap occurs when a page size is decreased with mremap.  When a section of pages is shrunk, qemu calls mmap_reserve on the pages that were released.  However, it has the diff operation reversed, subtracting the larger old_size from the smaller new_size.  Instead, it should be subtracting the smaller new_size from the larger old_size.  You can also see in the previous line of the change that this mmap_reserve call only occurs when old_size > new_size.

Bug: https://bugs.launchpad.net/qemu/+bug/1876373
Signed-off-by: Jonathan Marler <johnnymarler@gmail.com>
Reviewded-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200502161225.14346-1-johnnymarler@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index e37803379747..caab62909eb1 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -708,7 +708,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
         if (prot == 0) {
             host_addr = mremap(g2h(old_addr), old_size, new_size, flags);
             if (host_addr != MAP_FAILED && reserved_va && old_size > new_size) {
-                mmap_reserve(old_addr + old_size, new_size - old_size);
+                mmap_reserve(old_addr + old_size, old_size - new_size);
             }
         } else {
             errno = ENOMEM;
-- 
2.26.2


