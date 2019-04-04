Received: from eggs.gnu.org ([209.51.188.92]:60822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hC01B-00047b-JU
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hBzuF-0003oD-Ea
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:47:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hBzuF-0003me-40
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:47:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so2452420wml.4
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 03:47:38 -0700 (PDT)
Date: Thu, 4 Apr 2019 12:47:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190404104734.ncgxybz5nyiipns5@steredhat>
References: <20190401163240.xw24ezsloy5ds2hz@steredhat>
	<87zhp9599u.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhp9599u.fsf@zen.linaroharston>
Subject: Re: [Qemu-devel] VSOCK benchmark and optimizations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu devel list <qemu-devel@nongnu.org>, netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Apr 02, 2019 at 04:19:25AM +0000, Alex Bennée wrote:
> 
> My main interest is how it stacks up against:
> 
>   --device virtio-net-pci and I guess the vhost equivalent
> 

Hi Alex,
I added TCP tests on virtio-net and I did also a test with TCP_NODELAY,
just to be fair, because VSOCK doesn't implement something like this
(maybe could be an improvement to add for maximizing the throughput).
I set the MTU to the maximum allowed (65520).

I also redo the VSOCK tests. There are some differences because now I'm
using tuned to have fewer fluctuations and I removed batching in VSOCK
optimization because it is not ready to be published.

                   VSOCK               TCP + virtio-net + vhost
             host -> guest [Gbps]         host -> guest [Gbps]
pkt_size    before opt.  optimized      TCP_NODELAY
  64            0.060       0.096           0.16        0.15
  256           0.22        0.36            0.32        0.57
  512           0.42        0.74            1.2         1.2
  1K            0.7         1.5             2.1         2.1
  2K            1.5         2.9             3.5         3.4
  4K            2.5         5.3             5.5         5.3
  8K            3.9         8.8             8.0         7.9
  16K           6.6        12.8             9.8        10.2
  32K           9.9        18.1            11.8        10.7
  64K          13.5        21.4            11.4        11.3
  128K         17.9        23.6            11.2        11.0
  256K         18.0        24.4            11.1        11.0
  512K         18.4        25.3            10.1        10.7

Note: Maybe I have something miss configured because TCP on virtio-net
doesn't exceed 11 Gbps.

                   VSOCK               TCP + virtio-net + vhost
             guest -> host [Gbps]         guest -> host [Gbps]
pkt_size    before opt.  optimized      TCP_NODELAY
  64            0.088       0.101           0.24        0.24
  256           0.35        0.41            0.36        1.03
  512           0.70        0.73            0.69        1.6
  1K            1.1         1.3             1.1         3.0
  2K            2.4         2.6             2.1         5.5
  4K            4.3         4.5             3.8         8.8
  8K            7.3         7.6             6.6        20.0
  16K           9.2        11.1            12.3        29.4
  32K           8.3        18.1            19.3        28.2
  64K           8.3        25.4            20.6        28.7
  128K          7.2        26.7            23.1        27.9
  256K          7.7        24.9            28.5        29.4
  512K          7.7        25.0            28.3        29.3

virtio-net is well optimized than VSOCK, but we are near :). Maybe we
will use virtio-net as a transport for VSOCK, in order to avoid duplicate
optimizations.

How to reproduce TCP tests:

host$ ip link set dev br0 mtu 65520
host$ ip link set dev tap0 mtu 65520
host$ qemu-system-x86_64 ... \
      -netdev tap,id=net0,vhost=on,ifname=tap0,script=no,downscript=no \
      -device virtio-net-pci,netdev=net0

guest$ ip link set dev eth0 mtu 65520
guest$ iperf3 -s

host$ iperf3 -c ${VM_IP} -N -l ${pkt_size}      # host -> guest
host$ iperf3 -c ${VM_IP} -N -l ${pkt_size} -R   # guest -> host


Cheers,
Stefano
