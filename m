Received: from eggs.gnu.org ([2001:4830:134:3::10]:45955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dG6Rx-0005mp-SK
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dG6Rb-0007uU-M7
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:26:21 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:36346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dG6Rb-0007tR-Cx
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:25:59 -0400
Received: by mail-wm0-x22e.google.com with SMTP id 7so125023128wmo.1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 09:25:59 -0700 (PDT)
References: <20170531150933.10156-1-alex.bennee@linaro.org>
	<20170531150933.10156-3-alex.bennee@linaro.org>
	<20170531181737.230cbded@p-imbrenda.boeblingen.de.ibm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170531181737.230cbded@p-imbrenda.boeblingen.de.ibm.com>
Date: Wed, 31 May 2017 17:26:13 +0100
Message-ID: <87y3tdro0q.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] gdbstub: don't fail on vCont; C04:0;
 c packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: pbonzini@redhat.com, doug16k@gmail.com, qemu-devel@nongnu.org


Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> writes:

> On Wed, 31 May 2017 16:09:33 +0100
> Alex Bennée <alex.bennee@linaro.org> wrote:
>
>> The thread-id of 0 means any CPU but we then ignore the fact we find
>> the first_cpu in this case who can have an index of 0. Instead of
>> bailing out just test if we have managed to match up thread-id to a
>> CPU.
>>
>> Otherwise you get:
>>   gdb_handle_packet: command='vCont;C04:0;c'
>>   put_packet: reply='E22'
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>  gdbstub.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index a249846954..29c9ed3002 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -934,8 +934,8 @@ static int gdb_handle_vcont(GDBState *s, const
>> char *p)
>>               * CPU first, and only then we can use its index.
>>               */
>>              cpu = find_cpu(idx);
>> -            /* invalid CPU/thread specified */
>> -            if (!idx || !cpu) {
>> +            /* invalid thread specified, cpu not found. */
>> +            if (!cpu) {
>>                  res = -EINVAL;
>>                  goto out;
>>              }
>
> This is strange. cpu_index() is defined as:
>
> static inline int cpu_index(CPUState *cpu)
> {
> #if defined(CONFIG_USER_ONLY)
>     return cpu->host_tid;
> #else
>     return cpu->cpu_index + 1;
> #endif
> }
>
> therefore it shouldn't return 0 under any circumstance, and
> find_cpu(idx) should also fail if idx == 0, because internally it also
> uses cpu_index()
>
> on the other hand, you say that the patch does fix the problem for you,
> which really confuses me.

Hmm that was me assuming cpu_index(cpu) was the same as cpu->cpu_index.
However in the CONFIG_USER_ONLY case we return host_tid which is only
set by clone_func() so I think will not be set for the first cpu.

>
>
>
> (probably) completely unrelatedly, this:
>
> res = qemu_strtoul(p + 1, &p, 16, &tmp);
>
> should be like this instead:
>
> res = qemu_strtoul(p, &p, 16, &tmp);
>
> but this shouldn't impact you in any way.


--
Alex Bennée
