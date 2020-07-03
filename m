Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148D9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6ECD2084C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOBQIL7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6ECD2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrQXH-0005Ip-6Z
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 14:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrQWb-0004nb-PZ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 14:35:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30808
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrQWZ-0004NX-TS
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 14:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593801298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I2vs6DYntpzoHU8z2jv7tCuhMW9L31TJJg52Yx3kANg=;
 b=aOBQIL7ULzzxvBG1/JgOdnojyjujvf5gWNYNGQa+aNiN+Ut6k//ieeYXqOGJBzrh7QenG0
 CF0rJvJP7o0aUGssqnpBZwW7MOEncK8Ts6Jg7+pBLFKOuxh0+sTZAwm3M+R8DNeEzNOAsZ
 TB70d4NSo0wGS+Uwzm/GgkLjKfb6Imk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-eYvo8GGkO7eGeBT9dY3VeQ-1; Fri, 03 Jul 2020 14:34:54 -0400
X-MC-Unique: eYvo8GGkO7eGeBT9dY3VeQ-1
Received: by mail-wr1-f70.google.com with SMTP id f5so32431218wrv.22
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 11:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=I2vs6DYntpzoHU8z2jv7tCuhMW9L31TJJg52Yx3kANg=;
 b=GuZ/PdyAZDcQM0CWr7HFE27kX0+s1b6BTYITLxnjS2lA4iiYpcV6G7VyNEF5Ucz82a
 8SH4pae39kskQHruse69/o3gZS4zKEQEPOd6eCO4u4F8ttsewfnRJa9yjffeYHBf3iLt
 tyegbCbPbKlt8ImJFsgyCHNxujX3DCX5OyJrjH3ba30J6yU2+BVZw2AajGHuWfsMLdDC
 jpEGETaaJyV0qyy9GTW6zvG8n9d/VaEoGbkPvseUQuT34ZtteYq+5QdCnUDwlIwZ1Bpq
 913v+LZOR1RVW3lF/mOXpQ2NbzabfSkwurrja1jcRPOKWqCwFf2MM04x3fec1AQh/PkT
 s3PA==
X-Gm-Message-State: AOAM530A5ePDnTaupYisXTRFe7MvrvdqDORWVaI4AmVb3MYhHDPHu+F1
 IDApLuM/mlRbuPoXTQjaPjmq9Zj6vTmVSvv7qWwPdPMKtzmc7jQxIqKjgr9ByFVJ9Md5v/oJC0s
 jZvJ50OxqvwbfSCc=
X-Received: by 2002:a1c:e088:: with SMTP id x130mr36489449wmg.14.1593801292900; 
 Fri, 03 Jul 2020 11:34:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/vedspvx6ht+JZNZpNhFcx4oz2WMcuSL9TfxvfvOjgPCfYdSWEeCJLKkljDUL/jYEIOc70Q==
X-Received: by 2002:a1c:e088:: with SMTP id x130mr36489439wmg.14.1593801292713; 
 Fri, 03 Jul 2020 11:34:52 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id s8sm14802514wru.38.2020.07.03.11.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 11:34:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] MAINTAINERS: Cover the firmware JSON schema
Date: Fri,  3 Jul 2020 20:34:50 +0200
Message-Id: <20200703183450.32398-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an entry to cover firmware.json (see commit 3a0adfc9bf:
schema that describes the different uses and properties of
virtual machine firmware).

Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Suggested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Since RFC v1:
- Added Daniel & Kashyap as reviewer
- Added myself as co-maintainer with Laszlo

Based on a comment from Laszlo:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg604925.html
Background info from Kashyap:
https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg01978.html
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dec252f38b..64bcea658d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2601,6 +2601,14 @@ F: include/hw/i2c/smbus_master.h
 F: include/hw/i2c/smbus_slave.h
 F: include/hw/i2c/smbus_eeprom.h
 
+Firmware schema specifications
+M: Laszlo Ersek <lersek@redhat.com>
+M: Philippe Mathieu-Daudé <philmd@redhat.com>
+R: Daniel P. Berrange <berrange@redhat.com>
+R: Kashyap Chamarthy <kchamart@redhat.com>
+S: Maintained
+F: docs/interop/firmware.json
+
 EDK2 Firmware
 M: Laszlo Ersek <lersek@redhat.com>
 M: Philippe Mathieu-Daudé <philmd@redhat.com>
-- 
2.21.3


