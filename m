Received: from eggs.gnu.org ([2001:4830:134:3::10]:60268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fhsy2-0006IK-Ap
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 04:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fhsxz-00006a-9B
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 04:46:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51164 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fhsxz-00006T-37
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 04:46:47 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180720130928.6696-1-liujunjie23@huawei.com>
	<87h8kq86f8.fsf@dusky.pond.sub.org>
	<B526101FCAB4654DB0892B650DEFC555086C7F48@dggemm521-mbx.china.huawei.com>
	<87k1pm551g.fsf@dusky.pond.sub.org>
	<B526101FCAB4654DB0892B650DEFC555086C8382@dggemm521-mbx.china.huawei.com>
	<87r2jt40g1.fsf@dusky.pond.sub.org>
Date: Tue, 24 Jul 2018 10:46:44 +0200
In-Reply-To: <87r2jt40g1.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Tue, 24 Jul 2018 08:22:54 +0200")
Message-ID: <87zhyh2f7v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: "liujunjie (A)" <liujunjie23@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> "liujunjie (A)" <liujunjie23@huawei.com> writes:
>
>> The stack backtrace is as follows:
>> (gdb) bt
>> #0  0x00007f1dc3c7b091 in _g_log_abort () from /usr/lib64/libglib-2.0.so.0
>> #1  0x00007f1dc3c7c0bd in g_log_default_handler () from /usr/lib64/libglib-2.0.so.0
>> #2  0x00007f1dc3c7c341 in g_logv () from /usr/lib64/libglib-2.0.so.0
>> #3  0x00007f1dc3c7c5cf in g_log () from /usr/lib64/libglib-2.0.so.0
>> #4  0x00007f1dc3c7ac4c in g_malloc () from /usr/lib64/libglib-2.0.so.0
>> #5  0x00000000008300b7 in qstring_from_substr (
>>     str=0x7f13a2e67010 "00000000777b8000: 0000000003083000 ----A--U-\r\n00000000777b9000: 0000000005984000 ----A--U-\r\n00000000777ba000: 0000000005985000 ----A--U-\r\n00000000777bb000: 0000000003086000 ----A--U-\r\n00000000777bc000"..., start=start@entry=0, end=<optimized out>) at qobject/qstring.c:51
>> #6  0x0000000000830113 in qstring_from_str (str=<optimized out>) at qobject/qstring.c:66
>> #7  0x000000000082be98 in qobject_output_type_str (v=<optimized out>, name=0x89703b "unused", obj=0x7ffff0135f98, errp=<optimized out>)
>>     at qapi/qobject_output_visitor.c:172
>> #8  0x0000000000829d2c in visit_type_str (v=v@entry=0x4d9d940, name=name@entry=0x89703b "unused", obj=obj@entry=0x7ffff0135f98, errp=errp@entry=0x7ffff0135fa8)
>>     at qapi/qapi_visit_core.c:291
>> #9  0x0000000000576135 in qmp_marshal_output_str (
>>     ret_in=0x7f13a2e67010 "00000000777b8000: 0000000003083000 ----A--U-\r\n00000000777b9000: 0000000005984000 ----A--U-\r\n00000000777ba000: 0000000005985000 ----A--U-\r\n00000000777bb000: 0000000003086000 ----A--U-\r\n00000000777bc000"..., ret_out=ret_out@entry=0x7ffff0136068, errp=errp@entry=0x7ffff0135fe8) at qmp-marshal.c:2022
>> #10 0x00000000005762cb in qmp_marshal_human_monitor_command (args=<optimized out>, ret=0x7ffff0136068, errp=0x7ffff0136060) at qmp-marshal.c:2059
>> #11 0x000000000082c897 in do_qmp_dispatch (request=request@entry=0x1fcda50, errp=errp@entry=0x7ffff01360b8) at qapi/qmp_dispatch.c:114
>> #12 0x000000000082caeb in qmp_dispatch (request=request@entry=0x1fcda50) at qapi/qmp_dispatch.c:141
>> #13 0x000000000045e0d2 in handle_qmp_command (parser=<optimized out>, tokens=<optimized out>) at /usr/src/debug/qemu-kvm-2.8.1/monitor.c:3907
> [...]
>
> The code is trying to marshall the return value of
> qmp_human_monitor_command().  It's @ret_in in qmp_marshal_output_str()
> (frame#9, abbreviated by GDB), and @str in qstring_from_substr()
> (frame#5).  Also @str in qstring_from_str() (frame#6), but GDB can't see
> it there.  Sadly, GDB can't see shows qstring_from_substr()'s @end,
> either.  However, you previously examined qstring->length there:
>
>>> > (gdb) p/x qstring->length
>>> > $7 = 0xffffffffb0fd64bc
>>> > (gdb) p	end
>>> > $8 = <optimized out>
>
> We know
>
>     qstring->length = end - start + 1;
>
> If GDB shows the true value (always in doubt for optimized code), then
> @end must be qstring->length - 1, because @start is zero.  But that's
> not plausible at all!  It's almost 16 exabyte.
>
> I suspect GDB is lying to you.  Please show us the complete string, like
> this:
>
>     (gdb) set print elements unlimited
>     (gdb) print str

Actually, I'm interested only in the true length of @str, and the print
is just a simple way to find it.  No need to post the output of print if
it's inconveniently long.
