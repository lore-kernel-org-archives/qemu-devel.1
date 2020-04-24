Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBB9C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:45:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C7920736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdamB3Pb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C7920736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRtxC-0007ET-T4
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 04:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRtw1-0005e8-1Y
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRtw0-00024q-DM
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27662
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRtw0-00024C-0X
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587717823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAV2xhcXlUODkFrnp9hgnflmY8ZxvRVq9YuteVWPylc=;
 b=IdamB3PbNRF3qUMDk8tyRYkkEOT1EA2BLWBFoeoVk+L0i5Hs7blfxVoCE2qPdXGijZhtfc
 ICkhSQVqL1SKJO4S1diCMTLdYbfSgeKb2HmLwl2v/Pv44srliRWHKM2q+erelCP4rMyUwA
 tlP+Ht6/YsAg4EPQjOU3ntwO+7kk48o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-Wv4QlrwVPCqcb7b7vdjvUw-1; Fri, 24 Apr 2020 04:43:41 -0400
X-MC-Unique: Wv4QlrwVPCqcb7b7vdjvUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A44CA461;
 Fri, 24 Apr 2020 08:43:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FE125D70C;
 Fri, 24 Apr 2020 08:43:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D8AC611358BF; Fri, 24 Apr 2020 10:43:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/15] qapi: Fix typo in visit_start_list()'s contract
Date: Fri, 24 Apr 2020 10:43:26 +0200
Message-Id: <20200424084338.26803-4-armbru@redhat.com>
In-Reply-To: <20200424084338.26803-1-armbru@redhat.com>
References: <20200424084338.26803-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:07:34
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/visitor.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 7f63e4c381..c5d0ce9184 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -345,9 +345,9 @@ void visit_end_struct(Visitor *v, void **obj);
  * input visitors set *@list to NULL.
  *
  * After visit_start_list() succeeds, the caller may visit its members
- * one after the other.  A real visit (where @obj is non-NULL) uses
+ * one after the other.  A real visit (where @list is non-NULL) uses
  * visit_next_list() for traversing the linked list, while a virtual
- * visit (where @obj is NULL) uses other means.  For each list
+ * visit (where @list is NULL) uses other means.  For each list
  * element, call the appropriate visit_type_FOO() with name set to
  * NULL and obj set to the address of the value member of the list
  * element.  Finally, visit_end_list() needs to be called with the
--=20
2.21.1


