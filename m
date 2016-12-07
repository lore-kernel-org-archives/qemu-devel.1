Received: from eggs.gnu.org ([2001:4830:134:3::10]:37713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEc5N-0003EV-GT
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 08:16:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEc5J-00074Z-60
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 08:16:37 -0500
Date: Wed, 7 Dec 2016 14:16:19 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161207131619.GD4773@noname.str.redhat.com>
References: <CANYihzr60=ctstmpVA-g-ttWFd+8kf7-vLws3Zjx-hudYP0LjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANYihzr60=ctstmpVA-g-ttWFd+8kf7-vLws3Zjx-hudYP0LjQ@mail.gmail.com>
Subject: Re: [Qemu-devel] vpc max table entries calculation error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nick Owens <mischief@coreos.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 29.11.2016 um 22:07 hat Nick Owens geschrieben:
> i'm writing to discuss an issue in qemu's vpc creation.
> 
> when creating a dynamic-type vpc image with qemu-img like so:
> 
> $ qemu-img create -f vpc vhd.vhd 100M
> Formatting 'vhd.vhd', fmt=vpc size=104857600
> 
> and then inspecting the file (with a tool i wrote; it's also easy to see in
> a hex dump):
> 
> $ vhd-inspect ./vhd.vhd
>                                   MaxTableEntries: 51
> BlockSize: 2097152
> PhysicalSize: 104865792
> VirtualSize: 104865792
> PhysicalSize/BlockSize = 50
> 
> we see that the MaxTableEntries differs from the PhysicalSize/BlockSize.

You did an integer division, which you can't really do because with only
50 blocks it couldn't describe the part of the image after the last
complete block. The real value is PhysicalSize/BlockSize = 50.00390625,
and rounding up is the only sane thing to do to give you an image with
this specific size.

> so, i am not sure what the right fix is here, as it seems vpc is very
> messy, but i do think that this is a bug because the incorrect
> MaxTableEntries causes other tools to miscompute the real disk size. when
> these dynamic-type vpcs with incorrect MaxTableEntries are converted to
> fixed-type and uploaded to Microsoft Azure, it results in the hypervisor
> rejecting the image.
> 
> does someone have an idea about the correct way to fix this?

You must use a multiple of the block size for the image size if you want
an exact result without any rounding. You'll have to use force_size=on
because adjusting the size to CHS will most likely fail to keep the size
at a multiple of the block size.

Yes, calling VHD "very messy" seems to be quite accurate. Creating an
image that works the same way both on Azure and the original Virtual PC
is almost impossible.

Kevin
