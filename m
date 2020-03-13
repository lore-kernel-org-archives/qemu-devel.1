Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E23C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54A620749
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dyt/rkDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54A620749
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCfox-0003re-Pv
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 04:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jCfo4-0001x5-P8
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jCfnz-0005yh-Hg
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:36:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47036
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jCfnz-0005wx-CN
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584088590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SEg5ZdW9DSZQ5TnmumlJbc3rTjkhsPwaOrSQ6l3IKdM=;
 b=Dyt/rkDWs22HJEVdpGiWkOql47Q1DrXYBjubQWbChCITIrfmVjwFzcdqwYLBVAzXsopP+z
 /REW8AcxdNcRv5T6+xyO3znkWcWjTyxA9ISzXZMQmAgBHQpWrMPScE++TRTbnwzeW4YYZf
 J/WWWvHNPq4UW66fqRpXtz3+lkJ2uB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-u3oD9dCyMTKo9BaNKXhL1Q-1; Fri, 13 Mar 2020 04:36:26 -0400
X-MC-Unique: u3oD9dCyMTKo9BaNKXhL1Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C44E618A8CA1;
 Fri, 13 Mar 2020 08:36:25 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-85.ams2.redhat.com [10.36.117.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8251597AE0;
 Fri, 13 Mar 2020 08:36:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/3] iotests: Fix intermittent 030 hang
Date: Fri, 13 Mar 2020 09:36:14 +0100
Message-Id: <20200313083617.8326-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter ran into a 030 hang while testing a pull request. This turned out
to be two bugs in the test suite at once: First was the test failing
because a timeout was apparently too short, second was that the timeout
would actually cause the test to hang instead of failing. This series
should fix both.

Kevin Wolf (3):
  iotests.py: Enable faulthandler
  python/qemu: Kill QEMU process if 'quit' doesn't work
  iotests: Increase pause_wait() timeout

 python/qemu/machine.py        | 1 +
 tests/qemu-iotests/iotests.py | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

--=20
2.20.1


