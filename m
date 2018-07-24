Received: from eggs.gnu.org ([2001:4830:134:3::10]:42922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1fhlof-0006aw-FG
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 21:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1fhloa-0000Xu-VE
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 21:08:41 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:49686 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liujunjie23@huawei.com>)
	id 1fhloa-0000UH-6V
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 21:08:36 -0400
From: "liujunjie (A)" <liujunjie23@huawei.com>
Date: Tue, 24 Jul 2018 01:08:21 +0000
Message-ID: <B526101FCAB4654DB0892B650DEFC555086C8382@dggemm521-mbx.china.huawei.com>
References: <20180720130928.6696-1-liujunjie23@huawei.com>
	<87h8kq86f8.fsf@dusky.pond.sub.org>
	<B526101FCAB4654DB0892B650DEFC555086C7F48@dggemm521-mbx.china.huawei.com>
	<87k1pm551g.fsf@dusky.pond.sub.org>
In-Reply-To: <87k1pm551g.fsf@dusky.pond.sub.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] qstring: Fix integer overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

The stack backtrace is as follows:
(gdb) bt
#0  0x00007f1dc3c7b091 in _g_log_abort () from /usr/lib64/libglib-2.0.so.0
#1  0x00007f1dc3c7c0bd in g_log_default_handler () from /usr/lib64/libglib-=
2.0.so.0
#2  0x00007f1dc3c7c341 in g_logv () from /usr/lib64/libglib-2.0.so.0
#3  0x00007f1dc3c7c5cf in g_log () from /usr/lib64/libglib-2.0.so.0
#4  0x00007f1dc3c7ac4c in g_malloc () from /usr/lib64/libglib-2.0.so.0
#5  0x00000000008300b7 in qstring_from_substr (
    str=3D0x7f13a2e67010 "00000000777b8000: 0000000003083000 ----A--U-\r\n0=
0000000777b9000: 0000000005984000 ----A--U-\r\n00000000777ba000: 0000000005=
985000 ----A--U-\r\n00000000777bb000: 0000000003086000 ----A--U-\r\n0000000=
0777bc000"..., start=3Dstart@entry=3D0, end=3D<optimized out>) at qobject/q=
string.c:51
#6  0x0000000000830113 in qstring_from_str (str=3D<optimized out>) at qobje=
ct/qstring.c:66
#7  0x000000000082be98 in qobject_output_type_str (v=3D<optimized out>, nam=
e=3D0x89703b "unused", obj=3D0x7ffff0135f98, errp=3D<optimized out>)
    at qapi/qobject_output_visitor.c:172
#8  0x0000000000829d2c in visit_type_str (v=3Dv@entry=3D0x4d9d940, name=3Dn=
ame@entry=3D0x89703b "unused", obj=3Dobj@entry=3D0x7ffff0135f98, errp=3Derr=
p@entry=3D0x7ffff0135fa8)
    at qapi/qapi_visit_core.c:291
#9  0x0000000000576135 in qmp_marshal_output_str (
    ret_in=3D0x7f13a2e67010 "00000000777b8000: 0000000003083000 ----A--U-\r=
\n00000000777b9000: 0000000005984000 ----A--U-\r\n00000000777ba000: 0000000=
005985000 ----A--U-\r\n00000000777bb000: 0000000003086000 ----A--U-\r\n0000=
0000777bc000"..., ret_out=3Dret_out@entry=3D0x7ffff0136068, errp=3Derrp@ent=
ry=3D0x7ffff0135fe8) at qmp-marshal.c:2022
#10 0x00000000005762cb in qmp_marshal_human_monitor_command (args=3D<optimi=
zed out>, ret=3D0x7ffff0136068, errp=3D0x7ffff0136060) at qmp-marshal.c:205=
9
#11 0x000000000082c897 in do_qmp_dispatch (request=3Drequest@entry=3D0x1fcd=
a50, errp=3Derrp@entry=3D0x7ffff01360b8) at qapi/qmp_dispatch.c:114
#12 0x000000000082caeb in qmp_dispatch (request=3Drequest@entry=3D0x1fcda50=
) at qapi/qmp_dispatch.c:141
#13 0x000000000045e0d2 in handle_qmp_command (parser=3D<optimized out>, tok=
ens=3D<optimized out>) at /usr/src/debug/qemu-kvm-2.8.1/monitor.c:3907
#14 0x000000000083355e in json_message_process_token (lexer=3D0x1a608e8, in=
put=3D0x19f26e0, type=3DJSON_RCURLY, x=3D94, y=3D263) at qobject/json_strea=
mer.c:105
#15 0x0000000000861650 in json_lexer_feed_char (lexer=3Dlexer@entry=3D0x1a6=
08e8, ch=3D125 '}', flush=3Dflush@entry=3Dfalse) at qobject/json_lexer.c:31=
9
#16 0x0000000000861766 in json_lexer_feed (lexer=3D0x1a608e8, buffer=3D<opt=
imized out>, size=3D<optimized out>) at qobject/json_lexer.c:369
#17 0x0000000000833661 in json_message_parser_feed (parser=3D<optimized out=
>, buffer=3D<optimized out>, size=3D<optimized out>) at qobject/json_stream=
er.c:124
#18 0x000000000045cc32 in monitor_qmp_read (opaque=3D<optimized out>, buf=
=3D<optimized out>, size=3D<optimized out>) at /usr/src/debug/qemu-kvm-2.8.=
1/monitor.c:3937
#19 0x00000000005652f3 in tcp_chr_read (chan=3D<optimized out>, cond=3D<opt=
imized out>, opaque=3D0x1a5c020) at qemu_char.c:3253
#20 0x00007f1dc3c75609 in g_main_context_dispatch () from /usr/lib64/libgli=
b-2.0.so.0
#21 0x0000000000779a06 in glib_pollfds_poll () at main_loop.c:228
#22 0x0000000000779aab in os_host_main_loop_wait (timeout=3D4830848) at mai=
n_loop.c:273
#23 0x0000000000779bd5 in main_loop_wait (nonblocking=3Dnonblocking@entry=
=3D0) at main_loop.c:521
#24 0x0000000000570851 in main_loop () at vl.c:2100
#25 0x0000000000420d1e in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>, envp=3D<optimized out>) at vl.c:4980

> -----Original Message-----
> From: Markus Armbruster [mailto:armbru@redhat.com]
> Sent: Monday, July 23, 2018 11:46 PM
> To: liujunjie (A) <liujunjie23@huawei.com>
> Cc: wangxin (U) <wangxinxin.wang@huawei.com>; Gonglei (Arei)
> <arei.gonglei@huawei.com>; Huangweidong (C)
> <weidong.huang@huawei.com>; qemu-devel@nongnu.org
> Subject: Re: [Qemu-devel] [PATCH] qstring: Fix integer overflow
>=20
> "liujunjie (A)" <liujunjie23@huawei.com> writes:
>=20
> > Thanks for your reply.
> >> Really?  How exactly can this happen?  Please explain step by step.
> > There exist a qemu core related to this. You have mention that "The
> conversion truncates when strlen(str) - 1 exceeds INT_MAX".
> > Later in function qstring_from_substr, this truncated "end" will be ass=
igned
> to "qstring->length" again, which is size_t. This is the key point why qe=
mu
> coredumped.
> > Because when "end" is truncated, it can be negative number. If we assig=
n a
> negative number to a size_t variable, this size_t variable can become ver=
y
> large.
> > At last, we call g_malloc to try to alloc a large number of member whic=
h
> cannot success. So qemu coredump.
> > In my example, use gdb to debug function qstring_from_substr, I can get=
 the
> following message.
> > (gdb) p	qstring->length
> > $4 =3D 18446744072383980732  (too large to allocate)
> > (gdb) p	(int) (qstring->length)
> > $5 =3D -1325570884
> > (gdb) p/x (int)	qstring->length
> > $6 =3D 0xb0fd64bc
> > (gdb) p/x qstring->length
> > $7 =3D 0xffffffffb0fd64bc
> > (gdb) p	end
> > $8 =3D <optimized out>
>=20
> Can you provide a stack backtrace, too?
