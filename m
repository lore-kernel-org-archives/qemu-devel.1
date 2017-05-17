Received: from eggs.gnu.org ([2001:4830:134:3::10]:36436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1dB2K7-0003C5-Rv
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1dB2K4-0001nS-Mj
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:01:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:36854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1dB2K4-0001nE-CM
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:01:16 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Wed, 17 May 2017 17:01:11 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1ACB970@ORSMSX112.amr.corp.intel.com>
References: <1494972923-31756-1-git-send-email-anthony.xu@intel.com>
	<20170517112756.74cf6e47@nial.brq.redhat.com>
In-Reply-To: <20170517112756.74cf6e47@nial.brq.redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] Memory: use memory address space for
 cpu-memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>


> > If cpu-memory address space is same as memory address space,
> > use memory address space for cpu-memory address space.
> >
> > any memory region change causeaddress space to rebuild PhysPageMap,
> > rebuilding PhysPageMap is very expensive.
> >
> > removing cpu-memory address space reduces the guest boot time and
> > memory usage.
> >
> > Signed-off-by: Anthony Xu <anthony.xu@intel.com>
> > ---
> >  cpus.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/cpus.c b/cpus.c
> > index 740b8dc..15c7a6a 100644
> > --- a/cpus.c
> > +++ b/cpus.c
> > @@ -1748,8 +1748,13 @@ void qemu_init_vcpu(CPUState *cpu)
> >          /* If the target cpu hasn't set up any address spaces itself,
> >           * give it the default one.
> >           */
> > -        AddressSpace *as =3D address_space_init_shareable(cpu->memory,
> > -                                                        "cpu-memory");
> > +        AddressSpace *as;
> > +        if (cpu->memory =3D=3D address_space_memory.root) {
> > +            address_space_memory.ref_count++;
> probably this would cause reference leak when vcpu is destroyed

I thought address_space_destroy is called when vcpu is unplugged,
seems that's not the case, then ref_count++ is not needed.

Any other comments?


Thanks,
Anthony
