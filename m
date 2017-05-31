Received: from eggs.gnu.org ([2001:4830:134:3::10]:47436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dG6T2-0006RN-2p
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dG6SP-00009Z-SG
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:27:28 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:36775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dG6SP-00008E-Kg
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:26:49 -0400
Received: by mail-wm0-x234.google.com with SMTP id 7so125051239wmo.1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 09:26:49 -0700 (PDT)
References: <20170531150933.10156-1-alex.bennee@linaro.org>
	<20170531150933.10156-3-alex.bennee@linaro.org>
	<20170531181732.13140426@bahia.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170531181732.13140426@bahia.lan>
Date: Wed, 31 May 2017 17:27:04 +0100
Message-ID: <87wp8xrnzb.fsf@linaro.org>
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
To: Greg Kurz <groug@kaod.org>
Cc: pbonzini@redhat.com, doug16k@gmail.com, imbrenda@linux.vnet.ibm.com, qemu-devel@nongnu.org


Greg Kurz <groug@kaod.org> writes:

> On Wed, 31 May 2017 16:09:33 +0100
> Alex Bennée <alex.bennee@linaro.org> wrote:
>
>> The thread-id of 0 means any CPU but we then ignore the fact we find
>> the first_cpu in this case who can have an index of 0. Instead of
>
> The index can never be 0 in system mode actually, but you're right that this
> check doesn't make sense.
>
> The code still looks a bit convoluted IMHO. What about something like the
> following ?
>
>             /* 0 means any thread, so we pick the first valid CPU */
>             cpu = tmp ? find_cpu(tmp) : first_cpu;
>
>             /* invalid CPU/thread specified */
>             if (!cpu) {
>                 res = -EINVAL;
>                 goto out;
>             }

Yeah that will make it cleaner, I'll apply to v2.

>
> Anyway, the fix looks ok.
>
> Reviewed-by: Greg Kurz <groug@kaod.org>
>
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
>> @@ -934,8 +934,8 @@ static int gdb_handle_vcont(GDBState *s, const char *p)
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


--
Alex Bennée
