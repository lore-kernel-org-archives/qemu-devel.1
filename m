Received: from eggs.gnu.org ([2001:4830:134:3::10]:50937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ddHEF-0005pH-Os
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ddHEC-0005hW-L6
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:35:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:37633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ddHEC-0005fx-6S
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:35:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ddHEA-0008Dc-3m
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 14:35:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 625EA2E80D7
	for <qemu-devel@nongnu.org>; Thu,  3 Aug 2017 14:35:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Aug 2017 14:30:06 -0000
From: Andrey Smetanin <1708442@bugs.launchpad.net>
Reply-To: Bug 1708442 <1708442@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150176232235.21421.11970305069558342885.malonedeb@wampee.canonical.com>
	<10dfbd79-e5bd-e88c-27d8-246f89315387@redhat.com>
Message-Id: <23481501770606@webcorp01f.yandex-team.ru>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1708442] [NEW] Crash(assert) during reading
 image from http url through qemu-nbd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

03.08.2017, 17:01, "Eric Blake" <1708442@bugs.launchpad.net>:
> On 08/03/2017 07:12 AM, Andrey Smetanin wrote:
>> =C2=A0Public bug reported:
>>
>> =C2=A0Description:
>> =C2=A0During reading image from nbd device mounted by qemu-nbd server wi=
th url backend I/O error happens
>> =C2=A0"blk_update_request: I/O error, dev nbd0, sector 42117" dmesg. Aft=
er some investigation I found that qemu-nbd server aborts in aio_co_enter()=
 assert in util/async.c:468.
>
> Based on the backtrace, this looks to be a bug in the block/curl.c
> driver, rather than the nbd/ or block/nbd.c code. If I'm right, it
> should be possible to reproduce the crash using qemu-io directly on the
> curl path, rather than adding the extra layer of an nbd client reading
> through qemu-nbd (then again, having the qemu-nbd layer may be what is
> allowing multiple parallel requests to hit the curl driver at once,
> while qemu-io is not quite as easy to provoke into performing
> complicated access patterns).
>
>> =C2=A0Steps to reproduce:
>>
>> =C2=A01) sudo go run qemu-nbd-bug-report/qemu-nbd-bug.go (see qemu-nbd-b=
ug-
>> =C2=A0report.tar.gz)
>>
>> =C2=A0or try directly
>>
>> =C2=A01) qemu-nbd -c /dev/nbd0 -r -v --aio=3Dnative -f qcow2 json:{"file=
.driver":"http","file.url":"http://localhost:9666/image","file.readahead":3=
276800
>
> Presumably, you've got something serving the file at port 9666?
Yes, you are right. I'm using qemu-nbd-bug.go(see qemu-nbd-bug-report.tar.g=
z) script which does it.
>
>> =C2=A02) try read whole nbd device while error in dmesg appears x
>>
>> =C2=A0Versions:
>>
>> =C2=A01) qemu built from sources(/configure --target-list=3Dx86_64-softm=
mu --disable-user --enable-curl --enable-linux-aio --enable-virtfs --enable=
-debug --disable-pie
>> =C2=A0, top commit 5619c179057e24195ff19c8fe6d6a6cbcb16ed28):
>>
>> =C2=A0qemu-nbd -v
>> =C2=A0qemu-nbd 2.9.90 (v2.10.0-rc0-67-g5619c17)
>>
>> =C2=A02) libcurl(built from sources, top commit
>> =C2=A01767adf4399bb3be29121435e1bb1cc2bc05f7bf):
>>
>> =C2=A0curl -V
>> =C2=A0curl 7.55.0-DEV (Linux) libcurl/7.55.0-DEV OpenSSL/1.0.2g zlib/1.2=
.8
>>
>> =C2=A0Backtrace:
>> =C2=A0(gdb) bt
>> =C2=A0#0 0x00007f7131426428 in __GI_raise (sig=3Dsig@entry=3D6) at ../sy=
sdeps/unix/sysv/linux/raise.c:54
>> =C2=A0#1 0x00007f713142802a in __GI_abort () at abort.c:89
>> =C2=A0#2 0x00007f713141ebd7 in __assert_fail_base (fmt=3D<optimized out>=
, assertion=3Dassertion@entry=3D0x54c924 "self !=3D co",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0file=3Dfile@entry=3D0x54c871 "util/async.c=
", line=3Dline@entry=3D468,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0function=3Dfunction@entry=3D0x54c980 <__PR=
ETTY_FUNCTION__.24766> "aio_co_enter") at assert.c:92
>> =C2=A0#3 0x00007f713141ec82 in __GI___assert_fail (assertion=3D0x54c924 =
"self !=3D co", file=3D0x54c871 "util/async.c", line=3D468,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0function=3D0x54c980 <__PRETTY_FUNCTION__.2=
4766> "aio_co_enter") at assert.c:101
>> =C2=A0#4 0x00000000004fe6a2 in aio_co_enter (ctx=3D0xf0ddb0, co=3D0xf146=
50) at util/async.c:468
>> =C2=A0#5 0x00000000004fe637 in aio_co_wake (co=3D0xf14650) at util/async=
.c:456
>> =C2=A0#6 0x0000000000495c8a in curl_read_cb (ptr=3D0xf566d9, size=3D1, n=
memb=3D16135, opaque=3D0xf1cb90) at block/curl.c:275
>> =C2=A0#7 0x00007f713242ac24 in Curl_client_chop_write () from /usr/lib/x=
86_64-linux-gnu/libcurl.so
>> =C2=A0#8 0x00007f713242ae03 in Curl_client_write () from /usr/lib/x86_64=
-linux-gnu/libcurl.so
>> =C2=A0#9 0x00007f713244e1cf in readwrite_data () from /usr/lib/x86_64-li=
nux-gnu/libcurl.so
>> =C2=A0#10 0x00007f713244eb6f in Curl_readwrite () from /usr/lib/x86_64-l=
inux-gnu/libcurl.so
>> =C2=A0#11 0x00007f713245c1bb in multi_runsingle () from /usr/lib/x86_64-=
linux-gnu/libcurl.so
>> =C2=A0#12 0x00007f713245d819 in multi_socket () from /usr/lib/x86_64-lin=
ux-gnu/libcurl.so
>> =C2=A0#13 0x00007f713245e067 in curl_multi_socket_action () from /usr/li=
b/x86_64-linux-gnu/libcurl.so
>> =C2=A0#14 0x0000000000497555 in curl_setup_preadv (bs=3D0xf16820, acb=3D=
0x7f712d379860) at block/curl.c:918
>> =C2=A0#15 0x00000000004975fb in curl_co_preadv (bs=3D0xf16820, offset=3D=
6556160, bytes=3D512, qiov=3D0x7f712d379b40, flags=3D0) at block/curl.c:935
>
> The backtrace is definitely pointing at curl as being the problem.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc. +1-919-301-3266
> Virtualization: qemu.org | libvirt.org
>
> --
> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1708442
>
> Title:
> =C2=A0=C2=A0Crash(assert) during reading image from http url through qemu=
-nbd
>
> Status in QEMU:
> =C2=A0=C2=A0New
>
> Bug description:
> =C2=A0=C2=A0Description:
> =C2=A0=C2=A0During reading image from nbd device mounted by qemu-nbd serv=
er with url backend I/O error happens
> =C2=A0=C2=A0"blk_update_request: I/O error, dev nbd0, sector 42117" dmesg=
. After some investigation I found that qemu-nbd server aborts in aio_co_en=
ter() assert in util/async.c:468.
>
> =C2=A0=C2=A0Steps to reproduce:
>
> =C2=A0=C2=A01) sudo go run qemu-nbd-bug-report/qemu-nbd-bug.go (see qemu-=
nbd-bug-
> =C2=A0=C2=A0report.tar.gz)
>
> =C2=A0=C2=A0or try directly
>
> =C2=A0=C2=A01) qemu-nbd -c /dev/nbd0 -r -v --aio=3Dnative -f qcow2 json:{=
"file.driver":"http","file.url":"http://localhost:9666/image","file.readahe=
ad":3276800
> =C2=A0=C2=A02) try read whole nbd device while error "blk_update_request:=
 I/O error, dev nbd0, sector 42117" appears in dmesg
>
> =C2=A0=C2=A0Versions:
>
> =C2=A0=C2=A01) qemu built from sources(/configure --target-list=3Dx86_64-=
softmmu --disable-user --enable-curl --enable-linux-aio --enable-virtfs --e=
nable-debug --disable-pie
> =C2=A0=C2=A0, top commit 5619c179057e24195ff19c8fe6d6a6cbcb16ed28):
>
> =C2=A0=C2=A0qemu-nbd -v
> =C2=A0=C2=A0qemu-nbd 2.9.90 (v2.10.0-rc0-67-g5619c17)
>
> =C2=A0=C2=A02) libcurl(built from sources, top commit
> =C2=A0=C2=A01767adf4399bb3be29121435e1bb1cc2bc05f7bf):
>
> =C2=A0=C2=A0curl -V
> =C2=A0=C2=A0curl 7.55.0-DEV (Linux) libcurl/7.55.0-DEV OpenSSL/1.0.2g zli=
b/1.2.8
>
> =C2=A0=C2=A0Backtrace:
> =C2=A0=C2=A0(gdb) bt
> =C2=A0=C2=A0#0 0x00007f7131426428 in __GI_raise (sig=3Dsig@entry=3D6) at =
../sysdeps/unix/sysv/linux/raise.c:54
> =C2=A0=C2=A0#1 0x00007f713142802a in __GI_abort () at abort.c:89
> =C2=A0=C2=A0#2 0x00007f713141ebd7 in __assert_fail_base (fmt=3D<optimized=
 out>, assertion=3Dassertion@entry=3D0x54c924 "self !=3D co",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0file=3Dfile@entry=3D0x54c871 "util/as=
ync.c", line=3Dline@entry=3D468,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0function=3Dfunction@entry=3D0x54c980 =
<__PRETTY_FUNCTION__.24766> "aio_co_enter") at assert.c:92
> =C2=A0=C2=A0#3 0x00007f713141ec82 in __GI___assert_fail (assertion=3D0x54=
c924 "self !=3D co", file=3D0x54c871 "util/async.c", line=3D468,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0function=3D0x54c980 <__PRETTY_FUNCTIO=
N__.24766> "aio_co_enter") at assert.c:101
> =C2=A0=C2=A0#4 0x00000000004fe6a2 in aio_co_enter (ctx=3D0xf0ddb0, co=3D0=
xf14650) at util/async.c:468
> =C2=A0=C2=A0#5 0x00000000004fe637 in aio_co_wake (co=3D0xf14650) at util/=
async.c:456
> =C2=A0=C2=A0#6 0x0000000000495c8a in curl_read_cb (ptr=3D0xf566d9, size=
=3D1, nmemb=3D16135, opaque=3D0xf1cb90) at block/curl.c:275
> =C2=A0=C2=A0#7 0x00007f713242ac24 in Curl_client_chop_write () from /usr/=
lib/x86_64-linux-gnu/libcurl.so
> =C2=A0=C2=A0#8 0x00007f713242ae03 in Curl_client_write () from /usr/lib/x=
86_64-linux-gnu/libcurl.so
> =C2=A0=C2=A0#9 0x00007f713244e1cf in readwrite_data () from /usr/lib/x86_=
64-linux-gnu/libcurl.so
> =C2=A0=C2=A0#10 0x00007f713244eb6f in Curl_readwrite () from /usr/lib/x86=
_64-linux-gnu/libcurl.so
> =C2=A0=C2=A0#11 0x00007f713245c1bb in multi_runsingle () from /usr/lib/x8=
6_64-linux-gnu/libcurl.so
> =C2=A0=C2=A0#12 0x00007f713245d819 in multi_socket () from /usr/lib/x86_6=
4-linux-gnu/libcurl.so
> =C2=A0=C2=A0#13 0x00007f713245e067 in curl_multi_socket_action () from /u=
sr/lib/x86_64-linux-gnu/libcurl.so
> =C2=A0=C2=A0#14 0x0000000000497555 in curl_setup_preadv (bs=3D0xf16820, a=
cb=3D0x7f712d379860) at block/curl.c:918
> =C2=A0=C2=A0#15 0x00000000004975fb in curl_co_preadv (bs=3D0xf16820, offs=
et=3D6556160, bytes=3D512, qiov=3D0x7f712d379b40, flags=3D0) at block/curl.=
c:935
> =C2=A0=C2=A0#16 0x000000000047730f in bdrv_driver_preadv (bs=3D0xf16820, =
offset=3D6556160, bytes=3D512, qiov=3D0x7f712d379b40, flags=3D0) at block/i=
o.c:836
> =C2=A0=C2=A0#17 0x0000000000477c1f in bdrv_aligned_preadv (child=3D0xf1be=
20, req=3D0x7f712d379a60, offset=3D6556160, bytes=3D512, align=3D1,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qiov=3D0x7f712d379b40, flags=3D0) at =
block/io.c:1086
> =C2=A0=C2=A0#18 0x0000000000478109 in bdrv_co_preadv (child=3D0xf1be20, o=
ffset=3D6556160, bytes=3D512, qiov=3D0x7f712d379b40, flags=3D0) at block/io=
.c:1180
> =C2=A0=C2=A0#19 0x0000000000437498 in qcow2_co_preadv (bs=3D0xf0fdc0, off=
set=3D21563904, bytes=3D512, qiov=3D0x7f712d379e80, flags=3D0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0at block/qcow2.c:1812
> =C2=A0=C2=A0#20 0x000000000047730f in bdrv_driver_preadv (bs=3D0xf0fdc0, =
offset=3D21563904, bytes=3D512, qiov=3D0x7f712d379e80, flags=3D0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0at block/io.c:836
> =C2=A0=C2=A0#21 0x0000000000477c1f in bdrv_aligned_preadv (child=3D0xf1c0=
d0, req=3D0x7f712d379d30, offset=3D21563904, bytes=3D512, align=3D1,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qiov=3D0x7f712d379e80, flags=3D0) at =
block/io.c:1086
> =C2=A0=C2=A0#22 0x0000000000478109 in bdrv_co_preadv (child=3D0xf1c0d0, o=
ffset=3D21563904, bytes=3D512, qiov=3D0x7f712d379e80, flags=3D0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0at block/io.c:1180
> =C2=A0=C2=A0#23 0x00000000004645ad in blk_co_preadv (blk=3D0xf1be90, offs=
et=3D21563904, bytes=3D512, qiov=3D0x7f712d379e80, flags=3D0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0at block/block-backend.c:991
> =C2=A0=C2=A0#24 0x00000000004646fa in blk_read_entry (opaque=3D0x7f712d37=
9ea0) at block/block-backend.c:1038
> =C2=A0=C2=A0#25 0x000000000046481c in blk_prw (blk=3D0xf1be90, offset=3D2=
1563904,
> =C2=A0=C2=A0---Type <return> to continue, or q <return> to quit---
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0buf=3D0xf7f000 "2,NV\241t!\ti\312\vp\=
364\017Kl*\354\021\a\177\021\260\b\027\212\347\027\004\322\nG\340b\\\306pG\=
332\313\060\341;\002\360\063L\240\027T \211\341\305\022=D0=90E\230\356D=C7=
=AE}\211\bx\016\a\b\313\350\316\064.\017\372\032-R\376z\261\263\350|cQ<\016=
S_L\340A\221\366~L#\001+\271\204\065~\327\023\027I\211\343\361\276zT$4\336\=
273=CB=8F\353=CA=AA\234\016_Z|TMk\"\370\002\363~\334\332.\a\375\265m=D3=8C{=
/%\304=D6=8E\374sF<E\371\031o&\202\217\226\276>I\356\302\375F\340\332\324\0=
21\202\232>\026\261\233\303tv\023\304\006\243\037\062B=CF=8F\b\324rs\360'".=
.., bytes=3D512, co_entry=3D0x4646aa <blk_read_entry>, flags=3D0) at block/=
block-backend.c:1074
> =C2=A0=C2=A0#26 0x0000000000464f81 in blk_pread (blk=3D0xf1be90, offset=
=3D21563904, buf=3D0xf7f000, count=3D512) at block/block-backend.c:1227
> =C2=A0=C2=A0#27 0x00000000004906cb in nbd_trip (opaque=3D0xf5a940) at nbd=
/server.c:1380
> =C2=A0=C2=A0#28 0x000000000051c0a5 in coroutine_trampoline (i0=3D15812176=
, i1=3D0) at util/coroutine-ucontext.c:79
> =C2=A0=C2=A0#29 0x00007f713143b5d0 in ?? () from /lib/x86_64-linux-gnu/li=
bc.so.6
> =C2=A0=C2=A0#30 0x00007f712d47a770 in ?? ()
> =C2=A0=C2=A0#31 0x0000000000000000 in ?? ()
> =C2=A0=C2=A0Backtrace stopped: Cannot access memory at address 0x7f712d37=
a000
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1708442/+subscriptions

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1708442

Title:
  Crash(assert) during reading  image from http url through qemu-nbd

Status in QEMU:
  New

Bug description:
  Description:
  During reading image from nbd device mounted by qemu-nbd server with url =
backend I/O error happens
  "blk_update_request: I/O error, dev nbd0, sector 42117" dmesg. After some=
 investigation I found that qemu-nbd server aborts in aio_co_enter() assert=
 in util/async.c:468.

  Steps to reproduce:

  1) sudo go run qemu-nbd-bug-report/qemu-nbd-bug.go (see qemu-nbd-bug-
  report.tar.gz)

  or try directly

  1) qemu-nbd -c /dev/nbd0 -r -v --aio=3Dnative -f qcow2 json:{"file.driver=
":"http","file.url":"http://localhost:9666/image","file.readahead":3276800
  2) try read whole nbd device while error "blk_update_request: I/O error, =
dev nbd0, sector 42117" appears in dmesg

  Versions:

  1) qemu built from sources(/configure --target-list=3Dx86_64-softmmu --di=
sable-user --enable-curl --enable-linux-aio --enable-virtfs --enable-debug =
--disable-pie
  , top commit 5619c179057e24195ff19c8fe6d6a6cbcb16ed28):

  qemu-nbd -v
  qemu-nbd 2.9.90 (v2.10.0-rc0-67-g5619c17)

  2) libcurl(built from sources, top commit
  1767adf4399bb3be29121435e1bb1cc2bc05f7bf):

  curl -V
  curl 7.55.0-DEV (Linux) libcurl/7.55.0-DEV OpenSSL/1.0.2g zlib/1.2.8

  Backtrace:
  (gdb) bt
  #0  0x00007f7131426428 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
unix/sysv/linux/raise.c:54
  #1  0x00007f713142802a in __GI_abort () at abort.c:89
  #2  0x00007f713141ebd7 in __assert_fail_base (fmt=3D<optimized out>, asse=
rtion=3Dassertion@entry=3D0x54c924 "self !=3D co",
  =C2=A0=C2=A0=C2=A0=C2=A0file=3Dfile@entry=3D0x54c871 "util/async.c", line=
=3Dline@entry=3D468,
  =C2=A0=C2=A0=C2=A0=C2=A0function=3Dfunction@entry=3D0x54c980 <__PRETTY_FU=
NCTION__.24766> "aio_co_enter") at assert.c:92
  #3  0x00007f713141ec82 in __GI___assert_fail (assertion=3D0x54c924 "self =
!=3D co", file=3D0x54c871 "util/async.c", line=3D468,
  =C2=A0=C2=A0=C2=A0=C2=A0function=3D0x54c980 <__PRETTY_FUNCTION__.24766> "=
aio_co_enter") at assert.c:101
  #4  0x00000000004fe6a2 in aio_co_enter (ctx=3D0xf0ddb0, co=3D0xf14650) at=
 util/async.c:468
  #5  0x00000000004fe637 in aio_co_wake (co=3D0xf14650) at util/async.c:456
  #6  0x0000000000495c8a in curl_read_cb (ptr=3D0xf566d9, size=3D1, nmemb=
=3D16135, opaque=3D0xf1cb90) at block/curl.c:275
  #7  0x00007f713242ac24 in Curl_client_chop_write () from /usr/lib/x86_64-=
linux-gnu/libcurl.so
  #8  0x00007f713242ae03 in Curl_client_write () from /usr/lib/x86_64-linux=
-gnu/libcurl.so
  #9  0x00007f713244e1cf in readwrite_data () from /usr/lib/x86_64-linux-gn=
u/libcurl.so
  #10 0x00007f713244eb6f in Curl_readwrite () from /usr/lib/x86_64-linux-gn=
u/libcurl.so
  #11 0x00007f713245c1bb in multi_runsingle () from /usr/lib/x86_64-linux-g=
nu/libcurl.so
  #12 0x00007f713245d819 in multi_socket () from /usr/lib/x86_64-linux-gnu/=
libcurl.so
  #13 0x00007f713245e067 in curl_multi_socket_action () from /usr/lib/x86_6=
4-linux-gnu/libcurl.so
  #14 0x0000000000497555 in curl_setup_preadv (bs=3D0xf16820, acb=3D0x7f712=
d379860) at block/curl.c:918
  #15 0x00000000004975fb in curl_co_preadv (bs=3D0xf16820, offset=3D6556160=
, bytes=3D512, qiov=3D0x7f712d379b40, flags=3D0) at block/curl.c:935
  #16 0x000000000047730f in bdrv_driver_preadv (bs=3D0xf16820, offset=3D655=
6160, bytes=3D512, qiov=3D0x7f712d379b40, flags=3D0) at block/io.c:836
  #17 0x0000000000477c1f in bdrv_aligned_preadv (child=3D0xf1be20, req=3D0x=
7f712d379a60, offset=3D6556160, bytes=3D512, align=3D1,
  =C2=A0=C2=A0=C2=A0=C2=A0qiov=3D0x7f712d379b40, flags=3D0) at block/io.c:1=
086
  #18 0x0000000000478109 in bdrv_co_preadv (child=3D0xf1be20, offset=3D6556=
160, bytes=3D512, qiov=3D0x7f712d379b40, flags=3D0) at block/io.c:1180
  #19 0x0000000000437498 in qcow2_co_preadv (bs=3D0xf0fdc0, offset=3D215639=
04, bytes=3D512, qiov=3D0x7f712d379e80, flags=3D0)
  =C2=A0=C2=A0=C2=A0=C2=A0at block/qcow2.c:1812
  #20 0x000000000047730f in bdrv_driver_preadv (bs=3D0xf0fdc0, offset=3D215=
63904, bytes=3D512, qiov=3D0x7f712d379e80, flags=3D0)
  =C2=A0=C2=A0=C2=A0=C2=A0at block/io.c:836
  #21 0x0000000000477c1f in bdrv_aligned_preadv (child=3D0xf1c0d0, req=3D0x=
7f712d379d30, offset=3D21563904, bytes=3D512, align=3D1,
  =C2=A0=C2=A0=C2=A0=C2=A0qiov=3D0x7f712d379e80, flags=3D0) at block/io.c:1=
086
  #22 0x0000000000478109 in bdrv_co_preadv (child=3D0xf1c0d0, offset=3D2156=
3904, bytes=3D512, qiov=3D0x7f712d379e80, flags=3D0)
  =C2=A0=C2=A0=C2=A0=C2=A0at block/io.c:1180
  #23 0x00000000004645ad in blk_co_preadv (blk=3D0xf1be90, offset=3D2156390=
4, bytes=3D512, qiov=3D0x7f712d379e80, flags=3D0)
  =C2=A0=C2=A0=C2=A0=C2=A0at block/block-backend.c:991
  #24 0x00000000004646fa in blk_read_entry (opaque=3D0x7f712d379ea0) at blo=
ck/block-backend.c:1038
  #25 0x000000000046481c in blk_prw (blk=3D0xf1be90, offset=3D21563904,
  ---Type <return> to continue, or q <return> to quit---
  =C2=A0=C2=A0=C2=A0=C2=A0buf=3D0xf7f000 "2,NV\241t!\ti\312\vp\364\017Kl*\3=
54\021\a\177\021\260\b\027\212\347\027\004\322\nG\340b\\\306pG\332\313\060\=
341;\002\360\063L\240\027T \211\341\305\022=D0=90E\230\356D=C7=AE}\211\bx\0=
16\a\b\313\350\316\064.\017\372\032-R\376z\261\263\350|cQ<\016S_L\340A\221\=
366~L#\001+\271\204\065~\327\023\027I\211\343\361\276zT$4\336\273=CB=8F\353=
=CA=AA\234\016_Z|TMk\"\370\002\363~\334\332.\a\375\265m=D3=8C{/%\304=D6=8E\=
374sF<E\371\031o&\202\217\226\276>I\356\302\375F\340\332\324\021\202\232>\0=
26\261\233\303tv\023\304\006\243\037\062B=CF=8F\b\324rs\360'"..., bytes=3D5=
12, co_entry=3D0x4646aa <blk_read_entry>, flags=3D0) at block/block-backend=
.c:1074
  #26 0x0000000000464f81 in blk_pread (blk=3D0xf1be90, offset=3D21563904, b=
uf=3D0xf7f000, count=3D512) at block/block-backend.c:1227
  #27 0x00000000004906cb in nbd_trip (opaque=3D0xf5a940) at nbd/server.c:13=
80
  #28 0x000000000051c0a5 in coroutine_trampoline (i0=3D15812176, i1=3D0) at=
 util/coroutine-ucontext.c:79
  #29 0x00007f713143b5d0 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
  #30 0x00007f712d47a770 in ?? ()
  #31 0x0000000000000000 in ?? ()
  Backtrace stopped: Cannot access memory at address 0x7f712d37a000

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1708442/+subscriptions
