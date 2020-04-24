Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C0C55192
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994AB20767
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2VME+cw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994AB20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRu4J-0002zX-LR
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 04:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRtw3-0005gj-Vj
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRtw2-0002C2-GG
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45107
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRtw1-000276-T7
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587717825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+1AD7bP464ByRBM+IDNKx3lChiOeJt9PaiOdLk6OQ/U=;
 b=T2VME+cwttYX0bEltYjiE3cU1M0kclyTfTHOhXcTsJQaghDUwz76B/dVdY6TA4CGjdAfVH
 Pzv+0a52bBWWRQuROB8/i3sz8fD///35IOVEtH8ZHh2/7Mxe6BGNH4/s+ddufve8FlA3TT
 5HD9023/LCokWHuCHZLB5dvvl0ajGtM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-pIYVoZJUMSOgZlxilznAvA-1; Fri, 24 Apr 2020 04:43:43 -0400
X-MC-Unique: pIYVoZJUMSOgZlxilznAvA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A35B800D24;
 Fri, 24 Apr 2020 08:43:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ECCEB5D9CC;
 Fri, 24 Apr 2020 08:43:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EF53B11358C6; Fri, 24 Apr 2020 10:43:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/15] qapi: Clean up visitor's recovery from input with
 invalid type
Date: Fri, 24 Apr 2020 10:43:33 +0200
Message-Id: <20200424084338.26803-11-armbru@redhat.com>
In-Reply-To: <20200424084338.26803-1-armbru@redhat.com>
References: <20200424084338.26803-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:11:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

An alternate type's visit_type_FOO() fails when it runs into an
invalid ->type.  If it's an input visit, we then need to free the the
object we got from visit_start_alternate().  We do that with
qapi_free_FOO(), which uses the dealloc visitor.

Trouble is that object is in a bad state: its ->type is invalid.  So
the dealloc visitor will run into the same error again, and the error
recovery skips deallocating the alternate's (invalid) alternative.
Works, because qapi_free_FOO() ignores the error.

Avoid it instead: free the messed up object with by g_free().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/visit.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index e3467b770b..678109dfb5 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -234,6 +234,9 @@ void visit_type_%(c_name)s(Visitor *v, const char *name=
, %(c_name)s **obj, Error
     default:
         error_setg(&err, QERR_INVALID_PARAMETER_TYPE, name ? name : "null"=
,
                    "%(name)s");
+        /* Avoid passing invalid *obj to qapi_free_%(c_name)s() */
+        g_free(*obj);
+        *obj =3D NULL;
     }
 out_obj:
     visit_end_alternate(v, (void **)obj);
--=20
2.21.1


