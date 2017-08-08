Received: from eggs.gnu.org ([2001:4830:134:3::10]:38082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1df2ix-0006hN-Bp
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1df2ir-0001TA-Jg
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:30:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1df2iq-0001Nn-HB
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:30:53 -0400
References: <6b32aeb2-d488-eb3c-4147-a99fe4681a6f@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <5989A0D0.6010304@huawei.com>
Date: Tue, 8 Aug 2017 19:30:24 +0800
MIME-Version: 1.0
In-Reply-To: <6b32aeb2-d488-eb3c-4147-a99fe4681a6f@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] colo-compare: segfault and assert on
 colo_compare_finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: otubo@redhat.com, qemu-devel@nongnu.org
Cc: wency@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, wang.guang55@zte.com.cn, wang.yong155@zte.com.cn

Hi,

Did you test this branch https://github.com/coloft/qemu/tree/colo-for-qem=
u-2.10-2017-4-22 ?

This seems to be an already known problem, I'm not quite sure, it may be =
fixed by this patch

b19456dd0ea4eb418ad093f092adbb882be13054
char: Fix removing wrong GSource that be found by fd_in_tag
We use fd_in_tag to find a GSource, fd_in_tag is return value of g_source=
_attach(GSource *source, GMainContext *context), the return value is uniq=
ue only in the same context, so we may get the same values with different=
 'context' parameters. It is no problem to find the right fd_in_tag by us=
ing g_main_context_find_source_by_id(GMainContext *context, guint source_=
id) while there is only one default main context. But colo-compare tries =
to create/use its own context, and if we pass wrong 'context' parameter w=
ith right fd_in_tag, we will find a wrong GSource to handle. We tried to =
fix the related codes in commit b43decb015a6efeb9e3cdbdb80f6547ad7248a4c,=
 but it didn't fix the bug completely, because we still have some codes d=
idn't pass *right* context parameter for remove_fd_in_watch(). Let's fix =
it by record the GSource directly instead of fd_in_tag. Signed-off-by: zh=
anghailiang <zhang.zhanghailiang@huawei.com> Reviewed-by: Marc-Andr=C3=83=
=C2=A9 Lureau <marcandre.lureau@redhat.com>=20
Message-Id: <1492564532-91680-1-git-send-email-zhang.zhanghailiang@huawei=
=2Ecom> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com> Actually, we h=
ave already re-writed this part, and please follow the later series. Than=
ks, Hailiang

On 2017/8/8 0:39, Eduardo Otubo wrote:
> (please ignore my last email, looks like mutt wants play games lately)
>
> Hi all,
>
> I have found a problem on colo-compare that leads to segmentation fault=

> when calling qemu like this:
>
>    $ qemu-system-x86_64 -S -machine pc -object colo-compare,id=3Dtest-o=
bject
>
> First I got an assert failed:
>
>    (qemu-system-x86_64:7887): GLib-CRITICAL **: g_main_loop_quit:
> assertion 'loop !=3D NULL' failed
>
>   From this looks like s->compare_loop is NULL on the function
> colo_compare_finalize(), then I just added a check there and the assert=

> went away. But then there's the segfault:
>
>    Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fau=
lt.
>    0x00007ffff333f79e in pthread_join () from /lib64/libpthread.so.0
>    (gdb) bt
>    #0  0x00007ffff333f79e in pthread_join () at /lib64/libpthread.so.0
>    #1  0x0000555555c379d2 in qemu_thread_join (thread=3D0x7ffff7ff5160)=
 at
> util/qemu-thread-posix.c:547
>    #2  0x0000555555adfc1a in colo_compare_finalize (obj=3D0x7ffff7fd301=
0)
> at net/colo-compare.c:867
>    #3  0x0000555555b2cd87 in object_deinit (obj=3D0x7ffff7fd3010,
> type=3D0x5555567432e0) at qom/object.c:453
>    #4  0x0000555555b2cdf9 in object_finalize (data=3D0x7ffff7fd3010) at=

> qom/object.c:467
>    #5  0x0000555555b2dd80 in object_unref (obj=3D0x7ffff7fd3010) at
> qom/object.c:902
>    #6  0x0000555555b319a5 in user_creatable_add_type (type=3D0x55555674=
99a0
> "colo-compare", id=3D0x555556749960 "test-object", qdict=3D0x5555568357=
50,
> v=3D0x55555681a3f0, errp=3D0x7fffffffde58) at qom/object_interfaces.c:1=
05
>    #7  0x0000555555b31b02 in user_creatable_add_opts
> (opts=3D0x555556749910, errp=3D0x7fffffffde58) at qom/object_interfaces=
=2Ec:135
>    #8  0x0000555555b31bfd in user_creatable_add_opts_foreach
> (opaque=3D0x5555558e9c39 <object_create_delayed>, opts=3D0x555556749910=
,
> errp=3D0x0) at qom/object_interfaces.c:159
>    #9  0x0000555555c4aecf in qemu_opts_foreach (list=3D0x555556157ac0
> <qemu_object_opts>, func=3D0x555555b31b6f
> <user_creatable_add_opts_foreach>, opaque=3D0x5555558e9c39
> <object_create_delayed>, errp=3D0x0) at util/qemu-option.c:1104
>    #10 0x00005555558edb75 in main (argc=3D6, argv=3D0x7fffffffe2d8,
> envp=3D0x7fffffffe310) at vl.c:4520
>
> At this point '&s->thread' is '0'. Is this segfault and the above
> mentioned assert trigged because I'm creating a colo-compare object
> without any other parameter? In a positive case, a simple workaround an=
d
> error check should do it. Otherwise I'll debug a little more.
>
> Best regards,
