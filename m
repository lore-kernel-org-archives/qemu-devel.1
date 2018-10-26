Received: from eggs.gnu.org ([2001:4830:134:3::10]:57786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gG1iK-0004JD-68
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 08:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gG1iG-0003RY-Qx
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 08:59:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:37554 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gG1iG-0003Lh-Gd
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 08:59:40 -0400
References: <20181022110854.10284-1-fli@suse.com>
	<20181025125501.GA5912@work-vm>
From: Fei Li <fli@suse.com>
Message-ID: <670ce3cc-2146-ad2b-197e-8b18daf49e79@suse.com>
Date: Fri, 26 Oct 2018 20:59:26 +0800
MIME-Version: 1.0
In-Reply-To: <20181025125501.GA5912@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 0/2] Fix migration issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com



On 10/25/2018 08:55 PM, Dr. David Alan Gilbert wrote:
> * Fei Li (fli@suse.com) wrote:
>> Hi,
>> these two patches are to fix live migration issues. The first is
>> about multifd, and the second is to fix some error handling.
>>
>> But I have a question about using multifd migration.
>> In our current code, when multifd is used during migration, if there
>> is an error before the destination receives all new channels (I mean
>> multifd_recv_new_channel(ioc)), the destination does not exit but
>> keeps waiting (Hang in recvmsg() in qio_channel_socket_readv) until
>> the source exits.
>>
>> My question is about the state of the destination host if fails during
>> this period. I did a test, after applying [1/2] patch, if
>> multifd_new_send_channel_async() fails, the destination host hangs for
>> a while then later pops up a window saying
>>      "'QEMU (...) [stopped]' is not responding.
>>      You may choose to wait a short while for it to continue or force
>>      the application to quit entirely."
>> But after closing the window by clicking, the qemu on the dest still
>> hangs there until I exclusively kill the qemu on the source.
> That sounds like the main thread is blocked for some reason?
Yes, the main thread on=C2=A0 the dst is keeps looping.
> But I don't
> normally use the window setup;  if you try with -nographic and can see
> the HMP (or a QMP) monitor, can you see if the monitor still responds?

Thanks for the `-nographic` reminder, I harvested an interesting=20
phenonmenon:
If I do the `migrate -d tcp:ip_addr:port` before the guest's graphic appe=
ars
(it's dark now), there is no hang and the guest starts up properly later.
But if I do the live migration after the guest fully starts up, I mean wh=
en
I can operate something using my mouse inside the guest, the hang
situation is there.
This is true for using `-nographic` for both src and dst,
and using `-nographic` for only src or dst.


The hang phenonmenon is that the dst seems never responds (I
waited three minutes), and the cursor just keeps flashing. After I
exclusively kill the src, then the dst quit. Just as follows:
(Same result if gdb is not used in src)
src:
(qemu) ...
(qemu) q
(gdb) q
dst:
(qemu) Up to now, dst has received the 0 channel
Up to now, dst has received the 1 channel

(qemu)
(qemu)

To check the migtation state in the src:
(qemu) info migrate
globals:
store-global-state: on
only-migratable: off
send-configuration: on
send-section-footer: on
decompress-error-check: on
capabilities: xbzrle: off rdma-pin-all: off auto-converge: off=20
zero-blocks: off compress: off events: off postcopy-ram: off x-colo: off=20
release-ram: off block: off return-path: off pause-before-switchover:=20
off x-multifd: on dirty-bitmaps: off postcopy-blocktime: off=20
late-block-activate: off
Migration status: setup /* I added some codes to set the status to=20
"failed", but still not working, details see below */
total time: 0 milliseconds

I guess maybe the source should to proactive to tell the dst and
disconnects from the source side, so I tried to set the above
"Migration status" to be "failed", and use qemu_fclose(s->to_dst_file)
when multifd_new_send_channel_async() fails.
(BTW: I even tried:
 =C2=A0if (s->vm_was_running) {=C2=A0=C2=A0 vm_start();=C2=A0=C2=A0 }=C2=A0=
=C2=A0 )
But the hang situation is still there.
> If it doesn't then try and get a backtrace.
>
> The monitor really shouldn't block, so it would be interesting to see.
>
> Dave
I set two breakpoints and get the following backtrace, hope they can=20
help. :)

Thread 1 "qemu-system-x86" hit Breakpoint 1, multifd_recv_new_channel (
 =C2=A0=C2=A0=C2=A0 ioc=3D0x555557995af0) at /build/gitcode/qemu-build/mi=
gration/ram.c:1368
1368=C2=A0=C2=A0=C2=A0 {
(gdb) c
Continuing.

Thread 1 "qemu-system-x86" hit Breakpoint 2, qio_channel_socket_readv (
 =C2=A0=C2=A0=C2=A0 ioc=3D0x555557995af0, iov=3D0x5555568777d0, niov=3D1,=
 fds=3D0x0, nfds=3D0x0,
 =C2=A0=C2=A0=C2=A0 errp=3D0x7fffffffdb38) at io/channel-socket.c:463
463=C2=A0=C2=A0=C2=A0 {
(gdb) n
464=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 QIOChannelSocket *sioc =3D QIO_C=
HANNEL_SOCKET(ioc);
(gdb)
......
483=C2=A0=C2=A0=C2=A0 =C2=A0retry:
(gdb)
484=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D recvmsg(sioc->fd, &msg, =
sflags);
(gdb) bt
#0=C2=A0 qio_channel_socket_readv (ioc=3D0x555557995af0, iov=3D0x55555687=
77d0,=20
niov=3D1,
 =C2=A0=C2=A0=C2=A0 fds=3D0x0, nfds=3D0x0, errp=3D0x7fffffffdb38) at io/c=
hannel-socket.c:484
#1=C2=A0 0x0000555555d156c5 in qio_channel_readv_full (ioc=3D0x555557995a=
f0,
 =C2=A0=C2=A0=C2=A0 iov=3D0x5555568777d0, niov=3D1, fds=3D0x0, nfds=3D0x0=
, errp=3D0x7fffffffdb38)
 =C2=A0=C2=A0=C2=A0 at io/channel.c:65
#2=C2=A0 0x0000555555d15b26 in qio_channel_readv (ioc=3D0x555557995af0,
 =C2=A0=C2=A0=C2=A0 iov=3D0x5555568777d0, niov=3D1, errp=3D0x7fffffffdb38=
) at io/channel.c:197
#3=C2=A0 0x0000555555d15853 in qio_channel_readv_all_eof (ioc=3D0x5555579=
95af0,
 =C2=A0=C2=A0=C2=A0 iov=3D0x7fffffffda70, niov=3D1, errp=3D0x7fffffffdb38=
) at io/channel.c:106
#4=C2=A0 0x0000555555d1595c in qio_channel_readv_all (ioc=3D0x555557995af=
0,
 =C2=A0=C2=A0=C2=A0 iov=3D0x7fffffffda70, niov=3D1, errp=3D0x7fffffffdb38=
) at io/channel.c:142
#5=C2=A0 0x0000555555d15d0c in qio_channel_read_all (ioc=3D0x555557995af0=
,
 =C2=A0=C2=A0=C2=A0 buf=3D0x7fffffffdad0 "\340\"zVUU", buflen=3D25, errp=3D=
0x7fffffffdb38)
 =C2=A0=C2=A0=C2=A0 at io/channel.c:246
#6=C2=A0 0x000055555587695c in multifd_recv_initial_packet (c=3D0x5555579=
95af0,
 =C2=A0=C2=A0=C2=A0 errp=3D0x7fffffffdb38) at /build/gitcode/qemu-build/m=
igration/ram.c:653
#7=C2=A0 0x00005555558788fb in multifd_recv_new_channel (ioc=3D0x55555799=
5af0)
 =C2=A0=C2=A0=C2=A0 at /build/gitcode/qemu-build/migration/ram.c:1374
#8=C2=A0 0x0000555555bc9978 in migration_ioc_process_incoming=20
(ioc=3D0x555557995af0)
 =C2=A0=C2=A0=C2=A0 at migration/migration.c:573
#9=C2=A0 0x0000555555bd0c69 in migration_channel_process_incoming=20
(ioc=3D0x555557995af0)
 =C2=A0=C2=A0=C2=A0 at migration/channel.c:47
#10 0x0000555555bcf7e8 in socket_accept_incoming_migration (
 =C2=A0=C2=A0=C2=A0 listener=3D0x5555578dcae0, cioc=3D0x555557995af0, opa=
que=3D0x0)
 =C2=A0=C2=A0=C2=A0 at migration/socket.c:166
#11 0x0000555555d2051f in qio_net_listener_channel_func=20
(ioc=3D0x5555579c7180,
 =C2=A0=C2=A0=C2=A0 condition=3DG_IO_IN, opaque=3D0x5555578dcae0) at io/n=
et-listener.c:53
#12 0x0000555555d1c0a2 in qio_channel_fd_source_dispatch=20
(source=3D0x5555568d5970,
---Type <return> to continue, or q <return> to quit---
 =C2=A0=C2=A0=C2=A0 callback=3D0x555555d20473 <qio_net_listener_channel_f=
unc>,
 =C2=A0=C2=A0=C2=A0 user_data=3D0x5555578dcae0) at io/channel-watch.c:84
#13 0x00007ffff6353dc5 in g_main_context_dispatch ()
 =C2=A0=C2=A0 from /usr/lib64/libglib-2.0.so.0
#14 0x0000555555d7d1ad in glib_pollfds_poll () at util/main-loop.c:215
#15 0x0000555555d7d227 in os_host_main_loop_wait (timeout=3D0) at=20
util/main-loop.c:238
#16 0x0000555555d7d2e0 in main_loop_wait (nonblocking=3D0) at=20
util/main-loop.c:497
#17 0x00005555559cd679 in main_loop () at vl.c:1884
#18 0x00005555559d4f1e in main (argc=3D32, argv=3D0x7fffffffe0b8,=20
envp=3D0x7fffffffe1c0)
 =C2=A0=C2=A0=C2=A0 at vl.c:4618
(gdb) n

Thread 1 "qemu-system-x86" received signal SIGINT, Interrupt.
0x00007ffff5606f64 in recvmsg () from /lib64/libpthread.so.0
(gdb) c
Continuing.

After I input above `n`, the dst just hangs here, seems waiting for the=20
result of
recvmsg(sioc->fd, &msg, sflags); Later even I use ctrl+c to kill it, the=20
dst still hangs.

Have a nice day, thanks
Fei
>
>> The source host keeps running as expected, but I guess the hang
>> phenonmenon in the dest is not right.
>> Would someone kindly give some suggestions on this? Thanks a lot.
>>
>>
>> Fei Li (2):
>>    migration: fix the multifd code
>>    migration: fix some error handling
>>
>>   migration/migration.c    |  5 +----
>>   migration/postcopy-ram.c |  3 +++
>>   migration/ram.c          | 33 +++++++++++++++++++++++----------
>>   migration/ram.h          |  2 +-
>>   4 files changed, 28 insertions(+), 15 deletions(-)
>>
>> --=20
>> 2.13.7
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
