Received: from eggs.gnu.org ([2001:4830:134:3::10]:44097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dDx1C-0005Di-Br
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dDx18-0000ER-H2
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:57:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dDx18-0000Cp-7k
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:57:46 -0400
Date: Thu, 25 May 2017 20:57:43 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170525204018-mutt-send-email-mst@kernel.org>
References: <7ff05785-6bca-a886-0eb0-aeeb0f8d8e1a@redhat.com>
	<5923CCF2.2000001@intel.com>
	<3d9e8375-fbaa-c011-8242-b37cd971069b@redhat.com>
	<5924136A.4090004@intel.com>
	<7636d3d0-a0de-f9a6-47f8-2d09a448b978@redhat.com>
	<592544D9.5010100@intel.com>
	<23dac05e-ba3d-df6d-4831-feab9be1c6d2@redhat.com>
	<5926C7AC.4080603@intel.com>
	<6a6ecbcd-e9ae-1cf0-ccd9-14294cd0cf86@redhat.com>
	<5367a1b2-b3cc-8df2-c9ec-99fb60a57666@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5367a1b2-b3cc-8df2-c9ec-99fb60a57666@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [virtio-dev] Re:
 [PATCH v2 00/16] Vhost-pci for inter-VM communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, Stefan Hajnoczi <stefanha@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>

On Thu, May 25, 2017 at 08:31:09PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B405=E6=9C=8825=E6=97=A5 20:22, Jason Wang wrote:
> > > >=20
> > > > Even with vhost-pci to virito-net configuration, I think rx
> > > > zerocopy could be achieved but not implemented in your driver
> > > > (probably more easier in pmd).
> > > >=20
> > > Yes, it would be easier with dpdk pmd. But I think it would not be
> > > important in the NFV use case,
> > > since the data flow goes to one direction often.
> > >=20
> > > Best,
> > > Wei
> > >=20
> >=20
> > I would say let's don't give up on any possible performance optimizat=
ion
> > now. You can do it in the future.
> >=20
> > If you still want to keep the copy in both tx and rx, you'd better:
> >=20
> > - measure the performance of larger packet size other than 64B
> > - consider whether or not it's a good idea to do it in vcpu thread, o=
r
> > move it to another one(s)
> >=20
> > Thanks
>=20
> And what's more important, since you care NFV seriously. I would really
> suggest you to draft a pmd for vhost-pci and use it to for benchmarking=
.
> It's real life case. OVS dpdk is known for not optimized for kernel dri=
vers.
>=20
> Good performance number can help us to examine the correctness of both
> design and implementation.
>=20
> Thanks

I think that's a very valid point. Linux isn't currently optimized to
handle packets in device BAR.

There are several issues here and you do need to address them in the
kernel, no way around that:

1. lots of drivers set protection to
        vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);

   vfio certainly does, and so I think does pci sysfs.
   You won't get good performance with this, you want to use
   a cacheable mapping.
   This needs to be addressed for pmd to work well.

2. linux mostly assumes PCI BAR isn't memory, ioremap_cache returns __iom=
em
   pointers which aren't supposed to be dereferenced directly.
   You want a new API that does direct remap or copy if not possible.
   Alternatively remap or fail, kind of like pci_remap_iospace.
   Maybe there's already something like that - I'm not sure.


Thanks,
MST

--=20
MST
