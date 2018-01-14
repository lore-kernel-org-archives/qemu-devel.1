Received: from eggs.gnu.org ([2001:4830:134:3::10]:34237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1eafC7-0000Vn-Ch
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 05:07:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1eafC4-0002P3-7V
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 05:07:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ghammer@redhat.com>) id 1eafC4-0002Nm-1C
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 05:07:12 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64C61C047B60
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 10:07:10 +0000 (UTC)
From: Gal Hammer <ghammer@redhat.com>
Date: Sun, 14 Jan 2018 12:06:53 +0200
Message-Id: <1515924416-9266-1-git-send-email-ghammer@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3 v2] virtio: improve virtio devices
 initialization time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Gal Hammer <ghammer@redhat.com>

A bug was reported about a very slow boot time and a 100% CPU usage of
both Windows and Linux guests when running a VM with multiple
virtio-serial devices (https://bugzilla.redhat.com/1528588).

For example, running a VM with 25 virtio-serial devices, each one with
max_ports=511, could have a boot time of around 30 minutes. With this
patch (and another patch to kvm) the boot time is reduced to
approximately 3 minutes.

The patch wraps all the changes made to the Memory Regions during the
eventfd registrations in a memory regions transaction. I had to add a
cleanup callback function to the EventNotifier struct, so it will be
possible to use a transaction in the shutdown code path as well.

Gal Hammer (3):
  qemu: add a cleanup callback function to EventNotifier
  virtio: postpone the execution of event_notifier_cleanup function
  virtio: improve virtio devices initialization time

 accel/kvm/kvm-all.c           |  4 ++++
 hw/virtio/virtio-bus.c        | 19 +++++++++++--------
 hw/virtio/virtio.c            |  5 +++++
 include/qemu/event_notifier.h |  1 +
 util/event_notifier-posix.c   |  5 ++++-
 util/event_notifier-win32.c   |  2 ++
 6 files changed, 27 insertions(+), 9 deletions(-)

-- 
2.7.5
