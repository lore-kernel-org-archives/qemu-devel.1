Received: from eggs.gnu.org ([2001:4830:134:3::10]:57694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cEItp-0000AX-F5
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:47:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cEItm-0001bd-CE
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:47:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cEItm-0001bZ-3s
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:47:22 -0500
Date: Tue, 6 Dec 2016 16:47:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20161206164716.GG2125@work-vm>
References: <20161202174015.GE15373@work-vm>
	<1480926783.28320.9.camel@redhat.com>
	<20161205094646.GA2508@work-vm>
	<62f28da2-a81b-e0f8-32b7-6e75f197750b@redhat.com>
	<1481007570.20373.3.camel@redhat.com>
	<20161206105344.GD2125@work-vm>
	<1481027841.20373.23.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481027841.20373.23.camel@redhat.com>
Subject: Re: [Qemu-devel] [Spice-devel] Postcopy+spice crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: uril@redhat.com, qemu-devel@nongnu.org, spice-devel <spice-devel@freedesktop.org>

* Gerd Hoffmann (kraxel@redhat.com) wrote:
>   Hi,
> 
> Yep, spice worker thread ...
> 
> > Thread 7 (Thread 0x7fbe7f9ff700 (LWP 22383)):
> > #0  0x00007fc0aa42f49d in read () from /lib64/libpthread.so.0
> > #1  0x00007fc0a8c36c01 in spice_backtrace_gstack () from /lib64/libspice-server.so.1
> > #2  0x00007fc0a8c3e4f7 in spice_logv () from /lib64/libspice-server.so.1
> > #3  0x00007fc0a8c3e655 in spice_log () from /lib64/libspice-server.so.1
> > #4  0x00007fc0a8bfc6de in get_virt () from /lib64/libspice-server.so.1
> > #5  0x00007fc0a8bfcb73 in red_get_data_chunks_ptr () from /lib64/libspice-server.so.1
> > #6  0x00007fc0a8bff3fa in red_get_cursor_cmd () from /lib64/libspice-server.so.1
> > #7  0x00007fc0a8c0fd79 in handle_dev_loadvm_commands () from /lib64/libspice-server.so.1
> > #8  0x00007fc0a8bf9523 in dispatcher_handle_recv_read () from /lib64/libspice-server.so.1
> > #9  0x00007fc0a8c1d5a5 in red_worker_main () from /lib64/libspice-server.so.1
> > #10 0x00007fc0aa428dc5 in start_thread () from /lib64/libpthread.so.0
> > #11 0x00007fc0a61786ed in clone () from /lib64/libc.so.6
> 
> ... busy processing post_load request from main thread ...
> 
> > Thread 1 (Thread 0x7fc0aead5c40 (LWP 22376)):
> > #0  0x00007fc0aa42f49d in read () from /lib64/libpthread.so.0
> > #1  0x00007fc0a8bf9264 in read_safe () from /lib64/libspice-server.so.1
> > #2  0x00007fc0a8bf9717 in dispatcher_send_message () from /lib64/libspice-server.so.1
> > #3  0x00007fc0a8bfa0c2 in red_dispatcher_loadvm_commands () from /lib64/libspice-server.so.1
> > #4  0x000055646556c03d in qxl_spice_loadvm_commands (qxl=qxl@entry=0x55646755b8c0, ext=ext@entry=0x556467a895a0, count=2) at /root/git/qemu/hw/display/qxl.c:219
> > #5  0x000055646556d15f in qxl_post_load (opaque=0x55646755b8c0, version=<optimized out>) at /root/git/qemu/hw/display/qxl.c:2212
> > #6  0x000055646562f1b8 in vmstate_load_state (f=f@entry=0x5564666347d0, vmsd=<optimized out>, opaque=0x55646755b8c0, version_id=version_id@entry=21) at /root/git/qemu/migration/vmstate.c:151
> > #7  0x000055646540f4a1 in vmstate_load (f=0x5564666347d0, se=0x5564676f90a0, version_id=21) at /root/git/qemu/migration/savevm.c:690
> > #8  0x000055646540f6db in qemu_loadvm_section_start_full (f=f@entry=0x5564666347d0, mis=mis@entry=0x556466c93f10) at /root/git/qemu/migration/savevm.c:1843
> > #9  0x000055646540f9ac in qemu_loadvm_state_main (f=f@entry=0x5564666347d0, mis=mis@entry=0x556466c93f10) at /root/git/qemu/migration/savevm.c:1900
> > #10 0x000055646540fd8f in loadvm_handle_cmd_packaged (mis=0x556466c93f10) at /root/git/qemu/migration/savevm.c:1660
> > #11 loadvm_process_command (f=0x556467e45740) at /root/git/qemu/migration/savevm.c:1723
> > #12 qemu_loadvm_state_main (f=f@entry=0x556467e45740, mis=mis@entry=0x556466c93f10) at /root/git/qemu/migration/savevm.c:1913
> > #13 0x0000556465412546 in qemu_loadvm_state (f=f@entry=0x556467e45740) at /root/git/qemu/migration/savevm.c:1973
> > #14 0x000055646562b4e8 in process_incoming_migration_co (opaque=0x556467e45740) at /root/git/qemu/migration/migration.c:394
> > #15 0x0000556465746ada in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at /root/git/qemu/util/coroutine-ucontext.c:79
> > #16 0x00007fc0a60c7cf0 in ?? () from /lib64/libc.so.6
> > #17 0x00007ffe14885180 in ?? ()
> > #18 0x0000000000000000 in ?? ()
> 
> > It should; the device memory is just a RAMBlock that's migrated, so if it's
> > not arrived yet from the source the qxl code will block until postcopy
> > drags it across; assuming that is that the qxl code on the source isn't
> > still trying to write to it's copy at the same time, which at this
> > point it shouldn't.
> 
> Seems it happens while restoring the cursor,
> does this patch make a difference?

Hmm, my test case doesn't want to fail today, so unfortunately I can't tell.
(I've done at least 10 postcopies)

Dave

> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -2238,12 +2238,14 @@ static int qxl_post_load(void *opaque, int
> version)
>              cmds[out].group_id = MEMSLOT_GROUP_GUEST;
>              out++;
>          }
> +#if 0
>          if (d->guest_cursor) {
>              cmds[out].cmd.data = d->guest_cursor;
>              cmds[out].cmd.type = QXL_CMD_CURSOR;
>              cmds[out].group_id = MEMSLOT_GROUP_GUEST;
>              out++;
>          }
> +#endif
>          qxl_spice_loadvm_commands(d, cmds, out);
>          g_free(cmds);
>          if (d->guest_monitors_config) {
> 
> cheers,
>   Gerd
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
