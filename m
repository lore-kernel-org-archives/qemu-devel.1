Received: from eggs.gnu.org ([2001:4830:134:3::10]:34740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjqGE-000417-VI
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:40:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjqGD-0005n6-Gj
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:40:54 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:38207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjqGD-0005mx-2H
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:40:53 -0500
Received: by mail-wm0-x234.google.com with SMTP id t193so19686594wmt.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 08:40:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9sbqvqbe2T+W7HtTkdsnCWTHDf6EqtJ_2GGUjtKz64ug@mail.gmail.com>
References: <1488320775-9849-1-git-send-email-armbru@redhat.com>
	<CAFEAcA8WXnBXQ-qNmzRw6yD_tuYLQepmSC0be50s8h=-1r-VQw@mail.gmail.com>
	<CAFEAcA8oG+uODONjXpeAWpNxcmWfoxEbK31LksrLUQp5kbupgA@mail.gmail.com>
	<CAFEAcA9sbqvqbe2T+W7HtTkdsnCWTHDf6EqtJ_2GGUjtKz64ug@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 16:40:31 +0000
Message-ID: <CAFEAcA-2MdeE3CQYVmDOtV+Rc_+1dLFNXFEwGOSKFXdn1mzYJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/24] block: Command line option -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 3 March 2017 at 16:36, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 3 March 2017 at 16:31, Peter Maydell <peter.maydell@linaro.org> wrote:
>> x86-64 Linux host:
>>
>> QTEST_QEMU_BINARY=cris-softmmu/qemu-system-cris
>> QTEST_QEMU_IMG=qemu-img MALLOC_PERTURB_=${MALLOC_PERTURB_:-$((RANDOM %
>> 255 + 1))} gtester -k --verbose -m=quick  tests/qmp-test
>> tests/device-introspect-test tests/qom-test
>> TEST: tests/qmp-test... (pid=31974)
>>   /cris/qmp/protocol:
>> Broken pipe
>> FAIL
>
> Failure is intermittent.

gdb'ing the qemu shows a SEGV accessing a NULL qdict:

Thread 1 "qemu-system-cri" received signal SIGSEGV, Segmentation fault.
0x00005555557e98b9 in qdict_find (bucket=<optimised out>,
    key=0x55555587fd17 "error", qdict=0x0)
    at /home/petmay01/linaro/qemu-for-merges/qobject/qdict.c:110
110         QLIST_FOREACH(entry, &qdict->table[bucket], next)
(gdb) bt
#0  0x00005555557e98b9 in qdict_get (bucket=<optimised out>,
key=0x55555587fd17 "error", qdict=0x0)
    at /home/petmay01/linaro/qemu-for-merges/qobject/qdict.c:110
#1  0x00005555557e98b9 in qdict_get (qdict=0x0,
key=key@entry=0x55555587fd17 "error")
    at /home/petmay01/linaro/qemu-for-merges/qobject/qdict.c:157
#2  0x00005555557e9a69 in qdict_get_qdict (qdict=<optimised out>,
key=key@entry=0x55555587fd17 "error")
    at /home/petmay01/linaro/qemu-for-merges/qobject/qdict.c:242
#3  0x000055555561c1f8 in handle_qmp_command (parser=<optimised out>,
tokens=<optimised out>)
    at /home/petmay01/linaro/qemu-for-merges/monitor.c:3727
#4  0x00005555557ebca7 in json_message_process_token
(lexer=0x55555607d148, input=0x55555606b480, type=JSON_RCURLY, x=31,
y=6)
    at /home/petmay01/linaro/qemu-for-merges/qobject/json-streamer.c:105
#5  0x00005555558086fd in json_lexer_feed_char
(lexer=lexer@entry=0x55555607d148, ch=125 '}',
flush=flush@entry=false)
    at /home/petmay01/linaro/qemu-for-merges/qobject/json-lexer.c:319
#6  0x000055555580880e in json_lexer_feed (lexer=0x55555607d148,
buffer=<optimised out>, size=<optimised out>)
    at /home/petmay01/linaro/qemu-for-merges/qobject/json-lexer.c:369
#7  0x00005555557ebd69 in json_message_parser_feed (parser=<optimised
out>, buffer=<optimised out>, size=<optimised out>)
    at /home/petmay01/linaro/qemu-for-merges/qobject/json-streamer.c:124
#8  0x000055555561ad8b in monitor_qmp_read (opaque=<optimised out>,
buf=<optimised out>, size=<optimised out>)
    at /home/petmay01/linaro/qemu-for-merges/monitor.c:3768
#9  0x00005555557a190d in tcp_chr_read (chan=<optimised out>,
cond=<optimised out>, opaque=<optimised out>)
    at /home/petmay01/linaro/qemu-for-merges/chardev/char-socket.c:411
#10 0x00007fffe144404a in g_main_context_dispatch
(context=0x55555606ba80) at
/build/glib2.0-prJhLS/glib2.0-2.48.2/./glib/gmain.c:3154
#11 0x00007fffe144404a in g_main_context_dispatch
(context=context@entry=0x55555606ba80)
    at /build/glib2.0-prJhLS/glib2.0-2.48.2/./glib/gmain.c:3769
#12 0x00005555557f167b in main_loop_wait () at
/home/petmay01/linaro/qemu-for-merges/util/main-loop.c:215
#13 0x00005555557f167b in main_loop_wait (timeout=<optimised out>) at
/home/petmay01/linaro/qemu-for-merges/util/main-loop.c:260
#14 0x00005555557f167b in main_loop_wait (nonblocking=<optimised out>)
at /home/petmay01/linaro/qemu-for-merges/util/main-loop.c:508
#15 0x00005555555d87c5 in main () at
/home/petmay01/linaro/qemu-for-merges/vl.c:1900
#16 0x00005555555d87c5 in main (argc=<optimised out>, argv=<optimised
out>, envp=<optimised out>)
    at /home/petmay01/linaro/qemu-for-merges/vl.c:4714

(In frame 3 handle_qmp_command() the rsp returned from qmp_dispatch()
is NULL.)

thanks
-- PMM
