Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BE8CA9EBB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:17:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F982084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9xyU6sN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F982084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNczJ-0005Vy-DN
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNcAS-0005XM-Q7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNcAR-0007ET-Hw
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:24:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37071
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNcAR-0007Dz-EJ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571919878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9D1hpj0c7qs8ff7N0x/xdHSzEvF0sYzt8s1G5MLeFX0=;
 b=N9xyU6sNY9jeN/9nuRnqaFa74ZNKh8vFC98n1XZ6RsBmz767z4yNYvF6dB1Nk4o/gLNtBk
 9a6+nQyHs4ImpqhqK5g/xnyNH97SEKfcD2O98t94paISHZ0Ojpk9ql0SC0hGdJgjroT0Wu
 E3h+H5nEE0qreEjpZ5etpYxCH1J+8gI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-NxXC87fCNHSmfzcgf-nUYA-1; Thu, 24 Oct 2019 08:24:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08ABC80183E;
 Thu, 24 Oct 2019 12:24:36 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-184.brq.redhat.com [10.40.204.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B187A60559;
 Thu, 24 Oct 2019 12:24:27 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] mc146818rtc: fix timer interrupt reinjection
Date: Thu, 24 Oct 2019 14:24:22 +0200
Message-Id: <20191024122425.2483-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: NxXC87fCNHSmfzcgf-nUYA-1
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Xiao Guangrong <guangrong.xiao@gmail.com>,
 Vadim Rozenfeld <vrozenfe@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since v2:
split Marcelo's patch in 3 to ease review, no logical change.

v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg651016.html
v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg650803.html

Marcelo Tosatti (1):
  mc146818rtc: fix timer interrupt reinjection

Philippe Mathieu-Daud=C3=A9 (2):
  mc146818rtc: Simplify by reordering if() statement
  mc146818rtc: Tidy up indentation

 hw/timer/mc146818rtc.c | 52 +++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

--=20
2.21.0


