Received: from eggs.gnu.org ([2001:4830:134:3::10]:35295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZ9WG-0001bn-Mq
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:10:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZ9WA-0007b4-AU
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:10:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZ9WA-0007Yc-0i
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:10:14 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1543467132-2873-1-git-send-email-liq3ea@gmail.com>
	<1543467132-2873-3-git-send-email-liq3ea@gmail.com>
	<644186db-32d3-7c83-8b37-02e8427ef217@redhat.com>
	<87o99kj7tm.fsf@dusky.pond.sub.org>
	<b3e3a763-7865-285b-4fa7-b3146f19d354@redhat.com>
Date: Tue, 18 Dec 2018 08:09:59 +0100
In-Reply-To: <b3e3a763-7865-285b-4fa7-b3146f19d354@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon,
	17 Dec 2018 20:37:56 +0100")
Message-ID: <8736qvjooo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, ehabkost@redhat.com, mst@redhat.com, Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org, darren.kenny@oracle.com, pbonzini@redhat.com, rth@twiddle.net

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 12/17/18 8:01 PM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>=20
>>> Hi Li,
>>>
>>> On 11/29/18 5:52 AM, Li Qiang wrote:
>>>> According to qdev-properties.h, properties of pointer type should
>>>> be avoided. Turn "ps2_mouse" into a link.
>>>>
>>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>>> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
>>>> Signed-off-by: Li Qiang <liq3ea@gmail.com>
>>>> ---
>> [...]
>>>> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
>>>> index 4412eaf604..f63aac6673 100644
>>>> --- a/hw/i386/vmmouse.c
>>>> +++ b/hw/i386/vmmouse.c
>> [...]
>>>> @@ -283,8 +289,6 @@ static void vmmouse_class_initfn(ObjectClass *klas=
s, void *data)
>>>>      dc->realize =3D vmmouse_realizefn;
>>>>      dc->reset =3D vmmouse_reset;
>>>>      dc->vmsd =3D &vmstate_vmmouse;
>>>> -    dc->props =3D vmmouse_properties;
>>>> -    /* Reason: pointer property "ps2_mouse" */
>>>>      dc->user_creatable =3D false;
>>>
>>> "user_creatable =3D false" must have an justification comment.
>>=20
>> Correct.

Aside: more ->user_creatable =3D false without a comment have crept in
since I last swept them out.

>>> Can you keep 'Reason: link property "ps2_mouse"'?
>>=20
>> Is this a valid reason?
>>=20
>> A pointer property is one, because it can only be set by code.
>
> I prefer the original comment :)
>
> /* Reason: pointer property "ps2_mouse" */

A pointer property can't be set by -device because there's no sane way
to pick a value.  Not true for a link property: it's value is a QOM
path.  But I'm not sure such setting of link properties has been
implemented.  If it isn't, then /* Reason: link property "ps2_mouse */
is perfect.  If it isn, then it's wrong, possibly along with with
dc->user_creatable =3D false.

>>> Eventually the maintainer taking this patch can fix this for you.
>>>
>>> With the comment:
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>
>>>>  }
>> [...]
>>=20
