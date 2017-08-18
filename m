Received: from eggs.gnu.org ([2001:4830:134:3::10]:47505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1did7e-0005H1-CZ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 04:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1did7a-0002l4-GU
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 04:59:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1did7a-0002j6-5Y
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 04:59:14 -0400
Date: Fri, 18 Aug 2017 09:59:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170818085908.GB2222@work-vm>
References: <8b120ab5-5319-30d6-6971-411c7e5c4330@univention.de>
	<20170814183910.GA2469@work-vm>
	<35734e50-0fe7-1809-1826-f6f28856ff88@redhat.com>
	<410b3398-470f-4434-7488-890054b4921b@univention.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410b3398-470f-4434-7488-890054b4921b@univention.de>
Subject: Re: [Qemu-devel] RFH: difference in read-only mapped bios.bin -
 memory corruption?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philipp Hahn <hahn@univention.de>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

* Philipp Hahn (hahn@univention.de) wrote:
> Hello,
> 
> Am 15.08.2017 um 13:25 schrieb Laszlo Ersek:
> > On 08/14/17 20:39, Dr. David Alan Gilbert wrote:
> >> * Philipp Hahn (hahn@univention.de) wrote:
> >>> I'm currently investigating a problem, were a Linux VM does not reboot
> >>> and gets stuck in the SeaBIOS reboot code:
> >>>
> >>> I'm using SeaBIOS-1.7 from Debian with a more modern qemu-2.8
> ...>>> If I dump both regions and compare them, I get a difference:
> ...>> You might want seabios commit c68aff5 and b837e6 that got fixed after
> >> I tracked down some reboot hangs - although they were rare, not every
> >> time.  c68aff5 did certainly cause a corruption, and the address of that
> >> corruption was determined at link time and could overlay random useful
> >> bits of code if you were unlucky.
> 
> Thanks you for the commit IDs - to me this looks like they fixed the
> problem. Testing with seabios-1.10 does not show any reboot problem so far.
> 
> >>> 1. How can it be, that the low-mem ROM mapping is modified?
> >>
> >> I can't remember all the details, but PC ROM is shadowed and mapped over
> >> with RAM at various times,
> > 
> > Right. I don't remember for sure, but I believe the state of the PAM
> > registers doesn't only affect what the VCPUs see in that address range,
> > but also what your monitor commands will dump. (This would be the
> > logical choice -- make the monitor output what the VCPUs see anyway, at
> > the moment, dependent on the PAM settings.)
> 
> That makes sense.
> Do you know by change what change in Qemu triggered that bug, as I've
> never seen any reboot problem with qemu-1.1.2, but only since switching
> to qemu-2.8?

I didn't go back as far as 1.1.2, but I tried bisecting around 2.4/2.6
before I understood the failure and the bisect was very flaky;  I think
in the end it's a timing race where it comes down to the exact corrupt
value;  going back to ancient qemu might be taking some other path
through seabios but I ddin't investigate.

Dave

> Thanks again for your excellent help.
> 
> Philipp
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
