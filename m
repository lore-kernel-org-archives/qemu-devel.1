Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280A4C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFABA2073A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2zsuSC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFABA2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWgxI-0000vK-VY
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 09:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jWgt7-0003Qb-Fa
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:48:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27589
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jWgt5-0002pg-7x
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588859309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bm434Sx8fMyA8/6E2+2m2ygOFIlCsDp5bXTvEQyeQa0=;
 b=c2zsuSC73Uz3b6jglEUa28KVF4vQkHwVYYROTgB2PA3e1C4HMD52pu4FWoZX/5szbf7Z1n
 FS2vnlSpw5r9JcmQS0dCJAxyq5mzODTLo3KpsvPZMwdQOe3Vqb79h+vZhjHlP0IixHCP9P
 RNnqur4XLpibgtxfXzCg5rd8xx4sED8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-j3XifsDtNZGn9WqltWnhCA-1; Thu, 07 May 2020 09:48:26 -0400
X-MC-Unique: j3XifsDtNZGn9WqltWnhCA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49DBFEC1B3;
 Thu,  7 May 2020 13:48:25 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-114-199.ams2.redhat.com
 [10.36.114.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0CD510013BD;
 Thu,  7 May 2020 13:48:01 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: lvivier@redhat.com,
	qemu-devel@nongnu.org
Subject: [RFC v4 0/6] hmp,qmp: Add some commands to introspect virtio devices
Date: Thu,  7 May 2020 15:47:54 +0200
Message-Id: <20200507134800.10837-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Amit Shah <amit@kernel.org>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series introduces new QMP/HMP commands to dump the status=0D
of a a virtio device at different levels.=0D
=0D
1. Main command=0D
=0D
 HMP Only:=0D
=0D
     x-debug-virtio [subcommand]=0D
=0D
   Example:=0D
=0D
    List all sub-commands:=0D
=0D
    (qemu) x-debug-virtio=0D
    x-debug-virtio query  -- List all available virtio devices=0D
    x-debug-virtio status path -- Display status of a given virtio device=
=0D
    x-debug-virtio queue-status path queue -- Display status of a given vir=
tio queue=0D
    x-debug-virtio queue-element path queue [index] -- Display element of a=
 given virtio queue=0D
=0D
2. List available virtio devices in the machine=0D
=0D
  HMP Form:=0D
=0D
    x-debug-virtio query=0D
=0D
  Example:=0D
=0D
    (qemu) x-debug-virtio query=0D
    /machine/peripheral-anon/device[3]/virtio-backend [virtio-net]=0D
    /machine/peripheral-anon/device[1]/virtio-backend [virtio-serial]=0D
    /machine/peripheral-anon/device[0]/virtio-backend [virtio-blk]=0D
=0D
  QMP Form:=0D
=0D
    { 'command': 'x-debug-query-virtio', 'returns': ['VirtioInfo'] }=0D
=0D
  Example:=0D
=0D
  -> { "execute": "x-debug-query-virtio" }=0D
  <- { "return": [=0D
         {=0D
             "path": "/machine/peripheral-anon/device[3]/virtio-backend",=
=0D
             "type": "virtio-net"=0D
         },=0D
         {=0D
             "path": "/machine/peripheral-anon/device[1]/virtio-backend",=
=0D
             "type": "virtio-serial"=0D
         },=0D
         {=0D
             "path": "/machine/peripheral-anon/device[0]/virtio-backend",=
=0D
             "type": "virtio-blk"=0D
         }=0D
       ]=0D
     }=0D
=0D
3. Display status of a given virtio device=0D
=0D
  HMP Form:=0D
=0D
    x-debug-virtio status <path>=0D
=0D
  Example:=0D
=0D
    (qemu) x-debug-virtio status /machine/peripheral-anon/device[3]/virtio-=
backend=0D
    /machine/peripheral-anon/device[3]/virtio-backend:=0D
      Device Id:        1=0D
      Guest features:   event-idx, indirect-desc, version-1=0D
                        ctrl-mac-addr, guest-announce, ctrl-vlan, ctrl-rx, =
ctrl-vq, status, mrg-rxbuf, host-ufo, host-ecn, host-tso6, host-tso4, guest=
-ufo, guest-ecn, guest-tso6, guest-tso4, mac, ctrl-guest-offloads, guest-cs=
um, csum=0D
      Host features:    event-idx, indirect-desc, bad-feature, version-1, a=
ny-layout, notify-on-empty=0D
                        gso, ctrl-mac-addr, guest-announce, ctrl-rx-extra, =
ctrl-vlan, ctrl-rx, ctrl-vq, status, mrg-rxbuf, host-ufo, host-ecn, host-ts=
o6, host-tso4, guest-ufo, guest-ecn, guest-tso6, guest-tso4, mac, ctrl-gues=
t-offloads, guest-csum, csum=0D
      Backend features:=0D
      Endianness:       little=0D
      VirtQueues:       3=0D
=0D
  QMP Form:=0D
=0D
    { 'command': 'x-debug-virtio-status',=0D
      'data': { 'path': 'str' },=0D
      'returns': 'VirtioStatus'=0D
    }=0D
=0D
  Example:=0D
=0D
  -> { "execute": "x-debug-virtio-status",=0D
       "arguments": {=0D
           "path": "/machine/peripheral-anon/device[3]/virtio-backend"=0D
       }=0D
    }=0D
  <- { "return": {=0D
       "device-endian": "little",=0D
       "device-id": 1,=0D
       "backend-features": {=0D
         "device": {=0D
           "type": "virtio-net",=0D
           "data": []=0D
         },=0D
         "unknown": 0,=0D
         "transport": []=0D
       },=0D
       "num-vqs": 3,=0D
       "guest-features": {=0D
         "device": {=0D
           "type": "virtio-net",=0D
           "data": [ "ctrl-mac-addr", "guest-announce", "ctrl-vlan", "ctrl-=
rx",=0D
                     "ctrl-vq", "status", "mrg-rxbuf", "host-ufo", "host-ec=
n",=0D
                     "host-tso6", "host-tso4", "guest-ufo", "guest-ecn",=0D
                     "guest-tso6", "guest-tso4", "mac", "ctrl-guest-offload=
s",=0D
                     "guest-csum", "csum" ]=0D
         },=0D
         "unknown": 0,=0D
         "transport": [ "event-idx", "indirect-desc", "version-1" ]=0D
       },=0D
       "host-features": {=0D
         "device": {=0D
           "type": "virtio-net",=0D
           "data": [ "gso", "ctrl-mac-addr", "guest-announce", "ctrl-rx-ext=
ra",=0D
                     "ctrl-vlan", "ctrl-rx", "ctrl-vq", "status", "mrg-rxbu=
f",=0D
                     "host-ufo", "host-ecn", "host-tso6", "host-tso4",=0D
                     "guest-ufo", "guest-ecn", "guest-tso6", "guest-tso4",=
=0D
                     "mac", "ctrl-guest-offloads", "guest-csum", "csum" ]=
=0D
           },=0D
           "unknown": 0,=0D
           "transport": [ "event-idx", "indirect-desc", "bad-feature",=0D
                          "version-1", "any-layout", "notify-on-empty" ]=0D
         }=0D
       }=0D
     }=0D
=0D
4. Display status of a given virtio queue=0D
=0D
  HMP Form:=0D
=0D
    x-debug-virtio queue-status <path> <queue>=0D
=0D
  Example:=0D
=0D
    (qemu) x-debug-virtio queue-status /machine/peripheral-anon/device[3]/v=
irtio-backend 0=0D
    /machine/peripheral-anon/device[3]/virtio-backend:=0D
      index:                0=0D
      inuse:                0=0D
      last_avail_idx:       61=0D
      shadow_avail_idx:     292=0D
      signalled_used:       61=0D
      signalled_used_valid: 1=0D
      VRing:=0D
        num:         256=0D
        num_default: 256=0D
        align:       4096=0D
        desc:        0x000000006c352000=0D
        avail:       0x000000006c353000=0D
        used:        0x000000006c353240=0D
=0D
  QMP Form:=0D
=0D
    { 'command': 'x-debug-virtio-queue-status',=0D
      'data': { 'path': 'str', 'queue': 'uint16' },=0D
      'returns': 'VirtQueueStatus'=0D
    }=0D
=0D
  Example:=0D
=0D
  -> { "execute": "x-debug-virtio-queue-status",=0D
       "arguments": {=0D
           "path": "/machine/peripheral-anon/device[3]/virtio-backend",=0D
           "queue": 0=0D
       }=0D
    }=0D
  <- { "return": {=0D
       "signalled_used": 373,=0D
       "inuse": 0,=0D
       "vring_desc": 864411648,=0D
       "vring_num_default": 256,=0D
       "signalled_used_valid": 1,=0D
       "vring_avail": 864415744,=0D
       "last_avail_idx": 373,=0D
       "queue_index": 0,=0D
       "vring_used": 864416320,=0D
       "shadow_avail_idx": 619,=0D
       "used_idx": 373,=0D
       "vring_num": 256,=0D
       "vring_align": 4096=0D
       }=0D
     }=0D
=0D
5. Display element of a given virtio queue=0D
=0D
  HMP Form:=0D
=0D
    x-debug-virtio queue-element <path> <queue> [index]=0D
=0D
  Example:=0D
=0D
    Dump the information of the head element of the first queue of=0D
    the first virtio device::=0D
=0D
      (qemu) x-debug-virtio queue-element/machine/peripheral-anon/device[3]=
/virtio-backend 0=0D
      index:  67=0D
      ndescs: 1=0D
      descs:  addr 0x6fe69800 len 1536 (write)=0D
=0D
      (qemu) xp/128bx 0x6fe69800=0D
      000000006fe69800: 0x02 0x00 0x00 0x00 0x00 0x00 0x00 0x00=0D
      000000006fe69808: 0x00 0x00 0x01 0x00 0x52 0x54 0x00 0x12=0D
      000000006fe69810: 0x34 0x56 0x52 0x54 0x00 0x09 0x51 0xde=0D
      000000006fe69818: 0x08 0x00 0x45 0x00 0x00 0x4c 0x8f 0x32=0D
=0D
    device[3] is a virtio-net device and we can see in the element buffer t=
he=0D
    MAC address of the card::=0D
=0D
      [root@localhost ~]# ip link show ens4=0D
      2: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel st=
ate UP m0=0D
          link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff=0D
=0D
    and the MAC address of the gateway::=0D
=0D
      [root@localhost ~]# arp -a=0D
      _gateway (192.168.122.1) at 52:54:00:09:51:de [ether] on ens4=0D
=0D
  QMP Form:=0D
=0D
    { 'command': 'x-debug-virtio-queue-element',=0D
      'data': { 'path': 'str', 'queue': 'uint16', '*index': 'uint16' },=0D
      'returns': 'VirtioQueueElement'=0D
    }=0D
=0D
  Example:=0D
=0D
  -> { "execute": "x-debug-virtio-queue-element",=0D
       "arguments": {=0D
           "path": "/machine/peripheral-anon/device[3]/virtio-backend",=0D
           "queue": 0=0D
       }=0D
    }=0D
  -> { "return": {=0D
          "index": 109,=0D
          "ndescs": 1,=0D
          "descs": [=0D
              { "flags": [ "write" ], "len": 1536, "addr": 853145600 }=0D
          ]=0D
       }=0D
    }=0D
=0D
v4: re-send series as v3 didn't reach qemu-devel=0D
=0D
v3: use qapi_free_VirtioInfoList() on the head of the list, not on the tail=
=0D
    prefix the commands with x-debug-=0D
=0D
v2: introduce VirtioType enum=0D
    use an enum for the endianness=0D
    change field names to stick to naming conventions (s/_/-/)=0D
    add a patch to decode feature bits=0D
    don't check if the queue is empty to allow to displa old elements=0D
    use enum for desc flags=0D
    manage indirect desc=0D
    decode device features in the HMP command=0D
=0D
Laurent Vivier (6):=0D
  qmp: add QMP command x-debug-query-virtio=0D
  qmp: add QMP command x-debug-virtio-status=0D
  qmp: decode feature bits in virtio-status=0D
  qmp: add QMP command x-debug-virtio-queue-status=0D
  qmp: add QMP command x-debug-virtio-queue-element=0D
  hmp: add x-debug-virtio commands=0D
=0D
 Makefile                     |   2 +-=0D
 Makefile.target              |   7 +-=0D
 docs/system/monitor.rst      |   2 +=0D
 hmp-commands-virtio.hx       | 160 +++++++++++=0D
 hmp-commands.hx              |  10 +=0D
 hw/block/virtio-blk.c        |  23 ++=0D
 hw/char/virtio-serial-bus.c  |  11 +=0D
 hw/display/virtio-gpu-base.c |  10 +=0D
 hw/net/virtio-net.c          |  35 +++=0D
 hw/scsi/virtio-scsi.c        |  12 +=0D
 hw/virtio/Makefile.objs      |   2 +=0D
 hw/virtio/virtio-balloon.c   |  13 +=0D
 hw/virtio/virtio-iommu.c     |  14 +=0D
 hw/virtio/virtio-stub.c      |  34 +++=0D
 hw/virtio/virtio.c           | 542 +++++++++++++++++++++++++++++++++++=0D
 include/hw/virtio/virtio.h   |  14 +=0D
 include/monitor/hmp.h        |   4 +=0D
 monitor/misc.c               |  17 ++=0D
 qapi/Makefile.objs           |   2 +-=0D
 qapi/qapi-schema.json        |   1 +=0D
 qapi/virtio.json             | 502 ++++++++++++++++++++++++++++++++=0D
 tests/qtest/qmp-cmd-test.c   |   1 +=0D
 22 files changed, 1414 insertions(+), 4 deletions(-)=0D
 create mode 100644 hmp-commands-virtio.hx=0D
 create mode 100644 hw/virtio/virtio-stub.c=0D
 create mode 100644 qapi/virtio.json=0D
=0D
--=20=0D
2.26.2=0D
=0D


