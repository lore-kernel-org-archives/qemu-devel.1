Received: from eggs.gnu.org ([209.51.188.92]:52330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghH8o-0004NP-1l
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:55:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghH8l-0005kq-5M
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:55:40 -0500
Date: Wed, 9 Jan 2019 16:55:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190109165532.GX3998@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190102140535.11512-1-cfergeau@redhat.com>
	<20190102180158.GA6015@natto.ory.fergeau.eu>
	<4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
	<87o98sii5b.fsf@dusky.pond.sub.org>
	<20190107163606.GL23773@natto.ory.fergeau.eu>
	<87pnt7bflk.fsf@dusky.pond.sub.org>
	<d8a41aa9-42bf-94f0-d6e6-347547dc39da@redhat.com>
	<87bm4pewa8.fsf@dusky.pond.sub.org>
	<20190109144925.GT3998@redhat.com>
	<5ad4e813-64e4-4761-9675-7d73527ded9a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ad4e813-64e4-4761-9675-7d73527ded9a@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>, qemu-stable@nongnu.org

On Wed, Jan 09, 2019 at 04:02:28PM +0100, Max Reitz wrote:
> On 09.01.19 15:49, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Jan 09, 2019 at 03:32:47PM +0100, Markus Armbruster wrote:
> >> Max Reitz <mreitz@redhat.com> writes:
> >>
> >>> On 08.01.19 11:36, Markus Armbruster wrote:
> >>>> Copying block maintainers for help with assessing the bug's (non-)=
impact
> >>>> on security.
> >>>>
> >>>> Christophe Fergeau <cfergeau@redhat.com> writes:
> >>>>
> >>>>> On Mon, Jan 07, 2019 at 04:47:44PM +0100, Markus Armbruster wrote=
:
> >>>>>> Eric Blake <eblake@redhat.com> writes:
> >>>>>>
> >>>>>>> On 1/2/19 12:01 PM, Christophe Fergeau wrote:
> >>>>>>>> Adding Markus to cc: list, I forgot to do it when sending the =
patch.
> >>>>>>>
> >>>>>>> Also worth backporting via qemu-stable, now in cc.
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Christophe
> >>>>>>>>
> >>>>>>>> On Wed, Jan 02, 2019 at 03:05:35PM +0100, Christophe Fergeau w=
rote:
> >>>>>>>>> commit 8bca4613 added support for %% in json strings when int=
erpolating,
> >>>>>>>>> but in doing so, this broke handling of % when not interpolat=
ing as the
> >>>>>>>>> '%' is skipped in both cases.
> >>>>>>>>> This commit ensures we only try to handle %% when interpolati=
ng.
> >>>>>>
> >>>>>> Impact?
> >>>>>>
> >>>>>> If you're unable to assess, could you give us at least a reprodu=
cer?
> >>>>>
> >>>>> This all came from https://lists.freedesktop.org/archives/spice-d=
evel/2018-December/046644.html
> >>>>> Setting up a VM with libvirt with <graphics type=3D'spice' autopo=
rt=3D'yes' passwd=3D'password%'/>
> >>>>> fails to start with:
> >>>>>   qemu-system-x86_64: qobject/json-parser.c:146: parse_string: As=
sertion `*ptr' failed.
> >>>>>
> >>>>> If you use 'password%%' as the password instead, when trying to c=
onnect
> >>>>> to the VM, you type 'password%' as the password instead of 'passw=
ord%%'
> >>>>> as configured in the domain XML.
> >>>>
> >>>> Thanks.
> >>>>
> >>>> As the commit message says, the bug bites when we parse a string
> >>>> containing '%s' with !ctxt->ap.  The parser then swallows a charac=
ter.
> >>>> If it swallows the terminating '"', it fails the assertion.
> >>>>
> >>>> We parse with !ctxt->ap in the following cases:
> >>>>
> >>>> * Tests (tests/check-qjson.c, tests/test-qobject-input-visitor.c,
> >>>>   tests/test-visitor-serialization.c)
> >>>>
> >>>>   Plenty of tests, but we still failed to cover the buggy case :(
> >>>>
> >>>> * QMP input (monitor.c)
> >>>>
> >>>> * QGA input (qga/main.c)
> >>>>
> >>>> * qobject_from_json()
> >>>>
> >>>>   - JSON pseudo-filenames (block.c)
> >>>>
> >>>>     These are pseudo-filenames starting with "json:".
> >>>>
> >>>>   - JSON key pairs (block/rbd.c)
> >>>>
> >>>>     As far as I can tell, these can come only from pseudo-filename=
s
> >>>>     starting with "rbd:".
> >>>>
> >>>>   - JSON command line option arguments of -display and -blockdev
> >>>>     (qobject-input-visitor.c)
> >>>>
> >>>>     Reproducer: -blockdev '{"%"}'
> >>>>
> >>>> Command line, QMP and QGA input are trusted.
> >>>>
> >>>> Filenames are trusted when they come from command line, QMP or HMP=
.
> >>>> They are untrusted when they come from from image file headers.
> >>>> Example: QCOW2 backing file name.  Note that this is *not* the sec=
urity
> >>>> boundary between host and guest.  It's the boundary between host a=
nd an
> >>>> image file from an untrusted source.
> >>>>
> >>>> I can't see how the bug could be exploited.  Neither failing an
> >>>> assertion nor skipping a character in a filename of your choice is
> >>>> interesting.  We don't support compiling with NDEBUG.
> >>>>
> >>>> Kevin, Max, do you agree?
> >>>
> >>> I wouldn't call it "not interesting" if adding an image to your VM =
at
> >>> runtime can crash the whole thing.
> >>>
> >>> (qemu-img create -f qcow2 -u -b 'json:{"%"}' foo.qcow2 64M)
> >>
> >> "Not interesting" strictly from the point of view of exploiting the =
bug
> >> to penetrate trust boundaries.
> >>
> >>> Whether this is a security issue...  I don't know, but it is a DoS.
> >>
> >> I'm not sure whether feeding untrusted images to QEMU is a good idea=
 in
> >> general --- there's so much that could go wrong.  How hardened again=
st
> >> abuse are out block drivers?
> >>
> >> I figure what distinguishes this case is how utterly trivial creatin=
g a
> >> "bad" image is.
> >=20
> > Consider that you can already create a qcow2 image with a backing fil=
e
> > of /etc/shadow.
>=20
> If you cannot access this file, then it should just be an error and not
> crash qemu.
>=20
> If you can access this file, that's your own fault for bad permissions.
>
> > Or create a qcow2 image many EB in size that causes QEMU=20
> > to allocate massive amounts of RAM and/or burn CPU time, and so on.
>=20
> That would be the qcow2 driver's fault.  We do try to open only images
> which are sane.

The defintion of "sane" is quite hard though, as its contextual. There ar=
e
things that are sane when viewed from QEMU level, which can none the less
be considered a security bug from the mgmt app level. CPU/memory usage
associated with huge images is in this bucket I think, given how enourmou=
s
some disk images can genuinely be.

> And memory allocation failures should be handled gracefully, so the VM
> shouldn't crash.  Well, at least qcow2 does its best, what Linux makes
> of it, who knows.  (e.g. it may assign the memory to qemu and then the
> OOM killer may crash it later)

Yep, you'll quite likely succeed and trigger the OOM killer, or=20
alternatively succeed and push other running VMs out to swap
effectively inflicting a denial of service on them.

> > IOW, mgmt apps should never pass untrusted images to QEMU.  Crashing =
is
> > just one of many bad things, and probably not the worst that can happ=
en.
> >=20
> > They need to do validation upfront in some manner if receiving an=20
> > untrustworthy image. Openstack does this by running qemu-img, with=20
> > limits set on virutal memory size, CPU time, and then rejecting any=20
> > image with a backing file from being used at all.
> >=20
> >> Anyway, you are the block layer maintainers, so you get to decide
> >> whether to give this the full security bug treatment.  I'm merely th=
e
> >> clown who broke it %-/
> >=20
> > Accepting an image with any backing file at all from an untrusted use=
r
> > would be a flaw in the layered management app itself, not QEMU.
> >=20
> > So I think it would only be considered a security bug in QEMU if ther=
e was=20
> > a way for an unprivileged user to trick QEMU into writing malformed J=
SON
> > into an otherwise trusted image.
>=20
> Not making it a security bug makes me happy, of course, but I don't
> quite agree that qemu is not to blame if you pass it some image which
> makes it crash.

Certainly QEMU should never crash on any input. I just think that wrt=20
untrustworthy disk images, you need security protection well before you=20
get to a live QEMU VM process, so I think this can be just a "normal" bug=
.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
