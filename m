Received: from eggs.gnu.org ([2001:4830:134:3::10]:54119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f7zFG-0007RT-TP
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f7zFE-0002yN-6g
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:12:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55812 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f7zFE-0002xp-0v
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:12:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C36638079FC9
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 08:12:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180413161842.5117-1-marcandre.lureau@redhat.com>
	<20180413161842.5117-3-marcandre.lureau@redhat.com>
Date: Mon, 16 Apr 2018 10:12:03 +0200
In-Reply-To: <20180413161842.5117-3-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 13 Apr 2018 18:18:40 +0200")
Message-ID: <87r2nfsh7w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/4] qobject: use a QObjectBase_ struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> By moving the base fields to a QObjectBase_, QObject can be a type
> which also has a 'base' field. This allows to write a generic
> QOBJECT() macro that will work with any QObject type, including
> QObject itself. The container_of() macro ensures that the object to
> cast has a QObjectBase_ base field, giving some type safety
> guarantees. However, for it to work properly, all QObject types must
> have 'base' at offset 0 (which is ensured by static checking from
> the previous patch)

I'm afraid this condition is neither sufficient nor necessary.

QOBJECT() maps a pointer to some subtype to the base type QObject.  For
this to work, the subtype must contain a QObject.

Before the patch, this is trivially the case: the subtypes have a member
QObject base, and QOBJECT() returns its address.

Afterwards, the subtypes have a member QObjectBase_ base, and QOBJECT()
returns the address of a notional QObject wrapped around this member.
Works because QObject has no other members.

The condition 'base is at offset 0' does not ensure this, and is
therefore not sufficient.

It's not necessary, either: putting base elsewhere would work just fine
as long as we put *all* of QObject there.

Please document the real condition "QObject must have no members but
QObjectBase_ base, or else QOBJECT() breaks".  Feel free to check their
sizes are the same (I wouldn't bother).

If requiring base to be at offset zero for all subtypes materially
simplifies code, then go ahead and do that in a separate patch.  My gut
feeling is it doesn't, but I could be wrong.

> QObjectBase_ is not typedef and use a trailing underscore to make it
> obvious it is not for normal use and to avoid potential abuse.

Trailing underscore I like, lack of typedef I don't mind (but I'm firmly
in the "eschew typedef for structs" camp).  It does violate the common
QEMU coding style, though.

A comment /* Not for use outside include/qapi/qmp/ */ next to
QObjectBase_ wouldn't hurt.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
