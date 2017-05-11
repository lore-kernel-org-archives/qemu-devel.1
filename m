Received: from eggs.gnu.org ([2001:4830:134:3::10]:39575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8rv6-00047h-KC
	for qemu-devel@nongnu.org; Thu, 11 May 2017 13:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8rv1-0007xf-MV
	for qemu-devel@nongnu.org; Thu, 11 May 2017 13:30:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d8rv1-0007wk-HA
	for qemu-devel@nongnu.org; Thu, 11 May 2017 13:30:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FBD480F90
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 17:30:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-6-marcandre.lureau@redhat.com>
Date: Thu, 11 May 2017 19:30:19 +0200
In-Reply-To: <20170509173559.31598-6-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 9 May 2017 20:35:47 +0300")
Message-ID: <874lwrqp1w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/17] qapi: remove promote_int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> qnum_to_double() implicity promotes int now.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qnum_to_double() works for both for integers and doubles.  That's not
really new; it's what we've always done when we need a double, see
qobject_input_type_number() before your patch.

promote_int is about visit_start_alternate().  It's called before the
switch over the alternate object's member type (of type QType).

Input visitors allocate the alternate object, and set member type to a
value determined by the input.  promote_int =3D true asks the input
visitor to set type to QTYPE_QFLOAT when the input would otherwise call
for QTYPE_QINT.

Non-input visitors leave member type alone.

The generated visitors pass promote_int =3D true exactly when QTYPE_QINT
isn't a valid type.  Without that, we'd have to monkey-patch QTYPE_QINT
to QTYPE_QFLOAT in every generated visitor, just in case it's used with
an input visitor.  Not exactly elegant, but it works.

The only input visitor that implements alternates right now is the
QObject input visitor.

The previous patch fused QTYPE_QINT and QTYPE_QFLOAT, rendering
promote_int useless and unused.

Here's my attempt at a commit message:

    qapi: Remove visit_start_alternate() parameter promote_int

    Before the previous commit, parameter promote_int =3D true made
    visit_start_alternate() with an input visitor avoid QTYPE_QINT
    variants and create QTYPE_QFLOAT variants instead.  This was used
    where QTYPE_QINT variants were invalid.

    The previous commit fused QTYPE_QINT with QTYPE_QFLOAT, rendering
    rendering promote_int useless and unused.

Patch looks good to me.
