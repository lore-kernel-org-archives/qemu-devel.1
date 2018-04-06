Received: from eggs.gnu.org ([2001:4830:134:3::10]:39409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f4Nso-0007Ne-6F
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f4Nsk-0008PP-4W
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:42:10 -0400
Date: Fri, 6 Apr 2018 11:42:02 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180406114202.2cf34236.cohuck@redhat.com>
In-Reply-To: <8080442a-bd0b-6231-630c-39b48f910c7a@redhat.com>
References: <1522940844-12336-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1522940844-12336-4-git-send-email-mihajlov@linux.vnet.ibm.com>
	<8080442a-bd0b-6231-630c-39b48f910c7a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] s390: Do not pass inofficial IPL type
 to the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Fri, 6 Apr 2018 11:28:31 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 05.04.2018 17:07, Viktor Mihajlovski wrote:
> > IPL over a virtio-scsi device requires special handling not
> > available in the real architecture. For this purpose the IPL
> > type 0xFF has been chosen as means of communication between
> > QEMU and the pc-bios. However, a guest OS could be confused
> > by seeing an unknown IPL type.
> > 
> > This change sets the IPL parameter type to 0x02 (CCW) to prevent
> > this. Pre-existing Linux has looked up the IPL parameters only in
> > the case of FCP IPL. This means that the behavior should stay
> > the same even if Linux checks for the IPL type unconditionally.
> > 
> > Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> > ---
> >  pc-bios/s390-ccw/bootmap.c |  7 +++++++
> >  pc-bios/s390-ccw/iplb.h    | 15 +++++++++++++--
> >  2 files changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> > index fc2a9fe..9287b7a 100644
> > --- a/pc-bios/s390-ccw/bootmap.c
> > +++ b/pc-bios/s390-ccw/bootmap.c
> > @@ -70,6 +70,13 @@ static void jump_to_IPL_code(uint64_t address)
> >  {
> >      /* store the subsystem information _after_ the bootmap was loaded */
> >      write_subsystem_identification();
> > +
> > +    /* prevent unknown IPL types in the guest */
> > +    if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {
> > +        iplb.pbt = S390_IPL_TYPE_CCW;
> > +        set_iplb(&iplb);
> > +    }
> > +
> >      /*
> >       * The IPL PSW is at address 0. We also must not overwrite the
> >       * content of non-BIOS memory after we loaded the guest, so we
> > diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
> > index 7dfce4f..5357a36 100644
> > --- a/pc-bios/s390-ccw/iplb.h
> > +++ b/pc-bios/s390-ccw/iplb.h
> > @@ -97,16 +97,27 @@ extern QemuIplParameters qipl;
> >  #define S390_IPL_TYPE_CCW 0x02
> >  #define S390_IPL_TYPE_QEMU_SCSI 0xff
> >  
> > -static inline bool store_iplb(IplParameterBlock *iplb)
> > +static inline bool manage_iplb(IplParameterBlock *iplb, bool store)
> >  {
> >      register unsigned long addr asm("0") = (unsigned long) iplb;
> >      register unsigned long rc asm("1") = 0;
> >  
> >      asm volatile ("diag %0,%2,0x308\n"
> >                    : "+d" (addr), "+d" (rc)
> > -                  : "d" (6)
> > +                  : "d" (store ? 6 : 5)
> >                    : "memory", "cc");  
> 
> I can't find a proper public specification for diag 308, so no clue how
> to review this properly. Christian, could you please have a look?

It does match the diag 308 store/load implementation in
target/s390x/diag.c... but a pointer to an official spec (if public)
would still be appreciated :)
