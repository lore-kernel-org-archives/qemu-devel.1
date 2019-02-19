Received: from eggs.gnu.org ([209.51.188.92]:38269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gvzzC-00036h-3K
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gvzz9-00037P-Lh
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:38:37 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:47182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1gvzz5-00035q-Q7
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:38:32 -0500
Date: Tue, 19 Feb 2019 08:38:24 +0100
From: Sven Schnelle <svens@stackframe.org>
Message-ID: <20190219073824.GA7584@t470p.stackframe.org>
References: <20190218175529.11237-1-svens@stackframe.org>
	<20190218175529.11237-2-svens@stackframe.org>
	<861e47de-978b-b48c-d144-e50040d45bf4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <861e47de-978b-b48c-d144-e50040d45bf4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] lsi: use ldn_le_p()/stn_le_p()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>

Hi Philippe,

On Mon, Feb 18, 2019 at 10:39:54PM +0100, Philippe Mathieu-Daudé wrote:

> > -    newval = s->script_ram[addr >> 2];
> > -    shift = (addr & 3) * 8;
> > -    mask = ((uint64_t)1 << (size * 8)) - 1;
> > -    newval &= ~(mask << shift);
> > -    newval |= val << shift;
> > -    s->script_ram[addr >> 2] = newval;
> > +    stn_le_p(((void*)s->script_ram) + addr, size, val);
> 
> If you want to do pointer arithmetic, it is safer to cast to a uintptr_t.
> But since you update all the places that use script_ram[], it seems
> pointless to keep it as an array of uint32_t. We can simply convert it
> to an array of char.

You're right, i was assuming that the array is used somewhere else in the code,
but all the accesses are routed through these two functions, so it makes sense
to convert the type. However, i'm not sure whether i have to increase the version
number in the VMSTATE_BUFFER_UNSAFE() macro in that case? Are there possible
endianess issues with that change?

My current version looks like this:


commit 286d45946e235d5fdf2f95bf349b3048e3180392
Author: Sven Schnelle <svens@stackframe.org>
Date:   Tue Feb 19 06:59:23 2019 +0100

    lsi: use ldn_le_p()/stn_le_p()
    
    Signed-off-by: Sven Schnelle <svens@stackframe.org>

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index c493e3c4c7..0f9591016a 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -290,7 +290,7 @@ typedef struct {
     uint32_t adder;
 
     /* Script ram is stored as 32-bit words in host byteorder.  */
-    uint32_t script_ram[2048];
+    uint8_t script_ram[8192];
 } LSIState;
 
 #define TYPE_LSI53C810  "lsi53c810"
@@ -2078,29 +2078,14 @@ static void lsi_ram_write(void *opaque, hwaddr addr,
                           uint64_t val, unsigned size)
 {
     LSIState *s = opaque;
-    uint32_t newval;
-    uint32_t mask;
-    int shift;
-
-    newval = s->script_ram[addr >> 2];
-    shift = (addr & 3) * 8;
-    mask = ((uint64_t)1 << (size * 8)) - 1;
-    newval &= ~(mask << shift);
-    newval |= val << shift;
-    s->script_ram[addr >> 2] = newval;
+    stn_le_p(s->script_ram + addr, size, val);
 }
 
 static uint64_t lsi_ram_read(void *opaque, hwaddr addr,
                              unsigned size)
 {
     LSIState *s = opaque;
-    uint32_t val;
-    uint32_t mask;
-
-    val = s->script_ram[addr >> 2];
-    mask = ((uint64_t)1 << (size * 8)) - 1;
-    val >>= (addr & 3) * 8;
-    return val & mask;
+    return ldn_le_p(s->script_ram + addr, size);
 }
 
 static const MemoryRegionOps lsi_ram_ops = {
@@ -2243,7 +2228,7 @@ static const VMStateDescription vmstate_lsi_scsi = {
         VMSTATE_BUFFER_UNSAFE(scratch, LSIState, 0, 18 * sizeof(uint32_t)),
         VMSTATE_UINT8(sbr, LSIState),
 
-        VMSTATE_BUFFER_UNSAFE(script_ram, LSIState, 0, 2048 * sizeof(uint32_t)),
+        VMSTATE_BUFFER_UNSAFE(script_ram, LSIState, 0, 8192),
         VMSTATE_END_OF_LIST()
     }
 };
