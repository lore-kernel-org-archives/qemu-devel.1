Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E1BC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10CB1218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bq+SfwCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CB1218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT4bu-0006xH-P3
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 10:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kT4Zw-0004Aq-3a
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 10:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kT4Zt-0001f9-9w
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 10:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602773400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MWc7pWfmblvm467j8OMzEbe1UriWLZQrcu04cFL2GAw=;
 b=bq+SfwCaXU1yGMJqrtU5kj1K9+jDQP9g8O1RvEaYGCNRrcmAUB0hiOhisu0pyyD6F6pkeF
 ZnpV575VmrHRt+xuPMukT/JciqatBZpA3eB/qnR3El4XSNG4oJrMv5vZEs9Zxv+AQJPK/E
 eN/gM+hHSXFC/W0I033EdRrwf6okUoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-IuCnYd_2NnGXCQXXgV2bWA-1; Thu, 15 Oct 2020 10:49:58 -0400
X-MC-Unique: IuCnYd_2NnGXCQXXgV2bWA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53B54803659;
 Thu, 15 Oct 2020 14:49:57 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D23F76E70C;
 Thu, 15 Oct 2020 14:49:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/10] Block layer patches
Date: Thu, 15 Oct 2020 16:49:42 +0200
Message-Id: <20201015144952.388043-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 57c98ea9acdcef5021f5671efa6475a5794a51c4:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20201014-pull-request' into staging (2020-10-14 13:56:06 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to e1c4269763999e3b359fff19ad170e0110d3b457:

  block: deprecate the sheepdog block driver (2020-10-15 16:06:28 +0200)

----------------------------------------------------------------
Block layer patches:

- qemu-storage-daemon: Remove QemuOpts from --object parser
- monitor: Fix order in monitor_cleanup()
- Deprecate the sheepdog block driver

----------------------------------------------------------------
Daniel P. Berrangé (2):
      block: drop moderated sheepdog mailing list from MAINTAINERS file
      block: deprecate the sheepdog block driver

Kevin Wolf (5):
      keyval: Parse help options
      qom: Factor out helpers from user_creatable_print_help()
      qom: Add user_creatable_print_help_from_qdict()
      qemu-storage-daemon: Remove QemuOpts from --object parser
      monitor: Fix order in monitor_cleanup()

Markus Armbruster (3):
      keyval: Fix and clarify grammar
      test-keyval: Demonstrate misparse of ',' with implied key
      keyval: Fix parsing of ',' in value of implied key

 docs/system/deprecated.rst           |   9 ++
 configure                            |   5 +-
 include/qemu/help_option.h           |  11 +++
 include/qemu/option.h                |   2 +-
 include/qom/object_interfaces.h      |  21 +++-
 block/sheepdog.c                     |  14 +++
 monitor/monitor.c                    |  33 ++++---
 qapi/qobject-input-visitor.c         |   2 +-
 qom/object_interfaces.c              |  99 ++++++++++++-------
 storage-daemon/qemu-storage-daemon.c |  15 +--
 tests/test-keyval.c                  | 186 +++++++++++++++++++++++------------
 util/keyval.c                        | 103 ++++++++++++++-----
 MAINTAINERS                          |   1 -
 13 files changed, 339 insertions(+), 162 deletions(-)


