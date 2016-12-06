Received: from eggs.gnu.org ([2001:4830:134:3::10]:33978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cEEzx-0001le-DA
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:37:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cEEzu-0003Z8-6G
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:37:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cEEzt-0003Yi-UF
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:37:26 -0500
Message-ID: <1481027841.20373.23.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 06 Dec 2016 13:37:21 +0100
In-Reply-To: <20161206105344.GD2125@work-vm>
References: <20161202174015.GE15373@work-vm>
	<1480926783.28320.9.camel@redhat.com> <20161205094646.GA2508@work-vm>
	<62f28da2-a81b-e0f8-32b7-6e75f197750b@redhat.com>
	<1481007570.20373.3.camel@redhat.com> <20161206105344.GD2125@work-vm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [Spice-devel] Postcopy+spice crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: uril@redhat.com, qemu-devel@nongnu.org, spice-devel <spice-devel@freedesktop.org>

  Hi,

Yep, spice worker thread ...

> Thread 7 (Thread 0x7fbe7f9ff700 (LWP 22383)):
> #0  0x00007fc0aa42f49d in read () from /lib64/libpthread.so.0
> #1  0x00007fc0a8c36c01 in spice_backtrace_gstack () from /lib64/libspice-=
server.so.1
> #2  0x00007fc0a8c3e4f7 in spice_logv () from /lib64/libspice-server.so.1
> #3  0x00007fc0a8c3e655 in spice_log () from /lib64/libspice-server.so.1
> #4  0x00007fc0a8bfc6de in get_virt () from /lib64/libspice-server.so.1
> #5  0x00007fc0a8bfcb73 in red_get_data_chunks_ptr () from /lib64/libspice=
-server.so.1
> #6  0x00007fc0a8bff3fa in red_get_cursor_cmd () from /lib64/libspice-serv=
er.so.1
> #7  0x00007fc0a8c0fd79 in handle_dev_loadvm_commands () from /lib64/libsp=
ice-server.so.1
> #8  0x00007fc0a8bf9523 in dispatcher_handle_recv_read () from /lib64/libs=
pice-server.so.1
> #9  0x00007fc0a8c1d5a5 in red_worker_main () from /lib64/libspice-server.=
so.1
> #10 0x00007fc0aa428dc5 in start_thread () from /lib64/libpthread.so.0
> #11 0x00007fc0a61786ed in clone () from /lib64/libc.so.6

... busy processing post_load request from main thread ...

> Thread 1 (Thread 0x7fc0aead5c40 (LWP 22376)):
> #0  0x00007fc0aa42f49d in read () from /lib64/libpthread.so.0
> #1  0x00007fc0a8bf9264 in read_safe () from /lib64/libspice-server.so.1
> #2  0x00007fc0a8bf9717 in dispatcher_send_message () from /lib64/libspice=
-server.so.1
> #3  0x00007fc0a8bfa0c2 in red_dispatcher_loadvm_commands () from /lib64/l=
ibspice-server.so.1
> #4  0x000055646556c03d in qxl_spice_loadvm_commands (qxl=3Dqxl@entry=3D0x=
55646755b8c0, ext=3Dext@entry=3D0x556467a895a0, count=3D2) at /root/git/qem=
u/hw/display/qxl.c:219
> #5  0x000055646556d15f in qxl_post_load (opaque=3D0x55646755b8c0, version=
=3D<optimized out>) at /root/git/qemu/hw/display/qxl.c:2212
> #6  0x000055646562f1b8 in vmstate_load_state (f=3Df@entry=3D0x5564666347d=
0, vmsd=3D<optimized out>, opaque=3D0x55646755b8c0, version_id=3Dversion_id=
@entry=3D21) at /root/git/qemu/migration/vmstate.c:151
> #7  0x000055646540f4a1 in vmstate_load (f=3D0x5564666347d0, se=3D0x556467=
6f90a0, version_id=3D21) at /root/git/qemu/migration/savevm.c:690
> #8  0x000055646540f6db in qemu_loadvm_section_start_full (f=3Df@entry=3D0=
x5564666347d0, mis=3Dmis@entry=3D0x556466c93f10) at /root/git/qemu/migratio=
n/savevm.c:1843
> #9  0x000055646540f9ac in qemu_loadvm_state_main (f=3Df@entry=3D0x5564666=
347d0, mis=3Dmis@entry=3D0x556466c93f10) at /root/git/qemu/migration/savevm=
.c:1900
> #10 0x000055646540fd8f in loadvm_handle_cmd_packaged (mis=3D0x556466c93f1=
0) at /root/git/qemu/migration/savevm.c:1660
> #11 loadvm_process_command (f=3D0x556467e45740) at /root/git/qemu/migrati=
on/savevm.c:1723
> #12 qemu_loadvm_state_main (f=3Df@entry=3D0x556467e45740, mis=3Dmis@entry=
=3D0x556466c93f10) at /root/git/qemu/migration/savevm.c:1913
> #13 0x0000556465412546 in qemu_loadvm_state (f=3Df@entry=3D0x556467e45740=
) at /root/git/qemu/migration/savevm.c:1973
> #14 0x000055646562b4e8 in process_incoming_migration_co (opaque=3D0x55646=
7e45740) at /root/git/qemu/migration/migration.c:394
> #15 0x0000556465746ada in coroutine_trampoline (i0=3D<optimized out>, i1=
=3D<optimized out>) at /root/git/qemu/util/coroutine-ucontext.c:79
> #16 0x00007fc0a60c7cf0 in ?? () from /lib64/libc.so.6
> #17 0x00007ffe14885180 in ?? ()
> #18 0x0000000000000000 in ?? ()

> It should; the device memory is just a RAMBlock that's migrated, so if it=
's
> not arrived yet from the source the qxl code will block until postcopy
> drags it across; assuming that is that the qxl code on the source isn't
> still trying to write to it's copy at the same time, which at this
> point it shouldn't.

Seems it happens while restoring the cursor,
does this patch make a difference?

--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2238,12 +2238,14 @@ static int qxl_post_load(void *opaque, int
version)
             cmds[out].group_id =3D MEMSLOT_GROUP_GUEST;
             out++;
         }
+#if 0
         if (d->guest_cursor) {
             cmds[out].cmd.data =3D d->guest_cursor;
             cmds[out].cmd.type =3D QXL_CMD_CURSOR;
             cmds[out].group_id =3D MEMSLOT_GROUP_GUEST;
             out++;
         }
+#endif
         qxl_spice_loadvm_commands(d, cmds, out);
         g_free(cmds);
         if (d->guest_monitors_config) {

cheers,
  Gerd
