Received: from eggs.gnu.org ([2001:4830:134:3::10]:38633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1fhtTM-0007le-QS
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 05:19:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1fhtTI-0006Ao-QN
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 05:19:12 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2278 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liujunjie23@huawei.com>)
	id 1fhtTI-00067X-2m
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 05:19:08 -0400
From: "liujunjie (A)" <liujunjie23@huawei.com>
Date: Tue, 24 Jul 2018 09:18:52 +0000
Message-ID: <B526101FCAB4654DB0892B650DEFC555086C86D6@dggemm521-mbx.china.huawei.com>
References: <20180720130928.6696-1-liujunjie23@huawei.com>
	<87h8kq86f8.fsf@dusky.pond.sub.org>
	<B526101FCAB4654DB0892B650DEFC555086C7F48@dggemm521-mbx.china.huawei.com>
	<87k1pm551g.fsf@dusky.pond.sub.org>
	<B526101FCAB4654DB0892B650DEFC555086C8382@dggemm521-mbx.china.huawei.com>
	<87r2jt40g1.fsf@dusky.pond.sub.org> <87zhyh2f7v.fsf@dusky.pond.sub.org>
In-Reply-To: <87zhyh2f7v.fsf@dusky.pond.sub.org>
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

Even using gdb command: set print elements 0, is still too large to print t=
he whole string.
So I try to obtain the string in another way.
After several attempts(not easy in fact), I finally obtain the real length.=
 The way is as follows:
(gdb) p (int *)str
$1 =3D (int *) 0x7f13a2e67010
(gdb) p *(char*) (0x7f13a2e67010 + 0x8B0FD63FF)@192
$2 =3D "--W\r\nffffffffffd17000: 00000000fec00000 XG-DACT-W\r\nffffffffffd1=
8000: ", '0' <repeats 11 times>, "77000 XG-DA---W\r\nffffffffffd19000: ", '=
0 "78000 XG-DA---W\r\nffffffffffd1a000: ", '0' <repeats 11 times>, "79000 X=
G-DA---W\r\n\000\000"
With \000 at the end, we can find out the length is 0x8B0FD63FF + 192 - 2, =
that is 37329134781.
With this length, we can write a simple c code demo to reproduce the result=
 we obtain before. Such as:
-----------------------------
#include<stdio.h>
int main()
{
    char * tmp =3D "";
    size_t a =3D  37329134781;
    int end =3D a;
    size_t b =3D end;
    printf("%zu", b)
    return 0;
}
-----------------------------


> -----Original Message-----
> From: Markus Armbruster [mailto:armbru@redhat.com]
> Sent: Tuesday, July 24, 2018 4:47 PM
> To: Markus Armbruster <armbru@redhat.com>
> Cc: liujunjie (A) <liujunjie23@huawei.com>; wangxin (U)
> <wangxinxin.wang@huawei.com>; Gonglei (Arei) <arei.gonglei@huawei.com>;
> Huangweidong (C) <weidong.huang@huawei.com>; qemu-devel@nongnu.org
> Subject: Re: [Qemu-devel] [PATCH] qstring: Fix integer overflow
>=20
> Markus Armbruster <armbru@redhat.com> writes:
>=20
> > "liujunjie (A)" <liujunjie23@huawei.com> writes:
> >
> >> The stack backtrace is as follows:
> >> (gdb) bt
> >> #0  0x00007f1dc3c7b091 in _g_log_abort () from
> >> /usr/lib64/libglib-2.0.so.0
> >> #1  0x00007f1dc3c7c0bd in g_log_default_handler () from
> >> /usr/lib64/libglib-2.0.so.0
> >> #2  0x00007f1dc3c7c341 in g_logv () from /usr/lib64/libglib-2.0.so.0
> >> #3  0x00007f1dc3c7c5cf in g_log () from /usr/lib64/libglib-2.0.so.0
> >> #4  0x00007f1dc3c7ac4c in g_malloc () from
> >> /usr/lib64/libglib-2.0.so.0
> >> #5  0x00000000008300b7 in qstring_from_substr (
> >>     str=3D0x7f13a2e67010 "00000000777b8000: 0000000003083000
> >> ----A--U-\r\n00000000777b9000: 0000000005984000
> >> ----A--U-\r\n00000000777ba000: 0000000005985000
> >> ----A--U-\r\n00000000777bb000: 0000000003086000
> >> ----A--U-\r\n00000000777bc000"..., start=3Dstart@entry=3D0,
> >> end=3D<optimized out>) at qobject/qstring.c:51
> >> #6  0x0000000000830113 in qstring_from_str (str=3D<optimized out>) at
> >> qobject/qstring.c:66
> >> #7  0x000000000082be98 in qobject_output_type_str (v=3D<optimized out>=
,
> name=3D0x89703b "unused", obj=3D0x7ffff0135f98, errp=3D<optimized out>)
> >>     at qapi/qobject_output_visitor.c:172
> >> #8  0x0000000000829d2c in visit_type_str (v=3Dv@entry=3D0x4d9d940,
> name=3Dname@entry=3D0x89703b "unused", obj=3Dobj@entry=3D0x7ffff0135f98,
> errp=3Derrp@entry=3D0x7ffff0135fa8)
> >>     at qapi/qapi_visit_core.c:291
> >> #9  0x0000000000576135 in qmp_marshal_output_str (
> >>     ret_in=3D0x7f13a2e67010 "00000000777b8000: 0000000003083000
> >> ----A--U-\r\n00000000777b9000: 0000000005984000
> >> ----A--U-\r\n00000000777ba000: 0000000005985000
> >> ----A--U-\r\n00000000777bb000: 0000000003086000
> >> ----A--U-\r\n00000000777bc000"...,
> >> ret_out=3Dret_out@entry=3D0x7ffff0136068, errp=3Derrp@entry=3D0x7ffff0=
135fe8)
> >> at qmp-marshal.c:2022
> >> #10 0x00000000005762cb in qmp_marshal_human_monitor_command
> >> (args=3D<optimized out>, ret=3D0x7ffff0136068, errp=3D0x7ffff0136060) =
at
> >> qmp-marshal.c:2059
> >> #11 0x000000000082c897 in do_qmp_dispatch
> >> (request=3Drequest@entry=3D0x1fcda50, errp=3Derrp@entry=3D0x7ffff01360=
b8) at
> >> qapi/qmp_dispatch.c:114
> >> #12 0x000000000082caeb in qmp_dispatch
> >> (request=3Drequest@entry=3D0x1fcda50) at qapi/qmp_dispatch.c:141
> >> #13 0x000000000045e0d2 in handle_qmp_command (parser=3D<optimized
> out>,
> >> tokens=3D<optimized out>) at
> >> /usr/src/debug/qemu-kvm-2.8.1/monitor.c:3907
> > [...]
> >
> > The code is trying to marshall the return value of
> > qmp_human_monitor_command().  It's @ret_in in
> qmp_marshal_output_str()
> > (frame#9, abbreviated by GDB), and @str in qstring_from_substr()
> > (frame#5).  Also @str in qstring_from_str() (frame#6), but GDB can't
> > see it there.  Sadly, GDB can't see shows qstring_from_substr()'s
> > @end, either.  However, you previously examined qstring->length there:
> >
> >>> > (gdb) p/x qstring->length
> >>> > $7 =3D 0xffffffffb0fd64bc
> >>> > (gdb) p	end
> >>> > $8 =3D <optimized out>
> >
> > We know
> >
> >     qstring->length =3D end - start + 1;
> >
> > If GDB shows the true value (always in doubt for optimized code), then
> > @end must be qstring->length - 1, because @start is zero.  But that's
> > not plausible at all!  It's almost 16 exabyte.
> >
> > I suspect GDB is lying to you.  Please show us the complete string,
> > like
> > this:
> >
> >     (gdb) set print elements unlimited
> >     (gdb) print str
>=20
> Actually, I'm interested only in the true length of @str, and the print i=
s just a
> simple way to find it.  No need to post the output of print if it's incon=
veniently
> long.
