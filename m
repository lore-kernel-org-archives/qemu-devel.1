Received: from eggs.gnu.org ([2001:4830:134:3::10]:52229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpGlX-0006TY-4b
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpGlS-00013x-0h
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:31:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpGlR-00013Y-QP
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:31:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-18-marcandre.lureau@redhat.com>
	<87h8wicuhc.fsf@dusky.pond.sub.org>
	<80558265.8663807.1504625880216.JavaMail.zimbra@redhat.com>
Date: Tue, 05 Sep 2017 18:31:44 +0200
In-Reply-To: <80558265.8663807.1504625880216.JavaMail.zimbra@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 5 Sep 2017
	11:38:00 -0400 (EDT)")
Message-ID: <87zia9jedr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 17/54] qapi: add 'if' condition on
 entity objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> ----- Original Message -----
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>=20
>> > Take 'if' from expression, and use it to construct entity objects.
>> > Shared implicit objects must share the same 'if' condition.
>>=20
>> Shared by what?
>
> Shared by various make_implicit_object_type() users.

The only ones that are shared right now are simple union wrappers.  For
those, you pick a condition that isn't tight, but works.  Now we need to
work that into the commit message.  Perhaps:

    qapi: Pass 'if' condition into QAPISchemaEntity objects

    Built-in objects remain unconditional.  Explicitly defined objects
    use the condition specified in the schema.  Implicitly defined
    objects inherit their condition from their users.  For most of them,
    there is exactly one user, so the condition to use is obvious.  The
    exception is the wrapper types generated for simple union variants,
    which can be shared by any number of simple unions.  The tight
    condition would be the disjunction of the conditions of these simple
    unions.  For now, use wrapped type's condition instead.  Much
    simpler and good enough for now.

[...]
