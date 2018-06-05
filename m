Received: from eggs.gnu.org ([2001:4830:134:3::10]:52128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fQBnj-0005IX-NK
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fQBnZ-0003La-Po
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:15:03 -0400
Date: Tue, 5 Jun 2018 15:14:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180605151449.22aafbfc.cohuck@redhat.com>
In-Reply-To: <4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
	<20180509154822.23510-3-cohuck@redhat.com>
	<c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
	<20180515181006.0cb1dfc2.cohuck@redhat.com>
	<a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
	<20180522145208.310143ea.cohuck@redhat.com>
	<4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] vfio-ccw: support for halt/clear
 subchannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Tue, 22 May 2018 17:10:44 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 22/05/2018 14:52, Cornelia Huck wrote:
> > On Wed, 16 May 2018 15:32:48 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> > =20
> >> On 15/05/2018 18:10, Cornelia Huck wrote: =20
> >>> On Fri, 11 May 2018 11:33:35 +0200
> >>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> >>>    =20
> >>>> On 09/05/2018 17:48, Cornelia Huck wrote: =20
> >>>>> @@ -126,7 +192,24 @@ static void fsm_io_request(struct vfio_ccw_pri=
vate *private,
> >>>>>    =20
> >>>>>     	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
> >>>>>    =20
> >>>>> -	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
> >>>>> +	/*
> >>>>> +	 * Start processing with the clear function, then halt, then star=
t.
> >>>>> +	 * We may still be start pending when the caller wants to clean
> >>>>> +	 * up things via halt/clear.
> >>>>> +	 */ =20
> >>>> hum. The scsw here does not reflect the hardware state but the
> >>>> command passed from the user interface.
> >>>> Can we and should we authorize multiple commands in one call?
> >>>>
> >>>> If not, the comment is not appropriate and a switch on cmd.fctl
> >>>> would be a clearer. =20
> >>> There may be multiple functions specified, but we need to process them
> >>> in precedence order (and clear wins over the others, so to speak).
> >>> Would adding a sentence like "we always process just one function" he=
lp? =20
> >> Why should we allow multiple commands in a single call ?
> >> It brings no added value.
> >> Is there a use case?
> >> Currently QEMU does not do this and since we only have the SCSH there
> >> is no difference having the bit set alone or not alone. =20
> > I found this to be a very easy way to implement halt/clear. This still
> > holds true if we switch to some kind of capabilities for this (did not
> > have time to look at this further, though).
> >
> > As we have the fctl field anyway, I'm in favour of processing this all
> > in one function.
> > =20

[starting to look at this again]

>=20
> Sorry, I do not understand if we agree or not.
>=20
> I agree we have the fctl field and we must continue to use it
> for backward compatibility.

It also mirrors the hardware, no?

>=20
> I do not understand the "processing all in one function".
>=20
> Since yo already have 3 function to process these three instructions.
>=20
> Do you mean the if .. else if .. else if ?

Yes. There is a lot of common handling for each of these.

>=20
> Then I come back to what you said earlier on the precedence of the clear=
=20
> instruction:
>=20
> 1) do we have a use case to have more than one bit set in the fctl field?
>=20
> - if no, there is no need for precedence

It mirrors what the hardware does: you just set an additional bit if
processing has not yet finished.

>=20
> - if yes, why should clear have precedence ?

Because it does on the hardware?

>  =C2=A0 How do QEMU set more than one bit in fctl?
>  =C2=A0 why should we alter the order of the instructions given by the gu=
est?
>  =C2=A0 How can we know this order if there are multiple instructions at =
once?

In the future, we should return after we fired off the start etc.
request even if we did not receive an interrupt yet, so that the guest
might do a halt or clear before the start has finished. IOW, make this
as asynchronous as the hardware. That's why I'd like to simply
accumulate the things. The architecture already specified what happens
in the response.

Do you think that is feasible?
