Received: from eggs.gnu.org ([2001:4830:134:3::10]:52941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang_syi@163.com>) id 1cHTo1-0001or-Je
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 06:02:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang_syi@163.com>) id 1cHTnx-0001Ja-MP
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 06:02:33 -0500
Received: from mproxyhzb1.163.com ([123.58.178.201]:59924)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang_syi@163.com>) id 1cHTnw-0000w1-Hb
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 06:02:29 -0500
From: Zhang Shuaiyi <zhang_syi@163.com>
Date: Thu, 15 Dec 2016 17:00:35 +0800
Message-ID: <871sx9pj0o.fsf@163.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] Measure virtio-vsock speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com

I used kernel 4.8 and qemu v2.8.0-rc3.
Qemu command line:
  -device vhost-vsock-pci,id=vhost-vsock-pci0,guest-cid=3

I try to use nc-vsock to test vsock speed.
1. In host:
  # modprobe vhost-vsock
  # ./nc-vsock -l 1234 > /dev/null
2. In guest:
  a. use pv and nc-vsock, speed is about 62MB/s.
     # pv /dev/zero | ./nc-vsock 3 1234
  b. use dd and nc-vsock, speed is about 67MB/s.
     # dd if=/dev/zero bs=1M count=2000 | ./nc-vsock 3 1234
     
I think nc-vsock can not get the maximum speed, so I modified
nc-vsock.c.
1. In host, just recv data without printf.
2. In guest, use gettimeofday to record interval and send zero bufs.
  #define MAXLEN 65536
  char buf[MAXLEN] = {0};
  unsigned long long num = 0;

  gettimeofday(&start_time, NULL);
  for (n = 0; n  1000000; n++) {
      ret = send(fd, buf, MAXLEN, 0);
      if (ret  0) {
         fprintf(stderr, "send error ret:%d\n", ret);
         break;
      }
      num += ret;
  }
  gettimeofday(&end_time, NULL);

In this way, the virtio-vsock speed is about 500MB/s. But use iperf to
test virtio-net, the speed is about 1.5GB/s.

Iperf can be used to test virtio-net, is there a tool to test maximum virtio-vsock speed?
At present, virtio-vsock is faster than virtio-net?
