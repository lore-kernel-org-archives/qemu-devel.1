Received: from eggs.gnu.org ([2001:4830:134:3::10]:56929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fVCCS-0001Ye-2R
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 04:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fVCCR-0005vl-7q
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 04:41:16 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fVCCR-0005vU-0u
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 04:41:15 -0400
Received: by mail-wm0-x241.google.com with SMTP id j15-v6so20504292wme.0
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 01:41:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87po0nyzrg.fsf@dusky.pond.sub.org>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-4-marcandre.lureau@redhat.com>
	<87po0nyzrg.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Jun 2018 10:41:12 +0200
Message-ID: <CAJ+F1C+aqkJau41jYMse_1ypq=prUjENjEXeymbKq8G4rv3u-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/49] qapi: add 'if' to top-level
 expressions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Tue, Jun 19, 2018 at 9:57 AM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Accept 'if' key in top-level elements, accepted as string or list of
>> string type. The following patches will modify the test visitor to
>> check the value is correctly saved, and generate #if/#endif code (as a
>> single #if/endif line or a series for a list).
>>
>> Example of 'if' key:
>> { 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
>>   'if': 'defined(TEST_IF_STRUCT)' }
>>
>> The generated code is for now *unconditional*. Later patches generate
>> the conditionals.
>>
>> A following patch for qapi-code-gen.txt will provide more complete
>> documentation for 'if' usage.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> [...]
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 0b277036df..f77ad2ba3b 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -436,6 +436,10 @@ qapi-schema +=3D args-unknown.json
>>  qapi-schema +=3D bad-base.json
>>  qapi-schema +=3D bad-data.json
>>  qapi-schema +=3D bad-ident.json
>> +qapi-schema +=3D bad-if.json
>> +qapi-schema +=3D bad-if-empty.json
>> +qapi-schema +=3D bad-if-empty-list.json
>> +qapi-schema +=3D bad-if-list.json
>>  qapi-schema +=3D bad-type-bool.json
>>  qapi-schema +=3D bad-type-dict.json
>>  qapi-schema +=3D bad-type-int.json
>> @@ -933,6 +937,8 @@ $(patsubst %, check-%, $(check-qapi-schema-y)): chec=
k-%.json: $(SRC_PATH)/%.json
>>               "TEST","$*.out")
>>       @# Sanitize error messages (make them independent of build directo=
ry)
>>       @perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff -u $(SRC_PA=
TH)/$*.err -
>> +     @if test "$(QAPI_REGENERATE)" =3D=3D 1 ; then cp $*.test.out $(SRC=
_PATH)/$*.out ; fi
>> +     @if test "$(QAPI_REGENERATE)" =3D=3D 1 ; then cp $*.test.err $(SRC=
_PATH)/$*.err ; fi
>>       @diff -u $(SRC_PATH)/$*.out $*.test.out
>>       @diff -u $(SRC_PATH)/$*.exit $*.test.exit
>>
>
> Huh?

Oops, leftover. Do you have an alternative? I could propose it as a
seperate patch if it's generally useful.

--=20
Marc-Andr=C3=A9 Lureau
