Received: from eggs.gnu.org ([2001:4830:134:3::10]:44394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1egVfb-00037A-RJ
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:09:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1egVfY-00058u-Mb
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:09:51 -0500
References: <20180129165210.21086-1-cohuck@redhat.com>
	<20180129165210.21086-3-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3c0eb044-20ad-9f62-6ba8-caaed34cf3e5@redhat.com>
Date: Tue, 30 Jan 2018 14:09:43 +0100
MIME-Version: 1.0
In-Reply-To: <20180129165210.21086-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] s390x/cpumodel: allow zpci
 features in qemu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de

On 29.01.2018 17:52, Cornelia Huck wrote:
> AEN can be provided unconditionally, ZPCI has to be turned on
> manually (it should really depend on CONFIG_PCI).
> 
> With -cpu qemu,zpci=on, a 4.15 guest kernel can now successfully
> detect virtio-pci devices under tcg.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/s390x/gen-features.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 0570f597ec..db7ac965a0 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -574,6 +574,7 @@ static uint16_t qemu_LATEST[] = {
>      S390_FEAT_INTERLOCKED_ACCESS_2,
>      S390_FEAT_MSA_EXT_4,
>      S390_FEAT_MSA_EXT_3,
> +    S390_FEAT_ADAPTER_EVENT_NOTIFICATION,
>  };
>  
>  /* add all new definitions before this point */
> @@ -582,6 +583,8 @@ static uint16_t qemu_MAX[] = {
>      S390_FEAT_STFLE_53,
>      /* generates a dependency warning, leave it out for now */
>      S390_FEAT_MSA_EXT_5,
> +    /* should be conditional on CONFIG_PCI */
> +    S390_FEAT_ZPCI,
>  };
>  

What about something in addition like that, should work for now

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 212a5f0697..62fc8d538d 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -23,6 +23,7 @@
 #include "qapi/qmp/qbool.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/arch_init.h"
+#include "hw/pci/pci.h"
 #endif

 #define CPUDEF_INIT(_type, _gen, _ec_ga, _mha_pow, _hmfai, _name, _desc) \
@@ -1271,6 +1272,12 @@ static void register_types(void)

     /* init all bitmaps from gnerated data initially */
     s390_init_feat_bitmap(qemu_max_cpu_feat_init, qemu_max_cpu_feat);
+#ifndef CONFIG_USER_ONLY
+    if (!pci_available) {
+        clear_bit(S390_FEAT_ZPCI, qemu_max_cpu_feat);
+    }
+#endif
+
     for (i = 0; i < ARRAY_SIZE(s390_cpu_defs); i++) {
         s390_init_feat_bitmap(s390_cpu_defs[i].base_init,
                               s390_cpu_defs[i].base_feat);



>  /****** END FEATURE DEFS ******/
> 


-- 

Thanks,

David / dhildenb
