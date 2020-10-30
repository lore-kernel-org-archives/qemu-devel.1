Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827A9C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:28:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA7A20725
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrEXSGom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA7A20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYWKe-0003yC-Ic
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYWJk-0003Ja-F9
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52383)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYWJi-0000aU-K9
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604071669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ODLpRQSBoXdl2bHweXJxYHi5dpQs8FLpRt3OFMg34a8=;
 b=hrEXSGom8forsHV+AuJlt7TgvXosHJUqhyph+8nOnzyw7Alvnwi71eDSqPr7qB/Afip6o6
 0d+MQEGwf75dp31N3XPZwr36G/s3wBl9F8HUn2tYagLp3krQWVzvKJ+SF8uhaQ+1odkcO/
 SN8nvVu03TdUccK+AjuqcX6eo3zvMKI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-sN_8XrC4MjmEFyrDT4RE4Q-1; Fri, 30 Oct 2020 11:27:47 -0400
X-MC-Unique: sN_8XrC4MjmEFyrDT4RE4Q-1
Received: by mail-wr1-f71.google.com with SMTP id q15so2786105wrw.8
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 08:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ODLpRQSBoXdl2bHweXJxYHi5dpQs8FLpRt3OFMg34a8=;
 b=muKa7D0y/5eqks6XNC0xLl+/P2IvfQvkROFjkYx72dfy3iocuXhgG3DsIlewTVHdtK
 /IF7G+HTpAhlzyJ1Oj4KOHOZjQcsTN5PBScy/92kAgFr8XP7LWNR9VKSkfkNb44pKc1m
 D2tBs3j1Ji52Sn9leRRp7xcSCnQKAJoAdRp68izEZiu1bqSyR6RMS8qi9/dcpmAyNnAe
 KzjWceugp8EKAJwXyoaUPtfWSKAu+gao3vRWy3Xj3w5SxBlzY6T5YeDyLBItCwsQBIZ5
 k5BlB5uMceVtFXi6H85nWJ4kN7SziqqBSof2MZhY1eGDLWfPSWfVj25J8RhVZr8fdRYM
 hB9Q==
X-Gm-Message-State: AOAM531lekSLt6n/atyJmYPS5GzybVXMFhPs8VtQTTcog9fIvAHW763D
 tbJz3VI9UoXWTZMiQH04xgjRPV98J350nTtJWN6L3xls5UTxMTgj4fhvAQZiTh+F9jAvadWKNV1
 WWMsTfVhI8XCT1Mg=
X-Received: by 2002:a7b:cb98:: with SMTP id m24mr3469674wmi.133.1604071665919; 
 Fri, 30 Oct 2020 08:27:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3Dcxvi3XzCBl1YGdtvla7Qmz6e78ESlq+XKDZyMg1El3isjuWJq/ymQKTrsJKa45YWs/nsA==
X-Received: by 2002:a7b:cb98:: with SMTP id m24mr3469654wmi.133.1604071665744; 
 Fri, 30 Oct 2020 08:27:45 -0700 (PDT)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f20sm5123247wmc.26.2020.10.30.08.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 08:27:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] hw/smbios: Fix leaked fd in save_opt_one() error path
Date: Fri, 30 Oct 2020 16:27:42 +0100
Message-Id: <20201030152742.1553968-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix the following Coverity issue (RESOURCE_LEAK):

  CID 1432879: Resource leak

    Handle variable fd going out of scope leaks the handle.

Replace a close() call by qemu_close() since the handle is
opened with qemu_open().

Fixes: bb99f4772f5 ("hw/smbios: support loading OEM strings values from a file")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/smbios/smbios.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 8b30906e50a..6a3d39793bc 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -988,16 +988,18 @@ static int save_opt_one(void *opaque,
             if (ret < 0) {
                 error_setg(errp, "Unable to read from %s: %s",
                            value, strerror(errno));
+                qemu_close(fd);
                 return -1;
             }
             if (memchr(buf, '\0', ret)) {
                 error_setg(errp, "NUL in OEM strings value in %s", value);
+                qemu_close(fd);
                 return -1;
             }
             g_byte_array_append(data, (guint8 *)buf, ret);
         }
 
-        close(fd);
+        qemu_close(fd);
 
         *opt->dest = g_renew(char *, *opt->dest, (*opt->ndest) + 1);
         (*opt->dest)[*opt->ndest] = (char *)g_byte_array_free(data,  FALSE);
-- 
2.26.2


