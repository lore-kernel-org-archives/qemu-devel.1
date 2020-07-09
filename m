Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AA8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 02:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04B32065D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 02:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKe7ZHbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04B32065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtMbP-0006uZ-1W
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 22:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jtMae-0006FP-LG
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 22:47:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53536
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jtMac-00089d-2F
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 22:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594262827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L1mElrFaZr9pzaFgBeT4XKcV0c8nkMrnpmFLh5GMpLE=;
 b=TKe7ZHbxU6x9sx0lrtS51udeLwsqqzYvVM0l8t1SdMLqKiKLlWaaSHQCrh7qp2FP/cu7pn
 MsDYrPaSm2Ab6hCq+0rvhCOAAL8ZlxSjPpdPXzF2wIUTc9qWD93m8LgrVuk6jdCPigczAL
 SPN/XWg227BFq0Zy4GmmojGpihxD2Bk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-7wROBuMeOX6Qdc5ZygsoGQ-1; Wed, 08 Jul 2020 22:47:04 -0400
X-MC-Unique: 7wROBuMeOX6Qdc5ZygsoGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10E9B8015F7;
 Thu,  9 Jul 2020 02:47:03 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-247.rdu2.redhat.com
 [10.10.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED05F60C80;
 Thu,  9 Jul 2020 02:46:58 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 0/2] QEMU Gating CI
Date: Wed,  8 Jul 2020 22:46:55 -0400
Message-Id: <20200709024657.2500558-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The idea about a public facing Gating CI for QEMU was summarized in an=0D
RFC[1].  Since then, it was decided that a simpler version should be=0D
attempted first.=0D
=0D
At this point, there are two specific runners (an aarch64 and an s390)=0D
registered with GitLab, at https://gitlab.com/qemu-project, currently=0D
setup to the "qemu" repository.=0D
=0D
Changes from v1:=0D
=0D
- Added jobs that require specific GitLab runners already available=0D
  (Ubuntu 20.04 on aarch64, and Ubuntu 18.04 on s390x)=0D
- Removed jobs that require specific GitLab runners not yet available=0D
  (Fedora 30, FreeBSD 12.1)=0D
- Updated documentation=0D
- Added copyright and license to new scripts=0D
- Moved script to from "contrib" to "scripts/ci/"=0D
- Moved setup playbooks form "contrib" to "scripts/ci/setup"=0D
- Moved "gating.yml" to ".gitlab-ci.d" directory=0D
- Removed "staging" only branch restriction on jobs defined in=0D
  ".gitlab-ci.yml", assumes that the additional jobs on the staging=0D
  branch running on the freely available gitlab shared runner are=0D
  positive=0D
- Dropped patches 1-3 (already merged)=0D
- Simplified amount of version specifity on Ubuntu, from 18.04.3 to=0D
  simply 18.04 (assumes no diverse minor levels will be used or=0D
  specific runners)=0D
=0D
Changes from the RFC patches[2] accompanying the RFC document:=0D
=0D
- Moved gating job definitions to .gitlab-ci-gating.yml=0D
- Added info on "--disable-libssh" build option requirement=0D
  (https://bugs.launchpad.net/qemu/+bug/1838763) to Ubuntu 18.04 jobs=0D
- Added info on "--disable-glusterfs" build option requirement=0D
  (there's no static version of those libs in distro supplied=0D
  packages) to one=0D
- Dropped ubuntu-18.04.3-x86_64-notools job definition, because it=0D
  doesn't fall into the general scope of gating job described by PMM=0D
  (and it did not run any test)=0D
- Added w32 and w64 cross builds based on Fedora 30=0D
- Added a FreeBSD based job that builds all targets and runs `make=0D
  check`=0D
- Added "-j`nproc`" and "-j`sysctl -n hw.ncpu`" options to make as a=0D
  simple but effective way of speeding up the builds and tests by=0D
  using a number of make jobs matching the number of CPUs=0D
- Because the Ansible playbooks reference the content on Dockerfiles,=0D
  some fixes to some Dockerfiles caught in the process were included=0D
- New patch with script to check or wait on a pipeline execution=0D
=0D
[1] - https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg00231.html=
=0D
[2] - https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg00154.html=
=0D
=0D
Cleber Rosa (2):=0D
  GitLab Gating CI: introduce pipeline-status contrib script=0D
  GitLab Gating CI: initial set of jobs, documentation and scripts=0D
=0D
 .gitlab-ci.d/gating.yml                | 146 +++++++++++++++++=0D
 .gitlab-ci.yml                         |   1 +=0D
 docs/devel/testing.rst                 | 147 +++++++++++++++++=0D
 scripts/ci/gitlab-pipeline-status      | 156 ++++++++++++++++++=0D
 scripts/ci/setup/build-environment.yml | 217 +++++++++++++++++++++++++=0D
 scripts/ci/setup/gitlab-runner.yml     |  72 ++++++++=0D
 scripts/ci/setup/inventory             |   2 +=0D
 scripts/ci/setup/vars.yml              |  13 ++=0D
 8 files changed, 754 insertions(+)=0D
 create mode 100644 .gitlab-ci.d/gating.yml=0D
 create mode 100755 scripts/ci/gitlab-pipeline-status=0D
 create mode 100644 scripts/ci/setup/build-environment.yml=0D
 create mode 100644 scripts/ci/setup/gitlab-runner.yml=0D
 create mode 100644 scripts/ci/setup/inventory=0D
 create mode 100644 scripts/ci/setup/vars.yml=0D
=0D
--=20=0D
2.25.4=0D
=0D


