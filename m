Received: from eggs.gnu.org ([2001:4830:134:3::10]:43093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dRxLm-00051q-Fa
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 05:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dRxLj-0003Us-49
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 05:08:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dRxLi-0003T5-Tg
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 05:08:55 -0400
References: <20170622231228.1050-1-david@redhat.com>
	<20170625221956.rda2cls2ex7icapa@aurel32.net>
	<98e6dd78-d30d-fdb3-0572-5983154e2669@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <22333f7b-5e04-7a71-db9b-7f142e21dcd6@redhat.com>
Date: Mon, 3 Jul 2017 11:08:49 +0200
MIME-Version: 1.0
In-Reply-To: <98e6dd78-d30d-fdb3-0572-5983154e2669@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] target-s390x: fix risbg handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>
Cc: agraf@suse.de, thuth@redhat.com, qemu-devel@nongnu.org

On 01.07.2017 22:27, Richard Henderson wrote:
> On 06/25/2017 03:19 PM, Aurelien Jarno wrote:
>> On 2017-06-23 01:12, David Hildenbrand wrote:
>>> If we have for example: r3 contains 0x00000000ffffffff
>>>      ec 33 3f bf 61 55       risbg   %r3,%r3,63,191,97
>>>
>>> We want to rotate 33 to the left and only keep MSB bit 63 of that. So the
>>> result is then exactly 1 (we're reading the sign of the 32 bit value).
>>>
>>> Current code assumes that we can do that via an extract, which is not
>>> true (at least not that easy) and produces a 0.
>>
>> I think the mistake there is that the rotation is done to the left,
>> while in extract the "shift" is done to the right. The following patch
>> should be enough:
>>
>> --- a/target/s390x/translate.c
>> +++ b/target/s390x/translate.c
>> @@ -3441,8 +3441,8 @@ static ExitStatus op_risbg(DisasContext *s, DisasOps *o)
>>       }
>>   
>>       /* In some cases we can implement this with extract.  */
>> -    if (imask == 0 && pos == 0 && len > 0 && rot + len <= 64) {
>> -        tcg_gen_extract_i64(o->out, o->in2, rot, len);
>> +    if (imask == 0 && pos == 0 && len > 0 && rot - len >= 0) {
>> +        tcg_gen_extract_i64(o->out, o->in2, 64 - rot, len);
>>           return NO_EXIT;
> 
> Agreed.  Included.
> 
> 
> r~
> 

Was able to test it with your version and it works just fine!

Thanks!

-- 

Thanks,

David
