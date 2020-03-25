Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526D5C54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:46:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2297220771
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuWN6H3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2297220771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH2bp-0006nu-9P
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 05:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jH2aR-0005Xs-42
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jH2aP-0005JS-9I
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:44:34 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52929)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jH2aP-0005Io-4G
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585129472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=J/tUHejTvvdx6XLpLTMK+Iqi7hqEpLx9dR2KQLXWiLc=;
 b=DuWN6H3A8Yt/tQFzMh0KJcexBMIKvP7BvBL52lvM9BTFyIno5H+14bddCz1cXdvgQQYcsq
 jVhCzsdKl1+BjmWbo3/Ojxfbeun45vNicW2OYsW/WQg/YdBOY943+XTnzUsUAl5vpgZ+3n
 iKgtDwDRMcUdGjypRil33ZtFLp436Ik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-hoEmiI37M2qWgL_3BtCZ_g-1; Wed, 25 Mar 2020 05:44:30 -0400
X-MC-Unique: hoEmiI37M2qWgL_3BtCZ_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C340C107ACC4
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 09:44:29 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 91563A0A6F;
 Wed, 25 Mar 2020 09:44:26 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 0/2] fix qemu crash with memory-backend-* prealloc=yes
Date: Wed, 25 Mar 2020 05:44:21 -0400
Message-Id: <20200325094423.24293-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: lvivier@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Igor Mammedov (2):
  hostmem: set default prealloc_threads to valid value
  tests: numa: test one backend with prealloc enabled

 backends/hostmem.c      | 1 +
 tests/qtest/numa-test.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--=20
2.18.1


