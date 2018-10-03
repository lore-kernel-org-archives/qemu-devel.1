Received: from eggs.gnu.org ([2001:4830:134:3::10]:41429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7eqR-0007NC-0p
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7epM-0000mr-B8
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:56:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7epL-0000lc-BQ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:56:24 -0400
References: <20180921082041.29380-1-rkagan@virtuozzo.com>
	<20180921082041.29380-4-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eac406e9-13d0-31e3-9b80-15d1fa46e165@redhat.com>
Date: Wed, 3 Oct 2018 12:56:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180921082041.29380-4-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] hyperv: factor out arch-independent
 API into hw/hyperv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, Liran Alon <liran.alon@oracle.com>, Igor Mammedov <imammedo@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>

On 21/09/2018 10:20, Roman Kagan wrote:
> A significant part of hyperv.c is not actually tied to x86, and can
> be moved to hw/.
> 
> This will allow to maintain most of Hyper-V and VMBus
> target-independent, and to avoid conflicts with inclusion of
> arch-specific headers down the road in VMBus implementation.
> 
> Also this stuff can now be opt-out with CONFIG_HYPERV.
> 
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>

We can squash this in too:

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index b8f4675219..30722ccf98 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -9,7 +9,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += cpu/
 devices-dirs-$(CONFIG_SOFTMMU) += display/
 devices-dirs-$(CONFIG_SOFTMMU) += dma/
 devices-dirs-$(CONFIG_SOFTMMU) += gpio/
-devices-dirs-$(CONFIG_SOFTMMU) += hyperv/
+devices-dirs-$(CONFIG_HYPERV) += hyperv/
 devices-dirs-$(CONFIG_SOFTMMU) += i2c/
 devices-dirs-$(CONFIG_SOFTMMU) += ide/
 devices-dirs-$(CONFIG_SOFTMMU) += input/
diff --git a/hw/hyperv/Makefile.objs b/hw/hyperv/Makefile.objs
index 19928b726e..edaca2f763 100644
--- a/hw/hyperv/Makefile.objs
+++ b/hw/hyperv/Makefile.objs
@@ -1 +1,2 @@
-obj-$(CONFIG_HYPERV) += hyperv.o
+obj-y += hyperv.o
+obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
diff --git a/hw/misc/hyperv_testdev.c b/hw/hyperv/hyperv_testdev.c
similarity index 100%
rename from hw/misc/hyperv_testdev.c
rename to hw/hyperv/hyperv_testdev.c
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 6d50b03cfd..680350b3c3 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -71,7 +71,6 @@ obj-$(CONFIG_IOTKIT_SYSCTL) += iotkit-sysctl.o
 obj-$(CONFIG_IOTKIT_SYSINFO) += iotkit-sysinfo.o

 obj-$(CONFIG_PVPANIC) += pvpanic.o
-obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
 obj-$(CONFIG_AUX) += auxbus.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
 obj-$(CONFIG_MSF2) += msf2-sysreg.o


Paolo
