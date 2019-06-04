Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBBBC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 08:45:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D013C24B90
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 08:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D013C24B90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48745 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY54A-0003rs-08
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 04:45:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhengui@huawei.com>) id 1hY52y-0003DQ-3a
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhengui@huawei.com>) id 1hY52w-0005bQ-3g
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 04:43:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2240 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhengui@huawei.com>)
	id 1hY52p-0005TU-VK; Tue, 04 Jun 2019 04:43:49 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id CA916A7391E0A734E8C5;
	Tue,  4 Jun 2019 16:43:36 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.193) by DGGEMS406-HUB.china.huawei.com
	(10.3.19.206) with Microsoft SMTP Server id 14.3.439.0;
	Tue, 4 Jun 2019 16:43:26 +0800
To: Paolo Bonzini <pbonzini@redhat.co>, Stefan Hajnoczi <stefanha@redhat.com>
From: l00284672 <lizhengui@huawei.com>
Message-ID: <f1cc2c01-62ec-c820-3771-58a9b2a72841@huawei.com>
Date: Tue, 4 Jun 2019 16:39:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
	Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------B1ADF76D3EF0ABE40E617F08"
Content-Language: en-US
X-Originating-IP: [10.177.251.193]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] virtual machine cpu soft lock when qemu attach disk
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jiangyiwen@huawei.com, lizhengui@huawi.com, qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--------------B1ADF76D3EF0ABE40E617F08
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,=C2=A0 I found a problem that virtual machine cpu soft lock when I att=
ach=20
a disk to the vm in the case that

backend storage network has a large delay or IO pressure is too large.

1) The disk xml which I attached is:

 =C2=A0=C2=A0=C2=A0 <disk type=3D'block' device=3D'lun' rawio=3D'yes'>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <driver name=3D'qemu' type=3D'raw' cache=3D=
'none' io=3D'native'/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <source dev=3D'/dev/mapper/360022a11000c1=
e0a0787c23a000001cb'/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <backingStore/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <target dev=3D'sdb' bus=3D'scsi'/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <alias name=3D'scsi0-0-1-0'/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <address type=3D'drive' controller=3D'0' =
bus=3D'0' target=3D'1' unit=3D'0'/>
 =C2=A0=C2=A0=C2=A0 </disk>

2) The bt of qemu main thread:

#0 0x0000ffff9d78402c in pread64 () from /lib64/libpthread.so.0
#1 0x0000aaaace3357d8 in pread64 (__offset=3D0, __nbytes=3D4096,=20
__buf=3D0xaaaad47a5200, __fd=3D202) at /usr/include/bits/unistd.h:99
#2 raw_is_io_aligned (fd=3Dfd@entry=3D202, buf=3Dbuf@entry=3D0xaaaad47a52=
00,=20
len=3Dlen@entry=3D4096) at block/raw_posix.c:294
#3 0x0000aaaace33597c in raw_probe_alignment=20
(bs=3Dbs@entry=3D0xaaaad32ea920, fd=3D202, errp=3Derrp@entry=3D0xfffffef7=
a330) at=20
block/raw_posix.c:349
#4 0x0000aaaace335a48 in raw_refresh_limits (bs=3D0xaaaad32ea920,=20
errp=3D0xfffffef7a330) at block/raw_posix.c:811
#5 0x0000aaaace3404b0 in bdrv_refresh_limits (bs=3D0xaaaad32ea920,=20
errp=3D0xfffffef7a330, errp@entry=3D0xfffffef7a360) at block/io.c:122
#6 0x0000aaaace340504 in bdrv_refresh_limits=20
(bs=3Dbs@entry=3D0xaaaad09ce800, errp=3Derrp@entry=3D0xfffffef7a3b0) at=20
block/io.c:97
#7 0x0000aaaace2eb9f0 in bdrv_open_common (bs=3Dbs@entry=3D0xaaaad09ce800=
,=20
file=3Dfile@entry=3D0xaaaad0e89800, options=3D<optimized out>,=20
errp=3Derrp@entry=3D0xfffffef7a450)
at block.c:1194
#8 0x0000aaaace2eedec in bdrv_open_inherit (filename=3D<optimized out>,=20
filename@entry=3D0xaaaad25f92d0=20
"/dev/mapper/36384c4f100630193359db7a80000011d",
reference=3Dreference@entry=3D0x0, options=3D<optimized out>,=20
options@entry=3D0xaaaad3d0f4b0, flags=3D<optimized out>, flags@entry=3D12=
8,=20
parent=3Dparent@entry=3D0x0,
child_role=3Dchild_role@entry=3D0x0, errp=3Derrp@entry=3D0xfffffef7a710) =
at=20
block.c:1895
#9 0x0000aaaace2ef510 in bdrv_open=20
(filename=3Dfilename@entry=3D0xaaaad25f92d0=20
"/dev/mapper/36384c4f100630193359db7a80000011d",=20
reference=3Dreference@entry=3D0x0,
options=3Doptions@entry=3D0xaaaad3d0f4b0, flags=3Dflags@entry=3D128,=20
errp=3Derrp@entry=3D0xfffffef7a710) at block.c:1979
#10 0x0000aaaace331ef0 in blk_new_open=20
(filename=3Dfilename@entry=3D0xaaaad25f92d0=20
"/dev/mapper/36384c4f100630193359db7a80000011d",=20
reference=3Dreference@entry=3D0x0,
options=3Doptions@entry=3D0xaaaad3d0f4b0, flags=3D128,=20
errp=3Derrp@entry=3D0xfffffef7a710) at block/block_backend.c:213
#11 0x0000aaaace0da1f4 in blockdev_init (file=3Dfile@entry=3D0xaaaad25f92=
d0=20
"/dev/mapper/36384c4f100630193359db7a80000011d",=20
bs_opts=3Dbs_opts@entry=3D0xaaaad3d0f4b0,
errp=3Derrp@entry=3D0xfffffef7a710) at blockdev.c:603
#12 0x0000aaaace0dc478 in drive_new=20
(all_opts=3Dall_opts@entry=3D0xaaaad4dc31d0, block_default_type=3D<optimi=
zed=20
out>) at blockdev.c:1116
#13 0x0000aaaace0e3ee0 in add_init_drive (
optstr=3Doptstr@entry=3D0xaaaad0872ec0=20
"file=3D/dev/mapper/36384c4f100630193359db7a80000011d,format=3Draw,if=3Dn=
one,id=3Ddrive-scsi0-0-0-3,cache=3Dnone,aio=3Dnative")
at device_hotplug.c:46
#14 0x0000aaaace0e3f78 in hmp_drive_add (mon=3D0xfffffef7a810,=20
qdict=3D0xaaaad0c8f000) at device_hotplug.c:67
#15 0x0000aaaacdf7d688 in handle_hmp_command (mon=3D0xfffffef7a810,=20
cmdline=3D<optimized out>) at /usr/src/debug/qemu-kvm-2.8.1/monitor.c:319=
9
#16 0x0000aaaacdf7d778 in qmp_human_monitor_command (
command_line=3D0xaaaacfc8e3c0 "drive_add dummy=20
file=3D/dev/mapper/36384c4f100630193359db7a80000011d,format=3Draw,if=3Dno=
ne,id=3Ddrive-scsi0-0-0-3,cache=3Dnone,aio=3Dnative",=20

has_cpu_index=3Dfalse, cpu_index=3D0, errp=3Derrp@entry=3D0xfffffef7a968)=
 at=20
/usr/src/debug/qemu-kvm-2.8.1/monitor.c:660
#17 0x0000aaaace0fdb30 in qmp_marshal_human_monitor_command=20
(args=3D<optimized out>, ret=3D0xfffffef7a9e0, errp=3D0xfffffef7a9d8) at=20
qmp-marshal.c:2223
#18 0x0000aaaace3b6ad0 in do_qmp_dispatch (request=3D<optimized out>,=20
errp=3D0xfffffef7aa20, errp@entry=3D0xfffffef7aa40) at qapi/qmp_dispatch.=
c:115
#19 0x0000aaaace3b6d58 in qmp_dispatch (request=3D<optimized out>) at=20
qapi/qmp_dispatch.c:142
#20 0x0000aaaacdf79398 in handle_qmp_command (parser=3D<optimized out>,=20
tokens=3D<optimized out>) at /usr/src/debug/qemu-kvm-2.8.1/monitor.c:4010
#21 0x0000aaaace3bd6c0 in json_message_process_token=20
(lexer=3D0xaaaacf834c80, input=3D<optimized out>, type=3DJSON_RCURLY, x=3D=
214,=20
y=3D274) at qobject/json_streamer.c:105
#22 0x0000aaaace3f3d4c in json_lexer_feed_char=20
(lexer=3Dlexer@entry=3D0xaaaacf834c80, ch=3D<optimized out>,=20
flush=3Dflush@entry=3Dfalse) at qobject/json_lexer.c:319
#23 0x0000aaaace3f3e6c in json_lexer_feed (lexer=3D0xaaaacf834c80,=20
buffer=3D<optimized out>, size=3D<optimized out>) at qobject/json_lexer.c=
:369
#24 0x0000aaaacdf77c64 in monitor_qmp_read (opaque=3D<optimized out>,=20
buf=3D<optimized out>, size=3D<optimized out>) at=20
/usr/src/debug/qemu-kvm-2.8.1/monitor.c:4040
#25 0x0000aaaace0eab18 in tcp_chr_read (chan=3D<optimized out>,=20
cond=3D<optimized out>, opaque=3D0xaaaacf90b280) at qemu_char.c:3260
#26 0x0000ffff9dadf200 in g_main_context_dispatch () from=20
/lib64/libglib-2.0.so.0
#27 0x0000aaaace3c4a00 in glib_pollfds_poll () at util/main_loop.c:230
--Type <RET> for more, q to quit, c to continue without paging--
#28 0x0000aaaace3c4a88 in os_host_main_loop_wait (timeout=3D<optimized=20
out>) at util/main_loop.c:278
#29 0x0000aaaace3c4bf0 in main_loop_wait (nonblocking=3D<optimized out>)=20
at util/main_loop.c:534
#30 0x0000aaaace0f5d08 in main_loop () at vl.c:2120
#31 0x0000aaaacdf3a770 in main (argc=3D<optimized out>, argv=3D<optimized=
=20
out>, envp=3D<optimized out>) at vl.c:5017

3)The bt of vcpu thread

 From the bt we can see,=C2=A0 when do qmp sush as drive_add,=C2=A0 qemu =
main=20
thread locks the qemu_global_mutex=C2=A0 and do pread in raw_probe_alignm=
en.=20
Pread

is a synchronous operation. If backend storage network has a large delay=20
or IO pressure is too large,=C2=A0 the pread operation will not return fo=
r a=20
long time, which

make vcpu thread can't acquire qemu_global_mutex for a long time and=20
make the vcpu thread unable to be scheduled for a long time. So virtual=20
machine cpu soft lock happened.


I thank=C2=A0 qemu main thread should not hold qemu_global_mutex for a lo=
ng=20
time when do qmp that involving IO synchronous operation sush pread ,=20
ioctl, etc.

Do you have any solutions or good ideas about it? Thanks for your reply!






--------------B1ADF76D3EF0ABE40E617F08
Content-Type: text/x-vcard; name="lizhengui.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lizhengui.vcf"

bnVsbA==
--------------B1ADF76D3EF0ABE40E617F08--

