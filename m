Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AAFC2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C62932073A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNL/uHBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62932073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2vwf-0000qE-0h
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 06:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2vpR-0004Vw-5L
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2vpQ-0006tK-0B
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57648
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2vpP-0006sw-Qt
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581766903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wtnEPYynrWU+bMWdGCx2jW0GtVOeOZ4Ars9PSwUa4pY=;
 b=bNL/uHBnGsW1mSVThx7owdiUNP/7thIyCVJOIJ5AK2+wC+sLvJ/+30HizQMa4EP6kEwa4M
 EISFRIsJCxfdQGpE8qcjZgZK6smIKGAKAtzr44/Se5aXpDOg+9B1kqrgr4zcVWoO7DxLbZ
 duuRo+ewtllVCn5OJfEqEoR1EpdGVns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-GLrNkpH5M_miRfSHhSEhTw-1; Sat, 15 Feb 2020 06:41:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFDB7107ACC7;
 Sat, 15 Feb 2020 11:41:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B002E60BE1;
 Sat, 15 Feb 2020 11:41:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4870F1136361; Sat, 15 Feb 2020 12:41:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/18] qapi/ui.json: Put input-send-event body text in the
 right place
Date: Sat, 15 Feb 2020 12:41:28 +0100
Message-Id: <20200215114133.15097-14-armbru@redhat.com>
In-Reply-To: <20200215114133.15097-1-armbru@redhat.com>
References: <20200215114133.15097-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: GLrNkpH5M_miRfSHhSEhTw-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

In the doc comment for input-send-event, there is a multi-line
chunk of text ("The @device...take precedence") which is intended
to be the main body text describing the event. However it has
been placed after the arguments and Returns: section, which
means that the parser actually thinks that this text is
part of the "Returns" section text.

Move the body text up to the top so that the parser correctly
classifies it as body.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200213175647.17628-12-peter.maydell@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/ui.json | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index ba873e1e29..e8b8b708c7 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -949,13 +949,6 @@
 #
 # Send input event(s) to guest.
 #
-# @device: display device to send event(s) to.
-# @head: head to send event(s) to, in case the
-#        display device supports multiple scanouts.
-# @events: List of InputEvent union.
-#
-# Returns: Nothing on success.
-#
 # The @device and @head parameters can be used to send the input event
 # to specific input devices in case (a) multiple input devices of the
 # same kind are added to the virtual machine and (b) you have
@@ -967,6 +960,13 @@
 # are admissible, but devices with input routing config take
 # precedence.
 #
+# @device: display device to send event(s) to.
+# @head: head to send event(s) to, in case the
+#        display device supports multiple scanouts.
+# @events: List of InputEvent union.
+#
+# Returns: Nothing on success.
+#
 # Since: 2.6
 #
 # Note: The consoles are visible in the qom tree, under
--=20
2.21.1


