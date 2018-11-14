Received: from eggs.gnu.org ([2001:4830:134:3::10]:33146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <raistlin.df@gmail.com>) id 1gMsqm-000321-MD
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <raistlin.df@gmail.com>) id 1gMsqj-0007ws-0j
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:56:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <raistlin.df@gmail.com>)
	id 1gMsqi-0007vs-QT
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:56:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id i73-v6so9689308wmd.5
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 02:56:40 -0800 (PST)
From: Dario Faggioli <dfaggioli@suse.com>
Date: Wed, 14 Nov 2018 11:56:54 +0100
Message-ID: <154219301447.19470.4834273682384554888.stgit@wayrath>
In-Reply-To: <154219299016.19470.9372139354280787961.stgit@wayrath>
References: <154219299016.19470.9372139354280787961.stgit@wayrath>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH 1/3] i386: add properties for customizing
 L2 and L3 caches size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>

Make it possible to specify a custom size for the L2 and
L3 caches, from the command line.

This can be useful in cases where applications or libraries
check, within the guest, the cache size and behave differently
depending on what they actually see.

Signed-off-by: Dario Faggioli <dfaggioli@suse.com>
---
I am not entirely sure I got the include/hw/i386 bits right (i.e.,
whether I should include the new properties in PC_COMPAT_3_0 and, if
yes, if the stanzas are correct). I'll dig further (and accept any
help/advice :-D )
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
---
 0 files changed

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 136fe497b6..1094bba68c 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -308,6 +308,14 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = "Skylake-Server-IBRS" "-" TYPE_X86_CPU,\
         .property = "pku",\
         .value    = "off",\
+    },{\
+        .driver   = TYPE_X86_CPU,\
+        .property = "l3-cache-size",\
+        .value    = "off",\
+    },{\
+        .driver   = TYPE_X86_CPU,\
+        .property = "l2-cache-size",\
+        .value    = "off",\
     },
 
 #define PC_COMPAT_2_12 \
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f81d35e1f9..b8ccb2be04 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5778,6 +5778,14 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_INT32("x-hv-max-vps", X86CPU, hv_max_vps, -1),
     DEFINE_PROP_BOOL("x-hv-synic-kvm-only", X86CPU, hyperv_synic_kvm_only,
                      false),
+
+    /*
+     * Custom size for L2 and/or L3 cache. Default (0) means we use the
+     * default value for the CPU.
+     */
+    DEFINE_PROP_SIZE("l2-cache-size", X86CPU, l2_cache_size, 0),
+    DEFINE_PROP_SIZE("l3-cache-size", X86CPU, l3_cache_size, 0),
+
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9c52d0cbeb..ba0b913448 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1476,6 +1476,9 @@ struct X86CPU {
     int32_t core_id;
     int32_t thread_id;
 
+    uint64_t l2_cache_size;
+    uint64_t l3_cache_size;
+
     int32_t hv_max_vps;
 };
 
