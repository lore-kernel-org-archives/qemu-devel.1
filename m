Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C34C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 901EF2081E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vv5ZxrZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901EF2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ior88-0006Cw-I1
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ioqq1-0002RP-Lv
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ioqpz-0005BQ-L8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:32:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60136
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ioqpz-0005AS-Gn
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578411126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zOySCS/CoEGjbWjkUQ5KjtS6Qi5YVKt4h2N/MkT1Mxk=;
 b=Vv5ZxrZC6q6zEeRRe9QUiI2PtP+LvGxEIscv26ETVTq4xc7GNOFe+fzvNlrDhPQzTVQ2Ba
 oBQx3XeRLTzvEvCmN9FdyA5jqcG88woD8tF6oiERkZaIxqC9+9fzs6blXPsokqtgX1J2WI
 K/SPC9y/d7i+PKtCBBpyWoE2MWqPqNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-tixj4HT2Od-VbuSZ9mFBFA-1; Tue, 07 Jan 2020 10:32:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF89E8C6E0D;
 Tue,  7 Jan 2020 15:32:00 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-222.brq.redhat.com [10.40.204.222])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FB9C5D9CA;
 Tue,  7 Jan 2020 15:31:56 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] gitlab-ci: Add jobs to build the EDK2 firmware binaries
Date: Tue,  7 Jan 2020 16:31:51 +0100
Message-Id: <20200107153154.21401-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: tixj4HT2Od-VbuSZ9mFBFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We provide the EDK2 firmware binaries in pc-bios/. When we
update the roms/edk2/ submodule, we need to rebuild the
firmware binaries.
To avoid the burden on a single developer, this series add
a GitLab job to generate reproducible EDK2 firmware binaries.

The job is only on specific conditions:
- roms/edk2/ is updated
- or the branch or tag start with 'edk2'
- or 'edk2' appears in last commit description

We won't use ccache to build the EDK2 firmwares, but the patch
was ready/tested so I'm including it.

The proposed procedure to update the EDK2 submodule is:

- add a commit to update roms/edk2/ submodule
- push to gitlab
- download generated artifacts (only available if job succeed)
- unzip the firmware binaries from the artifacts archive
- test the binaries
- add a commit with the binaries, referencing the ci job url.

Example of pipeline that built the edk2-stable201905 firmwares:
https://gitlab.com/philmd/qemu/pipelines/107553178
(the job is https://gitlab.com/philmd/qemu/-/jobs/395823729)

The first patch is already reviewed, but is a prerequisite to
use the Ubuntu docker image to build, so I included it.

Since v1 [*]
- split in 2 jobs: build docker image, build firmwares
  (this way we build the docker image once for all the
   subsequent jobs)
- addressed Laszlo comment (minor the 'git-submodule-update)

Regards,

Phil.

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg668432.html

Philippe Mathieu-Daud=C3=A9 (3):
  roms/edk2-funcs: Force softfloat ARM toolchain prefix on Debian
  gitlab-ci.yml: Add jobs to build EDK2 firmware binaries
  gitlab-ci-edk2.yml: Use ccache

 .gitlab-ci-edk2.yml          | 58 ++++++++++++++++++++++++++++++++++++
 .gitlab-ci.d/edk2/Dockerfile | 30 +++++++++++++++++++
 .gitlab-ci.yml               |  3 ++
 MAINTAINERS                  |  4 ++-
 roms/edk2-funcs.sh           |  3 ++
 5 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 .gitlab-ci-edk2.yml
 create mode 100644 .gitlab-ci.d/edk2/Dockerfile

--=20
2.21.1


