Received: from eggs.gnu.org ([209.51.188.92]:45384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1hDUZs-0003sz-FG
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1hDUZr-00037t-I8
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:44:48 -0400
References: <20190325125142.11628-1-zhengxiang9@huawei.com>
	<CAFEAcA-O5+A0Q=14k2vrBg3KNM7MmqbcyhBoZZOe=AsyE-UDbw@mail.gmail.com>
	<19929558-9f2d-148a-4357-d48b46f8b62b@huawei.com>
	<87va06kvm6.fsf@dusky.pond.sub.org>
	<59f100b4-f6e9-973d-532b-58fb172a7009@redhat.com>
	<87imw5fv45.fsf@dusky.pond.sub.org>
	<abe1d9cd-85bb-2ef8-630f-af28cae6378c@redhat.com>
	<8736n9eb4s.fsf@dusky.pond.sub.org>
	<bf2decd3-b3cb-08eb-3449-b66f023b084a@huawei.com>
	<c57135ae-41a9-ed7b-976b-bf8fe43596a2@redhat.com>
From: Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <b107e0c0-1c4c-3f0f-eb78-8929c315ce28@huawei.com>
Date: Mon, 8 Apr 2019 21:43:46 +0800
MIME-Version: 1.0
In-Reply-To: <c57135ae-41a9-ed7b-976b-bf8fe43596a2@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] hw/arm/virt: use variable size of
 flash device to save memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Heyi Guo <guoheyi@huawei.com>, wanghaibin.wang@huawei.com


On 2019/4/3 23:35, Laszlo Ersek wrote:
>> I thought about your comments and wrote the following patch (just for test)
>> which uses a file mapping to replace the anonymous mapping. UEFI seems to work
>> fine. So why not use a file mapping to read or write a pflash device?
> Honestly I can't answer "why not do this". Maybe we should.
> 
> Regarding "why not do this *exactly as shown below*" -- probably because
> then we'd have updates to the same underlying regular file via both
> mmap() and write(), and the interactions between those are really tricky
> (= best avoided).
> 
> One of my favorite questions over the years used to be posting a matrix
> of possible mmap() and file descriptor r/w/sync interactions, with the
> outcomes as they were "implied" by POSIX, and then asking at the bottom,
> "is my understanding correct?" I've never ever received an answer to
> that. :)

In my opinion, it's feasible to r/w/sync the memory devices which use a block
backend via mmap() and write().

> 
> Also... although we don't really use them in practice, some QCOW2
> features for pflash block backends are -- or would be -- nice. (Not the
> internal snapshots or the live RAM dumps, of course.)

Regarding sparse files, can we read actual backend size data for the read-only
pflash memory as the following steps shown?

1) Create a sparse file -- QEMU_EFI-test.raw:
   dd if=/dev/zero of=QEMU_EFI-test.raw bs=1M seek=64 count=0

2) Read from QEMU_EFI.fd and write to QEMU_EFI-test.raw:
   dd of="QEMU_EFI-test.raw" if="QEMU_EFI.fd" conv=notrunc

3) Use QEMU_EFI-test.raw as the read-only pflash and start qemu with the below
patch applied:

---8>---

diff --git a/hw/block/block.c b/hw/block/block.c
index bf56c76..ad18d5e 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -30,7 +30,7 @@
 bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
                                  Error **errp)
 {
-    int64_t blk_len;
+    int64_t blk_len, actual_len;
     int ret;

     blk_len = blk_getlength(blk);
@@ -53,7 +53,9 @@ bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
      * block device and read only on demand.
      */
     assert(size <= BDRV_REQUEST_MAX_BYTES);
-    ret = blk_pread(blk, 0, buf, size);
+    actual_len = bdrv_get_allocated_file_size(blk_bs(blk));
+    ret = blk_pread(blk, 0, buf,
+            (!blk_is_read_only(blk) || actual_len < 0) ? size : actual_len);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "can't read block backend");
         return false;
-- 
1.8.3.1


-- 

Thanks,
Xiang
