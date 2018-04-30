Received: from eggs.gnu.org ([2001:4830:134:3::10]:46512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fDDFD-000053-36
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fDDF9-00020D-1J
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:09:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fDDF8-0001zv-Rd
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:09:42 -0400
Date: Mon, 30 Apr 2018 12:09:41 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180430120941.741f31cb@w520.home>
In-Reply-To: <CAHyh4xjzi5CK8+OJPpnr+F2ABpy5Jbbo1S4YR5ATi62LMRn+Pw@mail.gmail.com>
References: <CAHyh4xgMqsxCUOH-_p=DWVWpp0stxfwdfFo2s2cn1nmR2v5Siw@mail.gmail.com>
	<CAHyh4xjzi5CK8+OJPpnr+F2ABpy5Jbbo1S4YR5ATi62LMRn+Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] How to check if Vt-d is capable of
 posted-interrupt?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jintack Lim <jintack@cs.columbia.edu>
Cc: iommu@lists.linux-foundation.org, QEMU Devel Mailing List <qemu-devel@nongnu.org>, KVM General <kvm@vger.kernel.org>

On Mon, 30 Apr 2018 13:44:23 -0400
Jintack Lim <jintack@cs.columbia.edu> wrote:

> Add iommu mailing list since this question might be more related to iommu.
> 
> On Mon, Apr 30, 2018 at 10:11 AM, Jintack Lim <jintack@cs.columbia.edu> wrote:
> > Hi,
> >
> > I wonder how to check if Vt-d is capable of posted-interrupt? I'm
> > using Intel E5-2630 v3.
> >
> > I was once told that APICv and posted-interrupt capability always come
> > together. But it seems like my cpu support APICv
> > (/sys/module/kvm_intel/parameters/enable_apicv is Y), but
> > posted-interrupt capability is only shipped with the next generation
> > of the cpu (E5-2600 v4, which is Broadwell).
> >
> > What would be an easy way to check this?

PI support is bit 59 in the capability register which is exposed
through sysfs at /sys/class/iommu/dmar*/intel-iommu/cap so you could do
something like:

# for i in $(find /sys/class/iommu/dmar* -type l); do echo -n "$i: "; echo $(( ( 0x$(cat $i/intel-iommu/cap) >> 59 ) & 1 )); done

I think the relationship between APICv and PI goes the other direction,
if you have PI, you probably have APICv.  Having APICv implies nothing
about having PI.  Thanks,

Alex
