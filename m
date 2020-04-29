Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57314C83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20DE920775
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h67hfgk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DE920775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTh3r-0001L2-71
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1q-0007tT-4q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1c-0003tm-1x
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49114
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTh1b-0003q7-Dx
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588144853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mKzjfrclOr7lr/S5nNtSMwcSJZlKn8WN82dcYBCTw98=;
 b=h67hfgk+6kVBZ/oenN0ksmVQ7etQZGGQJPRLd2ixVBR7EovHIJ8cIZ5gobZWUgvTYpXuZm
 mACCtm6YajMIJAVwIJvvoxgyPyb5n0HnZNoU1znwn/RQSgMDEjBZvhvcoNi1wGEhMrBo/S
 tF2F1VhutXTm/3jBXhEAlwkWlxV4BiM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-Qnoykja2OCis6Qf4ZjVr_Q-1; Wed, 29 Apr 2020 03:20:51 -0400
X-MC-Unique: Qnoykja2OCis6Qf4ZjVr_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB2E98014D6
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 07:20:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63E755D9E5
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 07:20:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BFA7D11358BC; Wed, 29 Apr 2020 09:20:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/32] Miscellaneous patches for 2020-04-29
Date: Wed, 29 Apr 2020 09:20:16 +0200
Message-Id: <20200429072048.29963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit fdd76fecdde1ad444ff4deb7f1c4f7e4a1ef97d6=
:

  Update version for v5.0.0 release (2020-04-28 17:46:57 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-misc-2020-04-29

for you to fetch changes up to 8ef3a4be27efccd791d05e74b7b17d918f511a76:

  qemu-option: pass NULL rather than 0 to the id of qemu_opts_set() (2020-0=
4-29 08:01:52 +0200)

----------------------------------------------------------------
Miscellaneous patches for 2020-04-29

* Fix CLI option parsing corner cases
* Fix bugs on (unlikely) error paths
* Fix undefined behavior for silly option arguments
* Tidy up bamboo and sam460ex reporting of funny memory sizes
* Clean up error API violations
* A bit of refactoring here and there

----------------------------------------------------------------
Markus Armbruster (30):
      tests-qemu-opts: Cover has_help_option(), qemu_opt_has_help_opt()
      qemu-options: Factor out get_opt_name_value() helper
      qemu-option: Fix sloppy recognition of "id=3D..." after ",,"
      qemu-option: Fix has_help_option()'s sloppy parsing
      test-qemu-opts: Simplify test_has_help_option() after bug fix
      qemu-option: Avoid has_help_option() in qemu_opts_parse_noisily()
      qemu-img: Factor out accumulate_options() helper
      qemu-img: Move is_valid_option_list() to qemu-img.c and rewrite
      qemu-img: Reject broken -o ""
      cryptodev: Fix cryptodev_builtin_cleanup() error API violation
      block/file-posix: Fix check_cache_dropped() error handling
      cpus: Fix configure_icount() error API violation
      cpus: Proper range-checking for -icount shift=3DN
      arm/virt: Fix virt_machine_device_plug_cb() error API violation
      fdc: Fix fallback=3Dauto error handling
      bochs-display: Fix vgamem=3DSIZE error handling
      virtio-net: Fix duplex=3D... and speed=3D... error handling
      xen/pt: Fix flawed conversion to realize()
      io: Fix qio_channel_socket_close() error handling
      migration/colo: Fix qmp_xen_colo_do_checkpoint() error handling
      tests/test-logging: Fix test for -dfilter 0..0xffffffffffffffff
      qga: Fix qmp_guest_get_memory_blocks() error handling
      qga: Fix qmp_guest_suspend_{disk, ram}() error handling
      sam460ex: Suppress useless warning on -m 32 and -m 64
      smbus: Fix spd_data_generate() error API violation
      bamboo, sam460ex: Tidy up error message for unsupported RAM size
      smbus: Fix spd_data_generate() for number of banks > 2
      Makefile: Drop unused, broken target recurse-fuzz
      fuzz: Simplify how we compute available machines and types
      libqos: Give get_machine_allocator() internal linkage

Masahiro Yamada (1):
      qemu-option: pass NULL rather than 0 to the id of qemu_opts_set()

Philippe Mathieu-Daud=C3=A9 (1):
      various: Remove suspicious '\' character outside of #define in C code

 Makefile                          |   1 -
 include/hw/i2c/smbus_eeprom.h     |   2 +-
 include/qemu/option.h             |   1 -
 tests/qtest/libqos/qos_external.h |  10 +-
 backends/cryptodev-builtin.c      |  10 +-
 block/file-posix.c                |   5 +-
 block/replication.c               |   4 +-
 block/vhdx.c                      |   8 +-
 cpus.c                            |  52 ++++++----
 dump/dump.c                       |   2 +-
 hw/arm/virt.c                     |   4 +-
 hw/block/fdc.c                    |   1 +
 hw/display/bochs-display.c        |   6 +-
 hw/i2c/smbus_eeprom.c             |  32 +-----
 hw/mips/mips_fulong2e.c           |  10 +-
 hw/net/virtio-net.c               |   7 +-
 hw/ppc/ppc4xx_devs.c              |   8 +-
 hw/ppc/sam460ex.c                 |  13 +--
 hw/riscv/sifive_u.c               |   2 +-
 hw/scsi/scsi-disk.c               |   2 +-
 hw/sd/sdhci.c                     |   2 +-
 hw/xen/xen_pt.c                   |  12 +--
 io/channel-socket.c               |   5 +-
 migration/colo.c                  |   8 +-
 qemu-img.c                        |  87 +++++++++-------
 qga/commands-posix.c              |   3 +
 qga/commands-win32.c              |  14 +++
 softmmu/vl.c                      |  10 +-
 target/i386/cpu.c                 |  18 ++--
 target/microblaze/cpu.c           |  14 +--
 target/ppc/translate_init.inc.c   |   4 +-
 tests/qtest/fuzz/qos_fuzz.c       |  34 ++----
 tests/qtest/libqos/qos_external.c |  72 +++++--------
 tests/qtest/qos-test.c            |  29 ++++--
 tests/test-logging.c              |   4 +-
 tests/test-qemu-opts.c            |  46 ++++++++-
 util/qemu-option.c                | 210 +++++++++++++++++++---------------=
----
 37 files changed, 391 insertions(+), 361 deletions(-)

--=20
2.21.1


