Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFAAC433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 11:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7132074D
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 11:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwJ+QaS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7132074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9o1e-0007Rs-Mg
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 07:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k9o0s-00069Z-96
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 07:18:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21247
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k9o0q-0001g2-A3
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 07:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598181490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=J+CRd9oFi5EKkIwhDUt0/Yh52gFZKtXCZu+KKDV7H9s=;
 b=LwJ+QaS9C3xGvdVcgyqAwh5y7T9+vN3QUQKGKIJsL0HfEP7FPYhZhFnzFtG52GRn0EzghZ
 cCcbP1qacY9cuoiueG1Bcl/qcEIK9Kcu69FD8WFL6v1Dzm/jyaQ/j+ILsDLkh6plGxk2z/
 25rPEh8Pf9MmWj9GpcYCqPmFFhYbGEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-o9o4zviAMe2rjlBfKUetVw-1; Sun, 23 Aug 2020 07:18:06 -0400
X-MC-Unique: o9o4zviAMe2rjlBfKUetVw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5240510ABDA2;
 Sun, 23 Aug 2020 11:18:05 +0000 (UTC)
Received: from thuth.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D786D5BAC3;
 Sun, 23 Aug 2020 11:17:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 0/7] Run cross-compilation build tests in the gitlab-CI
Date: Sun, 23 Aug 2020 13:17:50 +0200
Message-Id: <20200823111757.72002-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 07:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, luoyonggang@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we can use all our QEMU build containers in the gitlab-CI,
we can also run the cross-compilation jobs there. Of course, some
problems have to be fixed first, so this is taken care of in the first
four patches.

The following two patches make sure that we can also enable WHPX builds with
our debian-win64-cross container, so that we can compile-test this accelerator
code now, too.

The last patch then finally enables the cross-compilation jobs in the CI.

v2:
 - Dropped patches that are not necessary anymore
 - Added the first two patches to fix problems with the new meson build
   system

Thomas Huth (7):
  configure: Add system = 'linux' for meson when cross-compiling
  tests/docker: Install python3-setuptools in the debian9-mxe containers
  tests/Makefile: test-image-locking needs CONFIG_POSIX
  tests/Makefile: test-replication needs CONFIG_POSIX
  dockerfiles/debian-win64-cross: Download WHPX MinGW headers
  configure: Allow automatic WHPX detection
  gitlab-ci: Add cross-compiling build tests

 .gitlab-ci.d/crossbuilds.yml                  | 113 ++++++++++++++++++
 .gitlab-ci.yml                                |   1 +
 MAINTAINERS                                   |   1 +
 configure                                     |   4 +
 tests/Makefile.include                        |   6 +-
 .../dockerfiles/debian-win64-cross.docker     |   9 +-
 tests/docker/dockerfiles/debian9-mxe.docker   |   2 +-
 7 files changed, 133 insertions(+), 3 deletions(-)
 create mode 100644 .gitlab-ci.d/crossbuilds.yml

-- 
2.18.2


