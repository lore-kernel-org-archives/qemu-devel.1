Received: from eggs.gnu.org ([2001:4830:134:3::10]:55428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d6anl-0003cI-2l
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d6ani-0002o1-0M
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:49:33 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d6anh-0002nJ-DM
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:49:29 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 5 May 2017 10:49:05 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA2650C5@DGGEMA505-MBX.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [Question] SeaBIOS: cannot boot oracle linux if
 increase the maximum size of permanent high memory area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin O'Connor <kevin@koconnor.net>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "seabios@seabios.org" <seabios@seabios.org>, "Xulei (Stone)" <stone.xulei@huawei.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "Wulizhen (Pss)" <pss.wulizhen@huawei.com>

Hi guys,=20

Currently my workmate encountered an issues in the testing environment:=20

A letter from him:

In order to boot a BIG vm (with 4T mem, 255 vCPUs, 60 virtio-scsi disk...),=
 i have to increase the=20
BUILD_MAX_HIGHTABLE to 512KB.
But, then i found i can not boot a  specific VM anymore (oracle linux 6.7 6=
4bits with kernel 3.8.13, 2G mem).
It seems be related with the unused high ram given VM back by SeaBios (mayb=
e also related to the memory align).
I've tested if setting giveback memory 64KB alignment other than 4KB, SeaBi=
os with 512KB BUILD_MAX_HIGHTABLE
can boot the specific VM. But , i don't know the reason...

As far as i know, if seabios does not give back the unused ZoneHigh memory =
seems will not trigger any problems
but just waste only a little memory ,right?

Can you tell me what's the worst effect if i apply the following patch?=20

Does it influence live migration?

Thanks!


diff --git a/src/config.h b/src/config.h
index baca029..b3536f1 100644
index baca029..b3536f1 100644
--- a/src/config.h
+++ b/src/config.h
@@ -17,7 +17,7 @@
 // Maximum number of map entries in the e820 map
 #define BUILD_MAX_E820 32
 // Space to reserve in high-memory for tables
-#define BUILD_MAX_HIGHTABLE (256*1024)
+#define BUILD_MAX_HIGHTABLE (512*1024)

diff --git a/src/malloc.c b/src/malloc.c
index 3733855..6302525 100644
--- a/src/malloc.c
+++ b/src/malloc.c
@@ -549,13 +549,7 @@ malloc_prepboot(void)
     dprintf(1, "Space available for UMB: %x-%x, %x-%x\n"
             , RomEnd, base, info->range_start, info->range_end);

-    // Give back unused high ram.
-    info =3D alloc_find_lowest(&ZoneHigh);
-    if (info) {
-        u32 giveback =3D ALIGN_DOWN(info->range_end-info->range_start, PAG=
E_SIZE);
-        e820_add(info->range_start, giveback, E820_RAM);
-        dprintf(1, "Returned %d bytes of ZoneHigh\n", giveback);
-    }

     calcRamSize();



Regards,
-Gonglei
