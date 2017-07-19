Received: from eggs.gnu.org ([2001:4830:134:3::10]:49188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXju5-00048r-GY
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:00:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXju2-0006zv-BW
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:00:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dXju2-0006zc-5P
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:00:14 -0400
Date: Wed, 19 Jul 2017 10:00:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170719100007.1071ce70@gondolin>
In-Reply-To: <5f8a2315-9224-f20c-7524-11f9a8ac8efd@de.ibm.com>
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170718142455.32676-5-cohuck@redhat.com>
	<5f8a2315-9224-f20c-7524-11f9a8ac8efd@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On Tue, 18 Jul 2017 21:56:26 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 07/18/2017 04:24 PM, Cornelia Huck wrote:
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
> >   
> 
> Not strictly necessary but do you also want to ifdef this
> 
>  kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
> 
> call?
> 
> If not you could actually even allow AEN but not PCI for !CONFIG_PCI.

I'm a bit unsure about the relationship of ais and aen with pci. I
remember that only adapters for pci currently support suppression,
although it could spread to other adapter types in the future. Not sure
about aen.

So I'd keep the ais enablement call, even though it won't have much of
an effect as no pci adapters will be registered.

As I don't quite remember what aen governed, I need to rely on your
feedback here.
