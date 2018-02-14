Received: from eggs.gnu.org ([2001:4830:134:3::10]:46455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eltDJ-0004oV-1t
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:18:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eltDD-0000es-1j
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:18:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35298 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eltDC-0000di-Tb
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:18:46 -0500
Date: Wed, 14 Feb 2018 10:18:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180214101826.2a05bfd6.cohuck@redhat.com>
In-Reply-To: <7052eafd-b231-bb93-298d-95913e825c45@redhat.com>
References: <20180214001105.21508-1-mdroth@linux.vnet.ibm.com>
	<7052eafd-b231-bb93-298d-95913e825c45@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a blog post documenting
 Spectre/Meltdown options for QEMU 2.11.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>

On Wed, 14 Feb 2018 10:05:24 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 14.02.2018 01:11, Michael Roth wrote:

> > +## enabling mitigations for s390 KVM guests
> > +
> > +For s390 guests there are 2 CPU options relating to Spectre/Meltdown:
> > +
> > +* bpb: Branch prediction blocking
> > +* ppa15: PPA15 is installed
> > +
> > +**bpb** requires a host kernel patched with:
> > +
> > +    commit 35b3fde6203b932b2b1a5b53b3d8808abc9c4f60
> > +    KVM: s390: wire up bpb feature
> > +
> > +and both **bpb** and **ppa15** require a firmware with the appropriate support
> > +level as well as guest kernel patches to enable the functionality within
> > +guests. Please check with your distro/vendor to confirm.
> > +
> > +Both **bpb** and **ppa15** are enabled by default with newer/patched host
> > +kernels, and can also be set manually. For example:
> > +
> > +    qemu-system-s390x -M s390-ccw-virtio-2.11 ... \
> > +      -cpu zEC12,bpb=on,ppa15=on   
> 
> IIRC we only enable them by default with "-cpu host" ? Cornelia, David,
> Christian, can you confirm?

-cpu host enables them if present, as does specifying the full model
(which will fail if not present on the host).

> So maybe better rephrase the above to:
> 
> Both **bpb** and **ppa15** are enabled by default when using "-cpu host"
> and when the host kernels supports these facilities. For other CPU

"and when both the host hardware and the host kernel supports..." ?

(Although that's still a bit misleading, as we only require the bpb KVM
interface; otherwise, the controls are pretty much independent from
what the host is doing IIUC.]

> models, the flags have to be set manually. For example:
> 
>     qemu-system-s390x -M s390-ccw-virtio-2.11 ... \
>       -cpu zEC12,bpb=on,ppa15=on
> 
> > +WRT to migration, enabling **bpb** requires the source/target also have **bpb**
> > +enabled. Since this is enabled by default, you must ensure that **bpb**=off if  
> 
> s/**bpb**=off/**bpb**=off is used/ ?
> 
> > +you wish to maintain migration compatibility with existing guests, or take
> > +steps to reboot guests with **bpb** enabled prior to migrating them.  
> 
>  Thomas
