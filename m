Received: from eggs.gnu.org ([2001:4830:134:3::10]:58947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.engraf@sysgo.com>) id 1cTWvm-0001vJ-Be
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 11:48:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.engraf@sysgo.com>) id 1cTWvk-0000Nr-O1
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 11:48:22 -0500
References: <98b1ad64-fe10-4ede-3493-f6d4b49ee1d9@sysgo.com>
	<CAFEAcA8asry6LGTuv+SLVyemNVFk9Q7WhU74Cc2YA_yud8qPMg@mail.gmail.com>
	<20170112113619.zuc5tuhmhzvawnmz@hawk.localdomain>
	<20170116102606.GB2136@work-vm>
From: David Engraf <david.engraf@sysgo.com>
Message-ID: <52cf298f-272a-d2f4-9962-7048087a6afb@sysgo.com>
Date: Tue, 17 Jan 2017 17:48:11 +0100
MIME-Version: 1.0
In-Reply-To: <20170116102606.GB2136@work-vm>
Content-Type: multipart/mixed; boundary="------------FF6F1E9E33C6397296B55BCC"
Subject: Re: [Qemu-devel] [PATCH v2] pflash_cfi01: fix per device sector
 length in CFI table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Andrew Jones <drjones@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is a multi-part message in MIME format.
--------------FF6F1E9E33C6397296B55BCC
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Am 16.01.2017 um 11:26 schrieb Dr. David Alan Gilbert:
> * Andrew Jones (drjones@redhat.com) wrote:
>> On Thu, Jan 12, 2017 at 10:42:41AM +0000, Peter Maydell wrote:
>>> On 12 January 2017 at 10:35, David Engraf <david.engraf@sysgo.com> wrote:
>>>> The CFI entry for sector length must be set to sector length per device.
>>>> This is important for boards using multiple devices like the ARM Vexpress
>>>> board (width = 4, device-width = 2).
>>>>
>>>> Linux and u-boots calculate the size ratio by dividing both values:
>>>>
>>>> size_ratio = info->portwidth / info->chipwidth;
>>>>
>>>> After that the sector length will be multiplied by the size_ratio, thus the
>>>> CFI entry for sector length is doubled. When Linux or u-boot send a sector
>>>> erase, they expect to erase the doubled sector length, but QEMU only erases
>>>> the board specified sector length.
>>>>
>>>> This patch fixes the sector length in the CFI table to match the length per
>>>> device, equal to blocks_per_device.
>>>
>>> Thanks for the patch. I haven't checked against the pflash spec yet,
>>> but this looks like it's probably the right thing.
>>>
>>> The only two machines which use a setup with multiple devices (ie
>>> which specify device_width to the pflash_cfi01) are vexpress and virt.
>>> For all other machines this patch leaves the behaviour unchanged.
>>>
>>> Q: do we need to have some kind of nasty hack so that pre-2.9 virt
>>> still gets the old broken values in the CFI table, for version and
>>> migration compatibility? Ccing Drew for an opinion...
>>>
>>
>> I'm pretty sure we need the nasty hack, but I'm also Ccing David for
>> his opinion.
>
> Hmm I don't understand enough about pflash to understand the change here;
> but generally if you need to keep something unchanged for older
> machine types, add a property and then set that property in
> the compatibility macros.
>
> See include/hw/compat.h, I think you'd add the entry to HW_COMPAT_2_8
> and follow a simple example like  old_msi_addr on intel-hda.c,
> that should get picked up by aarch, x86, ppc etc versioned machine types.

This is a new version of the previous patch including the HW_COMPAT entry.

After further tests with u-boot and Linux, I found another problem with 
the blocks per device and write block size. Blocks per device must not 
be divided with the number of devices because the resulting device size 
would not match the overall size. However write block size must be 
modified depending on the number of devices because the entry is per 
device and when u-boot writes into the flash it calculates the write 
size by using the CFI entry (write size per device) multiplied by the 
number of chips.

Here is a configuration example of the vexpress board:

VEXPRESS_FLASH_SIZE = 64M
VEXPRESS_FLASH_SECT_SIZE 256K
num-blocks = VEXPRESS_FLASH_SIZE / VEXPRESS_FLASH_SECT_SIZE = 256
sector-length = 256K
width = 4
device-width = 2

The code will fill the CFI entry with the following entries
num-blocks = 256
sector-length = 128K
writeblock_size = 2048

This results in two chips, each with 256 * 128K = 32M device size and a 
write block size of 2048.

A sector erase will be send to both chips, thus 256K must be erased. 
When u-boot sends a block write command, it will write 4096 bytes data 
at once (2048 per device).

I did not modify the CFI entry for write block size. Instead I kept the 
hard coded value of 2048 in the CFI table and fixed the internal entry 
for writeblock_size.

Best regards
- David


Signed-off-by: David Engraf <david.engraf@sysgo.com>


--------------FF6F1E9E33C6397296B55BCC
Content-Type: text/x-patch;
 name="fix_pflash_sector_len_v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fix_pflash_sector_len_v2.patch"

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 5f0ee9d..996daa3 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -99,6 +99,7 @@ struct pflash_t {
     char *name;
     void *storage;
     VMChangeStateEntry *vmstate;
+    bool old_multiple_chip_handling;
 };
 
 static int pflash_post_load(void *opaque, int version_id);
@@ -703,7 +704,7 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     pflash_t *pfl = CFI_PFLASH01(dev);
     uint64_t total_len;
     int ret;
-    uint64_t blocks_per_device, device_len;
+    uint64_t blocks_per_device, sector_len_per_device, device_len;
     int num_devices;
     Error *local_err = NULL;
 
@@ -726,8 +727,14 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
      * in the cfi_table[].
      */
     num_devices = pfl->device_width ? (pfl->bank_width / pfl->device_width) : 1;
-    blocks_per_device = pfl->nb_blocs / num_devices;
-    device_len = pfl->sector_len * blocks_per_device;
+    if (pfl->old_multiple_chip_handling) {
+        blocks_per_device = pfl->nb_blocs / num_devices;
+        sector_len_per_device = pfl->sector_len;
+    } else {
+        blocks_per_device = pfl->nb_blocs;
+        sector_len_per_device = pfl->sector_len / num_devices;
+    }
+    device_len = sector_len_per_device * blocks_per_device;
 
     /* XXX: to be fixed */
 #if 0
@@ -832,6 +839,8 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
         pfl->cfi_table[0x2A] = 0x0B;
     }
     pfl->writeblock_size = 1 << pfl->cfi_table[0x2A];
+    if (!pfl->old_multiple_chip_handling && num_devices > 1)
+        pfl->writeblock_size *= num_devices;
 
     pfl->cfi_table[0x2B] = 0x00;
     /* Number of erase block regions (uniform) */
@@ -839,8 +848,8 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     /* Erase block region 1 */
     pfl->cfi_table[0x2D] = blocks_per_device - 1;
     pfl->cfi_table[0x2E] = (blocks_per_device - 1) >> 8;
-    pfl->cfi_table[0x2F] = pfl->sector_len >> 8;
-    pfl->cfi_table[0x30] = pfl->sector_len >> 16;
+    pfl->cfi_table[0x2F] = sector_len_per_device >> 8;
+    pfl->cfi_table[0x30] = sector_len_per_device >> 16;
 
     /* Extended */
     pfl->cfi_table[0x31] = 'P';
@@ -898,6 +907,8 @@ static Property pflash_cfi01_properties[] = {
     DEFINE_PROP_UINT16("id2", struct pflash_t, ident2, 0),
     DEFINE_PROP_UINT16("id3", struct pflash_t, ident3, 0),
     DEFINE_PROP_STRING("name", struct pflash_t, name),
+    DEFINE_PROP_BOOL("old-multiple-chip-handling", struct pflash_t,
+                     old_multiple_chip_handling, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 4fe44d1..cb3c36a 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -2,7 +2,11 @@
 #define HW_COMPAT_H
 
 #define HW_COMPAT_2_8 \
-    /* empty */
+    {\
+        .driver   = "pflash_cfi01",\
+        .property = "old-multiple-chip-handling",\
+        .value    = "on",\
+    },
 
 #define HW_COMPAT_2_7 \
     {\

--------------FF6F1E9E33C6397296B55BCC--
