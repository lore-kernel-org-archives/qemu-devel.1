Received: from eggs.gnu.org ([2001:4830:134:3::10]:54177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dROze-0002Zv-9W
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 16:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dROzb-0007XT-69
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 16:27:50 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:32853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dROzb-0007Wi-2D
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 16:27:47 -0400
Received: by mail-qt0-x242.google.com with SMTP id c20so19171649qte.0
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 13:27:47 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170622231228.1050-1-david@redhat.com>
	<20170625221956.rda2cls2ex7icapa@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <98e6dd78-d30d-fdb3-0572-5983154e2669@twiddle.net>
Date: Sat, 1 Jul 2017 13:27:43 -0700
MIME-Version: 1.0
In-Reply-To: <20170625221956.rda2cls2ex7icapa@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Aurelien Jarno <aurelien@aurel32.net>, David Hildenbrand <david@redhat.com>
Cc: agraf@suse.de, thuth@redhat.com, qemu-devel@nongnu.org

On 06/25/2017 03:19 PM, Aurelien Jarno wrote:
> On 2017-06-23 01:12, David Hildenbrand wrote:
>> If we have for example: r3 contains 0x00000000ffffffff
>>      ec 33 3f bf 61 55       risbg   %r3,%r3,63,191,97
>>
>> We want to rotate 33 to the left and only keep MSB bit 63 of that. So the
>> result is then exactly 1 (we're reading the sign of the 32 bit value).
>>
>> Current code assumes that we can do that via an extract, which is not
>> true (at least not that easy) and produces a 0.
> 
> I think the mistake there is that the rotation is done to the left,
> while in extract the "shift" is done to the right. The following patch
> should be enough:
> 
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -3441,8 +3441,8 @@ static ExitStatus op_risbg(DisasContext *s, DisasOps *o)
>       }
>   
>       /* In some cases we can implement this with extract.  */
> -    if (imask == 0 && pos == 0 && len > 0 && rot + len <= 64) {
> -        tcg_gen_extract_i64(o->out, o->in2, rot, len);
> +    if (imask == 0 && pos == 0 && len > 0 && rot - len >= 0) {
> +        tcg_gen_extract_i64(o->out, o->in2, 64 - rot, len);
>           return NO_EXIT;

Agreed.  Included.


r~
