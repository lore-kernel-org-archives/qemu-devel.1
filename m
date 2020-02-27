Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87772C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 00:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B6F24650
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 00:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALyjnabt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B6F24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j76iJ-0006Ag-Hg
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 19:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j76hR-0004h5-Ji
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j76hQ-0005Zo-4X
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:06:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31964
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j76hP-0005Vo-VN
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582762003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cKRORrEf9YcJedMJvzNyay9/w4/IOsHfBlSFQzqp1RA=;
 b=ALyjnabtw7SvZqQ3fIj0DCwVmgaubJ8xVJycAwvq19AXrlPz6RWSo+JiPrh1rTwFXvyLVw
 oGp9D8Mb/7/KIccOnlQK46R+m6FHeBNEQrmSkWKnQ2HtEzJ9jZKuDtrvgTcf27mZaVCfKO
 3ZMoprfqzvXNYvXASrspuTLMYDXa+xc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-9Cr44RvQOwazYx6Mu0ynWg-1; Wed, 26 Feb 2020 19:06:41 -0500
X-MC-Unique: 9Cr44RvQOwazYx6Mu0ynWg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92073477;
 Thu, 27 Feb 2020 00:06:40 +0000 (UTC)
Received: from probe.redhat.com (ovpn-123-58.rdu2.redhat.com [10.10.123.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B27BA390;
 Thu, 27 Feb 2020 00:06:39 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/9] iotests: use python logging
Date: Wed, 26 Feb 2020 19:06:30 -0500
Message-Id: <20200227000639.9644-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series uses python logging to enable output conditionally on
iotests.log(). We unify an initialization call (which also enables
debugging output for those tests with -d) and then make the switch
inside of iotests.

It will help alleviate the need to create logged/unlogged versions
of all the various helpers we have made.

Also, I got lost and accidentally delinted iotests while I was here.
Sorry about that.

V6:
 - It's been so long since V5, let's just look at it anew.
 - Dropped patch 1, rebased, added more delinting.
 - I'm not touching the supported_platforms thing.
   Not interested in rehashing that debate.

V5:
 - Rebased again
 - Allow Python tests to run on any platform

V4:
 - Rebased on top of kwolf/block at the behest of mreitz

V3:
 - Rebased for 4.1+; now based on main branch.

V2:
 - Added all of the other python tests I missed to use script_initialize
 - Refactored the common setup as per Ehabkost's suggestion
 - Added protocol arguments to common initialization,
   but this isn't strictly required.

John Snow (9):
  iotests: do a light delinting
  iotests: add script_initialize
  iotests: replace mutable list default args
  iotest 258: use script_main
  iotests: Mark verify functions as private
  iotests: use python logging for iotests.log()
  iotests: ignore import warnings from pylint
  iotests: don't use 'format' for drive_add
  iotests: add pylintrc file

 tests/qemu-iotests/030        |   4 +-
 tests/qemu-iotests/055        |   3 +-
 tests/qemu-iotests/149        |   3 +-
 tests/qemu-iotests/194        |   4 +-
 tests/qemu-iotests/202        |   4 +-
 tests/qemu-iotests/203        |   4 +-
 tests/qemu-iotests/206        |   2 +-
 tests/qemu-iotests/207        |   6 +-
 tests/qemu-iotests/208        |   2 +-
 tests/qemu-iotests/209        |   2 +-
 tests/qemu-iotests/210        |   6 +-
 tests/qemu-iotests/211        |   6 +-
 tests/qemu-iotests/212        |   6 +-
 tests/qemu-iotests/213        |   6 +-
 tests/qemu-iotests/216        |   4 +-
 tests/qemu-iotests/218        |   2 +-
 tests/qemu-iotests/219        |   2 +-
 tests/qemu-iotests/222        |   7 +-
 tests/qemu-iotests/224        |   4 +-
 tests/qemu-iotests/228        |   6 +-
 tests/qemu-iotests/234        |   4 +-
 tests/qemu-iotests/235        |   4 +-
 tests/qemu-iotests/236        |   2 +-
 tests/qemu-iotests/237        |   2 +-
 tests/qemu-iotests/238        |   2 +
 tests/qemu-iotests/242        |   2 +-
 tests/qemu-iotests/245        |   1 +
 tests/qemu-iotests/245.out    |  24 ++--
 tests/qemu-iotests/246        |   2 +-
 tests/qemu-iotests/248        |   2 +-
 tests/qemu-iotests/254        |   2 +-
 tests/qemu-iotests/255        |   2 +-
 tests/qemu-iotests/256        |   2 +-
 tests/qemu-iotests/258        |  10 +-
 tests/qemu-iotests/260        |   4 +-
 tests/qemu-iotests/262        |   4 +-
 tests/qemu-iotests/264        |   4 +-
 tests/qemu-iotests/277        |   2 +
 tests/qemu-iotests/280        |   8 +-
 tests/qemu-iotests/283        |   4 +-
 tests/qemu-iotests/iotests.py | 244 +++++++++++++++++++---------------
 tests/qemu-iotests/pylintrc   |  20 +++
 42 files changed, 257 insertions(+), 177 deletions(-)
 create mode 100644 tests/qemu-iotests/pylintrc

--=20
2.21.1


