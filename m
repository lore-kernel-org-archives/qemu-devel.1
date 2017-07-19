Received: from eggs.gnu.org ([2001:4830:134:3::10]:54289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXnwA-00040p-Bm
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXnw7-0007hY-3A
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:18:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dXnw6-0007h9-Si
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:18:39 -0400
Date: Wed, 19 Jul 2017 14:18:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170719141832.735af9ca@gondolin>
In-Reply-To: <1bee2360-8107-590f-434c-fb2a946f34f4@redhat.com>
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170718142455.32676-5-cohuck@redhat.com>
	<1bee2360-8107-590f-434c-fb2a946f34f4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 4/9] s390x/pci: do not advertise pci
 on non-pci builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On Wed, 19 Jul 2017 13:41:04 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 18.07.2017 16:24, Cornelia Huck wrote:
> > Only set the zpci and aen feature bits on builds that actually
> > support pci.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  target/s390x/kvm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> > index 831492f9a2..880eccd58a 100644
> > --- a/target/s390x/kvm.c
> > +++ b/target/s390x/kvm.c
> > @@ -2685,8 +2685,10 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
> >      }
> >  
> >      /* set zpci and aen facilities */
> > +#ifdef CONFIG_PCI
> >      set_bit(S390_FEAT_ZPCI, model->features);
> >      set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
> > +#endif
> >  
> >      if (s390_known_cpu_type(cpu_type)) {
> >          /* we want the exact model, even if some features are missing */  
> 
> Have you tried whether this actually still works right in builds where
> CONFIG_PCI is enabled? I'm afraid, but I think the #ifdef does not work
> here, since CONFIG_PCI is a Makefile-only setting, and it does not get
> set in config-target.h at all...

Of course it does not. Sigh.

I think I'll just move this into a helper function in the zpci code
resp. the zpci stub.
