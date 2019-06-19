Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43DBC48BC5
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0938208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0938208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdh0n-0001m7-VV
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 16:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35347)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hdgv9-0004K6-Rd
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 16:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hdgv7-00019C-58
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 16:11:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56484)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hdgv5-000112-KN
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 16:10:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8168A89ACB
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 20:10:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-85.ams2.redhat.com
 [10.36.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AF841001B3D;
 Wed, 19 Jun 2019 20:10:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 82E8611386A0; Wed, 19 Jun 2019 22:10:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 22:10:33 +0200
Message-Id: <20190619201050.19040-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 19 Jun 2019 20:10:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 00/17] Move QOM, qdev,
 machine core and dump code
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
Cc: kwolf@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split qom.json, qdev.json, machine.json, machine-target.json and
dump.json off misc.json, so MAINTAINERS can cover them properly.

Move their QMP and HMP code similarly.

Move some code out of the the tree's root directory to better places.

Markus Armbruster (16):
  Makefile: Don't add monitor/ twice to common-obj-y
  hmp: Move hmp.h to include/monitor/
  qapi: Split qom.json and qdev.json off misc.json
  qom: Move QMP command handlers to qom/
  qom: Move HMP command handlers to qom/
  MAINTAINERS: Merge sections CPU, NUMA into Machine core
  qapi: Split machine.json off misc.json
  hw/core: Move numa.c to hw/core/
  hw/core: Collect QMP command handlers in hw/core/
  hw/core: Collect HMP command handlers in hw/core/
  qapi: Split machine-target.json off target.json and misc.json
  qapi: Rename target.json to misc-target.json
  qapi: Split dump.json off misc.json
  dump: Move the code to dump/
  MAINTAINERS: Add Windows dump to section "Dump"
  dump: Move HMP command handlers to dump/

Paolo Bonzini (1):
  MAINTAINERS: new maintainers for QOM

 MAINTAINERS                               |   29 +-
 Makefile.objs                             |    2 +-
 Makefile.target                           |    5 +-
 cpus.c                                    |  187 ---
 dump/Makefile.objs                        |    3 +
 dump/dump-hmp-cmds.c                      |   88 ++
 dump.c =3D> dump/dump.c                     |    4 +-
 win_dump.c =3D> dump/win_dump.c             |    0
 win_dump.h =3D> dump/win_dump.h             |    0
 hw/block/xen-block.c                      |    2 +-
 hw/core/Makefile.objs                     |    4 +
 hw/core/machine-hmp-cmds.c                |  164 +++
 hw/core/machine-qmp-cmds.c                |  328 ++++++
 numa.c =3D> hw/core/numa.c                  |   64 +-
 hw/core/qdev.c                            |    2 +-
 hw/ppc/spapr_rtc.c                        |    2 +-
 hw/s390x/s390-skeys.c                     |    2 +-
 hw/timer/mc146818rtc.c                    |    4 +-
 include/hw/boards.h                       |    1 +
 hmp.h =3D> include/monitor/hmp.h            |    3 +
 include/sysemu/dump.h                     |    2 +-
 include/sysemu/hostmem.h                  |    2 +-
 include/sysemu/numa.h                     |    2 +
 monitor/hmp-cmds.c                        |  238 +---
 monitor/misc.c                            |   47 +-
 monitor/qmp-cmds.c                        |  315 +----
 qapi/Makefile.objs                        |    7 +-
 qapi/dump.json                            |  200 ++++
 qapi/{target.json =3D> machine-target.json} |  304 +----
 qapi/machine.json                         |  697 +++++++++++
 qapi/misc-target.json                     |  268 +++++
 qapi/misc.json                            | 1304 ---------------------
 qapi/qapi-schema.json                     |    7 +-
 qapi/qdev.json                            |  125 ++
 qapi/qom.json                             |  244 ++++
 qdev-monitor.c                            |    2 +-
 qom/Makefile.objs                         |    1 +
 qom/qom-hmp-cmds.c                        |   62 +
 qom/qom-qmp-cmds.c                        |  323 +++++
 target/arm/helper.c                       |    2 +-
 target/arm/monitor.c                      |    2 +-
 target/i386/cpu.c                         |    4 +-
 target/i386/monitor.c                     |    2 +-
 target/i386/sev_i386.h                    |    2 +-
 target/mips/helper.c                      |    2 +-
 target/nios2/monitor.c                    |    2 +-
 target/ppc/monitor.c                      |    2 +-
 target/ppc/translate_init.inc.c           |    2 +-
 target/s390x/cpu.c                        |    2 +-
 target/s390x/cpu_models.c                 |    2 +-
 target/s390x/sigp.c                       |    2 +-
 target/sh4/monitor.c                      |    2 +-
 target/sparc/monitor.c                    |    2 +-
 target/xtensa/monitor.c                   |    2 +-
 vl.c                                      |   45 -
 55 files changed, 2629 insertions(+), 2492 deletions(-)
 create mode 100644 dump/Makefile.objs
 create mode 100644 dump/dump-hmp-cmds.c
 rename dump.c =3D> dump/dump.c (99%)
 rename win_dump.c =3D> dump/win_dump.c (100%)
 rename win_dump.h =3D> dump/win_dump.h (100%)
 create mode 100644 hw/core/machine-hmp-cmds.c
 create mode 100644 hw/core/machine-qmp-cmds.c
 rename numa.c =3D> hw/core/numa.c (90%)
 rename hmp.h =3D> include/monitor/hmp.h (98%)
 create mode 100644 qapi/dump.json
 rename qapi/{target.json =3D> machine-target.json} (61%)
 create mode 100644 qapi/machine.json
 create mode 100644 qapi/misc-target.json
 create mode 100644 qapi/qdev.json
 create mode 100644 qapi/qom.json
 create mode 100644 qom/qom-hmp-cmds.c
 create mode 100644 qom/qom-qmp-cmds.c

--=20
2.21.0


