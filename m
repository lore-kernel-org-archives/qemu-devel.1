Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9772EC2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 15:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DBB72082F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 15:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LP8mi6bC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBB72082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2zfp-00036d-Fd
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 10:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2zf2-00021N-Sr
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 10:47:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2zf1-0001wI-5w
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 10:47:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52003
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2zf1-0001uf-0g
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 10:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581781634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNbWLDpCo/qnGTCuXYHkPdCiNXWDiPn8sUeyQ6zeZVA=;
 b=LP8mi6bCXOIOe/Vo9Q8A+BN805uemSD5Xs/F91g/dCcC9gnzFELuRHMnEZqk4MZZRD0WoQ
 Q2lWf2o6XCLXCNdiFiftKH/KhO6zQTUBgXOn35VjtGsAij4Ne3Q2qOCWL4YxWUsCk9AD0Y
 GJFUQLGcgUd4XbzelbjdVDVkeIWQ6bg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-zQNTX_OuNcGhaS6xL9nZHw-1; Sat, 15 Feb 2020 10:47:12 -0500
Received: by mail-wr1-f71.google.com with SMTP id s13so5859685wru.7
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 07:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bPBmIuXZ1qKaNiUhOTrGrZTnpv3fW77NVQ+xSDe0sYQ=;
 b=psbIZ6SbEu4H2b7KnfXHoB62FqXtuv0l/CuddGi/0pTZPcQiWFVNyccrwUnEvNLsx2
 eXM4yvS+G8vYE3EcHU6eRNUV7JM79mgWln0Dt6VPo3//6f4cfssWUXkzWnUv37fdHHzx
 dhX7HZYHW1uClYDLp9uxChq6SOAqkx7Pw0f5QOl7VblYeBZcuWQxg0F34l6y/YET0XAp
 8ZCaBrW0JhS0MrAaQl+hd7Aoyxe/GePaES6SayyWrEzzhEGSnz+RJysEgRVnokVirFCb
 P+z0B+IIetwVwbW6EkuYdkKgiw6dfI4aavbFzP7ajxzJr9sH3VTk+veFeevpJnM5zVpZ
 y6yA==
X-Gm-Message-State: APjAAAXrfCjRZGyieCXPfq7GJnPSs1l8Uyj5A9SJfgk0wFSSDy72is9/
 1hW14QgHpdYejj60i9zJ+v8ASlRTr6kx6OXZ964yeHOFy15pWSOrW8mPHxNwvPMvTmIeNJ1on2S
 ZgkIFch+O4D4ZUpg=
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr11373841wml.88.1581781630819; 
 Sat, 15 Feb 2020 07:47:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNY6nDnGoV0UOD0WO9OsoonEpBRwvAs7zK6s7tRA9Fxu8UJ2SmNpyLm3CW/shX62IjPDnm/g==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr11373826wml.88.1581781630634; 
 Sat, 15 Feb 2020 07:47:10 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id w26sm11766519wmi.8.2020.02.15.07.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 07:47:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/ipmi/bmc: Delay timer_new_ns() from init to realize to
 avoid memleaks
Date: Sat, 15 Feb 2020 16:47:05 +0100
Message-Id: <20200215154706.19837-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215154706.19837-1-philmd@redhat.com>
References: <20200215154706.19837-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: zQNTX_OuNcGhaS6xL9nZHw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Pan Nengyuan <pannengyuan@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Corey Minyard <minyard@acm.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit f3a508eb4e the Euler Robot reported calling timer_new()
in instance_init() can leak heap memory. The easier fix is to
delay the timer creation at instance realize(). Similarly move
timer_del() into a new instance unrealize() method.

This case was found with the following coccinelle script:

    @ match @
    identifier instance_init;
    typedef Object;
    identifier obj;
    expression val, scale;
    identifier clock_type, callback, opaque;
    position pos;
    @@
    static void instance_init(Object *obj)
    {
      <...
    (
      val =3D timer_new@pos(clock_type, scale, callback, opaque);
    |
      val =3D timer_new_ns@pos(clock_type, callback, opaque);
    |
      val =3D timer_new_us@pos(clock_type, callback, opaque);
    |
      val =3D timer_new_ms@pos(clock_type, callback, opaque);
    )
      ...>
    }

    @ script:python @
    f << match.instance_init;
    p << match.pos;
    @@
    print "check %s:%s:%s in %s()" % (p[0].file, p[0].line, p[0].column, f)

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Pan Nengyuan <pannengyuan@huawei.com>
---
 hw/ipmi/ipmi_bmc_extern.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index f9a13e0a44..9144ac6c38 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -463,6 +463,15 @@ static void ipmi_bmc_extern_realize(DeviceState *dev, =
Error **errp)
=20
     qemu_chr_fe_set_handlers(&ibe->chr, can_receive, receive,
                              chr_event, NULL, ibe, NULL, true);
+
+    ibe->extern_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, extern_timeout,=
 ibe);
+}
+
+static void ipmi_bmc_extern_unrealize(DeviceState *dev, Error **errp)
+{
+    IPMIBmcExtern *ibe =3D IPMI_BMC_EXTERN(dev);
+
+    timer_del(ibe->extern_timer);
 }
=20
 static int ipmi_bmc_extern_post_migrate(void *opaque, int version_id)
@@ -502,7 +511,6 @@ static void ipmi_bmc_extern_init(Object *obj)
 {
     IPMIBmcExtern *ibe =3D IPMI_BMC_EXTERN(obj);
=20
-    ibe->extern_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, extern_timeout,=
 ibe);
     vmstate_register(NULL, 0, &vmstate_ipmi_bmc_extern, ibe);
 }
=20
@@ -510,7 +518,6 @@ static void ipmi_bmc_extern_finalize(Object *obj)
 {
     IPMIBmcExtern *ibe =3D IPMI_BMC_EXTERN(obj);
=20
-    timer_del(ibe->extern_timer);
     timer_free(ibe->extern_timer);
 }
=20
@@ -528,6 +535,7 @@ static void ipmi_bmc_extern_class_init(ObjectClass *oc,=
 void *data)
     bk->handle_reset =3D ipmi_bmc_extern_handle_reset;
     dc->hotpluggable =3D false;
     dc->realize =3D ipmi_bmc_extern_realize;
+    dc->unrealize =3D ipmi_bmc_extern_unrealize;
     device_class_set_props(dc, ipmi_bmc_extern_properties);
 }
=20
--=20
2.21.1


