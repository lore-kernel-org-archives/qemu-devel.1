Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EBEC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83FE02464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQwBr8kl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83FE02464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4ScH-0001Ad-JQ
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:54:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j4S3w-0001wd-6Y
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:19:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j4S3u-0004WD-CH
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:18:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28755
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j4S3t-0004VE-CL
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:18:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582129135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NIbpoTPRIugC/AN/kKqRGy1bAH0u75EO9suDLoHM/2Q=;
 b=DQwBr8kltc01EN9sxSwraxmRIY9rLN9IdZS0h0oWRYwTmTCGDYJNsRheoYhji2DZxslenU
 k7Nfe57TzdRFyztm0hPH/fJhKhuGGOUFFGxk5pAOUtrcFO7pFv/5bqrZnlBmltYq+Szb3k
 WsywBOglY3MKRj/kw5wswgo8S+7v/Hs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-JoMmZ0zCMwWKVlXeSeCHBg-1; Wed, 19 Feb 2020 11:18:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AC858C8333;
 Wed, 19 Feb 2020 16:18:50 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-151.ams2.redhat.com [10.36.116.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB4B689F13;
 Wed, 19 Feb 2020 16:18:48 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 07/13] migrate/ram: Get rid of "place_source" in
 ram_load_postcopy()
Date: Wed, 19 Feb 2020 17:17:19 +0100
Message-Id: <20200219161725.115218-8-david@redhat.com>
In-Reply-To: <20200219161725.115218-1-david@redhat.com>
References: <20200219161725.115218-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: JoMmZ0zCMwWKVlXeSeCHBg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's always the same value.

Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 migration/ram.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index cbd54947fb..75014717f6 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3119,7 +3119,6 @@ static int ram_load_postcopy(QEMUFile *f)
         ram_addr_t addr;
         void *host =3D NULL;
         void *page_buffer =3D NULL;
-        void *place_source =3D NULL;
         RAMBlock *block =3D NULL;
         uint8_t ch;
         int len;
@@ -3188,7 +3187,6 @@ static int ram_load_postcopy(QEMUFile *f)
                 place_needed =3D true;
                 target_pages =3D 0;
             }
-            place_source =3D postcopy_host_page;
         }
=20
         switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
@@ -3220,7 +3218,7 @@ static int ram_load_postcopy(QEMUFile *f)
                  * buffer to make sure the buffer is valid when
                  * placing the page.
                  */
-                qemu_get_buffer_in_place(f, (uint8_t **)&place_source,
+                qemu_get_buffer_in_place(f, (uint8_t **)&postcopy_host_pag=
e,
                                          TARGET_PAGE_SIZE);
             }
             break;
@@ -3265,8 +3263,8 @@ static int ram_load_postcopy(QEMUFile *f)
                 ret =3D postcopy_place_page_zero(mis, place_dest,
                                                block);
             } else {
-                ret =3D postcopy_place_page(mis, place_dest,
-                                          place_source, block);
+                ret =3D postcopy_place_page(mis, place_dest, postcopy_host=
_page,
+                                          block);
             }
         }
     }
--=20
2.24.1


