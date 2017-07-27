Received: from eggs.gnu.org ([2001:4830:134:3::10]:36621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daoIY-0006h1-2T
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 15:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daoIV-0000zi-FR
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 15:18:14 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170727024224.22900-1-f4bug@amsat.org>
	<20170727024224.22900-18-f4bug@amsat.org>
	<20170727134005.76e74eb6@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <96837087-e5a3-3c8c-63f3-fab1f821274a@amsat.org>
Date: Thu, 27 Jul 2017 16:18:07 -0300
MIME-Version: 1.0
In-Reply-To: <20170727134005.76e74eb6@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for 2.10 v2 18/20] 9pfs:
 avoid sign conversion error simplifying the code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

On 07/27/2017 08:40 AM, Greg Kurz wrote:
> On Wed, 26 Jul 2017 23:42:22 -0300
> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> Reviewed-by: Greg Kurz <groug@kaod.org>
> 
> Now, I'm not sure this can be merged during hard freeze since it is
> more code cleanup than actual bug fixing...

Hmm the commit message is probably not enough.
The problem is this code can send broken packets, see inlined:

> 
>>   hw/9pfs/9p.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
>> index 333dbb6f8e..0a37c8bd13 100644
>> --- a/hw/9pfs/9p.c
>> +++ b/hw/9pfs/9p.c
>> @@ -945,7 +945,6 @@ static void coroutine_fn v9fs_version(void *opaque)
>>       v9fs_string_init(&version);
>>       err = pdu_unmarshal(pdu, offset, "ds", &s->msize, &version);
>>       if (err < 0) {

if err == -1

>> -        offset = err;

here this sets offset = (size_t)(-1) = SIZE_MAX

>>           goto out;
>>       }
>>       trace_v9fs_version(pdu->tag, pdu->id, s->msize, version.data);
>> @@ -962,13 +961,12 @@ static void coroutine_fn v9fs_version(void *opaque)
>>   
>>       err = pdu_marshal(pdu, offset, "ds", s->msize, &version);
>>       if (err < 0) {
>> -        offset = err;
>>           goto out;
>>       }
>> -    offset += err;

here offset += SIZE_MAX which wraps, so this equivs to offset -= 1

>> +    err += offset;
>>       trace_v9fs_version_return(pdu->tag, pdu->id, s->msize, version.data);
>>   out:
>> -    pdu_complete(pdu, offset);

now we have offset = 7 - 1 = 6, since 6 > 0 pdu_complete() does not 
marshal the error code but 6 bytes of crap from pdu?

Maybe I missed something.

>> +    pdu_complete(pdu, err);
>>       v9fs_string_free(&version);
>>   }
>>   

Regards,

Phil.
