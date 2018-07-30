Received: from eggs.gnu.org ([2001:4830:134:3::10]:53212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fkAKr-0003No-I6
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fkAKn-0007tx-CV
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:43:49 -0400
References: <1532959766-53343-1-git-send-email-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2a2bedc4-e7c6-4284-51d7-94dae1ec6094@redhat.com>
Date: Mon, 30 Jul 2018 17:43:42 +0200
MIME-Version: 1.0
In-Reply-To: <1532959766-53343-1-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/sclp: fix maxram calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, imbrenda@linux.vnet.ibm.com

On 30.07.2018 16:09, Christian Borntraeger wrote:
> We clamp down ram_size to match the sclp increment size. We do
> not do the same for maxram_size, which means for large guests
> with some sizes (e.g. -m 50000) maxram_size differs from ram_size.
> This can break other code (e.g. CMMA migration) which uses maxram_size
> to calculate the number of pages and then throws some errors.
> 
> Fixes: 82fab5c5b90e468f3e9d54c ("s390x/sclp: remove memory hotplug support")
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> CC: qemu-stable@nongnu.org
> CC: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/sclp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index bd2a024..4510a80 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -320,6 +320,7 @@ static void sclp_memory_init(SCLPDevice *sclp)
>      initial_mem = initial_mem >> increment_size << increment_size;
>  
>      machine->ram_size = initial_mem;
> +    machine->maxram_size = initial_mem;
>      /* let's propagate the changed ram size into the global variable. */
>      ram_size = initial_mem;
>  }
> 

BTW, I handle it in may private patch like this

 static inline SCLPDevice *get_sclp_device(void)
 {
@@ -319,9 +321,12 @@ static void sclp_memory_init(SCLPDevice *sclp)
      * down to align with the nearest increment boundary. */
     initial_mem = initial_mem >> increment_size << increment_size;

-    machine->ram_size = initial_mem;
-    /* let's propagate the changed ram size into the global variable. */
-    ram_size = initial_mem;
+    /* propagate the changed ram size into the different places */
+    if (initial_mem != machine->ram_size) {
+        machine->maxram_size -= machine->ram_size - initial_mem;
+        machine->ram_size = initial_mem;
+        ram_size = initial_mem;
+    }
 }

You would right now overwrite any maxmem setting (which might be ok as
we don't support it yet).

-- 

Thanks,

David / dhildenb
