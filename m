Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3C6C4BA09
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 00:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E661220658
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 00:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlNpwhHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E661220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6kpo-0006KM-0j
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 19:45:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j6koS-0004zB-IM
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 19:44:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j6koQ-0003b4-RM
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 19:44:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34818
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j6koQ-0003Xn-Ah
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 19:44:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582677869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tKjIsZuF/s9kTNpGt2Om7FG4wUmiUeqH03UP+F7TdSY=;
 b=WlNpwhHcAsg66p2lE/R5XrD536UOkFG5JzS0tgy29p7ZCu0cl0LTM6nG24udvjZBLTRoMk
 2/lVx5K3PwHj2oPY0CXUkrIOuoDTmgcwdYwPTMj6BPKNOgsLaRgKUFGckJ8Dr+euNVDDBr
 vu+4JVk6plUNc97TUEljhcD5GXwUaME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-X43h1Z0ePxGNaFOIJ4XcrA-1; Tue, 25 Feb 2020 19:44:27 -0500
X-MC-Unique: X43h1Z0ePxGNaFOIJ4XcrA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83248477;
 Wed, 26 Feb 2020 00:44:26 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-182.bos.redhat.com [10.18.17.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4FA48C076;
 Wed, 26 Feb 2020 00:44:25 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] iotests: complicate run_job with this one weird trick?
Date: Tue, 25 Feb 2020 19:44:23 -0500
Message-Id: <20200226004425.1303-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Requires: 20200225005641.5478-1-jsnow@redhat.com

I'm kidding, but do treat this as an RFC. I doodled a little code
change and wasn't sure if it was appropriate because it's not really a
simplification.

The basic idea is to make a generic job runtime manager and allow
callers to subclass the manager. Then, instead of adding callback
arguments to the function all the time, we have =C3=A0 la carte customizati=
on
of the loop.

To showcase this a little bit, I removed the pre_finalization argument
and made existing callers use a custom JobRunner; and then converted
test 040 to use this style of job runner.

Letmeknowwhatchathink.

John Snow (2):
  iotests: add JobRunner class
  iotests: modify test 040 to use JobRunner

 tests/qemu-iotests/040        |  51 +++++-----
 tests/qemu-iotests/255        |   9 +-
 tests/qemu-iotests/257        |  12 ++-
 tests/qemu-iotests/287        |  19 +++-
 tests/qemu-iotests/iotests.py | 176 ++++++++++++++++++++++++----------
 5 files changed, 183 insertions(+), 84 deletions(-)

--=20
2.21.1


