Received: from eggs.gnu.org ([2001:4830:134:3::10]:57174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f7ybj-0006xk-6H
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f7ybe-0007Ay-6G
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:31:23 -0400
Date: Mon, 16 Apr 2018 09:31:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180416093105.180b2ce3.cohuck@redhat.com>
In-Reply-To: <c7dec4d0-2674-e51e-9698-571c7f02b6a7@linux.ibm.com>
References: <1523629847-22369-1-git-send-email-thuth@redhat.com>
	<df1a9534-c1ca-972b-91a6-359685a671df@linux.vnet.ibm.com>
	<f3d7c3d0-26fe-37db-abb3-0e99373ae315@redhat.com>
	<6b294d1a-5f3b-aa9c-c0e4-db9da04c4548@linux.vnet.ibm.com>
	<fb58d12d-92b3-2a68-af10-f8f5608f5237@amsat.org>
	<c7dec4d0-2674-e51e-9698-571c7f02b6a7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.13] pc-bios/s390-ccw: size_t should
 be unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Fri, 13 Apr 2018 14:09:55 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> On 04/13/2018 02:06 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 04/13/2018 01:59 PM, Halil Pasic wrote: =20
> >>>> On 04/13/2018 04:30 PM, Thomas Huth wrote: =20
> >>>>> "size_t" should be an unsigned type - the signed counterpart is cal=
led
> >>>>> "ssize_t" in the C standard instead. Thus we should also use this =
=20
> >>>> The first sentence sounds like ssize_t is too a type defined by some
> >>>> C standard. Is it or does ssize_t come form somewhere else? =20
> >>> Arrr, seems like ssize_t is rather coming from POSIX than from the C
> >>> standard, thanks for the hint. I'll rephrase the first sentence to:
> >>>
> >>> "size_t" should be an unsigned type according to the C standard, and
> >>> most libc implementations provide a signed counterpart called "ssize_=
t".
> >>>
> >>> OK?
> >>> =20
> >>
> >> This ssize_t seems to be an rather interesting type. For instance POSI=
X says
> >> """
> >> size_t
> >>     Used for sizes of objects.
> >> ssize_t
> >>     Used for a count of bytes or an error indication.
> >> """
> >> and
> >> """
> >> The type ssize_t shall be capable of storing values at least in the ra=
nge [-1, {SSIZE_MAX}].
> >> """
> >>
> >> And it does not mandate SSIZE_MIN in limits (but of course mandates SS=
IZE_MAX.
> >>
> >> I don't like this 'counterpart' word here, because AFAIU these don't h=
ave to
> >> be counterparts in any sense. That is SSIZE_MAX << SIZE_MAX is possibl=
e for
> >> example. I'm not sure about the every positive has a negative thing, b=
ut
> >> that's not important here.
> >>
> >> The code in question kind of uses both signed and unsigned size for
> >> the same (the string). We even have a signed to unsigned comparison wh=
ich
> >> could result in warnings. I still think the change is OK in practice, =
but
> >> maybe avoiding introducing ssize_t (until we really need it) is a bett=
er
> >> course of action. I think uitoa can be easily rewritten so it does not
> >> need the ssize_t.
> >>
> >> How about that? =20
> >=20
> > This seems clever indeed.
> >  =20
>=20
> This whole issue stems from my misuse of size_t in the first place. If it=
 makes
> things easier, let's just make num_idx of type "signed long".
>=20
> After reading this discussion, I think it makes sense to drop ssize_t. No=
 need
> to make it available for just one function unless there are strong claims=
 to
> also use this type elsewhere in the pc-bios (I can't find any).
>=20

+1 to just using signed long. Let's not make this needlessly complicated.
