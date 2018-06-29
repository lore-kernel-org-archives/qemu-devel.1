Received: from eggs.gnu.org ([2001:4830:134:3::10]:49627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1fYsGp-0003wH-KO
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1fYsGk-0007YU-GF
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:12:59 -0400
Received: from 185-219-166-8-static.vivo.cz ([185.219.166.8]:37152
	helo=smtp.vivo.cz)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1fYsGk-0007Wv-4M
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:12:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.vivo.cz (Postfix) with ESMTP id 50B47214758
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 14:12:52 +0200 (CEST)
Received: from smtp.vivo.cz ([127.0.0.1])
	by localhost (smtp.vivo.cz [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KPapWe6Ns5Pk for <qemu-devel@nongnu.org>;
	Fri, 29 Jun 2018 14:12:51 +0200 (CEST)
Received: from mamuti.net (85-132-149-57-static.vivo.cz [85.132.149.57])
	by smtp.vivo.cz (Postfix) with ESMTPS id 22E92133C32E
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 14:12:51 +0200 (CEST)
Date: Fri, 29 Jun 2018 14:12:51 +0200
From: Jiri Denemark <jdenemar@redhat.com>
Message-ID: <20180629121251.GB5072@orkuz.home>
References: <20180628154502.GO3513@redhat.com>
	<20180628195227.GH7451@localhost.localdomain>
	<20180629101417.GB27016@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180629101417.GB27016@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] CPU model versioning separate from machine type
 versioning ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org

On Fri, Jun 29, 2018 at 11:14:17 +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Jun 28, 2018 at 04:52:27PM -0300, Eduardo Habkost wrote:
> > On Thu, Jun 28, 2018 at 04:45:02PM +0100, Daniel P. Berrang=E9 wrote:
> > [...]
> > > What if we can borrow the concept of versioning from machine types =
and apply
> > > it to CPU models directly. For example, considering the history of =
"Haswell"
> > > in QEMU, if we had versioned things, we would by now have:
> > >=20
> > >      Haswell-1.3.0 - first version (37507094f350b75c62dc059f998e718=
5de3ab60a)
> > >      Haswell-2.2.0 - added 'rdrand' (78a611f1936b3eac8ed78a2be2146a=
742a85212c_
> > >      Haswell-2.3.0 - removed 'hle' & 'rtm' (a356850b80b3d13b2ef737d=
ad2acb05e6da03753)
> > >      Haswell-2.5.0 - added 'abm' (becb66673ec30cb604926d247ab9449a6=
0ad8b11
> > >      Haswell-2.12.0 - added 'spec-ctrl' (ac96c41354b7e4c70b756342d9=
b686e31ab87458)
> > >      Haswell-3.0.0  - added 'ssbd' (never done)
> > >=20
> > > If we followed the machine type approach, then a bare "Haswell" wou=
ld
> > > statically resolve at build time to the most recent Haswell-X.X.X v=
ersion
> > > associated with the QEMU release. This is unhelpful as we have a di=
rect
> > > dependancy on the host hardware features. Better would be for a bar=
e
> > > "Haswell" to be dynamically resolved at runtime, picking the most r=
ecent
> > > version that is capable of launching given the current hardware, KV=
M/TCG impl
> > > and QEMU version.
> > >=20
> > >   ie -cpu  Haswell
> > >=20
> > > should use Haswell-2.5.0  if on silicon with the TSX errata applied=
,
> > > but use Haswell-2.12.0 if the Spectre errata is applied in microcod=
e,
> > > and use Haswell-3.0.0 once Intel finally releases SSBD microcode er=
rata.
> >=20
> > Doing this unconditionally would make
> > "-machine pc-q35-3.1 -cpu Haswell" unsafe for live migration, and
> > break existing usage.  But this behavior could be enabled
> > explicitly somehow.
>=20
> True, for full back compat with existing libvirt we would probably
> want to opt-in to it.
>=20
> eg  -cpu Haswell could pick a fixed Haswell--XXX version according
> to the machine type.  -cpu Haswell,best=3Don  could pick best version
> for the host with the caveat about migration between heterogenous
> hosts.

I was thinking we could even separate the CPU model version from the
name itself:

    -cpu Haswell                    (the old, compatible way)
    -cpu Haswell,version=3Dbest
    -cpu Haswell,version=3D2.12.0

It would be slightly more work for the upper management layers, but IMHO
it would make more sense.

In any case, we have to think about keeping guest ABI stable.

I hope the automatic version selection would not cause any problems for
subsequent cold starts (such as Windows activation issues). It should be
very similar to updating CPU microcode which the guest OS is already
supposed to deal with in real hardware. However, in the past QEMU
changed CPU signature (family, model, stepping) for new machine types
and it is likely to happen with separately versioned CPU models too. I
believe CPU microcode updates do not touch these values. On the other
hand, it's similar to host-model and the user can always specify exact
version to avoid this slight change should it be a problem.

Once the domain starts, we need to keep stable ABI across migrations,
save/restores, or snapshots. Libvirt already does so by talking to QEMU
before starting vCPUs and checking for disabled/enabled features. Then
we store this information in the active domain XML to make sure we can
enforce the same CPU later. This concept would need to be enhanced to
include the CPU model version which QEMU would need to be able to
report.

A significantly more fun would result from letting libvirt use the
versioned CPU model stuff by default without an explicit knob in the
XML. But I guess you don't want to go that direction, do you?

Jirka
