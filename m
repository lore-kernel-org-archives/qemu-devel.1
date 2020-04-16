Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98282C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EFC221F4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z20H8sUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EFC221F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPBJo-0004wf-Ju
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 16:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jPBFh-0008FD-NU
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jPBFg-000487-Ps
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:36:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44903
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jPBFg-00047l-Mp
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587069408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2RHcLfzv/AHZUi5OBodeG6jtQjhpZVEt+eRcfP9lsEw=;
 b=Z20H8sUGQBZuPRqNv/tKe6PR5Qj5rCRxxyxN8Q9HzS4CHsjPaQTgSE0CtBXi2Myvy00niJ
 Ih/4Krfaw4+JeDhoPE/rZ5KESigzZLr/Atq9VNhF6XxiSvU3py1fPB1b+Jb2vpHoVeFN67
 yicGyMcHsmhIibijH37d/c0pvc3nncw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-d8kh3UcoPWaZFPyePOHkqg-1; Thu, 16 Apr 2020 16:36:39 -0400
X-MC-Unique: d8kh3UcoPWaZFPyePOHkqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7124B18C43C1;
 Thu, 16 Apr 2020 20:36:38 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F8DAA099C;
 Thu, 16 Apr 2020 20:36:36 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] device-core: use atomic_set on .realized property
Date: Thu, 16 Apr 2020 23:36:23 +0300
Message-Id: <20200416203624.32366-4-mlevitsk@redhat.com>
In-Reply-To: <20200416203624.32366-1-mlevitsk@redhat.com>
References: <20200416203624.32366-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some code might race with placement of new devices on a bus.
We currently first place a (unrealized) device on the bus
and then realize it.

As a workaround, users that scan the child device list, can
check the realized property to see if it is safe to access such a device.
Use an atomic write here too to aid with this.

A separate discussion is what to do with devices that are unrealized:
It looks like for this case we only call the hotplug handler's unplug
callback and its up to it to unrealize the device.
An atomic operation doesn't cause harm for this code path though.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/core/qdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f0c87e582e..bbb1ae3eb3 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -983,7 +983,7 @@ static void device_set_realized(Object *obj, bool value=
, Error **errp)
     }
=20
     assert(local_err =3D=3D NULL);
-    dev->realized =3D value;
+    atomic_set(&dev->realized, value);
     return;
=20
 child_realize_fail:
--=20
2.17.2


