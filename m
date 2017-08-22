Received: from eggs.gnu.org ([2001:4830:134:3::10]:52819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dk7Cw-0000Pq-AQ
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dk7Cv-0003mJ-A1
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:18:54 -0400
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:37264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dk7Cv-0003lu-66
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:18:53 -0400
Received: by mail-vk0-x241.google.com with SMTP id r199so7615472vke.4
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 04:18:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87inhmflu4.fsf@dusky.pond.sub.org>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-23-marcandre.lureau@redhat.com>
	<87inhmflu4.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 22 Aug 2017 13:18:52 +0200
Message-ID: <CAJ+F1C+05ZVLJFDecR57penFA+xP0QLtzFajd+YQEsETp_vBRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 22/26] qapi: make rtc-reset-reinjection
 depend on TARGET_I386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Thu, Aug 17, 2017 at 1:57 PM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  qapi-schema.json |  3 ++-
>>  monitor.c        | 10 ----------
>>  2 files changed, 2 insertions(+), 11 deletions(-)
>>
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 2f4528c769..2361c13fc8 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -6270,7 +6270,8 @@
>>  # <- { "return": {} }
>>  #
>>  ##
>> -{ 'command': 'rtc-reset-reinjection' }
>> +{ 'command': 'rtc-reset-reinjection',
>> +  'if': ['defined(NEED_CPU_H)', 'defined(TARGET_I386)'] }
>
> Aha, here' you use the list syntax.
>
> And your strategy to keep things compiling also becomes clear: you wrap
> uses of poisoned symbols like TARGET_I386 in #if defined(NEED_CPU_H).
>
> Not exactly elegant, but looks workable.  But you need to explain this
> solution in commit messages [PATCH 21, I guess] and document it in
> qapi-code-gen.txt.  *Unless* we can find a better one.

Updated doc

>
>>
>>  # Rocker ethernet network switch
>>  { 'include': 'qapi/rocker.json' }
>> diff --git a/monitor.c b/monitor.c
>> index 383c84d162..f3dafafa22 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -970,9 +970,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QObje=
ct **ret_data,
>>   */
>>  static void qmp_unregister_commands_hack(void)
>>  {
>> -#ifndef TARGET_I386
>> -    qmp_unregister_command(&qmp_commands, "rtc-reset-reinjection");
>> -#endif
>>  #ifndef TARGET_S390X
>>      qmp_unregister_command(&qmp_commands, "dump-skeys");
>>  #endif
>> @@ -4151,13 +4148,6 @@ QemuOptsList qemu_mon_opts =3D {
>>      },
>>  };
>>
>> -#ifndef TARGET_I386
>> -void qmp_rtc_reset_reinjection(Error **errp)
>> -{
>> -    error_setg(errp, QERR_FEATURE_DISABLED, "rtc-reset-reinjection");
>> -}
>> -#endif
>> -
>>  #ifndef TARGET_S390X
>>  void qmp_dump_skeys(const char *filename, Error **errp)
>>  {
>



--=20
Marc-Andr=C3=A9 Lureau
