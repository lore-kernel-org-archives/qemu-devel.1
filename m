Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567BBC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2461720658
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhEqAWO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2461720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpSQ-0005NV-Ax
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpKP-000107-7B
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpKO-0006VP-5C
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38535
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpKN-0006UB-UZ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584125195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+odCepFdf+oKmvTAs3N2qnqRhrI1h6ro08GqtUbZKA=;
 b=GhEqAWO0/bLmyJTyTvTzkRUegLbWXATcjLuITsxcg6FFuJioiIGE7dZ5l6NqeAYhFw7Nlj
 xBElYDZrcM4lGDpdZbLecNOePpTfzyiLvpML4gs1n1XC1p5dnS3vAbMpfCXptbW2+9saRE
 ZCscq5a3tbWFZxPGa2RYcXwtayEwDhw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-h-E9eXkCMxa8wf0nJXRL-g-1; Fri, 13 Mar 2020 14:46:33 -0400
X-MC-Unique: h-E9eXkCMxa8wf0nJXRL-g-1
Received: by mail-wr1-f72.google.com with SMTP id v6so4681004wrg.22
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xA3+617D9wmcRIrFdm8JishVoWNzKu8Wd1In0oWHLRo=;
 b=pe1lVg49AqYsDQF0OYHlPkx/naE6OKNC/5AuMrO/2ZhXKYxyiOSQzILNs6S0ftY3J9
 E6WuBFiIKUXUtg2Rf2tG7dq2/fjrH3gSBJUHiajOwxZaZ83J+i0dDaBwyZJDKPGeb1Gu
 /utJpYBmQqqeOThBXTxFqO1IBN5n8sNgfAn02jJKWzkE693+Q1zmAmpqg856eHq3vCKi
 u0gS8373QT4MpcKCSSds6hDXJ0eEFfgXYL6cJd00EqGDZxOLULyPOCmvyjUhwFz1stV0
 JmR+NydArj+b/ZV598CR19w5bm+IA1dvmLJC8zl5Qx/vf8GLaqZvVXM/3G43fY+MZoj+
 CmlA==
X-Gm-Message-State: ANhLgQ3yXJL48++6ljvEWWZ4rabqJphfT6XlWAaNrKIFAj51MI1DPCby
 ZqJ+U8dtpwN2t9Rgbyz/frBB99wAgLpXDhfQcBvEuEVJjZN0vvUEnHIA5ZhYB15s6cOmmC6phnX
 KBOp/Qn6K9/+tEqU=
X-Received: by 2002:adf:e3cc:: with SMTP id k12mr15163718wrm.266.1584125192673; 
 Fri, 13 Mar 2020 11:46:32 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv7Z0lzfYlF1vs1Lz7g7NclFsuaD+xFkjgyU5AXEQD3hHaG5QK7fUjcVcTEvxd0G3p+sZw/Zg==
X-Received: by 2002:adf:e3cc:: with SMTP id k12mr15163698wrm.266.1584125192517; 
 Fri, 13 Mar 2020 11:46:32 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id u8sm34255802wrn.69.2020.03.13.11.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:46:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/9] hw/core/qdev-properties: Export qdev_prop_enum
Date: Fri, 13 Mar 2020 19:46:03 +0100
Message-Id: <20200313184607.11792-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313184607.11792-1-philmd@redhat.com>
References: <20200313184607.11792-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/qdev-properties.h | 1 +
 hw/core/qdev-properties.c    | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index f161604fb6..134753d595 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -8,6 +8,7 @@
 extern const PropertyInfo qdev_prop_bit;
 extern const PropertyInfo qdev_prop_bit64;
 extern const PropertyInfo qdev_prop_bool;
+extern const PropertyInfo qdev_prop_enum;
 extern const PropertyInfo qdev_prop_uint8;
 extern const PropertyInfo qdev_prop_uint16;
 extern const PropertyInfo qdev_prop_uint32;
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 9c383ffa44..5912c394d4 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -84,6 +84,13 @@ void qdev_propinfo_set_default_value_enum(ObjectProperty=
 *op,
         qapi_enum_lookup(prop->info->enum_table, prop->defval.i));
 }
=20
+const PropertyInfo qdev_prop_enum =3D {
+    .name  =3D "enum",
+    .get   =3D qdev_propinfo_get_enum,
+    .set   =3D qdev_propinfo_set_enum,
+    .set_default_value =3D qdev_propinfo_set_default_value_enum,
+};
+
 /* Bit */
=20
 static uint32_t qdev_get_prop_mask(Property *prop)
--=20
2.21.1


