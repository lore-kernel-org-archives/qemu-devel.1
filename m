Received: from eggs.gnu.org ([2001:4830:134:3::10]:46659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f1bYA-0006Eh-Bk
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 13:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f1bY6-0001Cb-Bz
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 13:41:22 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:40961)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f1bY6-0001AK-29
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 13:41:18 -0400
References: <CAMo8BfKW3g6K4MU+eEz71Cq-FaSWox4ffHjj-1_zj9jM9CB7jw@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7952e90a-d976-cf13-0781-a67fa73324ca@vivier.eu>
Date: Thu, 29 Mar 2018 19:41:05 +0200
MIME-Version: 1.0
In-Reply-To: <CAMo8BfKW3g6K4MU+eEz71Cq-FaSWox4ffHjj-1_zj9jM9CB7jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] linux-user: missing synchronization in CPU object
 realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

Hi,

I think multi-threading and locking questions are more for Alex Bennée.

Alex, any comment?

Thanks,
Laurent

Le 29/03/2018 à 16:15, Max Filippov a écrit :
> Hello,
> 
> I'm running xtensa linux-user application that rapidly creates
> a lot of threads and I observe the following assertion failure:
> 
> (process:26953): GLib-CRITICAL **: g_hash_table_iter_next: assertion
> 'ri->version == ri->hash_table->version' failed
> **
> ERROR:qemu/qom/object.c:1663:object_get_canonical_path_component: code
> should not be reached
> 
> The backtrace:
> 
> #0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
> #1  0x00007ffff667c42a in __GI_abort () at abort.c:89
> #2  0x00007ffff79345a5 in g_assertion_message
> (domain=domain@entry=0x0, file=file@entry=0x5555557f8ef8
> "/home/jcmvbkbc/ws/tensilica/qemu/qemu/qom/object.c",
> line=line@entry=1662,
>     func=func@entry=0x5555557f96c0 <__func__.17879>
> "object_get_canonical_path_component",
> message=message@entry=0x7fffa80808a0 "code should not be reached") at
> ././glib/gtestutils.c:2432
> #3  0x00007ffff793463a in g_assertion_message_expr (domain=0x0,
> file=0x5555557f8ef8
> "/home/jcmvbkbc/ws/tensilica/qemu/qemu/qom/object.c", line=1662,
>     func=0x5555557f96c0 <__func__.17879>
> "object_get_canonical_path_component", expr=<optimized out>) at
> ././glib/gtestutils.c:2455
> #4  0x00005555556c6cec in object_get_canonical_path_component
> (obj=0x7fffa80777d0) at
> /home/jcmvbkbc/ws/tensilica/qemu/qemu/qom/object.c:1662
> #5  0x00005555556c6d1e in object_get_canonical_path
> (obj=0x7fffa80777d0) at
> /home/jcmvbkbc/ws/tensilica/qemu/qemu/qom/object.c:1672
> #6  0x00005555556bc693 in device_set_realized (obj=0x7fffa80777d0,
> value=true, errp=0x7ffff7f020f8) at
> /home/jcmvbkbc/ws/tensilica/qemu/qemu/hw/core/qdev.c:874
> #7  0x00005555556c75c4 in property_set_bool (obj=0x7fffa80777d0,
> v=0x7fffa8080750, name=0x5555557f889c "realized",
> opaque=0x7fffa8077660, errp=0x7ffff7f020f8) at
> /home/jcmvbkbc/ws/tensilica/qemu/qemu/qom/object.c:1923
> #8  0x00005555556c58ea in object_property_set (obj=0x7fffa80777d0,
> v=0x7fffa8080750, name=0x5555557f889c "realized", errp=0x7ffff7f020f8)
> at /home/jcmvbkbc/ws/tensilica/qemu/qemu/qom/object.c:1122
> #9  0x00005555556c8901 in object_property_set_qobject
> (obj=0x7fffa80777d0, value=0x7fffa80806a0, name=0x5555557f889c
> "realized", errp=0x7ffff7f020f8) at
> /home/jcmvbkbc/ws/tensilica/qemu/qemu/qom/qom-qobject.c:27
> #10 0x00005555556c5b62 in object_property_set_bool
> (obj=0x7fffa80777d0, value=true, name=0x5555557f889c "realized",
> errp=0x7ffff7f020f8) at
> /home/jcmvbkbc/ws/tensilica/qemu/qemu/qom/object.c:1188
> #11 0x00005555556c166f in cpu_create (typename=0x555557cb0d20
> "dc233c-xtensa-cpu") at
> /home/jcmvbkbc/ws/tensilica/qemu/qemu/qom/cpu.c:64
> #12 0x000055555564ec0e in cpu_copy (env=0x55555924d420) at
> /home/jcmvbkbc/ws/tensilica/qemu/qemu/linux-user/main.c:4121
> #13 0x000055555565d4e1 in do_fork (env=0x55555924d420, flags=4001536,
> newsp=829419520, parent_tidptr=829420792, newtls=829421856,
> child_tidptr=829420792) at
> /home/jcmvbkbc/ws/tensilica/qemu/qemu/linux-user/syscall.c:6350
> #14 0x00005555556664c7 in do_syscall (cpu_env=0x55555924d420, num=116,
> arg1=4001536, arg2=829419520, arg3=829420792, arg4=829421856,
> arg5=829420792, arg6=829420688, arg7=0, arg8=0)
>     at /home/jcmvbkbc/ws/tensilica/qemu/qemu/linux-user/syscall.c:10003
> #15 0x000055555564e85b in cpu_loop (env=0x55555924d420) at
> /home/jcmvbkbc/ws/tensilica/qemu/qemu/linux-user/main.c:3999
> #16 0x000055555565d3d9 in clone_func (arg=0x7fffffffbcd0) at
> /home/jcmvbkbc/ws/tensilica/qemu/qemu/linux-user/syscall.c:6313
> #17 0x00007ffff69ee494 in start_thread (arg=0x7ffff7f04700) at
> pthread_create.c:333
> #18 0x00007ffff6730acf in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:97
> 
> This happens because multiple threads concurrently call
> object_property_set_bool to realize cpu object in cpu_create,
> which results in the following call chain:
>   device_set_realized -> object_property_add_child ->
>   object_property_add -> g_hash_table_insert
> inserting newly created CPUs as children to /unattached without
> any locking.
> 
> I've put locking around the
>  object_property_set_bool(OBJECT(cpu), true, "realized", &err);
> call in the cpu_create and that fixed this issue. Any suggestion
> regarding how to fix this properly?
> 
