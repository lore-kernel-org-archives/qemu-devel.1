Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91651FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 08:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA31214DA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 08:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckAC1eNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA31214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT02i-00075g-JM
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 03:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iT01n-0006AJ-OZ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iT01m-0007jc-RZ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:53:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24105
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iT01m-0007jO-Ns
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573203238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tRd9WqZNuPYqpDlz44QByoIb1W7rhKVyf9Gs4hVJFnQ=;
 b=ckAC1eNm2L7uVw9gcxVL3TySZKU1pQN7YkXZtu9DG++cqGF9AtKJFdq5uK51nwpxAU52Kj
 00uAQFSgZGzKXEjF4moDXRKhb1zD9vMeqUvFvoIkXDuTcDSVuylZy7z1hgT27mml8vCFtD
 QXWeUqo9/HTXWQS2ZCi7RoVtOhPwdx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-3LN5Ho3QPFCVrPBikq3L2w-1; Fri, 08 Nov 2019 03:53:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C33CF8017DD;
 Fri,  8 Nov 2019 08:53:36 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-227.ams2.redhat.com
 [10.36.116.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87F0E600C9;
 Fri,  8 Nov 2019 08:53:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/2] block: Fix multiple blockdev-snapshot calls
Date: Fri,  8 Nov 2019 09:53:10 +0100
Message-Id: <20191108085312.27049-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 3LN5Ho3QPFCVrPBikq3L2w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf (2):
  block: Remove 'backing': null from bs->{explicit_,}options
  iotests: Test multiple blockdev-snapshot calls

 block.c                    |   2 +
 tests/qemu-iotests/273     |  76 +++++++++
 tests/qemu-iotests/273.out | 337 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 4 files changed, 416 insertions(+)
 create mode 100755 tests/qemu-iotests/273
 create mode 100644 tests/qemu-iotests/273.out

--=20
2.20.1


