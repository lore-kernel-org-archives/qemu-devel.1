Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA63C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 12:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55EF320753
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 12:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Ls5xg5k1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EF320753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMscy-0005wW-Ec
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 08:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jMscG-0005NJ-T4
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 08:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jMscF-0007Bv-UO
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 08:18:36 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:36335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jMscF-0007BT-DI; Fri, 10 Apr 2020 08:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=Hz3ulBmdpF4r2v6cud9D5vQ2ufWiyxbShw1ne3elaLE=; 
 b=Ls5xg5k1TmKAulGGhiYfDOBbINRPE1HlyPxZmsNCcR2MefWPWnG6bbdWx+h+qFGYOepoWVA5C+uBcJBBEe/jSjefRBZehVRJjZk7rMQnrktvDbYBAhwEyV0K0RFySKztHUHmAGSCCUFaM07D5pVWtmuSEzYjMbTuliurAak87CAMXiJiLYxBch0lONedUXMVv1EjwbOHlPgHlw1r363ou/fPub+UtFluUKADydbXQvnu4v9Pmv8LXfuOW047n/CggeQNDSg3eovBNQ8xPQY6NoodrS1qLLMOx4scuVrQW0uUQTJiPJ4dE2Dp2ODdtbndCQCOIX3YhyPrKS7oGhTjfg==;
Received: from static.113.35.0.81.ibercom.com ([81.0.35.113]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jMscD-0000On-6G; Fri, 10 Apr 2020 14:18:33 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jMsby-0002BA-D2; Fri, 10 Apr 2020 14:18:18 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0] qcow2: Add incompatibility note between backing files
 and raw external data files
Date: Fri, 10 Apr 2020 14:18:15 +0200
Message-Id: <20200410121816.8334-1-berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Backing files and raw external data files are mutually exclusive.
The documentation of the raw external data bit (in autoclear_features)
already indicates that, but we should also mention it on the other
side.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 docs/interop/qcow2.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 640e0eca40..298a031310 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -25,6 +25,9 @@ The first cluster of a qcow2 image contains the file header:
                     is stored (NB: The string is not null terminated). 0 if the
                     image doesn't have a backing file.
 
+                    Note: backing files are incompatible with raw external data
+                    files (auto-clear feature bit 1).
+
          16 - 19:   backing_file_size
                     Length of the backing file name in bytes. Must not be
                     longer than 1023 bytes. Undefined if the image doesn't have
-- 
2.20.1


