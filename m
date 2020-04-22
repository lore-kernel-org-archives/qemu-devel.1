Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC91C5518B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69CB020776
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUustaVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69CB020776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJAY-0004tK-Dm
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRJ6U-0006yu-Dc
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRJ6Q-0004Mn-5e
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46966
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jRJ6P-0004HU-OA
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587576237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xlNrq2Tb8WbiWsAlU80j8YtQWYybFIPf9j0sLO+2Ess=;
 b=DUustaVLhbx5o81AMLhmbzDgY2cDEQ8cqlkhqPi+jhfDKvAWiUquGsqfOPqN7C6fHSqqWf
 HEZsySC+wTwQfS9ED93oRvxdbw93/z4FXqOCPi9cksRoLsfk7aImpUjYqdwCzh1MxgBTXA
 hKNtHnHCxzm+alHgnHCcKFuzoY+Oksk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-LkXPM9_1ORiJaqLGuQNDaQ-1; Wed, 22 Apr 2020 13:23:54 -0400
X-MC-Unique: LkXPM9_1ORiJaqLGuQNDaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E86A41005510;
 Wed, 22 Apr 2020 17:23:52 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D2B86084B;
 Wed, 22 Apr 2020 17:23:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/8] run-coverity-scan: misc improvements,
 especially for docker mode
Date: Wed, 22 Apr 2020 13:23:43 -0400
Message-Id: <20200422172351.26583-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 09:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These include:

1) podman support through tests/docker/docker.py

2) avoiding repeated downloading of the tools in the container, by
   sharing the cache with the host

3) support for --update-tools-only --docker (though unlike regular
   --update-tools-only it must be run from within a QEMU source tree)

4) not related to docker mode, but used by it, a new --no-update-tools
   option that does not check for tool updates

5) the ability to get the Coverity token from git configuration, and
   also to have email from git configuration if it is not equal to
   user.email.

Patches 1 and 2 are tweaks to tests/docker/docker.py, while the others
are for run-coverity-scan.

Paolo Bonzini (8):
  docker.py/build: support -t and -f arguments
  docker.py/build: support binary files in --extra-files
  run-coverity-scan: get Coverity token and email from special git
    config section
  run-coverity-scan: use docker.py
  run-coverity-scan: add --no-update-tools option
  run-coverity-scan: use --no-update-tools in docker run
  run-coverity-scan: download tools outside the container
  run-coverity-scan: support --update-tools-only --docker

 scripts/coverity-scan/coverity-scan.docker |   3 +-
 scripts/coverity-scan/run-coverity-scan    | 126 +++++++++++++--------
 tests/docker/Makefile.include              |   2 +-
 tests/docker/docker.py                     |  14 ++-
 4 files changed, 88 insertions(+), 57 deletions(-)

--=20
2.18.2


