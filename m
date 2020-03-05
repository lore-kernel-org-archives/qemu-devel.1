Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB77EC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7178E2073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Et00Ea/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7178E2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9njU-0000zY-Bn
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 05:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9nig-0000AR-Gb
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:27:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9nif-0007xx-5r
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:27:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54485
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9nif-0007xF-2e
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583404028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=glnZh63agBY9jTgHy4oFd+qzRVfbjw7LMtpKPPibQwY=;
 b=Et00Ea/glSg9N/7SiSsf1HXMnWMqSrEQPI95S8DF4LlxJwcrxL392Nqos0Wojnw9k+cgID
 9j5Cr1ARkz2PgOl+7d8x1FgEqRydv8P8/zKTqPhOGEaxwrblfcEZpgEYO+ATeYGjHc2Kfx
 rwiUwLG0Q4AuE/WGawM4pcnqfFm5Uks=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-jDxm7FTJPgGNFp3NVrgi6A-1; Thu, 05 Mar 2020 05:27:06 -0500
X-MC-Unique: jDxm7FTJPgGNFp3NVrgi6A-1
Received: by mail-ed1-f71.google.com with SMTP id g26so2714234edj.17
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 02:27:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tlYR1W8zAZXcdKzJjizsFD/7Jmu1H/2LfMgVC3H1d9M=;
 b=stNT+/8uQ5Sr1R7+Lg+Ab+0KY8TVe0U6s06Y67ZOsfEqgvySyTSIpfa2UxR3x0D3pC
 ZEss2FGw2tyDDIXkMrJ5koFqZl1C+vhKQ/C/WgScPsIxa+sfs4s5UoK5v95CkoGaV3wt
 1mDfya/Dd2r1A8ZND4EjwOxqdVQUDjTjErAbqKmz+ACA9XdoiBZaE3BpI5G28zA0wEPZ
 T4DFF81fTUv08VHp3oUxZWQyJGmhhw2QC8MuojeqC+s024wZ9MmqHl3nSyol9P8Z7swl
 pH+fJYlbpWKzrPO1Mr21nL/JCEP2eyv+WutIXNuPoBNLRNNnD+Wsd54O+xbxOI99sflT
 tdlQ==
X-Gm-Message-State: ANhLgQ2PfeNVzRavF0trrZQxKpJYb1k+xDQz11O6obXyVU22u3inVZd4
 U4TyJ+ZyGA+sv2lGMxTXH8ee5+k/us9yY+1EBd5wmqYAvU5fwIKLcIgZMpoOvFJjTYSv8xcjsWb
 56Mo8eASa4CCayzg=
X-Received: by 2002:a05:6402:1481:: with SMTP id
 e1mr7536897edv.219.1583404025261; 
 Thu, 05 Mar 2020 02:27:05 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvCWVROkqixQzTZ5oXhvzzm2LLJyWWOo1alqJISLP5GP2X9Ktr5PVSfzKA+1q45rTlehYcP/g==
X-Received: by 2002:a05:6402:1481:: with SMTP id
 e1mr7536865edv.219.1583404025033; 
 Thu, 05 Mar 2020 02:27:05 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id f25sm1858980edt.73.2020.03.05.02.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 02:27:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4] hw/i386/intel_iommu: Simplify vtd_find_as_from_bus_num()
 logic
Date: Thu,  5 Mar 2020 11:27:02 +0100
Message-Id: <20200305102702.31512-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
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
Cc: Liu Yi L <yi.l.liu@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The vtd_find_as_from_bus_num() function was introduced (in commit
dbaabb25f) in a code format that could return an incorrect pointer,
which was later fixed by commit a2e1cd41ccf.
We could have avoided this by writing the if() statement differently.
Do it now, in case this function is re-used. The code is easier to
review (harder to miss bugs).

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Since v1: Re-worded commit description, patch sent without -w.
Since v2: patch send without diff
Since v3: Fix typo in description and comment (Eric Auger)

This patch is easier to review with 'git-diff -w' (--ignore-all-space)
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
2.21.1


