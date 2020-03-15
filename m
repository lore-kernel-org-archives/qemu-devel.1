Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92460C2BB1D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 14:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63AFE206B1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 14:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bW3khyU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AFE206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDUaD-0007PL-Eh
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 10:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jDUXd-0005We-Cf
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jDUXb-00025j-83
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38461
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jDUXb-0001x1-1j
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584283618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rvAyJpM8UMVc6pLEJtcCaEzj3OieyggncMtCsiDiag=;
 b=bW3khyU5fIre47bO933+ImYmhhtzcOARP7UKBPGfH3xoPeatoHiAq4PCkjMhespfXmkuLV
 ozDGM7dkB6AIPY0vOjlNnfHh/rKZFskUYGJfYXrkb463CKgAOcdqzMLVU5K7GbcqykoBNi
 bJo9KxrO8nz8JU9/fjrrt6FrvqKP8Jc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-iPEspqzXNBOmBckAuiRv2A-1; Sun, 15 Mar 2020 10:46:56 -0400
X-MC-Unique: iPEspqzXNBOmBckAuiRv2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F3DF107ACC4;
 Sun, 15 Mar 2020 14:46:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-49.ams2.redhat.com
 [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB9445C1B2;
 Sun, 15 Mar 2020 14:46:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7BAA011366CC; Sun, 15 Mar 2020 15:46:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/34] qapi: Belatedly update doc comment for @wait
 deprecation
Date: Sun, 15 Mar 2020 15:46:21 +0100
Message-Id: <20200315144653.22660-3-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-1-armbru@redhat.com>
References: <20200315144653.22660-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

Commit a9b305ba29 "socket: allow wait=3Dfalse for client socket"
deprecated use of @wait for client socket chardevs, but neglected to
update char.json's doc comment.  Make up for that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/char.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qapi/char.json b/qapi/char.json
index 6907b2bfdb..daceb20f84 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -258,6 +258,7 @@
 # @server: create server socket (default: true)
 # @wait: wait for incoming connection on server
 #        sockets (default: false).
+#        Silently ignored with server: false.  This use is deprecated.
 # @nodelay: set TCP_NODELAY socket option (default: false)
 # @telnet: enable telnet protocol on server
 #          sockets (default: false)
--=20
2.21.1


