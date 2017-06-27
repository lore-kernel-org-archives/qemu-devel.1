Received: from eggs.gnu.org ([2001:4830:134:3::10]:52326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPtkh-0006m9-DF
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPtWO-0001JC-EV
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:39:27 -0400
Received: from mail-qk0-x235.google.com ([2607:f8b0:400d:c09::235]:35590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPtWO-0001J2-AA
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:39:24 -0400
Received: by mail-qk0-x235.google.com with SMTP id 16so29921220qkg.2
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 09:39:24 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170621024831.26019-1-rth@twiddle.net>
	<20170621024831.26019-10-rth@twiddle.net> <87vanhx0xa.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <72213e0f-659e-e9dd-4915-94efff90ca29@twiddle.net>
Date: Tue, 27 Jun 2017 09:39:21 -0700
MIME-Version: 1.0
In-Reply-To: <87vanhx0xa.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/16] tcg: Use per-temp state data in
 liveness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net

On 06/27/2017 01:57 AM, Alex Bennée wrote:
>> -            /* Note this unsigned test catches TCG_CALL_ARG_DUMMY too.  */
>> -            if (arg < nb_globals) {
> 
> This test is gone but....
> 
>> -                dir = dir_temps[arg];
>> -                if (dir != 0 && temp_state[arg] == TS_DEAD) {
>> -                    TCGTemp *its = arg_temp(arg);
>> -                    TCGOpcode lopc = (its->type == TCG_TYPE_I32
>> -                                      ? INDEX_op_ld_i32
>> -                                      : INDEX_op_ld_i64);
>> -                    TCGOp *lop = tcg_op_insert_before(s, op, lopc, 3);
>> -
>> -                    lop->args[0] = dir;
>> -                    lop->args[1] = temp_arg(its->mem_base);
>> -                    lop->args[2] = its->mem_offset;
>> -
>> -                    /* Loaded, but synced with memory.  */
>> -                    temp_state[arg] = TS_MEM;
>> -                }
>> +            arg_ts = arg_temp(op->args[i]);
>> +            dir_ts = arg_ts->state_ptr;
>> +            if (dir_ts && arg_ts->state == TS_DEAD) {
> 
> ...we de-ref arg_ts here. So what if it was a TCG_CALL_ARG_DUMMY?

Good catch.  I need to do more testing on a host that actually uses this padding...


r~
