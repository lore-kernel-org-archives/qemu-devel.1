Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A05C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A114120736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Li3NSF9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A114120736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRu2n-0000Zp-PC
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 04:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRtw2-0005ek-Pf
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRtw0-00025P-SA
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52226
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRtw0-00024L-Dw
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587717823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=agw2xR3FoLhsUJSn/He3ew7VPz+p34vBOddxjagzng0=;
 b=Li3NSF9Gg+lo2wmlCsQeLvv08Khs3/pcSrXdjJJMVTVnmper11iNRnc69Pkedm7nadLWir
 8d1cyxzZXf67cBsM6yCZr9tKQstaTMtGO/S8sAlsjQimfduWHTchsfPauGbtuNBusczjMM
 b2CV6nR8lzyawdMczD/ZkLiWH7kX8hE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-FOyMccDLOF6fKLNF8HO0oQ-1; Fri, 24 Apr 2020 04:43:41 -0400
X-MC-Unique: FOyMccDLOF6fKLNF8HO0oQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9A0180B70E;
 Fri, 24 Apr 2020 08:43:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CB0B10016DA;
 Fri, 24 Apr 2020 08:43:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D52AD11358BE; Fri, 24 Apr 2020 10:43:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/15] qapi: Fix the virtual walk example in visitor.h's
 big comment
Date: Fri, 24 Apr 2020 10:43:25 +0200
Message-Id: <20200424084338.26803-3-armbru@redhat.com>
In-Reply-To: <20200424084338.26803-1-armbru@redhat.com>
References: <20200424084338.26803-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:57:59
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Call visit_check_list().  Missed in commit a4a1c70dc7 "qapi: Make
input visitors detect unvisited list tails".

Drop an irrelevant error_propagate() while there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/visitor.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index f8a0fc1ea9..7f63e4c381 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -215,6 +215,9 @@
  *      goto outlist;
  *  }
  * outlist:
+ *  if (!err) {
+ *      visit_check_list(v, &err);
+ *  }
  *  visit_end_list(v, NULL);
  *  if (!err) {
  *      visit_check_struct(v, &err);
@@ -222,7 +225,6 @@
  * outobj:
  *  visit_end_struct(v, NULL);
  * out:
- *  error_propagate(errp, err);
  *  visit_free(v);
  * </example>
  */
--=20
2.21.1


