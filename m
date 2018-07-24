Received: from eggs.gnu.org ([2001:4830:134:3::10]:53702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhyPy-0004RD-U7
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhyPx-0005Cq-S7
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:36:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56416 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fhyPx-0005CY-Lc
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:36:01 -0400
References: <20180723193530.20891-1-eblake@redhat.com>
	<87in553zsx.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8c082bfd-6753-c8d2-cfcd-e2be77c3f763@redhat.com>
Date: Tue, 24 Jul 2018 09:35:58 -0500
MIME-Version: 1.0
In-Reply-To: <87in553zsx.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-3.0] tests/libqtest: Improve
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, rth@twiddle.net, alex.bennee@linaro.org, f4bug@amsat.org, mst@redhat.com

On 07/24/2018 01:36 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> In kill_qemu() we have an assert that checks that the QEMU process
>> didn't dump core:
>>              assert(!WCOREDUMP(wstatus));
>>
>> Unfortunately the WCOREDUMP macro here means the resulting message
>> is not very easy to comprehend on at least some systems:
>>

>> -        if (pid == s->qemu_pid && WIFSIGNALED(wstatus)) {
>> -            assert(!WCOREDUMP(wstatus));

>> +            } else if (WIFSIGNALED(wstatus)) {
>> +                int sig = WTERMSIG(wstatus);
>> +                const char *signame = strsignal(sig) ?: "unknown ???";
>> +
>> +                if (!WCOREDUMP(wstatus)) {
>> +                    die = false;
> 
> Does WCOREDUMP(wstatus) depend on the user's ulimit -c?

'man waitpid' on Linux mentions that WCOREDUMP is nonportable, but does 
not mention any interaction with setrlimit.  But a quick test shows:

$ ulimit -S -c 0
$ cat foo.c
int main(int argc, char **argv) {
   return *argv[1];
}
$ gcc -o foo -Wall foo.c
$ ./foo 1
$ ./foo
Segmentation fault (core dumped)
$

the output was produced by bash, which uses waitpid() - and therefore 
the fact that bash reports the core dump even when no core file is 
created is promising.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
