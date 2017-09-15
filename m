Received: from eggs.gnu.org ([2001:4830:134:3::10]:41323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dspFj-00048K-0W
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 07:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dspFf-0006gT-Td
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 07:57:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dspFf-0006g9-Lv
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 07:57:43 -0400
References: <20170915101406.27823-1-cohuck@redhat.com>
	<20170915101406.27823-2-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <37791e7b-c096-3e88-4121-4f1739615367@redhat.com>
Date: Fri, 15 Sep 2017 13:57:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170915101406.27823-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] s390x/ccw: create s390 phb for
 compat reasons as well
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On 15.09.2017 12:14, Cornelia Huck wrote:
> d32bd032d8 ("s390x/ccw: create s390 phb conditionally") made
> registering the s390 pci host bridge conditional on presense
> of the zpci facility bit. Sadly, that breaks migration from
> some old machines.
> 
> Create the s390 phb if we need it for compat reasons, even if
> we don't provide the zpci facility.
> 
> Fixes: d32bd032d8 ("s390x/ccw: create s390 phb conditionally")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c         | 6 +++++-
>  include/hw/s390x/s390-virtio-ccw.h | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 0471407187..7e3148eb4a 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -269,6 +269,8 @@ static void s390_create_virtio_net(BusState *bus, const char *name)
>      }
>  }
>  
> +static S390CcwMachineClass *get_machine_class(void);
> +
>  static void ccw_init(MachineState *machine)
>  {
>      int ret;
> @@ -288,7 +290,7 @@ static void ccw_init(MachineState *machine)
>                        machine->initrd_filename, "s390-ccw.img",
>                        "s390-netboot.img", true);
>  
> -    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +    if (s390_has_feat(S390_FEAT_ZPCI) || get_machine_class()->pci_compat) {
>          DeviceState *dev = qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
>          object_property_add_child(qdev_get_machine(),
>                                    TYPE_S390_PCI_HOST_BRIDGE,
> @@ -429,6 +431,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>      s390mc->cpu_model_allowed = true;
>      s390mc->css_migration_enabled = true;
>      s390mc->gs_allowed = true;
> +    s390mc->pci_compat = false;
>      mc->init = ccw_init;
>      mc->reset = s390_machine_reset;
>      mc->hot_add_cpu = s390_hot_add_cpu;
> @@ -784,6 +787,7 @@ static void ccw_machine_2_7_class_options(MachineClass *mc)
>      S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
>  
>      s390mc->cpu_model_allowed = false;
> +    s390mc->pci_compat = pci_available;
>      ccw_machine_2_8_class_options(mc);
>      SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_7);
>  }
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
> index a9a90c2022..9978c89e90 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -41,6 +41,7 @@ typedef struct S390CcwMachineClass {
>      bool cpu_model_allowed;
>      bool css_migration_enabled;
>      bool gs_allowed;
> +    bool pci_compat;
>  } S390CcwMachineClass;
>  
>  /* runtime-instrumentation allowed by the machine */
> 

As an alternative, simply

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 0f28ebd162..0f22efc3b6 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -195,6 +195,8 @@ bool s390_has_feat(S390Feat feat)
                 return true;
             }
         }
+        if (feat == S390_FEAT_ZPCI)
+            return true;
 #endif
         return 0;
     }


(this is also the way we handle other features without cpu model support
-especially if cpu model support is disabled for older machines)

-- 

Thanks,

David
