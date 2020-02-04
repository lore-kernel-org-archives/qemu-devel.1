Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151FCC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C510F20661
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMKpM3sV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C510F20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyyy8-0008VI-AQ
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iyyvW-00043I-ET
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:11:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iyyvV-0001zJ-7r
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:11:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46456
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iyyvV-0001wG-2t
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580825500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AjyNbxSBpGsTz/kjzywnCOtECablM3ZAABUPyUM8ibY=;
 b=PMKpM3sVczWXyVlRZIErr3R/wa6bEu/C31GigjauaYWcw90oyQmgUSIMviJgJsEd5UUw10
 P4QpwoTbjWOatdNkY3oE/smkAyhxYe95XsrR+aSy4cov+xM1u+W5LyI+1JrWxxDyNtXwMD
 o8JCkqXACBzugmLS9BUAoXP0RkKHi7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-QCVJNYHCPcqEwMEoJ-nPPg-1; Tue, 04 Feb 2020 09:11:25 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E8B380573D
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 14:11:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-4.gru2.redhat.com [10.97.116.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 353137792B;
 Tue,  4 Feb 2020 14:11:14 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] python/qemu: qmp: Fix, delint and improvements
Date: Tue,  4 Feb 2020 11:11:06 -0300
Message-Id: <20200204141111.3207-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: QCVJNYHCPcqEwMEoJ-nPPg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: jsnow@redhat.com, philmd@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I started fixing an issue on exception handling which in some places
currently use the deprecated (in Python 3.3) `socket.error`. Then I
ended up delinting the module code and making some improvements.

Changes in v2:
- Rebased to master. No conflicts.
- Added docstring describing the allowed value of the new `timeout`
  option in accept() (patch 03) [jsnow]
- Set the new `timeout` option to 15.0 by default [philmd]

v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg667479.html

Git:
- Tree: https://github.com/wainersm/qemu
- Branch: python_qmp_sockets_error-v2

CI:
- Travis (FAIL): https://travis-ci.org/wainersm/qemu/builds/645583812
  Jobs failures aren't related with these changes


Wainer dos Santos Moschetta (5):
  python/qemu: qmp: Replace socket.error with OSError
  python/qemu: Delint the qmp module
  python/qemu: qmp: Make accept()'s timeout configurable
  python/qemu: qmp: Make QEMUMonitorProtocol a context manager
  python/qemu: qmp: Remove unnused attributes

 python/qemu/qmp.py | 97 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 71 insertions(+), 26 deletions(-)

--=20
2.23.0


