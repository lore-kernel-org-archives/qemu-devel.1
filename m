Received: from eggs.gnu.org ([2001:4830:134:3::10]:52525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyflT-0002P0-Km
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyflS-0001Rt-Te
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:34:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42906 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eyflS-0001RT-Pd
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:34:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 650AFEBFE8
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 15:34:58 +0000 (UTC)
References: <20180321134005.8822-1-marcandre.lureau@redhat.com>
	<20180321134005.8822-3-marcandre.lureau@redhat.com>
	<3ec274aa-0dea-0932-e560-f388c1cbac41@redhat.com>
	<CAMxuvay1j+E1YRggpqm9+ETE_FxD-ThGtPBenUtvt8oeYweS8g@mail.gmail.com>
	<4e876850-3057-e9d5-695b-69f4cde9aa9a@redhat.com>
	<CAMxuvay+aMU7=kr2ED+7Hq596oeoZP+xKXMYwGB+r8AG5=5rdQ@mail.gmail.com>
	<2467bc3b-c0da-b6e4-1201-48983ba5a5af@redhat.com>
	<26a3cea8-20ff-34a3-945b-044a730812b6@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d91d87e4-e3f0-c21f-669a-d3e70258a949@redhat.com>
Date: Wed, 21 Mar 2018 16:34:53 +0100
MIME-Version: 1.0
In-Reply-To: <26a3cea8-20ff-34a3-945b-044a730812b6@redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "P. Berrange, Daniel" <berrange@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>

On 21/03/2018 16:29, Eric Blake wrote:
>=20
> Not necessarily - can we use multiple layers of macros?=C2=A0 (Untested=
)
>=20
> #define QOBJECT_0(x) x
> #define QOBJECT_1(x) ({ \
> =C2=A0=C2=A0=C2=A0 QEMU_BUILD_BUG_ON(offsetof(typeof(*x), base)); \
> =C2=A0=C2=A0=C2=A0 &(x)->base; })
> #define QOBJECT(x) QOBJECT_ ## QEMU_GENERIC(x, \
> =C2=A0=C2=A0=C2=A0 (QObject *, 0),
> =C2=A0=C2=A0=C2=A0 (const QObject *, 0),
> =C2=A0=C2=A0=C2=A0 1)(x)
>=20
> or with an additional layer of glue() if needed
>=20
> That is, reduce the QEMU_GENERIC expansion into something that generate=
s
> only a single preprocessor token, where we then use to decide which
> OTHER macro to expand, so that we are only evaluating &(x)->base when w=
e
> selected the derived types.

I don't think so.  Macro expansion happens way earlier.

Paolo
