Received: from eggs.gnu.org ([2001:4830:134:3::10]:34119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1eHc9n-0005G9-2n
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 16:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1eHc9j-0001yk-K9
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 16:02:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44599)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1eHc9j-0001yD-Dy
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 16:02:03 -0500
Date: Wed, 22 Nov 2017 22:01:59 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20171122210158.GB21184@flask>
References: <20171122180908.31389-1-rkrcmar@redhat.com>
	<20171122202800.GU3037@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171122202800.GU3037@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] kvm: apic: save and restore x2APIC LDR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

2017-11-22 18:28-0200, Eduardo Habkost:
> On Wed, Nov 22, 2017 at 07:09:08PM +0100, Radim Kr=C4=8Dm=C3=A1=C5=99 w=
rote:
> > QEMU saves only 8 bits of APIC LDR, which means that it does not supp=
ort
> > x2APIC.  The correct way of fixing this would be to save and restore =
the
> > full 32 bit register, but because x2APIC LDR is a function of x2APIC =
ID,
> > we can also compute it and keep the migration format untouched.
> >=20
> > KVM always expected the LDR format to follow the xAPIC/x2APIC standar=
d,
> > but pre 4.1 KVMs used non-standard x2APIC ID in case the OS changed
> > xAPIC ID before switching to x2APIC, which means that QEMU has to use
> > the kvm_x2apic_api feature to derive the x2APIC ID.
> >=20
> > This bug has also been addressed on the KVM side with patch 5849d75a5=
c9b
> > ("KVM: lapic: Fixup LDR on load in x2apic").
>=20
> Is this sufficient to fix the bug on hosts that lack KVM commit
> 5849d75a5c9b, or we need both the KVM and QEMU patches?

Good point, either one is enough to fix the bug.
This patch makes x2APIC LDR work on old KVMs.
