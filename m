Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D3BC33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0390920674
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjkLegOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0390920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUl2-0002JC-Ho
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1itUPv-0006Ln-3V
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:36:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1itUPq-0002hR-CK
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:36:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43742
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1itUPq-0002h6-8z
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579516577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=500ZmFBEwikUlMIqphyR61O1txsRuYhX1wQe8tn04xA=;
 b=SjkLegOGG+b1eNC5oHNox346uIIC/MKbdnb8/gDDitsTITmH+0l9PMvfizwU0ufkdAEeeP
 +2yXVfPqhhAfw30QJTt170SYfIW6CjPfkS3XNeOV1RAxluZaTPFSBrRh4kaRtKUPirRYcb
 zMClRDH2h9sztQ1JFPTnH9iYbbUZPwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-WPNmIy8VN9CGQj8yt4pAJQ-1; Mon, 20 Jan 2020 05:36:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 159D8190B2BF;
 Mon, 20 Jan 2020 10:36:12 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9754F860E6;
 Mon, 20 Jan 2020 10:36:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/29] migration/postcopy: wait for decompress thread in precopy
Date: Mon, 20 Jan 2020 11:33:26 +0100
Message-Id: <20200120103340.25118-16-quintela@redhat.com>
In-Reply-To: <20200120103340.25118-1-quintela@redhat.com>
References: <20200120103340.25118-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: WPNmIy8VN9CGQj8yt4pAJQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: Laurent Vivier <lvivier@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

Compress is not supported with postcopy, it is safe to wait for
decompress thread just in precopy.

This is a preparation for later patch.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index bdb0316892..c13b44b4d9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4421,6 +4421,7 @@ static int ram_load_precopy(QEMUFile *f)
         }
     }
=20
+    ret |=3D wait_for_decompress_done();
     return ret;
 }
=20
@@ -4452,8 +4453,6 @@ static int ram_load(QEMUFile *f, void *opaque, int ve=
rsion_id)
         } else {
             ret =3D ram_load_precopy(f);
         }
-
-        ret |=3D wait_for_decompress_done();
     }
     trace_ram_load_complete(ret, seq_iter);
=20
--=20
2.24.1


