Received: from eggs.gnu.org ([2001:4830:134:3::10]:60335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fldbZ-00076T-Ty
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fldbV-0000oB-Qc
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:11:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46990 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fldbV-0000nT-LB
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:11:05 -0400
References: <20180730220831.390182-1-eblake@redhat.com>
	<874lgbih3r.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0786b49a-6adf-0986-8970-135d27bc344a@redhat.com>
Date: Fri, 3 Aug 2018 12:11:03 -0500
MIME-Version: 1.0
In-Reply-To: <874lgbih3r.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-3.0] tests/libqtest: Improve
 kill_qemu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com, mst@redhat.com, f4bug@amsat.org, alex.bennee@linaro.org, rth@twiddle.net

On 08/03/2018 10:51 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> In kill_qemu() we have an assert that checks that the QEMU process
>> didn't dump core:
>>              assert(!WCOREDUMP(wstatus));
>>
>> Unfortunately the WCOREDUMP macro here means the resulting message
>> is not very easy to comprehend on at least some systems:
>>
>> ahci-test: tests/libqtest.c:113: kill_qemu: Assertion `!(((__extension__ (((union { __typeof(wstatus) __in; int __i; }) { .__in = (wstatus) }).__i))) & 0x80)' failed.
>>
>> and it doesn't identify what signal the process took.
>>
>> -        if (pid == s->qemu_pid && WIFSIGNALED(wstatus)) {
>> -            assert(!WCOREDUMP(wstatus));
>> +        assert(pid == s->qemu_pid);
>> +        /*
>> +         * We expect qemu to exit with status 0; anything else is
>> +         * fishy and should be logged.  Abort except when death by
>> +         * signal is not accompanied by a coredump (as that's the only
>> +         * time it was likely that the user is trying to kill the
>> +         * testsuite early).
>> +         */
>> +        if (wstatus) {
>> +            die = true;
>> +            if (WIFEXITED(wstatus)) {
>> +                fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU "
>> +                        "process but encountered exit status %d\n",
>> +                        __FILE__, __LINE__, WEXITSTATUS(wstatus));
>> +            } else if (WIFSIGNALED(wstatus)) {
>> +                int sig = WTERMSIG(wstatus);

> 
> In review of v2, we found that WCOREDUMP() depends on the user's
> environment.  I doubt we should use it this way.
> 
> Why is suppressing the abort() when "the user is trying to kill the
> testsuite early" important?
> 

Only because the old code was special-casing based on whether WCOREDUMP. 
I'm not particularly attached to it, and am just fine submitting a v4 
that just quits on ALL death-by-signal, rather than caring whether a 
core dump was present.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
