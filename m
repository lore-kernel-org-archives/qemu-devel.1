Received: from eggs.gnu.org ([2001:4830:134:3::10]:57606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fSUuM-0002xn-LG
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 18:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fSUuL-0005JX-Jn
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 18:03:26 -0400
References: <20180611213927.141894-1-eblake@redhat.com>
	<20180611213927.141894-3-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ff47b198-c6a7-a2f5-86d0-93e3b431806e@redhat.com>
Date: Mon, 11 Jun 2018 17:03:19 -0500
MIME-Version: 1.0
In-Reply-To: <20180611213927.141894-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: Add test 221 to catch
 qemu-img map regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 06/11/2018 04:39 PM, Eric Blake wrote:
> Although qemu-img creates aligned files (by rounding up), it
> must also gracefully handle files that are not sector-aligned.
> Test that the bug fixed in the previous patch does not recur.
> 
> It's a bit annoying that we can see the (implicit) hole past
> the end of the file on to the next sector boundary, so if we
> ever reach the point where we report a byte-accurate size rather
> than our current behavior of always rounding up, this test will
> probably need a slight modification.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

> +
> +$QEMU_IO -c 'w 43008 1' "$TEST_IMG" # writing also rounds up

Shoot - missing a filter...

> +++ b/tests/qemu-iotests/221.out
> @@ -0,0 +1,16 @@
> +QA output created by 221
> +
> +=== Check mapping of unaligned raw image ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=43009
> +[{ "start": 0, "length": 43520, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
> +[{ "start": 0, "length": 43520, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
> +wrote 1/1 bytes at offset 43008
> +1 bytes, 1 ops; 0.0001 sec (7.512 KiB/sec and 7692.3077 ops/sec)

...which leaks volatile output.  Squash this in:

diff --git i/tests/qemu-iotests/221 w/tests/qemu-iotests/221
index f2cd3c2210e..41c4e4bdf88 100755
--- i/tests/qemu-iotests/221
+++ w/tests/qemu-iotests/221
@@ -48,7 +48,7 @@ $QEMU_IMG map --output=json "$TEST_IMG" | 
_filter_qemu_img_map
  truncate --size=43009 "$TEST_IMG" # so we resize it and check again
  $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map

-$QEMU_IO -c 'w 43008 1' "$TEST_IMG" # writing also rounds up
+$QEMU_IO -c 'w 43008 1' "$TEST_IMG" | _filter_qemu_io # writing also 
rounds up
  $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map

  truncate --size=43009 "$TEST_IMG" # so we resize it and check again
diff --git i/tests/qemu-iotests/221.out w/tests/qemu-iotests/221.out
index fcf61352cc3..a9c0190aadc 100644
--- i/tests/qemu-iotests/221.out
+++ w/tests/qemu-iotests/221.out
@@ -6,7 +6,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=43009
  [{ "start": 0, "length": 43520, "depth": 0, "zero": true, "data": 
false, "offset": OFFSET}]
  [{ "start": 0, "length": 43520, "depth": 0, "zero": true, "data": 
false, "offset": OFFSET}]
  wrote 1/1 bytes at offset 43008
-1 bytes, 1 ops; 0.0001 sec (7.512 KiB/sec and 7692.3077 ops/sec)
+1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
  [{ "start": 0, "length": 40960, "depth": 0, "zero": true, "data": 
false, "offset": OFFSET},
  { "start": 40960, "length": 2049, "depth": 0, "zero": false, "data": 
true, "offset": OFFSET},
  { "start": 43009, "length": 511, "depth": 0, "zero": true, "data": 
false, "offset": OFFSET}]


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
