Received: from eggs.gnu.org ([2001:4830:134:3::10]:43498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfAq8-00047M-H8
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfAq3-0001Co-Hd
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:10:56 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:38060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfAq3-0001CY-Dq
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:10:51 -0400
Received: by mail-qt0-x243.google.com with SMTP id p3so4055270qtg.5
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 13:10:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <150221331695.15915.4904484630739512874.stgit@bahia.lan>
	<9e56de2e-2c20-6e28-efd0-1f78b21a7be5@amsat.org>
	<9f3c0af6-1ff8-adca-9f69-2be8dd7d250f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <db1e220e-f3bf-352d-57ac-6ad3b427e944@amsat.org>
Date: Tue, 8 Aug 2017 17:10:46 -0300
MIME-Version: 1.0
In-Reply-To: <9f3c0af6-1ff8-adca-9f69-2be8dd7d250f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [for-2.10 PATCH] 9pfs: local: fix
 fchmodat_nofollow() limitations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>, zhiyong.wu@ucloud.cn, qemu-devel@nongnu.org

On 08/08/2017 04:34 PM, Eric Blake wrote:
> On 08/08/2017 01:48 PM, Philippe Mathieu-Daudé wrote:
> 
>>> +    fd = openat_file(dirfd, name, O_RDONLY | O_PATH, 0);
>>
>> since you use O_PATH, you can drop O_RDONLY.
> 
> Technically, POSIX says (and 'man 2 open' agrees, modulo the fact that
> Linux still lacks O_SEARCH) that you MUST provide one of the 5 access
> modes (they are O_RDONLY, O_RDWR, O_WRONLY, O_EXEC, and O_SEARCH;
> although POSIX allows O_EXEC and O_SEARCH to be the same bit pattern),
> and then bitwise-or any additional flags.  So the usage here is correct.
> 
> Practically, though, this code is ONLY compilable on Linux (no one else
> has O_PATH yet, although it is a useful Linux invention), and on Linux,
> O_RDONLY is 0.  So behaviorally, you are correct that open(O_PATH)
> rather than open(O_RDONLY | O_PATH) does the same thing, even if it sets
> a bad example. [Well, insofar as you don't have any other bugs by
> omitting O_NOFOLLOW, per my other thread...]

Oh ok. I didn't think of that, just checked Linux manpage:

    O_PATH (since Linux 2.6.39)

           When O_PATH is specified in flags, flag bits other than
           O_CLOEXEC, O_DIRECTORY, and O_NOFOLLOW are ignored.

> 
>>> +++ b/hw/9pfs/9p-util.h
>>> @@ -43,9 +43,13 @@ static inline int openat_file(int dirfd, const char
>>> *name, int flags,
>>>        }
>>>          serrno = errno;
>>> -    /* O_NONBLOCK was only needed to open the file. Let's drop it. */
>>> -    ret = fcntl(fd, F_SETFL, flags);
>>> -    assert(!ret);
>>> +    /* O_NONBLOCK was only needed to open the file. Let's drop it. We
>>> don't
>>> +     * do that with O_PATH since it ignores O_NONBLOCK.
>>> +     */
>>
>> thinking about if someone uses openat_file(d, O_PATH|O_CLOEXEC, ...),
>> why not set the fd flags always? like:
>>
>>         ret = fcntl(fd, F_SETFL, flags);
>>         assert((flags & O_PATH) || !ret);
> 
> Syscalls are expensive.  It's better to avoid fcntl() up front than it
> is to skip failure after the fact.

Ok, good to know!

Thank to clarify those points,

Phil.
