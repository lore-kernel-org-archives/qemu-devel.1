Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88308C83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:37:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FE62082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuqWranx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FE62082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU1tT-0001Pu-Cj
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 01:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1n6-000569-Os
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1n0-0002f8-HL
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58243
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jU1mz-0002e2-VE
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588224673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QhFDFCVlXf2fynHvudzXt99A5jd5y61ssmROnXO7FA0=;
 b=XuqWranxCJGSg36QfjEY9nr5NNFIl8v70g+ed1qI2/6J44vVjCBIYcVm4PoxbcqQebuy7M
 stn2dsByVDhurZV2q8QUzJ67Tp4O9y1EAduuqV7f3m247hcJEAqWDkCMSrNf6Atdp2edZG
 9z3Rgh4EPfbvE2eOoBGKSjg4zmwISdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-l1WyHnspNV-bAODqC4Xj9A-1; Thu, 30 Apr 2020 01:31:10 -0400
X-MC-Unique: l1WyHnspNV-bAODqC4Xj9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 699E61005510
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 05:31:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3710E5D787;
 Thu, 30 Apr 2020 05:31:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0C88311358CC; Thu, 30 Apr 2020 07:31:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/20] qapi: Clean up visitor's recovery from input with
 invalid type
Date: Thu, 30 Apr 2020 07:30:59 +0200
Message-Id: <20200430053104.32204-16-armbru@redhat.com>
In-Reply-To: <20200430053104.32204-1-armbru@redhat.com>
References: <20200430053104.32204-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Message-Id: <20200424084338.26803-11-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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


