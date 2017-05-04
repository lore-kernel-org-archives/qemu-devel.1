Received: from eggs.gnu.org ([2001:4830:134:3::10]:39535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1d6Hob-0003yq-VQ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1d6HoY-0005ch-21
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:33:09 -0400
Message-ID: <1493908379.4214.8.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 04 May 2017 16:32:59 +0200
In-Reply-To: <20170427072843.8089-1-david@gibson.dropbear.id.au>
References: <20170427072843.8089-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv3 0/4] Clean up compatibility mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org, clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
Cc: agraf@suse.de, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Thu, 2017-04-27 at 17:28 +1000, David Gibson wrote:
> This is a rebased and revised version of my patches revising CPU
> compatiblity mode handling on ppc, last posted in November.=C2=A0=C2=A0=
Since
> then, many of the patches have already been merged (some for 2.9, some
> since).=C2=A0=C2=A0This is what's left.
>=C2=A0
>=C2=A0=C2=A0* There was conceptual confusion about what a compatibility =
mode
>=C2=A0=C2=A0=C2=A0=C2=A0means, and how it interacts with the machine typ=
e.=C2=A0=C2=A0This cleans
>=C2=A0=C2=A0=C2=A0=C2=A0that up, clarifying that a compatibility mode (a=
s an externally set
>=C2=A0=C2=A0=C2=A0=C2=A0option) only makes sense on machine types that d=
on't permit the
>=C2=A0=C2=A0=C2=A0=C2=A0guest hypervisor privilege (i.e. 'pseries')
>=C2=A0
>=C2=A0=C2=A0* It was previously the user's (or management layer's) respo=
nsibility
>=C2=A0=C2=A0=C2=A0=C2=A0to determine compatibility of CPUs on either end=
 for migration.
>=C2=A0=C2=A0=C2=A0=C2=A0This uses the compatibility modes to check that =
properly during an
>=C2=A0=C2=A0=C2=A0=C2=A0incoming migration.

I started playing with this, mostly with libvirt integration
in mind of course, and quickly ran into a behavior that I
believe was not intentional and unfortunately managed to slip
into 2.9, I assume through the patches which were initially
part of this series (mentioned above).

More specifically, when I run a guest with

=C2=A0 -M pseries-2.8 -cpu host

using QEMU 2.8, the CPU in the guest is reported as

=C2=A0 POWER8E (raw), altivec supported

However, when using QEMU 2.9 with the very same command line,
including explicitly using the pseries-2.8 machine type, I
get

=C2=A0 POWER8 (architected), altivec supported

instead. The same happens with current master + your patches
applied on top.

I'm not sure how much real trouble that will actually cause
for guests, but it's a guest-visible change as a result of
upgrading QEMU, which should just not happen.


I'll keep testing your series and get back to you as soon as
I have more feedback or questions.

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
