Received: from eggs.gnu.org ([2001:4830:134:3::10]:33204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRhUZ-00008B-Iz
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:40:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRhUU-0003OH-MT
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:40:43 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:36297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cRhUU-0003Nn-8E
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:40:38 -0500
Received: by mail-lf0-x244.google.com with SMTP id h65so2353921lfi.3
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 07:40:38 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170104132625.28059-1-pbonzini@redhat.com>
	<20170104132625.28059-5-pbonzini@redhat.com>
	<20170112133445.GE26504@lemon>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5fdf0b89-4e2c-cdb1-7ec5-f5f292e61768@redhat.com>
Date: Thu, 12 Jan 2017 16:40:36 +0100
MIME-Version: 1.0
In-Reply-To: <20170112133445.GE26504@lemon>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/10] qemu-thread: optimize QemuLockCnt
 with futexes on Linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com



On 12/01/2017 14:34, Fam Zheng wrote:
>> +     */
>> +    while ((*val & QEMU_LOCKCNT_STATE_MASK) != QEMU_LOCKCNT_STATE_FREE) {
>> +        if ((*val & QEMU_LOCKCNT_STATE_MASK) == QEMU_LOCKCNT_STATE_LOCKED) {
>> +            int expected = *val;
>> +            int new = expected - QEMU_LOCKCNT_STATE_LOCKED + QEMU_LOCKCNT_STATE_WAITING;
>> +
>> +            trace_lockcnt_futex_wait_prepare(lockcnt, expected, new);
> ... the holder thread releases the lock at this point. In this case a second
> call to this function in qemu_lockcnt_dec_and_lock does pass
> QEMU_LOCKCNT_STATE_LOCKED in new_if_free, because 'waited' is left false there.
> The code is okay, but the comment above is too strict.

Right.

>> +bool qemu_lockcnt_dec_and_lock(QemuLockCnt *lockcnt)
>> +{
>> +    int val = atomic_read(&lockcnt->count);
>> +    int locked_state = QEMU_LOCKCNT_STATE_LOCKED;
>> +    bool waited = false;
>> +
>> +    for (;;) {
>> +        if (val >= 2 * QEMU_LOCKCNT_COUNT_STEP) {
>> +            int expected = val;
>> +            int new = val - QEMU_LOCKCNT_COUNT_STEP;
>> +            val = atomic_cmpxchg(&lockcnt->count, val, new);
>> +            if (val == expected) {
>> +                break;
>> +            }
> If (val != expected && val >= 2 * QEMU_LOCKCNT_COUNT_STEP), should this
> atomic_cmpxchg be retried before trying qemu_lockcnt_cmpxchg_or_wait?
> 

Yeah, the below can be moved entirely in an "else".

Paolo
