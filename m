Received: from eggs.gnu.org ([2001:4830:134:3::10]:60531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1dehdo-0002iF-Tz
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 09:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1dehdh-0007No-Ae
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 09:00:17 -0400
Received: from mail-it0-x229.google.com ([2607:f8b0:4001:c0b::229]:36771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a175818323@gmail.com>)
	id 1dehdh-0007Ji-2M
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 09:00:09 -0400
Received: by mail-it0-x229.google.com with SMTP id 77so3062026itj.1
	for <qemu-devel@nongnu.org>; Mon, 07 Aug 2017 06:00:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170801090158.35d18f10@w520.home>
References: <4E0AFA5F-44D6-4624-A99F-68A7FE52F397@meituan.com>
	<4b31a711-a52e-25d3-4a7c-1be8521097d9@redhat.com>
	<F99BFE80-FC15-40A0-BB3E-1B53B6CF9B05@meituan.com>
	<859362e8-0d98-3865-8bad-a15bfa218167@redhat.com>
	<20170726092931.0678689e@w520.home>
	<20170726190348-mutt-send-email-mst@kernel.org>
	<20170726113222.52aad9a6@w520.home>
	<CAMxP3BTFgwJtjh78hNBCoxBp1WsnZMZLsqzb3McqCq=-SX0a4g@mail.gmail.com>
	<20170731234626.7664be18@w520.home>
	<CAMxP3BTfMad-ycWHqmW+aVM7rv2CJSv-dmEFUveGBqAWvfbBjQ@mail.gmail.com>
	<20170801090158.35d18f10@w520.home>
From: Bob Chen <a175818323@gmail.com>
Date: Mon, 7 Aug 2017 21:00:04 +0800
Message-ID: <CAMxP3BRkzXBRPZw9fpCu-w4Fusn6ng_knk1cAz=EDBAiw9UnqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] =?utf-8?q?About_virtio_device_hotplug_in_Q35!_?=
	=?utf-8?b?44CQ5aSW5Z+f6YKu5Lu2LuiwqOaFjuafpemYheOAkQ==?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?B?6ZmI5Y2a?= <chenbo02@meituan.com>, qemu-devel@nongnu.org

Bad news... The performance had dropped dramatically when using emulated
switches.

I was referring to the PCIe doc at
https://github.com/qemu/qemu/blob/master/docs/pcie.txt

# qemu-system-x86_64_2.6.2 -enable-kvm -cpu host,kvm=3Doff -machine
q35,accel=3Dkvm -nodefaults -nodefconfig \
-device ioh3420,id=3Droot_port1,chassis=3D1,slot=3D1,bus=3Dpcie.0 \
-device x3130-upstream,id=3Dupstream_port1,bus=3Droot_port1 \
-device
xio3130-downstream,id=3Ddownstream_port1,bus=3Dupstream_port1,chassis=3D11,=
slot=3D11
\
-device
xio3130-downstream,id=3Ddownstream_port2,bus=3Dupstream_port1,chassis=3D12,=
slot=3D12
\
-device vfio-pci,host=3D08:00.0,multifunction=3Don,bus=3Ddownstream_port1 \
-device vfio-pci,host=3D09:00.0,multifunction=3Don,bus=3Ddownstream_port2 \
-device ioh3420,id=3Droot_port2,chassis=3D2,slot=3D2,bus=3Dpcie.0 \
-device x3130-upstream,id=3Dupstream_port2,bus=3Droot_port2 \
-device
xio3130-downstream,id=3Ddownstream_port3,bus=3Dupstream_port2,chassis=3D21,=
slot=3D21
\
-device
xio3130-downstream,id=3Ddownstream_port4,bus=3Dupstream_port2,chassis=3D22,=
slot=3D22
\
-device vfio-pci,host=3D89:00.0,multifunction=3Don,bus=3Ddownstream_port3 \
-device vfio-pci,host=3D8a:00.0,multifunction=3Don,bus=3Ddownstream_port4 \
...


Not 8 GPUs this time, only 4.

*1. Attached to pcie bus directly (former situation):*

Unidirectional P2P=3DDisabled Bandwidth Matrix (GB/s)
   D\D     0      1      2      3
     0 420.93  10.03  11.07  11.09
     1  10.04 425.05  11.08  10.97
     2  11.17  11.17 425.07  10.07
     3  11.25  11.25  10.07 423.64
Unidirectional P2P=3DEnabled Bandwidth Matrix (GB/s)
   D\D     0      1      2      3
     0 425.98  10.03  11.07  11.09
     1   9.99 426.43  11.07  11.07
     2  11.04  11.20 425.98   9.89
     3  11.21  11.21  10.06 425.97
Bidirectional P2P=3DDisabled Bandwidth Matrix (GB/s)
   D\D     0      1      2      3
     0 430.67  10.45  19.59  19.58
     1  10.44 428.81  19.49  19.53
     2  19.62  19.62 429.52  10.57
     3  19.60  19.66  10.43 427.38
Bidirectional P2P=3DEnabled Bandwidth Matrix (GB/s)
   D\D     0      1      2      3
     0 429.47  10.47  19.52  19.39
     1  10.48 427.15  19.64  19.52
     2  19.64  19.59 429.02  10.42
     3  19.60  19.64  10.47 427.81
P2P=3DDisabled Latency Matrix (us)
   D\D     0      1      2      3
     0   4.50  13.72  14.49  14.44
     1  13.65   4.53  14.52  14.33
     2  14.22  13.82   4.52  14.50
     3  13.87  13.75  14.53   4.55
P2P=3DEnabled Latency Matrix (us)
   D\D     0      1      2      3
     0   4.44  13.56  14.58  14.45
     1  13.56   4.48  14.39  14.45
     2  13.85  13.93   4.86  14.80
     3  14.51  14.23  14.70   4.72


*2. Attached to emulated Root Port and Switches:*

Unidirectional P2P=3DDisabled Bandwidth Matrix (GB/s)
   D\D     0      1      2      3
     0 420.48   3.15   3.12   3.12
     1   3.13 422.31   3.12   3.12
     2   3.08   3.09 421.40   3.13
     3   3.10   3.10   3.13 418.68
Unidirectional P2P=3DEnabled Bandwidth Matrix (GB/s)
   D\D     0      1      2      3
     0 418.68   3.14   3.12   3.12
     1   3.15 420.03   3.12   3.12
     2   3.11   3.10 421.39   3.14
     3   3.11   3.08   3.13 419.13
Bidirectional P2P=3DDisabled Bandwidth Matrix (GB/s)
   D\D     0      1      2      3
     0 424.36   5.36   5.35   5.34
     1   5.36 424.36   5.34   5.34
     2   5.35   5.36 425.52   5.35
     3   5.36   5.36   5.34 425.29
Bidirectional P2P=3DEnabled Bandwidth Matrix (GB/s)
   D\D     0      1      2      3
     0 422.98   5.35   5.35   5.35
     1   5.35 423.44   5.34   5.33
     2   5.35   5.35 425.29   5.35
     3   5.35   5.34   5.34 423.21
P2P=3DDisabled Latency Matrix (us)
   D\D     0      1      2      3
     0   4.79  16.59  16.38  16.22
     1  16.62   4.77  16.35  16.69
     2  16.77  16.66   4.03  16.68
     3  16.54  16.56  16.78   4.08
P2P=3DEnabled Latency Matrix (us)
   D\D     0      1      2      3
     0   4.51  16.56  16.58  16.66
     1  15.65   3.87  16.74  16.61
     2  16.59  16.81   3.96  16.70
     3  16.47  16.28  16.68   4.03


Is it because the heavy load of CPU emulation had caused a bottleneck?



2017-08-01 23:01 GMT+08:00 Alex Williamson <alex.williamson@redhat.com>:

> On Tue, 1 Aug 2017 17:35:40 +0800
> Bob Chen <a175818323@gmail.com> wrote:
>
> > 2017-08-01 13:46 GMT+08:00 Alex Williamson <alex.williamson@redhat.com>=
:
> >
> > > On Tue, 1 Aug 2017 13:04:46 +0800
> > > Bob Chen <a175818323@gmail.com> wrote:
> > >
> > > > Hi,
> > > >
> > > > This is a sketch of my hardware topology.
> > > >
> > > >           CPU0         <- QPI ->        CPU1
> > > >            |                             |
> > > >     Root Port(at PCIe.0)        Root Port(at PCIe.1)
> > > >        /        \                   /       \
> > >
> > > Are each of these lines above separate root ports?  ie. each root
> > > complex hosts two root ports, each with a two-port switch downstream =
of
> > > it?
> > >
> >
> > Not quite sure if root complex is a concept or a real physical device .=
..
> >
> > But according to my observation by `lspci -vt`, there are indeed 4 Root
> > Ports in the system. So the sketch might need a tiny update.
> >
> >
> >           CPU0         <- QPI ->        CPU1
> >
> >            |                             |
> >
> >       Root Complex(device?)      Root Complex(device?)
> >
> >          /    \                       /    \
> >
> >     Root Port  Root Port         Root Port  Root Port
> >
> >        /        \                   /        \
> >
> >     Switch    Switch             Switch    Switch
> >
> >      /   \      /  \              /   \     /   \
> >
> >    GPU   GPU  GPU  GPU          GPU   GPU  GPU   GPU
>
>
> Yes, that's what I expected.  So the numbers make sense, the immediate
> sibling GPU would share bandwidth between the root port and upstream
> switch port, any other GPU should not double-up on any single link.
>
> > > >     Switch    Switch             Switch    Switch
> > > >      /   \      /  \              /   \    /    \
> > > >    GPU   GPU  GPU  GPU          GPU   GPU GPU   GPU
> > > >
> > > >
> > > > And below are the p2p bandwidth test results.
> > > >
> > > > Host=EF=BC=9A
> > > >    D\D     0      1      2      3      4      5      6      7
> > > >      0 426.91  25.32  19.72  19.72  19.69  19.68  19.75  19.66
> > > >      1  25.31 427.61  19.74  19.72  19.66  19.68  19.74  19.73
> > > >      2  19.73  19.73 429.49  25.33  19.66  19.74  19.73  19.74
> > > >      3  19.72  19.71  25.36 426.68  19.70  19.71  19.77  19.74
> > > >      4  19.72  19.72  19.73  19.75 425.75  25.33  19.72  19.71
> > > >      5  19.71  19.75  19.76  19.75  25.35 428.11  19.69  19.70
> > > >      6  19.76  19.72  19.79  19.78  19.73  19.74 425.75  25.35
> > > >      7  19.69  19.75  19.79  19.75  19.72  19.72  25.39 427.15
> > > >
> > > > VM=EF=BC=9A
> > > >    D\D     0      1      2      3      4      5      6      7
> > > >      0 427.38  10.52  18.99  19.11  19.75  19.62  19.75  19.71
> > > >      1  10.53 426.68  19.28  19.19  19.73  19.71  19.72  19.73
> > > >      2  18.88  19.30 426.92  10.48  19.66  19.71  19.67  19.68
> > > >      3  18.93  19.18  10.45 426.94  19.69  19.72  19.67  19.72
> > > >      4  19.60  19.66  19.69  19.70 428.13  10.49  19.40  19.57
> > > >      5  19.52  19.74  19.72  19.69  10.44 426.45  19.68  19.61
> > > >      6  19.63  19.50  19.72  19.64  19.59  19.66 426.91  10.47
> > > >      7  19.69  19.75  19.70  19.69  19.66  19.74  10.45 426.23
> > >
> > > Interesting test, how do you get these numbers?  What are the units,
> > > GB/s?
> > >
> >
> >
> >
> > A p2pBandwidthLatencyTest from Nvidia CUDA sample code. Units are
> > GB/s. Asynchronous read and write. Bidirectional.
> >
> > However, the Unidirectional test had shown a different result. Didn't
> fall
> > down to a half.
> >
> > VM:
> > Unidirectional P2P=3DEnabled Bandwidth Matrix (GB/s)
> >    D\D     0      1      2      3      4      5      6      7
> >      0 424.07  10.02  11.33  11.30  11.09  11.05  11.06  11.10
> >      1  10.05 425.98  11.40  11.33  11.08  11.10  11.13  11.09
> >      2  11.31  11.28 423.67  10.10  11.14  11.13  11.13  11.11
> >      3  11.30  11.31  10.08 425.05  11.10  11.07  11.09  11.06
> >      4  11.16  11.17  11.21  11.17 423.67  10.08  11.25  11.28
> >      5  10.97  11.01  11.07  11.02  10.09 425.52  11.23  11.27
> >      6  11.09  11.13  11.16  11.10  11.28  11.33 422.71  10.10
> >      7  11.13  11.09  11.15  11.11  11.36  11.33  10.02 422.75
> >
> > Host:
> > Unidirectional P2P=3DEnabled Bandwidth Matrix (GB/s)
> >    D\D     0      1      2      3      4      5      6      7
> >      0 424.13  13.38  10.17  10.17  11.23  11.21  10.94  11.22
> >      1  13.38 424.06  10.18  10.19  11.20  11.19  11.19  11.14
> >      2  10.18  10.18 422.75  13.38  11.19  11.19  11.17  11.17
> >      3  10.18  10.18  13.38 425.05  11.05  11.08  11.08  11.06
> >      4  11.01  11.06  11.06  11.03 423.21  13.38  10.17  10.17
> >      5  10.91  10.91  10.89  10.92  13.38 425.52  10.18  10.18
> >      6  11.28  11.30  11.32  11.31  10.19  10.18 424.59  13.37
> >      7  11.18  11.20  11.16  11.21  10.17  10.19  13.38 424.13
>
> Looks right, a unidirectional test would create bidirectional data
> flows on the root port to upstream switch link and should be able to
> saturate that link.  With the bidirectional test, that link becomes a
> bottleneck.
>
> > > > In the VM, the bandwidth between two GPUs under the same physical
> switch
> > > is
> > > > obviously lower, as per the reasons you said in former threads.
> > >
> > > Hmm, I'm not sure I can explain why the number is lower than to more
> > > remote GPUs though.  Is the test simultaneously reading and writing a=
nd
> > > therefore we overload the link to the upstream switch port?  Otherwis=
e
> > > I'd expect the bidirectional support in PCIe to be able to handle the
> > > bandwidth.  Does the test have a read-only or write-only mode?
> > >
> > > > But what confused me most is that GPUs under different switches cou=
ld
> > > > achieve the same speed, as well as in the Host. Does that mean afte=
r
> > > IOMMU
> > > > address translation, data traversing has utilized QPI bus by defaul=
t?
> > > Even
> > > > these two devices do not belong to the same PCIe bus?
> > >
> > > Yes, of course.  Once the transaction is translated by the IOMMU it's
> > > just a matter of routing the resulting address, whether that's back
> > > down the I/O hierarchy under the same root complex or across the QPI
> > > link to the other root complex.  The translated address could just as
> > > easily be to RAM that lives on the other side of the QPI link.  Also,
> it
> > > seems like the IOMMU overhead is perhaps negligible here, unless the
> > > IOMMU is actually being used in both cases.
> > >
> >
> >
> > Yes, the overhead of bandwidth is negligible, but the latency is not as
> > good as we expected. I assume it is IOMMU address translation to blame.
> >
> > I ran this twice with IOMMU on/off on Host, the results were the same.
> >
> > VM:
> > P2P=3DEnabled Latency Matrix (us)
> >    D\D     0      1      2      3      4      5      6      7
> >      0   4.53  13.44  13.60  13.60  14.37  14.51  14.55  14.49
> >      1  13.47   4.41  13.37  13.37  14.49  14.51  14.56  14.52
> >      2  13.38  13.61   4.32  13.47  14.45  14.43  14.53  14.33
> >      3  13.55  13.60  13.38   4.45  14.50  14.48  14.54  14.51
> >      4  13.85  13.72  13.71  13.81   4.47  14.61  14.58  14.47
> >      5  13.75  13.77  13.75  13.77  14.46   4.46  14.52  14.45
> >      6  13.76  13.78  13.73  13.84  14.50  14.55   4.45  14.53
> >      7  13.73  13.78  13.76  13.80  14.53  14.63  14.56   4.46
> >
> > Host:
> > P2P=3DEnabled Latency Matrix (us)
> >    D\D     0      1      2      3      4      5      6      7
> >      0   3.66   5.88   6.59   6.58  15.26  15.15  15.03  15.14
> >      1   5.80   3.66   6.50   6.50  15.15  15.04  15.06  15.00
> >      2   6.58   6.52   4.12   5.85  15.16  15.06  15.00  15.04
> >      3   6.80   6.81   6.71   4.12  15.12  13.08  13.75  13.31
> >      4  14.91  14.18  14.34  12.93   4.13   6.45   6.56   6.63
> >      5  15.17  14.99  15.03  14.57   5.61   3.49   6.19   6.29
> >      6  15.12  14.78  14.60  13.47   6.16   6.15   3.53   5.68
> >      7  15.00  14.65  14.82  14.28   6.16   6.15   5.44   3.56
>
> Yes, the IOMMU is not free, page table walks are occurring here.  Are
> you using 1G pages for the VM?  2G?  Does this platform support 1G
> super pages on the IOMMU?  (cat /sys/class/iommu/*/intel-iommu/cap, bit
> 34 is 2MB page support, bit 35 is 1G).  All modern Xeons should support
> 1G so you'll want to use 1G hugepages in the VM to take advantage of
> that.
>
> > > In the host test, is the IOMMU still enabled?  The routing of PCIe
> > > transactions is going to be governed by ACS, which Linux enables
> > > whenever the IOMMU is enabled, not just when a device is assigned to =
a
> > > VM.  It would be interesting to see if another performance tier is
> > > exposed if the IOMMU is entirely disabled, or perhaps it might better
> > > expose the overhead of the IOMMU translation.  It would also be
> > > interesting to see the ACS settings in lspci for each downstream port
> > > for each test.  Thanks,
> > >
> > > Alex
> > >
> >
> >
> > How to display GPU's ACS settings? Like this?
> >
> > [420 v2] Advanced Error Reporting
> > UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP=
-
> > ECRC- UnsupReq- ACSViol-
> > UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP=
-
> > ECRC- UnsupReq- ACSViol-
> > UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTL=
P+
> > ECRC- UnsupReq- ACSViol-
>
> As Michael notes, this is AER, ACS is Access Control Services.  It
> should be another capability in lspci.  Thanks,
>
> Alex
>
