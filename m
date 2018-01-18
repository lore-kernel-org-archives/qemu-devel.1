Received: from eggs.gnu.org ([2001:4830:134:3::10]:44068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ecDwt-0000Zz-5X
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ecDwn-0000bt-7k
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:25:59 -0500
Date: Thu, 18 Jan 2018 18:25:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180118182547.2e1b630b.cohuck@redhat.com>
In-Reply-To: <20180118182317.4ab785be@p-imbrenda.boeblingen.de.ibm.com>
References: <1516035122-7617-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<20180118172034.3dda2622.cohuck@redhat.com>
	<20180118175229.42b27779@p-imbrenda.boeblingen.de.ibm.com>
	<20180118180240.7d678384.cohuck@redhat.com>
	<20180118182317.4ab785be@p-imbrenda.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] s390x: fix storage attributes
 migration for non-small guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu, 18 Jan 2018 18:23:17 +0100
Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:

> On Thu, 18 Jan 2018 18:02:40 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Thu, 18 Jan 2018 17:52:29 +0100
> > Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:
> >   
> > > On Thu, 18 Jan 2018 17:20:34 +0100
> > > Cornelia Huck <cohuck@redhat.com> wrote:
> > >     
> > > > On Mon, 15 Jan 2018 17:52:02 +0100
> > > > Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:
> > > >       
> > > > > Fix storage attribute migration so that it does not fail for
> > > > > guests with more than a few GB of RAM. Migration itself was
> > > > > successful, but storage attributes were not migrated completely.
> > > > > 
> > > > > This patch fixes the migration of all storage attributes, even
> > > > > when the guest have large amounts of memory.
> > > > > 
> > > > > Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> > > > > Fixes: 903fd80b03243476 ("s390x/migration: Storage attributes
> > > > > device") ---
> > > > >  hw/s390x/s390-stattrib-kvm.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/hw/s390x/s390-stattrib-kvm.c
> > > > > b/hw/s390x/s390-stattrib-kvm.c index 41770a7..480551c 100644
> > > > > --- a/hw/s390x/s390-stattrib-kvm.c
> > > > > +++ b/hw/s390x/s390-stattrib-kvm.c
> > > > > @@ -116,7 +116,7 @@ static void
> > > > > kvm_s390_stattrib_synchronize(S390StAttribState *sa) for (cx =
> > > > > 0; cx + len <= max; cx += len) { clog.start_gfn = cx;
> > > > >              clog.count = len;
> > > > > -            clog.values = (uint64_t)(sas->incoming_buffer + cx
> > > > > * len);        
> > > > 
> > > > Hm, doesn't that even imply that you reference an area beyond the
> > > > buffer, as the <= max check does not catch this?      
> > > 
> > > what do you mean?
> > > 
> > > cx + len <= max catches the cases where you would write beyond the
> > > end of the buffer. if cx + len == max then we are filling the
> > > buffer to the last byte. and we will get out at the next
> > > iteration.    
> > 
> > Yes, but the problem is that your offset is too long, isn't it? (Where
> > cx + len <= max, but you use an offset of cx * len which may be >
> > max.)  
> 
> which is exactly why I'm removing that line. look at the very beginning
> of the line, there is a -
> 
> the replacement line (the one that starts with a +) has only cx

Err, yes :) I simply wanted to comment that this looks worse than "not
migrated completely".

> 
> > But maybe I'm simply too tired.  
> 
> looks like it :)
> 
> > >     
> > > > > +            clog.values = (uint64_t)(sas->incoming_buffer +
> > > > > cx); r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS,
> > > > > &clog); if (r) {
> > > > >                  error_report("KVM_S390_SET_CMMA_BITS failed:
> > > > > %s", strerror(-r)); @@ -126,7 +126,7 @@ static void
> > > > > kvm_s390_stattrib_synchronize(S390StAttribState *sa) if (cx <
> > > > > max) { clog.start_gfn = cx;
> > > > >              clog.count = max - cx;
> > > > > -            clog.values = (uint64_t)(sas->incoming_buffer + cx
> > > > > * len);      
> > > 
> > > and here we fill in the last pieces if there are any leftovers,
> > > which at this point are guaranteed to be smaller than len.
> > >     
> > > > > +            clog.values = (uint64_t)(sas->incoming_buffer +
> > > > > cx); r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS,
> > > > > &clog); if (r) {
> > > > >                  error_report("KVM_S390_SET_CMMA_BITS failed:
> > > > > %s", strerror(-r));        
> > > >       
> > >     
> >   
> 
