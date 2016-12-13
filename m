Received: from eggs.gnu.org ([2001:4830:134:3::10]:50908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cGm2z-0001jQ-BC
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:19:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cGm2t-0000sn-Oq
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:19:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cGm2t-0000sf-Iq
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:18:59 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1481306777-5441-1-git-send-email-ehabkost@redhat.com>
	<6b1269fd-762f-9971-7114-868cd425de3d@suse.de>
	<20161212182256.GA29949@thinpad.lan.raisama.net>
Date: Tue, 13 Dec 2016 13:18:56 +0100
In-Reply-To: <20161212182256.GA29949@thinpad.lan.raisama.net> (Eduardo
	Habkost's message of "Mon, 12 Dec 2016 16:22:56 -0200")
Message-ID: <87y3zknhsf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9] qom: Make all interface types
 abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Lin Ma <lma@suse.com>, qemu-devel@nongnu.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Mon, Dec 12, 2016 at 03:04:25PM +0100, Andreas F=C3=A4rber wrote:
>> Am 09.12.2016 um 19:06 schrieb Eduardo Habkost:
>> > "qom-list-types abstract=3Dfalse" currently returns all interface
>> > types, as if they were not abstract. Fix this by making sure all
>> > interface types are abstract.
>> >=20
>> > All interface types have instance_size =3D=3D 0, so we can use
>> > it to set abstract=3Dtrue on
>> >=20
>> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> > ---
>> >  qom/object.c                   |  4 +++
>> >  tests/device-introspect-test.c | 61 +++++++++++++++++++++++++++++++++=
++++++---
>> >  2 files changed, 62 insertions(+), 3 deletions(-)
>> >=20
>> > diff --git a/qom/object.c b/qom/object.c
>> > index 7a05e35..3870c1b 100644
>> > --- a/qom/object.c
>> > +++ b/qom/object.c
>> > @@ -272,6 +272,10 @@ static void type_initialize(TypeImpl *ti)
>> >=20=20
>> >      ti->class_size =3D type_class_get_size(ti);
>> >      ti->instance_size =3D type_object_get_size(ti);
>> > +    /* Any type with zero instance_size is implicitly abstract.
>> > +     * This means interface types are all abstract.
>> > +     */
>> > +    ti->abstract |=3D ti->instance_size =3D=3D 0;
>>=20
>> IIRC this is a bool field, so I would prefer to avoid |=3D by using an
>> old-fashioned if statement.
>
> I was going to use an if statement, but then I tried to make it
> simpler using "|=3D". I will add it back in v2.

Operator | is perfectly fine for boolean operands, and so is your |=3D
line.  Doesn't mean a conditional would be worse.

[...]
