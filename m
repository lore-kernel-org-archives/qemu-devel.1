Received: from eggs.gnu.org ([2001:4830:134:3::10]:49510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eopqs-0006vH-VO
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:19:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eopqr-0000h9-P6
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:19:54 -0500
Date: Thu, 22 Feb 2018 13:19:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180222121925.GD4147@localhost.localdomain>
References: <7c23f28d-ee14-c504-ae13-04414c4b032e@redhat.com>
	<20180222105755.GB4147@localhost.localdomain>
	<37efa6ac-8e36-9c96-84ef-a8639ba64937@kamp.de>
	<20180222113204.GC4147@localhost.localdomain>
	<20180222114053.GE9323@redhat.com>
	<ab206ced-9b56-93d5-04b7-f342d45a2927@kamp.de>
	<20180222120029.GI9323@redhat.com>
	<c46fd50f-3952-75a3-eb5a-a53a06c3bc4d@kamp.de>
	<20180222120334.GJ9323@redhat.com>
	<f2c949cb-ef04-3b7d-1068-6af02ac2201c@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f2c949cb-ef04-3b7d-1068-6af02ac2201c@kamp.de>
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, jsnow@redhat.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

Am 22.02.2018 um 13:06 hat Peter Lieven geschrieben:
> Am 22.02.2018 um 13:03 schrieb Daniel P. Berrang=E9:
> > On Thu, Feb 22, 2018 at 01:02:05PM +0100, Peter Lieven wrote:
> >> Am 22.02.2018 um 13:00 schrieb Daniel P. Berrang=E9:
> >>> On Thu, Feb 22, 2018 at 12:51:58PM +0100, Peter Lieven wrote:
> >>>> Am 22.02.2018 um 12:40 schrieb Daniel P. Berrang=E9:
> >>>>> On Thu, Feb 22, 2018 at 12:32:04PM +0100, Kevin Wolf wrote:
> >>>>>> Am 22.02.2018 um 12:01 hat Peter Lieven geschrieben:
> >>>>>>> Am 22.02.2018 um 11:57 schrieb Kevin Wolf:
> >>>>>>>> Am 20.02.2018 um 22:54 hat Paolo Bonzini geschrieben:
> >>>>>>>>> On 20/02/2018 18:04, Peter Lieven wrote:
> >>>>>>>>>> Hi,
> >>>>>>>>>>
> >>>>>>>>>> I remember we discussed a long time ago to limit the stack u=
sage of all
> >>>>>>>>>> functions that are executed in a coroutine
> >>>>>>>>>> context to a very low value to be able to safely limit the c=
oroutine
> >>>>>>>>>> stack size as well.
> >>>>>>>>> IIRC the only issue was that hw/ide/atapi.c has mutual recurs=
ion between
> >>>>>>>>> ide_atapi_cmd_reply_end -> ide_transfer_start -> ahci_start_t=
ransfer ->
> >>>>>>>>> ide_atapi_cmd_reply_end.
> >>>>>>>>>
> >>>>>>>>> But perhaps it's not an issue, somebody needs to audit the co=
de.
> >>>>>>>> I think John intended to get rid of the recursion sometime, bu=
t I doubt
> >>>>>>>> he has had the time so far.
> >>>>>>> Apart from this is is possible to define special cflags in the
> >>>>>>> Makefile.objs just for a subdirectory? I have patches ready to =
make
> >>>>>>> the block layer files and other coroutine users compile with
> >>>>>>> -Wstack-size=3D2048. But I do not want to specify each file sep=
arately.
> >>>>>> Our Makefiles have lines like this:
> >>>>>>
> >>>>>>     iscsi.o-cflags     :=3D $(LIBISCSI_CFLAGS)
> >>>>>>
> >>>>>> I don't think there is a direct mechanism to apply cflags to a w=
hole
> >>>>>> directory or just to block-obj-y/block-obj-m, but just looping o=
ver them
> >>>>>> could work. I'm not a Makefile expert at all, but after some toy=
ing with
> >>>>>> a simple example, something like this might work:
> >>>>>>
> >>>>>>     $(foreach x,$(block-obj-y),$(eval $x-cflags +=3D -Wstack-siz=
e=3D2048))
> >>>>> You'll need it for anything block layer depends on too - so that'=
s much
> >>>>> of util/, crypto/ and io/ directories at least.
> >>>>>
> >>>>> So perhaps it would be shorter if we do the opposite - set -Wstac=
k-size=3D2048
> >>>>> globally for everything in QEMU, and then override -Wstack-size=3D=
$BIGGER
> >>>>> for the (hopefully) few sources that have a larger stack need ?
> >>>> I tried that already. 2048 is a strong limit for many functions.
> >>>> It breaks already as soon as some buffer has a size of PATH_MAX, b=
ut
> >>>> thats handleable. But there are some structs around that are very =
large.
> >>> There are surprisingly few "char [PATH_MAX]" variables left in QEMU=
 - we
> >>> should have a final push to eliminate them regardless.
> >>>
> >>>> Generally, it would be a good idea to have a global limit, of cour=
se.
> >>> We could at least put a limit on that matches the current worst cas=
e to
> >>> prevent it getting worse than it already is.
> >> That would be a good idea, yes.
> >>
> >> How would you handle the override for a smaller -Wstack-usage ?
> > If you have multiple -Wstack-size=3D$XXX  flags to GCC, I expect the =
last
> > one wins. So just need to double check that the per-object file CFLAG=
S
> > occur after the global CFLAS in the compiler args
>=20
> I will check that, thanks.
>=20
> When I am at it, what would be the proper replacement for char[PATH_MAX=
] ?

g_malloc() with the exact size?

Kevin
