Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A19C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 15:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55FC920675
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 15:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwn7WA0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FC920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK1iB-0004jJ-I4
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 11:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jK1hG-0003tF-Jl
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 11:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jK1hE-0005lE-Lt
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 11:23:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40153
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jK1hE-0005kF-HN
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 11:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585841035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Yf5uDtW7gs2zk8Q4/GEIjjHk2+ZNQ5ozRhNnnxmSEE=;
 b=dwn7WA0Nj8fYvZlBL8D5w7tiX/Nc9kMBOzJEip+j1HX9UlbHN0roV2TYwcw++WJz0yfn05
 3g/TChuALU6UrKs/MFoHHsN5ry7xJfvoqIHFjOTlJ8Gmvb4Vf45MwrUp15RFQe30PP9gFH
 y7eAJy9w2lBj1SdVzLwSqOHD/B2xHRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-P4z3dnzqMjO5Xq8NxuXshg-1; Thu, 02 Apr 2020 11:23:53 -0400
X-MC-Unique: P4z3dnzqMjO5Xq8NxuXshg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A03118B5FA0;
 Thu,  2 Apr 2020 15:23:52 +0000 (UTC)
Received: from work-vm (ovpn-114-253.ams2.redhat.com [10.36.114.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BAE2F9B924;
 Thu,  2 Apr 2020 15:23:47 +0000 (UTC)
Date: Thu, 2 Apr 2020 16:23:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [RFC 0/5] hmp, qmp: Add some commands to introspect virtio devices
Message-ID: <20200402152345.GR2834@work-vm>
References: <20200402100302.833267-1-lvivier@redhat.com>
 <CAJ+F1CLejBjX7Q6Ttb4jh96juPdWAGx8fvc3FRVSY-TfXJcoUQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLejBjX7Q6Ttb4jh96juPdWAGx8fvc3FRVSY-TfXJcoUQ@mail.gmail.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi
>=20
> On Thu, Apr 2, 2020 at 12:03 PM Laurent Vivier <lvivier@redhat.com> wrote=
:
> >
> > This series introduces new QMP/HMP commands to dump the status
> > of a a virtio device at different levels.
>=20
> Looks nice, but my feeling is that we are growing qemu with debugging
> facilities in general with HMP/QMP.
>=20
> If this is only for debugging purposes, why don't we compile it only
> when --enable-debug?
>=20
> A guest that would need to be debugged could have its state loaded in
> a debug version of qemu.
>=20
> Alternatively, I think most of the data you provide here could
> probably be introspected via gdb scripts.
>=20
> Just some thoughts

I kind of agree, but virtio is bread-and-butter, so having it available
all the time isn't a bad idea; however having said that hte same
argument would be for why having gdb scripts to examine your virtio
queues would be useful if you're dealing with a core.

Dave

>=20
> >
> > 1. Main command
> >
> >  HMP Only:
> >
> >      virtio [subcommand]
> >
> >    Example:
> >
> >     List all sub-commands:
> >
> >     (qemu) virtio
> >     virtio query  -- List all available virtio devices
> >     virtio status path -- Display status of a given virtio device
> >     virtio queue-status path queue -- Display status of a given virtio =
queue
> >     virtio queue-element path queue [index] -- Display element of a giv=
en virtio queue
> >
> > 2. List available virtio devices in the machine
> >
> >   HMP Form:
> >
> >     virtio query
> >
> >   Example:
> >
> >     (qemu) virtio query
> >     /machine/peripheral-anon/device[3]/virtio-backend [virtio-net]
> >     /machine/peripheral-anon/device[1]/virtio-backend [virtio-serial]
> >     /machine/peripheral-anon/device[0]/virtio-backend [virtio-blk]
> >
> >   QMP Form:
> >
> >     { 'command': 'query-virtio', 'returns': ['VirtioInfo'] }
> >
> >   Example:
> >
> >   -> { "execute": "query-virtio" }
> >   <- { "return": [
> >          {
> >              "path": "/machine/peripheral-anon/device[3]/virtio-backend=
",
> >              "type": "virtio-net"
> >          },
> >          {
> >              "path": "/machine/peripheral-anon/device[1]/virtio-backend=
",
> >              "type": "virtio-serial"
> >          },
> >          {
> >              "path": "/machine/peripheral-anon/device[0]/virtio-backend=
",
> >              "type": "virtio-blk"
> >          }
> >        ]
> >      }
> >
> > 3. Display status of a given virtio device
> >
> >   HMP Form:
> >
> >     virtio status <path>
> >
> >   Example:
> >
> >     (qemu) virtio status /machine/peripheral-anon/device[3]/virtio-back=
end
> >     /machine/peripheral-anon/device[3]/virtio-backend:
> >       Device Id:        1
> >       Guest features:   0x0000000130afffa7
> >       Host features:    0x0000000179bfffe7
> >       Backend features: 0x0000000000000000
> >       Endianness:       little
> >       VirtQueues:       3
> >
> >   QMP Form:
> >
> >     { 'command': 'virtio-status',
> >       'data': { 'path': 'str' },
> >       'returns': 'VirtioStatus'
> >     }
> >
> >   Example:
> >
> >   -> { "execute": "virtio-status",
> >        "arguments": {
> >            "path": "/machine/peripheral-anon/device[3]/virtio-backend"
> >        }
> >     }
> >   <- { "return": {
> >            "backend_features": 0,
> >            "guest_features": 5111807911,
> >            "num_vqs": 3,
> >            "host_features": 6337593319,
> >            "device_endian": "little",
> >            "device_id": 1
> >        }
> >      }
> >
> > 4. Display status of a given virtio queue
> >
> >   HMP Form:
> >
> >     virtio queue-status <path> <queue>
> >
> >   Example:
> >
> >     (qemu) virtio queue-status /machine/peripheral-anon/device[3]/virti=
o-backend 0
> >     /machine/peripheral-anon/device[3]/virtio-backend:
> >       index:                0
> >       inuse:                0
> >       last_avail_idx:       61
> >       shadow_avail_idx:     292
> >       signalled_used:       61
> >       signalled_used_valid: 1
> >       VRing:
> >         num:         256
> >         num_default: 256
> >         align:       4096
> >         desc:        0x000000006c352000
> >         avail:       0x000000006c353000
> >         used:        0x000000006c353240
> >
> >   QMP Form:
> >
> >     { 'command': 'virtio-queue-status',
> >       'data': { 'path': 'str', 'queue': 'uint16' },
> >       'returns': 'VirtQueueStatus'
> >     }
> >
> >   Example:
> >
> >   -> { "execute": "virtio-queue-status",
> >        "arguments": {
> >            "path": "/machine/peripheral-anon/device[3]/virtio-backend",
> >            "queue": 0
> >        }
> >     }
> >   <- { "return": {
> >        "signalled_used": 373,
> >        "inuse": 0,
> >        "vring_desc": 864411648,
> >        "vring_num_default": 256,
> >        "signalled_used_valid": 1,
> >        "vring_avail": 864415744,
> >        "last_avail_idx": 373,
> >        "queue_index": 0,
> >        "vring_used": 864416320,
> >        "shadow_avail_idx": 619,
> >        "used_idx": 373,
> >        "vring_num": 256,
> >        "vring_align": 4096
> >        }
> >      }
> >
> > 5. Display element of a given virtio queue
> >
> >   HMP Form:
> >
> >     virtio queue-element <path> <queue> [index]
> >
> >   Example:
> >
> >     Dump the information of the head element of the first queue of
> >     the first virtio device::
> >
> >       (qemu) virtio queue-element/machine/peripheral-anon/device[3]/vir=
tio-backend 0
> >       index:  67
> >       ndescs: 1
> >       descs:  addr 0x6fe69800 len 1536 (write-only)
> >
> >       (qemu) xp/128bx 0x6fe69800
> >       000000006fe69800: 0x02 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> >       000000006fe69808: 0x00 0x00 0x01 0x00 0x52 0x54 0x00 0x12
> >       000000006fe69810: 0x34 0x56 0x52 0x54 0x00 0x09 0x51 0xde
> >       000000006fe69818: 0x08 0x00 0x45 0x00 0x00 0x4c 0x8f 0x32
> >
> >     device[3] is a virtio-net device and we can see in the element buff=
er the
> >     MAC address of the card::
> >
> >       [root@localhost ~]# ip link show ens4
> >       2: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_code=
l state UP m0
> >           link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
> >
> >     and the MAC address of the gateway::
> >
> >       [root@localhost ~]# arp -a
> >       _gateway (192.168.122.1) at 52:54:00:09:51:de [ether] on ens4
> >
> >   QMP Form:
> >
> >     { 'command': 'virtio-queue-element',
> >       'data': { 'path': 'str', 'queue': 'uint16', '*index': 'uint16' },
> >       'returns': 'VirtioQueueElement'
> >     }
> >
> >   Example:
> >
> >   -> { "execute": "virtio-queue-element",
> >        "arguments": {
> >            "path": "/machine/peripheral-anon/device[3]/virtio-backend",
> >            "queue": 0
> >        }
> >     }
> >   -> { "return": {
> >           "index": 109,
> >           "len": 0,
> >           "ndescs": 1,
> >           "descs": [
> >               { "flags": 2, "len": 2048, "addr": 853145600 }
> >           ]
> >        }
> >     }
> >
> > Laurent Vivier (5):
> >   qmp: add QMP command query-virtio
> >   qmp: add QMP command virtio-status
> >   qmp: add QMP command virtio-queue-status
> >   qmp: add QMP command virtio-queue-element
> >   hmp: add virtio commands
> >
> >  Makefile                   |   2 +-
> >  Makefile.target            |   7 +-
> >  docs/system/monitor.rst    |   2 +
> >  hmp-commands-virtio.hx     | 148 ++++++++++++++++++
> >  hmp-commands.hx            |  10 ++
> >  hw/virtio/Makefile.objs    |   2 +
> >  hw/virtio/virtio-stub.c    |  32 ++++
> >  hw/virtio/virtio.c         | 313 +++++++++++++++++++++++++++++++++++++
> >  include/hw/virtio/virtio.h |   1 +
> >  include/monitor/hmp.h      |   4 +
> >  monitor/misc.c             |  17 ++
> >  qapi/Makefile.objs         |   2 +-
> >  qapi/qapi-schema.json      |   1 +
> >  qapi/virtio.json           | 302 +++++++++++++++++++++++++++++++++++
> >  tests/qtest/qmp-cmd-test.c |   1 +
> >  15 files changed, 840 insertions(+), 4 deletions(-)
> >  create mode 100644 hmp-commands-virtio.hx
> >  create mode 100644 hw/virtio/virtio-stub.c
> >  create mode 100644 qapi/virtio.json
> >
> > --
> > 2.25.1
> >
> >
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


