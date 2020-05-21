Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3338C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 12:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7475D2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 12:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIo9A4b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7475D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbkcj-0008WK-Ct
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 08:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbka1-0003Sl-9m
 for qemu-devel@nongnu.org; Thu, 21 May 2020 08:45:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39537
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbkZz-00053e-PG
 for qemu-devel@nongnu.org; Thu, 21 May 2020 08:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590065141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0942xGY1fM49lKCT9PFv309B9YWBCGhLlYD3EJvm3Dc=;
 b=jIo9A4b4XCf4hldd1yu6qHVvTcvz3rjEeyGNrzUrBTMehSR9ZU77YpihaEPPB1pYpJe6sr
 pTmlKnu8XdsOgmf7nnbGWjChr8MwO6/8deB/P/fqbsBfcijDxJGo3POpZfzzPzQSKHrsZB
 1TF6rJC3TaLMujQV4h5di9ZjYKoLHOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-j19fswLmOPmXzS320ADxcQ-1; Thu, 21 May 2020 08:45:37 -0400
X-MC-Unique: j19fswLmOPmXzS320ADxcQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 336B1107ACCD;
 Thu, 21 May 2020 12:45:36 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FD5334201;
 Thu, 21 May 2020 12:45:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/8] run-coverity-scan: misc improvements,
 especially for docker mode
Date: Thu, 21 May 2020 08:45:27 -0400
Message-Id: <20200521124535.5329-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

v1->v2: adjust comments, new option --docker-engine

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
 scripts/coverity-scan/run-coverity-scan    | 139 +++++++++++++--------
 tests/docker/Makefile.include              |   2 +-
 tests/docker/docker.py                     |  14 ++-
 4 files changed, 98 insertions(+), 60 deletions(-)

-- 
2.26.2


