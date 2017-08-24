Received: from eggs.gnu.org ([2001:4830:134:3::10]:56693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkpG5-00023h-G9
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkpG4-0007bv-Jc
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:21:05 -0400
References: <20170818211542.5380-1-eblake@redhat.com>
	<20170818211542.5380-9-eblake@redhat.com>
	<e44a3300-cbe9-c9d7-ae49-b223f638d7ea@redhat.com>
	<da3712de-986d-8130-7a97-e9f1071d2a03@redhat.com>
	<c665235d-8bec-627a-f750-4dc2798c3d8c@redhat.com>
	<5d84655b-d82a-956a-f434-023961b23552@redhat.com>
	<2ffb6aab-09a0-7136-946f-f68f7478c0f7@redhat.com>
	<bddc04d6-686e-ca5c-ef30-6df7bdb9c3bf@redhat.com>
	<87h8wxqunl.fsf@dusky.pond.sub.org>
	<e1c18d2a-ac5e-2892-3343-80b943345f3e@redhat.com>
	<874lsxnupg.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <221c272d-60de-1443-1471-2266b4e1c86b@redhat.com>
Date: Thu, 24 Aug 2017 12:20:54 +0200
MIME-Version: 1.0
In-Reply-To: <874lsxnupg.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 08/13] tests: Rely more on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, "open list:Floppy" <qemu-block@nongnu.org>

On 24/08/2017 12:09, Markus Armbruster wrote:
> Cut-and-paste cuts both ways (pardon the pun):
>=20
>     initialize with QTestState A
>     frobnicate with QTestState A
>     glomnify with QTestState A
>     frobnicate with QTestState A
>     initialize with QTestState B
>     boingboing with QTestState B
>     finalize with QTestState A
>     finalize with QTestState A
>=20
> Uh, forgot to frobnicate after boingboing, let me fix that real quick!
>=20
>     initialize with QTestState A
>     frobnicate with QTestState A
>     glomnify with QTestState A
>     frobnicate with QTestState A
>     initialize with QTestState B
>     boingboing with QTestState B
>     frobnicate with QTestState A
>     finalize with QTestState A
>     finalize with QTestState A
>=20
> Spot the pasto.
>
> This hasty paste would simply work with global_qtest.  I'm not claiming
> there are cases that are just the opposite.  I'm just challenging your
> apparent claim that the long forms help with avoiding or catching
> pastos.  Can you explain how they help more than they hurt?

A pasto without global_qtest is local.

But cut-and-paste that involves _assigning_ global_qtest, even if it
doesn't have cut-and-paste mistakes, may create a mess of functions
knowing^Wbelieving they know what global_qtest is.

Assigning global_qtest means the short-form functions have effectively
dynamic binding.  In a perfect world, global_qtest would be static and
the create-and-assign-global would assert(!global_qtest).  Then >1 VM ->
don't use the short forms.

Paolo

> A bit of global state isn't automatically bad.  *Shared* global state i=
s
> what gets us into trouble.  Can you point to examples where global_qtes=
t
> is shared in ways that aren't 100% trivial?
