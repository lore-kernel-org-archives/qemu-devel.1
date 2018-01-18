Received: from eggs.gnu.org ([2001:4830:134:3::10]:35333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecHt2-0003IO-Ox
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:38:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecHsz-0007X7-KU
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:38:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:17527)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecHsz-0007Wc-Av
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:38:13 -0500
Date: Thu, 18 Jan 2018 19:38:05 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180118213805.GI5292@localhost.localdomain>
References: <20180118025245.13042-1-famz@redhat.com>
	<d1dd1750-c487-be35-05eb-ffb12f18e805@redhat.com>
	<a81a812f-065c-e8be-0d6d-92525a379a82@amsat.org>
	<cf2b427d-a8a0-a124-16dd-598d4f7eea46@redhat.com>
	<CAAdtpL4kR9qWjWHBuYYbZXv=FBoKXRgLE5tzaaC1nZyJZNHXNA@mail.gmail.com>
	<59cde1ab-cf5f-b40a-4377-b33091b593a2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <59cde1ab-cf5f-b40a-4377-b33091b593a2@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scsi-generic: Simplify error handling code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thu, Jan 18, 2018 at 02:34:39PM -0600, Eric Blake wrote:
> On 01/18/2018 09:55 AM, Philippe Mathieu-Daud=E9 wrote:
> > On Thu, Jan 18, 2018 at 9:03 AM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
> >> On 18/01/2018 12:21, Philippe Mathieu-Daud=E9 wrote:
> >>>> I'm not a fan of bool return types, in general (because "!" is oft=
en
> >>>> success while "< 0" is failure) and especially when there is an Er=
ror**;
> >>>> I disagree with commit 9d3b155186.  But the function is not in an =
area I
> >>>> maintain so I'm queuing this, thanks.
> >>> Do you prefer "if (local_err)" and "if (errp && *errp)" ?
> >>
> >> The latter is wrong.  I do prefer
> >=20
> > Ok so my 253674981e24 missed that train too.

Oops.  I thought we had Coccinelle scripts to detect that
pattern.

>=20
> Markus has expressed as desire, as the error maintainer, to make errp
> functions return a useful value for less boilerplate, and at one point
> was even debating about Coccinelle scripts to make the conversion
> easier.  Perhaps int with -1 is more reliable than bool for that useful
> value, but this is definitely a topic of past discussion.
>=20
> By the way, if (local_err) is definitely preferable; 'if (errp &&
> *errp)' means that your behavior is different depending on whether the
> caller wanted to ignore the error, and not whether you wanted to handle
> the error.
>=20
> >=20
> >>
> >>     if (local_err) {
> >>         error_propagate(errp, local_err);
> >>         return;
> >>     }
>=20
> Yes, that's the right boilerplate if you don't have a return value witn=
ess.
>=20
> >>
> >> or maybe (but only if there is a meaning to a zero vs. positive retu=
rn
> >> value, or if errno is an important part of the returned Error *)
> >>
> >>     ret =3D f(..., errp);
> >>     if (ret < 0) {
> >>         return;
> >>     }
> >>
> >>> I wondered once if a macro might improve this pattern but thought t=
he
> >>> code would get more obscure.
> >>
> >> Eduardo had a series to avoid error_propagate, where NULL was replac=
ed
> >> by a (non-NULL) IGNORED_ERRORS macro.  Then you could do:
> >>
> >>     f(..., errp);
> >>     if (error_is_set(errp)) {
> >>         return;
> >>     }
> >>
> >> See here:
> >> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg03139.html
> >=20
> > This series never hit /master!
> >=20
> > Reading the thread I'm not sure what was the expected outcome.
>=20
> And since Markus may not answer this thread for a while, I'm still not
> sure if there is any expected outcome.

Quoting Markus on that discussion:

"If we switch to returning success/failure (which also gets rid of the
boilerplate), then the macros may still let us get rid of boilerplate
more quickly, for some additional churn.  Worthwhile?  Depends on how
long the return value change takes us."

I guess the lack of activity switching the code to returning
success/failure is enough evidence that the switch will take us
forever?

We can do some effort to document the preferred convention to
return success/failure, but I don't think we will be able to
convert the existing void/ret/bool functions to a single style
(whatever it is) in a reasonable time.

That said, IMO returning 0/-1 or true/false is always preferred
to returning void, so there's no need to add more local_err
boilerplate code.

--=20
Eduardo
