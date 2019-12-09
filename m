Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C19C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 07:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECD62071E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 07:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="nbvCL3c5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECD62071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieDgB-0003Ul-7S
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 02:42:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ieDfR-0002dU-5V
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 02:41:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ieDfO-0001CB-36
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 02:41:15 -0500
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:50028)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1ieDfN-0001BX-GG
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 02:41:14 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 05FB82E0991;
 Mon,  9 Dec 2019 10:41:09 +0300 (MSK)
Received: from myt4-4db2488e778a.qloud-c.yandex.net
 (myt4-4db2488e778a.qloud-c.yandex.net [2a02:6b8:c00:884:0:640:4db2:488e])
 by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 E4ikTqM1uB-f7EuBuqO; Mon, 09 Dec 2019 10:41:08 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1575877268; bh=PITJf/bn5T55B4eym02hcq0v+DEViLG6YqLqJJ2S4h4=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=nbvCL3c56n7C63XeBQB2RadSM32gL29C+3e3GwunkDwqi+zfFCWvZrMBNYXB7h2/a
 040MiI3b/sJYf6jTdCcRqx9tbIyMdkG+OP6+plIZQV+675J6wwCuEaYOaqQ60MMPO0
 wCs86LcVxcf8RmA8bw0hbRGtQOMY1Ic8GBMMs1E4=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:2c54:c0fb:a18c:48a0])
 by myt4-4db2488e778a.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 dqiMOlYtgw-f7YqTBYF; Mon, 09 Dec 2019 10:41:07 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/1] Removing RAMBlocks during migration
Date: Mon,  9 Dec 2019 10:41:01 +0300
Message-Id: <20191209074102.5926-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1a2d::193
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, yc-core@yandex-team.ru,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I found that it's possible to remove a RAMBlock during migration.
E.g. device hot-unplugging initiated by a guest (how to reproduce is belo=
w).
And I want to clarify whether RAMBlock removing (or even adding) during
migration is valid operation or it's a bug.

Currently, it may cause some race conditions with migration thread and
migration may fail because of them. For instance, vmstate_unregister_ram
function which is called during PCIe device removing does these:
- Memset idstr -> target may receive unknown/zeroed idstr -> migration fa=
il
- Set RAMBlock flags as non-migratable -> migration fail

RAMBlock removing itself seems safe for migration thread because of RCU.
But it seems to me there are other possible race conditions (didn't test =
it):
- qemu_put_buffer_async -> saves pointer to RAMBlock's memory
   -> block will be freed out of RCU (between ram save iterations)
   -> qemu_fflush -> access to freed memory.

So, I have the following questions:
1. Is RAMBlock removing/adding OK during migration?
2. If yes then what should we do with vmstate_unregister_ram?
   - Just remove vmstate_unregister_ram (my RFC patch)
   - Refcount RAMBlock's migratable/non-migratable state
   - Something else?
3. If it mustn't be possible, so may be
   assert(migration_is_idle()) in qemu_ram_free?

P.S.
I'm working on a fix of below problem and trying to choose better way:
allow device removing and fix all problem like this or fix a particular d=
evice.

--------
How to reproduce device removing during migration:

1. Source QEMU command line (target is similar)
  $ x86_64-softmmu/qemu-system-x86_64 \
    -nodefaults -no-user-config -m 1024 -M q35 \
    -qmp unix:./src.sock,server,nowait \
    -drive file=3D./image,format=3Draw,if=3Dvirtio \
    -device ioh3420,id=3Dpcie.1 \
    -device virtio-net,bus=3Dpcie.1
2. Start migration with slow speed (to simplify reproducing)
3. Power off a device on the hotplug pcie.1 bus:
  $ echo 0 > /sys/bus/pci/slots/0/power
4. Increase migration speed and wait until fail

Most likely you will get something like this:
  qemu-system-x86_64: get_pci_config_device: Bad config data:
          i=3D0xaa read: 0 device: 40 cmask: ff wmask: 0 w1cmask:19
  qemu-system-x86_64: Failed to load PCIDevice:config
  qemu-system-x86_64: Failed to load
          ioh-3240-express-root-port:parent_obj.parent_obj.parent_obj
  qemu-system-x86_64: error while loading state for instance 0x0 of devic=
e
          '0000:00:03.0/ioh-3240-express-root-port'
  qemu-system-x86_64: load of migration failed: Invalid argument

This error is just an illustration of the removing device possibility,
but not actually an illustration of the race conditions for removing RAMB=
lock.

Regards,
Yury

Yury Kotov (1):
  migration: Remove vmstate_unregister_ram

 hw/block/pflash_cfi01.c     | 1 -
 hw/block/pflash_cfi02.c     | 1 -
 hw/mem/pc-dimm.c            | 5 -----
 hw/misc/ivshmem.c           | 2 --
 hw/pci/pci.c                | 1 -
 include/migration/vmstate.h | 1 -
 migration/savevm.c          | 6 ------
 7 files changed, 17 deletions(-)

--=20
2.24.0


