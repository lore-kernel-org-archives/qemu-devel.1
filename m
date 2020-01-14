Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D02C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F9124672
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6zdPIr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F9124672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irKqA-0002eI-KT
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 06:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1irKa2-000752-Jd
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:41:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1irKZy-0003Uh-QR
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:41:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60596
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1irKZy-0003UR-Gy
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579002109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3VZqz3zUF2Y1jQsm5V0KLQ63Ic05gunHzewXnrdXRG4=;
 b=G6zdPIr5N2uY3Njo/3QT2QVz3YKDoyJZ9kMpKkshXRpj5S1O+D4kfmuwgp8up2aTxdL3Hb
 DtSRPGUMPdhgYlUh1tGslh8rTQPqsIcp8J36BN6TmTkBtbQ9NZFJiPKwKw93+6/IWPRA0/
 NCQLNR5QS8i/YDIEYM07c/HTkQ0vF2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-mFPCDuHyNjyvmv79iySHSg-1; Tue, 14 Jan 2020 06:41:47 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAE3618CA242;
 Tue, 14 Jan 2020 11:41:45 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 373CA5DA70;
 Tue, 14 Jan 2020 11:41:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/30] migration/postcopy: set all_zero to true on the first
 target page
Date: Tue, 14 Jan 2020 12:39:14 +0100
Message-Id: <20200114113926.3556-19-quintela@redhat.com>
In-Reply-To: <20200114113926.3556-1-quintela@redhat.com>
References: <20200114113926.3556-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: mFPCDuHyNjyvmv79iySHSg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Richard Henderson <rth@twiddle.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Jason Wang <jasowang@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

For the first target page, all_zero is set to true for this round check.

After target_pages introduced, we could leverage this variable instead
of checking the address offset.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 8ebaea255e..460abfa2c3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4102,7 +4102,7 @@ static int ram_load_postcopy(QEMUFile *f)
             page_buffer =3D postcopy_host_page +
                           ((uintptr_t)host & (block->page_size - 1));
             /* If all TP are zero then we can optimise the place */
-            if (!((uintptr_t)host & (block->page_size - 1))) {
+            if (target_pages =3D=3D 1) {
                 all_zero =3D true;
             } else {
                 /* not the 1st TP within the HP */
--=20
2.24.1


