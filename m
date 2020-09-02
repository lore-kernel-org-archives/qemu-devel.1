Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F043BC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6CAF2072A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7eLTBbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CAF2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNrI-0002fG-Sv
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDNor-00069Z-Bp
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:08:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31012
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDNop-0001lf-OB
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599034115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPGPiB1QKs5CSZ+0D2TKHKMlGexrsgYUk0usBoV2JpU=;
 b=V7eLTBbMPQK7wLs4HZi5AZSM7Ss3Zf5v5CC1dLXVxa2zsQww62n3WFthG5UYx9AajvnatZ
 1RD851mDW00Azj1f3zV9Fk8ZLgexflNjhFZwEqx/4E89l8ezgmxkTcWVPW1dTBSHcaAcbP
 oUIyQK5HeDaJ4Z1RWUBjcGFCSsidNOg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-xmHkW446PuaQcKFzGlLS1g-1; Wed, 02 Sep 2020 04:08:31 -0400
X-MC-Unique: xmHkW446PuaQcKFzGlLS1g-1
Received: by mail-wr1-f72.google.com with SMTP id k11so1639229wrw.16
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IPGPiB1QKs5CSZ+0D2TKHKMlGexrsgYUk0usBoV2JpU=;
 b=KNPzT4sYWPL0ojJpgnZPZwWpAAsXaPvhYFSyxaDqFAQH7b4kq0zksrEkJmemClYhAx
 I3ZC9n4u3StrEiITEAGmBibLVlM7fXCQQT+gBkSaz4YNieVi9nZ8CJ0LqNWUPvoIUCx3
 rDzIRkEJ79fxHSiviOBz5FSdyCgJ5FHSm9kzAuFlfwsxbUr6f6PWcLfMA9Mvf8vQeGem
 wB7kFnTlFA68tqj85sYBL7f7J9CO6jA+MeSy2iC98ngSfL10h68nbeRRQtHb+FC5AjzL
 4sVngOIJBJKIqaDJ4yiPHmT/TqoMVQAt4tPB5r1MiiB51dshL7RBXmxdRqD/egiRYIkO
 1GJQ==
X-Gm-Message-State: AOAM532T3fy8LivN/aOGfFrSXmrDTjyMVkSb54HbTx2cX3Z3MXbqjCxr
 fluOD7eD//u2ZikGmwT1oFW63Tz6ih1xvwuXhOR9o3RoAzfqxdkpQsY1USR2maRc+LXmKRyZQ4b
 vaQlpogysfkEvSvA=
X-Received: by 2002:a5d:4949:: with SMTP id r9mr1493761wrs.27.1599034110191;
 Wed, 02 Sep 2020 01:08:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWlP3zIU6c2cv0vrpsCyddH9464yfvzmcKWfRGRoxhqImfNkE+p33PY74ZHfGcY0Zao6U0kw==
X-Received: by 2002:a5d:4949:: with SMTP id r9mr1493740wrs.27.1599034109985;
 Wed, 02 Sep 2020 01:08:29 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id a15sm2887216wrn.3.2020.09.02.01.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 01:08:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] util/qsp: Do not declare local variable only used for
 assertion
Date: Wed,  2 Sep 2020 10:08:01 +0200
Message-Id: <20200902080801.160652-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902080801.160652-1-philmd@redhat.com>
References: <20200902080801.160652-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This variable is used once in an assertion. Remove single
declaration and access directly in the assert().

See in "qemu/osdep.h":

 *                                  [...] disable assertion is not
 * supported upstream so the risk is all yours.  Meanwhile, please
 * submit patches to remove any side-effects inside an assertion, or
 * fixing error handling that should use Error instead of assert.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/qsp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/util/qsp.c b/util/qsp.c
index 7d5147f1b20..1db044ecedd 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -560,9 +560,7 @@ static void qsp_iter_diff(void *p, uint32_t hash, void *htp)
 
     /* No point in reporting an empty entry */
     if (new->n_acqs == 0 && new->ns == 0) {
-        bool removed = qht_remove(ht, new, hash);
-
-        g_assert(removed);
+        g_assert(qht_remove(ht, new, hash));
         g_free(new);
     }
 }
-- 
2.26.2


