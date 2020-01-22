Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AF7C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112EF2253D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqhM8LoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112EF2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuB4g-00014F-C9
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 03:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuB1c-0005sd-Qo
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:06:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuB1b-0006Ki-RB
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:06:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58549
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuB1b-0006KY-Nk
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579680367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1TNpFnh0cmBnEC63KMUrlWRs2Qj4E3E6VTgKkSdjRI0=;
 b=IqhM8LoIheqiX2pq1UPqY5QJFevMJrYV7IrMvS41Deg9uW908x3yr6dQXmEoSaafkxTYrj
 vINUl5X7gyTe4ENaxvki5kIiF/zewYiBqtUeOLdUBJsb9FX4dNOXpp2zD0k6qPZmNMcml6
 rPUDHdEqYU6/FDMK4oySHjIOr3kJWjs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-rc3pOGPFPAWtvfXzdoWZGA-1; Wed, 22 Jan 2020 03:06:05 -0500
Received: by mail-wm1-f69.google.com with SMTP id c4so1724262wmb.8
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 00:06:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/mOXF1TD9+1yrGDb4R2TxgSp1NSRuXORauWLHI+ot/g=;
 b=lfX/qUgq+m3IAhV00N+2KSINdld4EGxY3xKHqtuNIUNH0k8zjiHpPYshj6f572qPGQ
 SFDXjFqHXKTalz04PyZtl9SHDuO0U4kog+f9BIZUEK6u67OEY8NgXWTgykYpNiDY+cVS
 VPiKStYTQDlna743lumWd0aOXlftfvqwrdxete9H++nlcVC1if4LpJB5jReBY2oYD5AC
 WpY42MLS41pETXvEXD8ijtB3NNMmJh4uqbWPBwOwLqH80ICDdlCcSNFdbsHOJ27lFUdS
 nCQjFriGLBW91il5ZhVTe9zrg+4ZQFVe8X960DmWwET2wpAu6rTuSPjxsu4G/c5k58x1
 nnrA==
X-Gm-Message-State: APjAAAWS6UhVqW4LWiTr4ig6DknVEJcWM1Fb969PUrRqxlV967blxazk
 dLXWH+5CARBPHfRFlJ+FBrsK5ggPjtmy6+RH18qzISXz1BRpHJYXr9jjDLWbhkXTXTuWRhV10sM
 /P0g3Jm65fjqXW9Q=
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr1628557wmj.117.1579680363871; 
 Wed, 22 Jan 2020 00:06:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqxq0iSrvMspRcYoBpFUqg2DopUjgwJijtnjefYy9oA5H3UXQlQd8h907Om1+5MnRUt4Ch3CJA==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr1628537wmj.117.1579680363713; 
 Wed, 22 Jan 2020 00:06:03 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 g9sm56239815wro.67.2020.01.22.00.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 00:06:03 -0800 (PST)
Date: Wed, 22 Jan 2020 03:06:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] bios-tables-test: fix path to allowed diff
Message-ID: <20200122080538.591734-5-mst@redhat.com>
References: <20200122080538.591734-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122080538.591734-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: rc3pOGPFPAWtvfXzdoWZGA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: 1e8a1fae7464 ("test: Move qtests to a separate directory")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.=
c
index 6ec1c5be64..6535ab7f04 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -21,7 +21,7 @@
  * in binary commit created in step 6):
  *
  * After 1-3 above tests will pass but ignore differences with the expecte=
d files.
- * You will also notice that tests/bios-tables-test-allowed-diff.h lists
+ * You will also notice that tests/qtest/bios-tables-test-allowed-diff.h l=
ists
  * a bunch of files. This is your hint that you need to do the below:
  * 4. Run
  *      make check V=3D1
--=20
MST


