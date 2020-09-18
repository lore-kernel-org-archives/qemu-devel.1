Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C21C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F66B20872
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqGq7HnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F66B20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJKni-0002aA-Vt
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJKks-0000Lr-7w
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:05:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJKkq-0002nW-I5
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600452303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=syFAbH20ps3bZJnXHQ5hKzOCwTqYrnEvIr2Q/VfgrK0=;
 b=XqGq7HnVMyCNS6JD01soHIVLs6oDBwt+occP4ymTNlrycl2wfnZhHLUU1Eog+TSQmW+ToO
 sihz7lrey2SRPuw4OrgtZ0fFdhoypxfsqC8RonHE+Ex1gghLvjrpsgEwa6svyLo5Tuf5Ca
 gxbJrePbBKIDOmZWA+xZu4aol3m2Zr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-TrH9_ArSMo-vyNLMfzqZJQ-1; Fri, 18 Sep 2020 14:04:57 -0400
X-MC-Unique: TrH9_ArSMo-vyNLMfzqZJQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75A0B18BE163;
 Fri, 18 Sep 2020 18:04:56 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1163E1002D58;
 Fri, 18 Sep 2020 18:04:55 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PULL 2/2] analyze-migration.py: fix read_migration_debug_json()
 return type
Date: Fri, 18 Sep 2020 14:04:51 -0400
Message-Id: <20200918180451.1121055-3-ehabkost@redhat.com>
In-Reply-To: <20200918180451.1121055-1-ehabkost@redhat.com>
References: <20200918180451.1121055-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alexey Kirillov <lekiravi@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Kirillov <lekiravi@yandex-team.ru>

Since we use result of read_migration_debug_json() as JSON formatted string,
we must provide proper type. Before Python 3.6 json.loads() method
support only str typed input.

Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
Message-Id: <20200715152135.20287-1-lekiravi@yandex-team.ru>
[ehabkost: added comment explaining why decode() is needed}
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/analyze-migration.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 95838cbff3..d70ec7d33a 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -97,7 +97,8 @@ class MigrationFile(object):
         # Seek back to where we were at the beginning
         self.file.seek(entrypos, 0)
 
-        return data[jsonpos:jsonpos + jsonlen]
+        # explicit decode() needed for Python 3.5 compatibility
+        return data[jsonpos:jsonpos + jsonlen].decode("utf-8")
 
     def close(self):
         self.file.close()
-- 
2.26.2


