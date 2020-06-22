Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C33C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E01620716
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUbE+zgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E01620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnIzI-0003Xe-O5
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnIyJ-0001Uj-IO
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:42:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36862
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnIyH-0003uf-6E
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592818952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8qOVyNMvYxbii3tjFST8dO7Ugc4BAVpzFJSTP+mTIcI=;
 b=bUbE+zgbUefnkzokxNisSjpt7bJeU0VGYqv601+og0vlJ/+9WCHQTTHyu02KSYMAeE7IhP
 wtZLLeIsa1w6iuLfmMPhRlQugDyHOjZAwGjnMY10ca0pa1oJ/LmJ8qnNpGqvSCGItZqWua
 yfmCqpsMGM4flvCNOwJfJdMFRtdClNU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-S0rTIIKvO_uaIhTkfyrVpw-1; Mon, 22 Jun 2020 05:42:30 -0400
X-MC-Unique: S0rTIIKvO_uaIhTkfyrVpw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDB8E100A614;
 Mon, 22 Jun 2020 09:42:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 579617C1FD;
 Mon, 22 Jun 2020 09:42:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BA5E1113846D; Mon, 22 Jun 2020 11:42:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/16] Crazy shit around -global (pardon my french)
Date: Mon, 22 Jun 2020 11:42:11 +0200
Message-Id: <20200622094227.1271650-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are three ways to configure backends:

* -nic, -serial, -drive, ... (onboard devices)

* Set the property with -device, or, if you feel masochistic, with
  -set device (pluggable devices)

* Set the property with -global (both)

The trouble is -global is terrible.

It gets applied in object_new(), which can't fail.  We treat failure
to apply -global as fatal error, except when hot-plugging, where we
treat it as warning *boggle*.  I'm not addressing that today.

Some code falls apart when you use both -global and the other way.

To make life more interesting, we gave -drive two roles: with
interface type other than none, it's for configuring onboard devices,
and with interface type none, it's for defining backends for use with
-device and such.  Since we neglect to require interface type none for
the latter, you can use one -drive in both roles.  This confuses the
code about as much as you, dear reader, probably are by now.

Because this still isn't interesting enough, there's yet another way
to configure backends, just for floppies: set the floppy controller's
property.  Goes back to the time when floppy wasn't a separate device,
and involves some Bad Magic.  Now -global can interact with itself!

Digging through all this took me an embarrassing amount of time.
Hair, too.

My patches reject some the silliest uses outright, and deprecate some
not so silly ones that have replacements.

Apply on top of my "[PATCH v2 00/58] qdev: Rework how we plug into the
parent bus".

Enjoy!

v2:
* Rebased; tests/qemu-iotests/172.out regenerated to resolve conflicts
* PATCH 10-12: check_non_null() renamed to check_prop_still_unset()
  [Philippe]

Markus Armbruster (16):
  iotests/172: Include "info block" in test output
  iotests/172: Cover empty filename and multiple use of drives
  iotests/172: Cover -global floppy.drive=...
  fdc: Reject clash between -drive if=floppy and -global isa-fdc
  fdc: Open-code fdctrl_init_isa()
  fdc: Deprecate configuring floppies with -global isa-fdc
  docs/qdev-device-use.txt: Update section "Default Devices"
  blockdev: Deprecate -drive with bogus interface type
  qdev: Eliminate get_pointer(), set_pointer()
  qdev: Improve netdev property override error a bit
  qdev: Reject drive property override
  qdev: Reject chardev property override
  qdev: Make qdev_prop_set_drive() match the other helpers
  arm/aspeed: Drop aspeed_board_init_flashes() parameter @errp
  sd/pxa2xx_mmci: Don't crash on pxa2xx_mmci_init() error
  sd/milkymist-memcard: Fix error API violation

 docs/qdev-device-use.txt            |  17 +-
 docs/system/deprecated.rst          |  34 ++
 include/hw/block/fdc.h              |   2 +-
 include/hw/qdev-properties.h        |  18 +-
 include/sysemu/blockdev.h           |   2 +
 blockdev.c                          |  27 +-
 hw/arm/aspeed.c                     |  16 +-
 hw/arm/cubieboard.c                 |   2 +-
 hw/arm/exynos4210.c                 |   2 +-
 hw/arm/imx25_pdk.c                  |   2 +-
 hw/arm/mcimx6ul-evk.c               |   2 +-
 hw/arm/mcimx7d-sabre.c              |   2 +-
 hw/arm/msf2-som.c                   |   4 +-
 hw/arm/nseries.c                    |   4 +-
 hw/arm/orangepi.c                   |   2 +-
 hw/arm/raspi.c                      |   2 +-
 hw/arm/sabrelite.c                  |   6 +-
 hw/arm/vexpress.c                   |   3 +-
 hw/arm/xilinx_zynq.c                |   7 +-
 hw/arm/xlnx-versal-virt.c           |   2 +-
 hw/arm/xlnx-zcu102.c                |  10 +-
 hw/block/fdc.c                      |  82 ++--
 hw/block/nand.c                     |   2 +-
 hw/block/pflash_cfi01.c             |   6 +-
 hw/block/pflash_cfi02.c             |   2 +-
 hw/core/qdev-properties-system.c    | 151 ++++---
 hw/core/qdev-properties.c           |  17 +
 hw/i386/pc.c                        |   8 +-
 hw/ide/qdev.c                       |   4 +-
 hw/isa/isa-superio.c                |  18 +-
 hw/m68k/q800.c                      |   3 +-
 hw/microblaze/petalogix_ml605_mmu.c |   5 +-
 hw/ppc/pnv.c                        |   3 +-
 hw/ppc/spapr.c                      |   4 +-
 hw/scsi/scsi-bus.c                  |   2 +-
 hw/sd/milkymist-memcard.c           |   2 +-
 hw/sd/pxa2xx_mmci.c                 |  15 +-
 hw/sd/sd.c                          |   2 +-
 hw/sd/ssi-sd.c                      |   3 +-
 hw/sparc64/sun4u.c                  |   9 +-
 hw/xtensa/xtfpga.c                  |   3 +-
 softmmu/vl.c                        |   8 +
 tests/qemu-iotests/172              |  27 +-
 tests/qemu-iotests/172.out          | 656 +++++++++++++++++++++++++---
 44 files changed, 928 insertions(+), 270 deletions(-)

-- 
2.26.2


