Received: from eggs.gnu.org ([2001:4830:134:3::10]:52841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8Ve1-000111-J6
	for qemu-devel@nongnu.org; Wed, 10 May 2017 13:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8Ve0-00023i-VA
	for qemu-devel@nongnu.org; Wed, 10 May 2017 13:43:25 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d8Ve0-00023X-RI
	for qemu-devel@nongnu.org; Wed, 10 May 2017 13:43:24 -0400
Received: by mail-qt0-x241.google.com with SMTP id j13so378680qta.3
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 10:43:24 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170509180715.22910-1-rth@twiddle.net>
	<20170509180715.22910-5-rth@twiddle.net>
	<20170510101620.q3mob35aivxz324g@aurel32.net>
	<6105454.pozpFHdzOs@perso>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7a84cbc8-ea93-ada5-eeaf-fc1ac143d826@twiddle.net>
Date: Wed, 10 May 2017 10:43:19 -0700
MIME-Version: 1.0
In-Reply-To: <6105454.pozpFHdzOs@perso>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 4/6] target/s390x: Implement LOAD PAIR
 DISJOINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?=c3=89ric_Bischoff?= <ebischoff@nerim.net>, Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org

On 05/10/2017 10:13 AM, Éric Bischoff wrote:
> Le mercredi 10 mai 2017, 12:16:20 Aurelien Jarno a écrit :
>>> +    /* In a parallel context, stop the world and single step.  */
>>> +    if (parallel_cpus) {
>>> +        potential_page_fault(s);
>>> +        gen_helper_exit_atomic(cpu_env);
>>> +        return EXIT_NORETURN;
>>> +    }
>>
>> One small additional comment about this patch I haven't spotted at the
>> first review. The exit_atomic helper is properly restoring the CPU state
>> passing the return address to cpu_loop_exit_atomic, so I believe the
>> potential_page_fault call is not necessary. That said, it doesn't hurt
>> either.
> 
> Merci pour la relecture Aurélien.
> 
> Richard, what do we do? We remove the potential_page_fault(s); or not?

I'm thinking of using gen_exception(EXCP_ATOMIC) instead.
The unwind associated with the regular helper_exit_atomic
has more overhead than potential_page_fault().


r~
