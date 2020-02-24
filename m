Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655DBC38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E545218AC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJiKXsqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E545218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Kg1-0003oj-AJ
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 15:50:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6Keg-0000n2-Ah
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:48:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6Kef-00060T-9W
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:48:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28934
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6Kef-000609-5a
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582577320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aBf1Nz3dO7lmnq6x8HgckUD4/9P7/UEzlUI+mgbV/5Q=;
 b=UJiKXsqYoZH39Vy5amsYnhSHCMJV/gludANRIJ09mbCqgVyo36ppRn7P/6pfg79bCmdw79
 eNjUfKhyyIOoF0yozO5EjDzVSf7Hnzww4O9Co8avW9Zw7YZWzQ8dJyo5TXnUsP4SA7hcFA
 VZ08XcQbH5m/T1tYrG0Kknty01Lg6rw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-E_QdaMtbMTSy5Mf8Nm1AAg-1; Mon, 24 Feb 2020 15:48:35 -0500
X-MC-Unique: E_QdaMtbMTSy5Mf8Nm1AAg-1
Received: by mail-wr1-f72.google.com with SMTP id c6so6133889wrm.18
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 12:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T9F9enB4mqr+YPnaVrLHGBnKs+NXe+icyfAm27ef64A=;
 b=BKYNsZYGPCTxRzw7n1ZqwLReiMbYj3JtCZQZG9VIJ/bSjXFEh4G+JWChVUw4vZmusP
 BI/xHqlDrV0ch0WMevHHz3TSgg5Uc4uQ2MjThhPbG4XipOxgQy2UpEixmdHtGaCU4rBU
 n78quzIut0oGVAnk58kaHR2h9JZPgnAnBg68mfSRLiTSWzglpDbYnvupFL4bMA8gbAls
 ZwekINYGYsgpYEq7ZtvfgAO0Xt8CLBbLrgVEeRNaFhcCC2za2AsHUqZ8/7gM2OY7wGd8
 WMlXYjXKGGr9zV0j1x7iGrp8XEZ2r7hhkv/Cv/CWXWhvDKI3y2RM9Djw23EJPdiq3D0h
 toVQ==
X-Gm-Message-State: APjAAAW8SQoMOGgYzQqPnss2rgMsThqmK5UQkpC90bKik8N+2nnl3otE
 xVUh06DMKIR/XZ13hiBHtL/jxNQy9jSYpwUXO1sa41lUtB7bIpsi3HRXkwLocDIVeuH/RNtfw8A
 Q/kWBOG6wSzdyQf4=
X-Received: by 2002:a7b:c759:: with SMTP id w25mr805780wmk.15.1582577314794;
 Mon, 24 Feb 2020 12:48:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqwxBizVAfehGk3miduLVPYkPJAIfgR+35+r8qEsbPuDdZQRaeyaOJy4zQqQ4Y2N2h4q3ZdVrQ==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr805686wmk.15.1582577313662;
 Mon, 24 Feb 2020 12:48:33 -0800 (PST)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id t81sm863436wmg.6.2020.02.24.12.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 12:48:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 01/32] memory: Correctly return alias region type
Date: Mon, 24 Feb 2020 21:47:57 +0100
Message-Id: <20200224204828.23167-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200224204828.23167-1-philmd@redhat.com>
References: <20200224204828.23167-1-philmd@redhat.com>
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since memory region aliases are neither rom nor ram, they are
described as i/o, which is often incorrect. Return instead the
type of the original region we are aliasing.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: qemu-trivial@nongnu.org

 memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/memory.c b/memory.c
index aeaa8dcc9e..ce1179874e 100644
--- a/memory.c
+++ b/memory.c
@@ -2818,6 +2818,9 @@ void address_space_destroy(AddressSpace *as)
=20
 static const char *memory_region_type(MemoryRegion *mr)
 {
+    if (mr->alias) {
+        return memory_region_type(mr->alias);
+    }
     if (memory_region_is_ram_device(mr)) {
         return "ramd";
     } else if (memory_region_is_romd(mr)) {
--=20
2.21.1


