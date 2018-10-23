Received: from eggs.gnu.org ([2001:4830:134:3::10]:50870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gEwgV-0006V3-V0
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gEwgR-0001UX-Un
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:25:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gEwgN-0001Kl-GY
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:25:16 -0400
Date: Tue, 23 Oct 2018 14:25:05 +0100
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181023132505.GJ32717@xz-x1>
References: <CAHyh4xiVxNOxwWeKDw2ccAURx3zRMTd+nVLD=oav6ShqCBdjXw@mail.gmail.com>
	<20181022092710.GH32717@xz-x1>
	<CAHyh4xgOkoPokm5GQSH8dBDRrB-o1_MLhO8SnWK71VahUL8f+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHyh4xgOkoPokm5GQSH8dBDRrB-o1_MLhO8SnWK71VahUL8f+w@mail.gmail.com>
Subject: Re: [Qemu-devel] Virtual IOMMU is working for Windows VM?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jintack Lim <jintack@cs.columbia.edu>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, lprosek@redhat.com

On Mon, Oct 22, 2018 at 10:43:32AM -0400, Jintack Lim wrote:
> On Mon, Oct 22, 2018 at 5:27 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Mon, Oct 22, 2018 at 12:22:02AM -0400, Jintack Lim wrote:
> > > Hi,
> > >
> > > I wonder if vIOMMU is working for Windows VM?
> > >
> > > I tried it with v2.11.0, but it didn't seem to work. I assume that seaBIOS
> > > sets IOMMU on by default as is the case when I launched a Linux VM. But I
> > > might be missing something. Can somebody shed some light on it?
> >
> > Hi, Jintack,
> >
> 
> Thanks Peter,
> 
> > I think at least the latest QEMU should work for Windows, but I don't
> > really run Windows that frequently.
> >
> > What is the error you've encountered?  Have you tried the latest QEMU,
> > or switching Windows versions to try?
> 
> I ran Windows commands in Windows Powershell like below. Well, I guess
> this is not the best way to check IOMMU presence, but couldn't find a
> better way to do it.
> 
> $ (Get-VMHost).IovSupport
> false
> $ (Get-VMHost).IovSupportReasons
> The chipset on the system does not do DMA remapping, ...
> 
> I just tried QEMU v3.0.0, but I see the same symptom. I'm using
> Windows server 2016.  Unfortunately, trying another Windows version
> would be hard for me at this point.
> 
> I just wonder if there's way to check if Vt-d is on in SeaBIOS?

I'm not sure whether SeaBIOS would enable VT-d or has any kind of
support of it at all even if the translation unit is provided.

> 
> >
> > What I can remember about Windows is that Ladi had fixed a bug for
> > windows-only (8991c460be, "intel_iommu: relax iq tail check on
> > VTD_GCMD_QIE enable", 2017-07-03) but it should be even in 2.10 so I
> > guess it's not the problem you've encountered.
> 
> I'm CCing Ladi, just in case he has some idea :)

Good idea, though I'm afraid the RH email could be stall though. :)

I can try to install one Windows Server 2016 some day but I cannot
really guarantee.  Feel free to try to debug it on your own :).
Basically I would consider to enable the IOMMU traces in intel_iommu.c
just like what you have done before when with the vfio-pci devices and
check out the log.  Normally we should see plenty of MMIOs to setup
the device and hopefully that would provide hint on what's wrong there.

Regards,

-- 
Peter Xu
