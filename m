Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2316CC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2903206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzMIx6m+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2903206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE3xT-0005qF-2M
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 00:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jE3wE-000494-PJ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jE3wC-0007Ja-VO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:34:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:20134)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jE3wC-0007E3-KZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584419683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qMBK4htcawoB2Ws4ru90YJZaFm3K5s6FVZTC4kJ6q2M=;
 b=NzMIx6m+D6GWxQ23Vx08bFbgcjBh2GI8LTV0aTf0zDEDFoXi+bEYN5f9I18FGl82/bRlgi
 482wWnhAl7+7/J922Koh7W733zWuDEKMlVAnia6kwFFG28Wb4+NHsV9oGcvfpXA3W5K0NC
 sSi1F1TmEw4aF5NGJwJN9P20lF5qTSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-AC2ssYIxPiWp1fNQtulZ7g-1; Tue, 17 Mar 2020 00:34:39 -0400
X-MC-Unique: AC2ssYIxPiWp1fNQtulZ7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB05B100550E;
 Tue, 17 Mar 2020 04:34:38 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF7485C1B2;
 Tue, 17 Mar 2020 04:34:37 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] iotests: add JobRunner framework
Date: Tue, 17 Mar 2020 00:34:34 -0400
Message-Id: <20200317043437.19464-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Requires: 20200317004105.27059-1-jsnow@redhat.com

(This requires the iotests pylint & logging series.)

The basic idea is to make a generic job runtime manager and allow
callers to subclass the manager. Then, instead of adding callback
arguments to the function all the time, we have =C3=A0 la carte customizati=
on
of the loop.

To showcase this a little bit, I removed the pre_finalization argument
and made existing callers use a custom JobRunner; and then converted
test 040 to use this style of job runner.

Is it a simplification? No. Is it cool? Maybe. Did it remove the
duplicated job-running code in 040? yes.

V3:
 - Rebased on logging series v8
 - Converted 155's new usage of job_run

V2:
 - Rebased on logging series; logging conditionals are pretty now.
 - Inlined callback login in 257
 - No longer based on bitmap-populate job (no test 287)
 - Moved super() call to the beginning of test 040's callback
 - Added docstrings and type annotations

John Snow (3):
  qmp.py: change event_wait to use a dict
  iotests: add JobRunner class
  iotests: modify test 040 to use JobRunner

 python/qemu/machine.py        |  10 +-
 tests/qemu-iotests/040        |  51 +++++----
 tests/qemu-iotests/155        |  15 ++-
 tests/qemu-iotests/255        |   9 +-
 tests/qemu-iotests/257        |  54 +++++----
 tests/qemu-iotests/260        |   5 +-
 tests/qemu-iotests/iotests.py | 201 +++++++++++++++++++++++++---------
 tests/qemu-iotests/pylintrc   |  11 ++
 8 files changed, 246 insertions(+), 110 deletions(-)

--=20
2.21.1


