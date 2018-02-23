Received: from eggs.gnu.org ([2001:4830:134:3::10]:33948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epH27-0006Sn-WA
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:21:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epH24-0006p2-OD
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:21:19 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39404 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1epH24-0006ny-J9
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:21:16 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-9-armbru@redhat.com>
	<a095759a-0b4b-125d-a178-3456e3651c42@redhat.com>
Date: Fri, 23 Feb 2018 18:20:58 +0100
In-Reply-To: <a095759a-0b4b-125d-a178-3456e3651c42@redhat.com> (Eric Blake's
	message of "Mon, 12 Feb 2018 13:42:05 -0600")
Message-ID: <87eflblj0l.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/29] qapi-gen: New common driver for
 code and doc generators
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
>> Whenever qapi-schema.json changes, we run six programs eleven times to
>> update eleven files.  Similar for qga/qapi-schema.json.  This is
>> silly.  Replace the six programs by a single program that spits out
>> all eleven files.
>>
>> The programs become modules in new Python package qapi, along with the
>> helper library.  This requires moving them to scripts/qapi/.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>   .gitignore                                         |  2 +
>>   Makefile                                           | 86 +++++++++-----=
-----
>>   docs/devel/qapi-code-gen.txt                       | 97 ++++++++++----=
--------
>>   monitor.c                                          |  2 +-
>>   qapi-schema.json                                   |  2 +-
>>   scripts/qapi-gen.py                                | 41 +++++++++
>>   scripts/qapi/__init__.py                           |  0
>>   scripts/{qapi-commands.py =3D> qapi/commands.py}     | 23 ++---
>>   scripts/{qapi.py =3D> qapi/common.py}                | 18 +---
>>   scripts/{qapi2texi.py =3D> qapi/doc.py}              | 29 ++-----
>>   scripts/{qapi-event.py =3D> qapi/events.py}          | 23 ++---
>>   scripts/{qapi-introspect.py =3D> qapi/introspect.py} | 32 ++-----
>>   scripts/{qapi-types.py =3D> qapi/types.py}           | 34 ++------
>>   scripts/{qapi-visit.py =3D> qapi/visit.py}           | 34 ++------
>>   tests/Makefile.include                             | 56 ++++++-------
>>   tests/qapi-schema/test-qapi.py                     |  4 +-
>>   16 files changed, 193 insertions(+), 290 deletions(-)
>>   create mode 100755 scripts/qapi-gen.py
>>   create mode 100644 scripts/qapi/__init__.py
>>   rename scripts/{qapi-commands.py =3D> qapi/commands.py} (94%)
>>   rename scripts/{qapi.py =3D> qapi/common.py} (99%)
>>   rename scripts/{qapi2texi.py =3D> qapi/doc.py} (92%)
>>   mode change 100755 =3D> 100644
>
> Still forgot mention that the mode bit change was intentional, but not
> worth a respin for just that.
>
>>   rename scripts/{qapi-event.py =3D> qapi/events.py} (92%)
>>   rename scripts/{qapi-introspect.py =3D> qapi/introspect.py} (90%)
>>   rename scripts/{qapi-types.py =3D> qapi/types.py} (90%)
>>   rename scripts/{qapi-visit.py =3D> qapi/visit.py} (92%)
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
>> +++ b/docs/devel/qapi-code-gen.txt
>
>> -    $ python scripts/qapi-event.py --output-dir=3D"qapi-generated"
>> -    --prefix=3D"example-" example-schema.json
>>       $ cat qapi-generated/example-qapi-event.h
>>   [Uninteresting stuff omitted...]
>>   @@ -1302,23 +1296,22 @@ Example:
>>       }
>>         const char *const example_QAPIEvent_lookup[] =3D {
>> -        [EXAMPLE_QAPI_EVENT_MY_EVENT] =3D "MY_EVENT",
>> +
>> +[EXAMPLE_QAPI_EVENT_MY_EVENT] =3D "MY_EVENT",
>>           [EXAMPLE_QAPI_EVENT__MAX] =3D NULL,
>>       };
>
> Looks like our generated code indentation has slightly regressed from
> what we would write by hand, but it's still okay for generated code
> (and the commit message in 5/29 did call that out)

I'd prefer to have this tidied up.

>> +++ b/scripts/qapi-gen.py
>
>> +++ b/scripts/qapi/commands.py
>> @@ -13,7 +13,7 @@ This work is licensed under the terms of the GNU GPL, =
version 2.
>>   See the COPYING file in the top-level directory.
>>   """
>>   -from qapi import *
>> +from qapi.common import *
>>       def gen_command_decl(name, arg_type, boxed, ret_type):
>> @@ -255,13 +255,8 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor=
):
>>           self._regy +=3D gen_register_command(name, success_response)
>>     -def main(argv):
>> -    (input_file, output_dir, do_c, do_h, prefix, opts) =3D parse_comman=
d_line()
>> -
>> -    blurb =3D '''
>> - * Schema-defined QAPI/QMP commands
>> -'''
>> -
>> +def gen_commands(schema, output_dir, prefix):
>> +    blurb =3D ' * Schema-defined QAPI/QMP commands'
>
> We discussed whether to make the assignment to blurb be a one-liner in
> an earlier patch, but I'm also fine with the churn you have over the
> course of the series.

I ran out of time, and decided to leave this one as is.
