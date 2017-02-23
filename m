Received: from eggs.gnu.org ([2001:4830:134:3::10]:38189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgzNs-0007S4-EV
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:49:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgzNo-0007X2-EK
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:49:00 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:32976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cgzNo-0007WT-7r
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:48:56 -0500
Received: by mail-wm0-x234.google.com with SMTP id t18so5171285wmt.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 11:48:55 -0800 (PST)
References: <CAJSP0QVjokCyvVtDcyWBhDqsWKwdNX6zyAo1uL9VmyzMfakS9A@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAJSP0QVjokCyvVtDcyWBhDqsWKwdNX6zyAo1uL9VmyzMfakS9A@mail.gmail.com>
Date: Thu, 23 Feb 2017 19:48:52 +0000
Message-ID: <87y3wwy9gb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Hang in aio/multi/mutex/mcs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>


Stefan Hajnoczi <stefanha@gmail.com> writes:

> Hi Paolo,
> Alex Benne reported that Travis CI is hanging in aio/multi/mutex/mcs:
>
> https://travis-ci.org/qemu/qemu/builds/203811867
>
> 0x00007fe9d680052d in nanosleep () from
> target:/lib/x86_64-linux-gnu/libpthread.so.0
> (gdb) info threads
>   Id   Target Id         Frame
> * 1    LWP 15116 "test-aio-multit" 0x00007fe9d680052d in nanosleep ()
> from target:/lib/x86_64-linux-gnu/libpthread.so.0
> (gdb) bt
> #0  0x00007fe9d680052d in nanosleep () from
> target:/lib/x86_64-linux-gnu/libpthread.so.0
> #1  0x00007fe9d74c6072 in g_usleep () from
> target:/lib/x86_64-linux-gnu/libglib-2.0.so.0
> #2  0x000055b90b2e9dca in test_multi_fair_mutex (seconds=1, threads=5)
> at /tmp/qemu-test/src/tests/test-aio-multithread.c:363
> #3  0x00007fe9d74c365b in ?? () from
> target:/lib/x86_64-linux-gnu/libglib-2.0.so.0
> #4  0x00007fe9d74c37d6 in ?? () from
> target:/lib/x86_64-linux-gnu/libglib-2.0.so.0
> #5  0x00007fe9d74c37d6 in ?? () from
> target:/lib/x86_64-linux-gnu/libglib-2.0.so.0
> #6  0x00007fe9d74c37d6 in ?? () from
> target:/lib/x86_64-linux-gnu/libglib-2.0.so.0
> #7  0x00007fe9d74c3b2b in g_test_run_suite () from
> target:/lib/x86_64-linux-gnu/libglib-2.0.so.0
> #8  0x000055b90b2e758c in main (argc=1, argv=0x7ffd65cb4928) at
> /tmp/qemu-test/src/tests/test-aio-multithread.c:462

To reproduce:

  make docker-test-quick@travis J=4 DEBUG=1
  /tmp/qemu-test/src/tests/docker/test-quick

This usually hangs for me. In another winder you can run:

  docker exec -it $CONTAINER_NAME bash

To get access to the filesystem and see the hung tasks.

If it doesn't trigger during this stage you may need to:

  cd /var/tmp/qemu-build
  ./tests/test-aio-multithread

Hope that helps the debugging ;-)

--
Alex Bennée
