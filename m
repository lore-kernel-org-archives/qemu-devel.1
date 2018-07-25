Received: from eggs.gnu.org ([2001:4830:134:3::10]:39907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fiMTR-0005Xa-0v
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 12:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fiMTO-0007nF-0F
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 12:17:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45146 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fiMTN-0007nB-RF
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 12:17:09 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180723193530.20891-1-eblake@redhat.com>
	<87in553zsx.fsf@dusky.pond.sub.org>
	<8c082bfd-6753-c8d2-cfcd-e2be77c3f763@redhat.com>
Date: Wed, 25 Jul 2018 18:17:01 +0200
In-Reply-To: <8c082bfd-6753-c8d2-cfcd-e2be77c3f763@redhat.com> (Eric Blake's
	message of "Tue, 24 Jul 2018 09:35:58 -0500")
Message-ID: <878t5zxpc2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eric Blake <eblake@redhat.com>
Cc: peter.maydell@linaro.org, mst@redhat.com, f4bug@amsat.org, qemu-devel@nongnu.org, alex.bennee@linaro.org, rth@twiddle.net

Eric Blake <eblake@redhat.com> writes:

> On 07/24/2018 01:36 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> In kill_qemu() we have an assert that checks that the QEMU process
>>> didn't dump core:
>>>              assert(!WCOREDUMP(wstatus));
>>>
>>> Unfortunately the WCOREDUMP macro here means the resulting message
>>> is not very easy to comprehend on at least some systems:
>>>
>
>>> -        if (pid == s->qemu_pid && WIFSIGNALED(wstatus)) {
>>> -            assert(!WCOREDUMP(wstatus));
>
>>> +            } else if (WIFSIGNALED(wstatus)) {
>>> +                int sig = WTERMSIG(wstatus);
>>> +                const char *signame = strsignal(sig) ?: "unknown ???";
>>> +
>>> +                if (!WCOREDUMP(wstatus)) {
>>> +                    die = false;
>>
>> Does WCOREDUMP(wstatus) depend on the user's ulimit -c?
>
> 'man waitpid' on Linux mentions that WCOREDUMP is nonportable, but
> does not mention any interaction with setrlimit.  But a quick test
> shows:
>
> $ ulimit -S -c 0
> $ cat foo.c
> int main(int argc, char **argv) {
>   return *argv[1];
> }
> $ gcc -o foo -Wall foo.c
> $ ./foo 1
> $ ./foo
> Segmentation fault (core dumped)
> $
>
> the output was produced by bash, which uses waitpid() - and therefore
> the fact that bash reports the core dump even when no core file is
> created is promising.

Proof beats plausibility argument:

$ cat wcordump.c
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int
main(void)
{
    pid_t child = fork();
    int wstatus;

    if (child < 0) {
	perror("fork");
	exit(1);
    }
    if (!child) {
	abort();
    }
    if (waitpid(child, &wstatus, 0) < 0) {
	perror("waitpid");
	exit(1);
    }
    if (WIFSIGNALED(wstatus)) {
	printf("sig %d %d\n",
	       WTERMSIG(wstatus), WCOREDUMP(wstatus));
    } else {
	printf("no sig\n");
    }
    exit(0);
}
$ gcc -Wall -g -O wcordump.c
$ (ulimit -c unlimited; ./a.out)
sig 6 128
$ (ulimit -c 0; ./a.out)
sig 6 0

Looks like WCOREDUMP() does depend on my ulimit -c.
