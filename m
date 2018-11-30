Received: from eggs.gnu.org ([2001:4830:134:3::10]:49159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1gShSB-0006zq-Sy
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1gShS6-0000Cg-Uq
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:59:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:51240 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <afaerber@suse.de>) id 1gShS6-0008SD-IE
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:59:22 -0500
References: <87r2f3nj80.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <b829ecbe-ba51-f79c-9caa-179dd1358143@suse.de>
Date: Fri, 30 Nov 2018 12:59:17 +0100
MIME-Version: 1.0
In-Reply-To: <87r2f3nj80.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] What's our ABI promise for externally visible QOM?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Am 30.11.18 um 07:59 schrieb Markus Armbruster:
> QOM types and the QOM graph are externally visible:
>=20
> * qom-list-types returns QOM type names and parents.
>=20
>   Fine print: the result is limited to concrete types by default.
>   Aside: that's the only way to figure out whether a type is abstract.
>   Interface design fail.  The result can optionally be limited to
>   sub-types of a certain type.
>=20
> * qom-list-properties returns a named type's static properties.
>=20
> * qom-list returns an object's properties.  This lets clients traverse
>   the QOM graph.
>=20
> * qom-get returns a property's value.
>=20
> * qom-set changes a property's value.
>=20
> * -object and object-add create a QOM object of a certain type with
>   certain property values.  The type must be a sub-type of
>   "user-creatable".
>=20
> * Types are identified by name.
>=20
> * Objects and properties are identified by QOM path.  An absolute QOM
>   paths is the path within the composition tree starting at the root.
>   Partial paths are a convenience you don't want to understand.
>=20
> What promises do we make regarding the stability  / backward
> compatibility of these externally visible entities?

Mainly we agreed on not changing the type of an existing property for
backwards compatibility (e.g., don't switch between int and string,
change the property name then). More difficult will be structs in that
regard - does adding a field count as changing the type? Adding and
removing properties should be okay, as it can be discovered or results
in a detectable error. Don't recall we made any other promises, but I
might've forgotten something in this ad-hoc list.

Regards,
Andreas

>=20
> The QMP command documentation is silent on it.  A user could reasonably
> assume that the general QMP stability promise extends to all of QOM.
> Does it?
>=20
> Was that the intent when we created qom-list, qom-set, qom-get?
> Andreas, do you remember?
>=20
> Is it practical given the current state of affairs?
>=20
> Is it a good idea?
>=20


--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=C3=BCrnberg)
