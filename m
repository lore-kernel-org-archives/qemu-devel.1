Received: from eggs.gnu.org ([2001:4830:134:3::10]:33965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXoLo-0003R4-SG
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXoLl-0005r2-LE
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:49:44 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:39254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXoLl-0005qk-F1
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:49:41 -0400
Received: by mail-pg0-x22a.google.com with SMTP id n2-v6so4229388pgq.6
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 06:49:41 -0700 (PDT)
References: <20180623022258.22158-1-programmingkidx@gmail.com>
	<ecf44486-09a4-9c9a-b96e-1db2d6a1bcbe@linaro.org>
	<1E63C3B2-7668-4D05-BC43-02E478FB493B@gmail.com>
	<bc3cd25b-bdd1-3bc7-8d2d-5c351f2c30d5@linaro.org>
	<4CC477CD-237F-480D-B9B5-B35FF507BD3C@gmail.com>
	<c6d132e2-b2e0-5bbb-7b71-9bd13253aa22@linaro.org>
	<2CAC99CF-A717-4A94-A68C-EEB76C727F87@gmail.com>
	<dbbebf00-9b32-4639-1e26-a888c48f6203@linaro.org>
	<CDA6AAA3-1452-4CBA-93A9-94CD83705E1A@gmail.com>
	<CAFXwXrk+X_heyWnwAzLQ6E9+j5=AxJ-Dh+nM5e7zuQcJCEAsyg@mail.gmail.com>
	<6918D473-064B-4356-B8B0-EE20ED05544F@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2c18018e-24a1-c098-e0a0-b8f497804c1d@linaro.org>
Date: Tue, 26 Jun 2018 06:49:37 -0700
MIME-Version: 1.0
In-Reply-To: <6918D473-064B-4356-B8B0-EE20ED05544F@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fix fdiv instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>

On 06/25/2018 03:23 PM, Programmingkid wrote:
> 
>> On Jun 25, 2018, at 5:08 PM, Richard Henderson <richard.henderson@linaro.org> wrote:
>>
>> On Mon, Jun 25, 2018, 08:23 G 3 <programmingkidx@gmail.com> wrote:
>>>
>>> Try
>>>
>>>     uint64_t expected_answer = 0xffff0000deadbeef;
>>>     ...
>>>     c.i = expected_answer;
>>>     asm volatile("fdiv %0, %1, %2" : "+f"(c.d) : "f"(1.0), "f"(0.0));
>>>
>>> to avoid depending on uninitialized data.  (This expected value is
>>> an SNaN with a deadbeef marker Just to be Sure.)
>>>
>>>
>>> r~
>>
>>
>> Ok I made this program and tried it on my iMac G5 (PowerPC 970).
>>
>> #include <stdio.h>
>> #include <stdint.h>
>> #include <inttypes.h>
>>
>> // Used to convert unsigned integer <--> double
>> union Converter
>> {
>>      double d;
>>      uint64_t i;
>> };
>> typedef union Converter Converter;
>>
>> int main (int argc, const char * argv[]) {
>>      Converter answer;
>>      answer.i = 0xffff0000deadbeef;
>>      //asm volatile("mtfsb1 27"); /* Set ZE bit */
>>      asm volatile("fdiv %0, %1, %2" : "=f"(answer.d) : "f"(1.0),  
>> "f"(0.0));
>>
>> Need +f for inout operand.
>> This didn't test what you expected.
> 
> What do you mean by inout operand?

An operand that is both input and output.

> If you could send me some sample code I will test it out.

I did, you just didn't read it properly.
Here it is again:

  asm volatile("fdiv %0, %1, %2"
               : "+f"(answer.d) : "f"(1.0), "f"(0.0));
                 ^^^^

r~
