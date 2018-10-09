Received: from eggs.gnu.org ([2001:4830:134:3::10]:49858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g9qAD-0005W5-RR
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g9qAA-0001uH-Iw
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:26:57 -0400
Received: from mail.ispras.ru ([83.149.199.45]:38676)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g9qA9-0001tK-SY
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:26:54 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <CANzW0mvSX5nWuinDU68W2yJzgoQSGAHPqpz0G36A6NKwRsz_4A@mail.gmail.com>
	<d45bff6c4e472811f01452b5f730c1b6@ispras.ru>
	<CANzW0mthuW0a7LR7DhpvTPnZ5n5DxtYyfYQf756vtyb9g0O7QQ@mail.gmail.com>
	<CANzW0muZaNRtOP6OjXJ11HXL_q2MDOhCxY2dXZc2DzHr5BxqLw@mail.gmail.com>
	<1930792321d9a0b16576359c7cec9f51@ispras.ru>
	<CANzW0mta+dqVQUEPoXMuhwn+QY0+vBoOjBAj7BPmRL=z72Wxjw@mail.gmail.com>
	<002601d45faf$0d28a4f0$2779eed0$@ru>
	<CANzW0muyArqfeY2xY92hZWFsHD6me75KJBowcu0OrqnvbFDy5Q@mail.gmail.com>
In-Reply-To: <CANzW0muyArqfeY2xY92hZWFsHD6me75KJBowcu0OrqnvbFDy5Q@mail.gmail.com>
Date: Tue, 9 Oct 2018 14:26:52 +0300
Message-ID: <003c01d45fc2$fa57cfe0$ef076fa0$@ru>
MIME-Version: 1.0
Content-Language: ru
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/25] Fixing record/replay and adding
 reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Artem Pisarenko' <artem.k.pisarenko@gmail.com>
Cc: Pavel.Dovgaluk@ispras.ru, qemu-devel@nongnu.org

Maybe this will help?

=20

https://www.mail-archive.com/qemu-devel@nongnu.org/msg560780.html

=20

Pavel Dovgalyuk

=20

From: Artem Pisarenko [mailto:artem.k.pisarenko@gmail.com]=20
Sent: Tuesday, October 09, 2018 2:24 PM
To: Pavel Dovgalyuk
Cc: Pavel.Dovgaluk@ispras.ru; qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] [PATCH v6 00/25] Fixing record/replay and =
adding reverse debugging

=20

(Since all previous patches are already merged to master, I'm running =
tests against latest (almost) version from master branch. Following =
results are based on master commit =
dafd95053611aa14dda40266857608d12ddce658 .)

=20

Applying this patch made Tests 1 and 2 succeed (at least I wasn't able =
to acheive failures with several attempts).

Also I've tried few tests without sleep=3Doff and/or rtc base options. =
All of them succeed too, except one case - removing sleep=3Doff =
(regardless of -rtc option values or its presence at all) causes qemu to =
hang hard in recording mode at very startup. Process needs to be killed.

=20

Some info from debugger:

    qemu-system-x86_64 [13231] [cores: 2,4,5,7]   =20

          Thread #1 [qemu-system-x86] 13231 [core: 2] (Suspended : =
Container)   =20

                      __lll_lock_wait() at lowlevellock.S:135 =
0x7f00b116626d  =20

                      __GI___pthread_mutex_lock() at =
pthread_mutex_lock.c:80 0x7f00b115fdbd    =20

                      qemu_mutex_lock_impl() at qemu-thread-posix.c:66 =
0x947ac4     =20

                      replay_mutex_lock() at replay-internal.c:206 =
0x7f3dea      =20

                      os_host_main_loop_wait() at main-loop.c:235 =
0x94335e   =20

                      main_loop_wait() at main-loop.c:497 0x943429     =20

                      main_loop() at vl.c:1,853 0x5be70f  =20

                      main() at vl.c:4,575 0x5c56e0          =20

          Thread #2 [qemu-system-x86] 13282 [core: 4] (Suspended : =
Container)   =20

          Thread #3 [qemu-system-x86] 13283 [core: 5] (Suspended : =
Container)   =20

          Thread #4 [qemu-system-x86] 13284 [core: 7] (Suspended : Step) =


                      cpu_get_icount_raw() at cpus.c:301 0x45a0a0        =
=20

                      replay_get_current_step() at replay.c:67 0x7f2f14  =
=20

                      replay_save_instructions() at =
replay-internal.c:225 0x7f3ea0         =20

                      replay_save_clock() at replay-time.c:24 0x7f483d   =


                      icount_warp_rt() at cpus.c:512 0x45a745    =20

                      qemu_account_warp_timer() at cpus.c:690 0x45ad55   =
     =20

                      qemu_tcg_rr_cpu_thread_fn() at cpus.c:1,498 =
0x45c554   =20

                      qemu_thread_start() at qemu-thread-posix.c:504 =
0x9485cf=20

                      start_thread() at pthread_create.c:333 =
0x7f00b115d6ba    =20

                      clone() at clone.S:109 0x7f00b0e9341d      =20

    gdb (7.11.1)         =20

=20

Threads #2,3 are just waiting in poll or similar. Nothing extraordinary.

=20

Thread #4 cycles inside do {} while() loop of cpu_get_icount_raw() =
function:

    do {

        start =3D seqlock_read_begin(&timers_state.vm_clock_seqlock);

        icount =3D cpu_get_icount_raw_locked();

    } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));

=20

Value of timers_state.vm_clock_seqlock.sequence is always 3.

=20

=D0=B2=D1=82, 9 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 15:04, Pavel =
Dovgalyuk <dovgaluk@ispras.ru>:

Please try the following patch.

There was a problem with rtc option in record/replay mode.

=20

diff --git a/vl.c b/vl.c

index 40d5d0f..afe1c20 100644

--- a/vl.c

+++ b/vl.c

@@ -2885,6 +2885,7 @@ int main(int argc, char **argv, char **envp)

     DisplayState *ds;

     QemuOpts *opts, *machine_opts;

     QemuOpts *icount_opts =3D NULL, *accel_opts =3D NULL;

+    QemuOpts *rtc_opts =3D NULL;

     QemuOptsList *olist;

     int optind;

     const char *optarg;

@@ -3691,12 +3692,11 @@ int main(int argc, char **argv, char **envp)

                 warn_report("This option is ignored and will be removed =
soon");

                 break;

             case QEMU_OPTION_rtc:

-                opts =3D qemu_opts_parse_noisily(qemu_find_opts("rtc"), =
optarg,

-                                               false);

-                if (!opts) {

+                rtc_opts =3D =
qemu_opts_parse_noisily(qemu_find_opts("rtc"),

+                                                   optarg, false);

+                if (!rtc_opts) {

                     exit(1);

                 }

-                configure_rtc(opts);

                 break;

             case QEMU_OPTION_tb_size:

#ifndef CONFIG_TCG

@@ -3907,6 +3907,9 @@ int main(int argc, char **argv, char **envp)

     loc_set_none();

     replay_configure(icount_opts);

+    if (rtc_opts) {

+        configure_rtc(rtc_opts);

+    }

     if (incoming && !preconfig_exit_requested) {

         error_report("'preconfig' and 'incoming' options are "

=20

Pavel Dovgalyuk

=20

From: Artem Pisarenko [mailto:artem.k.pisarenko@gmail.com]=20
Sent: Thursday, October 04, 2018 4:16 PM
To: dovgaluk
Cc: Pavel.Dovgaluk@ispras.ru; qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] [PATCH v6 00/25] Fixing record/replay and =
adding reverse debugging

=20

No, it didn't changed test results, at least for =
https://github.com/ispras/qemu/tree/rr-180911 . Even step values it =
stucks on are same for most runs.

Playing with master and my own branch gives different results for tests =
without sleep=3Doff and -rtc base. It seems that patch you mentioned =
didn't changed them very much.

The only thing can be said for sure, is that this patch does not fix =
issues completely. But MAY fix them partially or in some other specific =
cases...

=20

=D1=81=D1=80, 3 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 12:47, dovgaluk =
<dovgaluk@ispras.ru>:

Can you try applying this patch?
https://www.mail-archive.com/qemu-devel@nongnu.org/msg563798.html

I also encountered the problems with x86_64 replaying and found the=20
misprint in
the code which was fixed later, than sending the series to the mailing=20
list.

Pavel Dovgalyuk


Artem Pisarenko =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2018-10-02 10:02:
> I've added "-monitor stdio" option to command line of Test 1 and
> repeated entering command during execution:
>=20
>   QEMU 3.0.50 monitor - type 'help' for more information
>   (qemu) info replay
>   Replaying execution 'icount_rr_capture.bin': current step =3D
> 311736195
>   (qemu) info replay
>   Replaying execution 'icount_rr_capture.bin': current step =3D
> 318198367
>   (qemu) info replay
>   Replaying execution 'icount_rr_capture.bin': current step =3D
> 324737211
>   (qemu) info replay
>   Replaying execution 'icount_rr_capture.bin': current step =3D
> 329890795
>   (qemu) info replay
>   Replaying execution 'icount_rr_capture.bin': current step =3D
> 607069789
>   (qemu) info replay
>   Replaying execution 'icount_rr_capture.bin': current step =3D
> 607069789
>   (qemu) info replay
>   Replaying execution 'icount_rr_capture.bin': current step =3D
> 607069789
>   ...
>=20
> Some notes on value of step it stucks on:
> - mostly it's same (even across different record-replay pairs);
> - stressing host during replay may cause it to change even for same
> record-replay pair (i.e. different replay executions for same file
> recorded).
>=20
> This specific case seems to be stable to reproduce.
>=20
> =D0=B2=D1=82, 2 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 0:22, Artem =
Pisarenko
> <artem.k.pisarenko@gmail.com>:
>=20
>> I've posted bug report with extended tests (incl. case without
>> sleep=3Doff). You may find guest image (kernel) in bug description.
>> https://bugs.launchpad.net/qemu/+bug/1795369 [1]
>>=20
>> The most annoying thing is that some issues are almost not
>> reproducible. There are definitely race conditions somewhere in qemu
>> code. Running 'stress-ng' utility with CPU and I/O stressors in
>> parallel with qemu execution greatly minimizes amount of attempts
>> when I'm trying to trigger some of issues I encounter.
>>=20
>> I'll try 'info monitor' command tomorrow, but no guarantees that
>> I'll be able to reproduce issue again.
>>=20
>> Speaking about '-nographic' and SDL... I've noted that UI greatly
>> minimizes possibility of hanging (but not avoids it completely) when
>> using icount in general, so this effect isn't rr-specific. I've
>> already reported this bug too.
>>=20
>> =D0=BF=D0=BD, 1 =D0=BE=D0=BA=D1=82. 2018 =D0=B3., 20:14 dovgaluk =
<dovgaluk@ispras.ru>:
>>=20
>>> Artem Pisarenko =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2018-09-30 14:01:
>>>> Feature still broken :(
>>>=20
>>> Thanks for testing.
>>>=20
>>>>=20
>>>> Brief description of my tests.
>>>>=20
>>>> Guest image is Linux, which just powers off after kernel boots
>>>> (instead of proceeding to user-space /init or /sbin/init).
>>>> Base cmdline:
>>>> qemu-system-x86_64 -nodefaults -machine pc,accel=3Dtcg -m 2048
>>> -cpu
>>>> qemu64 -rtc clock=3Dvm,base=3D2000-01-01T00:00:00 -kernel bzImage
>>> -initrd
>>>> rootfs -append 'nokaslr console=3DttyS0 rdinit=3D/init_poweroff'
>>>> -nographic -serial SERIAL_VALUE -icount
>>>> 1,sleep=3Doff,rr=3DRR_VALUE,rrfile=3Dicount_rr_capture.bin
>>>=20
>>> I've never tried it with sleep=3Doff. Can you remove it and try
>>> again?
>>>=20
>>> We also seen a problem with '-nographic'. When we remove this
>>> option and
>>> QEMU runs with SDL
>>> window, everything is ok. There is some problem with main loop
>>> which may
>>> sleep when there
>>> is no GUI to update, or something like that. We couldn't fix it
>>> yet.
>>>=20
>>>>=20
>>>> Test 1. When SERIAL_VALUE=3Dnone
>>>> Running with RR_VALUE=3Drecord completes successfully.
>>>> Running with RR_VALUE=3Dreplay doesn't completes. qemu process
>>> just
>>>> eating ~100% cpu and memory usage doesn't grow after some
>>> moment. I
>>>> don't see what happens because of problem no.2 (see below).
>>>=20
>>> Try 'info replay' monitor command. Does instruction counter
>>> increases?
>>>=20
>>>>=20
>>>> Test 2. When SERIAL_VALUE=3Dstdio
>>>> Running with RR_VALUE=3Drecord completes successfully.
>>>>=20
>>>> Running with RR_VALUE=3Dreplay caues exit with error:
>>>>=20
>>>> "qemu-system-x86_64: Missing character write event in the replay
>>> log"
>>>>=20
>>>> These problems are same with qemu 2.12 (both vanilla and with
>>> previous
>>>> versions of these patches applied). Furthemore, I consider whole
>>>> icount mode broken and determinism isn't achievable.
>>>> The irony is that I actually don't need record/replay feature.
>>> I've
>>>> tried to use it only as instrument to debug failing determinism
>>> in
>>>> qemu code. But since replay/record feature itself relies on
>>>> determinism, which is broken, it's no wonder why it fails also
>>> (I just
>>>> hoped to bypass it).
>>>>=20
>>>> Contact me if you need more details. I just tired a lot trying
>>> to get
>>>> all these things working... Hope is leaving me...
>>>=20
>>> Can you share the kernel in case the icount still broken?
>>>=20
>>> Pavel Dovgalyuk
>> --
>>=20
>> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
>> =D0=90=D1=80=D1=82=D0=B5=D0=BC =
=D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=D0=BA=D0=BE
>  --
>=20
> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
>   =D0=90=D1=80=D1=82=D0=B5=D0=BC =
=D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=D0=BA=D0=BE
>=20
> Links:
> ------
> [1] https://bugs.launchpad.net/qemu/+bug/1795369

--=20

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
  =D0=90=D1=80=D1=82=D0=B5=D0=BC =
=D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=D0=BA=D0=BE

--=20

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
  =D0=90=D1=80=D1=82=D0=B5=D0=BC =
=D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=D0=BA=D0=BE
