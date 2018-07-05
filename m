Received: from eggs.gnu.org ([2001:4830:134:3::10]:56679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fb3CI-0005Y8-NI
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fb3CH-0001Wc-Um
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:17:18 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fb3CH-0001UG-Mb
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:17:17 -0400
Received: by mail-wr1-x441.google.com with SMTP id p1-v6so1057577wrs.9
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 05:17:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87k1q99aeu.fsf@dusky.pond.sub.org>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
	<20180326150916.9602-9-marcandre.lureau@redhat.com>
	<87k1q99aeu.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 5 Jul 2018 14:17:16 +0200
Message-ID: <CAJ+F1CKtWFiwMHpcfbZcy22aRwbA0-YEbMCqZVKexWcGV=60rQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 08/38] json-lexer: make it safe to call
 multiple times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Thu, Jul 5, 2018 at 1:42 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> We can easily avoid the burden of checking if the lexer was
>> initialized prior to calling destroy by the caller, let's do it.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  qobject/json-lexer.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
>> index 980ba159d6..0eaba43a2c 100644
>> --- a/qobject/json-lexer.c
>> +++ b/qobject/json-lexer.c
>> @@ -386,5 +386,8 @@ int json_lexer_flush(JSONLexer *lexer)
>>
>>  void json_lexer_destroy(JSONLexer *lexer)
>>  {
>> -    g_string_free(lexer->token, true);
>> +    if (lexer->token) {
>> +        g_string_free(lexer->token, true);
>> +        lexer->token =3D NULL;
>> +    }
>>  }
>
> Is this just on general principles[*], or does it enable simplifactions
> later in this series?
>
>

It allowed further simplification later in the series. I don't know if
this is still necessary after the rebase and other changes, feel free
to delay it.

thanks



--=20
Marc-Andr=C3=A9 Lureau
