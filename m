Received: from eggs.gnu.org ([209.51.188.92]:48173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hAzrc-000844-01
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 12:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hAzra-0002Op-Rk
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 12:32:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hAzra-0002NX-Hb
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 12:32:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so93459wmd.0
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 09:32:45 -0700 (PDT)
Date: Mon, 1 Apr 2019 18:32:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190401163240.xw24ezsloy5ds2hz@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] VSOCK benchmark and optimizations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu devel list <qemu-devel@nongnu.org>, netdev@vger.kernel.org

Hi Alex,
I'm sending you some benchmarks and information about VSOCK CCing qemu-devel
and linux-netdev (maybe this info could be useful for others :))

One of the VSOCK advantages is the simple configuration: you don't need to set
up IP addresses for guest/host, and it can be used with the standard POSIX
socket API. [1]

I'm currently working on it, so the "optimized" values are still work in
progress and I'll send the patches upstream (Linux) as soon as possible.
(I hope in 1 or 2 weeks)

Optimizations:
+ reducing the number of credit update packets
  - RX side sent, on every packet received, an empty packet only to inform the
    TX side about the space in the RX buffer.
+ increase RX buffers size to 64 KB (from 4 KB)
+ merge packets to fill RX buffers

As benchmark tool I used iperf3 [2] modified with VSOCK support:

             host -> guest [Gbps]      guest -> host [Gbps]
pkt_size    before opt.  optimized    before opt.  optimized
  1K            0.5         1.6           1.4         1.4
  2K            1.1         3.1           2.3         2.5
  4K            2.0         5.6           4.2         4.4
  8K            3.2        10.2           7.2         7.5
  16K           6.4        14.2           9.4        11.3
  32K           9.8        18.9           9.2        17.8
  64K          13.8        22.9           8.8        25.0
  128K         17.6        24.5           7.7        25.7
  256K         19.0        24.8           8.1        25.6
  512K         20.8        25.1           8.1        25.4


How to reproduce:

host$ modprobe vhost_vsock
host$ qemu-system-x86_64 ... -device vhost-vsock-pci,guest-cid=3
      # Note: Guest CID should be >= 3
      # (0, 1 are reserved and 2 identify the host)

guest$ iperf3 --vsock -s

host$ iperf3 --vsock -c 3 -l ${pkt_size}      # host -> guest
host$ iperf3 --vsock -c 3 -l ${pkt_size} -R   # guest -> host


If you want, I can do a similar benchmark (with iperf3) using a networking
card (do you have a specific configuration?).

Let me know if you need more details!

Thanks,
Stefano

[1] https://wiki.qemu.org/Features/VirtioVsock
[2] https://github.com/stefano-garzarella/iperf/
