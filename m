Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B966C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 02:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467E220844
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 02:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467E220844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56611 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxifz-0005Xy-BQ
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 22:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1hxicd-0001MV-HJ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 22:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hxicb-0005Ko-LA
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 22:02:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hxicb-0005KE-7X
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 22:02:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 89A0085360
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 02:02:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-78.ams2.redhat.com
 [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5A1C7AB49;
 Wed, 14 Aug 2019 02:02:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 04:02:18 +0200
Message-Id: <20190814020218.1868-7-quintela@redhat.com>
In-Reply-To: <20190814020218.1868-1-quintela@redhat.com>
References: <20190814020218.1868-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 14 Aug 2019 02:02:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 6/6] RFH: We lost "connect" events
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we have lots of channels, sometimes multifd migration fails
with the following error:

(qemu) migrate -d tcp:0:4444
(qemu) qemu-system-x86_64: multifd_send_pages: channel 17 has already qui=
t!
qemu-system-x86_64: multifd_send_pages: channel 17 has already quit!
qemu-system-x86_64: multifd_send_sync_main: multifd_send_pages fail
qemu-system-x86_64: Unable to write to socket: Connection reset by peer
info migrate
globals:
store-global-state: on
only-migratable: off
send-configuration: on
send-section-footer: on
decompress-error-check: on
clear-bitmap-shift: 18
capabilities: xbzrle: off rdma-pin-all: off auto-converge: off zero-block=
s: off compress: off events: off postcopy-ram: off x-colo: off release-ra=
m: off block: off return-path: off pause-before-switchover: off multifd: =
on dirty-bitmaps: off postcopy-blocktime: off late-block-activate: off x-=
ignore-shared: off
Migration status: failed (Unable to write to socket: Connection reset by =
peer)
total time: 0 milliseconds

On this particular example I am using 100 channels.  The bigger the
number of channels, the easier that it is to reproduce.  That don't
mean that it is a good idea to use so many channels.

With the previous patches on this series, I can run "reliabely" on my
hardware with until 10 channels.  Most of the time.  Until it fails.
With 100 channels, it fails almost always.

I thought that the problem was on the send side, so I tried to debug
there.  As you can see for the delay, if you put any
printf()/error_report/trace, you can get that the error goes away, it
is very timing sensitive.  With a delay of 10000 microseconds, it only
works sometimes.

What have I discovered so far:

- send side calls qemu_socket() on all the channels.  So it appears
  that it gets created correctly.
- on the destination side, it appears that "somehowe" some of the
  connections are lost by the listener.  This error happens when the
  destination side socket hasn't been "accepted", and it is not
  properly created.  As far as I can see, we have several options:

  1- I don't know how to use properly qio asynchronously
     (this is one big posiblity).

  2- glib has one error in this case?  or how qio listener is
     implemented on top of glib.  I put lots of printf() and other
     instrumentation, and it appears that the listener io_func is not
     called at all for the connections that are missing.

  3- it is always possible that we are missing some g_main_loop_run()
     somewhere.  Notice how test/test-io-channel-socket.c calls it
     "creatively".

  4- It is enterely possible that I should be using the sockets as
     blocking instead of non-blocking.  But I am not sure about that
     one yet.

- on the sending side, what happens is:

  eventually it call socket_connect() after all the async dance with
  thread creation, etc, etc. Source side creates all the channels, it
  is the destination side which is missing some of them.

  sending side sends the first packet by that channel, it "sucheeds"
  and didn't give any error.

  after some time, sending side decides to send another packet through
  that channel, and it is now when we get the above error.

Any good ideas?

Later, Juan.

PD: Command line used is attached:

Imortant bits:
- multifd is set
- multifd_channels is set to 100

/scratch/qemu/fail/x64/x86_64-softmmu/qemu-system-x86_64 -M
pc-i440fx-3.1,accel=3Dkvm,usb=3Doff,vmport=3Doff,nvdimm -L
/mnt/code/qemu/check/pc-bios/ -smp 2 -name t1,debug-threads=3Don -m 3G
-uuid 113100f9-6c99-4a7a-9b78-eb1c088d1087 -monitor stdio -boot
strict=3Don -drive
file=3D/mnt/images/test.img,format=3Dqcow2,if=3Dnone,id=3Ddisk0 -device
virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x7,drive=3Ddisk0,id=3Dvirti=
o-disk0,bootindex=3D1
-netdev tap,id=3Dhostnet0,script=3D/etc/kvm-ifup,downscript=3D -device
virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:9d:10:51,bus=3D=
pci.0,addr=3D0x3
-serial pty -parallel none -usb -device usb-tablet -k es -vga cirrus
--global migration.x-multifd=3Don --global
migration.multifd-channels=3D100 -trace events=3D/home/quintela/tmp/event=
s

CC: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/ram.c b/migration/ram.c
index 25a211c3fb..50586304a0 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1248,6 +1248,7 @@ int multifd_save_setup(void)
         p->packet =3D g_malloc0(p->packet_len);
         p->name =3D g_strdup_printf("multifdsend_%d", i);
         socket_send_channel_create(multifd_new_send_channel_async, p);
+        usleep(100000);
     }
     return 0;
 }
--=20
2.21.0


