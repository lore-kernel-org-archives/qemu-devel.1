Received: from eggs.gnu.org ([2001:4830:134:3::10]:36562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fkNK7-0001HC-8T
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 01:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fkNK2-0006qJ-84
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 01:35:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37674 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fkNK2-0006pz-3y
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 01:35:50 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180723193530.20891-1-eblake@redhat.com>
	<87in553zsx.fsf@dusky.pond.sub.org>
	<8c082bfd-6753-c8d2-cfcd-e2be77c3f763@redhat.com>
	<878t5zxpc2.fsf@dusky.pond.sub.org>
	<a5c7582a-419a-03fb-4f05-c59fed4f0732@redhat.com>
Date: Tue, 31 Jul 2018 07:35:46 +0200
In-Reply-To: <a5c7582a-419a-03fb-4f05-c59fed4f0732@redhat.com> (Eric Blake's
	message of "Mon, 30 Jul 2018 16:24:55 -0500")
Message-ID: <87va8wt1al.fsf@dusky.pond.sub.org>
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
Cc: peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org, f4bug@amsat.org, alex.bennee@linaro.org, rth@twiddle.net

Eric Blake <eblake@redhat.com> writes:

> On 07/25/2018 11:17 AM, Markus Armbruster wrote:
>
>>>
>>> the output was produced by bash, which uses waitpid() - and therefore
>>> the fact that bash reports the core dump even when no core file is
>>> created is promising.
>>
>> Proof beats plausibility argument:
>>
>> $ cat wcordump.c
>
>> $ gcc -Wall -g -O wcordump.c
>> $ (ulimit -c unlimited; ./a.out)
>> sig 6 128
>> $ (ulimit -c 0; ./a.out)
>> sig 6 0
>
> Doesn't match my results:
>
> $ (ulimit -c 0; ./a.out)
> sig 6 128
>
> So, what's different between our two environments?
>
> kernel 4.17.7-100.fc27.x86_64

4.17.7-200.fc28.x86_64

> $ echo /proc/sys/kernel/core_*
> /proc/sys/kernel/core_pattern /proc/sys/kernel/core_pipe_limit
> /proc/sys/kernel/core_uses_pid
> $ cat /proc/sys/kernel/core_*
> |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %e

This is "core" on my development boxes (I'm a happy caveman).

# cat /etc/sysctl.d/50-coredump.conf 
kernel.core_pattern=core

> 0
> 1
>
>>
>> Looks like WCOREDUMP() does depend on my ulimit -c.
>
> Or worse, that its behavior is kernel/environment-sensitive.

Looks like it.
