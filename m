Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE82C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3656520830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3656520830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8OOx-0007lZ-4B
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1i8OA8-0002iA-Tj
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1i8OA7-0007HZ-Lz
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:25:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50200)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1i8OA7-0007HD-F6
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:25:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0CE731DB0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 12:25:22 +0000 (UTC)
Received: from localhost (ovpn-112-63.ams2.redhat.com [10.36.112.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BC11100195F;
 Thu, 12 Sep 2019 12:25:16 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 16:25:08 +0400
Message-Id: <20190912122514.22504-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Thu, 12 Sep 2019 12:25:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/6] Add dbus-vmstate
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
Cc: berrange@redhat.com, quintela@redhat.com, mprivozn@redhat.com,
 dgilbert@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

With external processes or helpers participating to the VM support, it
becomes necessary to handle their migration. Various options exist to
transfer their state:
1) as the VM memory, RAM or devices (we could say that's how
   vhost-user devices can be handled today, they are expected to
   restore from ring state)
2) other "vmstate" (as with TPM emulator state blobs)
3) left to be handled by management layer

1) is not practical, since an external processes may legitimatelly
need arbitrary state date to back a device or a service, or may not
even have an associated device.

2) needs ad-hoc code for each helper, but is simple and working

3) is complicated for management layer, QEMU has the migration timing

The proposed "dbus-vmstate" object will connect to a given D-Bus
address, and save/load from org.qemu.VMState1 owners on migration.

Thus helpers can easily have their state migrated with QEMU, without
implementing ad-hoc support (such as done for TPM emulation)

D-Bus is ubiquitous on Linux (it is systemd IPC), and can be made to
work on various other OSes. There are several implementations and good
bindings for various languages.  (the tests/dbus-vmstate-test.c is a
good example of how simple the implementation of services can be, even
in C)

dbus-vmstate is put into use by the libvirt series "[PATCH 00/23] Use
a slirp helper process".

v3:
- after various discussions on helper processes, we settled on a
  preference for having a bus for communications. This version is
  actually v1 updated.
- added a dbus.rst document to describe D-Bus recommendations for QEMU
- added dbus-vmstate-daemon.sh to play with the dbus-daemon configuration
  (although it is not very useful in the context of a single UID)
- added a new vmstate interface, so that any object can implement
  VMStateDescription, and converted dbus-vmstate
- added "migration: fix vmdesc leak on vmstate_save() error"
- convert to g_auto

v2:
- D-Bus is most common and practical through a bus, but it requires a
  daemon to be running. I argue that the benefits outweight the cost
  of running an extra daemon in v1 in the context of multi-process
  qemu, but it is also possible to connect in p2p mode as done in this
  new version.

Marc-Andr=C3=A9 Lureau (6):
  migration: fix vmdesc leak on vmstate_save() error
  vmstate: add qom interface to get id
  vmstate: replace DeviceState with VMStateIf
  tests: add qtest_expect_exit_status()
  docs: start a document to describe D-Bus usage
  Add dbus-vmstate object

 MAINTAINERS                   |   6 +
 backends/Makefile.objs        |   4 +
 backends/dbus-vmstate.c       | 530 ++++++++++++++++++++++++++++++++++
 configure                     |   7 +
 docs/devel/migration.rst      |   2 +-
 docs/interop/dbus-vmstate.rst |  68 +++++
 docs/interop/dbus.rst         |  73 +++++
 docs/interop/index.rst        |   2 +
 hw/block/onenand.c            |   2 +-
 hw/core/Makefile.objs         |   1 +
 hw/core/qdev.c                |  21 +-
 hw/core/vmstate-if.c          |  23 ++
 hw/ide/cmd646.c               |   2 +-
 hw/ide/isa.c                  |   2 +-
 hw/ide/piix.c                 |   2 +-
 hw/ide/via.c                  |   2 +-
 hw/misc/max111x.c             |   2 +-
 hw/net/eepro100.c             |   4 +-
 hw/net/vmxnet3.c              |   2 +-
 hw/nvram/eeprom93xx.c         |   4 +-
 hw/ppc/spapr_drc.c            |   9 +-
 hw/ppc/spapr_iommu.c          |   4 +-
 hw/s390x/s390-skeys.c         |   2 +-
 include/hw/vmstate-if.h       |  32 ++
 include/migration/register.h  |   6 +-
 include/migration/vmstate.h   |  10 +-
 migration/qjson.h             |   2 +
 migration/savevm.c            |  29 +-
 stubs/vmstate.c               |   4 +-
 tests/Makefile.include        |  20 +-
 tests/dbus-vmstate-daemon.sh  |  95 ++++++
 tests/dbus-vmstate-test.c     | 386 +++++++++++++++++++++++++
 tests/dbus-vmstate1.xml       |  12 +
 tests/libqtest.c              |  41 +--
 tests/libqtest.h              |   9 +
 35 files changed, 1355 insertions(+), 65 deletions(-)
 create mode 100644 backends/dbus-vmstate.c
 create mode 100644 docs/interop/dbus-vmstate.rst
 create mode 100644 docs/interop/dbus.rst
 create mode 100644 hw/core/vmstate-if.c
 create mode 100644 include/hw/vmstate-if.h
 create mode 100755 tests/dbus-vmstate-daemon.sh
 create mode 100644 tests/dbus-vmstate-test.c
 create mode 100644 tests/dbus-vmstate1.xml

--=20
2.23.0


