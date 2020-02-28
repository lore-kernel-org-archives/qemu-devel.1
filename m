Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45CEC3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 340E72084E
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tuyo18zF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340E72084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7eCL-0000SF-4R
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7e88-0001Z5-L2
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7e87-0001YA-CD
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27183
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7e86-0001Xe-5L
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2Kfw5nEVFcSKCWzcOhteR6YpW54ZFAnQQKQBI2MXqg=;
 b=Tuyo18zFbKQAqU6TuN/qAMGMP2b17He54fHcdkzIso9H8s30HAV9fjMJhy2IfyzYEXjz1c
 P0+aUo5rZSHy9d454ih/iRR/DD+nVWKXsNZMjE9QjO+wTLFPstKgWyG+o4aAP4QY2lpaO0
 zM0YJjiQbKkmdCn6TUYcrOX2Qi3laC4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-_Dos33FHPzKrxCrBLO2oAA-1; Fri, 28 Feb 2020 06:48:27 -0500
X-MC-Unique: _Dos33FHPzKrxCrBLO2oAA-1
Received: by mail-wr1-f72.google.com with SMTP id z1so1226120wrs.9
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UifnvwpH88RzXCfeYrjEOymeXNUW1ByC1YLamNivAUM=;
 b=cMy7ck6/YQfpQlXX8T0bwlosi3NDZpJBTMp9ej5Xn/zX6szqSNgH3UTFT5NC4u7GMN
 ljAsENUCwOiMX4RqfpNFRU5GtHEZ7oVdb7YwjLWiUw+r0b2/l7xrVIbM1eXkcS5eC8CD
 jH5YBCykx7kw5l42Re5pn2HI4WNohP83k/L2S9BRzpL4tJ4BxShC+mNT+pf8F5pIEWii
 CBrNcNfdHiIvm62WaMTq3Oy2I8EAdoRpRMQdgVlxGUhlPbdcI+wl0mJV3haK2IanLVCH
 yyayPKXSXSnKuC19Gdd8iUCABmwAJrJ6rIGBcf+HsEIYoFnDB2dIfVcnkZqKJeRd3Nsl
 xGKQ==
X-Gm-Message-State: APjAAAWoU2nkssTPdS4FJ25Vn/ro7tcpgu1/ksVdML41Um4q3nNAcu/c
 +PHVBq0naCuf0Q02cMrwtaVEoq6vHOJX5iTiaGs+k4Krh8vAj5yTAVV7PrLYPQ61VOFi3bzIMDR
 yvOqfIet2N0IcT0k=
X-Received: by 2002:a05:6000:1142:: with SMTP id
 d2mr4433722wrx.62.1582890505822; 
 Fri, 28 Feb 2020 03:48:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqw/YOGrrKpPqdBU/A8oP0QeSk83ur85tLpWBnJ8ZzExIf0wpFgLDVPZSkRhqNA7dkInB/MwmQ==
X-Received: by 2002:a05:6000:1142:: with SMTP id
 d2mr4433710wrx.62.1582890505589; 
 Fri, 28 Feb 2020 03:48:25 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id a7sm1736226wmj.12.2020.02.28.03.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 03:48:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/18] hw/i2c/smbus_ich9: Include "qemu/range.h"
Date: Fri, 28 Feb 2020 12:46:44 +0100
Message-Id: <20200228114649.12818-14-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228114649.12818-1-philmd@redhat.com>
References: <20200228114649.12818-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hw/i2c/smbus_ich9.c calls range_covers_byte(). Include "qemu/range.h"
which declares it.

This fixes (when modifying unrelated headers):

  hw/i2c/smbus_ich9.c:66:9: error: implicit declaration of function 'range_=
covers_byte' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
      if (range_covers_byte(address, len, ICH9_SMB_HOSTC)) {
          ^

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i2c/smbus_ich9.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index fd50fb851a..48f1ff4191 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -21,6 +21,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/range.h"
 #include "hw/i2c/pm_smbus.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
--=20
2.21.1


