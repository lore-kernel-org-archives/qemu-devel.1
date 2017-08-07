Received: from eggs.gnu.org ([2001:4830:134:3::10]:56950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1delDT-0007MF-IF
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1delDO-0005OA-KP
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:49:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1delDO-0005Mp-Al
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:49:14 -0400
Reply-To: otubo@redhat.com
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <6b32aeb2-d488-eb3c-4147-a99fe4681a6f@redhat.com>
Date: Mon, 7 Aug 2017 18:39:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] colo-compare: segfault and assert on
 colo_compare_finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: zhang.zhanghailiang@huawei.com, wency@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, wang.guang55@zte.com.cn, wang.yong155@zte.com.cn

(please ignore my last email, looks like mutt wants play games lately)

Hi all,

I have found a problem on colo-compare that leads to segmentation fault
when calling qemu like this:

  $ qemu-system-x86_64 -S -machine pc -object colo-compare,id=test-object

First I got an assert failed:

  (qemu-system-x86_64:7887): GLib-CRITICAL **: g_main_loop_quit: 
assertion 'loop != NULL' failed

 From this looks like s->compare_loop is NULL on the function
colo_compare_finalize(), then I just added a check there and the assert 
went away. But then there's the segfault:

  Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
  0x00007ffff333f79e in pthread_join () from /lib64/libpthread.so.0
  (gdb) bt
  #0  0x00007ffff333f79e in pthread_join () at /lib64/libpthread.so.0
  #1  0x0000555555c379d2 in qemu_thread_join (thread=0x7ffff7ff5160) at 
util/qemu-thread-posix.c:547
  #2  0x0000555555adfc1a in colo_compare_finalize (obj=0x7ffff7fd3010) 
at net/colo-compare.c:867
  #3  0x0000555555b2cd87 in object_deinit (obj=0x7ffff7fd3010, 
type=0x5555567432e0) at qom/object.c:453
  #4  0x0000555555b2cdf9 in object_finalize (data=0x7ffff7fd3010) at 
qom/object.c:467
  #5  0x0000555555b2dd80 in object_unref (obj=0x7ffff7fd3010) at 
qom/object.c:902
  #6  0x0000555555b319a5 in user_creatable_add_type (type=0x5555567499a0 
"colo-compare", id=0x555556749960 "test-object", qdict=0x555556835750, 
v=0x55555681a3f0, errp=0x7fffffffde58) at qom/object_interfaces.c:105
  #7  0x0000555555b31b02 in user_creatable_add_opts 
(opts=0x555556749910, errp=0x7fffffffde58) at qom/object_interfaces.c:135
  #8  0x0000555555b31bfd in user_creatable_add_opts_foreach 
(opaque=0x5555558e9c39 <object_create_delayed>, opts=0x555556749910, 
errp=0x0) at qom/object_interfaces.c:159
  #9  0x0000555555c4aecf in qemu_opts_foreach (list=0x555556157ac0 
<qemu_object_opts>, func=0x555555b31b6f 
<user_creatable_add_opts_foreach>, opaque=0x5555558e9c39 
<object_create_delayed>, errp=0x0) at util/qemu-option.c:1104
  #10 0x00005555558edb75 in main (argc=6, argv=0x7fffffffe2d8, 
envp=0x7fffffffe310) at vl.c:4520

At this point '&s->thread' is '0'. Is this segfault and the above 
mentioned assert trigged because I'm creating a colo-compare object 
without any other parameter? In a positive case, a simple workaround and 
error check should do it. Otherwise I'll debug a little more.

Best regards,
-- 
Eduardo Otubo
Senior Software Engineer // Red Hat Hyper-V Virtualization, Berlin, DE
IRC: otubo@{RedHat, OFTC, Freenode}
