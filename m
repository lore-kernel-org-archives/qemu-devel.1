Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FA8C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:59:04 +0000 (UTC)
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A1B217D9
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A1B217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDri2-0000gA-Kk
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 10:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iDqWA-0005lb-5D
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iDqW3-0005Ho-38
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:42:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34192)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iDqW2-0005Gu-Hq
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:42:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 643823003194
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 13:42:31 +0000 (UTC)
Received: from localhost (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90E1B600C6;
 Fri, 27 Sep 2019 13:42:26 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/7] Add dbus-vmstate
Date: Fri, 27 Sep 2019 17:42:17 +0400
Message-Id: <20190927134224.14550-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 27 Sep 2019 13:42:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 dgilbert@redhat.com, pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
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

v4:
- add Daniel security scenarios to the D-Bus document
- misc doc improvements
- add "util: add dbus helper unit" patch, with
  qemu_dbus_get_queued_owners()
- add "configure: add GDBUS_CODEGEN", explaining why gio-unix is
  required when available
- silence the expected failing tests
- update copyright headers, MAINTAINERS
- add r-b/a-b tags
- rebased

(Note: patchew dbus test fails for unclear reasons, but I can't
reproduce locally nor on travis)

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

Marc-Andr=C3=A9 Lureau (7):
  vmstate: add qom interface to get id
  vmstate: replace DeviceState with VMStateIf
  docs: start a document to describe D-Bus usage
  util: add dbus helper unit
  Add dbus-vmstate object
  configure: add GDBUS_CODEGEN
  tests: add dbus-vmstate-test

 MAINTAINERS                   |  12 +
 backends/Makefile.objs        |   4 +
 backends/dbus-vmstate.c       | 496 ++++++++++++++++++++++++++++++++++
 configure                     |   7 +
 docs/interop/dbus-vmstate.rst |  74 +++++
 docs/interop/dbus.rst         | 104 +++++++
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
 hw/nvram/eeprom93xx.c         |   4 +-
 hw/ppc/spapr_drc.c            |   9 +-
 hw/ppc/spapr_iommu.c          |   4 +-
 hw/s390x/s390-skeys.c         |   2 +-
 include/hw/vmstate-if.h       |  40 +++
 include/migration/register.h  |   4 +-
 include/migration/vmstate.h   |  10 +-
 include/qemu/dbus.h           |  18 ++
 migration/savevm.c            |  20 +-
 stubs/vmstate.c               |   4 +-
 tests/Makefile.include        |  20 +-
 tests/dbus-vmstate-daemon.sh  |  95 +++++++
 tests/dbus-vmstate-test.c     | 399 +++++++++++++++++++++++++++
 tests/dbus-vmstate1.xml       |  12 +
 util/Makefile.objs            |   3 +
 util/dbus.c                   |  55 ++++
 33 files changed, 1421 insertions(+), 38 deletions(-)
 create mode 100644 backends/dbus-vmstate.c
 create mode 100644 docs/interop/dbus-vmstate.rst
 create mode 100644 docs/interop/dbus.rst
 create mode 100644 hw/core/vmstate-if.c
 create mode 100644 include/hw/vmstate-if.h
 create mode 100644 include/qemu/dbus.h
 create mode 100755 tests/dbus-vmstate-daemon.sh
 create mode 100644 tests/dbus-vmstate-test.c
 create mode 100644 tests/dbus-vmstate1.xml
 create mode 100644 util/dbus.c

--=20
2.23.0


