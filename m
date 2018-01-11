Received: from eggs.gnu.org ([2001:4830:134:3::10]:48180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZkRL-0002eh-6G
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZkRK-0006wa-BW
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:31:11 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eZkRK-0006vp-63
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:31:10 -0500
Received: by mail-wm0-x230.google.com with SMTP id f140so8044488wmd.2
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 13:31:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87o9n9cnz3.fsf@dusky.pond.sub.org>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-21-marcandre.lureau@redhat.com>
	<87tvx1e2xz.fsf@dusky.pond.sub.org>
	<87o9n9cnz3.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 11 Jan 2018 22:31:08 +0100
Message-ID: <CAJ+F1CKLyABUkn02g-a=OmOVGFm_yawBnY6H4NpJBLqv-nK_=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 20/50] qapi-event: add 'if' condition to
 generated enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Fri, Dec 8, 2017 at 3:07 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Markus Armbruster <armbru@redhat.com> writes:
>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>>> Add condition to QAPIEvent enum members based on the event 'if'.
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>  scripts/qapi-event.py | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
>>> index 38f4264817..60c6f7030d 100644
>>> --- a/scripts/qapi-event.py
>>> +++ b/scripts/qapi-event.py
>>> @@ -168,7 +168,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
>>>      def visit_event(self, name, info, ifcond, arg_type, boxed):
>>>          self.decl +=3D gen_event_send_decl(name, arg_type, boxed)
>>>          self.defn +=3D gen_event_send(name, arg_type, boxed)
>>> -        self._event_names.append(QAPISchemaMember(name))
>>> +        self._event_names.append(QAPISchemaMember(name, ifcond))
>>>
>>>
>>>  (input_file, output_dir, do_c, do_h, prefix, dummy) =3D parse_command_=
line()
>>
>> No test coverage?

There is no coverage of this change in qapi-schema-test.out since the
event_names enum is an implicit type created by qapi-event.py.

We verify the generated event.h still compiles ;)

Seriously, if necessary we could add a specific test somehow, checking
the generated code further.

>
> Wait!  This patch has no effect, because the it merely puts the ifcond
> argument into QAPISchemaMember.ifcond.  Only later patches put
> QAPISchemaMember.ifcond to use.  Correct?

In general, the patches were splitted this way:
1. accept 'if' in json & verify with visitors
2. add the #if wrapping in the generated code
3. add negative / error tests

In v4, I merged most tests with 1.

> Aside: the ifcond_decorator could already be doing something with the
> argument, but I'll be hanged if I remember how that magic works.
>

It's wrapping visitor methods with a ifcond argument in the previous
patches, not used later.

thanks

--=20
Marc-Andr=C3=A9 Lureau
