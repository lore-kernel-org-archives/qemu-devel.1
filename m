Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8494C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 07:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF2E23329
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 07:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rw1oFaSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF2E23329
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpnvL-000487-Ug
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 03:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jpnuf-0003HU-Cq
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 03:09:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25661
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jpnud-0008U8-Qk
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 03:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593414546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fawuTb1k2s1/RPCI2SKvzOHGJOjU32e1SGmkU6D2G4E=;
 b=Rw1oFaSLuKJ7WlSKzN9V3iJG5kn8/RnrgQso34g3IDNsp27ipiLeT29RberGkLwMWa/oYh
 pMGDVPiJdNogu1XBu1g+vph3qiV5r1NogthSIh9GqNUUgXUE3utALLJ3tQLrpT934Jfvkq
 pbs1Y4y7eyh0BPPBrBGS9sgaH8eKt9I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-WQ5jNGd5MEmqyzzVrc9EXw-1; Mon, 29 Jun 2020 03:09:03 -0400
X-MC-Unique: WQ5jNGd5MEmqyzzVrc9EXw-1
Received: by mail-wm1-f72.google.com with SMTP id h6so18038537wmb.7
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 00:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fawuTb1k2s1/RPCI2SKvzOHGJOjU32e1SGmkU6D2G4E=;
 b=pUpiIWhz+6EwbT1Llar5gITjpZI8szehkm/fdoPCyBIlAWXQnXH/Ei1Lfe58pke6ua
 AfFDVIlinU2hboLHBkojAWA+j4bV8GIvQ7Jhzog5vj9vYyw3Nmxk41Ar1e8QVb7A0NAv
 k3iJL6PzcI0FE5iFAiE1pKi3264t4HKXW7EbTGjyU63Tk84U6xc+v9WtBxUBRImUt9eN
 dJcbWXMjB12hhyuiW0YOk0qg0rPsZqf/Ha0vaZt0ZiAtcqKAQ94K3kHKJndZJOT4Z2VF
 pGCTD5XSmZAOA1mltKFWfSc/xSFWTMu7yYujJWmW27OTMcA655jJ7rHK7ww+fnXS9O4x
 44cg==
X-Gm-Message-State: AOAM531AAMq8nV5dnNSam/gi7rtQuRZJK/qRAywPtbDBDiYjOymwp+Go
 eBlkn5o6fQXgQ9I1cHDe4ox9azIgL5yGGrjeBXHLxEHgKeR5PKvCSKoTTOF9AyNc9MjNrPSQ74t
 oLFBWJC7uxKIQSG8=
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr15461850wrw.111.1593414541792; 
 Mon, 29 Jun 2020 00:09:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4/rBM6DXBzCq1M3jlss4KnuvLuDnvNCHFH4PY/VselrR3HFasK2K5gK50N60h+FGuXV5mhg==
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr15461824wrw.111.1593414541410; 
 Mon, 29 Jun 2020 00:09:01 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id d13sm36543580wrq.89.2020.06.29.00.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 00:09:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] util/qemu-option: Document the get_opt_value() function
Date: Mon, 29 Jun 2020 09:08:58 +0200
Message-Id: <20200629070858.19850-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:03:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HEXHASH_WORD=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity noticed commit 950c4e6c94 introduced a dereference before
null check in get_opt_value (CID1391003):

  In get_opt_value: All paths that lead to this null pointer
  comparison already dereference the pointer earlier (CWE-476)

We fixed this in commit 6e3ad3f0e31, but relaxed the check in commit
0c2f6e7ee99 because "No callers of get_opt_value() pass in a NULL
for the 'value' parameter".

Since this function is publicly exposed, it risks new users to do
the same error again. Avoid that documenting the 'value' argument
must not be NULL.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v2: Drop confuse comment (Damien Hedde)
---
 include/qemu/option.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/qemu/option.h b/include/qemu/option.h
index eb4097889d..ac50d25774 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -28,6 +28,19 @@
 
 #include "qemu/queue.h"
 
+/**
+ * get_opt_value
+ * @p: a pointer to the option name, delimited by commas
+ * @value: a non-NULL pointer that will received the delimited options
+ *
+ * The @value char pointer will be allocated and filled with
+ * the delimited options.
+ *
+ * Returns the position of the comma delimiter/zero byte after the
+ * option name in @p.
+ * The memory pointer in @value must be released with a call to g_free()
+ * when no longer required.
+ */
 const char *get_opt_value(const char *p, char **value);
 
 void parse_option_size(const char *name, const char *value,
-- 
2.21.3


