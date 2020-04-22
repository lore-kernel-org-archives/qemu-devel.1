Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF55FC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7813320774
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdO1TvxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7813320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFnM-0005dF-PQ
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRFjm-0000C3-PJ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRFjk-0008F6-9Q
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:48:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36900
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRFjj-0008AE-SC
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587563302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wTkkZ0baNr2PlF+36UnREU+T0co/N68a0grMAwtmAHg=;
 b=VdO1TvxHwANlpOpu+wDaunu2uKVrpLYFUhngkvYSwZ+KxowIXwiFI/Wf6T2GGV76gMOUAv
 wIVzKvwg+YrzXZO32NXXQLbyOElXRIXvp0ELoYkFxqi6K8jSe9ms9K08dRGbJnhHMd20eq
 hmczIlSf6ZkykMrYaZMK8x/gAd4Nzkk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-qS4tS5Z-NLmamLmmeDkMwA-1; Wed, 22 Apr 2020 09:48:18 -0400
X-MC-Unique: qS4tS5Z-NLmamLmmeDkMwA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D58A4DB60;
 Wed, 22 Apr 2020 13:48:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A5F360C87;
 Wed, 22 Apr 2020 13:48:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DAA6E11358BF; Wed, 22 Apr 2020 15:48:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] bamboo,
 sam460ex: Tidy up error message for unsupported RAM size
Date: Wed, 22 Apr 2020 15:48:14 +0200
Message-Id: <20200422134815.1584-4-armbru@redhat.com>
In-Reply-To: <20200422134815.1584-1-armbru@redhat.com>
References: <20200422134815.1584-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Improve

    $ ppc-softmmu/qemu-system-ppc -M sam460ex -m 4096
    qemu-system-ppc: Max 1 banks of 2048 ,1024 ,512 ,256 ,128 ,64 ,32 MB DI=
MM/bank supported
    qemu-system-ppc: Possible valid RAM size: 2048

to

    qemu-system-ppc: at most 1 bank of 2048, 1024, 512, 256, 128, 64, 32 Mi=
B each supported
    Possible valid RAM size: 1024 MiB

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ppc/ppc4xx_devs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index 3376c43ff5..f1651e04d9 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -716,11 +716,11 @@ void ppc4xx_sdram_banks(MemoryRegion *ram, int nr_ban=
ks,
         for (i =3D 0; sdram_bank_sizes[i]; i++) {
             g_string_append_printf(s, "%" PRIi64 "%s",
                                    sdram_bank_sizes[i] / MiB,
-                                   sdram_bank_sizes[i + 1] ? " ," : "");
+                                   sdram_bank_sizes[i + 1] ? ", " : "");
         }
-        error_report("Max %d banks of %s MB DIMM/bank supported",
-            nr_banks, s->str);
-        error_report("Possible valid RAM size: %" PRIi64,
+        error_report("at most %d bank%s of %s MiB each supported",
+                     nr_banks, nr_banks =3D=3D 1 ? "" : "s", s->str);
+        error_printf("Possible valid RAM size: %" PRIi64 " MiB \n",
             used_size ? used_size / MiB : sdram_bank_sizes[i - 1] / MiB);
=20
         g_string_free(s, true);
--=20
2.21.1


