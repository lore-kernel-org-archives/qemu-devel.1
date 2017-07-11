Received: from eggs.gnu.org ([2001:4830:134:3::10]:59664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUqW1-0003zU-O1
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUqVy-0004kB-L6
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:27:29 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUqVy-0004j0-D3
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:27:26 -0400
Received: by mail-wr0-x233.google.com with SMTP id r103so172864814wrb.0
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 01:27:26 -0700 (PDT)
References: <20170710192128.9048-1-alex.bennee@linaro.org>
	<20170710192128.9048-5-alex.bennee@linaro.org>
	<e21159d2-42aa-1b08-5ea9-2f367a8e452f@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <e21159d2-42aa-1b08-5ea9-2f367a8e452f@twiddle.net>
Date: Tue, 11 Jul 2017 09:27:23 +0100
Message-ID: <87lgnv9y50.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] target/arm: use DISAS_JUMP for ISB
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: peter.maydell@linaro.org, cota@braap.org, qemu-devel@nongnu.org, "open list:ARM" <qemu-arm@nongnu.org>


Richard Henderson <rth@twiddle.net> writes:

> On 07/10/2017 09:21 AM, Alex Bennée wrote:
>> -        s->is_jmp = DISAS_UPDATE;
>> +        gen_a64_set_pc_im(s->pc);
>> +        s->is_jmp = DISAS_JUMP;
>
> Better would be gen_goto_tb.  The destination is known, so there's no
> need to go through lookup_and_goto_ptr.  You still get the icount_decr
> check at the start of the linked TB, which is what you're looking for.
>
> Interesting that a64's gen_goto_tb sets is_jmp, but a32 does not...

Hmm the only caller that is not already in the exit path sets it. Maybe
I should push the s->is_jmp to the a32 gen_goto_tb? I can then do the
same in both.

--
Alex Bennée
