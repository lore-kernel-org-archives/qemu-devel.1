Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D596DC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3B8208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egEprZDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3B8208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVu5H-00074N-UA
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 06:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVu4C-0005Pr-CW
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 06:13:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVu4A-0001bI-00
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 06:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603447976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gSp78aYnfBQazXAWBJcm69s0Ji1f69fThU0FHl/a+8Y=;
 b=egEprZDMH90d6gpptN3jxLxsCQ7QitO2htc7Q1pntgAYOJlkjRTQXhSfFWjEcoWhSBV+6J
 Fc0Jzq1czFEXWv0UiAxhtEudupOcQ6MTYh3r375SP691QYHXztzlGXUtmwxqFtMOyRgZ8z
 EAbvFEL4+j9Evcqb/wwj2hFEi/3ebfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-IdF_BeBAN4-QqyoUMZ5YIA-1; Fri, 23 Oct 2020 06:12:54 -0400
X-MC-Unique: IdF_BeBAN4-QqyoUMZ5YIA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D4E3805F05;
 Fri, 23 Oct 2020 10:12:53 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEC786EF65;
 Fri, 23 Oct 2020 10:12:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/6] qemu-storage-daemon: QAPIfy --chardev
Date: Fri, 23 Oct 2020 12:12:16 +0200
Message-Id: <20201023101222.250147-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While the qemu-storage-daemon command line is still considered unstable,
let's change --chardev from the old QemuOpts-based parser to QAPI, so
that it becomes a simple mapping of chardev-add to the command line and
will fit in a future fully QAPIfied command line without later
incompatible changes or additional compatibility glue.

Kevin Wolf (6):
  char/stdio: Fix QMP default for 'signal'
  char: Factor out qemu_chr_print_types()
  qapi: Remove wrapper struct for simple unions
  qapi: Optionally parse simple unions as flat
  tests/qapi-schema: Flat representation of simple unions
  qemu-storage-daemon: Use qmp_chardev_add() for --chardev

 qapi/char.json                                |  6 +-
 docs/devel/qapi-code-gen.txt                  | 43 +++++++---
 include/chardev/char.h                        |  1 +
 include/qapi/visitor-impl.h                   |  3 +
 include/qapi/visitor.h                        | 10 +++
 backends/tpm/tpm_emulator.c                   |  3 +-
 backends/tpm/tpm_passthrough.c                |  4 +-
 block/crypto.c                                |  3 +-
 block/qcow2.c                                 |  9 +-
 block/vmdk.c                                  | 14 ++--
 blockdev.c                                    | 36 ++++----
 chardev/char-file.c                           |  5 +-
 chardev/char-mux.c                            |  5 +-
 chardev/char-parallel.c                       |  5 +-
 chardev/char-pipe.c                           |  7 +-
 chardev/char-ringbuf.c                        |  5 +-
 chardev/char-serial.c                         |  5 +-
 chardev/char-socket.c                         | 13 ++-
 chardev/char-stdio.c                          |  9 +-
 chardev/char-udp.c                            | 11 +--
 chardev/char.c                                | 27 +++---
 chardev/msmouse.c                             |  4 +-
 chardev/wctablet.c                            |  4 +-
 hw/core/numa.c                                |  6 +-
 hw/display/xenfb.c                            |  8 +-
 hw/input/hid.c                                |  8 +-
 hw/input/ps2.c                                |  6 +-
 hw/input/virtio-input-hid.c                   |  8 +-
 hw/mem/pc-dimm.c                              | 18 ++--
 hw/virtio/virtio-mem-pci.c                    |  3 +-
 hw/virtio/virtio-pmem-pci.c                   |  3 +-
 monitor/hmp-cmds.c                            | 14 ++--
 qapi/qapi-visit-core.c                        | 10 +++
 qemu-keymap.c                                 |  2 +-
 replay/replay-input.c                         | 46 +++++-----
 storage-daemon/qemu-storage-daemon.c          | 47 +++++++++--
 tests/test-char.c                             | 12 ++-
 tests/test-clone-visitor.c                    | 14 ++--
 tests/test-qmp-cmds.c                         |  2 +-
 tests/test-qobject-input-visitor.c            | 24 +++---
 tests/test-qobject-output-visitor.c           | 24 +++---
 ui/console.c                                  |  5 +-
 ui/input-keymap.c                             | 12 +--
 ui/input-legacy.c                             | 12 +--
 ui/input.c                                    | 43 +++++-----
 util/qemu-sockets.c                           |  8 +-
 scripts/qapi/expr.py                          |  7 +-
 scripts/qapi/introspect.py                    |  7 +-
 scripts/qapi/schema.py                        | 63 +++++++++++---
 scripts/qapi/visit.py                         | 36 ++++++++
 tests/qapi-schema/doc-good.out                |  8 +-
 tests/qapi-schema/flat-union-allow-flat.err   |  2 +
 tests/qapi-schema/flat-union-allow-flat.json  | 10 +++
 tests/qapi-schema/flat-union-allow-flat.out   |  0
 tests/qapi-schema/meson.build                 |  4 +
 tests/qapi-schema/qapi-schema-test.json       | 10 +++
 tests/qapi-schema/qapi-schema-test.out        | 84 +++++++------------
 tests/qapi-schema/union-allow-flat-bad.err    |  2 +
 tests/qapi-schema/union-allow-flat-bad.json   |  5 ++
 tests/qapi-schema/union-allow-flat-bad.out    |  0
 .../union-allow-flat-builtin-type.err         |  2 +
 .../union-allow-flat-builtin-type.json        |  5 ++
 .../union-allow-flat-builtin-type.out         |  0
 tests/qapi-schema/union-clash-member.err      |  2 +
 tests/qapi-schema/union-clash-member.json     |  6 ++
 tests/qapi-schema/union-clash-member.out      |  0
 66 files changed, 484 insertions(+), 336 deletions(-)
 create mode 100644 tests/qapi-schema/flat-union-allow-flat.err
 create mode 100644 tests/qapi-schema/flat-union-allow-flat.json
 create mode 100644 tests/qapi-schema/flat-union-allow-flat.out
 create mode 100644 tests/qapi-schema/union-allow-flat-bad.err
 create mode 100644 tests/qapi-schema/union-allow-flat-bad.json
 create mode 100644 tests/qapi-schema/union-allow-flat-bad.out
 create mode 100644 tests/qapi-schema/union-allow-flat-builtin-type.err
 create mode 100644 tests/qapi-schema/union-allow-flat-builtin-type.json
 create mode 100644 tests/qapi-schema/union-allow-flat-builtin-type.out
 create mode 100644 tests/qapi-schema/union-clash-member.err
 create mode 100644 tests/qapi-schema/union-clash-member.json
 create mode 100644 tests/qapi-schema/union-clash-member.out

-- 
2.28.0


