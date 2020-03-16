Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2177FC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE64720658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFdAL1yG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE64720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDurd-0004Cq-2v
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDupH-0008JN-J9
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDupG-00039m-Hu
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26215)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDupG-00036p-Cx
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P91BDDFp6WWBIyOarvZn4paQHej1y4/GWozJGZUVwdw=;
 b=TFdAL1yGTD6Fwpdm25/PhRbE92mJmUzDMHabt61H2BCw4zJaQ9sVxJI/bHLzfninL+bxQZ
 ppERyE36hKNj9mHwPM0niFQbKNcwr1jgrUEvHUFPxOOeE0hgHhvTEj7u6GY4C50ft0ex64
 J59chdGy0jxrLVccrUsf7eWZWPBmvW4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-IhDE65Z3NKi7bSRHNKosSA-1; Mon, 16 Mar 2020 14:50:56 -0400
X-MC-Unique: IhDE65Z3NKi7bSRHNKosSA-1
Received: by mail-wm1-f72.google.com with SMTP id m4so6183359wmi.5
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7aNJ2gC8YMKEuodM495PkW/8yrOdqW/HFr1FTk6gVds=;
 b=da97bD37T6D9FVjY7lx0FmfCLokLRB2d5uJNyl7MKTiYlCinxVDrmEdX/Hqf+s9h4B
 8VEKSAGUg/bkU5cj6Gqy1+T/KoesUWnpD/3gzkeN+SDJGZZHdsQac94/vLRJ7N9vA+/F
 T582TxIthzLnrRd6RO/sHVLnekNQ9bSS/a/JI+j70gLz2DAGt/0ou3JXUCvhR6IwCP26
 sJvZwcKUL8rMJknpy3K7npSfB+/xRWoazCFi/xYslJ8NSlSoLlB9HPGqPBbN3usWzW/4
 qbh8agmpzuH4HWiMaK68/Xkrn4pk752MZvESsUpWPsBpyMxOVwN+a5uMzFIeg/Ab+Vux
 81vQ==
X-Gm-Message-State: ANhLgQ3cNkJrmP67FiOcII+++OTkFJ6NvNcMyZ5S1IiI3wXd8j3XzJAk
 8rDzAJdKbHFCsDfQxKCYSD5qb0e4jycOCToJH6vQQlRnLZeEinh1GpdCwc09mkb1guLpoPwJf0y
 yGs94zcLnE0YYTv8=
X-Received: by 2002:a1c:ac46:: with SMTP id v67mr457729wme.153.1584384655075; 
 Mon, 16 Mar 2020 11:50:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt3KUoeRQGbTh7k2X4hX4P4+QinKDcRd7Pux5fkFOe7V+/ik3+7j4YU/RkdsJEZj6ci19AXJA==
X-Received: by 2002:a1c:ac46:: with SMTP id v67mr457718wme.153.1584384654902; 
 Mon, 16 Mar 2020 11:50:54 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id z129sm753554wmb.7.2020.03.16.11.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:50:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 09/25] hw/pci-host: Use memory_region_init_rom() with
 read-only regions
Date: Mon, 16 Mar 2020 19:49:50 +0100
Message-Id: <20200316185006.576-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316185006.576-1-philmd@redhat.com>
References: <20200316185006.576-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: "open list:PReP" <qemu-ppc@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/pci-host/prep.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 1aff72bec6..1a02e9a670 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -325,9 +325,8 @@ static void raven_realize(PCIDevice *d, Error **errp)
     d->config[0x0D] =3D 0x10; // latency_timer
     d->config[0x34] =3D 0x00; // capabilities_pointer
=20
-    memory_region_init_ram_nomigrate(&s->bios, OBJECT(s), "bios", BIOS_SIZ=
E,
-                           &error_fatal);
-    memory_region_set_readonly(&s->bios, true);
+    memory_region_init_rom_nomigrate(&s->bios, OBJECT(s), "bios", BIOS_SIZ=
E,
+                                     &error_fatal);
     memory_region_add_subregion(get_system_memory(), (uint32_t)(-BIOS_SIZE=
),
                                 &s->bios);
     if (s->bios_name) {
--=20
2.21.1


