Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D671C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24F8E206EC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHpI4zOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F8E206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jENHL-00008l-AU
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 21:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jENFz-0007Rg-9X
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jENFx-0004Kh-Rt
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:12:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21886)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jENFx-0004Ee-M1
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584493944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fy9j2q+KrPH5uNSb/1a8pMTmwTEFbsOFcLK/7sA2cXA=;
 b=EHpI4zOJ6TyMmbV66ZufrDtSqRSdeAOx5bouD1WsDrWHs00w69yByaw9Av+k0rYEe2YpnI
 aAZGrvPCYk5JXzngTj7MTbPsm1UALmOHq1U/r+WzB6a1KNr27vyimVF1FZv+3SH129CBRO
 YxpU174cMJqarpJN2/q7ouXfhzjtMWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-UCA3MpdaMTK0349kkB-POQ-1; Tue, 17 Mar 2020 21:12:21 -0400
X-MC-Unique: UCA3MpdaMTK0349kkB-POQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A6B38017CC;
 Wed, 18 Mar 2020 01:12:20 +0000 (UTC)
Received: from localhost (ovpn-118-148.rdu2.redhat.com [10.10.118.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7302A5D9E5;
 Wed, 18 Mar 2020 01:12:19 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/4] Python queue for 5.0 soft freeze
Date: Tue, 17 Mar 2020 21:12:13 -0400
Message-Id: <20200318011217.2102748-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d649689a8ecb2e276cc20d3af6d416e3c299cb17=
:=0D
=0D
  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into sta=
ging (2020-03-17 18:33:05 +0000)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/ehabkost/qemu.git tags/python-next-pull-request=0D
=0D
for you to fetch changes up to f4abfc6cb037da951e7977a67171f361fc6d21d7:=0D
=0D
  MAINTAINERS: add simplebench (2020-03-17 21:09:26 -0400)=0D
=0D
----------------------------------------------------------------=0D
Python queue for 5.0 soft freeze=0D
=0D
* Add scripts/simplebench (Vladimir Sementsov-Ogievskiy)=0D
=0D
----------------------------------------------------------------=0D
=0D
Vladimir Sementsov-Ogievskiy (4):=0D
  scripts/simplebench: add simplebench.py=0D
  scripts/simplebench: add qemu/bench_block_job.py=0D
  scripts/simplebench: add example usage of simplebench=0D
  MAINTAINERS: add simplebench=0D
=0D
 MAINTAINERS                            |   5 +=0D
 scripts/simplebench/bench-example.py   |  80 ++++++++++++++++=0D
 scripts/simplebench/bench_block_job.py | 119 +++++++++++++++++++++++=0D
 scripts/simplebench/simplebench.py     | 128 +++++++++++++++++++++++++=0D
 4 files changed, 332 insertions(+)=0D
 create mode 100644 scripts/simplebench/bench-example.py=0D
 create mode 100755 scripts/simplebench/bench_block_job.py=0D
 create mode 100644 scripts/simplebench/simplebench.py=0D
=0D
--=20=0D
2.24.1=0D
=0D


