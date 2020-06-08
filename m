Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10734C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF39B2063A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDcUjz9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF39B2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKIv-0003YV-1D
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKCz-00060W-9r
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:01:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28659
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKCu-0007Rh-8q
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=awCHYAXUOGkS+dWmNDQ4SQqbGqK/3LMSf+67fZKCnc0=;
 b=cDcUjz9SDc+O5KcNdlJ5/YMdGHem6EyimH6hybVCRfm2zvEofSNu0aFCKvBmVc1rm2LTe8
 Kq0ycRhwepuGgqsia+xxBnfXb0kBNkm1MdE+dq6i4LUy94m62J5G6+337pw5IJnVEmSGjp
 eet1C3ncp3M7YGCDLsSCcA4dbPVpWaE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-Bdxf2JZeM12eSB7Zm743WA-1; Mon, 08 Jun 2020 12:00:55 -0400
X-MC-Unique: Bdxf2JZeM12eSB7Zm743WA-1
Received: by mail-wr1-f71.google.com with SMTP id a4so7337336wrp.5
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=awCHYAXUOGkS+dWmNDQ4SQqbGqK/3LMSf+67fZKCnc0=;
 b=eq1UxoP1wfp2I7hfb2eKcqc7LN2K4Fc/vZQJNimL25Pe80pDa5d+UxpvVBUbBUoKe0
 iL/6pQFPwGUJcYediwvPGV3xkDKwYJWxfQbSvQ4EYKIkIUy36BMWnZBF1vy6SZQ1tqdN
 RCf/RkcOoVVolz//5kxh+OXwfp/bk4DtFYXIrzOe1t1GZjJJ7GDxH6cDF4bYcbY6NzNh
 m1g1DLL83wqUppXie6Mior+N/dhSiFnoc0DjJ3hJ+dDJg2T6ARy2UCHwyfXHOnmDwpVH
 Irq0YjDiFQvYhU6QUYekNQXvaWK6yH+Q8vYCzp+fmUd/OZBrFyJJI7d2yT0+ymSuI9lH
 tvPQ==
X-Gm-Message-State: AOAM530ILvPAxvVzyALPgpmWARmR9+67t2h9SXZcswEkNqqRcuHJJLTt
 G+rp/i1aBhrcunHDp4qvWRlwRzZAbiMX5TFCwvxDudy9SSUEbiXPZmdUyFUPHw0uAJgQfd6FVCP
 kHZDTeJgVwLPbvtY=
X-Received: by 2002:a1c:a3c5:: with SMTP id m188mr48583wme.152.1591632053830; 
 Mon, 08 Jun 2020 09:00:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziyL5raG4PwAXzO4TG14Cp0iz1q12d2PaRjnoEeXVkhA3kNQMidurFs0yP2smspC0uLUhA1g==
X-Received: by 2002:a1c:a3c5:: with SMTP id m188mr48526wme.152.1591632053569; 
 Mon, 08 Jun 2020 09:00:53 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id w10sm187197wrp.16.2020.06.08.09.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:00:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 01/35] qom/object: Update documentation
Date: Mon,  8 Jun 2020 18:00:10 +0200
Message-Id: <20200608160044.15531-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608160044.15531-1-philmd@redhat.com>
References: <20200608160044.15531-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The documentation was introduced in 2f28d2ff9dc, then
0d09e41a51 and a27bd6c77 moved the headers around.
Update the comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qom/object.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index fd453dc8d6..eb560bf32f 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -45,7 +45,7 @@ typedef struct InterfaceInfo InterfaceInfo;
  * <example>
  *   <title>Creating a minimal type</title>
  *   <programlisting>
- * #include "qdev.h"
+ * #include "hw/qdev-core.h"
  *
  * #define TYPE_MY_DEVICE "my-device"
  *
@@ -146,7 +146,7 @@ typedef struct InterfaceInfo InterfaceInfo;
  * <example>
  *   <title>Overriding a virtual function</title>
  *   <programlisting>
- * #include "qdev.h"
+ * #include "hw/qdev-core.h"
  *
  * void my_device_class_init(ObjectClass *klass, void *class_data)
  * {
@@ -170,7 +170,7 @@ typedef struct InterfaceInfo InterfaceInfo;
  * <example>
  *   <title>Defining an abstract class</title>
  *   <programlisting>
- * #include "qdev.h"
+ * #include "hw/qdev-core.h"
  *
  * typedef struct MyDeviceClass
  * {
-- 
2.21.3


