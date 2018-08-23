Received: from eggs.gnu.org ([2001:4830:134:3::10]:45912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fspmF-00053Y-RA
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fspmA-0000EI-5w
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:35:55 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:34669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fspm9-0000Bf-Mg
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:35:49 -0400
Received: by mail-oi0-x235.google.com with SMTP id 13-v6so9311024ois.1
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 06:35:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9GTsKcteYCLC2jk0icxGYGX9R=Hbrph7CK3bugc3+kVQ@mail.gmail.com>
References: <20180823113659.21737-1-pbonzini@redhat.com>
	<CAFEAcA9GTsKcteYCLC2jk0icxGYGX9R=Hbrph7CK3bugc3+kVQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 14:35:28 +0100
Message-ID: <CAFEAcA-UAt414iE1TGcaHb1x2Pwg=19HwG=n7gVDDHo31=0Bag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/73] Misc patches for 2018-08-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 August 2018 at 14:30, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 23 August 2018 at 12:36, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> The following changes since commit 659b11e7a7239529cfdb4968418268ff9aa22d88:
>>
>>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.1-pull-request' into staging (2018-08-21 11:36:15 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to 07c8c1c9311b81cbf3bcc49d4fed18e1d889a8f2:
>>
>>   test-char: add socket reconnect test (2018-08-23 13:32:50 +0200)
>>
>> I removed the offending patch.
>
> Test failure on FreeBSD:
>
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> gtester -k --verbose -m=quick tests/test-char
> TEST: tests/test-char... (pid=16190)
>   /char/null:                                                          OK
>   /char/invalid:                                                       OK
>   /char/ringbuf:                                                       OK
>   /char/mux:                                                           OK
>   /char/stdio:                                                         OK
>   /char/pipe:                                                          OK
>   /char/file:                                                          OK
>   /char/file-fifo:                                                     OK
>   /char/udp:                                                           OK
>   /char/serial:                                                        OK
>   /char/hotswap:                                                       OK
>   /char/socket/basic:                                                  OK
>   /char/socket/reconnect:                                              FAIL
> GTester: last random seed: R02S521380d9c12f1dac3ad1763bf5665c27
> (pid=16367)
>   /char/socket/fdpass:                                                 OK
> FAIL: tests/test-char
> **
> ERROR:tests/test-char.c:353:char_socket_test_common: assertion failed:
> (object_property_get_bool(OBJECT(chr_client), "connected",
> &error_abort))

Fairly reproducible (I think it passed about once in 10 tries.)
Backtrace, which looks bogus, probably due to compiler optimisation:

(gdb) bt
#0  0x0000000801ff884a in thr_kill () from /lib/libc.so.7
#1  0x0000000801ff8814 in raise () from /lib/libc.so.7
#2  0x0000000801ff8789 in abort () from /lib/libc.so.7
#3  0x0000000800d4e36c in g_assertion_message () from
/usr/local/lib/libglib-2.0.so.0
#4  0x0000000800d4e3ce in g_assertion_message_expr () from
/usr/local/lib/libglib-2.0.so.0
#5  0x0000000000409a40 in char_socket_test_common (chr=0x802ea5100,
    reconnect=<value optimized out>) at test-char.c:352
#6  0x0000000800d4deee in g_test_queue_destroy () from
/usr/local/lib/libglib-2.0.so.0
#7  0x0000000800d4e14b in g_test_queue_destroy () from
/usr/local/lib/libglib-2.0.so.0
#8  0x0000000800d4e14b in g_test_queue_destroy () from
/usr/local/lib/libglib-2.0.so.0
#9  0x0000000800d4d2a3 in g_test_run_suite () from
/usr/local/lib/libglib-2.0.so.0
#10 0x0000000800d4d1d8 in g_test_run () from /usr/local/lib/libglib-2.0.so.0
#11 0x00000000004074a4 in main (argc=1, argv=0x7fffffffebc8) at test-char.c:839

thanks
-- PMM
