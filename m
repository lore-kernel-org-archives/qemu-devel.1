Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E977C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:11:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D549320707
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hA/B//Fj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D549320707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioU28-0008Nb-Vq
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ioTeQ-0002WV-OY
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ioTeP-0002qL-85
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:46:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52811
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ioTeP-0002pP-45
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578321995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3n8CMJnLKZ7RSrdIku//nKAZwqXJ4Geu+5RGdbKJZSo=;
 b=hA/B//FjcRdfX+OUpVs7uooyOrkkV5GngUM0DMPAQDTyVzXJrlG+LdMfAxVVijdWVWIy8a
 FTy4E5OkmX6ycIxKDvZBc4UxMZ16BPo8LCoT6JvGN6ga1kWfm6rkGZm9FZWNF5sBvKdgej
 04xxvKmMU9Zf3fVGUqhuDhD1V0UXFhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-D3k7Vc76MCeSu-PsgPry3A-1; Mon, 06 Jan 2020 09:46:32 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D23941007277;
 Mon,  6 Jan 2020 14:46:30 +0000 (UTC)
Received: from localhost (ovpn-112-48.ams2.redhat.com [10.36.112.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1A65100164D;
 Mon,  6 Jan 2020 14:46:26 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 0/9] Add dbus-vmstate
Date: Mon,  6 Jan 2020 18:46:13 +0400
Message-Id: <20200106144622.1520994-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: D3k7Vc76MCeSu-PsgPry3A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit b0b74e1f17508cb8cef8afd698558db1bd8999cc=
:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-requ=
est' into staging (2020-01-06 11:39:55 +0000)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/dbus-vmstate7-pull-request

for you to fetch changes up to 586ca6ba3cd6d7a3a85ed5cdc4e53b1cd584b0c0:

  tests: add dbus-vmstate-test (2020-01-06 18:41:32 +0400)

----------------------------------------------------------------
Add dbus-vmstate

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

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (9):
  vmstate: add qom interface to get id
  vmstate: replace DeviceState with VMStateIf
  docs: start a document to describe D-Bus usage
  util: add dbus helper unit
  Add dbus-vmstate object
  configure: add GDBUS_CODEGEN
  dockerfiles: add dbus-daemon to some of latest distributions
  tests: add migration-helpers unit
  tests: add dbus-vmstate-test

 configure                                |   7 +
 include/hw/vmstate-if.h                  |  40 ++
 include/migration/register.h             |   4 +-
 include/migration/vmstate.h              |  10 +-
 include/qemu/dbus.h                      |  19 +
 tests/migration-helpers.h                |  37 ++
 backends/dbus-vmstate.c                  | 510 +++++++++++++++++++++++
 hw/block/onenand.c                       |   2 +-
 hw/core/qdev.c                           |  21 +-
 hw/core/vmstate-if.c                     |  23 +
 hw/ide/cmd646.c                          |   2 +-
 hw/ide/isa.c                             |   2 +-
 hw/ide/piix.c                            |   2 +-
 hw/ide/via.c                             |   2 +-
 hw/misc/max111x.c                        |   2 +-
 hw/net/eepro100.c                        |   4 +-
 hw/net/virtio-net.c                      |   3 +-
 hw/nvram/eeprom93xx.c                    |   4 +-
 hw/ppc/spapr_drc.c                       |   9 +-
 hw/ppc/spapr_iommu.c                     |   4 +-
 hw/s390x/s390-skeys.c                    |   2 +-
 migration/savevm.c                       |  20 +-
 stubs/vmstate.c                          |   4 +-
 tests/dbus-vmstate-test.c                | 382 +++++++++++++++++
 tests/migration-helpers.c                | 167 ++++++++
 tests/migration-test.c                   | 176 +-------
 util/dbus.c                              |  57 +++
 MAINTAINERS                              |  12 +
 Makefile.objs                            |   1 +
 backends/Makefile.objs                   |   4 +
 backends/trace-events                    |   7 +
 docs/interop/dbus-vmstate.rst            |  74 ++++
 docs/interop/dbus.rst                    | 110 +++++
 docs/interop/index.rst                   |   2 +
 hw/core/Makefile.objs                    |   1 +
 tests/Makefile.include                   |  25 +-
 tests/dbus-vmstate-daemon.sh             |  95 +++++
 tests/dbus-vmstate1.xml                  |  12 +
 tests/docker/dockerfiles/centos7.docker  |   1 +
 tests/docker/dockerfiles/debian10.docker |   1 +
 tests/docker/dockerfiles/fedora.docker   |   1 +
 tests/docker/dockerfiles/ubuntu.docker   |   1 +
 util/Makefile.objs                       |   3 +
 43 files changed, 1660 insertions(+), 205 deletions(-)
 create mode 100644 include/hw/vmstate-if.h
 create mode 100644 include/qemu/dbus.h
 create mode 100644 tests/migration-helpers.h
 create mode 100644 backends/dbus-vmstate.c
 create mode 100644 hw/core/vmstate-if.c
 create mode 100644 tests/dbus-vmstate-test.c
 create mode 100644 tests/migration-helpers.c
 create mode 100644 util/dbus.c
 create mode 100644 backends/trace-events
 create mode 100644 docs/interop/dbus-vmstate.rst
 create mode 100644 docs/interop/dbus.rst
 create mode 100755 tests/dbus-vmstate-daemon.sh
 create mode 100644 tests/dbus-vmstate1.xml

--=20
2.25.0.rc1.1.gb0343b22ed


