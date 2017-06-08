Received: from eggs.gnu.org ([2001:4830:134:3::10]:54013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIt9M-0002zW-V7
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 04:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIt9J-0005t0-NA
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 04:50:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dIt9J-0005rp-Dr
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 04:50:37 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170607074632.13162-1-marcandre.lureau@redhat.com>
	<20170607074632.13162-6-marcandre.lureau@redhat.com>
	<56127bd4-c7b5-6589-9dc6-58dc955e7103@redhat.com>
	<1905290985.31619103.1496910193025.JavaMail.zimbra@redhat.com>
Date: Thu, 08 Jun 2017 10:50:30 +0200
In-Reply-To: <1905290985.31619103.1496910193025.JavaMail.zimbra@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 8 Jun 2017
	04:23:13 -0400 (EDT)")
Message-ID: <87r2yug8x5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/5] coccinelle: prefer glib g_new/g_renew
 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, pbonzini@redhat.com, qemu-devel@nongnu.org, peter maydell <peter.maydell@linaro.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> ----- Original Message -----
>> On 06/07/2017 02:46 AM, Marc-Andr=C3=A9 Lureau wrote:
>> > The g_new() familly of macros is simpler and safer than g_malloc().
>>=20
>> s/familly/family/
>>=20
>> >=20
>> > "The return pointer is cast to the given type... Care is taken to
>> > avoid overflow when calculating the size of the allocated block."
>> >=20
>> > I left out the common g_malloc(sizeof(*ptr)) pattern, since
>> > alternative "g_new(typeof(*ptr))" isn't very common. But we may want
>> > to change that too?
>>=20
>> Markus has made changes like this in the past (see commits bdd81add,
>> b45c03f, ...).  It may even be worth cribbing his commit messages,
>> and/or converting his Coccinelle script into something stored in the
>> repository, since we tend to re-run it and find more poor uses that have
>> crept in over time.
>
> I don't think it's so simple to write a full and correct script that is w=
orth being stored in tree. At least, I don't have enough experience to do s=
o.
>=20=20
>> >=20
>> > Here is the cocci script I used, then I edited manually a few
>> > changes (I removed useless cast for ex):
>> >=20
>> > @@
>> > expression e1;
>> > expression e2;
>> > expression mem;
>> > type t1;
>> > @@
>>=20
>> Your script differs from Markus', we should figure out if they can be
>> merged into one.
>
> One notable difference is that I abuse expression, instead of type. I did=
n't manage to teach spatch about the includes and custom type (--all-includ=
es didn't work). I just tried with expression and it was happy, I haven't s=
earched further.

Does your semantic patch more, less, or both?

>>=20
>> > (
>> > - g_malloc0(sizeof(*e2))
>> > + g_malloc0(sizeof(*e2))
>>=20
>> Huh?
>>=20
>> > |
>> > - g_malloc(sizeof(*e2))
>> > + g_malloc(sizeof(*e2))
>>=20
>> Huh?
>
> That's what I explained in the cover letter, I don't wont those to be tou=
ched, but they would because I abuse expressions...
>=20=20
>>=20
>> > |
>> > - g_realloc(mem, (e1) * sizeof(*e2))
>> > + g_renew(typeof(*e2), mem, e1)
>>=20
>> We haven't used typeof() very frequently. I don't know if it is worth
>> using more frequently, maybe Markus has an opinion.
>>=20
>> > |
>> > - g_malloc0((e1) * sizeof(*e2))
>> > + g_new0(typeof(*e2), e1)
>> > |
>> > - g_malloc((e1) * sizeof(*e2))
>> > + g_new(typeof(*e2), e1)
>> > |
>> > - g_realloc(mem, (e1) * sizeof(e2[0]))
>> > + g_renew(typeof(e2[0]), mem, e1)
>>=20
>> Ditto.
>>=20
>> > |
>> > - g_realloc(mem, (e1) * sizeof(e2))
>> > + g_renew(e2, mem, e1)
>>=20
>> This one makes sense.
>>=20
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[...]
>> >  161 files changed, 278 insertions(+), 285 deletions(-)
>>=20
>> That's big; I'd rather we get consensus on the Coccinelle script first,
>> and then review the fallout.  Last time I did a .cocci patch that was
>> worth having in the tree, I specifically split the addition of the
>> script from running the script, to make backporting slightly easier
>> (backport the script as-is, then re-run the formula in the commit
>> message of the application, which is easier than hand-verifying conflict
>> resolutions over time).
>
> Sadly, my script is really far from perfect. And I don't how much time it=
 will take me to make it better, and if I really want to spend that time fo=
r this. In any case, the result needs careful review. So thought it would b=
e easier to provide a patch that I manually changed/reviewed, rather than a=
 full cocci script.

I can play with the script when this series reaches the front of my
review queue.

Manual review might be easier if you split the patch along patterns.

To get similar patches merged in the past, I had to split along split
along subsystems as well.  The typical split is major subsystems with
active maintainers, plus a part of miscellaneous leftovers.

>
>> >=20
>> > diff --git a/hw/lm32/lm32_hwsetup.h b/hw/lm32/lm32_hwsetup.h
>> > index a01f6bc5df..38ade3db0e 100644
>> > --- a/hw/lm32/lm32_hwsetup.h
>> > +++ b/hw/lm32/lm32_hwsetup.h
>> > @@ -58,7 +58,7 @@ static inline HWSetup *hwsetup_init(void)
>> >  {
>> >      HWSetup *hw;
>> >=20=20
>> > -    hw =3D g_malloc(sizeof(HWSetup));
>> > +    hw =3D g_new(HWSetup, 1);
>>=20
>> At any rate, cleanups like this match what we have done in the past, so
>> you're on the right track, even though I'm not giving R-b yet.
