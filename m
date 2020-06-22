Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D563C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:36:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 265422071A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsP9LCNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265422071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOUj-00028j-F5
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jnORv-0004A2-8s
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:33:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39597
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jnORs-00027h-KW
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592840006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZLYTi1g/Mnv+zI9k7mRjUo2yu8MgpoJho4Uw0zqEOFE=;
 b=YsP9LCNKxAIy4AyxHoqvM51ZLPviNPrNTo81fJxDp0PT1nQxOwvUKsw5vu+ShLGGmFxCis
 dUxZzCm188Bx+1AfwN1tRdK9SIr9aGgOeoe8knTVeqMCKFvvsoz11jELGO3o9a2o9hWcbk
 O7t8x3mdTj9V90VrUpQ1HLqfi/vv74s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-UKDsqUltNj-A_Ur77iH6Qg-1; Mon, 22 Jun 2020 11:33:24 -0400
X-MC-Unique: UKDsqUltNj-A_Ur77iH6Qg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D38CA107ACCD;
 Mon, 22 Jun 2020 15:33:23 +0000 (UTC)
Received: from domokun.gsslab.fab.redhat.com (unknown [10.33.8.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48C1460BEC;
 Mon, 22 Jun 2020 15:33:19 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 0/3] gitlab: build containers to use in build jobs
Date: Mon, 22 Jun 2020 16:33:15 +0100
Message-Id: <20200622153318.751107-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current gitlab CI jobs are quite inefficient because they
use the generic distro images and then apt-get/dnf install
extra packages every time.

The other downside is that the container environment used is
only defined in thte .gitlab-ci.yml file, so it tedious to
reproduce locally.

We already have containers defined in tests/docker for use by
developers building locally. We can use these for CI systems
too if we just had a way to build them....

...GitLab CI offers such a way. We can use docker-in-docker
to build the images at the start of the CI cycle, and use
the built images in later jobs.

These later jobs are now faster because they're not having
to install any software.

There is a performance hit to build the images, however, they
are cached in the GitLab docker registry. A user forking the
repo will use the cache from qemu-project/qemu and their own
local fork. So overall the time penalty to build images will
only be seen if the user modifiers tests/docker/dockerfiles
in their patch series, or if the base image changes.

The GitLab container registry is public, so we're not limited
to using the built images in GitLab CI. Any other CI system
that uses docker can consume these images. Similarly we could
change the tests/docker/Makefile  rules so that developers
pull from https://gitlab.com/qemu-project/qemu, instead of
building images locally. This is why we're building all the
images, instead of just the handful the current jobs want.

The interesting stuff is mostly in patch 2.

Patch 3 is a quick hack I did to convert existing jobs to use
the newly built images. I know there's other work being done
on the GitLab jobs right now that probably conflicts with this
though, so I've not invested much time in patch 3. Consider it
more an illustration of what's possible, than a finished proposal
for merge. The patch 3 diff is fairly unintelligble, so it is
easier to look at the final result:

  https://gitlab.com/berrange/qemu/-/blob/ci-cont/.gitlab-ci.yml

An example pipeline can be viewed here:

  https://gitlab.com/berrange/qemu/-/pipelines/158824359

The cached images are here:

  https://gitlab.com/berrange/qemu/container_registry

Daniel P. Berrangé (3):
  gitlab: introduce explicit "container" and "build" stages
  gitlab: build all container images during CI
  gitlab: convert jobs to use custom built containers

 .gitlab-ci.d/containers.yml | 248 ++++++++++++++++++++++++++++++++++++
 .gitlab-ci.d/edk2.yml       |   3 +-
 .gitlab-ci.d/opensbi.yml    |   3 +-
 .gitlab-ci.yml              | 187 +++++++++++++--------------
 4 files changed, 340 insertions(+), 101 deletions(-)
 create mode 100644 .gitlab-ci.d/containers.yml

-- 
2.24.1


