Received: from eggs.gnu.org ([2001:4830:134:3::10]:55301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1da42j-0007t4-GN
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1da42g-0007nv-EI
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:54:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10385)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1da42g-0007nR-5U
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:54:46 -0400
Date: Tue, 25 Jul 2017 18:54:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170725175439.GC2820@work-vm>
References: <150097502966.6397.351311629210845503.malonedeb@gac.canonical.com>
	<b64e52eb-47ca-7264-0e09-1dc9b3794e92@redhat.com>
	<87fudkefdw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87fudkefdw.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1706296] [NEW] Booting NT 4 disk causes
 /home/rjones/d/qemu/cpus.c:1580:qemu_mutex_lock_iothread: assertion failed:
 (!qemu_mutex_iothread_locked())
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Bug 1706296 <1706296@bugs.launchpad.net>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, KONRAD Frederic <fred.konrad@greensocs.com>

* Alex Benn=E9e (alex.bennee@linaro.org) wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
> > On 25.07.2017 11:30, Richard Jones wrote:
> >> ERROR:/home/rjones/d/qemu/cpus.c:1580:qemu_mutex_lock_iothread: asse=
rtion failed: (!qemu_mutex_iothread_locked())
> >> Aborted (core dumped)
> >>
> >> The stack trace in the failing thread is:
> >>
> >> Thread 4 (Thread 0x7fffb0418700 (LWP 21979)):
> >> #0  0x00007fffdd89b64b in raise () at /lib64/libc.so.6
> >> #1  0x00007fffdd89d450 in abort () at /lib64/libc.so.6
> >> #2  0x00007fffdff8c75d in g_assertion_message () at /lib64/libglib-2=
.0.so.0
> >> #3  0x00007fffdff8c7ea in g_assertion_message_expr ()
> >>     at /lib64/libglib-2.0.so.0
> >> #4  0x00005555557a7d00 in qemu_mutex_lock_iothread ()
> >>     at /home/rjones/d/qemu/cpus.c:1580
> >> #5  0x00005555557cb429 in io_writex (env=3Denv@entry=3D0x55555675140=
0, iotlbentry=3D0x55555675b678,
> >>     iotlbentry@entry=3D0x5aaaaae40c918, val=3Dval@entry=3D8, addr=3D=
addr@entry=3D2148532220, retaddr=3D0, retaddr@entry=3D93825011136120, siz=
e=3Dsize@entry=3D4)
> >>     at /home/rjones/d/qemu/accel/tcg/cputlb.c:795
> >> #6  0x00005555557ce0f7 in io_writel (retaddr=3D93825011136120, addr=3D=
2148532220, val=3D8, index=3D255, mmu_idx=3D21845, env=3D0x555556751400)
> >>     at /home/rjones/d/qemu/softmmu_template.h:265
> >> #7  0x00005555557ce0f7 in helper_le_stl_mmu (env=3Denv@entry=3D0x555=
556751400, addr=3Daddr@entry=3D2148532220, val=3Dval@entry=3D8, oi=3D<opt=
imized out>, retaddr=3D93825011136120, retaddr@entry=3D0) at /home/rjones=
/d/qemu/softmmu_template.h:300
> >> #8  0x000055555587c0a4 in cpu_stl_kernel_ra (env=3D0x555556751400, p=
tr=3D2148532220, v=3D8, retaddr=3D0) at /home/rjones/d/qemu/include/exec/=
cpu_ldst_template.h:182
> >> #9  0x0000555555882610 in do_interrupt_protected (is_hw=3D<optimized
> >> out>, next_eip=3D<optimized out>, error_code=3D2, is_int=3D<optimize=
d out>,
> >> intno=3D<optimized out>, env=3D0x555556751400) at
> >> /home/rjones/d/qemu/target/i386/seg_helper.c:758
>=20
> Erm, what is happening here? I think the seg_helper is writing a stack
> frame but for some reason to io memory, triggering the BQL. This just
> seems weird.

addr=3D2148532220 doesn't seem fun; that's 800FFFFC maybe a missing mask
somewhere?
(or cpu in completely the wrong mode).

Dave

>=20
> >> #10 0x0000555555882610 in do_interrupt_all (cpu=3Dcpu@entry=3D0x5555=
56749170, intno=3D<optimized out>, is_int=3D<optimized out>, error_code=3D=
2, next_eip=3D<optimized out>, is_hw=3Dis_hw@entry=3D0) at /home/rjones/d=
/qemu/target/i386/seg_helper.c:1252
> >> #11 0x00005555558839d3 in x86_cpu_do_interrupt (cs=3D0x555556749170)
> >>     at /home/rjones/d/qemu/target/i386/seg_helper.c:1298
> >> #12 0x00005555557d2ccb in cpu_handle_exception (ret=3D<synthetic poi=
nter>, cpu=3D0x5555566a4590) at /home/rjones/d/qemu/accel/tcg/cpu-exec.c:=
465
> >> #13 0x00005555557d2ccb in cpu_exec (cpu=3Dcpu@entry=3D0x555556749170=
)
> >>     at /home/rjones/d/qemu/accel/tcg/cpu-exec.c:670
> >> #14 0x00005555557a855a in tcg_cpu_exec (cpu=3D0x555556749170)
> >>     at /home/rjones/d/qemu/cpus.c:1270
> >> #15 0x00005555557a855a in qemu_tcg_rr_cpu_thread_fn (arg=3D<optimize=
d out>)
> >>     at /home/rjones/d/qemu/cpus.c:1365
> >> #16 0x00007fffddc3d36d in start_thread () at /lib64/libpthread.so.0
> >> #17 0x00007fffdd975b9f in clone () at /lib64/libc.so.6
> >
> > Looks like the iothread lock is taken twice here, one time in
> > accel/tcg/cpu-exec.c around line 465 and one time in
> > accel/tcg/cputlb.c:795 again.
> >
> > If I've get that right, the locks have been added by this commit here=
:
> >
> >  8d04fb55dec381bc5105cb47f29d918e579e8cbd
> >  tcg: drop global lock during TCG code execution
> >
> > so this looks related to the MTTCG reworks that happened recently. I
> > hope one of the MTTCG gurus has some spare time to look at this...
>=20
> I think I really need an x86 guru to explain what just happened.
>=20
> --
> Alex Benn=E9e
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
