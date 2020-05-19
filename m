Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AF6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:33:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB3920709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB3920709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaxgR-0003Iq-Be
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 04:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao3.xu@intel.com>) id 1jaxft-0002sl-9A
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:32:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:7176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao3.xu@intel.com>) id 1jaxfr-0007zq-DS
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:32:32 -0400
IronPort-SDR: Ng56xWAm8NzbGxJvjMhE1nv03yR5Nyo1ADXzl3TaWWhDIcM/INMI+CaMbZD78DdAtCK8bQ8Ehj
 zlcYcHv/OwDQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2020 01:32:22 -0700
IronPort-SDR: sXJd1/MU1hKge6q84Dg59inC1QJd+9/W1OKj9BnDARxnKCOXi2o/j1OoLDm8/9Y7bNLe/QXZQC
 s8zOlQdxFfcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; d="scan'208";a="343073291"
Received: from shzintpr01.sh.intel.com (HELO [0.0.0.0]) ([10.239.4.80])
 by orsmga001.jf.intel.com with ESMTP; 19 May 2020 01:32:20 -0700
From: Tao Xu <tao3.xu@intel.com>
Subject: Migration with ``drive-mirror`` + NBD will let quorum qcow2 image
 become larger
To: Alberto Garcia <berto@igalia.com>, Zhang Chen <chen.zhang@intel.com>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <3b1bbe79-088c-2e65-178f-074ac0f72ec6@intel.com>
Date: Tue, 19 May 2020 16:32:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.93; envelope-from=tao3.xu@intel.com;
 helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 04:32:22
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, RCVD_ILLEGAL_IP=1.3,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I am using ``drive-mirror`` + NBD for live storage migration. But I find 
that if I use a qcow2 image(virtual size: 10 GiB, disk size: 1.8 GiB) as 
a child of quorum, then the destination image become larger(virtual 
size: 10 GiB, disk size: 10 GiB). However if I use a qcow2 image 
directly, then the destination image(virtual size: 10 GiB, disk size: 
1.8 GiB) will be equal to the source.

So I am wondering if my usage is wrong or it is expected with 
quorum+drive-mirror?

P.S. Detail:

1) [On *destination* Host]: qemu-img create -f qcow2 fedora32.qcow2 10G
Formatting 'fedora32.qcow2', fmt=qcow2 size=10737418240 
cluster_size=65536 lazy_refcounts=off refcount_bits=16

qemu-img info fedora32.qcow2
image: fedora32.qcow2
file format: qcow2
virtual size: 10 GiB (10737418240 bytes)
disk size: 196 KiB
cluster_size: 65536
Format specific information:
     compat: 1.1
     lazy refcounts: false
     refcount bits: 16
     corrupt: false

Boot the QEMU using:

disk_path=fedora32.qcow2
net_param="-netdev 
tap,id=hn0,vhost=off,br=br0,helper=/usr/local/libexec/qemu-bridge-helper 
-device rtl8139,id=e0,netdev=hn0"
cmdline="qemu-system-x86_64 \
-enable-kvm \
-m 2G -smp 4 -qmp stdio -bios OVMF.fd \
-monitor telnet:127.0.0.1:4444,nowait,server -vnc :7 -rtc base=utc \
-cpu host -device cirrus-vga,id=video0,bus=pci.0,addr=0x2 \
-device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 \
-device usb-tablet,id=input0,bus=usb.0,port=1 $net_param \
-drive if=none,id=parent0,file.filename=$disk_path,driver=qcow2 \
-incoming tcp:0:8888"
exec $cmdline

[On *destination* QEMU]:
{'execute':'qmp_capabilities'}
{'execute': 'nbd-server-start', 'arguments': {'addr': {'type': 'inet', 
'data': {'host': '192.168.0.33', 'port': '8889'} } } }
{'execute': 'nbd-server-add', 'arguments': {'device': 'parent0', 
'writable': true } }

2) [On *source* Host]:

Boot the QEMU using:

disk_path=fedora32.qcow2
net_param="-netdev 
tap,id=hn0,vhost=off,br=br0,helper=/usr/local/libexec/qemu-bridge-helper 
-device rtl8139,id=e0,netdev=hn0"
cmdline="qemu-system-x86_64 \
-enable-kvm \
-m 2G -smp 4 -qmp stdio -bios OVMF.fd \
-monitor telnet:127.0.0.1:4444,nowait,server -vnc :7 -rtc base=utc \
-cpu host -device cirrus-vga,id=video0,bus=pci.0,addr=0x2 \
-device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 \
-device usb-tablet,id=input0,bus=usb.0,port=1 $net_param \
-drive 
if=virtio,id=colo-disk0,driver=quorum,vote-threshold=1,children.0.file.filename=$disk_path,children.0.driver=qcow2"
exec $cmdline

[On *source* QEMU]:

{'execute':'qmp_capabilities'}
{'execute': 'drive-mirror', 'arguments':{ 'device': 'colo-disk0', 
'job-id': 'resync', 'target': 'nbd://192.168.0.33:8889/parent0', 'mode': 
'existing', 'format': 'nbd', 'sync': 'full'} }

{"timestamp": {"seconds": 1589902560, "microseconds": 107418}, "event": 
"JOB_STATUS_CHANGE", "data": {"status": "created", "id": "resync"}}
{"timestamp": {"seconds": 1589902560, "microseconds": 107487}, "event": 
"JOB_STATUS_CHANGE", "data": {"status": "running", "id": "resync"}}
{"return": {}}
{"timestamp": {"seconds": 1589902721, "microseconds": 439095}, "event": 
"JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "resync"}}
{"timestamp": {"seconds": 1589902721, "microseconds": 439194}, "event": 
"BLOCK_JOB_READY", "data": {"device": "resync", "len": 10739253248, 
"offset": 10739253248, "speed": 0, "type": "mirror"}}

3)[On *destination* Host]:
qemu-img info fedora32.qcow2
image: fedora32.qcow2
file format: qcow2
virtual size: 10 GiB (10737418240 bytes)
disk size: 10 GiB
cluster_size: 65536
Format specific information:
     compat: 1.1
     lazy refcounts: false
     refcount bits: 16
     corrupt: false
4)But if [On *source* Host] boot qemu using:

disk_path=fedora32.qcow2
net_param="-netdev 
tap,id=hn0,vhost=off,br=br0,helper=/usr/local/libexec/qemu-bridge-helper 
-device rtl8139,id=e0,netdev=hn0"
cmdline="qemu-system-x86_64 \
-enable-kvm \
-m 2G -smp 4 -qmp stdio -bios OVMF.fd \
-monitor telnet:127.0.0.1:4444,nowait,server -vnc :7 -rtc base=utc \
-cpu host -device cirrus-vga,id=video0,bus=pci.0,addr=0x2 \
-device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 \
-device usb-tablet,id=input0,bus=usb.0,port=1 $net_param \
-drive if=virtio,id=parent0,file.filename=$disk_path,driver=qcow2"
exec $cmdline

Then [On *destination* Host]:

qemu-img info fedora32.qcow2
image: fedora32.qcow2
file format: qcow2
virtual size: 10 GiB (10737418240 bytes)
disk size: 1.8 GiB
cluster_size: 65536
Format specific information:
     compat: 1.1
     lazy refcounts: false
     refcount bits: 16
     corrupt: false

