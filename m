Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4480FC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:15:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D3FB2468D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEOHGxZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3FB2468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcrO-0007PD-Ev
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1jBcqN-0006ia-IC
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1jBcqM-0007Rg-0q
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:14:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42702
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1jBcqL-0007PI-Rz
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583838876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UkklVopQ1HHnd3o6jX8v6sjMqY3VU44drciZfMmG6v4=;
 b=YEOHGxZABXtu0i36qsFZ1pocx3z6+AtaI4N+FY4A8lOKz4sx6ySLBxwnB+ri/Lyyj3Xb/a
 LX+5b0x++lYyX6EMofMVW4qov3PEu02M4DqUKfZphGIlvsjw33ylrQCEYFTMBISsI2qNB2
 BN1VJ3ewGROZbWfppyrmNwGCJr5b+uA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-bbeQaaMkNu6MYR7HLf2LyQ-1; Tue, 10 Mar 2020 07:14:35 -0400
X-MC-Unique: bbeQaaMkNu6MYR7HLf2LyQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E4E8107B277;
 Tue, 10 Mar 2020 11:14:34 +0000 (UTC)
Received: from secure.mitica (unknown [10.36.118.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1797610002A2;
 Tue, 10 Mar 2020 11:14:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] configure: Improve zstd test
Date: Tue, 10 Mar 2020 12:14:31 +0100
Message-Id: <20200310111431.173151-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There were one error on the test (missing an s for --exists).
But we really need a recent zstd (1.4.0).
Thanks to Michal Privoznik to provide the right vension.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reported-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index cbf864bff1..f5454bd603 100755
--- a/configure
+++ b/configure
@@ -2475,7 +2475,8 @@ fi
 # zstd check
=20
 if test "$zstd" !=3D "no" ; then
-    if $pkg_config --exist libzstd ; then
+    libzstd_minver=3D"1.4.0"
+    if $pkg_config --atleast-version=3D$libzstd_minver libzstd ; then
         zstd_cflags=3D"$($pkg_config --cflags libzstd)"
         zstd_libs=3D"$($pkg_config --libs libzstd)"
         LIBS=3D"$zstd_libs $LIBS"
--=20
2.24.1


