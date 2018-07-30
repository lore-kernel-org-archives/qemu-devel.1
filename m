Received: from eggs.gnu.org ([2001:4830:134:3::10]:42861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkFf6-00056Z-FV
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 17:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkFf1-0007sp-QU
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 17:25:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40102 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fkFf1-0007qj-KV
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 17:24:59 -0400
References: <20180723193530.20891-1-eblake@redhat.com>
	<87in553zsx.fsf@dusky.pond.sub.org>
	<8c082bfd-6753-c8d2-cfcd-e2be77c3f763@redhat.com>
	<878t5zxpc2.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a5c7582a-419a-03fb-4f05-c59fed4f0732@redhat.com>
Date: Mon, 30 Jul 2018 16:24:55 -0500
MIME-Version: 1.0
In-Reply-To: <878t5zxpc2.fsf@dusky.pond.sub.org>
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
Cc: peter.maydell@linaro.org, mst@redhat.com, f4bug@amsat.org, qemu-devel@nongnu.org, alex.bennee@linaro.org, rth@twiddle.net

On 07/25/2018 11:17 AM, Markus Armbruster wrote:

>>
>> the output was produced by bash, which uses waitpid() - and therefore
>> the fact that bash reports the core dump even when no core file is
>> created is promising.
> 
> Proof beats plausibility argument:
> 
> $ cat wcordump.c

> $ gcc -Wall -g -O wcordump.c
> $ (ulimit -c unlimited; ./a.out)
> sig 6 128
> $ (ulimit -c 0; ./a.out)
> sig 6 0

Doesn't match my results:

$ (ulimit -c 0; ./a.out)
sig 6 128

So, what's different between our two environments?

kernel 4.17.7-100.fc27.x86_64

$ echo /proc/sys/kernel/core_*
/proc/sys/kernel/core_pattern /proc/sys/kernel/core_pipe_limit 
/proc/sys/kernel/core_uses_pid
$ cat /proc/sys/kernel/core_*
|/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %e
0
1

> 
> Looks like WCOREDUMP() does depend on my ulimit -c.

Or worse, that its behavior is kernel/environment-sensitive.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
