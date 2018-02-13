Received: from eggs.gnu.org ([2001:4830:134:3::10]:52453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elfOZ-000668-H1
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:33:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elfOY-0002RV-HT
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:33:35 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elfOY-0002Qz-CS
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:33:34 -0500
Received: by mail-oi0-x241.google.com with SMTP id b3so14585216oib.11
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 10:33:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <40306631-7740-3b72-f561-16a786cf8c7a@redhat.com>
References: <20180213140029.8308-1-peter.maydell@linaro.org>
	<40306631-7740-3b72-f561-16a786cf8c7a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 18:33:13 +0000
Message-ID: <CAFEAcA8iAxN=t12akUD5XHFeG3+6+nbWbdr2Z_Hn606=A6VJmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] log-for-trace.h: Split out parts of log.h
 used by trace.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 13 February 2018 at 15:19, Eric Blake <eblake@redhat.com> wrote:
> On 02/13/2018 08:00 AM, Peter Maydell wrote:
>> +++ b/scripts/tracetool/backend/log.py
>> @@ -20,7 +20,7 @@ PUBLIC = True
>>       def generate_h_begin(events, group):
>> -    out('#include "qemu/log.h"',
>> +    out('#include "qemu/log-for-trace.h"',
>>           '')
>>     @@ -35,14 +35,13 @@ def generate_h(event, group):
>>       else:
>>           cond = "trace_event_get_state(%s)" % ("TRACE_" +
>> event.name.upper())
>>   -    out('    if (%(cond)s) {',
>> +    out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
>>           '        struct timeval _now;',
>>           '        gettimeofday(&_now, NULL);',
>> -        '        qemu_log_mask(LOG_TRACE,',
>
>
> Oh, nice side effect - the old code was unconditionally calling
> gettimeofday() even when qemu_loglevel_mask(LOG_TRACE) fails; the new code
> limits the call when the logging is actually going to happen.

True, but I think in practice if the trace_event_get_state()
check succeeds then LOG_TRACE will always be on.

(Slightly oddly, qemu_str_to_log_mask() only sets LOG_TRACE if
a trace:foo event was enabled, but qemu_set_log() forces LOG_TRACE
to on even if no trace events were enabled.)

>> -        '                      "%%d@%%zd.%%06zd:%(name)s " %(fmt)s
>> "\\n",',
>> -        '                      getpid(),',
>> -        '                      (size_t)_now.tv_sec,
>> (size_t)_now.tv_usec',
>> -        '                      %(argnames)s);',
>> +        '        qemu_log("%%d@%%zd.%%06zd:%(name)s " %(fmt)s "\\n",',
>> +        '                 getpid(),',
>> +        '                 (size_t)_now.tv_sec, (size_t)_now.tv_usec',
>> +        '                 %(argnames)s);',
>>           '    }',
>>           cond=cond,
>>           name=event.name,
>>
>
> If you don't think the extra preprocessor magic to prevent accidental
> inclusion of the internal header is necessary, then
> Reviewed-by: Eric Blake <eblake@redhat.com>

It doesn't seem very likely in practice that anybody would
include the obscure internal header. We can add the magic
later if the mistake seems to happen in practice...

thanks
-- PMM
