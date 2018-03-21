Received: from eggs.gnu.org ([2001:4830:134:3::10]:50450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyfgX-0005bJ-6D
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:29:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyfgT-0006Au-V7
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:29:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48248 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eyfgT-0006Ab-QT
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:29:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66A7C4023BB3
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 15:29:49 +0000 (UTC)
References: <20180321134005.8822-1-marcandre.lureau@redhat.com>
	<20180321134005.8822-3-marcandre.lureau@redhat.com>
	<3ec274aa-0dea-0932-e560-f388c1cbac41@redhat.com>
	<CAMxuvay1j+E1YRggpqm9+ETE_FxD-ThGtPBenUtvt8oeYweS8g@mail.gmail.com>
	<4e876850-3057-e9d5-695b-69f4cde9aa9a@redhat.com>
	<CAMxuvay+aMU7=kr2ED+7Hq596oeoZP+xKXMYwGB+r8AG5=5rdQ@mail.gmail.com>
	<2467bc3b-c0da-b6e4-1201-48983ba5a5af@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <26a3cea8-20ff-34a3-945b-044a730812b6@redhat.com>
Date: Wed, 21 Mar 2018 10:29:46 -0500
MIME-Version: 1.0
In-Reply-To: <2467bc3b-c0da-b6e4-1201-48983ba5a5af@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] qobject: assume base of a qobject is
 at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "P. Berrange, Daniel" <berrange@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>

On 03/21/2018 09:49 AM, Paolo Bonzini wrote:
> On 21/03/2018 15:21, Marc-Andr=C3=A9 Lureau wrote:
>>>> Yeah, I tried a few of those approaches. Here the problem is that
>>>> QObject doesn't have base field. So you get a compile time error wit=
h
>>>> a QObject * as argument.
>>>
>>> So the compiler requires &(x)->base to resolve even when it is not on=
 the
>>> branch that gets selected?
>>
>> Unfortunately, yes, all branches must compile apparently (I know)...
>=20
> Ugh, and that's indeed true of _Generic too.  These don't compile:
>=20
>    struct s1 { int y; };
>    struct s2 { int z; };
>=20
>    #define f(x)  _Generic(x, struct s1: (x).y, struct s2: (x).z)
>=20
>    int f1(struct s1 *s) { return f(*s); }
>    int f2(struct s2 *s) { return f(*s); }
>=20
> :(  Then I guess Marc-Andr=C3=A9's realization is ugly but unavoidable.

Not necessarily - can we use multiple layers of macros?  (Untested)

#define QOBJECT_0(x) x
#define QOBJECT_1(x) ({ \
     QEMU_BUILD_BUG_ON(offsetof(typeof(*x), base)); \
     &(x)->base; })
#define QOBJECT(x) QOBJECT_ ## QEMU_GENERIC(x, \
     (QObject *, 0),
     (const QObject *, 0),
     1)(x)

or with an additional layer of glue() if needed

That is, reduce the QEMU_GENERIC expansion into something that generates=20
only a single preprocessor token, where we then use to decide which=20
OTHER macro to expand, so that we are only evaluating &(x)->base when we=20
selected the derived types.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
