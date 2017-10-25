Received: from eggs.gnu.org ([2001:4830:134:3::10]:38107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7HnD-0004mJ-Fa
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7Hn5-0005Zm-4w
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:16:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:56576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7Hn4-0005Yh-N3
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:15:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7Hn3-0005Uf-V7
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 09:15:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E4CD92E8047
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 09:15:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Oct 2017 09:10:46 -0000
From: "R.Nageswara Sastry" <nasastry@in.ibm.com>
Reply-To: Bug 1727250 <1727250@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150892252192.18283.8177817026945520523.malonedeb@chaenomeles.canonical.com>
Message-Id: <150892264644.17673.6625662376647428867.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1727250] Re: qemu-io-test 147 segfaults when
 configured with gcov
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

from dmesg:
[81791.481930] qemu-system-ppc[28640]: unhandled signal 11 at 0000000000000=
004 nip 00007fff9f82f7d4 lr 0000000010e182fc code 30001
[81791.649081] qemu-system-ppc[28651]: unhandled signal 11 at 0000000000000=
004 nip 00007fffbd94f7d4 lr 0000000010e182fc code 30001
[81791.817591] qemu-system-ppc[28660]: unhandled signal 11 at 0000000000000=
004 nip 00007fff8c1ff7d4 lr 0000000010e182fc code 30001
[81791.994442] qemu-system-ppc[28669]: unhandled signal 11 at 0000000000000=
004 nip 00007fffa6f1f7d4 lr 0000000010e182fc code 30001
[81792.121339] qemu-system-ppc[28678]: unhandled signal 11 at 0000000000000=
004 nip 00007fffb9abf7d4 lr 0000000010e182fc code 30001
[81792.205728] qemu-system-ppc[28687]: unhandled signal 11 at 0000000000000=
004 nip 00007fff8dccf7d4 lr 0000000010e182fc code 30001


from gdb:
(gdb) bt
#0  0x00007fffa4a3f7d4 in __strcmp_power9 () from /lib64/libc.so.6
#1  0x0000000010e182fc in find_desc_by_name (desc=3D0x11304690, name=3D0x3d=
fce1b0 "server.str") at util/qemu-option.c:166
#2  0x0000000010e1d814 in qemu_opts_absorb_qdict (opts=3D0x3e25b1c0, qdict=
=3D0x3e0bbd40, errp=3D0x7fffd055c678) at util/qemu-option.c:1026
#3  0x0000000010c5b2d0 in nbd_open (bs=3D0x3dfcaee0, options=3D0x3e0bbd40, =
flags=3D24578, errp=3D0x7fffd055c760) at block/nbd.c:406
#4  0x0000000010b454d4 in bdrv_open_driver (bs=3D0x3dfcaee0, drv=3D0x113050=
10 <bdrv_nbd_unix>, node_name=3D0x0, options=3D0x3e0bbd40, open_flags=3D245=
78, errp=3D0x7fffd055c930) at block.c:1135
#5  0x0000000010b46af0 in bdrv_open_common (bs=3D0x3dfcaee0, file=3D0x0, op=
tions=3D0x3e0bbd40, errp=3D0x7fffd055c930) at block.c:1395
#6  0x0000000010b4ced4 in bdrv_open_inherit (filename=3D0x0, reference=3D0x=
0, options=3D0x3e0bbd40, flags=3D40962, parent=3D0x3dfc4be0, child_role=3D0=
x11004bd8 <child_file>, errp=3D0x7fffd055cb30) at block.c:2615
#7  0x0000000010b4b60c in bdrv_open_child_bs (filename=3D0x0, options=3D0x3=
dfc8ea0, bdref_key=3D0x11005870 "file", parent=3D0x3dfc4be0, child_role=3D0=
x11004bd8 <child_file>, allow_none=3Dtrue, errp=3D0x7fffd055cb30) at block.=
c:2314
#8  0x0000000010b4c9ac in bdrv_open_inherit (filename=3D0x0, reference=3D0x=
0, options=3D0x3dfc8ea0, flags=3D8194, parent=3D0x0, child_role=3D0x0, errp=
=3D0x7fffd055cd48) at block.c:2566
#9  0x0000000010b4d6f8 in bdrv_open (filename=3D0x0, reference=3D0x0, optio=
ns=3D0x3e261380, flags=3D0, errp=3D0x7fffd055cd48) at block.c:2697
#10 0x00000000105a4684 in bds_tree_init (bs_opts=3D0x3e261380, errp=3D0x7ff=
fd055cd48) at blockdev.c:652
#11 0x00000000105b5c9c in qmp_blockdev_add (options=3D0x7fffd055cd58, errp=
=3D0x7fffd055cd48) at blockdev.c:3920
#12 0x00000000105eea88 in qmp_marshal_blockdev_add (args=3D0x3e25e320, ret=
=3D0x7fffd055cec0, errp=3D0x7fffd055ceb8) at qmp-marshal.c:616
#13 0x0000000010db4de0 in do_qmp_dispatch (cmds=3D0x1136b198 <qmp_commands>=
, request=3D0x3e25d300, errp=3D0x7fffd055cf30) at qapi/qmp-dispatch.c:104
#14 0x0000000010db518c in qmp_dispatch (cmds=3D0x1136b198 <qmp_commands>, r=
equest=3D0x3e25d300) at qapi/qmp-dispatch.c:131
#15 0x00000000100c9470 in handle_qmp_command (parser=3D0x3dfd3350, tokens=
=3D0x3dfbef40) at /home/nasastry/qemu/monitor.c:3854
#16 0x0000000010dc8bcc in json_message_process_token (lexer=3D0x3dfd3358, i=
nput=3D0x3dfbdc80, type=3DJSON_RCURLY, x=3D273, y=3D0) at qobject/json-stre=
amer.c:105
#17 0x0000000010e3dc98 in json_lexer_feed_char (lexer=3D0x3dfd3358, ch=3D12=
5 '}', flush=3Dfalse) at qobject/json-lexer.c:323
#18 0x0000000010e3dfe0 in json_lexer_feed (lexer=3D0x3dfd3358, buffer=3D0x7=
fffd055d2f8 "}", size=3D1) at qobject/json-lexer.c:373
#19 0x0000000010dc8d6c in json_message_parser_feed (parser=3D0x3dfd3350, bu=
ffer=3D0x7fffd055d2f8 "}", size=3D1) at qobject/json-streamer.c:124
#20 0x00000000100c99ac in monitor_qmp_read (opaque=3D0x3dfd32c0, buf=3D0x7f=
ffd055d2f8 "}", size=3D1) at /home/nasastry/qemu/monitor.c:3896
#21 0x0000000010ca9430 in qemu_chr_be_write_impl (s=3D0x3dfce650, buf=3D0x7=
fffd055d2f8 "}", len=3D1) at chardev/char.c:167
#22 0x0000000010ca9594 in qemu_chr_be_write (s=3D0x3dfce650, buf=3D0x7fffd0=
55d2f8 "}", len=3D1) at chardev/char.c:179
#23 0x0000000010cbf154 in tcp_chr_read (chan=3D0x3dfd2190, cond=3DG_IO_IN, =
opaque=3D0x3dfce650) at chardev/char-socket.c:440
#24 0x0000000010cf9b1c in qio_channel_fd_source_dispatch (source=3D0x3e2594=
70, callback=3D0x10cbee50 <tcp_chr_read>, user_data=3D0x3dfce650) at io/cha=
nnel-watch.c:84
#25 0x00007fffa4f13ab0 in g_main_context_dispatch () from /lib64/libglib-2.=
0.so.0
#26 0x0000000010ddf918 in glib_pollfds_poll () at util/main-loop.c:214
#27 0x0000000010ddfcc8 in os_host_main_loop_wait (timeout=3D-1) at util/mai=
n-loop.c:261
#28 0x0000000010ddfeec in main_loop_wait (nonblocking=3D0) at util/main-loo=
p.c:515
#29 0x00000000105d0afc in main_loop () at vl.c:1995
#30 0x00000000105e5cc4 in main (argc=3D16, argv=3D0x7fffd055ed08, envp=3D0x=
7fffd055ed90) at vl.c:4899
(gdb) bt full
#0  0x00007fffa4a3f7d4 in __strcmp_power9 () from /lib64/libc.so.6
No symbol table info available.
#1  0x0000000010e182fc in find_desc_by_name (desc=3D0x11304690, name=3D0x3d=
fce1b0 "server.str") at util/qemu-option.c:166
        i =3D 7
#2  0x0000000010e1d814 in qemu_opts_absorb_qdict (opts=3D0x3e25b1c0, qdict=
=3D0x3e0bbd40, errp=3D0x7fffd055c678) at util/qemu-option.c:1026
        local_err =3D 0x0
        state =3D {opts =3D 0x3e25b1c0, errp =3D 0x7fffd055c5b0}
        entry =3D 0x3dfce180
        next =3D 0x3dfce220
#3  0x0000000010c5b2d0 in nbd_open (bs=3D0x3dfcaee0, options=3D0x3e0bbd40, =
flags=3D24578, errp=3D0x7fffd055c760) at block/nbd.c:406
        s =3D 0x3e262d70
        opts =3D 0x3e25b1c0
        local_err =3D 0x0
        sioc =3D 0x0
        tlscreds =3D 0x0
        hostname =3D 0x0
        ret =3D -22
        __func__ =3D "nbd_open"
#4  0x0000000010b454d4 in bdrv_open_driver (bs=3D0x3dfcaee0, drv=3D0x113050=
10 <bdrv_nbd_unix>, node_name=3D0x0, options=3D0x3e0bbd40, open_flags=3D245=
78, errp=3D0x7fffd055c930) at block.c:1135
        local_err =3D 0x0
        ret =3D 0
        __PRETTY_FUNCTION__ =3D "bdrv_open_driver"
        __func__ =3D "bdrv_open_driver"
#5  0x0000000010b46af0 in bdrv_open_common (bs=3D0x3dfcaee0, file=3D0x0, op=
tions=3D0x3e0bbd40, errp=3D0x7fffd055c930) at block.c:1395
        ret =3D 0
        open_flags =3D 24578
        filename =3D 0x0
        driver_name =3D 0x3e25b340 "nbd"
        node_name =3D 0x0
        discard =3D 0x3e25b460 "unmap"
        detect_zeroes =3D 0x0
        opts =3D 0x3e25b210
        drv =3D 0x11305010 <bdrv_nbd_unix>
        local_err =3D 0x0
        __PRETTY_FUNCTION__ =3D "bdrv_open_common"
        __func__ =3D "bdrv_open_common"
#6  0x0000000010b4ced4 in bdrv_open_inherit (filename=3D0x0, reference=3D0x=
0, options=3D0x3e0bbd40, flags=3D40962, parent=3D0x3dfc4be0, child_role=3D0=
x11004bd8 <child_file>, errp=3D0x7fffd055cb30) at block.c:2615
        ret =3D 0
        file =3D 0x0
        bs =3D 0x3dfcaee0
        drv =3D 0x11305010 <bdrv_nbd_unix>
        drvname =3D 0x3e0e28c0 "nbd"
        backing =3D 0x0
        local_err =3D 0x0
        snapshot_options =3D 0x0
        snapshot_flags =3D 0
        __PRETTY_FUNCTION__ =3D "bdrv_open_inherit"
        __func__ =3D "bdrv_open_inherit"
#7  0x0000000010b4b60c in bdrv_open_child_bs (filename=3D0x0, options=3D0x3=
dfc8ea0, bdref_key=3D0x11005870 "file", parent=3D0x3dfc4be0, child_role=3D0=
x11004bd8 <child_file>, allow_none=3Dtrue, errp=3D0x7fffd055cb30) at block.=
c:2314
        bs =3D 0x0
        image_options =3D 0x3dfc9ec0
        bdref_key_dot =3D 0x3e25ae10 "\220\065\036>"
        reference =3D 0x0
        __PRETTY_FUNCTION__ =3D "bdrv_open_child_bs"
        __func__ =3D "bdrv_open_child_bs"
#8  0x0000000010b4c9ac in bdrv_open_inherit (filename=3D0x0, reference=3D0x=
0, options=3D0x3dfc8ea0, flags=3D8194, parent=3D0x0, child_role=3D0x0, errp=
=3D0x7fffd055cd48) at block.c:2566
        file_bs =3D 0x7fffd055cba0
        ret =3D 0
        file =3D 0x0
        bs =3D 0x3dfc4be0
        drv =3D 0x112ebae0 <bdrv_raw>
        drvname =3D 0x3e0a78b0 "raw"
        backing =3D 0x0
        local_err =3D 0x0
        snapshot_options =3D 0x0
        snapshot_flags =3D 0
        __PRETTY_FUNCTION__ =3D "bdrv_open_inherit"
        __func__ =3D "bdrv_open_inherit"
---Type <return> to continue, or q <return> to quit---
#9  0x0000000010b4d6f8 in bdrv_open (filename=3D0x0, reference=3D0x0, optio=
ns=3D0x3e261380, flags=3D0, errp=3D0x7fffd055cd48) at block.c:2697
No locals.
#10 0x00000000105a4684 in bds_tree_init (bs_opts=3D0x3e261380, errp=3D0x7ff=
fd055cd48) at blockdev.c:652
        bdrv_flags =3D 0
#11 0x00000000105b5c9c in qmp_blockdev_add (options=3D0x7fffd055cd58, errp=
=3D0x7fffd055cd48) at blockdev.c:3920
        bs =3D 0x0
        obj =3D 0x3e261380
        v =3D 0x3e25a2d0
        qdict =3D 0x3e261380
        ent =3D 0x0
        local_err =3D 0x0
        __func__ =3D "qmp_blockdev_add"
#12 0x00000000105eea88 in qmp_marshal_blockdev_add (args=3D0x3e25e320, ret=
=3D0x7fffd055cec0, errp=3D0x7fffd055ceb8) at qmp-marshal.c:616
        err =3D 0x0
        v =3D 0x3e0a6e40
        arg =3D {driver =3D BLOCKDEV_DRIVER_RAW, has_node_name =3D true, no=
de_name =3D 0x3e25a930 "nbd-blockdev", has_discard =3D false, discard =3D B=
LOCKDEV_DISCARD_OPTIONS_IGNORE, has_cache =3D false, cache =3D 0x0, has_rea=
d_only =3D false,
          read_only =3D false, has_force_share =3D false, force_share =3D f=
alse, has_detect_zeroes =3D false, detect_zeroes =3D BLOCKDEV_DETECT_ZEROES=
_OPTIONS_OFF, u =3D {blkdebug =3D {image =3D 0x3e200a70, has_config =3D fal=
se, config =3D 0x0,
              has_align =3D false, align =3D 0, has_max_transfer =3D false,=
 max_transfer =3D 0, has_opt_write_zero =3D false, opt_write_zero =3D 0, ha=
s_max_write_zero =3D false, max_write_zero =3D 0, has_opt_discard =3D false,
              opt_discard =3D 0, has_max_discard =3D false, max_discard =3D=
 0, has_inject_error =3D false, inject_error =3D 0x0, has_set_state =3D fal=
se, set_state =3D 0x0}, blkverify =3D {test =3D 0x3e200a70, raw =3D 0x0}, b=
ochs =3D {
              file =3D 0x3e200a70}, cloop =3D {file =3D 0x3e200a70}, dmg =
=3D {file =3D 0x3e200a70}, file =3D {filename =3D 0x3e200a70 "\004", has_pr=
_manager =3D false, pr_manager =3D 0x0, has_locking =3D false, locking =3D =
ON_OFF_AUTO_AUTO,
              has_aio =3D false, aio =3D BLOCKDEV_AIO_OPTIONS_THREADS}, ftp=
 =3D {url =3D 0x3e200a70 "\004", has_readahead =3D false, readahead =3D 0, =
has_timeout =3D false, timeout =3D 0, has_username =3D false, username =3D =
0x0,
              has_password_secret =3D false, password_secret =3D 0x0, has_p=
roxy_username =3D false, proxy_username =3D 0x0, has_proxy_password_secret =
=3D false, proxy_password_secret =3D 0x0}, ftps =3D {url =3D 0x3e200a70 "\0=
04",
              has_readahead =3D false, readahead =3D 0, has_timeout =3D fal=
se, timeout =3D 0, has_username =3D false, username =3D 0x0, has_password_s=
ecret =3D false, password_secret =3D 0x0, has_proxy_username =3D false,
              proxy_username =3D 0x0, has_proxy_password_secret =3D false, =
proxy_password_secret =3D 0x0, has_sslverify =3D false, sslverify =3D false=
}, gluster =3D {volume =3D 0x3e200a70 "\004", path =3D 0x0, server =3D 0x0,
              has_debug =3D false, debug =3D 0, has_logfile =3D false, logf=
ile =3D 0x0}, host_cdrom =3D {filename =3D 0x3e200a70 "\004", has_pr_manage=
r =3D false, pr_manager =3D 0x0, has_locking =3D false, locking =3D ON_OFF_=
AUTO_AUTO,
              has_aio =3D false, aio =3D BLOCKDEV_AIO_OPTIONS_THREADS}, hos=
t_device =3D {filename =3D 0x3e200a70 "\004", has_pr_manager =3D false, pr_=
manager =3D 0x0, has_locking =3D false, locking =3D ON_OFF_AUTO_AUTO, has_a=
io =3D false,
              aio =3D BLOCKDEV_AIO_OPTIONS_THREADS}, http =3D {url =3D 0x3e=
200a70 "\004", has_readahead =3D false, readahead =3D 0, has_timeout =3D fa=
lse, timeout =3D 0, has_username =3D false, username =3D 0x0, has_password_=
secret =3D false,
              password_secret =3D 0x0, has_proxy_username =3D false, proxy_=
username =3D 0x0, has_proxy_password_secret =3D false, proxy_password_secre=
t =3D 0x0, has_cookie =3D false, cookie =3D 0x0, has_cookie_secret =3D fals=
e,
              cookie_secret =3D 0x0}, https =3D {url =3D 0x3e200a70 "\004",=
 has_readahead =3D false, readahead =3D 0, has_timeout =3D false, timeout =
=3D 0, has_username =3D false, username =3D 0x0, has_password_secret =3D fa=
lse,
              password_secret =3D 0x0, has_proxy_username =3D false, proxy_=
username =3D 0x0, has_proxy_password_secret =3D false, proxy_password_secre=
t =3D 0x0, has_cookie =3D false, cookie =3D 0x0, has_sslverify =3D false,
              sslverify =3D false, has_cookie_secret =3D false, cookie_secr=
et =3D 0x0}, iscsi =3D {transport =3D (unknown: 1042287216), portal =3D 0x0=
, target =3D 0x0, has_lun =3D false, lun =3D 0, has_user =3D false, user =
=3D 0x0,
              has_password_secret =3D false, password_secret =3D 0x0, has_i=
nitiator_name =3D false, initiator_name =3D 0x0, has_header_digest =3D fals=
e, header_digest =3D QAPI_ISCSI_HEADER_DIGEST_CRC32C, has_timeout =3D false,
              timeout =3D 0}, luks =3D {file =3D 0x3e200a70, has_key_secret=
 =3D false, key_secret =3D 0x0}, nbd =3D {server =3D 0x3e200a70, has_export=
 =3D false, export =3D 0x0, has_tls_creds =3D false, tls_creds =3D 0x0}, nf=
s =3D {
              server =3D 0x3e200a70, path =3D 0x0, has_user =3D false, user=
 =3D 0, has_group =3D false, group =3D 0, has_tcp_syn_count =3D false, tcp_=
syn_count =3D 0, has_readahead_size =3D false, readahead_size =3D 0,
              has_page_cache_size =3D false, page_cache_size =3D 0, has_deb=
ug =3D false, debug =3D 0}, null_aio =3D {has_size =3D 112, size =3D 0, has=
_latency_ns =3D false, latency_ns =3D 0}, null_co =3D {has_size =3D 112, si=
ze =3D 0,
              has_latency_ns =3D false, latency_ns =3D 0}, parallels =3D {f=
ile =3D 0x3e200a70}, qcow2 =3D {file =3D 0x3e200a70, has_backing =3D false,=
 backing =3D 0x0, has_lazy_refcounts =3D false, lazy_refcounts =3D false,
              has_pass_discard_request =3D false, pass_discard_request =3D =
false, has_pass_discard_snapshot =3D false, pass_discard_snapshot =3D false=
, has_pass_discard_other =3D false, pass_discard_other =3D false,
              has_overlap_check =3D false, overlap_check =3D 0x0, has_cache=
_size =3D false, cache_size =3D 0, has_l2_cache_size =3D false, l2_cache_si=
ze =3D 0, has_refcount_cache_size =3D false, refcount_cache_size =3D 0,
              has_cache_clean_interval =3D false, cache_clean_interval =3D =
0, has_encrypt =3D false, encrypt =3D 0x0}, qcow =3D {file =3D 0x3e200a70, =
has_backing =3D false, backing =3D 0x0, has_encrypt =3D false, encrypt =3D =
0x0}, qed =3D {
              file =3D 0x3e200a70, has_backing =3D false, backing =3D 0x0},=
 quorum =3D {has_blkverify =3D 112, blkverify =3D 10, children =3D 0x0, vot=
e_threshold =3D 0, has_rewrite_corrupted =3D false, rewrite_corrupted =3D f=
alse,
              has_read_pattern =3D false, read_pattern =3D QUORUM_READ_PATT=
ERN_QUORUM}, raw =3D {file =3D 0x3e200a70, has_offset =3D false, offset =3D=
 0, has_size =3D false, size =3D 0}, rbd =3D {pool =3D 0x3e200a70 "\004", i=
mage =3D 0x0,
              has_conf =3D false, conf =3D 0x0, has_snapshot =3D false, sna=
pshot =3D 0x0, has_user =3D false, user =3D 0x0, has_server =3D false, serv=
er =3D 0x0}, replication =3D {file =3D 0x3e200a70, mode =3D REPLICATION_MOD=
E_PRIMARY,
              has_top_id =3D false, top_id =3D 0x0}, sheepdog =3D {server =
=3D 0x3e200a70, vdi =3D 0x0, has_snap_id =3D false, snap_id =3D 0, has_tag =
=3D false, tag =3D 0x0}, ssh =3D {server =3D 0x3e200a70, path =3D 0x0, has_=
user =3D false,
              user =3D 0x0}, throttle =3D {throttle_group =3D 0x3e200a70 "\=
004", file =3D 0x0}, vdi =3D {file =3D 0x3e200a70}, vhdx =3D {file =3D 0x3e=
200a70}, vmdk =3D {file =3D 0x3e200a70, has_backing =3D false, backing =3D =
0x0}, vpc =3D {
              file =3D 0x3e200a70}, vvfat =3D {dir =3D 0x3e200a70 "\004", h=
as_fat_type =3D false, fat_type =3D 0, has_floppy =3D false, floppy =3D fal=
se, has_label =3D false, label =3D 0x0, has_rw =3D false, rw =3D false}, vx=
hs =3D {
              vdisk_id =3D 0x3e200a70 "\004", server =3D 0x0, has_tls_creds=
 =3D false, tls_creds =3D 0x0}}}
#13 0x0000000010db4de0 in do_qmp_dispatch (cmds=3D0x1136b198 <qmp_commands>=
, request=3D0x3e25d300, errp=3D0x7fffd055cf30) at qapi/qmp-dispatch.c:104
        local_err =3D 0x0
        command =3D 0x3e25b660 "blockdev-add"
        args =3D 0x3e25e320
        dict =3D 0x3e25d300
        cmd =3D 0x3def3920
        ret =3D 0x0
        __func__ =3D "do_qmp_dispatch"
        __FUNCTION__ =3D "do_qmp_dispatch"
#14 0x0000000010db518c in qmp_dispatch (cmds=3D0x1136b198 <qmp_commands>, r=
equest=3D0x3e25d300) at qapi/qmp-dispatch.c:131
        err =3D 0x0
        ret =3D 0x3e25d300
        rsp =3D 0x3e25a950
#15 0x00000000100c9470 in handle_qmp_command (parser=3D0x3dfd3350, tokens=
=3D0x3dfbef40) at /home/nasastry/qemu/monitor.c:3854
        req =3D 0x3e25d300
        rsp =3D 0x0
        id =3D 0x0
        qdict =3D 0x3e25d300
        mon =3D 0x3dfd32c0
        err =3D 0x0
        __func__ =3D "handle_qmp_command"
#16 0x0000000010dc8bcc in json_message_process_token (lexer=3D0x3dfd3358, i=
nput=3D0x3dfbdc80, type=3DJSON_RCURLY, x=3D273, y=3D0) at qobject/json-stre=
amer.c:105
---Type <return> to continue, or q <return> to quit---
        parser =3D 0x3dfd3350
        token =3D 0x3e25a930
        tokens =3D 0x3dfbef40
#17 0x0000000010e3dc98 in json_lexer_feed_char (lexer=3D0x3dfd3358, ch=3D12=
5 '}', flush=3Dfalse) at qobject/json-lexer.c:323
        char_consumed =3D 1
        new_state =3D 101
        __PRETTY_FUNCTION__ =3D "json_lexer_feed_char"
#18 0x0000000010e3dfe0 in json_lexer_feed (lexer=3D0x3dfd3358, buffer=3D0x7=
fffd055d2f8 "}", size=3D1) at qobject/json-lexer.c:373
        err =3D 0
        i =3D 0
#19 0x0000000010dc8d6c in json_message_parser_feed (parser=3D0x3dfd3350, bu=
ffer=3D0x7fffd055d2f8 "}", size=3D1) at qobject/json-streamer.c:124
No locals.
#20 0x00000000100c99ac in monitor_qmp_read (opaque=3D0x3dfd32c0, buf=3D0x7f=
ffd055d2f8 "}", size=3D1) at /home/nasastry/qemu/monitor.c:3896
        old_mon =3D 0x0
#21 0x0000000010ca9430 in qemu_chr_be_write_impl (s=3D0x3dfce650, buf=3D0x7=
fffd055d2f8 "}", len=3D1) at chardev/char.c:167
        be =3D 0x3dfd32c0
#22 0x0000000010ca9594 in qemu_chr_be_write (s=3D0x3dfce650, buf=3D0x7fffd0=
55d2f8 "}", len=3D1) at chardev/char.c:179
No locals.
#23 0x0000000010cbf154 in tcp_chr_read (chan=3D0x3dfd2190, cond=3DG_IO_IN, =
opaque=3D0x3dfce650) at chardev/char-socket.c:440
        chr =3D 0x3dfce650
        __func__ =3D "tcp_chr_read"
        s =3D 0x3dfce650
        buf =3D "}\000=CA=81\377\177\000\000@\000\000\t\377\377\377\377\000=
\001\000\000\000\000\000\000\240\334\373=3D\000\000\000\000\300\334\373=3D\=
000\000\000\000`\234\364=3D\000\000\000\000\220\234\364=3D\000\000\000\000\=
340\201\375=3D", '\000' <repeats 12 times>, "pk\020>\000\000\000\000pk\020>=
\000\000\000\000\240\036\362=3D", '\000' <repeats 12 times>, "\300l\346=3D\=
000\000\000\000\360R\n>\000\000\000\000\370\324U\320\377\177\000\000\b", '\=
000' <repeats 16 times>, "\355\035\362M=3D\223~d\343U\320\377\177\000\000\2=
40\323U\320\377\177\000\000\200\343U\320\377\177\000\000\000\251\065\021\00=
2\000\000\000\340\252*\020\000\000\000\000\000\251\065\021\000\000\000\000\=
060"...
        len =3D 1
        size =3D 1
#24 0x0000000010cf9b1c in qio_channel_fd_source_dispatch (source=3D0x3e2594=
70, callback=3D0x10cbee50 <tcp_chr_read>, user_data=3D0x3dfce650) at io/cha=
nnel-watch.c:84
        func =3D 0x10cbee50 <tcp_chr_read>
        ssource =3D 0x3e259470
#25 0x00007fffa4f13ab0 in g_main_context_dispatch () from /lib64/libglib-2.=
0.so.0
No symbol table info available.
#26 0x0000000010ddf918 in glib_pollfds_poll () at util/main-loop.c:214
        context =3D 0x3dfc1a50
        pfds =3D 0x3e25bdf0
#27 0x0000000010ddfcc8 in os_host_main_loop_wait (timeout=3D-1) at util/mai=
n-loop.c:261
        context =3D 0x3dfc1a50
        ret =3D 1
        spin_counter =3D 0
#28 0x0000000010ddfeec in main_loop_wait (nonblocking=3D0) at util/main-loo=
p.c:515
        ret =3D 1
        timeout =3D 4294967295
        timeout_ns =3D -1
#29 0x00000000105d0afc in main_loop () at vl.c:1995
No locals.
#30 0x00000000105e5cc4 in main (argc=3D16, argv=3D0x7fffd055ed08, envp=3D0x=
7fffd055ed90) at vl.c:4899
        i =3D 1
        snapshot =3D 0
        linux_boot =3D 0
        initrd_filename =3D 0x0
        kernel_filename =3D 0x0
        kernel_cmdline =3D 0x10eb5c88 ""
        boot_order =3D 0x10e75568 ""
        boot_once =3D 0x0
        ds =3D 0x3e21dba0
        cyls =3D 0
        heads =3D 0
        secs =3D 0
        translation =3D 0
        opts =3D 0x0
        machine_opts =3D 0x3defabe0
        hda_opts =3D 0x0
        icount_opts =3D 0x0
        accel_opts =3D 0x0
        olist =3D 0x1112b3d8 <qemu_machine_opts>
        optind =3D 16
        optarg =3D 0x7fffd055f359 "accel=3Dqtest"
        loadvm =3D 0x0
---Type <return> to continue, or q <return> to quit---
        machine_class =3D 0x3df4fd00
        cpu_model =3D 0x0
        vga_model =3D 0x7fffd055f2d4 "none"
        qtest_chrdev =3D 0x7fffd055f2e0 "unix:path=3D/home/nasastry/qemu/te=
sts/qemu-iotests/scratch/qemu-32241-qtest.sock"
        qtest_log =3D 0x0
        pid_file =3D 0x0
        incoming =3D 0x0
        userconfig =3D true
        nographic =3D false
        display_type =3D DT_NONE
        display_remote =3D 0
        log_mask =3D 0x0
        log_file =3D 0x0
        trace_file =3D 0x0
        maxram_size =3D 536870912
        ram_slots =3D 0
        vmstate_dump_file =3D 0x0
        main_loop_err =3D 0x0
        err =3D 0x0
        list_data_dirs =3D false
        dirs =3D 0x3dfc4b20
        bdo_queue =3D {sqh_first =3D 0x0, sqh_last =3D 0x7fffd055e7d8}
        __func__ =3D "main"
        __FUNCTION__ =3D "main"

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1727250

Title:
  qemu-io-test 147 segfaults when configured with gcov

Status in QEMU:
  New

Bug description:
  Head is at 3d7196d43bfe12efe98568cb60057e273652b99b

  Steps to re-produce:
  1. git clone
  ./configure --enable-gcov --target-list=3Dppc64-softmmu
  make
  cd tests/qemu-iotests

  2. export qemu binary, in my environment
  export QEMU_PROG=3D/home/nasastry/qemu_gcov/ppc64-softmmu/qemu-system-ppc=
64

  3. Run test 147 with format qcow2
  ./check -qcow2 147

  QEMU          -- "/home/nasastry/qemu_gcov/ppc64-softmmu/qemu-system-ppc6=
4" -nodefaults -machine accel=3Dqtest
  QEMU_IMG      -- "/home/nasastry/qemu/qemu-img"
  QEMU_IO       -- "/home/nasastry/qemu/qemu-io"  --cache writeback -f qcow2
  QEMU_NBD      -- "/home/nasastry/qemu/qemu-nbd"
  IMGFMT        -- qcow2 (compat=3D1.1)
  IMGPROTO      -- file
  PLATFORM      -- Linux/ppc64le zzfp365-lp1 4.13.0-4.rel.git49564cb.el7.ce=
ntos.ppc64le
  TEST_DIR      -- /home/nasastry/qemu/tests/qemu-iotests/scratch
  SOCKET_SCM_HELPER -- /home/nasastry/qemu/tests/qemu-iotests/socket_scm_he=
lper

  147 0s ... [failed, exit status 1] - output mismatch (see 147.out.bad)
  --- /home/nasastry/qemu/tests/qemu-iotests/147.out	2017-10-25 14:04:54.97=
8600753 +0530
  +++ /home/nasastry/qemu/tests/qemu-iotests/147.out.bad	2017-10-25 14:09:5=
3.769783770 +0530
  @@ -1,5 +1,95 @@
  -......
  +WARNING:qemu:qemu received signal -11: /home/nasastry/qemu_gcov/ppc64-so=
ftmmu/qemu-system-ppc64 -chardev socket,id=3Dmon,path=3D/home/nasastry/qemu=
/tests/qemu-iotests/scratch/qemu-28636-monitor.sock -mon chardev=3Dmon,mode=
=3Dcontrol -display none -vga none -qtest unix:path=3D/home/nasastry/qemu/t=
ests/qemu-iotests/scratch/qemu-28636-qtest.sock -machine accel=3Dqtest -nod=
efaults -machine accel=3Dqtest
  +WARNING:qemu:qemu received signal -11: /home/nasastry/qemu_gcov/ppc64-so=
ftmmu/qemu-system-ppc64 -chardev socket,id=3Dmon,path=3D/home/nasastry/qemu=
/tests/qemu-iotests/scratch/qemu-28636-monitor.sock -mon chardev=3Dmon,mode=
=3Dcontrol -display none -vga none -qtest unix:path=3D/home/nasastry/qemu/t=
ests/qemu-iotests/scratch/qemu-28636-qtest.sock -machine accel=3Dqtest -nod=
efaults -machine accel=3Dqtest
  +WARNING:qemu:qemu received signal -11: /home/nasastry/qemu_gcov/ppc64-so=
ftmmu/qemu-system-ppc64 -chardev socket,id=3Dmon,path=3D/home/nasastry/qemu=
/tests/qemu-iotests/scratch/qemu-28636-monitor.sock -mon chardev=3Dmon,mode=
=3Dcontrol -display none -vga none -qtest unix:path=3D/home/nasastry/qemu/t=
ests/qemu-iotests/scratch/qemu-28636-qtest.sock -machine accel=3Dqtest -nod=
efaults -machine accel=3Dqtest
  +WARNING:qemu:qemu received signal -11: /home/nasastry/qemu_gcov/ppc64-so=
ftmmu/qemu-system-ppc64 -chardev socket,id=3Dmon,path=3D/home/nasastry/qemu=
/tests/qemu-iotests/scratch/qemu-28636-monitor.sock -mon chardev=3Dmon,mode=
=3Dcontrol -display none -vga none -qtest unix:path=3D/home/nasastry/qemu/t=
ests/qemu-iotests/scratch/qemu-28636-qtest.sock -machine accel=3Dqtest -nod=
efaults -machine accel=3Dqtest
  +WARNING:qemu:qemu received signal -11: /home/nasastry/qemu_gcov/ppc64-so=
ftmmu/qemu-system-ppc64 -chardev socket,id=3Dmon,path=3D/home/nasastry/qemu=
/tests/qemu-iotests/scratch/qemu-28636-monitor.sock -mon chardev=3Dmon,mode=
=3Dcontrol -display none -vga none -qtest unix:path=3D/home/nasastry/qemu/t=
ests/qemu-iotests/scratch/qemu-28636-qtest.sock -machine accel=3Dqtest -nod=
efaults -machine accel=3Dqtest
  +WARNING:qemu:qemu received signal -11: /home/nasastry/qemu_gcov/ppc64-so=
ftmmu/qemu-system-ppc64 -chardev socket,id=3Dmon,path=3D/home/nasastry/qemu=
/tests/qemu-iotests/scratch/qemu-28636-monitor.sock -mon chardev=3Dmon,mode=
=3Dcontrol -display none -vga none -qtest unix:path=3D/home/nasastry/qemu/t=
ests/qemu-iotests/scratch/qemu-28636-qtest.sock -machine accel=3Dqtest -nod=
efaults -machine accel=3Dqtest
  +FFFFFF
  +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  +FAIL: test_fd (__main__.BuiltinNBD)
  +----------------------------------------------------------------------
  +Traceback (most recent call last):
  +  File "147", line 203, in test_fd
  +    self.client_test(filename, flatten_sock_addr(address), 'nbd-export')
  +  File "147", line 55, in client_test
  +    self.assert_qmp(result, 'return', {})
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 315, in=
 assert_qmp
  +    result =3D self.dictpath(d, path)
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 274, in=
 dictpath
  +    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)))
  +AssertionError: failed path traversal for "return" in "None"
  +
  +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  +FAIL: test_inet (__main__.BuiltinNBD)
  +----------------------------------------------------------------------
  +Traceback (most recent call last):
  +  File "147", line 146, in test_inet
  +    flatten_sock_addr(address), 'nbd-export')
  +  File "147", line 55, in client_test
  +    self.assert_qmp(result, 'return', {})
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 315, in=
 assert_qmp
  +    result =3D self.dictpath(d, path)
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 274, in=
 dictpath
  +    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)))
  +AssertionError: failed path traversal for "return" in "None"
  +
  +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  +FAIL: test_inet6 (__main__.BuiltinNBD)
  +----------------------------------------------------------------------
  +Traceback (most recent call last):
  +  File "147", line 171, in test_inet6
  +    self.client_test(filename, flatten_sock_addr(address), 'nbd-export')
  +  File "147", line 55, in client_test
  +    self.assert_qmp(result, 'return', {})
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 315, in=
 assert_qmp
  +    result =3D self.dictpath(d, path)
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 274, in=
 dictpath
  +    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)))
  +AssertionError: failed path traversal for "return" in "None"
  +
  +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  +FAIL: test_unix (__main__.BuiltinNBD)
  +----------------------------------------------------------------------
  +Traceback (most recent call last):
  +  File "147", line 179, in test_unix
  +    flatten_sock_addr(address), 'nbd-export')
  +  File "147", line 55, in client_test
  +    self.assert_qmp(result, 'return', {})
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 315, in=
 assert_qmp
  +    result =3D self.dictpath(d, path)
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 274, in=
 dictpath
  +    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)))
  +AssertionError: failed path traversal for "return" in "None"
  +
  +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  +FAIL: test_inet (__main__.QemuNBD)
  +----------------------------------------------------------------------
  +Traceback (most recent call last):
  +  File "147", line 96, in test_inet
  +    flatten_sock_addr(address))
  +  File "147", line 55, in client_test
  +    self.assert_qmp(result, 'return', {})
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 315, in=
 assert_qmp
  +    result =3D self.dictpath(d, path)
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 274, in=
 dictpath
  +    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)))
  +AssertionError: failed path traversal for "return" in "None"
  +
  +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  +FAIL: test_unix (__main__.QemuNBD)
  +----------------------------------------------------------------------
  +Traceback (most recent call last):
  +  File "147", line 103, in test_unix
  +    flatten_sock_addr(address))
  +  File "147", line 55, in client_test
  +    self.assert_qmp(result, 'return', {})
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 315, in=
 assert_qmp
  +    result =3D self.dictpath(d, path)
  +  File "/home/nasastry/qemu/tests/qemu-iotests/iotests.py", line 274, in=
 dictpath
  +    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)))
  +AssertionError: failed path traversal for "return" in "None"
  +
   ----------------------------------------------------------------------
   Ran 6 tests

  -OK
  +FAILED (failures=3D6)
  Failures: 147
  Failed 1 of 1 tests

  With out gcov configured, the above test get pass.
  export QEMU_PROG=3D/home/nasastry/qemu/ppc64-softmmu/qemu-system-ppc64
  ./check -qcow2 147
  QEMU          -- "/home/nasastry/qemu/ppc64-softmmu/qemu-system-ppc64" -n=
odefaults -machine accel=3Dqtest
  QEMU_IMG      -- "/home/nasastry/qemu/qemu-img"
  QEMU_IO       -- "/home/nasastry/qemu/qemu-io"  --cache writeback -f qcow2
  QEMU_NBD      -- "/home/nasastry/qemu/qemu-nbd"
  IMGFMT        -- qcow2 (compat=3D1.1)
  IMGPROTO      -- file
  PLATFORM      -- Linux/ppc64le zzfp365-lp1 4.13.0-4.rel.git49564cb.el7.ce=
ntos.ppc64le
  TEST_DIR      -- /home/nasastry/qemu/tests/qemu-iotests/scratch
  SOCKET_SCM_HELPER -- /home/nasastry/qemu/tests/qemu-iotests/socket_scm_he=
lper

  147
  Passed all 1 tests

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1727250/+subscriptions
