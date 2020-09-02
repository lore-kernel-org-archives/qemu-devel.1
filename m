Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337C9C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53D320709
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/3PqoKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53D320709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWHG-0007LI-V5
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDWGE-0005cx-8n
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:09:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDWGA-0001FQ-9t
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599066561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=n5vz9EqajcMJj3rg9FNOQjJod3B6pJREb634LTeTOPE=;
 b=B/3PqoKNowk7ObJa/eZqfMQt+wFj5M/0zyt9ElwwLu8w2vVOvt5rfA4zSR+eHj4pu9Ac0r
 hU5UzhaN9hAVLMgKBFyfT16MF9RTUVZbylT1xesD2lA1rDWOm2EsQJouZnC0yCDyagA51z
 XOu0u7IOZr6+EMFC1cfVh1Qqf3kHn+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-mfwgjSfoMyq76pRbstBJRQ-1; Wed, 02 Sep 2020 13:09:18 -0400
X-MC-Unique: mfwgjSfoMyq76pRbstBJRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 826A680EF84;
 Wed,  2 Sep 2020 17:09:17 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D40D819C59;
 Wed,  2 Sep 2020 17:09:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/8] block: improve error reporting for unsupported O_DIRECT
Date: Wed,  2 Sep 2020 18:09:05 +0100
Message-Id: <20200902170913.1785194-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 01:13:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v1: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg00269.html=0D
v2: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg00589.html=0D
v3: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg07098.html=0D
v4: https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg05334.html=0D
=0D
See patch commit messages for rationale=0D
=0D
Ideally we would convert other callers of qemu_open to use=0D
qemu_open_err, and eventually remove qemu_open, renaming=0D
qemu_open_err back to qemu_open.  Given soft freeze is just=0D
days away though, I'm hoping this series is simple enough=0D
to get into this release, leaving bigger cleanup for later.=0D
=0D
Improved in v5:=0D
=0D
 - Drop reporting of flags in failed open call=0D
 - Split O_CLOEXEC handling off into separate helper=0D
 - Refactor monitor FD set APIs to simplify their use=0D
=0D
Improved in v4:=0D
=0D
 - Use assert() for programmer mistakes=0D
 - Split second patch into three distinct parts=0D
 - Misc typos=0D
 - Improve commit message=0D
=0D
Improved in v3:=0D
=0D
 - Re-arrange the patches series, so that the conversion to Error=0D
   takes place first, then the improve O_DIRECT reporting=0D
 - Rename existing method to qemu_open_old=0D
 - Use a pair of new methods qemu_open + qemu_create to improve=0D
   arg checking=0D
=0D
Improved in v2:=0D
=0D
 - Mention that qemu_open_err is preferred over qemu_open=0D
 - Get rid of obsolete error_report call=0D
 - Simplify O_DIRECT handling=0D
 - Fixup iotests for changed error message text=0D
=0D
Daniel P. Berrang=C3=A9 (8):=0D
  monitor: simplify functions for getting a dup'd fdset entry=0D
  util: split off a helper for dealing with O_CLOEXEC flag=0D
  util: rename qemu_open() to qemu_open_old()=0D
  util: refactor qemu_open_old to split off variadic args handling=0D
  util: add Error object for qemu_open_internal error reporting=0D
  util: introduce qemu_open and qemu_create with error reporting=0D
  util: give a specific error message when O_DIRECT doesn't work=0D
  block/file: switch to use qemu_open/qemu_create for improved errors=0D
=0D
 accel/kvm/kvm-all.c            |   2 +-=0D
 backends/rng-random.c          |   2 +-=0D
 backends/tpm/tpm_passthrough.c |   8 +--=0D
 block/file-posix.c             |  16 ++---=0D
 block/file-win32.c             |   5 +-=0D
 block/vvfat.c                  |   5 +-=0D
 chardev/char-fd.c              |   2 +-=0D
 chardev/char-pipe.c            |   6 +-=0D
 chardev/char.c                 |   2 +-=0D
 dump/dump.c                    |   2 +-=0D
 hw/s390x/s390-skeys.c          |   2 +-=0D
 hw/usb/host-libusb.c           |   2 +-=0D
 hw/vfio/common.c               |   4 +-=0D
 include/monitor/monitor.h      |   3 +-=0D
 include/qemu/osdep.h           |   9 ++-=0D
 io/channel-file.c              |   2 +-=0D
 monitor/misc.c                 |  58 ++++++++----------=0D
 net/vhost-vdpa.c               |   2 +-=0D
 os-posix.c                     |   2 +-=0D
 qga/channel-posix.c            |   4 +-=0D
 qga/commands-posix.c           |   6 +-=0D
 stubs/fdset.c                  |   8 +--=0D
 target/arm/kvm.c               |   2 +-=0D
 ui/console.c                   |   2 +-=0D
 util/osdep.c                   | 104 +++++++++++++++++++++++----------=0D
 util/oslib-posix.c             |   2 +-=0D
 26 files changed, 148 insertions(+), 114 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


