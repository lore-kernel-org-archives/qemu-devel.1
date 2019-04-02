Received: from eggs.gnu.org ([209.51.188.92]:32963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hBDyq-0000lN-Lw
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hBDyp-0006UJ-BK
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:37:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hBDyo-0006Ql-Uo
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:37:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so15254984wrp.2
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 00:37:10 -0700 (PDT)
Date: Tue, 2 Apr 2019 09:37:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190402073706.7t5w5gyj5tf7quwk@steredhat>
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
> Stefano Garzarella <sgarzare@redhat.com> writes:
> 
> > Hi Alex,
> > I'm sending you some benchmarks and information about VSOCK CCing qemu-devel
> > and linux-netdev (maybe this info could be useful for others :))
> >
> > One of the VSOCK advantages is the simple configuration: you don't need to set
> > up IP addresses for guest/host, and it can be used with the standard POSIX
> > socket API. [1]
> >
> > I'm currently working on it, so the "optimized" values are still work in
> > progress and I'll send the patches upstream (Linux) as soon as possible.
> > (I hope in 1 or 2 weeks)
> >
> > Optimizations:
> > + reducing the number of credit update packets
> >   - RX side sent, on every packet received, an empty packet only to inform the
> >     TX side about the space in the RX buffer.
> > + increase RX buffers size to 64 KB (from 4 KB)
> > + merge packets to fill RX buffers
> >
> > As benchmark tool I used iperf3 [2] modified with VSOCK support:
> >
> >              host -> guest [Gbps]      guest -> host [Gbps]
> > pkt_size    before opt.  optimized    before opt.  optimized
> >   1K            0.5         1.6           1.4         1.4
> >   2K            1.1         3.1           2.3         2.5
> >   4K            2.0         5.6           4.2         4.4
> >   8K            3.2        10.2           7.2         7.5
> >   16K           6.4        14.2           9.4        11.3
> >   32K           9.8        18.9           9.2        17.8
> >   64K          13.8        22.9           8.8        25.0
> >   128K         17.6        24.5           7.7        25.7
> >   256K         19.0        24.8           8.1        25.6
> >   512K         20.8        25.1           8.1        25.4
> >
> >
> > How to reproduce:
> >
> > host$ modprobe vhost_vsock
> > host$ qemu-system-x86_64 ... -device vhost-vsock-pci,guest-cid=3
> >       # Note: Guest CID should be >= 3
> >       # (0, 1 are reserved and 2 identify the host)
> >
> > guest$ iperf3 --vsock -s
> >
> > host$ iperf3 --vsock -c 3 -l ${pkt_size}      # host -> guest
> > host$ iperf3 --vsock -c 3 -l ${pkt_size} -R   # guest -> host
> >
> >
> > If you want, I can do a similar benchmark (with iperf3) using a networking
> > card (do you have a specific configuration?).
> 
> My main interest is how it stacks up against:
> 
>   --device virtio-net-pci and I guess the vhost equivalent

I'll do some tests with virtio-net and vhost.

> 
> AIUI one of the motivators was being able to run something like NFS for
> a guest FS over vsock instead of the overhead from UDP and having to
> deal with the additional complication of having a working network setup.
> 

CCing Stefan.

I know he is working on virtio-fs that maybe suite better with your use cases.
He also worked on VSOCK support for NFS, but I think it is not merged upstream.

Thanks,
Stefano
