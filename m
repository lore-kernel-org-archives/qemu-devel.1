Received: from eggs.gnu.org ([2001:4830:134:3::10]:47619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gScsu-0001dz-4n
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 02:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gScmU-0003eZ-IH
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 02:00:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gScmT-0003bg-Pa
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 02:00:06 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 30 Nov 2018 07:59:59 +0100
Message-ID: <87r2f3nj80.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] What's our ABI promise for externally visible QOM?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

QOM types and the QOM graph are externally visible:

* qom-list-types returns QOM type names and parents.

  Fine print: the result is limited to concrete types by default.
  Aside: that's the only way to figure out whether a type is abstract.
  Interface design fail.  The result can optionally be limited to
  sub-types of a certain type.

* qom-list-properties returns a named type's static properties.

* qom-list returns an object's properties.  This lets clients traverse
  the QOM graph.

* qom-get returns a property's value.

* qom-set changes a property's value.

* -object and object-add create a QOM object of a certain type with
  certain property values.  The type must be a sub-type of
  "user-creatable".

* Types are identified by name.

* Objects and properties are identified by QOM path.  An absolute QOM
  paths is the path within the composition tree starting at the root.
  Partial paths are a convenience you don't want to understand.

What promises do we make regarding the stability  / backward
compatibility of these externally visible entities?

The QMP command documentation is silent on it.  A user could reasonably
assume that the general QMP stability promise extends to all of QOM.
Does it?

Was that the intent when we created qom-list, qom-set, qom-get?
Andreas, do you remember?

Is it practical given the current state of affairs?

Is it a good idea?
