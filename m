Received: from eggs.gnu.org ([2001:4830:134:3::10]:52372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etGOU-0006Th-5y
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:28:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etGOP-0007lA-2Z
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:28:54 -0500
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
	<fd62ebf7-3abc-79a2-f269-825b4f8d6598@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <818fe50b-c3b8-30c5-5452-2009762142c1@ilande.co.uk>
Date: Tue, 6 Mar 2018 17:28:09 +0000
MIME-Version: 1.0
In-Reply-To: <fd62ebf7-3abc-79a2-f269-825b4f8d6598@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/30] ppc-for-2.12 queue 20180306
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 06/03/18 16:48, Thomas Huth wrote:

> Something in the recent commits introduced a new way to cause unexpected
> aborts of QEMU:
> 
> $ ppc64-softmmu/qemu-system-ppc64 -monitor stdio
> QEMU 2.11.50 monitor - type 'help' for more information
> (qemu) device_add macio-newworld
> Unexpected error in qemu_chr_fe_init() at
> /home/thuth/devel/qemu/chardev/char-fe.c:222:
> Device 'serial0' is in use
> Aborted (core dumped)
> 
> Of course it does not make sense to add a macio-newworld device on the
> pseries machine, but QEMU should not abort in this case - it should just
> print an error message and continue afterwards. Any ideas how to fix this?

So the backtrace from git master looks like this:

Thread 1 "qemu-system-ppc" received signal SIGABRT, Aborted.
__GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51 
 
 

51      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory. 
 
 

(gdb) bt 
 
 

#0  __GI_raise (sig=sig@entry=6) at 
../sysdeps/unix/sysv/linux/raise.c:51 
 

#1  0x00007fffdbd6e3fa in __GI_abort () at abort.c:89 
 
 

#2  0x0000555555de6d86 in error_handle_fatal (errp=0x555556bdfb90 
<error_abort>, err=0x555556ef5a00) at util/error.c:38 
 

#3  0x0000555555de6eb6 in error_setv (errp=0x555556bdfb90 <error_abort>, 
src=0x555556031ad0 "chardev/char-fe.c", line=222, func=0x555556031c50 
<__func__.18713> "qemu_chr_fe_init", 
err_class=ERROR_CLASS_GENERIC_ERROR,
     fmt=0x555556031b50 "Device '%s' is in use", ap=0x7fffffffd010, 
suffix=0x0) at util/error.c:71 
 

#4  0x0000555555de7097 in error_setg_internal (errp=0x555556bdfb90 
<error_abort>, src=0x555556031ad0 "chardev/char-fe.c", line=222, 
func=0x555556031c50 <__func__.18713> "qemu_chr_fe_init", 

     fmt=0x555556031b50 "Device '%s' is in use") at util/error.c:95 
 
 

#5  0x0000555555d673fc in qemu_chr_fe_init (b=0x555557aef590, 
s=0x555556de2290, errp=0x555556bdfb90 <error_abort>) at 
chardev/char-fe.c:222 

#6  0x0000555555af5467 in set_chr (obj=0x555557aeef80, v=0x555557960c20, 
name=0x555555f65fc5 "chrA", opaque=0x555556658410 <escc_properties+432>, 
errp=0x555556bdfb90 <error_abort>) at 
hw/core/qdev-properties-system.c:216
#7  0x0000555555cb326a in object_property_set (obj=0x555557aeef80, 
v=0x555557960c20, name=0x555555f65fc5 "chrA", errp=0x555556bdfb90 
<error_abort>) at qom/object.c:1109 

#8  0x0000555555cb6232 in object_property_set_qobject 
(obj=0x555557aeef80, value=0x555557960bf0, name=0x555555f65fc5 "chrA", 
errp=0x555556bdfb90 <error_abort>) at qom/qom-qobject.c:27 

#9  0x0000555555cb32af in object_property_set_str (obj=0x555557aeef80, 
value=0x555556de23c0 "serial0", name=0x555555f65fc5 "chrA", 
errp=0x555556bdfb90 <error_abort>) at qom/object.c:1117 

#10 0x0000555555af5d94 in qdev_prop_set_chr (dev=0x555557aeef80, 
name=0x555555f65fc5 "chrA", value=0x555556de2290) at 
hw/core/qdev-properties-system.c:427
#11 0x0000555555b350a8 in macio_instance_init (obj=0x555557aec3c0) at 
hw/misc/macio/macio.c:347


It seems that the error is being raised when setting the property rather 
than during realize so I'm not sure what I can do to handle this. Any 
thoughts?


ATB,

Mark.
