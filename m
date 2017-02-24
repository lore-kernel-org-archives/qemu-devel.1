Received: from eggs.gnu.org ([2001:4830:134:3::10]:60076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1chLtk-0003G5-H5
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1chLtj-00075Y-JB
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:51:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1chLtj-00074T-DG
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:51:23 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90EE44E4D6
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 19:51:22 +0000 (UTC)
Date: Fri, 24 Feb 2017 19:51:18 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170224195117.GR8830@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] make check: crash in vhost-user chardev cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: mst@redhat.com, armbru@redhat.com

Hi,
  I'm seeing a hang+crash doing a make check that
looks like it's coming from vhost-user's chardev cleanup,
so I'm suspecting your e0b283e7c.
The synptom is that the make check hangs in the qtest
part, and a dmesg shows that a qemu crashed.
I got a backtrace that shows:

(gdb) where
#0  0x0000560d3344f03e in qemu_chr_fe_read_all (be=be@entry=0x0, buf=buf@entry=0x7ffea7a2f520 "\v", len=len@entry=12) at /home/dgilbert/git/qemu/chardev/char.c:209
#1  0x0000560d33199d64 in vhost_user_read (msg=msg@entry=0x7ffea7a2f520, dev=<optimized out>)
    at /home/dgilbert/git/qemu/hw/virtio/vhost-user.c:125
#2  0x0000560d3319a11f in vhost_user_get_vring_base (dev=0x560d35a614a0, ring=0x7ffea7a2f670)
    at /home/dgilbert/git/qemu/hw/virtio/vhost-user.c:417
#3  0x0000560d33196abb in vhost_virtqueue_stop (dev=dev@entry=0x560d35a614a0, vdev=vdev@entry=0x560d3729cc00, vq=0x560d35a61678, idx=1) at /home/dgilbert/git/qemu/hw/virtio/vhost.c:1070
#4  0x0000560d33198cd4 in vhost_dev_stop (hdev=hdev@entry=0x560d35a614a0, vdev=vdev@entry=0x560d3729cc00)
    at /home/dgilbert/git/qemu/hw/virtio/vhost.c:1533
#5  0x0000560d3317bfd8 in vhost_net_stop_one (net=0x560d35a614a0, dev=0x560d3729cc00)
    at /home/dgilbert/git/qemu/hw/net/vhost_net.c:288
#6  0x0000560d3317c4aa in vhost_net_stop (dev=dev@entry=0x560d3729cc00, ncs=<optimized out>, total_queues=total_queues@entry=1) at /home/dgilbert/git/qemu/hw/net/vhost_net.c:367
#7  0x0000560d33179201 in virtio_net_vhost_status (status=<optimized out>, n=0x560d3729cc00)
    at /home/dgilbert/git/qemu/hw/net/virtio-net.c:176
#8  0x0000560d33179201 in virtio_net_set_status (vdev=0x560d3729cc00, status=7 '\a')
    at /home/dgilbert/git/qemu/hw/net/virtio-net.c:250
#9  0x0000560d3339ce99 in qemu_del_net_client (nc=0x560d35a61250) at /home/dgilbert/git/qemu/net/net.c:390
#10 0x0000560d3339e30d in net_cleanup () at /home/dgilbert/git/qemu/net/net.c:1454
#11 0x0000560d330ee940 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>)
    at /home/dgilbert/git/qemu/vl.c:4637
(gdb) 

#0  qemu_chr_fe_read_all (be=be@entry=0x0, buf=buf@entry=0x7ffea7a2f520 "\v", len=len@entry=12)
    at /home/dgilbert/git/qemu/chardev/char.c:209
209         Chardev *s = be->chr;

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
