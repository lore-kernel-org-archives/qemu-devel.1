Received: from eggs.gnu.org ([2001:4830:134:3::10]:48277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9WAM-0004mk-TL
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9WAJ-0002Hr-7p
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:05:46 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:38416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9WAG-0002DO-MY
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:05:42 -0400
Received: by mail-wr1-x42a.google.com with SMTP id a13-v6so20982577wrt.5
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 07:05:34 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-20-alex.bennee@linaro.org>
	<005c01d45f06$bbd7c6b0$33875410$@ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <005c01d45f06$bbd7c6b0$33875410$@ru>
Date: Mon, 08 Oct 2018 15:05:31 +0100
Message-ID: <871s90o7o4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 19/21] plugins: add an example
 hotblocks plugin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, 'Stefan Hajnoczi' <stefanha@redhat.com>


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

> I guess this one is too tcg-dependent.
> It count TB's, but breaking code into TBs may depend on many things,
> like breakpoints, record/replay, ...
>
> I mean that this measuring approach may be used only in some specific
> cases, and not ok as an example.

You are right it involves a degree of knowledge of how the TCG works
although it doesn't look inside the internals to do it - you do have to
specify -d nochain to get useful numbers.

I used this as an example in lieu of defining tracepoints in the main
translation loop. They would be better there as it would be unambiguous
what the behaviour would be. That said I think a translation block start
as well as pre/post instruction translation points would be useful as
block level granularity will be good enough for a number of use cases.

>
> Pavel Dovgalyuk
>
>> -----Original Message-----
>> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
>> Sent: Friday, October 05, 2018 6:49 PM
>> To: qemu-devel@nongnu.org
>> Cc: Pavel.Dovgaluk@ispras.ru; vilanova@ac.upc.edu; cota@braap.org; Alex =
Benn=C3=A9e; Stefan
>> Hajnoczi
>> Subject: [RFC PATCH 19/21] plugins: add an example hotblocks plugin
>>
>> This plugin attempts to track hotblocks by total execution count and
>> average time to return to block. It is intended to be lower impact
>> than saving a long log file and post-processing it.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  trace/plugins/hotblocks/hotblocks.c | 69 +++++++++++++++++++++++++++++
>>  1 file changed, 69 insertions(+)
>>  create mode 100644 trace/plugins/hotblocks/hotblocks.c
>>
>> diff --git a/trace/plugins/hotblocks/hotblocks.c b/trace/plugins/hotbloc=
ks/hotblocks.c
>> new file mode 100644
>> index 0000000000..e9166ad1a5
>> --- /dev/null
>> +++ b/trace/plugins/hotblocks/hotblocks.c
>> @@ -0,0 +1,69 @@
>> +/*
>> + * Execution Hotblocks Plugin
>> + *
>> + * Copyright (c) 2018
>> + * Written by Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> + *
>> + * This code is licensed under the GNU GPL v2.
>> + */
>> +
>> +#include <stdint.h>
>> +#include <stdio.h>
>> +#include <glib.h>
>> +#include <time.h>
>> +#include "plugins.h"
>> +
>> +/* Plugins need to take care of their own locking */
>> +GMutex lock;
>> +GHashTable *hotblocks;
>> +
>> +typedef struct {
>> +    uintptr_t pc;
>> +    unsigned int hits;
>> +    struct timespec last;
>> +    unsigned long total_time;
>> +} ExecCount;
>> +
>> +bool plugin_init(const char *args)
>> +{
>> +    hotblocks =3D g_hash_table_new(NULL, g_direct_equal);
>> +    return true;
>> +}
>> +
>> +char *plugin_status(void)
>> +{
>> +    GString *report =3D g_string_new("We have ");
>> +    char *r;
>> +    g_mutex_lock(&lock);
>> +    g_string_append_printf(report, "%ud entries in the hash table\n",
>> +                           g_hash_table_size(hotblocks));
>> +    g_mutex_unlock(&lock);
>> +    r =3D report->str;
>> +    g_string_free(report, FALSE);
>> +    return r;
>> +}
>> +
>> +bool exec_tb(void *tb, uintptr_t pc)
>> +{
>> +    ExecCount *cnt;
>> +    struct timespec current;
>> +    clock_gettime(CLOCK_MONOTONIC, &current);
>> +
>> +    g_mutex_lock(&lock);
>> +    cnt =3D (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer=
) pc);
>> +    if (cnt) {
>> +        cnt->hits++;
>> +        cnt->total_time +=3D current.tv_nsec - cnt->last.tv_nsec;
>> +        cnt->last =3D current;
>> +    } else {
>> +        cnt =3D g_new0(ExecCount, 1);
>> +        cnt->pc =3D pc;
>> +        cnt->last =3D current;
>> +        cnt->hits =3D 1;
>> +        g_hash_table_insert(hotblocks, (gpointer) pc, (gpointer) cnt);
>> +    }
>> +    g_mutex_unlock(&lock);
>> +
>> +    /* As we are collecting up samples no reason to continue tracing */
>> +    return false;
>> +}
>> --
>> 2.17.1


--
Alex Benn=C3=A9e
