Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723FCFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:48:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D9F22459
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwHUDZ+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D9F22459
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT2kE-0001TU-2d
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iT2i4-0000I8-Mi
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:45:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iT2i3-0005OR-NY
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:45:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55216
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iT2i3-0005O1-Jg
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573213547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1SYPrg6aPcrrR0/spfWF0Y4p2ovd8urL0lWobyO7y/4=;
 b=VwHUDZ+/yezqmpt4Q1h09PrzM0QMaRDS43G8HZydSvOAbdS/abUyBDYYQdDVg1vlSususM
 JG+kf/vtnN/NVfsny/3KxcWBbXkbLL8gJWYnZkbUlEqdYgAkAmpaX6tfSwnfExJigQnEwE
 T+nHV/5U0MUloT+Cf3KJ3Kx1eRbfhis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-iPbxAvb6MFWJiwGIw0U7Fw-1; Fri, 08 Nov 2019 06:45:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CF461005500;
 Fri,  8 Nov 2019 11:45:43 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 51B45600D3;
 Fri,  8 Nov 2019 11:45:34 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Laszlo Ersek <lersek@redhat.com>
Subject: [PATCH v2 0/2] configure: Only decompress EDK2 blobs and check for
 bzip2 for X86/ARM
Date: Fri,  8 Nov 2019 12:45:29 +0100
Message-Id: <20191108114531.21518-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: iPbxAvb6MFWJiwGIw0U7Fw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series fixes a bug reported by Thomas: bzip2 is (only) required
to decompress the EDK2 blobs, which target the ARM/X86 archs.

First restrict the blobs decompression to their targets (we don't
need to decompress them when not building X86/ARM).

Then check bzip2 is available.

Philippe Mathieu-Daud=C3=A9 (2):
  configure: Only decompress EDK2 blobs for X86/ARM targets
  configure: Check bzip2 is available

 Makefile  |  2 ++
 configure | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

--=20
2.21.0


