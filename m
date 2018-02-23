Received: from eggs.gnu.org ([2001:4830:134:3::10]:39339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epHDs-0005xh-83
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:33:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epHDn-0004yZ-KC
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:33:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1epHDn-0004xu-Dj
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:33:23 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-18-armbru@redhat.com>
	<b6772d13-4b8d-4b9d-078b-3da01e0b564a@redhat.com>
Date: Fri, 23 Feb 2018 18:33:21 +0100
In-Reply-To: <b6772d13-4b8d-4b9d-078b-3da01e0b564a@redhat.com> (Eric Blake's
	message of "Mon, 12 Feb 2018 14:34:47 -0600")
Message-ID: <87sh9rk3vi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 17/29] qapi: Record 'include' directives
 in intermediate representation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 02/11/2018 03:35 AM, Markus Armbruster wrote:
>> The include directive permits modular QAPI schemata, but the generated
>> code is monolithic all the same.  To permit generating modular code,
>> the front end needs to pass more information on inclusions to the back
>> ends.  The commit before last added the necessary information to the
>> parse tree.  This commit adds it to the intermediate representation
>> and its QAPISchemaVisitor.  A later commit will use this to to
>> generate modular code.
>>
>> New entity QAPISchemaInclude represents inclusions.  Call new visitor
>> method visit_include() for it, so visitors can see the sub-modules a
>> module includes.
>>
>> Note that unlike other entities, QAPISchemaInclude has no name, and is
>> therefore not added to entity_dict.
>>
>> New QAPISchemaEntity attribute @module names the entity's source file.
>> Call new visitor method visit_module() when it changes during a visit,
>> so visitors can keep track of the module being visited.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>> @@ -1479,16 +1497,19 @@ class QAPISchema(object):
>>           self._entity_dict =3D {}
>>           self._predefining =3D True
>>           self._def_predefineds()
>> -        self._predefining =3D False
>>           self._def_exprs(exprs)
>>           self.check()
>
> Why does self._predfining not need to be toggled anymore?  Do we even
> need this variable any more...
>
>>
>>      def _def_entity(self, ent):
>>          # Only the predefined types are allowed to not have info
>>          assert ent.info or self._predefining
>> -        assert ent.name not in self._entity_dict
>
> ...and/or is this assert now worthless?
>
>
>> +++ b/tests/qapi-schema/comments.out
>> @@ -1,4 +1,5 @@
>>   object q_empty
>>   enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbo=
ol']
>>       prefix QTYPE
>> +module comments.json
>>   enum Status ['good', 'bad', 'ugly']
>
> Based on the generated output, it looks like you can tell whether you
> are in the predefining stage by not having any module at all; the
> first visit_module call is what flips the switch that everything else
> is defined by a module and must therefore have associated info.

Editing accident.  I started down the road you described, decided I lack
the time to reach its end, then failed to back out completely.
