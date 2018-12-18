Received: from eggs.gnu.org ([2001:4830:134:3::10]:34403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gZB5F-0005zD-L3
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 03:50:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gZB5E-0003kH-GZ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 03:50:33 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:47083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gZB5E-0003ic-7B
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 03:50:32 -0500
Received: by mail-io1-xd41.google.com with SMTP id v10so12111834ios.13
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 00:50:31 -0800 (PST)
MIME-Version: 1.0
References: <1543467132-2873-1-git-send-email-liq3ea@gmail.com>
	<1543467132-2873-3-git-send-email-liq3ea@gmail.com>
	<644186db-32d3-7c83-8b37-02e8427ef217@redhat.com>
	<87o99kj7tm.fsf@dusky.pond.sub.org>
	<b3e3a763-7865-285b-4fa7-b3146f19d354@redhat.com>
	<8736qvjooo.fsf@dusky.pond.sub.org>
In-Reply-To: <8736qvjooo.fsf@dusky.pond.sub.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 18 Dec 2018 16:49:54 +0800
Message-ID: <CAKXe6S+EVGMnETHUdZaGu7E8Tv_jmk--uVepRjSW5__6pVc6fw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/2] hw: vmmouse: Use link instead of
 pointer property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, ehabkost@redhat.com, mst@redhat.com, Qemu Developers <qemu-devel@nongnu.org>, Darren Kenny <darren.kenny@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, rth@twiddle.net

Markus Armbruster <armbru@redhat.com> =E4=BA=8E2018=E5=B9=B412=E6=9C=8818=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=883:10=E5=86=99=E9=81=93=EF=BC=
=9A

> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>
> > On 12/17/18 8:01 PM, Markus Armbruster wrote:
> >> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
> >>
> >>> Hi Li,
> >>>
> >>> On 11/29/18 5:52 AM, Li Qiang wrote:
> >>>> According to qdev-properties.h, properties of pointer type should
> >>>> be avoided. Turn "ps2_mouse" into a link.
> >>>>
> >>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >>>> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> >>>> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> >>>> ---
> >> [...]
> >>>> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
> >>>> index 4412eaf604..f63aac6673 100644
> >>>> --- a/hw/i386/vmmouse.c
> >>>> +++ b/hw/i386/vmmouse.c
> >> [...]
> >>>> @@ -283,8 +289,6 @@ static void vmmouse_class_initfn(ObjectClass
> *klass, void *data)
> >>>>      dc->realize =3D vmmouse_realizefn;
> >>>>      dc->reset =3D vmmouse_reset;
> >>>>      dc->vmsd =3D &vmstate_vmmouse;
> >>>> -    dc->props =3D vmmouse_properties;
> >>>> -    /* Reason: pointer property "ps2_mouse" */
> >>>>      dc->user_creatable =3D false;
> >>>
> >>> "user_creatable =3D false" must have an justification comment.
> >>
> >> Correct.
>
> Aside: more ->user_creatable =3D false without a comment have crept in
> since I last swept them out.
>
> >>> Can you keep 'Reason: link property "ps2_mouse"'?
> >>
> >> Is this a valid reason?
> >>
> >> A pointer property is one, because it can only be set by code.
> >
> > I prefer the original comment :)
> >
> > /* Reason: pointer property "ps2_mouse" */
>
> A pointer property can't be set by -device because there's no sane way
> to pick a value.  Not true for a link property: it's value is a QOM
> path.  But I'm not sure such setting of link properties has been
> implemented.  If it isn't, then /* Reason: link property "ps2_mouse */
> is perfect. If it isn, then it's wrong, possibly along with with

dc->user_creatable =3D false.
>
>
Agree,

AFAIK there is no way to set link property in '-device'.
Anyway I think the maintainer can just merge or add this minor adjustment
to the patch.

Thanks,
Li Qiang



> >>> Eventually the maintainer taking this patch can fix this for you.
> >>>
> >>> With the comment:
> >>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>>
> >>>>  }
> >> [...]
> >>
>
