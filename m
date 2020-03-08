Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D5FC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 13:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD43B20866
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 13:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDYFBWWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD43B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAw45-0007IQ-1l
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 09:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jAw1s-0004uk-BE
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jAw1o-0006hF-QX
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:31:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51863
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jAw1o-0006gR-MI
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583674295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WD83umNxm2ky0VXPPRkxHn9Dl02EzVTi3i3J6pm7IYQ=;
 b=CDYFBWWZ0iQicSG3JlMQ+CdNzF1oDfW2yZ6/LVoE90nR3thX19KtJiW1CLILYClICDWsnC
 9NOq8H9hjdcCdm8Bp6bYUQ4VsXLO5yixsTwZhgtIeqjrN6XhWyKDZrjubstS8LmJ6EMnfN
 C5SFssv1gp9p01XX3D3EXsorDDO9xuk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-DCS703EIMsCvZ4-e6arM1g-1; Sun, 08 Mar 2020 09:31:32 -0400
X-MC-Unique: DCS703EIMsCvZ4-e6arM1g-1
Received: by mail-qt1-f199.google.com with SMTP id f25so4957431qtp.12
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2020 06:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=hDANYJtJJ6fz/Foo93IRg8oS9InICE/RlX6g+g3k1KI=;
 b=NDssei9ZI8dHEpfmcP0mHAOsI+yeOLW0QrO8w8uCipARXf3m6+Isb7xrc2pXncD2oY
 ilQ3nSxpUbD7tUrj4gj9osyG+6uk1sNQJlnMQwNt6oCYpE+vP1aS4E5PXTe28fGi51F3
 Hbg3i7VYuDhbGShZnMOZGLaGoGxriCjO9+czUEL/IlpLJQ8H47har72VwF9h6lEADFvF
 4LQEaGDubilxulUw6eTlk7DRtl54K8CVNojGqOcyN3IF+eGqiKqay2j+jkW4IQq3dD/7
 A2CKTiqs+u67nWrbT3FoAmfOmxDskjVJmabgj2A+jbYIwPOTFzVBDLBq7kkfPc6l0ikI
 MWrw==
X-Gm-Message-State: ANhLgQ0GZj5PERzyl3J4qr2TwEPdpJKkqpqapwVysslfyGpxja1UO8Dt
 iIIVkxKJ62cFFAqPos3nMO9kFOt0WR0xtSB0gsHUzCOnj+j5Um2zGA4KrDq1pk4IIdR+BbBWOcW
 Keam2yQbvWqRhaLg=
X-Received: by 2002:a05:620a:2209:: with SMTP id
 m9mr10778077qkh.71.1583674291392; 
 Sun, 08 Mar 2020 06:31:31 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsp4dv1bezoMHrXC/3zAlA2zYBMlRcCbUtQwyB7yUKScheb3XnsU/3yJQQa5uiJRMhsL7tZZA==
X-Received: by 2002:a05:620a:2209:: with SMTP id
 m9mr10778060qkh.71.1583674291069; 
 Sun, 08 Mar 2020 06:31:31 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id w41sm21001422qtj.49.2020.03.08.06.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 06:31:30 -0700 (PDT)
Date: Sun, 8 Mar 2020 09:31:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] hw/i386/intel_iommu: Simplify vtd_find_as_from_bus_num()
 logic
Message-ID: <20200308133054.1563705-5-mst@redhat.com>
References: <20200308133054.1563705-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200308133054.1563705-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The vtd_find_as_from_bus_num() function was introduced (in commit
dbaabb25f) in a code format that could return an incorrect pointer,
which was later fixed by commit a2e1cd41ccf.
We could have avoided this by writing the if() statement differently.
Do it now, in case this function is re-used. The code is easier to
review (harder to miss bugs).

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200305102702.31512-1-philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6258c58ac9..204b6841ec 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -987,24 +987,26 @@ static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, ui=
nt32_t level)
 static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUState *s, uint8_t bus_nu=
m)
 {
     VTDBus *vtd_bus =3D s->vtd_as_by_bus_num[bus_num];
-    if (!vtd_bus) {
-        /*
-         * Iterate over the registered buses to find the one which
-         * currently hold this bus number, and update the bus_num
-         * lookup table:
-         */
-        GHashTableIter iter;
+    GHashTableIter iter;
=20
-        g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
-        while (g_hash_table_iter_next(&iter, NULL, (void **)&vtd_bus)) {
-            if (pci_bus_num(vtd_bus->bus) =3D=3D bus_num) {
-                s->vtd_as_by_bus_num[bus_num] =3D vtd_bus;
-                return vtd_bus;
-            }
-        }
-        vtd_bus =3D NULL;
+    if (vtd_bus) {
+        return vtd_bus;
     }
-    return vtd_bus;
+
+    /*
+     * Iterate over the registered buses to find the one which
+     * currently holds this bus number and update the bus_num
+     * lookup table.
+     */
+    g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
+    while (g_hash_table_iter_next(&iter, NULL, (void **)&vtd_bus)) {
+        if (pci_bus_num(vtd_bus->bus) =3D=3D bus_num) {
+            s->vtd_as_by_bus_num[bus_num] =3D vtd_bus;
+            return vtd_bus;
+        }
+    }
+
+    return NULL;
 }
=20
 /* Given the @iova, get relevant @slptep. @slpte_level will be the last le=
vel
--=20
MST


