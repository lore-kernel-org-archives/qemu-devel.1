Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E358C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69BAE20663
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ca+yngGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BAE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpDI-0003D7-Hk
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpBp-0000jW-Tm
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpBo-0004GV-W9
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21882
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpBo-0004F7-Ry
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wGoD8B/E7ALRdyPVkuOPFi6qepohKGtXhwvJlBp3QNU=;
 b=ca+yngGFE8NxbkXX6oWqxkQjLgtLsN1q2EGwRkaZ48rMXvB2Gihl3PUUCDbIm9ebYKmf5q
 msnpwsJoFwUibjga7Oyqj1Ph+F96taRZfBs5aho1bu0jtXLlo1n872QPFYDl1GReA1S/k2
 cFvqvkpogFSLiIMDVwehyF0EhSNTi2c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-BzChaShcOrOYDHknBqJgmQ-1; Fri, 13 Mar 2020 14:37:43 -0400
X-MC-Unique: BzChaShcOrOYDHknBqJgmQ-1
Received: by mail-wr1-f70.google.com with SMTP id o9so4728791wrw.14
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T76tUQ+vOJYR7iIj3p+P6wqlEgQ0pagAj6PhTCTXdsc=;
 b=LTgBObgnoPdc7jKxK/ILCb98m/9YuoN1wtkCxAFZzcNA7M4jzC7BGEmcgaSmhQGBv/
 6QpNfTFIAVgrWpsem6VSB9CL5Xuh5fgLZ9DHr3GtDp4oJiQkt/Sc3rkqM0QDO7b4P+uJ
 BPRR9ak5AoirKaS7JLvYS4ZoqnR2YqfQufUbbjJJUHiVQmbSwW1xEFnksm1VsGL9oMsp
 REsrsGMy+QrCN8JYROUMTbniloG0IlGk8NRP0O5H06qdEQYDbsuF7F98ZYYuZm9ng3Z7
 lFOVIFKeHIt90uHA6R4vZWs0zBKO/3xEx3X7bGRPzo7Tkm5giK2JnaeWvMc6EC1Aqp+A
 MN5Q==
X-Gm-Message-State: ANhLgQ150QQ+A9i0ewC5KDoERuMPFzmWEv40m8HgevrNkqDpSABBml5c
 HPcVBRlGHgOv5pggqloBhafogQQY1XtZ8ZGwBZxqeP7Y/bLAM/7HR1EFpPQKNFZiWYkQLwP+yN7
 l2k3cfyXyDW6yRQA=
X-Received: by 2002:a7b:ce94:: with SMTP id q20mr11560607wmj.157.1584124661706; 
 Fri, 13 Mar 2020 11:37:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt55lOk8cq/FfDyGsqCjNX/EF/f1KG2Wt2coox2gOYadwCTOT9928FGmsSSu/bYROjhTtyiSQ==
X-Received: by 2002:a7b:ce94:: with SMTP id q20mr11560582wmj.157.1584124661544; 
 Fri, 13 Mar 2020 11:37:41 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id w10sm4132784wrr.49.2020.03.13.11.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:37:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/14] exec: Drop redundant #ifdeffery
Date: Fri, 13 Mar 2020 19:36:47 +0100
Message-Id: <20200313183652.10258-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313183652.10258-1-philmd@redhat.com>
References: <20200313183652.10258-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 exec.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/exec.c b/exec.c
index 7bc9828c5b..f258502966 100644
--- a/exec.c
+++ b/exec.c
@@ -185,10 +185,6 @@ struct DirtyBitmapSnapshot {
     unsigned long dirty[];
 };
=20
-#endif
-
-#if !defined(CONFIG_USER_ONLY)
-
 static void phys_map_node_reserve(PhysPageMap *map, unsigned nodes)
 {
     static unsigned alloc_hint =3D 16;
--=20
2.21.1


