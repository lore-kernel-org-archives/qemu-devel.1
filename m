Received: from eggs.gnu.org ([2001:4830:134:3::10]:34403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhengui@huawei.com>) id 1fSD6l-0005zx-Dv
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 23:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhengui@huawei.com>) id 1fSD6h-0003Zy-Ai
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 23:03:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2546 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhengui@huawei.com>)
	id 1fSD6g-0003YQ-94
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 23:02:59 -0400
References: <ed097efe-73a8-5184-e0d6-114374d798f1@huawei.com>
	<20180610074333.GA16232@lemon.usersys.redhat.com>
From: l00284672 <lizhengui@huawei.com>
Message-ID: <e560f893-ae9e-8611-bc18-55ae9bd958a0@huawei.com>
Date: Mon, 11 Jun 2018 11:01:55 +0800
MIME-Version: 1.0
In-Reply-To: <20180610074333.GA16232@lemon.usersys.redhat.com>
Content-Type: multipart/mixed; boundary="------------FAC1AE7A9076605788EF5BEC"
Content-Language: en-US
Subject: Re: [Qemu-devel] question: a dead loop in qemu when do
 blockJobAbort and vm suspend coinstantaneously
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: stefanha@gmail.com, kwolf@redhat.com, lizhengui@huawei.com, qemu-devel@nongnu.org

--------------FAC1AE7A9076605788EF5BEC
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Thanks for your reply.

I tried your patch but it didn't work for qemu crashed.=C2=A0 The qemu cr=
ash=20
bt is below:

(gdb) bt
#0=C2=A0 bdrv_detach_aio_context (bs=3Dbs@entry=3D0x55a96b79ca30)
#1=C2=A0 0x000055a9688249ae in bdrv_set_aio_context (bs=3Dbs@entry=3D0x55=
a96b79ca30,
 =C2=A0=C2=A0=C2=A0 new_context=3Dnew_context@entry=3D0x55a96b766920)
#2=C2=A0 0x000055a96885f721 in blk_set_aio_context (blk=3D0x55a96b792820,=
=20
new_context=3D0x55a96b766920)
#3=C2=A0 0x000055a9685ab797 in virtio_blk_data_plane_stop (vdev=3D<optimi=
zed out>)
#4=C2=A0 0x000055a9687bf705 in virtio_bus_stop_ioeventfd (bus=3D0x55a96cc=
42220)
#5=C2=A0 0x000055a9685d9d94 in virtio_vmstate_change (opaque=3D0x55a96cc4=
2290,=20
running=3D<optimized out>,
 =C2=A0=C2=A0=C2=A0 state=3D<optimized out>)
#6=C2=A0 0x000055a96866e1a2 in vm_state_notify (running=3Drunning@entry=3D=
0,=20
state=3Dstate@entry=3DRUN_STATE_PAUSED)
#7=C2=A0 0x000055a96857b4c5 in do_vm_stop (state=3DRUN_STATE_PAUSED)
#8=C2=A0 vm_stop (state=3Dstate@entry=3DRUN_STATE_PAUSED)
#9=C2=A0 0x000055a96867d52b in qmp_stop (errp=3Derrp@entry=3D0x7fff4e54a0=
d8)
#10 0x000055a96867b6ab in qmp_marshal_stop (args=3D<optimized out>,=20
ret=3D<optimized out>, errp=3D0x7fff4e54a
#11 0x000055a9688c2267 in do_qmp_dispatch (errp=3D0x7fff4e54a118,=20
request=3D0x55a96b7b4740)
#12 qmp_dispatch (request=3Drequest@entry=3D0x55a96b7ae490)
#13 0x000055a96857dd42 in handle_qmp_command (parser=3D<optimized out>,=20
tokens=3D<optimized out>)
#14 0x000055a9688c7534 in json_message_process_token=20
(lexer=3D0x55a96b776a68, input=3D0x55a96b70cae0, type=3D
 =C2=A0=C2=A0=C2=A0 x=3D36, y=3D91)
#15 0x000055a9688e960b in json_lexer_feed_char=20
(lexer=3Dlexer@entry=3D0x55a96b776a68, ch=3D125 '}',
 =C2=A0=C2=A0=C2=A0 flush=3Dflush@entry=3Dfalse)
#16 0x000055a9688e96ce in json_lexer_feed (lexer=3D0x55a96b776a68,=20
buffer=3D<optimized out>, size=3D<optimize
#17 0x000055a9688c75f9 in json_message_parser_feed (parser=3D<optimized=20
out>, buffer=3D<optimized out>,
#18 0x000055a96857c5fb in monitor_qmp_read (opaque=3D<optimized out>,=20
buf=3D<optimized out>,=C2=A0 size=3D<optimized out>)
#19 0x000055a968667596 in tcp_chr_read (chan=3D<optimized out>,=20
cond=3D<optimized out>, opaque=3D0x55a96b7748
#20 0x00007f8a9447899a in g_main_context_dispatch () from=20
/lib64/libglib-2.0.so.0
#21 0x000055a968828c3c in glib_pollfds_poll ()
#22 os_host_main_loop_wait (timeout=3D<optimized out>)
#23 main_loop_wait (nonblocking=3D<optimized out>)
#24 0x000055a96854351f in main_loop () at vl.c:2095
#25 main (argc=3D<optimized out>, argv=3D<optimized out>, envp=3D<optimiz=
ed out>)

(gdb) p *bs
$1 =3D {total_sectors =3D 94186141054112, open_flags =3D 1811887680, read=
_only=20
=3D 169, encrypted =3D 85, valid_k
 =C2=A0 sg =3D false, probed =3D false, copy_on_read =3D 0, flush_queue =3D=
 {entries=20
=3D {sqh_first =3D 0x0,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sqh_last =3D 0x55a96b79ca48}}, active_flu=
sh_req =3D false,=20
flushed_gen =3D 68727, drv =3D 0x0, opaque =3D 0
 =C2=A0 aio_context =3D 0x55a96b778cd0, aio_notifiers =3D {lh_first =3D 0=
x0},=20
walking_aio_notifiers =3D false,
 =C2=A0 filename =3D "/mnt/sdb/lzg/disk_10G.son", '\000' <repeats 4070 ti=
mes>,
 =C2=A0 backing_file =3D "\000mnt/sdb/lzg/disk_10G.raw", '\000' <repeats =
4070=20
times>,
 =C2=A0 backing_format =3D "\000aw", '\000' <repeats 12 times>,=20
full_open_options =3D 0x0,
 =C2=A0 exact_filename =3D "/mnt/sdb/lzg/disk_10G.son", '\000' <repeats 4=
070=20
times>, backing =3D 0x0, file =3D 0x0,
 =C2=A0 before_write_notifiers =3D {notifiers =3D {lh_first =3D 0x0}}, in=
_flight =3D=20
0, serialising_in_flight =3D 0,
 =C2=A0 wakeup =3D false, wr_highest_offset =3D 35188224, bl =3D {request=
_alignment=20
=3D 0, max_pdiscard =3D 0,
 =C2=A0=C2=A0=C2=A0 pdiscard_alignment =3D 0, max_pwrite_zeroes =3D 0,=20
pwrite_zeroes_alignment =3D 0, opt_transfer =3D 0, max_t
 =C2=A0=C2=A0=C2=A0 min_mem_alignment =3D 0, opt_mem_alignment =3D 0, max=
_iov =3D 0},=20
supported_write_flags =3D 0,
 =C2=A0 supported_zero_flags =3D 4, node_name =3D "#block349", '\000' <re=
peats 22=20
times>, node_list =3D {
 =C2=A0=C2=A0=C2=A0 tqe_next =3D 0x55a96b7b14f0, tqe_prev =3D 0x0}, bs_li=
st =3D {tqe_next =3D=20
0x55a96b7ab240, tqe_prev =3D 0x0},
 =C2=A0 monitor_list =3D {tqe_next =3D 0x0, tqe_prev =3D 0x0}, dirty_bitm=
aps =3D=20
{lh_first =3D 0x0}, refcnt =3D 0,
 =C2=A0 tracked_requests =3D {lh_first =3D 0x0}, op_blockers =3D {{lh_fir=
st =3D 0x0}=20
<repeats 18 times>}, job =3D 0x0,
 =C2=A0 inherits_from =3D 0x0, children =3D {lh_first =3D 0x0}, parents =3D=
 {lh_first=20
=3D 0x0}, options =3D 0x0,
 =C2=A0 explicit_options =3D 0x0, detect_zeroes =3D=20
BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF, backing_blocker =3D 0x0,
 =C2=A0 write_threshold_offset =3D 0, write_threshold_notifier =3D {notif=
y =3D 0x0,=20
node =3D {le_next =3D 0x0, le_prev
 =C2=A0 io_plugged =3D 0, quiesce_counter =3D 0, write_gen =3D 68727}
(gdb) p *bs->drv
Cannot access memory at address 0x0

 From the bt we can see,=C2=A0 qemu met a Null pointer reference in=20
bdrv_detach_aio_context. The code is below:

void bdrv_detach_aio_context(BlockDriverState *bs)
{
 =C2=A0=C2=A0=C2=A0 .........

QLIST_FOREACH_SAFE(baf, &bs->aio_notifiers, list, baf_tmp) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (baf->deleted) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_=
do_remove_aio_context_notifier(baf);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 baf->=
detach_aio_context(baf->opaque);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0 /* Never mind iterating again to check for ->deleted.=
 bdrv_close() will
 =C2=A0=C2=A0=C2=A0=C2=A0 * remove remaining aio notifiers if we aren't c=
alled again.
 =C2=A0=C2=A0=C2=A0=C2=A0 */
 =C2=A0=C2=A0=C2=A0 bs->walking_aio_notifiers =3D false;

if (bs->drv->bdrv_detach_aio_context) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->drv->bdrv_detach_aio_cont=
ext(bs);
 =C2=A0=C2=A0=C2=A0 }

..................
}

In your patch, the mirror_exit is done in=20
aio_poll(qemu_get_aio_context(), true).=C2=A0 In
mirror_exit, the top bs willl be free by bdrv_unref.=C2=A0 So it will mak=
e a
Null pointer access in the follow-up procedure.




On 2018/6/10 15:43, Fam Zheng wrote:
> On Sat, 06/09 17:10, l00284672 wrote:
>> Hi, I found a dead loop in qemu when do blockJobAbort and vm suspend
>> coinstantaneously.
>>
>> The qemu bt is below:
>>
>> #0=C2=A0 0x00007ff58b53af1f in ppoll () from /lib64/libc.so.6
>> #1=C2=A0 0x00000000007fdbd9 in ppoll (__ss=3D0x0, __timeout=3D0x7ffcf7=
055390,
>> __nfds=3D<optimized out>, __fds=3D<optimized out>) at
>> /usr/include/bits/poll2.h:77
>> #2=C2=A0 qemu_poll_ns (fds=3D<optimized out>, nfds=3D<optimized out>,
>> timeout=3Dtimeout@entry=3D0) at util/qemu-timer.c:334
>> #3=C2=A0 0x00000000007ff83a in aio_poll (ctx=3Dctx@entry=3D0x269d800,
>> blocking=3Dblocking@entry=3Dfalse) at util/aio-posix.c:629
>> #4=C2=A0 0x0000000000776e91 in bdrv_drain_recurse (bs=3Dbs@entry=3D0x2=
6d9cb0) at
>> block/io.c:198
>> #5=C2=A0 0x0000000000776ef2 in bdrv_drain_recurse (bs=3Dbs@entry=3D0x3=
665990) at
>> block/io.c:215
>> #6=C2=A0 0x00000000007774b8 in bdrv_do_drained_begin (bs=3D0x3665990,
>> recursive=3D<optimized out>, parent=3D0x0) at block/io.c:291
>> #7=C2=A0 0x000000000076a79e in blk_drain (blk=3D0x2780fc0) at
>> block/block-backend.c:1586
>> #8=C2=A0 0x000000000072d2a9 in block_job_drain (job=3D0x29df040) at bl=
ockjob.c:123
>> #9=C2=A0 0x000000000072d228 in block_job_detach_aio_context (opaque=3D=
0x29df040) at
>> blockjob.c:139
>> #10 0x00000000007298b1 in bdrv_detach_aio_context (bs=3Dbs@entry=3D0x3=
665990) at
>> block.c:4885
>> #11 0x0000000000729a46 in bdrv_set_aio_context (bs=3D0x3665990,
>> new_context=3D0x268e140) at block.c:4946
>> #12 0x0000000000499743 in virtio_blk_data_plane_stop (vdev=3D<optimize=
d out>)
>> at
>> /mnt/sdb/lzg/code/shequ_code/5_29/qemu/hw/block/dataplane/virtio-blk.c=
:285
>> #13 0x00000000006bce30 in virtio_bus_stop_ioeventfd (bus=3D0x3de5378) =
at
>> hw/virtio/virtio-bus.c:246
>> #14 0x00000000004c654d in virtio_vmstate_change (opaque=3D0x3de53f0,
>> running=3D<optimized out>, state=3D<optimized out>)
>>  =C2=A0=C2=A0=C2=A0 at /mnt/sdb/lzg/code/shequ_code/5_29/qemu/hw/virti=
o/virtio.c:2222
>> #15 0x0000000000561b52 in vm_state_notify (running=3Drunning@entry=3D0=
,
>> state=3Dstate@entry=3DRUN_STATE_PAUSED) at vl.c:1514
>> #16 0x000000000045d67a in do_vm_stop (state=3Dstate@entry=3DRUN_STATE_=
PAUSED,
>> send_stop=3Dsend_stop@entry=3Dtrue)
>>  =C2=A0=C2=A0=C2=A0 at /mnt/sdb/lzg/code/shequ_code/5_29/qemu/cpus.c:1=
012
>> #17 0x000000000045dafd in vm_stop (state=3Dstate@entry=3DRUN_STATE_PAU=
SED) at
>> /mnt/sdb/lzg/code/shequ_code/5_29/qemu/cpus.c:2035
>> #18 0x000000000057301b in qmp_stop (errp=3Derrp@entry=3D0x7ffcf70556f0=
) at
>> qmp.c:106
>> #19 0x000000000056bf7a in qmp_marshal_stop (args=3D<optimized out>,
>> ret=3D<optimized out>, errp=3D0x7ffcf7055738) at qapi/qapi-commands-mi=
sc.c:784
>> #20 0x00000000007f2d27 in do_qmp_dispatch (errp=3D0x7ffcf7055730,
>> request=3D0x3e121e0, cmds=3D<optimized out>) at qapi/qmp-dispatch.c:11=
9
>> #21 qmp_dispatch (cmds=3D<optimized out>, request=3Drequest@entry=3D0x=
26f2800) at
>> qapi/qmp-dispatch.c:168
>> #22 0x00000000004655be in monitor_qmp_dispatch_one
>> (req_obj=3Dreq_obj@entry=3D0x39abff0) at
>> /mnt/sdb/lzg/code/shequ_code/5_29/qemu/monitor.c:4088
>> #23 0x0000000000465894 in monitor_qmp_bh_dispatcher (data=3D<optimized=
 out>)
>> at /mnt/sdb/lzg/code/shequ_code/5_29/qemu/monitor.c:4146
>> #24 0x00000000007fc571 in aio_bh_call (bh=3D0x26de7e0) at util/async.c=
:90
>> #25 aio_bh_poll (ctx=3Dctx@entry=3D0x268dd50) at util/async.c:118
>> #26 0x00000000007ff6f0 in aio_dispatch (ctx=3D0x268dd50) at
>> util/aio-posix.c:436
>> #27 0x00000000007fc44e in aio_ctx_dispatch (source=3D<optimized out>,
>> callback=3D<optimized out>, user_data=3D<optimized out>) at util/async=
.c:261
>> #28 0x00007ff58bc7c99a in g_main_context_dispatch () from
>> /lib64/libglib-2.0.so.0
>> #29 0x00000000007fea3a in glib_pollfds_poll () at util/main-loop.c:215
>> #30 os_host_main_loop_wait (timeout=3D<optimized out>) at util/main-lo=
op.c:238
>> #31 main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at util/main-=
loop.c:497
>> #32 0x0000000000561cad in main_loop () at vl.c:1848
>> #33 0x000000000041995c in main (argc=3D<optimized out>, argv=3D<optimi=
zed out>,
>> envp=3D<optimized out>) at vl.c:4605
>>
>> The disk is a virtio-blk dataplane disk with a mirror job running.=C2=A0=
 The dead
>> loop is here:
>>
>> static void block_job_detach_aio_context(void *opaque)
>> {
>>  =C2=A0=C2=A0=C2=A0 BlockJob *job =3D opaque;
>>
>>  =C2=A0=C2=A0=C2=A0 /* In case the job terminates during aio_poll()...=
 */
>>  =C2=A0=C2=A0=C2=A0 job_ref(&job->job);
>>
>>  =C2=A0=C2=A0=C2=A0 job_pause(&job->job);
>>
>>  =C2=A0 while (!job->job.paused && !job_is_completed(&job->job)) {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_drain(&job->job);
>>  =C2=A0=C2=A0=C2=A0 }
>>
>>  =C2=A0=C2=A0=C2=A0 job->job.aio_context =3D NULL;
>>  =C2=A0=C2=A0=C2=A0 job_unref(&job->job);
>> }
>>
>> The job is deferred to main loop now,=C2=A0 but the=C2=A0 job_drain on=
ly processes the
>> AIO context of bs which has no more work to do,
>>
>> while the main loop BH is scheduled for setting the job->completed fla=
g is
>> never processed.
> In that case, main loop's AioContext should be driven like in job_finis=
h_sync().
> Could you try this patch?
>
> diff --git a/blockjob.c b/blockjob.c
> index 0306533a2e..72aa82ac2d 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -135,7 +135,15 @@ static void block_job_detach_aio_context(void *opa=
que)
>
>       job_pause(&job->job);
>
> -    while (!job->job.paused && !job_is_completed(&job->job)) {
> +
> +    while (true) {
> +        if (job->job.paused || job_is_completed(&job->job)) {
> +            break;
> +        }
> +        if (job->deferred_to_main_loop) {
> +            aio_poll(qemu_get_aio_context(), true);
> +            continue;
> +        }
>           job_drain(&job->job);
>       }
>
> .
>


--------------FAC1AE7A9076605788EF5BEC
Content-Type: text/x-vcard; name="lizhengui.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lizhengui.vcf"

bnVsbA==
--------------FAC1AE7A9076605788EF5BEC--
