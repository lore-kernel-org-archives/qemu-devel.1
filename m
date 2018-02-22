Received: from eggs.gnu.org ([2001:4830:134:3::10]:44920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eopbM-0007CV-C6
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eopbG-0000a7-6u
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:03:52 -0500
Date: Thu, 22 Feb 2018 12:03:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180222120334.GJ9323@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <7b01ba4b-7f5f-30c7-d6d8-3c22f2774e7e@kamp.de>
	<7c23f28d-ee14-c504-ae13-04414c4b032e@redhat.com>
	<20180222105755.GB4147@localhost.localdomain>
	<37efa6ac-8e36-9c96-84ef-a8639ba64937@kamp.de>
	<20180222113204.GC4147@localhost.localdomain>
	<20180222114053.GE9323@redhat.com>
	<ab206ced-9b56-93d5-04b7-f342d45a2927@kamp.de>
	<20180222120029.GI9323@redhat.com>
	<c46fd50f-3952-75a3-eb5a-a53a06c3bc4d@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c46fd50f-3952-75a3-eb5a-a53a06c3bc4d@kamp.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] Limiting coroutine stack usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, jsnow@redhat.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

On Thu, Feb 22, 2018 at 01:02:05PM +0100, Peter Lieven wrote:
> Am 22.02.2018 um 13:00 schrieb Daniel P. Berrang=C3=A9:
> > On Thu, Feb 22, 2018 at 12:51:58PM +0100, Peter Lieven wrote:
> >> Am 22.02.2018 um 12:40 schrieb Daniel P. Berrang=C3=A9:
> >>> On Thu, Feb 22, 2018 at 12:32:04PM +0100, Kevin Wolf wrote:
> >>>> Am 22.02.2018 um 12:01 hat Peter Lieven geschrieben:
> >>>>> Am 22.02.2018 um 11:57 schrieb Kevin Wolf:
> >>>>>> Am 20.02.2018 um 22:54 hat Paolo Bonzini geschrieben:
> >>>>>>> On 20/02/2018 18:04, Peter Lieven wrote:
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> I remember we discussed a long time ago to limit the stack usa=
ge of all
> >>>>>>>> functions that are executed in a coroutine
> >>>>>>>> context to a very low value to be able to safely limit the cor=
outine
> >>>>>>>> stack size as well.
> >>>>>>> IIRC the only issue was that hw/ide/atapi.c has mutual recursio=
n between
> >>>>>>> ide_atapi_cmd_reply_end -> ide_transfer_start -> ahci_start_tra=
nsfer ->
> >>>>>>> ide_atapi_cmd_reply_end.
> >>>>>>>
> >>>>>>> But perhaps it's not an issue, somebody needs to audit the code=
.
> >>>>>> I think John intended to get rid of the recursion sometime, but =
I doubt
> >>>>>> he has had the time so far.
> >>>>> Apart from this is is possible to define special cflags in the
> >>>>> Makefile.objs just for a subdirectory? I have patches ready to ma=
ke
> >>>>> the block layer files and other coroutine users compile with
> >>>>> -Wstack-size=3D2048. But I do not want to specify each file separ=
ately.
> >>>> Our Makefiles have lines like this:
> >>>>
> >>>>     iscsi.o-cflags     :=3D $(LIBISCSI_CFLAGS)
> >>>>
> >>>> I don't think there is a direct mechanism to apply cflags to a who=
le
> >>>> directory or just to block-obj-y/block-obj-m, but just looping ove=
r them
> >>>> could work. I'm not a Makefile expert at all, but after some toyin=
g with
> >>>> a simple example, something like this might work:
> >>>>
> >>>>     $(foreach x,$(block-obj-y),$(eval $x-cflags +=3D -Wstack-size=3D=
2048))
> >>> You'll need it for anything block layer depends on too - so that's =
much
> >>> of util/, crypto/ and io/ directories at least.
> >>>
> >>> So perhaps it would be shorter if we do the opposite - set -Wstack-=
size=3D2048
> >>> globally for everything in QEMU, and then override -Wstack-size=3D$=
BIGGER
> >>> for the (hopefully) few sources that have a larger stack need ?
> >> I tried that already. 2048 is a strong limit for many functions.
> >> It breaks already as soon as some buffer has a size of PATH_MAX, but
> >> thats handleable. But there are some structs around that are very la=
rge.
> > There are surprisingly few "char [PATH_MAX]" variables left in QEMU -=
 we
> > should have a final push to eliminate them regardless.
> >
> >> Generally, it would be a good idea to have a global limit, of course=
.
> > We could at least put a limit on that matches the current worst case =
to
> > prevent it getting worse than it already is.
>=20
> That would be a good idea, yes.
>=20
> How would you handle the override for a smaller -Wstack-usage ?

If you have multiple -Wstack-size=3D$XXX  flags to GCC, I expect the last
one wins. So just need to double check that the per-object file CFLAGS
occur after the global CFLAS in the compiler args


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
