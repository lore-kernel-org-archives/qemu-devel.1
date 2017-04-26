Received: from eggs.gnu.org ([2001:4830:134:3::10]:36137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3J9J-0000iv-Oa
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3J9I-00013q-Rm
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:22:13 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:37211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d3J9I-00012p-F7
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:22:12 -0400
Received: by mail-wm0-x232.google.com with SMTP id m123so119397492wma.0
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 02:22:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170426081816.GA2098@work-vm>
References: <1493179907-22516-1-git-send-email-thuth@redhat.com>
	<20170426081816.GA2098@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Apr 2017 10:21:50 +0100
Message-ID: <CAFEAcA8kDDnSuMfU7tFwMQf9sMVzpz=+dkuroWGRXGtbPkdFzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] monitor: Check whether TCG is enabled
 before running the "info jit" code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 26 April 2017 at 09:18, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> * Thomas Huth (thuth@redhat.com) wrote:
>> The "info jit" command currently aborts on Mac OS X with the message
>> "qemu_mutex_lock: Invalid argument" when running with "-M accel=qtest".
>> We should only call into the TCG code here if TCG has really been
>> enabled and initialized.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  monitor.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/monitor.c b/monitor.c
>> index be282ec..3e0979d 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -1086,6 +1086,11 @@ static void hmp_info_registers(Monitor *mon, const QDict *qdict)
>>
>>  static void hmp_info_jit(Monitor *mon, const QDict *qdict)
>>  {
>> +    if (!tcg_enabled()) {
>> +        error_report("JIT information is only available with accel=tcg");
>> +        return;
>> +    }
>> +
>>      dump_exec_info((FILE *)mon, monitor_fprintf);
>>      dump_drift_info((FILE *)mon, monitor_fprintf);
>>  }
>
> so tcg_enabled checks tcg_ctx.code_gen_buffer != NULL
> code_gen_buffer is set by code_gen_alloc
> code_gen_alloc does a qemu_mutex_init of tb_lock
> and the previous problem was an uninitialised tb_lock.
>
> So:
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>
> Peter: Does this fix the hmp test for you?

Yes, it does.

Tested-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM
