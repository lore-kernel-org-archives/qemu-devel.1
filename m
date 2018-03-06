Received: from eggs.gnu.org ([2001:4830:134:3::10]:34452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1etDY4-0006Gl-7Z
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:26:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1etDY0-0002Eg-TC
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:26:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40610
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1etDY0-0002Dw-N5
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:26:32 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w26EPHBk072193
	for <qemu-devel@nongnu.org>; Tue, 6 Mar 2018 09:26:30 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ghv951tqk-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 09:26:30 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Tue, 6 Mar 2018 14:26:28 -0000
Date: Tue, 6 Mar 2018 15:26:23 +0100
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
In-Reply-To: <20180226175751.2d8e5f05.cohuck@redhat.com>
References: <1519407778-23095-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1519407778-23095-4-git-send-email-imbrenda@linux.vnet.ibm.com>
	<20180226175751.2d8e5f05.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20180306152623.0f541361@p-imbrenda.boeblingen.de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/3] s390x/sclp: extend SCLP event masks
 to 64 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com

On Mon, 26 Feb 2018 17:57:51 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 23 Feb 2018 18:42:58 +0100
> Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:
>=20
> > Extend the SCLP event masks to 64 bits.
> >=20
> > Notice that using any of the new bits results in a state that
> > cannot be migrated to an older version.
> >=20
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> > ---
> >  hw/s390x/event-facility.c         | 56
> > ++++++++++++++++++++++++++++++---------
> > include/hw/s390x/event-facility.h |  2 +- 2 files changed, 45
> > insertions(+), 13 deletions(-)
> >=20
> > diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> > index e04ed9f..c3e39ee 100644
> > --- a/hw/s390x/event-facility.c
> > +++ b/hw/s390x/event-facility.c
> > @@ -30,7 +30,7 @@ struct SCLPEventFacility {
> >      SysBusDevice parent_obj;
> >      SCLPEventsBus sbus;
> >      /* guest's receive mask */
> > -    sccb_mask_t receive_mask;
> > +    uint32_t receive_mask_pieces[2];
> >      /*
> >       * when false, we keep the same broken, backwards compatible
> > behaviour as
> >       * before, allowing only masks of size exactly 4; when true,
> > we implement @@ -42,6 +42,18 @@ struct SCLPEventFacility {
> >      uint16_t mask_length;
> >  };
> > =20
> > +static inline sccb_mask_t make_receive_mask(SCLPEventFacility *ef)
> > +{
> > +    return ((sccb_mask_t)ef->receive_mask_pieces[0]) << 32 |
> > +                         ef->receive_mask_pieces[1];
> > +}
> > +
> > +static inline void store_receive_mask(SCLPEventFacility *ef,
> > sccb_mask_t val) +{
> > +    ef->receive_mask_pieces[1] =3D val;
> > +    ef->receive_mask_pieces[0] =3D val >> 32;
> > +}
> > + =20
>=20
> Hm... how are all those values actually defined in the architecture?
> You pass around some values internally (which are supposedly in host
> endian) and then and/or them with the receive mask here. Are they
> compared byte-for-byte? 32-bit-for-32-bit?

We always convert anything from/to the guest into/from host endian, so
things Just Work=E2=84=A2. comparison is always with =3D=3D and so on, on t=
he full
reconstructed values. receive_mask_pieces[0] always needs to contain
the leftmost 32 bits of the mask, which does not correspond to the
leftmost 32 bits in little endian, which is why these functions need to
exist.

These utility functions help recompose the 64-bit value from the two
32-bit pieces or the other way around. On a big endian system this will
result in a nop.=20

The accessors are needed because we can't store the 64 bit value
internally as a 64bit value -- we need to save the high 32 bits for
compat, and the lower (rightmost in the mask) 32 bits only when used,
and this is not possible otherwise. But all operations are always only
performed on the correct 64-bit values.

I hope it makes sense

> I'm also not a fan of the _pieces suffix - reminds me of Dwarf
> pieces :)

I also think this is very ugly, but there isn't much that can be done,
unless we start using all the pre_ and post_ hooks in the savestate,
but that would really look ugly.
