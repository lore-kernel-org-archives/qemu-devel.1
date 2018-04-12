Received: from eggs.gnu.org ([2001:4830:134:3::10]:40725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f6dy2-0007XT-9y
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f6dxx-0000wu-BF
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:16:54 -0400
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:38478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f6dxx-0000w7-3Z
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:16:49 -0400
Received: from player773.ha.ovh.net (unknown [10.109.122.49])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id E2FDBADB01
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 17:16:46 +0200 (CEST)
References: <20180412101858.21304-1-clg@kaod.org>
	<CAFEAcA8wJCSwtpypvH+3HKvv39o9bPC1vXJ_Co4VwiZTOt78ZA@mail.gmail.com>
	<20180412115326.GF2704@work-vm>
	<CAFEAcA9-LzsfBpnYJUVc7j6j4ePUyiQYqGv3EaGjvAgw-3nyKw@mail.gmail.com>
	<3432d654-c562-505e-e341-afe9d8fdf6cb@kaod.org>
	<CAFEAcA9G_ZwrZ1HkuvUPzOHadYbq7fKu819K=kFieMccDwt1AQ@mail.gmail.com>
	<a2a27461-c792-9204-849d-9c7c0ffbd0c6@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <698c684b-bdf5-fb62-7140-3d8b5fb7556a@kaod.org>
Date: Thu, 12 Apr 2018 17:16:28 +0200
MIME-Version: 1.0
In-Reply-To: <a2a27461-c792-9204-849d-9c7c0ffbd0c6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: discard RAMBlocks of type
 ram_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com, Eric Blake <eblake@redhat.com>

On 04/12/2018 04:11 PM, Paolo Bonzini wrote:
> On 12/04/2018 15:51, Peter Maydell wrote:
>> Paolo may have an opinion what the API here should be, but
>> at the MemoryRegion level we already have a mix of functions
>> memory_region_init_foo_nomigrate() and memory_region_init_foo(),
>> which at the moment just control whether we call
>> vmstate_register_ram() or not. Is it possible to hook into that,
>> so that we default to marking RAMBlocks as not-migrated, and
>> when vmstate_register_ram() is called we set the flag to
>> "migrated"?
> 
> Yes, that sounds pretty.

I have added the MIGRATABLE flag un/setting under qemu_ram_un/set_idstr() 
which are the only routines called by vmstate_un/register_ram().   
Tell me if that's fine or if you'd rather have helpers to
set MIGRATABLE from savem ? below is some code extract.

Thanks,

C.

>> NB: this probably requires careful thought to make sure we
>> don't accidentally break migration compat, but it seems like
>> the cleaner approach. At the moment we do weird things if you
>> migrate a RAM block that hasn't had its ID string set, IIRC,
>> so just not migrating those RAM blocks seems like a better
>> plan than mishandling them. It would also mean that the
>> vmstate_register/unregister_ram() functions did what they
>> claim to do based on the function name, I think.

--- qemu-xive.git.orig/exec.c
+++ qemu-xive.git/exec.c
@@ -104,6 +104,9 @@ static MemoryRegion io_mem_unassigned;
  * (Set during postcopy)
  */
 #define RAM_UF_ZEROPAGE (1 << 3)
+
+/* RAM can be migrated */
+#define RAM_MIGRATABLE (1 << 4)
 #endif
 
 #ifdef TARGET_PAGE_BITS_VARY
@@ -1807,6 +1810,11 @@ void qemu_ram_set_uf_zeroable(RAMBlock *
     rb->flags |= RAM_UF_ZEROPAGE;
 }
 
+bool qemu_ram_is_migratable(RAMBlock *rb)
+{
+    return rb->flags & RAM_MIGRATABLE;
+}
+
 /* Called with iothread lock held.  */
 void qemu_ram_set_idstr(RAMBlock *new_block, const char *name, DeviceState *dev)
 {
@@ -1823,6 +1831,7 @@ void qemu_ram_set_idstr(RAMBlock *new_bl
         }
     }
     pstrcat(new_block->idstr, sizeof(new_block->idstr), name);
+    new_block->flags |= RAM_MIGRATABLE;
 
     rcu_read_lock();
     RAMBLOCK_FOREACH(block) {
@@ -1845,6 +1854,7 @@ void qemu_ram_unset_idstr(RAMBlock *bloc
      */
     if (block) {
         memset(block->idstr, 0, sizeof(block->idstr));
+        block->flags &= ~RAM_MIGRATABLE;
     }
 }
