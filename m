Received: from eggs.gnu.org ([2001:4830:134:3::10]:39281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eFGAh-0007bw-PQ
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eFGAe-0001K1-Ib
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:09:19 -0500
Date: Thu, 16 Nov 2017 10:09:10 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171116100910.1a9e291a.cohuck@redhat.com>
In-Reply-To: <07ba2257-d6b4-2a57-1151-21f3a69b89d0@de.ibm.com>
References: <20171115154223.109991-1-borntraeger@de.ibm.com>
	<20171115181034.5f0b624e.cohuck@redhat.com>
	<07ba2257-d6b4-2a57-1151-21f3a69b89d0@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390/kvm_virtio/linux-headers: remove
 traces of old virtio transport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On Thu, 16 Nov 2017 08:45:09 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 11/15/2017 06:10 PM, Cornelia Huck wrote:
> > On Wed, 15 Nov 2017 16:42:23 +0100
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> We no longer support the old s390 transport, neither does the newest
> >> Linux kernel. Remove it from the linux header script as well as the
> >> s390x virtio code.  We still should handle the VIRTIO_NOTIFY hypercall,
> >> to tolerate early printk on older guest kernels without an sclp console.  
> > 
> > Are there any such guests still around? Wouldn't they be unable to run
> > because of the missing old transport anyway?  
> 
> As far as I can see even an 4.13 will do
> 
> static int __init s390_virtio_console_init(void)
> {
>         if (sclp.has_vt220 || sclp.has_linemode)
>                 return -ENODEV;
>         return virtio_cons_early_init(early_put_chars);
> }
> console_initcall(s390_virtio_console_init);
> 
> No matter if there is the old transport or not available.
> 
> So as soon as somebody chooses virtio-console you should see the diag500 from the early
> printk.

Grmpf, and the first condition does not trigger when you don't define
any sclp console.

Oh well, it seems we still have to drag this along :(
 
> >   
> >> We continue to ignore these events.
> >>
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >>  hw/s390x/s390-virtio-hcall.h                   |  6 ++-
> >>  include/standard-headers/asm-s390/kvm_virtio.h | 64
> >> --------------------------
> >> scripts/update-linux-headers.sh                |  1 - 3 files
> >> changed, 4 insertions(+), 67 deletions(-) delete mode 100644
> >> include/standard-headers/asm-s390/kvm_virtio.h  
> >   

I think this becomes relevant only when someone does a headers update
against 4.15+, which is unlikely to happen in freeze. So I'll queue
this to s390-next only.
