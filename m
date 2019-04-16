Received: from eggs.gnu.org ([209.51.188.92]:36929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGJeH-0005mS-2H
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGJeF-0001rF-GY
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:41:00 -0400
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-6-david@redhat.com>
	<fed7735f-6d51-f84d-8160-6967ffec2338@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b2442338-174b-65fc-0fc4-b6af58c60eb0@redhat.com>
Date: Tue, 16 Apr 2019 10:40:52 +0200
MIME-Version: 1.0
In-Reply-To: <fed7735f-6d51-f84d-8160-6967ffec2338@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 05/41] s390x/tcg: Implement VECTOR ADD
 WITH CARRY COMPUTE CARRY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 12.04.19 23:58, Richard Henderson wrote:
> On 4/11/19 12:08 AM, David Hildenbrand wrote:
>> +static DisasJumpType op_vaccc(DisasContext *s, DisasOps *o)
>> +{
>> +    if (get_field(s->fields, m5) != ES_128) {
>> +        gen_program_exception(s, PGM_SPECIFICATION);
>> +        return DISAS_NORETURN;
>> +    }
>> +
>> +    gen_gvec_4_ool(get_field(s->fields, v1), get_field(s->fields, v2),
>> +                   get_field(s->fields, v3), get_field(s->fields, v4), 0,
>> +                   gen_helper_gvec_vaccc128);
>> +    return DISAS_NEXT;
>> +}
> 
> An inline expansion could be
> 
> One possible expansion is
> 
>   tcg_gen_andi_i64(tl, cl, 1);
>   tcg_gen_add2_i64(tl, th, tl, zero, al, zero);
>   tcg_gen_add2_i64(tl, th, tl, th, bl, zero);
>   tcg_gen_add2_i64(tl, th, th, zero, ah, zero);
>   tcg_gen_add2_i64(tl, th, tl, th, bl, zero);
>   /* carry out in th */
> 
> This is 8 insns for the addition vs the hw optimal 6, but we're not exactly an
> optimizing compiler either.  ;-)
> 

Yes, very nice! Thanks!

> 
> r~
> 


-- 

Thanks,

David / dhildenb
