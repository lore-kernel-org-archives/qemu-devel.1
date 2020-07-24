Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FF4C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EEAC2065F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmRF/e2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEAC2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyxiR-0000eV-Qg
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyxha-00086b-3n
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:25:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59525
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyxhX-0000xR-Jd
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595597126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ATGOUODpJK2k+GIzwvHJfuskiTl3xB2feIQ1iuYonn4=;
 b=NmRF/e2fcMqpbHnw6lbRY2OiVwDSNYcPSI02op4/lF3KHvetsZ/ThcVHEY5b2GiNAUeOOJ
 hjn/mc6U7mXpuMHDaVyyLI7TsF4jHGssl7ul3K5ZOHrWsFgNLlWa9JwL75inbiQ+YFA6uD
 hK2/q4EKPIsrl+3829a75kZsJ3FX6FQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-ftzEkAd1Pw6OaFy-xnsPYQ-1; Fri, 24 Jul 2020 09:25:23 -0400
X-MC-Unique: ftzEkAd1Pw6OaFy-xnsPYQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0A8B104ECFD;
 Fri, 24 Jul 2020 13:25:21 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45F97101E1BF;
 Fri, 24 Jul 2020 13:25:12 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] block: improve error reporting for unsupported O_DIRECT
Date: Fri, 24 Jul 2020 14:25:06 +0100
Message-Id: <20200724132510.3250311-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:55:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v1: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg00269.html=0D
v2: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg00589.html=0D
=0D
See patch commit messages for rationale=0D
=0D
Ideally we would convert other callers of qemu_open to use=0D
qemu_open_err, and eventually remove qemu_open, renaming=0D
qemu_open_err back to qemu_open.  Given soft freeze is just=0D
days away though, I'm hoping this series is simple enough=0D
to get into this release, leaving bigger cleanup for later.=0D
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
Daniel P. Berrang=C3=A9 (4):=0D
  util: rename qemu_open() to qemu_open_old()=0D
  util: introduce qemu_open and qemu_create with error reporting=0D
  util: give a specific error message when O_DIRECT doesn't work=0D
  block: switch to use qemu_open/qemu_create for improved errors=0D
=0D
 accel/kvm/kvm-all.c            |  2 +-=0D
 backends/rng-random.c          |  2 +-=0D
 backends/tpm/tpm_passthrough.c |  8 +--=0D
 block/file-posix.c             | 16 +++---=0D
 block/file-win32.c             |  5 +-=0D
 block/vvfat.c                  |  5 +-=0D
 chardev/char-fd.c              |  2 +-=0D
 chardev/char-pipe.c            |  6 +--=0D
 chardev/char.c                 |  2 +-=0D
 dump/dump.c                    |  2 +-=0D
 hw/s390x/s390-skeys.c          |  2 +-=0D
 hw/usb/host-libusb.c           |  2 +-=0D
 hw/vfio/common.c               |  4 +-=0D
 include/qemu/osdep.h           |  8 ++-=0D
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
 util/osdep.c                   | 91 +++++++++++++++++++++++++++++-----=0D
 util/oslib-posix.c             |  2 +-=0D
 32 files changed, 144 insertions(+), 77 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


