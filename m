Received: from eggs.gnu.org ([2001:4830:134:3::10]:58590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eYlG4-0005RM-D6
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 23:11:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eYlG1-0003cW-8Z
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 23:11:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eYlG0-0003bv-Rf
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 23:11:25 -0500
Date: Tue, 9 Jan 2018 06:11:17 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180109060920-mutt-send-email-mst@kernel.org>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
	<CAFEAcA_pt7XhXOhL2jSxwH9ooL7xjShmp6eBAYpRLc=dY-=TXQ@mail.gmail.com>
	<20171221223704-mutt-send-email-mst@kernel.org>
	<CAAdtpL74ZyVsLwgBjpbsdSHbWdY_Uq6ouRAvgo00UdVevTKq8A@mail.gmail.com>
	<20171222014258-mutt-send-email-mst@kernel.org>
	<CAFEAcA8eKTEh3zSOPNm1WgUujNOU+zcNSgBAE5G68QcObQd8sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8eKTEh3zSOPNm1WgUujNOU+zcNSgBAE5G68QcObQd8sA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/25] pc, pci, virtio: features, fixes,
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philippe@mathieu-daude.net>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Jan 08, 2018 at 09:14:41AM +0000, Peter Maydell wrote:
> On 21 December 2017 at 23:43, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> you also need to drop "hw/pci: remove obsolete PCIDevice->init()"
> >> (applied in your tree as 18951fce55d5aa58cd1629b4cb704ee51bab4420)
> >> else the not-yet-QOM'ified NVME won't work anymore.
> >
> > Done that too, thanks a lot
> 
> Hi. I'm afraid this pullreq (merge of 880b1ff) has new runtime
> errors from the clang sanitizer:
> 
> /home/petmay01/linaro/qemu-for-merges/hw/net/net_tx_pkt.c:201:27:
> runtime error: member access within misaligned address 0x55b4ffee8246
> for type 'struct ip_header', which requires 4 byte alignment
> 0x55b4ffee8246: note: pointer points here
>  01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff ff
> ff ff 00 00 00 00 00 00  00 00
>              ^
> /home/petmay01/linaro/qemu-for-merges/hw/net/net_tx_pkt.c:201:27:
> runtime error: load of misaligned address 0x55b4ffee8246 for type
> 'uint8_t' (aka 'unsigned char'), which requires 4 byte alignment
> 0x55b4ffee8246: note: pointer points here
>  01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff ff
> ff ff 00 00 00 00 00 00  00 00
>              ^
> /home/petmay01/linaro/qemu-for-merges/hw/net/net_tx_pkt.c:208:65:
> runtime error: member access within misaligned address 0x55b4ffee8246
> for type 'struct ip_header', which requires 4 byte alignment
> 0x55b4ffee8246: note: pointer points here
>  01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff ff
> ff ff 00 00 00 00 00 00  00 00
>              ^
> /home/petmay01/linaro/qemu-for-merges/hw/net/net_tx_pkt.c:210:13:
> runtime error: member access within misaligned address 0x55b4ffee8246
> for type 'struct ip_header', which requires 4 byte alignment
> 0x55b4ffee8246: note: pointer points here
>  01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff ff
> ff ff 00 00 00 00 00 00  00 00
>              ^
> /home/petmay01/linaro/qemu-for-merges/hw/net/net_tx_pkt.c:210:13:
> runtime error: load of misaligned address 0x55b4ffee8246 for type
> 'uint8_t' (aka 'unsigned char'), which requires 4 byte alignment
> 0x55b4ffee8246: note: pointer points here
>  01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff ff
> ff ff 00 00 00 00 00 00  00 00
>              ^
> 
> Sorry for the late report, I didn't quite have time
> to process the pull before Christmas holidays.
> 
> thanks
> -- PMM

So it's an existing bug exposed by the test.
I've reverted the test for now but I didn't rebase
as there are downstream trees based on this pull req.

-- 
MST
