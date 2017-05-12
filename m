Received: from eggs.gnu.org ([2001:4830:134:3::10]:52891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1d9JJr-0003Nt-QE
	for qemu-devel@nongnu.org; Fri, 12 May 2017 18:45:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1d9JJp-0002Uv-Ta
	for qemu-devel@nongnu.org; Fri, 12 May 2017 18:45:55 -0400
Date: Sat, 13 May 2017 00:45:36 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170512224536.6zp3z4vs7mma5akx@eukaryote>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tduxusamorlryhtk"
Content-Disposition: inline
Subject: [Qemu-devel] QEMU seg-fault with intermediate image streaming --
 bdrv_reopen() in stream_start()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berto@igalia.com, kwolf@redhat.com, qemu-block@nongnu.org


--tduxusamorlryhtk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reproducer
----------

[Disk image chain: disk1.qcow2 <- b.qcow2 <- c.qcow2]

$ qemu-system-x86_64 -display none -nodefconfig -nodefaults \
    -m 512 -device virtio-scsi-pci,id=scsi \
    -device virtio-serial-pci  \
    -drive driver=qcow2,file.driver=file,file.filename=./disk1.qcow2,id=virtio0 \
    -monitor stdio -qmp unix:./qmp-sock,server,nowait

Create two overlays (I used `qmp-shell`):

    (QEMU) blockdev-snapshot-sync device=virtio0 snapshot-file=b.qcow2
    (QEMU) blockdev-snapshot-sync device=virtio0 snapshot-file=c.qcow2


[Figure out the (format) 'node-name' of 'b.qcow2', from the output of
QMP `query-named-block-nodes` so that it can be supplied to the 'device'
parameter]

Try to perform intermediate streaming (pull clusters from 'disk1.qcow2'
into 'b.qcow2':

    (QEMU) block-stream device=#block832 base=disk1.qcow2


Result
------

QEMU crashes with SIGSEGV:

[...]
Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x000055555593d8f7 in stream_start (job_id=0x0, bs=0x555558646e20, base=0x5555568548c0, backing_file_str=0x55555863d710 "disk1.qcow2", speed=0, on_error=BLOCKDEV_ON_ERROR_REPORT, 
    errp=0x7fffffffbcf8) at /home/kashyapc/tinker-space/qemu/block/stream.c:283
283             bdrv_reopen(bs, s->bs_flags, NULL);
[...]

* * *

NOTE: Of course, streaming to active layer works.


Stack traces
------------

I've attached the stack traces from GDB to this email.


Version
-------

v2.9.0-304-gca7305b


`git blame` seems to point to this commit:
------------------------------------------------------------------------
commit a170a91fd3eab6155da39e740381867e80bcc93e
[...]
    stream: Use real permissions in streaming block job
    
    The correct permissions are relatively obvious here (and explained in
    code comments). For intermediate streaming, we need to reopen the top
    node read-write before creating the job now because the permissions
    system catches attempts to get the BLK_PERM_WRITE_UNCHANGED permission
    on a read-only node.
------------------------------------------------------------------------

-- 
/kashyap

--tduxusamorlryhtk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gdb-output-of-intermediate-block-stream-crash.txt"

(gdb) thread apply all bt full

Thread 4 (Thread 0x7fffc4c8e700 (LWP 730)):
#0  0x00007fffdccb4bd0 in pthread_cond_wait@@GLIBC_2.3.2 () at /lib64/libpthread.so.0
#1  0x0000555555c83e8f in qemu_cond_wait (cond=0x5555568b9980, mutex=0x555556323fc0 <qemu_global_mutex>) at /home/kashyapc/tinker-space/qemu/util/qemu-thread-posix.c:133
        err = 21845
        __func__ = "qemu_cond_wait"
#2  0x00005555557a74c0 in qemu_tcg_wait_io_event (cpu=0x555556886dc0) at /home/kashyapc/tinker-space/qemu/cpus.c:1074
#3  0x00005555557a7d10 in qemu_tcg_rr_cpu_thread_fn (arg=0x555556886dc0) at /home/kashyapc/tinker-space/qemu/cpus.c:1385
        cpu = 0x0
#4  0x00007fffdccaf5ca in start_thread () at /lib64/libpthread.so.0
#5  0x00007fffdc9e90ed in clone () at /lib64/libc.so.6

Thread 2 (Thread 0x7fffd0b01700 (LWP 728)):
#0  0x00007fffdc9e3239 in syscall () at /lib64/libc.so.6
#1  0x0000555555c8421d in qemu_futex_wait (f=0x555556757184 <rcu_call_ready_event>, val=4294967295) at /home/kashyapc/tinker-space/qemu/include/qemu/futex.h:26
#2  0x0000555555c84320 in qemu_event_wait (ev=0x555556757184 <rcu_call_ready_event>) at /home/kashyapc/tinker-space/qemu/util/qemu-thread-posix.c:399
        value = 1
#3  0x0000555555c9b7fd in call_rcu_thread (opaque=0x0) at /home/kashyapc/tinker-space/qemu/util/rcu.c:249
        tries = 0
        n = 0
        node = 0x7fff941f9c10
#4  0x00007fffdccaf5ca in start_thread () at /lib64/libpthread.so.0
#5  0x00007fffdc9e90ed in clone () at /lib64/libc.so.6

Thread 1 (Thread 0x7ffff7ee0f80 (LWP 724)):
#0  0x000055555593d8f7 in stream_start (job_id=0x0, bs=0x555558646e20, base=0x5555568548c0, backing_file_str=0x55555863d710 "disk1.qcow2", speed=0, on_error=BLOCKDEV_ON_ERROR_REPORT, errp=0x
7fffffffbcf8) at /home/kashyapc/tinker-space/qemu/block/stream.c:283
        s = 0x0
        iter = 0xe5685e050
        orig_bs_flags = 8192
---Type <return> to continue, or q <return> to quit---
#1  0x00005555558f8acf in qmp_block_stream (has_job_id=false, job_id=0x0, device=0x5555586282f0 "#block830", has_base=true, base=0x55555863d710 "disk1.qcow2", has_base_node=false, base_node=
0x0, has_backing_file=false, backing_file=0x0, has_speed=false, speed=0, has_on_error=false, on_error=BLOCKDEV_ON_ERROR_REPORT, errp=0x7fffffffbda0)
    at /home/kashyapc/tinker-space/qemu/blockdev.c:3033
        bs = 0x555558646e20
        iter = 0x5555568548c0
        base_bs = 0x5555568548c0
        aio_context = 0x55555683cb40
        local_err = 0x55555684a230
        base_name = 0x55555863d710 "disk1.qcow2"
        __func__ = "qmp_block_stream"
        __PRETTY_FUNCTION__ = "qmp_block_stream"
#2  0x000055555590f6e8 in qmp_marshal_block_stream (args=0x55555689ddd0, ret=0x7fffffffbe90, errp=0x7fffffffbe88) at qmp-marshal.c:488
        err = 0x0
        v = 0x55555779cd80
        arg = 
          {has_job_id = false, job_id = 0x0, device = 0x5555586282f0 "#block830", has_base = true, base = 0x55555863d710 "disk1.qcow2", has_base_node = false, base_node = 0x0, has_backing_fi
le = false, backing_file = 0x0, has_speed = false, speed = 0, has_on_error = false, on_error = BLOCKDEV_ON_ERROR_REPORT}
#3  0x0000555555c6ff23 in do_qmp_dispatch (cmds=0x5555563240a0 <qmp_commands>, request=0x555557b09460, errp=0x7fffffffbee0) at /home/kashyapc/tinker-space/qemu/qapi/qmp-dispatch.c:104
        local_err = 0x0
        command = 0x555558640790 "block-stream"
        args = 0x55555689ddd0
        dict = 0x555557b09460
        cmd = 0x5555567d7310
        ret = 0x0
        __func__ = "do_qmp_dispatch"
#4  0x0000555555c7005b in qmp_dispatch (cmds=0x5555563240a0 <qmp_commands>, request=0x555557b09460) at /home/kashyapc/tinker-space/qemu/qapi/qmp-dispatch.c:131
        err = 0x0
        ret = 0x555557b09460
        rsp = 0x5555586282f0
#5  0x00005555557b22f2 in handle_qmp_command (parser=0x55555684f4e0, tokens=0x55555683c740) at /home/kashyapc/tinker-space/qemu/monitor.c:3833
---Type <return> to continue, or q <return> to quit---
        req = 0x555557b09460
        rsp = 0x0
        id = 0x0
        qdict = 0x555557b09460
        mon = 0x55555684f460
        err = 0x0
        __func__ = "handle_qmp_command"
#6  0x0000555555c7753b in json_message_process_token (lexer=0x55555684f4e8, input=0x55555683c3a0, type=JSON_RCURLY, x=506, y=0)
    at /home/kashyapc/tinker-space/qemu/qobject/json-streamer.c:105
        parser = 0x55555684f4e0
        token = 0x55555863d710
        tokens = 0x55555683c740
#7  0x0000555555ca25ff in json_lexer_feed_char (lexer=0x55555684f4e8, ch=125 '}', flush=false) at /home/kashyapc/tinker-space/qemu/qobject/json-lexer.c:319
        char_consumed = 1
        new_state = 101
        __PRETTY_FUNCTION__ = "json_lexer_feed_char"
#8  0x0000555555ca2747 in json_lexer_feed (lexer=0x55555684f4e8, buffer=0x7fffffffc160 "}", size=1) at /home/kashyapc/tinker-space/qemu/qobject/json-lexer.c:369
        err = 0
        i = 0
#9  0x0000555555c775e2 in json_message_parser_feed (parser=0x55555684f4e0, buffer=0x7fffffffc160 "}", size=1) at /home/kashyapc/tinker-space/qemu/qobject/json-streamer.c:124        [49/3116]
#10 0x00005555557b24ba in monitor_qmp_read (opaque=0x55555684f460, buf=0x7fffffffc160 "}", size=1) at /home/kashyapc/tinker-space/qemu/monitor.c:3876
        old_mon = 0x0
#11 0x0000555555c0e439 in qemu_chr_be_write_impl (s=0x55555684ad60, buf=0x7fffffffc160 "}", len=1) at /home/kashyapc/tinker-space/qemu/chardev/char.c:284
        be = 0x55555684f460
#12 0x0000555555c0e498 in qemu_chr_be_write (s=0x55555684ad60, buf=0x7fffffffc160 "}", len=1) at /home/kashyapc/tinker-space/qemu/chardev/char.c:296
#13 0x0000555555c16309 in tcp_chr_read (chan=0x555558635690, cond=G_IO_IN, opaque=0x55555684ad60) at /home/kashyapc/tinker-space/qemu/chardev/char-socket.c:414
        chr = 0x55555684ad60
        __func__ = "tcp_chr_read"
        s = 0x55555684ad60
        buf = "}\000\331UUU\000\000 \000\000\000\060\000\000\000@\302\377\377\377\177\000\000\200\301\377\377\377\177\000\000\000\000\374\377", '\000' <repeats 16 times>, "\001\000\000\000\b
---Type <return> to continue, or q <return> to quit---
\000\000\000\060\000\000\000@\310\377\377\377\177\000\000\200\307\377\377\377\177\000\000\320\326\377\377\377\177", '\000' <repeats 18 times>, "\340\316\026\337\377\177\000\000\000\000\000\0
00\001\000\000\000\020\071\236VUU\000\000\000\302\377\377\377\177\000\000\323>\307UUU\000\000\006\000\000\000\000\000\000\000\260\244yXUU\000\000\060\302\377\377\377\177\000\000;?\307UUU\000
\000\320\302\377\377\377\177\000\000\260\244yXUU\000\000s\000\000\000s\000\000\000"...
        len = 1
        size = 1
#14 0x0000555555c2d72c in qio_channel_fd_source_dispatch (source=0x55555684b3d0, callback=0x555555c16167 <tcp_chr_read>, user_data=0x55555684ad60)
    at /home/kashyapc/tinker-space/qemu/io/channel-watch.c:84
        func = 0x555555c16167 <tcp_chr_read>
        ssource = 0x55555684b3d0
#15 0x00007fffdf1676ba in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
#16 0x0000555555c7f7c7 in glib_pollfds_poll () at /home/kashyapc/tinker-space/qemu/util/main-loop.c:213
        context = 0x55555683cec0
        pfds = 0x5555587982d0
#17 0x0000555555c7f8c3 in os_host_main_loop_wait (timeout=363065576) at /home/kashyapc/tinker-space/qemu/util/main-loop.c:261
        context = 0x55555683cec0
        ret = 2
        spin_counter = 0
#18 0x0000555555c7f97c in main_loop_wait (nonblocking=0) at /home/kashyapc/tinker-space/qemu/util/main-loop.c:517
        ret = 21845
        timeout = 4294967295
        timeout_ns = 363065576
#19 0x000055555590456e in main_loop () at /home/kashyapc/tinker-space/qemu/vl.c:1899
#20 0x000055555590c35e in main (argc=17, argv=0x7fffffffd6d8, envp=0x7fffffffd768) at /home/kashyapc/tinker-space/qemu/vl.c:4717
        i = 0
        snapshot = 0
        linux_boot = 0
        initrd_filename = 0x0
        kernel_filename = 0x0
        kernel_cmdline = 0x555555cdfae8 ""
        boot_order = 0x555555cc61ff "cad"
---Type <return> to continue, or q <return> to quit---
        boot_once = 0x0
        ds = 0x5555581f37b0
        cyls = 0
        heads = 0
        secs = 0
        translation = 0
        opts = 0x0
        machine_opts = 0x55555683bc80
        hda_opts = 0x0
        icount_opts = 0x0
        accel_opts = 0x0
        olist = 0x567a5fa0
        optind = 17
        optarg = 0x7fffffffdc12 "unix:./qmp-sock,server,nowait"
        loadvm = 0x0
        machine_class = 0x555556838050
        cpu_model = 0x0
        vga_model = 0x0
        qtest_chrdev = 0x0
        qtest_log = 0x0
        pid_file = 0x0
        incoming = 0x0
        defconfig = false
        userconfig = true
        nographic = false
        display_type = DT_NONE
        display_remote = 0
        log_mask = 0x0
        log_file = 0x0
        trace_file = 0x0
---Type <return> to continue, or q <return> to quit---
        maxram_size = 536870912
        ram_slots = 0
        vmstate_dump_file = 0x0
        main_loop_err = 0x0
        err = 0x0
        list_data_dirs = false
        bdo_queue = {sqh_first = 0x0, sqh_last = 0x7fffffffd4c0}
        __func__ = "main"


--tduxusamorlryhtk--
