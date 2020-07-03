Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D05C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABBB320760
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwLr6vNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBB320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOdL-0006Mr-T6
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrOL9-0006BR-Mm
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:15:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58474
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrOL7-0003WR-LP
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593792900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=faVuA6XsjUgnJyBwKxSDHRX8cyqJtIw/ArhZE775aWQ=;
 b=JwLr6vNe0jhBn54EJAwgZ34I7Artq9TbElyX1628TZJZ7VSa9f44MXBdWPZX7sFf3B1n5u
 PSOWEJq79Ru23U6lNK3lHHmWiebsji32XYyIedP394+9nQXwhtGlSPO3aCeYemuHbU0fbh
 MWkHNBg8V4Cp35yBIs+k1I3mCJswQMQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-jqg1rYizOwSwVcYv2gP3_A-1; Fri, 03 Jul 2020 12:14:56 -0400
X-MC-Unique: jqg1rYizOwSwVcYv2gP3_A-1
Received: by mail-wm1-f72.google.com with SMTP id 65so15818810wmd.8
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=faVuA6XsjUgnJyBwKxSDHRX8cyqJtIw/ArhZE775aWQ=;
 b=Viu005UmRWLmpoRgdEnFreZNCygcedGWSsDX/AZPL8+smXZ9kQlsHv5QnpV8e8PvL9
 10nOTf3clKPUUA3PmiKbK8PlmwmtE5Tb0MpKy1TJW8tCG8ppgiBpOkXQIvWJA6js0L6p
 jnCH6JOBcqb6tD9Kw39tqsha+RMRQfGm+c6z5K1Te3r4BXbFzD5iUSN7cbVo1RCUCK8n
 6b+4YrE9KxrZqi+dGZRoqN8iKshd+/CzNxmFZh8Oc90Lp1vywsVwZNm8AwP90QcC3h5n
 lZgALzTC+Ap/KlisyoRhwz8nQQvYRoYPKajqFEs9h+Lvd4C7zvZom/kMEhepyINhGqfm
 imvg==
X-Gm-Message-State: AOAM530JT8pd1yC9R+B10ZDkf6r+unVQb4DR/eBQfRZnbMtfqtnaKOYm
 R+phr+1FPE460G33nbS9NExU94jAMG8liOPt8mr3wxFBbu5y/g9FlYboW5lEZp/0PR9/cuSKdYv
 zpd7YQhAPtCHTurg=
X-Received: by 2002:a5d:5151:: with SMTP id u17mr6886865wrt.154.1593792895539; 
 Fri, 03 Jul 2020 09:14:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhuPyC4UVKvR4E+wI2bduxfvSn3/zDBZUvrCJhxl+LE019hAKKbfVm6HkC2wGH76RRCbRBDA==
X-Received: by 2002:a5d:5151:: with SMTP id u17mr6886854wrt.154.1593792895381; 
 Fri, 03 Jul 2020 09:14:55 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id e4sm14178974wrt.97.2020.07.03.09.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:14:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] MAINTAINERS: Cover the firmware JSON schema
Date: Fri,  3 Jul 2020 18:14:53 +0200
Message-Id: <20200703161453.8406-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
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
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an entry to cover firmware.json (see commit 3a0adfc9bf:
schema that describes the different uses and properties of
virtual machine firmware).
Cc the libvirt maintainers if it ever changes.

Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Based on a comment from Laszlo:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg604925.html

I don't think Laszlo should be the sole maintainer, not sure
who else should be listed. Gerd and Kashyap? :)
Can we add it 'maintained' without specific maintainer?
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dec252f38b..57c90201df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2601,6 +2601,12 @@ F: include/hw/i2c/smbus_master.h
 F: include/hw/i2c/smbus_slave.h
 F: include/hw/i2c/smbus_eeprom.h
 
+Firmware schema specifications
+M: Laszlo Ersek <lersek@redhat.com>
+R: libvir-list@redhat.com
+S: Maintained
+F: docs/interop/firmware.json
+
 EDK2 Firmware
 M: Laszlo Ersek <lersek@redhat.com>
 M: Philippe Mathieu-Daudé <philmd@redhat.com>
-- 
2.21.3


