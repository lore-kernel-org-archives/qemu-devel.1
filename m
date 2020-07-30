Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1ECC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8736C20842
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJd+URVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8736C20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k19MX-0007Gy-Ng
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 10:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k19JV-00028t-47
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:13:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49891
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k19JT-0004LX-DN
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596118418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=J25xb/5oNVlwpz+mVU84R/kso5SDjy+5vsH2DY9aSgI=;
 b=EJd+URVKmGZf7Xqftzjr3hAjniUsk1VDLvqNKdTooK2RG57caQe52PkiEJt+r4RK3nYjBM
 JJ0xEf8ypjI8fqH29uwgjaLa2W4U3+ljFGd4/CLMPYUpHNbPHebyC/sCroCW3ERuHjLV8K
 BL/DCCqDxvm5TunT6W/vydFDPop7x7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173--LnZBZbgMGOUIlCyUx_Ewg-1; Thu, 30 Jul 2020 10:13:35 -0400
X-MC-Unique: -LnZBZbgMGOUIlCyUx_Ewg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82F288017FB;
 Thu, 30 Jul 2020 14:13:34 +0000 (UTC)
Received: from thuth.com (ovpn-112-85.ams2.redhat.com [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDC757BEBD;
 Thu, 30 Jul 2020 14:13:28 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 0/4] Test more in less time in the Gitlab-CI
Date: Thu, 30 Jul 2020 16:13:22 +0200
Message-Id: <20200730141326.8260-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:59:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series adds two new "build-system" pipelines to the Gitlab-CI,
one based on Debian and one on CentOS. We then use these build pipelines
to test the targets that were missing so far (e.g. the two new targets
rx-softmmu and avr-softmmu), and move some of the targets from the other
build-system pipelines here, too, so that the total testing time gets
shorter (at least 5 minutes from what I've seen so far).

Unfortunately, two of the avocado-based acceptance tests that would get
enabled by this are not working on gitlab, so they are disabled in the
second patch. It does not seem to be a caching issue (I've checked it
with the fourth patch), maybe it's something related to ports not being
available in the container, but I did not investigate further. They
can be enabled back later again when someone has some more time for
debugging.

v2:
 - Added Reviewed-bys from v1
 - Added fourth patch to fix the caching issue

Thomas Huth (4):
  tests/docker: Add python3-venv and netcat to the debian-amd64
    container
  tests/acceptance: Disable the rx sash and arm cubieboard replay test
    on Gitlab
  gitlab-ci.yml: Add build-system-debian and build-system-centos jobs
  gitlab-ci: Fix Avocado cache usage

 .gitlab-ci.yml                               | 109 +++++++++++++++----
 tests/acceptance/machine_rx_gdbsim.py        |   4 +
 tests/acceptance/replay_kernel.py            |   1 +
 tests/docker/dockerfiles/debian-amd64.docker |   4 +-
 4 files changed, 98 insertions(+), 20 deletions(-)

-- 
2.18.1


