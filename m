Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DA4C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 17:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BB12207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 17:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFcUwCL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB12207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZI83-0005JM-Bc
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 12:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iZI2Y-0002Ku-TQ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 12:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iZI2W-00072S-9Q
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 12:20:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25638
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iZI2W-00071m-0z
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 12:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574702442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ieq20g0g0Mm5ncHKQTFZelg+aG/LUEVA3RUMZMW0J0c=;
 b=GFcUwCL4v7ZnNzNqx4+UHMFvVNSS1R7rYMZk1lypW6FbM+HxdcGz6VEJFvY6q7fsv+48z3
 MnUOzvUplty1EldhAYuOAGEv0BfPtLjHgRmKj/glWHT3IaPLaywmvRS1ioMF4ozKUzk9HN
 5+QJ0pB15imcXDuSfHkMvyRbQocZp4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-oCVZPgHJPS2ySmkk3-uJMQ-1; Mon, 25 Nov 2019 12:20:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E066918557C8;
 Mon, 25 Nov 2019 17:20:37 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3875E19D70;
 Mon, 25 Nov 2019 17:20:32 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] s390x/cpumodel: Introduce dynamic feature group
Date: Mon, 25 Nov 2019 18:20:29 +0100
Message-Id: <20191125172031.16282-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: oCVZPgHJPS2ySmkk3-uJMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Michael Mueller <mimu@linux.ibm.com>, Jiri Denemark <jdenemar@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This thread was previously called:
    s390x/cpumodel: Introduce "best" model variants

There was recently a discussion regarding CPU model versions. That concept
does not fit s390x where we have a lot of feature variability. I
proposed an alternative approach in [1], which might work for x86 as well
(but I am not sure if x86 still can or wants to switch to that), and
requires only little changes in upper layers.

[1] and patch #2 contains more information on the motivation for this. It
allows, for example, to specify/expand "best feature set possible on this
accelerator, hw and, firmware"

"
    Get the best possible feature set (e.g., excluding deprecated features)
    for a CPU definition in the configuration
        -cpu z14,all-features=3Doff,recommended-features=3Don

    Get the maximum possible feature set (e.g., including deprecated
    features) for a CPU definition in the configuration ("everything that
    could be enabled"):
        -cpu z14,all-features=3Doff,available-features=3Don

    Get all valid features for a CPU definition:
        -cpu z14,all-features=3Don
"

v1 -> v2:
- Use dynamic feature groups instead of new models

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg07222.html

Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Jiri Denemark <jdenemar@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Michael Mueller <mimu@linux.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>

David Hildenbrand (2):
  s390x/cpumodel: Factor out CPU feature dependencies
  s390x/cpumodel: Introduce dynamic feature groups

 target/s390x/cpu_features.c |  29 +++++
 target/s390x/cpu_features.h |  14 +++
 target/s390x/cpu_models.c   | 242 +++++++++++++++++++++++++++---------
 3 files changed, 228 insertions(+), 57 deletions(-)

--=20
2.21.0


