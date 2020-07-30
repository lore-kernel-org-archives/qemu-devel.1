Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7F9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:42:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D8520838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wbnwoCp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D8520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Ahg-0004Ea-N8
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1Ad9-00074r-4i
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1Ad6-00024e-Py
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXQsH007512;
 Thu, 30 Jul 2020 15:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=sNMMA9cIERl8NT3gfsUyrYfWvtpuiyyK5Abgvz03fGY=;
 b=wbnwoCp/D9ZYWWiAUtBZsww3BskBY8+SZrH/Tpk8267ov8r0Ys5GHh4LUgoWcQsqC/SI
 NGckGsRHLtjV1ihvxV/Xssh/b7l+5z+wxGp7JQ9+2N1QxZoi/EquuYGJXT+Sm7V74k/C
 q284HD0AzUDGAoN2rb/L31N9GX85C19/sQsiUQNb0nCc8tSKyKyXbts9gSmB8hrFT+7m
 kfHWotd5PMXHQqvjTelhwkgap9uZEK23L7+oHweHAyz4w36e/jFWC8NBYRycue6Cg3wZ
 p8E1N/gtg+4ZJ/aqUF91NT0EhEIznU9wRye4r7Ed7xdA9ErhbYMd9kXj3WaVVyT0AmvY zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 32hu1jmfd4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:37:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFWZeI176178;
 Thu, 30 Jul 2020 15:37:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 32hu61a0uy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:37:54 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UFbq2u001703;
 Thu, 30 Jul 2020 15:37:53 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:37:51 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 00/32] Live Update
Date: Thu, 30 Jul 2020 08:14:04 -0700
Message-Id: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1011
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=steven.sistare@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 11:37:58
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Improve and extend the qemu functions that save and restore VM state so a
guest may be suspended and resumed with minimal pause time.  qemu may be
updated to a new version in between.

The first set of patches adds the cprsave and cprload commands to save and
restore VM state, and allow the host kernel to be updated and rebooted in
between.  The VM must create guest RAM in a persistent shared memory file,
such as /dev/dax0.0 or persistant /dev/shm PKRAM as proposed in 
https://lore.kernel.org/lkml/1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com/

cprsave stops the VCPUs and saves VM device state in a simple file, and
thus supports any type of guest image and block device.  The caller must
not modify the VM's block devices between cprsave and cprload.

cprsave and cprload support guests with vfio devices if the caller first
suspends the guest by issuing guest-suspend-ram to the qemu guest agent.
The guest drivers suspend methods flush outstanding requests and re-
initialize the devices, and thus there is no device state to save and
restore.

   1 savevm: add vmstate handler iterators
   2 savevm: VM handlers mode mask
   3 savevm: QMP command for cprsave
   4 savevm: HMP Command for cprsave
   5 savevm: QMP command for cprload
   6 savevm: HMP Command for cprload
   7 savevm: QMP command for cprinfo
   8 savevm: HMP command for cprinfo
   9 savevm: prevent cprsave if memory is volatile
  10 kvmclock: restore paused KVM clock
  11 cpu: disable ticks when suspended
  12 vl: pause option
  13 gdbstub: gdb support for suspended state

The next patches add a restart method that eliminates the persistent memory
constraint, and allows qemu to be updated across the restart, but does not
allow host reboot.  Anonymous memory segments used by the guest are
preserved across a re-exec of qemu, mapped at the same VA, via a proposed
madvise(MADV_DOEXEC) option in the Linux kernel.  See
https://lore.kernel.org/lkml/1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com/

  14 savevm: VMS_RESTART and cprsave restart
  15 vl: QEMU_START_FREEZE env var
  16 oslib: add qemu_clr_cloexec
  17 util: env var helpers
  18 osdep: import MADV_DOEXEC
  19 memory: ram_block_add cosmetic changes
  20 vl: add helper to request re-exec
  21 exec, memory: exec(3) to restart
  22 char: qio_channel_socket_accept reuse fd
  23 char: save/restore chardev socket fds
  24 ui: save/restore vnc socket fds
  25 char: save/restore chardev pty fds
  26 monitor: save/restore QMP negotiation status
  27 vhost: reset vhost devices upon cprsave
  28 char: restore terminal on restart

The next patches extend the restart method to save and restore vfio-pci
state, eliminating the requirement for a guest agent.  The vfio container,
group, and device descriptors are preserved across the qemu re-exec.

  29 pci: export pci_update_mappings
  30 vfio-pci: save and restore
  31 vfio-pci: trace pci config
  32 vfio-pci: improved tracing

Here is an example of updating qemu from v4.2.0 to v4.2.1 using 
"cprload restart".  The software update is performed while the guest is
running to minimize downtime.

window 1				| window 2
					|
# qemu-system-x86_64 ... 		|
QEMU 4.2.0 monitor - type 'help' ...	|
(qemu) info status			|
VM status: running			|
					| # yum update qemu
(qemu) cprsave /tmp/qemu.sav restart	|
QEMU 4.2.1 monitor - type 'help' ...	|
(qemu) info status			|
VM status: paused (prelaunch)		|
(qemu) cprload /tmp/qemu.sav		|
(qemu) info status			|
VM status: running			|


Here is an example of updating the host kernel using "cprload reboot"

window 1					| window 2
						|
# qemu-system-x86_64 ...mem-path=/dev/dax0.0 ...|
QEMU 4.2.1 monitor - type 'help' ...		|
(qemu) info status				|
VM status: running				|
						| # yum update kernel-uek
(qemu) cprsave /tmp/qemu.sav restart		|
						|
# systemctl kexec				|
kexec_core: Starting new kernel			|
...						|
						|
# qemu-system-x86_64 ...mem-path=/dev/dax0.0 ...|
QEMU 4.2.1 monitor - type 'help' ...		|
(qemu) info status				|
VM status: paused (prelaunch)			|
(qemu) cprload /tmp/qemu.sav			|
(qemu) info status				|
VM status: running				|


Mark Kanda (5):
  char: qio_channel_socket_accept reuse fd
  char: save/restore chardev socket fds
  ui: save/restore vnc socket fds
  monitor: save/restore QMP negotiation status
  vhost: reset vhost devices upon cprsave

Steve Sistare (27):
  savevm: add vmstate handler iterators
  savevm: VM handlers mode mask
  savevm: QMP command for cprsave
  savevm: HMP Command for cprsave
  savevm: QMP command for cprload
  savevm: HMP Command for cprload
  savevm: QMP command for cprinfo
  savevm: HMP command for cprinfo
  savevm: prevent cprsave if memory is volatile
  kvmclock: restore paused KVM clock
  cpu: disable ticks when suspended
  vl: pause option
  gdbstub: gdb support for suspended state
  savevm: VMS_RESTART and cprsave restart
  vl: QEMU_START_FREEZE env var
  oslib: add qemu_clr_cloexec
  util: env var helpers
  osdep: import MADV_DOEXEC
  memory: ram_block_add cosmetic changes
  vl: add helper to request re-exec
  exec, memory: exec(3) to restart
  char: save/restore chardev pty fds
  char: restore terminal on restart
  pci: export pci_update_mappings
  vfio-pci: save and restore
  vfio-pci: trace pci config
  vfio-pci: improved tracing

 MAINTAINERS                    |   7 ++
 accel/kvm/kvm-all.c            |   8 +-
 accel/kvm/trace-events         |   3 +-
 chardev/char-pty.c             |  38 +++++--
 chardev/char-socket.c          |  35 ++++++
 chardev/char-stdio.c           |   7 ++
 chardev/char.c                 |  16 +++
 exec.c                         |  88 +++++++++++++--
 gdbstub.c                      |  11 +-
 hmp-commands.hx                |  46 ++++++++
 hw/i386/kvm/clock.c            |   6 +-
 hw/pci/msix.c                  |   1 +
 hw/pci/pci.c                   |  17 +--
 hw/pci/trace-events            |   5 +-
 hw/vfio/common.c               | 115 ++++++++++++++++----
 hw/vfio/pci.c                  | 179 ++++++++++++++++++++++++++++++-
 hw/vfio/platform.c             |   2 +-
 hw/vfio/trace-events           |  11 +-
 hw/virtio/vhost.c              |  12 +++
 include/chardev/char.h         |   8 ++
 include/exec/memory.h          |   4 +
 include/hw/pci/pci.h           |   2 +
 include/hw/vfio/vfio-common.h  |   4 +-
 include/io/channel-socket.h    |   3 +-
 include/migration/register.h   |   3 +
 include/migration/vmstate.h    |  11 ++
 include/monitor/hmp.h          |   3 +
 include/qemu/cutils.h          |   1 +
 include/qemu/env.h             |  31 ++++++
 include/qemu/osdep.h           |   8 ++
 include/sysemu/sysemu.h        |  10 ++
 io/channel-socket.c            |  12 ++-
 io/net-listener.c              |   4 +-
 migration/block.c              |   1 +
 migration/migration.c          |   4 +-
 migration/ram.c                |   1 +
 migration/savevm.c             | 237 ++++++++++++++++++++++++++++++++++++-----
 migration/savevm.h             |   4 +-
 monitor/hmp-cmds.c             |  28 +++++
 monitor/qmp-cmds.c             |  16 +++
 monitor/qmp.c                  |  42 ++++++++
 qapi/migration.json            |  35 ++++++
 qapi/pragma.json               |   1 +
 qemu-options.hx                |   9 ++
 scsi/qemu-pr-helper.c          |   2 +-
 softmmu/vl.c                   |  65 ++++++++++-
 tests/qtest/tpm-emu.c          |   2 +-
 tests/test-char.c              |   2 +-
 tests/test-io-channel-socket.c |   4 +-
 trace-events                   |   2 +
 ui/vnc.c                       | 153 +++++++++++++++++++++-----
 util/Makefile.objs             |   2 +-
 util/env.c                     | 132 +++++++++++++++++++++++
 util/oslib-posix.c             |   9 ++
 util/oslib-win32.c             |   4 +
 55 files changed, 1331 insertions(+), 135 deletions(-)
 create mode 100644 include/qemu/env.h
 create mode 100644 util/env.c

-- 
1.8.3.1


