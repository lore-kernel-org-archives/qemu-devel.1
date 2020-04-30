Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C599BC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926022082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akw9rWkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926022082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU1qE-0002XN-Me
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 01:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1n4-00051K-1a
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1mz-0002dr-EB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24253
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jU1my-0002cC-Ud
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588224670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KHyO4JxugOlImIWj3y5oCeHbCpnx1r0BSz/Koq+fg+E=;
 b=akw9rWkDvEa0SYD7D96XEB6pnUVcvW3IUmFeSxsyrg6J2U3zvVXT5ajj1tLqA9tHU7p3Yr
 fwUKNO4p22+ZGuYYWGLB5UXv2VZ0Oqm6j50l2YL5nbfTe8mMCqGsQikriQ4DppTa6/PJAg
 lYDqdRLNsMp0SnWtIDgrBlJDAy/Cy0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-ZHwrzjcUP2COkfeozdU-LQ-1; Thu, 30 Apr 2020 01:31:09 -0400
X-MC-Unique: ZHwrzjcUP2COkfeozdU-LQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31E61107B271
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 05:31:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF993196AE;
 Thu, 30 Apr 2020 05:31:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ED58311358C5; Thu, 30 Apr 2020 07:31:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/20] qapi: Document @errp usage more thoroughly in visitor.h
Date: Thu, 30 Apr 2020 07:30:53 +0200
Message-Id: <20200430053104.32204-10-armbru@redhat.com>
In-Reply-To: <20200430053104.32204-1-armbru@redhat.com>
References: <20200430053104.32204-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200424084338.26803-5-armbru@redhat.com>
---
 include/qapi/visitor.h | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index c5d0ce9184..09df7099c6 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -284,9 +284,7 @@ void visit_free(Visitor *v);
  * into *@obj.  @obj may also be NULL for a virtual walk, in which
  * case @size is ignored.
  *
- * @errp obeys typical error usage, and reports failures such as a
- * member @name is not present, or present but not an object.  On
- * error, input visitors set *@obj to NULL.
+ * On failure, set *@obj to NULL and store an error through @errp.
  *
  * After visit_start_struct() succeeds, the caller may visit its
  * members one after the other, passing the member's name and address
@@ -303,8 +301,7 @@ void visit_start_struct(Visitor *v, const char *name, v=
oid **obj,
 /*
  * Prepare for completing an object visit.
  *
- * @errp obeys typical error usage, and reports failures such as
- * unparsed keys remaining in the input stream.
+ * On failure, store an error through @errp.
  *
  * Should be called prior to visit_end_struct() if all other
  * intermediate visit steps were successful, to allow the visitor one
@@ -340,9 +337,7 @@ void visit_end_struct(Visitor *v, void **obj);
  * allow @list to be NULL for a virtual walk, in which case @size is
  * ignored.
  *
- * @errp obeys typical error usage, and reports failures such as a
- * member @name is not present, or present but not a list.  On error,
- * input visitors set *@list to NULL.
+ * On failure, set *@list to NULL and store an error through @errp.
  *
  * After visit_start_list() succeeds, the caller may visit its members
  * one after the other.  A real visit (where @list is non-NULL) uses
@@ -376,8 +371,7 @@ GenericList *visit_next_list(Visitor *v, GenericList *t=
ail, size_t size);
 /*
  * Prepare for completing a list visit.
  *
- * @errp obeys typical error usage, and reports failures such as
- * unvisited list tail remaining in the input stream.
+ * On failure, store an error through @errp.
  *
  * Should be called prior to visit_end_list() if all other
  * intermediate visit steps were successful, to allow the visitor one
@@ -409,8 +403,10 @@ void visit_end_list(Visitor *v, void **list);
  *
  * @obj must not be NULL. Input and clone visitors use @size to
  * determine how much memory to allocate into *@obj, then determine
- * the qtype of the next thing to be visited, stored in (*@obj)->type.
- * Other visitors will leave @obj unchanged.
+ * the qtype of the next thing to be visited, and store it in
+ * (*@obj)->type.  Other visitors leave @obj unchanged.
+ *
+ * On failure, set *@obj to NULL and store an error through @errp.
  *
  * If successful, this must be paired with visit_end_alternate() with
  * the same @obj to clean up, even if visiting the contents of the
@@ -463,8 +459,9 @@ bool visit_optional(Visitor *v, const char *name, bool =
*present);
  *
  * Currently, all input visitors parse text input, and all output
  * visitors produce text output.  The mapping between enumeration
- * values and strings is done by the visitor core, using @strings; it
- * should be the ENUM_lookup array from visit-types.h.
+ * values and strings is done by the visitor core, using @lookup.
+ *
+ * On failure, store an error through @errp.
  *
  * May call visit_type_str() under the hood, and the enum visit may
  * fail even if the corresponding string visit succeeded; this implies
@@ -488,6 +485,8 @@ bool visit_is_input(Visitor *v);
  *
  * @obj must be non-NULL.  Input visitors set *@obj to the value;
  * other visitors will leave *@obj unchanged.
+ *
+ * On failure, store an error through @errp.
  */
 void visit_type_int(Visitor *v, const char *name, int64_t *obj, Error **er=
rp);
=20
@@ -564,6 +563,8 @@ void visit_type_size(Visitor *v, const char *name, uint=
64_t *obj,
  *
  * @obj must be non-NULL.  Input visitors set *@obj to the value;
  * other visitors will leave *@obj unchanged.
+ *
+ * On failure, store an error through @errp.
  */
 void visit_type_bool(Visitor *v, const char *name, bool *obj, Error **errp=
);
=20
@@ -581,6 +582,8 @@ void visit_type_bool(Visitor *v, const char *name, bool=
 *obj, Error **errp);
  * It is safe to cast away const when preparing a (const char *) value
  * into @obj for use by an output visitor.
  *
+ * On failure, set *@obj to NULL and store an error through @errp.
+ *
  * FIXME: Callers that try to output NULL *obj should not be allowed.
  */
 void visit_type_str(Visitor *v, const char *name, char **obj, Error **errp=
);
@@ -594,6 +597,8 @@ void visit_type_str(Visitor *v, const char *name, char =
**obj, Error **errp);
  * @obj must be non-NULL.  Input visitors set *@obj to the value;
  * other visitors will leave *@obj unchanged.  Visitors should
  * document if infinity or NaN are not permitted.
+ *
+ * On failure, store an error through @errp.
  */
 void visit_type_number(Visitor *v, const char *name, double *obj,
                        Error **errp);
@@ -608,6 +613,8 @@ void visit_type_number(Visitor *v, const char *name, do=
uble *obj,
  * other visitors will leave *@obj unchanged.  *@obj must be non-NULL
  * for output visitors.
  *
+ * On failure, set *@obj to NULL and store an error through @errp.
+ *
  * Note that some kinds of input can't express arbitrary QObject.
  * E.g. the visitor returned by qobject_input_visitor_new_keyval()
  * can't create numbers or booleans, only strings.
@@ -622,6 +629,8 @@ void visit_type_any(Visitor *v, const char *name, QObje=
ct **obj, Error **errp);
  *
  * @obj must be non-NULL.  Input visitors set *@obj to the value;
  * other visitors ignore *@obj.
+ *
+ * On failure, set *@obj to NULL and store an error through @errp.
  */
 void visit_type_null(Visitor *v, const char *name, QNull **obj,
                      Error **errp);
--=20
2.21.1


