Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D62C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:45:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BFAE20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBNubsWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFAE20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtoF-0000cS-LJ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jDsGm-0004FF-4L
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jDsGl-0000cE-5i
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:54319)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jDsGk-0000a3-Tv
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=58r+wK0UXkNczSKOSXdpBoyDfrF05c/l8DDZ3fKjikg=;
 b=QBNubsWJeC6rk08fStMXYV91+FlE7KAhESToNx3uPNMA6wjuZz+cyIKWezm5MYLNuaz4E6
 PGx1qMYT6W/K+t6xlecboxakUOMZrxL5xgf5grGHUDz9ddiOB0LMGO4ceqc7c2KmmeIFwz
 gjIIxOUXovcNPfxwyIqPvh8TAPkV59U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-LRzYSThkMjqzfFOetOFdjg-1; Mon, 16 Mar 2020 12:07:08 -0400
X-MC-Unique: LRzYSThkMjqzfFOetOFdjg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEB351932D9F;
 Mon, 16 Mar 2020 16:07:06 +0000 (UTC)
Received: from localhost (ovpn-117-61.ams2.redhat.com [10.36.117.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83A9F10016EB;
 Mon, 16 Mar 2020 16:07:03 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] gcc 9.2 strncpy(3) warnings fixes
Date: Mon, 16 Mar 2020 16:07:00 +0000
Message-Id: <20200316160702.478964-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SSBoaXQgdHdvIHN0cm5jcHkoMykgY29tcGlsZXIgd2FybmluZ3Mgd2l0aCBnY2MgOS4yIGFuZCBz
YW5pdGl6ZXJzIGVuYWJsZWQKcmVjZW50bHkuICBVc2UgUUVNVSdzIHBzdHJjcHkoKSBmdW5jdGlv
biBpbnN0ZWFkIC0gaXQgYWx3YXlzIE5VTC10ZXJtaW5hdGVzIGFuZAp0aGVyZWZvcmUgZWxpbWlu
YXRlcyB0aGUgY29uY2VybnMgYmVoaW5kIHRoaXMgY29tcGlsZXIgd2FybmluZy4KClN0ZWZhbiBI
YWpub2N6aSAoMik6CiAgbWlncmF0aW9uOiBhdm9pZCBzdXNwaWNpb3VzIHN0cm5jcHkoKSB1c2UK
ICBody9yZG1hOiBhdm9pZCBzdXNwaWNpb3VzIHN0cm5jcHkoKSB1c2UKCiBody9yZG1hL3Ztdy9w
dnJkbWFfZGV2X3JpbmcuYyB8IDQgKystLQogbWlncmF0aW9uL2dsb2JhbF9zdGF0ZS5jICAgICAg
fCA0ICsrLS0KIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQoKLS0gCjIuMjQuMQoK


