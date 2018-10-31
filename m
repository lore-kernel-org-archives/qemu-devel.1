Received: from eggs.gnu.org ([2001:4830:134:3::10]:49351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gHuoa-0005E5-FF
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 14:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gHuoX-00026L-Ai
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 14:02:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gHuoW-00020O-QE
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 14:01:57 -0400
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-2-david@redhat.com>
	<87pnvqdvsj.fsf@dusky.pond.sub.org>
	<e8fe86a1-d075-2ea8-d1f4-e08e5dceee07@redhat.com>
	<875zxingqn.fsf@dusky.pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <440eb166-73d1-77b6-5dd9-66a0abd7d665@redhat.com>
Date: Wed, 31 Oct 2018 19:01:46 +0100
MIME-Version: 1.0
In-Reply-To: <875zxingqn.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/7] qapi: use qemu_strtoi64() in
 parse_str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 31.10.18 18:55, Markus Armbruster wrote:
> David Hildenbrand <david@redhat.com> writes:
>=20
>> On 31.10.18 15:40, Markus Armbruster wrote:
>>> David Hildenbrand <david@redhat.com> writes:
>>>
>>>> The qemu api claims to be easier to use, and the resulting code seem=
s to
>>>> agree.
> [...]
>>>> @@ -60,9 +61,7 @@ static int parse_str(StringInputVisitor *siv, cons=
t char *name, Error **errp)
>>>>      }
>>>> =20
>>>>      do {
>>>> -        errno =3D 0;
>>>> -        start =3D strtoll(str, &endptr, 0);
>>>> -        if (errno =3D=3D 0 && endptr > str) {
>>>> +        if (!qemu_strtoi64(str, &endptr, 0, &start)) {
>>>>              if (*endptr =3D=3D '\0') {
>>>>                  cur =3D g_malloc0(sizeof(*cur));
>>>>                  range_set_bounds(cur, start, start);
>>>> @@ -71,11 +70,7 @@ static int parse_str(StringInputVisitor *siv, con=
st char *name, Error **errp)
>>>>                  str =3D NULL;
>>>>              } else if (*endptr =3D=3D '-') {
>>>>                  str =3D endptr + 1;
>>>> -                errno =3D 0;
>>>> -                end =3D strtoll(str, &endptr, 0);
>>>> -                if (errno =3D=3D 0 && endptr > str && start <=3D en=
d &&
>>>> -                    (start > INT64_MAX - 65536 ||
>>>> -                     end < start + 65536)) {
>>>> +                if (!qemu_strtoi64(str, &endptr, 0, &end) && start =
< end) {
>>>
>>> You deleted (start > INT64_MAX - 65536 || end < start + 65536).  Can =
you
>>> explain that to me?  I'm feeling particularly dense today...
>>
>> qemu_strtoi64 performs all different kinds of error handling completel=
y
>> internally. This old code here was an attempt to filter out -EWHATEVER
>> from the response. No longer needed as errors and the actual value are
>> reported via different ways.
>=20
> I understand why errno =3D=3D 0 && endptr > str go away.  They also do =
in
> the previous hunk.
>=20
> The deletion of (start > INT64_MAX - 65536 || end < start + 65536) is
> unobvious.  What does it do before the patch?
>=20
> The condition goes back to commit 659268ffbff, which predates my watch
> as maintainer.  Its commit message is of no particular help.  Its code
> is... allright, the less I say about that, the better.
>=20
> We're parsing a range here.  We already parsed its lower bound into
> @start (and guarded against errors), and its upper bound into @end (and
> guarded against errors).
>=20
> If the condition you delete is false, we goto error.  So the condition
> is about range validity.  I figure it's an attempt to require valid
> ranges to be no "wider" than 65535.  The second part end < start + 6553=
6
> checks exactly that, except shit happens when start + 65536 overflows.
> The first part attempts to guard against that, but
>=20
> (1) INT64_MAX is *wrong*, because we compute in long long, and
>=20
> (2) it rejects even small ranges like INT64_MAX - 2 .. INT64_MAX - 1.
>=20
> WTF?!?
>=20
> Unless I'm mistaken, the condition is not about handling any of the
> errors that qemu_strtoi64() handles for us.
>=20
> The easiest way for you out of this morass is probably to keep the
> condition exactly as it was, then use the "my patch doesn't make things
> any worse" get-out-of-jail-free card.
>=20

Looking at the code in qapi/string-output-visitor.c related to range and
list handling I feel like using the get-out-of-jail-free card to get out
of qapi code now :) Too much magic in that code and too little time for
me to understand it all.

Thanks for your time and review anyway. My time is better invested in
other parts of QEMU. I will drop both patches from this series.

--=20

Thanks,

David / dhildenb
