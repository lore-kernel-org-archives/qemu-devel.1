Received: from eggs.gnu.org ([2001:4830:134:3::10]:51859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dcQ6B-0003Ma-TB
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 01:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dcQ68-0003sO-QY
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 01:52:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dcQ68-0003pj-HY
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 01:52:04 -0400
Date: Mon, 31 Jul 2017 23:46:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170731234626.7664be18@w520.home>
In-Reply-To: <CAMxP3BTFgwJtjh78hNBCoxBp1WsnZMZLsqzb3McqCq=-SX0a4g@mail.gmail.com>
References: <4E0AFA5F-44D6-4624-A99F-68A7FE52F397@meituan.com>
	<4b31a711-a52e-25d3-4a7c-1be8521097d9@redhat.com>
	<F99BFE80-FC15-40A0-BB3E-1B53B6CF9B05@meituan.com>
	<859362e8-0d98-3865-8bad-a15bfa218167@redhat.com>
	<20170726092931.0678689e@w520.home>
	<20170726190348-mutt-send-email-mst@kernel.org>
	<20170726113222.52aad9a6@w520.home>
	<CAMxP3BTFgwJtjh78hNBCoxBp1WsnZMZLsqzb3McqCq=-SX0a4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Bob Chen <a175818323@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?B?6ZmI5Y2a?= <chenbo02@meituan.com>, qemu-devel@nongnu.org

On Tue, 1 Aug 2017 13:04:46 +0800
Bob Chen <a175818323@gmail.com> wrote:

> Hi,
>=20
> This is a sketch of my hardware topology.
>=20
>           CPU0         <- QPI ->        CPU1
>            |                             |
>     Root Port(at PCIe.0)        Root Port(at PCIe.1)
>        /        \                   /       \

Are each of these lines above separate root ports?  ie. each root
complex hosts two root ports, each with a two-port switch downstream of
it?

>     Switch    Switch             Switch    Switch
>      /   \      /  \              /   \    /    \
>    GPU   GPU  GPU  GPU          GPU   GPU GPU   GPU
>=20
>=20
> And below are the p2p bandwidth test results.
>=20
> Host=EF=BC=9A
>    D\D     0      1      2      3      4      5      6      7
>      0 426.91  25.32  19.72  19.72  19.69  19.68  19.75  19.66
>      1  25.31 427.61  19.74  19.72  19.66  19.68  19.74  19.73
>      2  19.73  19.73 429.49  25.33  19.66  19.74  19.73  19.74
>      3  19.72  19.71  25.36 426.68  19.70  19.71  19.77  19.74
>      4  19.72  19.72  19.73  19.75 425.75  25.33  19.72  19.71
>      5  19.71  19.75  19.76  19.75  25.35 428.11  19.69  19.70
>      6  19.76  19.72  19.79  19.78  19.73  19.74 425.75  25.35
>      7  19.69  19.75  19.79  19.75  19.72  19.72  25.39 427.15
>=20
> VM=EF=BC=9A
>    D\D     0      1      2      3      4      5      6      7
>      0 427.38  10.52  18.99  19.11  19.75  19.62  19.75  19.71
>      1  10.53 426.68  19.28  19.19  19.73  19.71  19.72  19.73
>      2  18.88  19.30 426.92  10.48  19.66  19.71  19.67  19.68
>      3  18.93  19.18  10.45 426.94  19.69  19.72  19.67  19.72
>      4  19.60  19.66  19.69  19.70 428.13  10.49  19.40  19.57
>      5  19.52  19.74  19.72  19.69  10.44 426.45  19.68  19.61
>      6  19.63  19.50  19.72  19.64  19.59  19.66 426.91  10.47
>      7  19.69  19.75  19.70  19.69  19.66  19.74  10.45 426.23

Interesting test, how do you get these numbers?  What are the units,
GB/s?
=20
> In the VM, the bandwidth between two GPUs under the same physical switch =
is
> obviously lower, as per the reasons you said in former threads.

Hmm, I'm not sure I can explain why the number is lower than to more
remote GPUs though.  Is the test simultaneously reading and writing and
therefore we overload the link to the upstream switch port?  Otherwise
I'd expect the bidirectional support in PCIe to be able to handle the
bandwidth.  Does the test have a read-only or write-only mode?
=20
> But what confused me most is that GPUs under different switches could
> achieve the same speed, as well as in the Host. Does that mean after IOMMU
> address translation, data traversing has utilized QPI bus by default? Even
> these two devices do not belong to the same PCIe bus?

Yes, of course.  Once the transaction is translated by the IOMMU it's
just a matter of routing the resulting address, whether that's back
down the I/O hierarchy under the same root complex or across the QPI
link to the other root complex.  The translated address could just as
easily be to RAM that lives on the other side of the QPI link.  Also, it
seems like the IOMMU overhead is perhaps negligible here, unless the
IOMMU is actually being used in both cases.

In the host test, is the IOMMU still enabled?  The routing of PCIe
transactions is going to be governed by ACS, which Linux enables
whenever the IOMMU is enabled, not just when a device is assigned to a
VM.  It would be interesting to see if another performance tier is
exposed if the IOMMU is entirely disabled, or perhaps it might better
expose the overhead of the IOMMU translation.  It would also be
interesting to see the ACS settings in lspci for each downstream port
for each test.  Thanks,

Alex
