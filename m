Received: from eggs.gnu.org ([2001:4830:134:3::10]:36511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dIAN9-0001mC-EK
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dIAN6-0008S9-BT
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:01:55 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:32900 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dIAN5-0008Rl-Uu
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 05:01:52 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-19-vsementsov@virtuozzo.com>
	<426afe4b-30b9-8d85-67d5-20af3bae775d@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <31f65f46-29f2-db09-e2aa-42cd62bcd0c6@virtuozzo.com>
Date: Tue, 6 Jun 2017 12:01:46 +0300
MIME-Version: 1.0
In-Reply-To: <426afe4b-30b9-8d85-67d5-20af3bae775d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 18/19] nbd/client: refactor TRACE of
 NBD_MAGIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

05.06.2017 18:06, Eric Blake wrote:
> On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   nbd/client.c | 26 +++++++++++++++++---------
>>   1 file changed, 17 insertions(+), 9 deletions(-)
>>
>> diff --git a/nbd/client.c b/nbd/client.c
>> index 3d15596120..52f7981c9c 100644
>> --- a/nbd/client.c
>> +++ b/nbd/client.c
>> @@ -426,6 +426,21 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
>>       return QIO_CHANNEL(tioc);
>>   }
>>   
>> +static const char *nbd_magic_to_string(char *out, const char *in,
>> +                                       size_t count)
>> +{
>> +    size_t i;
>> +
>> +    for (i = 0; i < count; ++i) {
>> +        if (in[i] == '\0') {
>> +            out[i] = '\0';
>> +            break;
>> +        }
>> +        out[i] = qemu_isprint(in[i]) ? in[i] : '.';
>> +    }
>> +
>> +    return out;
>> +}
> Do we really need this?
>
>> -    TRACE("Magic is %c%c%c%c%c%c%c%c",
>> -          qemu_isprint(buf[0]) ? buf[0] : '.',
>> -          qemu_isprint(buf[1]) ? buf[1] : '.',
>> -          qemu_isprint(buf[2]) ? buf[2] : '.',
>> -          qemu_isprint(buf[3]) ? buf[3] : '.',
>> -          qemu_isprint(buf[4]) ? buf[4] : '.',
>> -          qemu_isprint(buf[5]) ? buf[5] : '.',
>> -          qemu_isprint(buf[6]) ? buf[6] : '.',
>> -          qemu_isprint(buf[7]) ? buf[7] : '.');
>> +    TRACE("Magic is %s", nbd_magic_to_string(print_buf, buf, 9));
> Would it be any simpler to just print the received magic as a 64-bit
> number in hex, instead of trying to string-ize it?  Either the client
> sends the right magic (the usual case), so we don't need to waste time
> string-izing it, or the client is bogus and sent us garbage (where
> printing a hex value is just as efficient as string-izing things to see
> what the garbage actually was).
>
agree.



-- 
Best regards,
Vladimir
