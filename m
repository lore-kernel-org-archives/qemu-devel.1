Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6615BC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394B820727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394B820727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgZu-0003y1-DL
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jBgKj-0004fQ-Fj
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jBgKi-0001QE-7u
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:58:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56878)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jBgKi-0001NU-1n
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:58:12 -0400
Received: from 2.general.paelzer.uk.vpn ([10.172.196.173]
 helo=localhost.localdomain) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jBgKg-0004kR-IN; Tue, 10 Mar 2020 14:58:10 +0000
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/1] avoid failing to load modules after upgrades
Date: Tue, 10 Mar 2020 15:58:05 +0100
Message-Id: <20200310145806.18335-1-christian.ehrhardt@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 91.189.89.112
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 pkg-qemu-devel@lists.alioth.debian.org, Cole Robinson <crobinso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Miroslav Rezanina <mrezanin@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,
this is a continuation of a discussion at KVM Forum eventually
becoming [1] and the v1 of the patch [2].

Overall it is about qemu providing some way for distribution
packaging to allow loading shared objects for a qemu binary
that was upgraded.

I also refreshed the qemu test build for Ubuntu [3] and have started a
libvirt change [4] to allow to read from there through apparmor protection.
Upstreaming of that will follow once we agree and merge the qemu change.

Updates since v1:
- make the feature configurable and default off

[1]: https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg00005.html
[2]: https://lists.nongnu.org/archive/html/qemu-devel/2020-03/msg01593.html
[3]: https://launchpad.net/~ci-train-ppa-service/+archive/ubuntu/3961
[4]: https://code.launchpad.net/~paelzer/ubuntu/+source/libvirt/+git/libvirt/+merge/380469

Christian Ehrhardt (1):
  modules: load modules from versioned /var/run dir

 configure     | 15 +++++++++++++++
 util/module.c | 14 ++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.25.1


