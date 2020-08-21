Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037B1C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C644720748
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXt6YH1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C644720748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Ak2-0001vx-37
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k9AjA-0000Sg-2j
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:21:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48553
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k9Aj6-0008OJ-Ot
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598030473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b1s+i5DDeDvU0F5ELxnhTJl6tCoa5BU9rVxGinpRU2E=;
 b=cXt6YH1dnswXz0O5OJv3zineEX7iyo3nhd+AHm37YmD0Cm6+vFMcHmqv7M1ag3f+KclAcM
 3jHcDf1HRO5RXQo0uRbnQxsh9T1kT+jSh6AUlPHeAyRRSMt7sfkKyMgcewC1otXKJP41hG
 bYhfBPLqGMKu0sVtqp6/Ov7Z1CFoLZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-4MmncKyDMtigrMaotSO6cw-1; Fri, 21 Aug 2020 13:21:10 -0400
X-MC-Unique: 4MmncKyDMtigrMaotSO6cw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA56E10054FF;
 Fri, 21 Aug 2020 17:21:08 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AC696E715;
 Fri, 21 Aug 2020 17:21:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/6] block: improve error reporting for unsupported O_DIRECT
Date: Fri, 21 Aug 2020 18:20:59 +0100
Message-Id: <20200821172105.608752-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v1: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg00269.html=0D
v2: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg00589.html=0D
v3: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg07098.html=0D
=0D
See patch commit messages for rationale=0D
=0D
Ideally we would convert other callers of qemu_open to use=0D
qemu_open_err, and eventually remove qemu_open, renaming=0D
qemu_open_err back to qemu_open.  Given soft freeze is just=0D
days away though, I'm hoping this series is simple enough=0D
to get into this release, leaving bigger cleanup for later.=0D
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
Daniel P. Berrang=C3=A9 (6):=0D
  util: rename qemu_open() to qemu_open_old()=0D
  util: refactor qemu_open_old to split off variadic args handling=0D
  util: add Error object for qemu_open_internal error reporting=0D
  util: introduce qemu_open and qemu_create with error reporting=0D
  util: give a specific error message when O_DIRECT doesn't work=0D
  block/fileb: switch to use qemu_open/qemu_create for improved errors=0D
=0D
 accel/kvm/kvm-all.c            |  2 +-=0D
 backends/rng-random.c          |  2 +-=0D
 backends/tpm/tpm_passthrough.c |  8 ++--=0D
 block/file-posix.c             | 16 +++----=0D
 block/file-win32.c             |  5 +-=0D
 block/vvfat.c                  |  5 +-=0D
 chardev/char-fd.c              |  2 +-=0D
 chardev/char-pipe.c            |  6 +--=0D
 chardev/char.c                 |  2 +-=0D
 dump/dump.c                    |  2 +-=0D
 hw/s390x/s390-skeys.c          |  2 +-=0D
 hw/usb/host-libusb.c           |  2 +-=0D
 hw/vfio/common.c               |  4 +-=0D
 include/qemu/osdep.h           |  8 +++-=0D
 io/channel-file.c              |  2 +-=0D
 net/vhost-vdpa.c               |  2 +-=0D
 os-posix.c                     |  2 +-=0D
 qga/channel-posix.c            |  4 +-=0D
 qga/commands-posix.c           |  6 +--=0D
 target/arm/kvm.c               |  2 +-=0D
 tests/qemu-iotests/051.out     |  4 +-=0D
 tests/qemu-iotests/051.pc.out  |  4 +-=0D
 tests/qemu-iotests/061.out     |  2 +-=0D
 tests/qemu-iotests/069.out     |  2 +-=0D
 tests/qemu-iotests/082.out     |  4 +-=0D
 tests/qemu-iotests/111.out     |  2 +-=0D
 tests/qemu-iotests/226.out     |  6 +--=0D
 tests/qemu-iotests/232.out     | 12 ++---=0D
 tests/qemu-iotests/244.out     |  6 +--=0D
 ui/console.c                   |  2 +-=0D
 util/osdep.c                   | 83 ++++++++++++++++++++++++++++------=0D
 util/oslib-posix.c             |  2 +-=0D
 32 files changed, 136 insertions(+), 77 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


