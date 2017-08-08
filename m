Received: from eggs.gnu.org ([2001:4830:134:3::10]:57703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1df5Vz-0005tV-4I
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1df5Vv-0006Ri-5D
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:29:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1df5Vu-0006RJ-St
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:29:43 -0400
References: <6b32aeb2-d488-eb3c-4147-a99fe4681a6f@redhat.com>
	<5989A0D0.6010304@huawei.com>
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <72850633-e8e6-afe7-148f-695888c23438@redhat.com>
Date: Tue, 8 Aug 2017 16:29:34 +0200
MIME-Version: 1.0
In-Reply-To: <5989A0D0.6010304@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org
Cc: wency@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, wang.guang55@zte.com.cn, wang.yong155@zte.com.cn

On 08/08/2017 01:30 PM, Hailiang Zhang wrote:
> Hi,
>=20
> Did you test this branch=20
> https://github.com/coloft/qemu/tree/colo-for-qemu-2.10-2017-4-22 ?
>=20
> This seems to be an already known problem, I'm not quite sure, it may b=
e=20
> fixed by this patch

It's not :( Using your branch I don't see the assert() error anymore,=20
but the segfault remains and apparently in the same place:

Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x00007ffff30ec79e in pthread_join () from /lib64/libpthread.so.0
(gdb) bt
#0  0x00007ffff30ec79e in pthread_join () at /lib64/libpthread.so.0
#1  0x0000555555c0b807 in qemu_thread_join (thread=3D0x7ffff7ff5130) at=20
util/qemu-thread-posix.c:504
#2  0x0000555555ac96c2 in colo_compare_finalize (obj=3D0x7ffff7fd3010) at=
=20
net/colo-compare.c:873
#3  0x0000555555b12f90 in object_deinit (obj=3D0x7ffff7fd3010,=20
type=3D0x5555566e4c70) at qom/object.c:454
#4  0x0000555555b13002 in object_finalize (data=3D0x7ffff7fd3010) at=20
qom/object.c:468
#5  0x0000555555b13f92 in object_unref (obj=3D0x7ffff7fd3010) at=20
qom/object.c:903
#6  0x0000555555b17a3e in user_creatable_add_type (type=3D0x5555566eb270=20
"colo-compare", id=3D0x5555566eb230 "test-object", qdict=3D0x555556781bc0=
,=20
v=3D0x5555567798f0, errp=3D0x7fffffffde58) at qom/object_interfaces.c:104
#7  0x0000555555b17b9b in user_creatable_add_opts (opts=3D0x5555566eb1e0,=
=20
errp=3D0x7fffffffde58) at qom/object_interfaces.c:134
#8  0x0000555555b17c96 in user_creatable_add_opts_foreach=20
(opaque=3D0x5555558e3562 <object_create_delayed>, opts=3D0x5555566eb1e0,=20
errp=3D0x0) at qom/object_interfaces.c:158
#9  0x0000555555c1e634 in qemu_opts_foreach (list=3D0x5555561077a0=20
<qemu_object_opts>, func=3D0x555555b17c08=20
<user_creatable_add_opts_foreach>, opaque=3D0x5555558e3562=20
<object_create_delayed>, errp=3D0x0) at util/qemu-option.c:1114
#10 0x00005555558e7441 in main (argc=3D6, argv=3D0x7fffffffe2d8,=20
envp=3D0x7fffffffe310) at vl.c:4455

So, from what you're saying, this is *not* caused by the lack of=20
parameter on the command line. Right?

>=20
> b19456dd0ea4eb418ad093f092adbb882be13054
> char: Fix removing wrong GSource that be found by fd_in_tag
> We use fd_in_tag to find a GSource, fd_in_tag is return value of=20
> g_source_attach(GSource *source, GMainContext *context), the return=20
> value is unique only in the same context, so we may get the same values=
=20
> with different 'context' parameters. It is no problem to find the right=
=20
> fd_in_tag by using g_main_context_find_source_by_id(GMainContext=20
> *context, guint source_id) while there is only one default main context=
.=20
> But colo-compare tries to create/use its own context, and if we pass=20
> wrong 'context' parameter with right fd_in_tag, we will find a wrong=20
> GSource to handle. We tried to fix the related codes in commit=20
> b43decb015a6efeb9e3cdbdb80f6547ad7248a4c, but it didn't fix the bug=20
> completely, because we still have some codes didn't pass *right* contex=
t=20
> parameter for remove_fd_in_watch(). Let's fix it by record the GSource=20
> directly instead of fd_in_tag. Signed-off-by: zhanghailiang=20
> <zhang.zhanghailiang@huawei.com> Reviewed-by: Marc-Andr=C3=83=C2=A9 Lur=
eau=20
> <marcandre.lureau@redhat.com> Message-Id:=20
> <1492564532-91680-1-git-send-email-zhang.zhanghailiang@huawei.com>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com> Actually, we have=20
> already re-writed this part, and please follow the later series. Thanks=
,=20
> Hailiang
>=20
> On 2017/8/8 0:39, Eduardo Otubo wrote:
>> (please ignore my last email, looks like mutt wants play games lately)
>>
>> Hi all,
>>
>> I have found a problem on colo-compare that leads to segmentation faul=
t
>> when calling qemu like this:
>>
>>    $ qemu-system-x86_64 -S -machine pc -object colo-compare,id=3Dtest-=
object
>>
>> First I got an assert failed:
>>
>>    (qemu-system-x86_64:7887): GLib-CRITICAL **: g_main_loop_quit:
>> assertion 'loop !=3D NULL' failed
>>
>>   From this looks like s->compare_loop is NULL on the function
>> colo_compare_finalize(), then I just added a check there and the asser=
t
>> went away. But then there's the segfault:
>>
>>    Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fa=
ult.
>>    0x00007ffff333f79e in pthread_join () from /lib64/libpthread.so.0
>>    (gdb) bt
>>    #0  0x00007ffff333f79e in pthread_join () at /lib64/libpthread.so.0
>>    #1  0x0000555555c379d2 in qemu_thread_join (thread=3D0x7ffff7ff5160=
) at
>> util/qemu-thread-posix.c:547
>>    #2  0x0000555555adfc1a in colo_compare_finalize (obj=3D0x7ffff7fd30=
10)
>> at net/colo-compare.c:867
>>    #3  0x0000555555b2cd87 in object_deinit (obj=3D0x7ffff7fd3010,
>> type=3D0x5555567432e0) at qom/object.c:453
>>    #4  0x0000555555b2cdf9 in object_finalize (data=3D0x7ffff7fd3010) a=
t
>> qom/object.c:467
>>    #5  0x0000555555b2dd80 in object_unref (obj=3D0x7ffff7fd3010) at
>> qom/object.c:902
>>    #6  0x0000555555b319a5 in user_creatable_add_type (type=3D0x5555567=
499a0
>> "colo-compare", id=3D0x555556749960 "test-object", qdict=3D0x555556835=
750,
>> v=3D0x55555681a3f0, errp=3D0x7fffffffde58) at qom/object_interfaces.c:=
105
>>    #7  0x0000555555b31b02 in user_creatable_add_opts
>> (opts=3D0x555556749910, errp=3D0x7fffffffde58) at qom/object_interface=
s.c:135
>>    #8  0x0000555555b31bfd in user_creatable_add_opts_foreach
>> (opaque=3D0x5555558e9c39 <object_create_delayed>, opts=3D0x55555674991=
0,
>> errp=3D0x0) at qom/object_interfaces.c:159
>>    #9  0x0000555555c4aecf in qemu_opts_foreach (list=3D0x555556157ac0
>> <qemu_object_opts>, func=3D0x555555b31b6f
>> <user_creatable_add_opts_foreach>, opaque=3D0x5555558e9c39
>> <object_create_delayed>, errp=3D0x0) at util/qemu-option.c:1104
>>    #10 0x00005555558edb75 in main (argc=3D6, argv=3D0x7fffffffe2d8,
>> envp=3D0x7fffffffe310) at vl.c:4520
>>
>> At this point '&s->thread' is '0'. Is this segfault and the above
>> mentioned assert trigged because I'm creating a colo-compare object
>> without any other parameter? In a positive case, a simple workaround a=
nd
>> error check should do it. Otherwise I'll debug a little more.
>>
>> Best regards,
>=20
