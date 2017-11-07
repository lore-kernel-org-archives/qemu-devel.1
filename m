Received: from eggs.gnu.org ([2001:4830:134:3::10]:45566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eBroA-0008NQ-13
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eBro5-0004PX-0Y
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:32:02 -0500
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:50572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eBro4-0004P5-Qu
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:31:56 -0500
Received: by mail-pg0-x231.google.com with SMTP id y5so9596308pgq.7
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 16:31:56 -0800 (PST)
References: <20171103193802.11876-1-laurent@vivier.eu>
	<20076e3b-883a-b669-8453-f870eda6e31a@ozlabs.ru>
	<425ee57b-641a-b8d3-7700-1ddcbc243ec3@vivier.eu>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <1c023bba-4a43-369a-cdc1-b173f95560e2@ozlabs.ru>
Date: Tue, 7 Nov 2017 11:31:51 +1100
MIME-Version: 1.0
In-Reply-To: <425ee57b-641a-b8d3-7700-1ddcbc243ec3@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: remove nmi.c and
 fw-path-provider.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Riku Voipio <riku.voipio@linaro.org>

On 06/11/17 21:15, Laurent Vivier wrote:
> Le 06/11/2017 à 01:44, Alexey Kardashevskiy a écrit :
>> On 04/11/17 06:38, Laurent Vivier wrote:
>>> linux-user binaries don't need firmware and NMI,
>>> so don't add them in this case, move QDEV
>>> firmware functions to qdev-fw.c
>>
>>
>> When configured with --target-list=ppc64-linux-user , config-host.mak gets
>> TARGET_DIRS=ppc64-linux-user  and I would expect CONFIG_SOFTMMU to be
>> disabled in Makefile#27 and qdev.c not to be compiled at all but this is
>> not happening, I wonder why...
> 
> this is driven by config-target.mak and config-target.h which are target
> specific.
> 
> for ppc64-linux-user, you have ppc64-linux-user/config-target.mak:
> ...
> CONFIG_LINUX_USER=y
> ...
> 
> for ppc64-softmmu/config-target.mak:
> ...
> CONFIG_SOFTMMU=y
> ...


Ah, I get it, Makefile.objs includes:
common-obj-y += hw/

and hw/Makefile.objs includes:
devices-dirs-y += core/

and hw/core/Makefile.objs includes:
common-obj-y += qdev.o

and nowhere it checks that CONFIG_SOFTMMU is not set as hw/core/* files
still export symbols needed by qom/cpu.c and TCG so doing as below does not
help. I'd suggest moving shared stuff out of hw/ and stop including hw/ in
linus-user builds (basically, apply the patch below and resolve
compile/link errors) but I suspect it is not that easy (or even correct)
but if it is correct, I could give it a try.


Paolo?



diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index f8d7a4aaed..be8d89dc0a 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -1,6 +1,6 @@
 # core qdev-related obj files, also used by *-user:
-common-obj-y += qdev.o qdev-properties.o
-common-obj-y += bus.o reset.o
+obj-$(CONFIG_SOFTMMU) += qdev.o qdev-properties.o bus.o
+common-obj-y += reset.o
 common-obj-y += fw-path-provider.o
 # irq.o needed for qdev GPIO handling:
 common-obj-y += irq.o
diff --git a/qom/Makefile.objs b/qom/Makefile.objs
index 516349eec3..479929705a 100644
--- a/qom/Makefile.objs
+++ b/qom/Makefile.objs
@@ -1,4 +1,4 @@
 qom-obj-y = object.o container.o qom-qobject.o
 qom-obj-y += object_interfaces.o

-common-obj-y = cpu.o
+obj-$(CONFIG_SOFTMMU) = cpu.o



-- 
Alexey
