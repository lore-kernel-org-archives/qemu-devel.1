Received: from eggs.gnu.org ([2001:4830:134:3::10]:37958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnoBT-0001ai-Jy
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnoBP-0007y4-L7
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:16:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnoBP-0007xd-Ca
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:16:19 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-26-git-send-email-armbru@redhat.com>
	<CAJ+F1CK+i0HTNU83ftuc9zBcNFm2NSxecajt97QvDZGfj9on8w@mail.gmail.com>
Date: Tue, 14 Mar 2017 16:16:16 +0100
In-Reply-To: <CAJ+F1CK+i0HTNU83ftuc9zBcNFm2NSxecajt97QvDZGfj9on8w@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 14 Mar 2017
	12:42:40 +0000")
Message-ID: <87shmfyjlr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 25/47] qapi2texi: Include member
 type in generated documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Mar 13, 2017 at 10:31 AM Markus Armbruster <armbru@redhat.com>
> wrote:
>
>> The recent merge of docs/qmp-commands.txt and docs/qmp-events.txt into
>> the schema lost type information.  Fix this documentation regression.
>>
>> Example change (qemu-qmp-ref.txt):
>>
>>   -- Struct: InputKeyEvent
>>
>>       Keyboard input event.
>>
>>       Members:
>> -     'button'
>> +     'button: InputButton'
>>            Which button this event is for.
>> -     'down'
>> +     'down: boolean'
>>            True for key-down and false for key-up events.
>>
>>       Since: 2.0
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi.py      | 14 ++++++++++++++
>>  scripts/qapi2texi.py |  8 ++++++--
>>  2 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/qapi.py b/scripts/qapi.py
>> index 9430493..b82a2a6 100644
>> --- a/scripts/qapi.py
>> +++ b/scripts/qapi.py
>> @@ -1101,6 +1101,11 @@ class QAPISchemaType(QAPISchemaEntity):
>>          }
>>          return json2qtype.get(self.json_type())
>>
>> +    def doc_type(self):
>> +        if self.is_implicit():
>> +            return None
>> +        return self.name
>> +
>>
>>  class QAPISchemaBuiltinType(QAPISchemaType):
>>      def __init__(self, name, json_type, c_type):
>> @@ -1125,6 +1130,9 @@ class QAPISchemaBuiltinType(QAPISchemaType):
>>      def json_type(self):
>>          return self._json_type_name
>>
>> +    def doc_type(self):
>> +        return self.json_type()
>> +
>>      def visit(self, visitor):
>>          visitor.visit_builtin_type(self.name, self.info,
>> self.json_type())
>>
>> @@ -1184,6 +1192,12 @@ class QAPISchemaArrayType(QAPISchemaType):
>>      def json_type(self):
>>          return 'array'
>>
>> +    def doc_type(self):
>> +        elt_doc_type =3D self.element_type.doc_type()
>> +        if not elt_doc_type:
>> +            return None
>>
>
> In which case is this expected to happen? place an assert here instead?

I think assert should work now, the argument is a bit longwinded, and it
won't let us simplify code.

First the argument.

T.doc_type() returns None for a non-array type T when T.is_implicit()
and T isn't a built-in type, because:

* QAPISchemaType.doc_type() returns None when self.is_implicit(), but

* QAPISchemaBuiltinType().doc_type() overrides, and never returns None.

T.is_implicit() is true for the following non-array, non-builtin T:

* the implicitly defined enumeration type of a simple union's tag

* the implicitly defined variant type of a simple union

* an implicitly defined base type of a union

* an implicitly defined argument type of a command or event

We can't actually make arrays of these.

Now let's see whether we can use it to simplify code.

There are four calls of .doc_type() besides the one shown above:

* texi_member() calls it for types of

  - the (common) members of object types (including command and event
    arguments) and members of alternate types.  None happens for the
    implicitly defined tag member of simple unions.  The easiest way to
    cope with it is to cope with None for any member.

  - the members of variant members of simple unions.  It doesn't bother
    to handle None, because a member type can only be a built-in or
    explictly defined type, or an array thereof.

* texi_members() calls it and checks for None to help identify
  undocumented members where we can do better than say "Not documented".

* texi_members() calls it for the base type, except when it's implicitly
  defined.  It doesn't bother to handle None, because it can only be an
  explictly defined struct type.

* texi_members() calls it for the types of variant members of flat
  unions.  It doesn't bother to handle None, because a member type can
  only be a built-in or explictly defined type.

Adding the assertion makes no case of None go away.

> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!
