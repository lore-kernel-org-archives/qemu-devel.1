Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7842EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33BD82083B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eshcrZAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BD82083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1EIN-00019I-Gz
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 15:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1EHY-0000gn-0r
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 15:32:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1EHU-0004BG-5y
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 15:31:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UJQujF008177;
 Thu, 30 Jul 2020 19:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=corp-2020-01-29;
 bh=cryTOultYgHvqm2pphOTnvKqL/r6aQ7bRhG5rEqLwZc=;
 b=eshcrZAEfirFHHW8KJBorMmwyZea4vM3osD3Hc9xAnFas9ZLdGROUfKaITUum4VqbHbc
 1hmMyBwMxGJn7zgX1kO6gHTpNOuDN+8qtHmzl03KB1fap2MKtUXYfuaooOQOJiSH31Z8
 SAWANQziK1aCVySLmlnJcEDGkeyQ3MMyTEatw+f2q69/0cyZfHZLCWLlni4jBs5y7SOp
 YqnvP0BPAu+GPaD+xscosO8LAWxsUBWNOsBkk00xarz0if7rUVnsgO2+7HuEzqH/Quvr
 GmjeU8IaHXN7YhUkxR7Q80+7+U6eW0a3g/4kxpDukPMrXzA197EmdwNa9zmWo9vOiyU7 xA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 32hu1jnm4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 19:31:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UJSaP2109731;
 Thu, 30 Jul 2020 19:31:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 32hu61tq1b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 19:31:50 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UJVkdH023977;
 Thu, 30 Jul 2020 19:31:46 GMT
Received: from [10.39.200.60] (/10.39.200.60)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 12:31:45 -0700
Subject: Re: [PATCH V1 00/32] Live Update
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <20200730174910.GD2603@work-vm>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <acfecc83-5d61-039e-752b-8fa0ac505c7c@oracle.com>
Date: Thu, 30 Jul 2020 15:31:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730174910.GD2603@work-vm>
Content-Type: multipart/mixed; boundary="------------73BB0E3125855E49EA54A251"
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300134
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=steven.sistare@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 14:00:56
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------73BB0E3125855E49EA54A251
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 7/30/2020 1:49 PM, Dr. David Alan Gilbert wrote:
> * Steve Sistare (steven.sistare@oracle.com) wrote:
>> Improve and extend the qemu functions that save and restore VM state so a
>> guest may be suspended and resumed with minimal pause time.  qemu may be
>> updated to a new version in between.
> 
> Nice.
> 
>> The first set of patches adds the cprsave and cprload commands to save and
>> restore VM state, and allow the host kernel to be updated and rebooted in
>> between.  The VM must create guest RAM in a persistent shared memory file,
>> such as /dev/dax0.0 or persistant /dev/shm PKRAM as proposed in 
>> https://lore.kernel.org/lkml/1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com/
>>
>> cprsave stops the VCPUs and saves VM device state in a simple file, and
>> thus supports any type of guest image and block device.  The caller must
>> not modify the VM's block devices between cprsave and cprload.
> 
> can I ask why you don't just add a migration flag to skip the devices
> you don't want, and then do a migrate to a file?
> (i.e. migrate "exec:cat > afile")
> We already have the 'x-ignore-shared' capability that's used for doing
> RAM snapshots of VMs; primarily I think for being able to start a VM
> from a RAM snapshot as a fast VM start trick.
> (There's also a xen_save_devices that does something similar).
> If you backed the RAM as you say, enabled x-ignore-shared and then did:
> 
>    migrate "exec:cat > afile"
> 
> and restarted the destination with:
> 
>     migrate_incoming "exec:cat afile"
> 
> what is different (except the later stuff about the vfio magic and
> chardevs).
> 
> Dave

Yes, I did consider whether to extend the migration syntax and implemention in
save_vmstate and load_vmstate, versus creating something new.  Those functions 
handle stuff like bdrv snapshot, aio, and migration which are n/a for the cpr 
use case, and the cpr functions handle state that is n/a for the migration case. 
I judged that a single function handling both would be less readable and 
maintainable.  At their core all these routines call qemu_loadvm_state() and 
qemu_savevm_state().
 The surrounding code is mostly different.


Take a look at 
  savevm.c:save_vmstate()   vs   save_cpr_snapshot() attached
and
  savevm.c:load_vmstate()   vs   load_cpr_snapshot() attached

I attached the complete versions of the cpr functions because they are built up
over multiple patches in this series, thus hard to visualize in patch form.

- Steve

> 
>> cprsave and cprload support guests with vfio devices if the caller first
>> suspends the guest by issuing guest-suspend-ram to the qemu guest agent.
>> The guest drivers suspend methods flush outstanding requests and re-
>> initialize the devices, and thus there is no device state to save and
>> restore.
>>
>>    1 savevm: add vmstate handler iterators
>>    2 savevm: VM handlers mode mask
>>    3 savevm: QMP command for cprsave
>>    4 savevm: HMP Command for cprsave
>>    5 savevm: QMP command for cprload
>>    6 savevm: HMP Command for cprload
>>    7 savevm: QMP command for cprinfo
>>    8 savevm: HMP command for cprinfo
>>    9 savevm: prevent cprsave if memory is volatile
>>   10 kvmclock: restore paused KVM clock
>>   11 cpu: disable ticks when suspended
>>   12 vl: pause option
>>   13 gdbstub: gdb support for suspended state
>>
>> The next patches add a restart method that eliminates the persistent memory
>> constraint, and allows qemu to be updated across the restart, but does not
>> allow host reboot.  Anonymous memory segments used by the guest are
>> preserved across a re-exec of qemu, mapped at the same VA, via a proposed
>> madvise(MADV_DOEXEC) option in the Linux kernel.  See
>> https://lore.kernel.org/lkml/1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com/
>>
>>   14 savevm: VMS_RESTART and cprsave restart
>>   15 vl: QEMU_START_FREEZE env var
>>   16 oslib: add qemu_clr_cloexec
>>   17 util: env var helpers
>>   18 osdep: import MADV_DOEXEC
>>   19 memory: ram_block_add cosmetic changes
>>   20 vl: add helper to request re-exec
>>   21 exec, memory: exec(3) to restart
>>   22 char: qio_channel_socket_accept reuse fd
>>   23 char: save/restore chardev socket fds
>>   24 ui: save/restore vnc socket fds
>>   25 char: save/restore chardev pty fds
>>   26 monitor: save/restore QMP negotiation status
>>   27 vhost: reset vhost devices upon cprsave
>>   28 char: restore terminal on restart
>>
>> The next patches extend the restart method to save and restore vfio-pci
>> state, eliminating the requirement for a guest agent.  The vfio container,
>> group, and device descriptors are preserved across the qemu re-exec.
>>
>>   29 pci: export pci_update_mappings
>>   30 vfio-pci: save and restore
>>   31 vfio-pci: trace pci config
>>   32 vfio-pci: improved tracing
>>
>> Here is an example of updating qemu from v4.2.0 to v4.2.1 using 
>> "cprload restart".  The software update is performed while the guest is
>> running to minimize downtime.
>>
>> window 1				| window 2
>> 					|
>> # qemu-system-x86_64 ... 		|
>> QEMU 4.2.0 monitor - type 'help' ...	|
>> (qemu) info status			|
>> VM status: running			|
>> 					| # yum update qemu
>> (qemu) cprsave /tmp/qemu.sav restart	|
>> QEMU 4.2.1 monitor - type 'help' ...	|
>> (qemu) info status			|
>> VM status: paused (prelaunch)		|
>> (qemu) cprload /tmp/qemu.sav		|
>> (qemu) info status			|
>> VM status: running			|
>>
>>
>> Here is an example of updating the host kernel using "cprload reboot"
>>
>> window 1					| window 2
>> 						|
>> # qemu-system-x86_64 ...mem-path=/dev/dax0.0 ...|
>> QEMU 4.2.1 monitor - type 'help' ...		|
>> (qemu) info status				|
>> VM status: running				|
>> 						| # yum update kernel-uek
>> (qemu) cprsave /tmp/qemu.sav restart		|
>> 						|
>> # systemctl kexec				|
>> kexec_core: Starting new kernel			|
>> ...						|
>> 						|
>> # qemu-system-x86_64 ...mem-path=/dev/dax0.0 ...|
>> QEMU 4.2.1 monitor - type 'help' ...		|
>> (qemu) info status				|
>> VM status: paused (prelaunch)			|
>> (qemu) cprload /tmp/qemu.sav			|
>> (qemu) info status				|
>> VM status: running				|
>>
>>
>> Mark Kanda (5):
>>   char: qio_channel_socket_accept reuse fd
>>   char: save/restore chardev socket fds
>>   ui: save/restore vnc socket fds
>>   monitor: save/restore QMP negotiation status
>>   vhost: reset vhost devices upon cprsave
>>
>> Steve Sistare (27):
>>   savevm: add vmstate handler iterators
>>   savevm: VM handlers mode mask
>>   savevm: QMP command for cprsave
>>   savevm: HMP Command for cprsave
>>   savevm: QMP command for cprload
>>   savevm: HMP Command for cprload
>>   savevm: QMP command for cprinfo
>>   savevm: HMP command for cprinfo
>>   savevm: prevent cprsave if memory is volatile
>>   kvmclock: restore paused KVM clock
>>   cpu: disable ticks when suspended
>>   vl: pause option
>>   gdbstub: gdb support for suspended state
>>   savevm: VMS_RESTART and cprsave restart
>>   vl: QEMU_START_FREEZE env var
>>   oslib: add qemu_clr_cloexec
>>   util: env var helpers
>>   osdep: import MADV_DOEXEC
>>   memory: ram_block_add cosmetic changes
>>   vl: add helper to request re-exec
>>   exec, memory: exec(3) to restart
>>   char: save/restore chardev pty fds
>>   char: restore terminal on restart
>>   pci: export pci_update_mappings
>>   vfio-pci: save and restore
>>   vfio-pci: trace pci config
>>   vfio-pci: improved tracing
>>
>>  MAINTAINERS                    |   7 ++
>>  accel/kvm/kvm-all.c            |   8 +-
>>  accel/kvm/trace-events         |   3 +-
>>  chardev/char-pty.c             |  38 +++++--
>>  chardev/char-socket.c          |  35 ++++++
>>  chardev/char-stdio.c           |   7 ++
>>  chardev/char.c                 |  16 +++
>>  exec.c                         |  88 +++++++++++++--
>>  gdbstub.c                      |  11 +-
>>  hmp-commands.hx                |  46 ++++++++
>>  hw/i386/kvm/clock.c            |   6 +-
>>  hw/pci/msix.c                  |   1 +
>>  hw/pci/pci.c                   |  17 +--
>>  hw/pci/trace-events            |   5 +-
>>  hw/vfio/common.c               | 115 ++++++++++++++++----
>>  hw/vfio/pci.c                  | 179 ++++++++++++++++++++++++++++++-
>>  hw/vfio/platform.c             |   2 +-
>>  hw/vfio/trace-events           |  11 +-
>>  hw/virtio/vhost.c              |  12 +++
>>  include/chardev/char.h         |   8 ++
>>  include/exec/memory.h          |   4 +
>>  include/hw/pci/pci.h           |   2 +
>>  include/hw/vfio/vfio-common.h  |   4 +-
>>  include/io/channel-socket.h    |   3 +-
>>  include/migration/register.h   |   3 +
>>  include/migration/vmstate.h    |  11 ++
>>  include/monitor/hmp.h          |   3 +
>>  include/qemu/cutils.h          |   1 +
>>  include/qemu/env.h             |  31 ++++++
>>  include/qemu/osdep.h           |   8 ++
>>  include/sysemu/sysemu.h        |  10 ++
>>  io/channel-socket.c            |  12 ++-
>>  io/net-listener.c              |   4 +-
>>  migration/block.c              |   1 +
>>  migration/migration.c          |   4 +-
>>  migration/ram.c                |   1 +
>>  migration/savevm.c             | 237 ++++++++++++++++++++++++++++++++++++-----
>>  migration/savevm.h             |   4 +-
>>  monitor/hmp-cmds.c             |  28 +++++
>>  monitor/qmp-cmds.c             |  16 +++
>>  monitor/qmp.c                  |  42 ++++++++
>>  qapi/migration.json            |  35 ++++++
>>  qapi/pragma.json               |   1 +
>>  qemu-options.hx                |   9 ++
>>  scsi/qemu-pr-helper.c          |   2 +-
>>  softmmu/vl.c                   |  65 ++++++++++-
>>  tests/qtest/tpm-emu.c          |   2 +-
>>  tests/test-char.c              |   2 +-
>>  tests/test-io-channel-socket.c |   4 +-
>>  trace-events                   |   2 +
>>  ui/vnc.c                       | 153 +++++++++++++++++++++-----
>>  util/Makefile.objs             |   2 +-
>>  util/env.c                     | 132 +++++++++++++++++++++++
>>  util/oslib-posix.c             |   9 ++
>>  util/oslib-win32.c             |   4 +
>>  55 files changed, 1331 insertions(+), 135 deletions(-)
>>  create mode 100644 include/qemu/env.h
>>  create mode 100644 util/env.c
>>
>> -- 
>> 1.8.3.1
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

--------------73BB0E3125855E49EA54A251
Content-Type: text/plain; charset=UTF-8;
 name="save_cpr_snapshot.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="save_cpr_snapshot.c"

dm9pZCBzYXZlX2Nwcl9zbmFwc2hvdChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBjaGFyICpt
b2RlLCBFcnJvciAqKmVycnApCnsKICAgIGludCByZXQgPSAwOwogICAgUUVNVUZpbGUgKmY7
CiAgICBWTVN0YXRlTW9kZSBvcDsKCiAgICBpZiAoIXN0cmNtcChtb2RlLCAicmVib290Iikp
IHsKICAgICAgICBvcCA9IFZNU19SRUJPT1Q7CiAgICB9IGVsc2UgaWYgKCFzdHJjbXAobW9k
ZSwgInJlc3RhcnQiKSkgewogICAgICAgIG9wID0gVk1TX1JFU1RBUlQ7CiAgICB9IGVsc2Ug
ewogICAgICAgIGVycm9yX3NldGcoZXJycCwgImNwcnNhdmU6IGJhZCBtb2RlICVzIiwgbW9k
ZSk7CiAgICAgICAgcmV0dXJuOwogICAgfQoKICAgIGlmIChvcCA9PSBWTVNfUkVCT09UICYm
IHFlbXVfcmFtX3ZvbGF0aWxlKGVycnApKSB7CiAgICAgICAgcmV0dXJuOwogICAgfQoKICAg
IGlmIChvcCA9PSBWTVNfUkVTVEFSVCAmJiBRRU1VX01BRFZfRE9FWEVDID09IFFFTVVfTUFE
Vl9JTlZBTElEKSB7CiAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAia2VybmVsIGRvZXMgbm90
IHN1cHBvcnQgTUFEVl9ET0VYRUMuIik7CiAgICAgICAgcmV0dXJuOwogICAgfQoKICAgIGlm
IChvcCA9PSBWTVNfUkVTVEFSVCAmJiB4ZW5fZW5hYmxlZCgpKSB7CiAgICAgICAgZXJyb3Jf
c2V0ZyhlcnJwLCAieGVuIGRvZXMgbm90IHN1cHBvcnQgY3Byc2F2ZSByZXN0YXJ0Iik7CiAg
ICAgICAgcmV0dXJuOwogICAgfQoKICAgIGYgPSBxZl9maWxlX29wZW4oZmlsZSwgT19DUkVB
VCB8IE9fV1JPTkxZIHwgT19UUlVOQywgMDYwMCwgZXJycCk7CiAgICBpZiAoIWYpIHsKICAg
ICAgICByZXR1cm47CiAgICB9CgogICAgcmV0ID0gZ2xvYmFsX3N0YXRlX3N0b3JlKCk7CiAg
ICBpZiAocmV0KSB7CiAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiRXJyb3Igc2F2aW5nIGds
b2JhbCBzdGF0ZSIpOwogICAgICAgIHFlbXVfZmNsb3NlKGYpOwogICAgICAgIHJldHVybjsK
ICAgIH0KCiAgICAvKiBVcGRhdGUgdGltZXJzX3N0YXRlIGJlZm9yZSBzYXZpbmcuICBTdXNw
ZW5kIGRpZCBub3Qgc28gZG8uICovCiAgICBpZiAocnVuc3RhdGVfY2hlY2soUlVOX1NUQVRF
X1NVU1BFTkRFRCkpIHsKICAgICAgICBjcHVfZGlzYWJsZV90aWNrcygpOwogICAgfQoKICAg
IHZtX3N0b3AoUlVOX1NUQVRFX1NBVkVfVk0pOwoKICAgIHJldCA9IHFlbXVfc2F2ZXZtX3N0
YXRlKGYsIG9wLCBlcnJwKTsKICAgIGlmICgocmV0IDwgMCkgJiYgISplcnJwKSB7CiAgICAg
ICAgZXJyb3Jfc2V0ZyhlcnJwLCAicWVtdV9zYXZldm1fc3RhdGUgZmFpbGVkIik7CiAgICB9
CiAgICBxZW11X2ZjbG9zZShmKTsKCiAgICBpZiAob3AgPT0gVk1TX1JFQk9PVCkgewogICAg
ICAgIG5vX3NodXRkb3duID0gMDsKICAgICAgICBxZW11X3N5c3RlbV9zaHV0ZG93bl9yZXF1
ZXN0KCk7CiAgICB9IGVsc2UgaWYgKG9wID09IFZNU19SRVNUQVJUKSB7CiAgICAgICAgaWYg
KHFlbXVfcHJlc2VydmVfcmFtKGVycnApKSB7CiAgICAgICAgICAgIHJldHVybjsKICAgICAg
ICB9CiAgICAgICAgc2F2ZV9jaGFyZGV2X2ZkcygpOwogICAgICAgIHNhdmVfdm5jX2Zkcygp
OwogICAgICAgIHNhdmVfbmFtZWRfZmQoIm1udGZkIik7ICAgICAgICAgIC8qIHdhcyByZWNl
aXZlZCBmcm9tIHFlbXUtY3ByICovCiAgICAgICAgc2F2ZV9uYW1lZF9mZCgiY3RsZmQiKTsg
ICAgICAgICAgLyogd2FzIHJlY2VpdmVkIGZyb20gcWVtdS1jcHIgKi8KICAgICAgICB3YWxr
ZW52KEZEX1BSRUZJWCwgcHJlc2VydmVfZmQsIDApOwogICAgICAgIHJlc2V0X3Zob3N0X2Rl
dmljZXMoKTsKICAgICAgICBzYXZlX3FtcF9uZWdvdGlhdGlvbl9zdGF0dXMoKTsKICAgICAg
ICBxZW11X3Rlcm1fZXhpdCgpOwogICAgICAgIHFlbXVfc3lzdGVtX2V4ZWNfcmVxdWVzdCgp
OwogICAgICAgIHB1dGVudigoY2hhciAqKSJRRU1VX1NUQVJUX0ZSRUVaRT0iKTsKICAgIH0K
fQoK
--------------73BB0E3125855E49EA54A251
Content-Type: text/plain; charset=UTF-8;
 name="load_cpr_snapshot.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="load_cpr_snapshot.c"

dm9pZCBsb2FkX2Nwcl9zbmFwc2hvdChjb25zdCBjaGFyICpmaWxlLCBFcnJvciAqKmVycnAp
CnsKICAgIFFFTVVGaWxlICpmOwogICAgaW50IHJldDsKICAgIFJ1blN0YXRlIHN0YXRlOwoK
ICAgIGlmIChydW5zdGF0ZV9pc19ydW5uaW5nKCkpIHsKICAgICAgICBlcnJvcl9zZXRnKGVy
cnAsICJjcHJsb2FkIGNhbGxlZCBmb3IgYSBydW5uaW5nIFZNIik7CiAgICAgICAgcmV0dXJu
OwogICAgfQoKICAgIGYgPSBxZl9maWxlX29wZW4oZmlsZSwgT19SRE9OTFksIDAsIGVycnAp
OwogICAgaWYgKCFmKSB7CiAgICAgICAgcmV0dXJuOwogICAgfQoKICAgIHJldCA9IHFlbXVf
bG9hZHZtX3N0YXRlKGYsIFZNU19SRUJPT1QgfCBWTVNfUkVTVEFSVCk7CiAgICBxZW11X2Zj
bG9zZShmKTsKICAgIGlmIChyZXQgPCAwKSB7CiAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAi
RXJyb3IgJWQgd2hpbGUgbG9hZGluZyBWTSBzdGF0ZSIsIHJldCk7CiAgICAgICAgcmV0dXJu
OwogICAgfQoKICAgIHN0YXRlID0gZ2xvYmFsX3N0YXRlX2dldF9ydW5zdGF0ZSgpOwogICAg
aWYgKHN0YXRlID09IFJVTl9TVEFURV9SVU5OSU5HKSB7CiAgICAgICAgdm1fc3RhcnQoKTsK
ICAgIH0gZWxzZSB7CiAgICAgICAgcnVuc3RhdGVfc2V0KHN0YXRlKTsKICAgICAgICBpZiAo
cnVuc3RhdGVfY2hlY2soUlVOX1NUQVRFX1NVU1BFTkRFRCkpIHsKICAgICAgICAgICAgc3Rh
cnRfb25fd2FrZSA9IDE7CiAgICAgICAgfQogICAgfQoKICAgIGxvYWRfdm5jX2ZkcygpOwp9
Cgo=
--------------73BB0E3125855E49EA54A251--

