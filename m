Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04678C83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C13CD2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUpPSurd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13CD2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU1s4-0006qo-TE
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 01:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1n4-00051e-CP
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1mx-0002dC-V1
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32476
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jU1mx-0002cE-Gh
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588224670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XclF4jnst4bkQ32tFN7KlkPQvrWnjYnDPVn9nZDzRBQ=;
 b=eUpPSurdOg3ayDjJTcNcRFe23WZTToy4o/SYywtBpnRQrQNWaV/clyyoq8sbKWZgVh8HBl
 UKkCdrny+Lwtb/y+sO/ifAfPGiVTsSByEpJdqrBYxMIwI4UQygoT+cppRFYiQlbAx8kkTf
 eEU3i82c4qoZTtLdQCeQWYu4xIEVTZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-Z9iEgWh5N3-mpeqZV4DJXA-1; Thu, 30 Apr 2020 01:31:08 -0400
X-MC-Unique: Z9iEgWh5N3-mpeqZV4DJXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 056E1835B41
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 05:31:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA8885D787;
 Thu, 30 Apr 2020 05:31:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EA1D811358C4; Thu, 30 Apr 2020 07:31:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/20] qapi: Fix typo in visit_start_list()'s contract
Date: Thu, 30 Apr 2020 07:30:52 +0200
Message-Id: <20200430053104.32204-9-armbru@redhat.com>
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200424084338.26803-4-armbru@redhat.com>
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


