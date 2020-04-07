Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A0DC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD16920644
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fG/R71QR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD16920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLlex-0008Uo-UA
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 06:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLldy-0006mZ-HD
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLldx-0003nE-D9
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:39:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55572
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLldx-0003mo-99
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586255984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OAlwYExYL7FXMGFqy7dpLDQc3zXe1swji5LOmQIhXXs=;
 b=fG/R71QRKZT1fpvi+1RSO5YubCQHLrO53uvU79cj1RXeJlx+CD5t1bNnIppRGaP/6m8EGH
 0W0v2vhdOiy3kH8KNrYkyz3DtnhbIvAzB+i3th4gsxCV4XBnMfUSGD49ouXQ8k723hQpXr
 +apA+bwBY+yoqAbROMNtxa+gFqw0ZxM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-Uf_4Vm-eO5irLdVcAw8yFQ-1; Tue, 07 Apr 2020 06:39:42 -0400
X-MC-Unique: Uf_4Vm-eO5irLdVcAw8yFQ-1
Received: by mail-ed1-f72.google.com with SMTP id h12so2687382edv.11
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 03:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/e+70mn4POD7XlgEb4CcMUAmHPb35XO4kgSuT4PH7wk=;
 b=IqF1meQlXcm5biSICREVi4l/UgZyjlUPC41eqznaGcEm1ka/xwrkRJ0JBcINc52c6E
 NmFCSImlSGlcu+t8E1Qchz2OlUIt0xb+0Z6HnSZkw3wqTrnkBw/51+eUcO2yASi+h4t2
 JrjUI7yLjzAnpazi2lGI+e7HDkNfssIdLOWXetYSu+5HSysr5yMIFDchRuvMVxYURv3r
 TtbC+YiTIZ7dY5Q2tds6oZ2pTkIOpreq5BpziNPYKVg/h/MzSDq5Kxq2dWTZlUnCJk4Z
 teo/5QI1MGS8P3Jt9/qEZaKSNctwHkKG7jgE4tVvW7m+5Gh/5ApMKcd159H3cghPEjoM
 y6Dg==
X-Gm-Message-State: AGi0PuYSvlhnHQDaqrRsuAxQeCxbb6hqdYkPGtRXMDHDV1MxQcKZeuM2
 WSiiBCH1Yn+s4J/cl0NIKDGQ2Cad/dA6UAyuZf+b3VUD3Ha99OVVqKE58CLBGj7U3nk+3YlvzWE
 r95em58sYJTC//QU=
X-Received: by 2002:a17:906:9a2:: with SMTP id
 q2mr1464971eje.244.1586255980116; 
 Tue, 07 Apr 2020 03:39:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypJR7GsbIEBobu8C8+EBo8QzCo2zAKsNQpT7sVu/t4Hrl4YfbVdImSO3f2Qum5RKrbDXYOsgmg==
X-Received: by 2002:a17:906:9a2:: with SMTP id
 q2mr1464943eje.244.1586255979802; 
 Tue, 07 Apr 2020 03:39:39 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id w20sm3231734ejv.40.2020.04.07.03.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 03:39:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] tests/acceptance/ppc_prep_40p: Use mirror for
 ftp.software.ibm.com
Date: Tue,  7 Apr 2020 12:39:18 +0200
Message-Id: <20200407103920.32558-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200407103920.32558-1-philmd@redhat.com>
References: <20200407103920.32558-1-philmd@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Willian Rampazzo <willianr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To avoid regular failures on Travis-CI with ftp.software.ibm.com,
use a mirror.

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Tested-by: Willian Rampazzo <willianr@gmail.com>
Reviewed-by: Willian Rampazzo <willianr@gmail.com>
Message-Id: <20200403172919.24621-4-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/ppc_prep_40p.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_4=
0p.py
index 138064285a..1515561249 100644
--- a/tests/acceptance/ppc_prep_40p.py
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -30,7 +30,8 @@ def test_factory_firmware_and_netbsd(self):
         :avocado: tags=3Dmachine:40p
         :avocado: tags=3Dslowness:high
         """
-        bios_url =3D ('ftp://ftp.boulder.ibm.com/rs6000/firmware/'
+        bios_url =3D ('http://ftpmirror.your.org/pub/misc/'
+                    'ftp.software.ibm.com/rs6000/firmware/'
                     '7020-40p/P12H0456.IMG')
         bios_hash =3D '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
         bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_hash)
--=20
2.21.1


