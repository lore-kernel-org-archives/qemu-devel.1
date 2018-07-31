Received: from eggs.gnu.org ([2001:4830:134:3::10]:54831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fkU0x-0002v6-Hv
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fkU0w-0001kW-MW
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:44:35 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fkU0w-0001k7-Co
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:44:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id v14-v6so16520258wro.5
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 05:44:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87tvofr6a8.fsf@dusky.pond.sub.org>
References: <20180731104258.2459-1-marcandre.lureau@redhat.com>
	<87tvofr6a8.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 31 Jul 2018 14:44:32 +0200
Message-ID: <CAJ+F1CJnXYZfKD2Uoy4cFpzEeHKXREdw3_3-f8Sao1PyO4=EFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] monitor: accept input on resume
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

On Tue, Jul 31, 2018 at 1:30 PM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> A chardev may stop trying to write if the associated can_read()
>> callback returned 0. This happens when the monitor is suspended.
>> The frontend is supposed to call qemu_chr_fe_accept_input() when it is
>> ready to accept data again.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Impact?

I have observed the issue with a spice port, all pending commands
aren't flushed. Most chardev don't use the accept_input() callback,
and instead poll regularly, like char-socket.c:tcp_chr_read_poll()

>
> Is this to be considered for 3.0?

This is not a regression, afaik, and doesn't impact common monitor
chardev. So it could be delayed. But it's also a small fix for Spice
chardev that shouldn't create regression, so it should be fine for
3.0.

thanks

>
>> ---
>>  monitor.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/monitor.c b/monitor.c
>> index d580c5a79c..e1a14e02cf 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -4412,6 +4412,7 @@ void monitor_resume(Monitor *mon)
>>              assert(mon->rs);
>>              readline_show_prompt(mon->rs);
>>          }
>> +        qemu_chr_fe_accept_input(&mon->chr);
>>      }
>>      trace_monitor_suspend(mon, -1);
>>  }
>



--=20
Marc-Andr=C3=A9 Lureau
