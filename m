Received: from eggs.gnu.org ([2001:4830:134:3::10]:43244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fAXx4-0001Ii-Px
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fAXx0-0005Tf-R9
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:40:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42278 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fAXx0-0005T4-K4
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:39:58 -0400
Date: Mon, 23 Apr 2018 10:39:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180423093944.GE3267@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180417224054.26363-1-lersek@redhat.com>
	<87po2wzysh.fsf@dusky.pond.sub.org>
	<8a52bb49-4194-3b91-8b67-a0e5700fd6ed@redhat.com>
	<87in8nvdpn.fsf@dusky.pond.sub.org>
	<20180419075629.GC10259@redhat.com>
	<5ed8b01f-7faa-b23d-5fd2-f4715294e061@redhat.com>
	<20180419091201.GI10259@redhat.com>
	<a9006770-b4e3-cf57-3efa-c967740f7a94@redhat.com>
	<20180420093457.GE21035@redhat.com>
	<20180423001010.GA19804@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180423001010.GA19804@umbus.fritz.box>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, libvir-list@redhat.com, Michal Privoznik <mprivozn@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, David Gibson <dgibson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Apr 23, 2018 at 10:10:10AM +1000, David Gibson wrote:
> On Fri, Apr 20, 2018 at 10:34:57AM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Fri, Apr 20, 2018 at 10:11:08AM +0200, Laszlo Ersek wrote:
> > > On 04/19/18 11:12, Daniel P. Berrang=C3=A9 wrote:
> > > > On Thu, Apr 19, 2018 at 10:39:32AM +0200, Laszlo Ersek wrote:
> > > >> On 04/19/18 09:56, Daniel P. Berrang=C3=A9 wrote:
> > > >>> On Thu, Apr 19, 2018 at 09:48:36AM +0200, Markus Armbruster wro=
te:
> > > >>>> Laszlo Ersek <lersek@redhat.com> writes:
> > > >>>>
> > > >>>>> On 04/18/18 10:47, Markus Armbruster wrote:
> > > >>>>>> Laszlo Ersek <lersek@redhat.com> writes:
> > > >>>> Replacing CpuInfoArch by such an enum will change the discrimi=
nator
> > > >>>> value from "other" to the real architecture, with the obvious
> > > >>>> compatibility concerns.  But we've accepted similar changes tw=
ice
> > > >>>> already: commit 9d0306dfdfb and commit 25fa194b7b1, both v2.12=
.0-rc0.
> > > >>>>
> > > >>>> "other" was a bad idea.  Hindsight 20/20.
> > > >>>>
> > > >>>> Getting rid of it in one go rather than piecemeal seems like t=
he least
> > > >>>> bad way out.  Too late for 2.12, though.  Eric, what do you th=
ink?
> > > >>>
> > > >>> Given the context in which this "other" value is used, I think =
it is
> > > >>> reasonable to kill it and put a full arch list in there.
> > > >>>
> > > >>> No app is likely to be accessing the struct under "other" becau=
se it
> > > >>> is just an empty placeholder.
> > > >>
> > > >> Commit 9d0306dfdfb added "s390" and "CpuInfoS390", which I guess=
 had the
> > > >> potential to confuse QMP clients that didn't expect "s390", but
> > > >> otherwise it didn't mess with preexistent enum values / structur=
es.
> > > >=20
> > > > NB, qemu-system-s390x would previously have returned "other" in
> > > > this field, and now it returns "s390".  So while it didn't
> > > > remove "other" from the list of things that could potentially
> > > > exist, it did change what the s390x binary will actually report.
> > > >=20
> > > >> The same applies to commit 25fa194b7b1, just with "riscv" /
> > > >> "CpuInfoRISCV" substituted.
> > > >>
> > > >> Removing "other" might confuse QMP clients that expect it, excep=
t
> > > >> (according to Daniel) no such client exists, probably.
> > > >=20
> > > > When I say removing "other", I imply that we add an explicit arch
> > > > for all those which we currently are missing. IOW, all qemu-syste=
m-XXX
> > > > binaries which currently report "other" would change to report th=
eir
> > > > respective "XXX" values.
> > > >=20
> > > > So in this way, it is exactly the same as what we did when we
> > > > introduced "s390" as an option.
> > > >=20
> > > > The only difference is that once we have every binary reporting t=
he
> > > > correct arch, we can now also remove "other" from the schema itse=
lf
> > > > as it will then be unused.
> > >=20
> > > Can we please translate this into more actionable items for me, bec=
ause
> > > I'm getting confused :)
> > >=20
> > > First, if I add "i386" and "x86_64" to the enum list, we'll have al=
l
> > > three of "i386", "x86_64" and "x86". Is that useful? How will that =
work?
> >=20
> > Hmm, yes, on closer look this is a big mess as it is. We've been usin=
g
> > generic terms for covering multiple architectures :-(  'x86' for both
> > i386 and x86_64,  'sparc' for sparc and sparc64, etc. If we try to fi=
x
> > that we'll be entering a world of backcompat hurt :-(
> >=20
> > Since your schema is likely to end up just being a file in docs/specs=
,
> > rather than directly part of our existnig qapi schema, I suggest we j=
ust
> > ignore whats there. Just define an arch enum in your spec which is ri=
ght,
> > and let someone else worry about fixing the mess
>=20
> Trouble is, for these "biarch" cases, I'm not sure it's always clear
> what the right value for a firmware is.  While whether a userspace
> binary is i386 or x86_64 is clear and well-defined, a firmware could
> well be responsible for switching the CPU from its reset mode into the
> more modern 64-bit mode, and would therefore have at least some code
> in both archs.

In the context of these firmware metadata files, the architecture is
essentially the QEMU target binary architecture name, as it has an
associated list of machine types from that binary.

So 'i386' refers to qemu-system-i386, and the fact that qemu-system-x86_6=
4
can run 'i386' is not applicable - you'd use the 'x86_64' firmware metada=
ta
rules for that.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
