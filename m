Received: from eggs.gnu.org ([2001:4830:134:3::10]:39925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgoeG-0002K4-A9
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:21:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgoeC-0005kJ-7a
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:21:12 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cgoeC-0005k6-1a
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:21:08 -0500
Received: by mail-wm0-x22b.google.com with SMTP id r141so4830167wmg.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 00:21:07 -0800 (PST)
References: <20170222171327.26624-1-alex.bennee@linaro.org>
	<20170222171327.26624-6-alex.bennee@linaro.org>
	<CAJhHMCAJ9ci+qhmQD48WZHzUiGqodaUfhd=bNrhU27o=VEYG_Q@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAJhHMCAJ9ci+qhmQD48WZHzUiGqodaUfhd=bNrhU27o=VEYG_Q@mail.gmail.com>
Date: Thu, 23 Feb 2017 08:21:15 +0000
Message-ID: <87y3wxuxl0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v13 05/24] tcg: add options for enabling
 MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, MTTCG Devel <mttcg@listserver.greensocs.com>, KONRAD =?utf-8?B?RnLDqWTDqXJpYw==?= <fred.konrad@greensocs.com>, alvise rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, nikunj@linux.vnet.ibm.com, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Sergey Fedorov <serge.fdrv@gmail.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>


Pranith Kumar <bobby.prani@gmail.com> writes:

> Hi Alex,
>
> On Wed, Feb 22, 2017 at 12:13 PM, Alex Bennée <alex.bennee@linaro.org> wrote:
>> From: KONRAD Frederic <fred.konrad@greensocs.com>
>>
>> We know there will be cases where MTTCG won't work until additional work
>> is done in the front/back ends to support. It will however be useful to
>> be able to turn it on.
>>
>> As a result MTTCG will default to off unless the combination is
>> supported. However the user can turn it on for the sake of testing.
>>
>> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
>> [AJB: move to -accel tcg,thread=multi|single, defaults]
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Reviewed-by: Richard Henderson <rth@twiddle.net>
>> ---
>> v1:
>>   - merge with add mttcg option.
>>   - update commit message
>> v2:
>>   - machine_init->opts_init
>> v3:
>>   - moved from -tcg to -accel tcg,thread=single|multi
>>   - fix checkpatch warnings
>> v4:
>>   - make mttcg_enabled extern, qemu_tcg_mttcg_enabled() now just macro
>>   - qemu_tcg_configure now propagates Error instead of exiting
>>   - better error checking of thread=foo
>>   - use CONFIG flags for default_mttcg_enabled()
>>   - disable mttcg with icount, error if both forced on
>> v7
>>   - explicitly disable MTTCG for TCG_OVERSIZED_GUEST
>>   - use check_tcg_memory_orders_compatible() instead of CONFIG_MTTCG_HOST
>>   - change CONFIG_MTTCG_TARGET to TARGET_SUPPORTS_MTTCG
>> v8
>>   - fix missing include tcg.h
>>   - change mismatched MOs to a warning instead of error
>> v10
>>   - TCG_DEFAULT_MO -> TCG_GUEST_DEFAULT_MO
>> v11
>>   - tweak warning message
>> ---
>>  cpus.c                | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/qom/cpu.h     |  9 +++++++
>>  include/sysemu/cpus.h |  2 ++
>>  qemu-options.hx       | 20 ++++++++++++++
>>  tcg/tcg.h             |  9 +++++++
>>  vl.c                  | 49 +++++++++++++++++++++++++++++++++-
>>  6 files changed, 161 insertions(+), 1 deletion(-)
>>
>> diff --git a/cpus.c b/cpus.c
>> index 0bcb5b50b6..c296ec715f 100644
>> --- a/cpus.c
>> +++ b/cpus.c
> <...>
>> +void qemu_tcg_configure(QemuOpts *opts, Error **errp)
>> +{
>> +    const char *t = qemu_opt_get(opts, "thread");
>> +    if (t) {
>> +        if (strcmp(t, "multi") == 0) {
>> +            if (TCG_OVERSIZED_GUEST) {
>> +                error_setg(errp, "No MTTCG when guest word size > hosts");
>> +            } else {
>> +                if (!check_tcg_memory_orders_compatible()) {
>> +                    error_report("Guest expects a stronger memory ordering than"
>> +                                 "the host provides");
>> +                    error_printf("This may cause strange/hard to debug errors");
>> +                }
>
> This prints it as:
>
> Guest expects a stronger memory ordering thanthe host provides
>
> Please add a space between 'than' and 'the'.

Will do.

> Also why are you using
> error_report() for the first line and error_printf() for the second?

There is only one error to report, quoth HACKING:

"Use error_printf() & friends to print additional information."

--
Alex Bennée
