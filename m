Received: from eggs.gnu.org ([2001:4830:134:3::10]:45546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1etfPV-0004hC-3m
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 15:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1etfPR-0007Np-Rd
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 15:11:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49962 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1etfPR-0007NZ-M4
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 15:11:33 -0500
Date: Wed, 7 Mar 2018 20:11:13 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180307201112.GK3089@work-vm>
References: <20180307165038.88640-1-brijesh.singh@amd.com>
	<20180307165038.88640-22-brijesh.singh@amd.com>
	<20180307172703.GH3089@work-vm>
	<6b8bf293-4a3c-5832-8617-a2b957f97a83@amd.com>
	<20180307182409.GI3089@work-vm>
	<7b76c3ca-dc35-8bea-2513-7b4da262c91d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <7b76c3ca-dc35-8bea-2513-7b4da262c91d@amd.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 21/28] sev/i386: add debug encrypt and
 decrypt commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Richard Henderson <rth@twiddle.net>

* Brijesh Singh (brijesh.singh@amd.com) wrote:
>=20
>=20
> On 3/7/18 12:24 PM, Dr. David Alan Gilbert wrote:
> > * Brijesh Singh (brijesh.singh@amd.com) wrote:
> >>
> >> On 03/07/2018 11:27 AM, Dr. David Alan Gilbert wrote:
> >>
> >> [...]
> >>
> >>>> +{
> >>>> +    SEVState *s =3D (SEVState *)handle;
> >>>> +
> >>>> +    /* If policy does not allow debug then no need to register op=
s */
> >>>> +    if (s->policy & SEV_POLICY_NODBG) {
> >>>> +        return;
> >>>> +    }
> >>> So what happens if someone tries to use a gdb or monitor command wh=
en
> >>> policy didn't allow debug?  Does it end up with an obvious error
> >>> somehow?
> >>>
> >> In those cases caller will get encrypted bytes, leading to unintelli=
gible
> >> data. It can sometime translate into  obvious errors e.g caller trie=
s to
> >> walk guest pagtable and it gets garbage and will have trouble dumpin=
g the
> >> pgtables etc. Many times qemu calls ldphys_* functions to access the=
 data it
> >> may get tricky to report the errors.
> > So would it make sense to have something like:
> >
> > sev_mem_cant_read(uint8_t *dst, const uint8_t *src, uint32_t len, Mem=
TxAttrs attrs)
> > {
> >     error_report("SEV Guest policy does not allow debug access");
> >
> >     return -EPERM;
> > }
>=20
> In very early patches we had something similar but I was not sure=A0 if
> that was right thing. Any debug accesses were=A0 printing ton of messag=
es

OK, if it would generate silly amounts of debug then leave it as is;
but I bet it'll confuse someone in the future when they try and dig
through it for debug without realising SEV-debug is there!

Dave

> and also in some case caller actually wants to dump the memory content
> (e.g x /10gx 0x000).. what we should return in those cases ? In my
> approach was if debug was not enabled then simply don't decrypt the
> memory and provide the raw data.
>=20
> There was some discussion to have very high level security policy which
> may have attribute like debug=3Don|off, if debug is disabled then QEMU
> monitor can display messages like debug not allowed to better inform us=
er.
>=20
>=20
> > void
> > sev_set_debug_ops(void *handle, MemoryRegion *mr)
> > {
> >     SEVState *s =3D (SEVState *)handle;
> >
> >     /* If policy does not allow debug then no need to register ops */
> >     if (s->policy & SEV_POLICY_NODBG) {
> >         sev_ops.read =3D sev_mem_cant_read;
> >         sev_ops.write =3D sev_mem_cant_write;
> >     } else {
> >         sev_ops.read =3D sev_mem_read;
> >         sev_ops.write =3D sev_mem_write;
> >     }
> >
> > Dave
> >
> >> -Brijesh
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
