Received: from eggs.gnu.org ([2001:4830:134:3::10]:37732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gUUPq-0004FT-7V
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 05:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gUUPl-0006Qg-No
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 05:28:26 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:59942
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gUUPl-0006MG-4j
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 05:28:21 -0500
References: <1543848532-12604-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1543848532-12604-4-git-send-email-lizhijian@cn.fujitsu.com>
	<20181203200403-mutt-send-email-mst@kernel.org>
	<351854fc-c419-f006-8744-7f45d2701f16@cn.fujitsu.com>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <f9656fba-181c-6267-648c-95dd2380043e@cn.fujitsu.com>
Date: Wed, 5 Dec 2018 18:28:11 +0800
MIME-Version: 1.0
In-Reply-To: <351854fc-c419-f006-8744-7f45d2701f16@cn.fujitsu.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 3/4] i386: import bootparam.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philip.li@intel.com, zhijianx.li@intel.com

Hi Michael

I cooked a draft with cp_portable to import bootparam.h, could you have a look.

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 0a964fe..1beeceb 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -44,6 +44,12 @@ cp_portable() {
                                       -e 'linux/kernel' \
                                       -e 'linux/sysinfo' \
                                       -e 'asm-generic/kvm_para' \
+                                     -e 'linux/screen_info.h' \
+                                     -e 'linux/apm_bios.h' \
+                                     -e 'linux/edd.h' \
+                                     -e 'video/edid.h' \
+                                     -e 'asm/ist.h' \
+                                     -e 'linux/ioctl.h' \
                                       > /dev/null
      then
          echo "Unexpected #include in input file $f".
@@ -59,6 +65,8 @@ cp_portable() {
          -e 's/__be\([0-9][0-9]*\)/uint\1_t/g' \
          -e 's/"\(input-event-codes\.h\)"/"standard-headers\/linux\/\1"/' \
          -e 's/<linux\/\([^>]*\)>/"standard-headers\/linux\/\1"/' \
+        -e "s/<asm\/\([^>]*\)>/\"standard-headers\/asm-$arch\/\1\"/" \
+        -e 's/<video\/\([^>]*\)>/"standard-headers\/video\/\1"/' \
          -e 's/__bitwise//' \
          -e 's/__attribute__((packed))/QEMU_PACKED/' \
          -e 's/__inline__/inline/' \
@@ -74,6 +82,23 @@ cp_portable() {
          "$f" > "$to/$header";
  }
  
+rm -rf "$output/include/standard-headers/linux"
+mkdir -p "$output/include/standard-headers/linux"
+
+cp_bootparam()
+{
+    mkdir -p $output/include/standard-headers/video
+    cp "$tmpdir"/include/linux/ioctl.h "$output/include/standard-headers/linux"
+    cp_portable "$tmpdir"/include/linux/screen_info.h "$output/include/standard-headers/linux"
+    cp_portable "$tmpdir/include/linux/apm_bios.h" "$output/include/standard-headers/linux"
+    cp_portable "$tmpdir/include/linux/edd.h" "$output/include/standard-headers/linux"
+    cp_portable "$tmpdir/include/asm/ist.h" $output/include/standard-headers/asm-$arch
+    cp_portable "$tmpdir/include/video/edid.h" $output/include/standard-headers/video
+
+    # bootparam.h includes above headers
+    cp_portable "$tmpdir/include/asm/bootparam.h" "$output/include/standard-headers/asm-$arch"
+}
+
  # This will pick up non-directories too (eg "Kconfig") but we will
  # ignore them in the next loop.
  ARCHLIST=$(cd "$linux/arch" && echo *)
@@ -120,6 +145,7 @@ for arch in $ARCHLIST; do
          cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
          cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
          cp_portable "$tmpdir/include/asm/kvm_para.h" "$output/include/standard-headers/asm-$arch"
+        cp_bootparam
      fi
  done
  
@@ -163,8 +189,6 @@ cat <<EOF >$output/linux-headers/linux/virtio_ring.h
  #include "standard-headers/linux/virtio_ring.h"
  EOF
  
-rm -rf "$output/include/standard-headers/linux"
-mkdir -p "$output/include/standard-headers/linux"
  for i in "$tmpdir"/include/linux/*virtio*.h \
           "$tmpdir/include/linux/qemu_fw_cfg.h" \
           "$tmpdir/include/linux/input.h" \

Thanks
Zhijian


On 12/04/2018 04:09 PM, Li Zhijian wrote:
>
>
>
> On 12/04/2018 09:06 AM, Michael S. Tsirkin wrote:
>> On Mon, Dec 03, 2018 at 10:48:51PM +0800, Li Zhijian wrote:
>>> It provides setup_data struct and header fields
>>>
>>> CC: Michael S. Tsirkin<mst@redhat.com>
>>> Signed-off-by: Li Zhijian<lizhijian@cn.fujitsu.com>
>> Sorry I was unclear when I said "import it from Linux".
> Sorry, it's my fault.
>
>> The way to import it is to copy the header
>> from the linux kernel by adding it to ./scripts/update-linux-headers.sh
>> and placing a copy into include/standard-headers/
>>
>> Hope that helps.
> that's really helpful.
>
> i wonder which type copy should i use 'cp' or 'cp_portable'
> this header includes several sub-headers
>
> $ grep include  /tmp/tmp.MBF10Z9MeS/include/asm/bootparam.h
> #include <linux/types.h>
> #include <linux/screen_info.h>
> #include <linux/apm_bios.h>
> #include <linux/edd.h>
> #include <asm/ist.h>
> #include <video/edid.h>
>
> Thanks
> Zhijian
>
>>
>      
>    
>
>
>
>
