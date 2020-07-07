Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8FEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6172064C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZODaebLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6172064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqcD-0003Km-8S
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsqI6-0007N8-TY
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:17:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54706
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsqI3-0000PY-Gf
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594138669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mNwIqI2mu4rkbqL6dTb2rqwPthcR/vKO4uaRRUKp7S8=;
 b=ZODaebLbo76rl5i2MTiBFQeisc+i4G59j37++7Qx8ylKH2//nMDryV50kI6TZEcwIDH1NU
 LgUh4aA+7JlmaTKLMqHmfH6ypHOiEpBBzdIKAffh7MhCd4Lq74sc7EvCnlQjwL8T6y9wUc
 XyyGbD0t8r3K8N7cma+tDX+Nlj6pb6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-b8VO6wBNOLS_ABkxkOYEAg-1; Tue, 07 Jul 2020 12:17:45 -0400
X-MC-Unique: b8VO6wBNOLS_ABkxkOYEAg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FBDA800D5C;
 Tue,  7 Jul 2020 16:17:44 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-113.ams2.redhat.com [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2428F77892;
 Tue,  7 Jul 2020 16:17:42 +0000 (UTC)
Date: Tue, 7 Jul 2020 18:17:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: Re: [PATCH for-5.1] file-posix: Mitigate file fragmentation with
 extent size hints
Message-ID: <20200707161741.GG7002@linux.fritz.box>
References: <20200707142329.48303-1-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200707142329.48303-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.07.2020 um 16:23 hat Kevin Wolf geschrieben:
> Espeically when O_DIRECT is used with image files so that the page cache
> indirection can't cause a merge of allocating requests, the file will
> fragment on the file system layer, with a potentially very small
> fragment size (this depends on the requests the guest sent).
> 
> On Linux, fragmentation can be reduced by setting an extent size hint
> when creating the file (at least on XFS, it can't be set any more after
> the first extent has been allocated), basically giving raw files a
> "cluster size" for allocation.
> 
> This adds an create option to set the extent size hint, and changes the
> default from not setting a hint to setting it to 1 MB. The main reason
> why qcow2 defaults to smaller cluster sizes is that COW becomes more
> expensive, which is not an issue with raw files, so we can choose a
> larger file. The tradeoff here is only potentially wasted disk space.
> 
> For qcow2 (or other image formats) over file-posix, the advantage should
> even be greater because they grow sequentially without leaving holes, so
> there won't be wasted space. Setting even larger extent size hints for
> such images may make sense. This can be done with the new option, but
> let's keep the default conservative for now.
> 
> The effect is very visible with a test that intentionally creates a
> badly fragmented file with qemu-img bench (the time difference while
> creating the file is already remarkable) and then looks at the number of
> extents and the take a simple "qemu-img map" takes.
> 
> Without an extent size hint:
> 
>     $ ./qemu-img create -f raw -o extent_size_hint=0 ~/tmp/test.raw 10G
>     Formatting '/home/kwolf/tmp/test.raw', fmt=raw size=10737418240 extent_size_hint=0
>     $ ./qemu-img bench -f raw -t none -n -w ~/tmp/test.raw -c 1000000 -S 8192 -o 0
>     Sending 1000000 write requests, 4096 bytes each, 64 in parallel (starting at offset 0, step size 8192)
>     Run completed in 25.848 seconds.
>     $ ./qemu-img bench -f raw -t none -n -w ~/tmp/test.raw -c 1000000 -S 8192 -o 4096
>     Sending 1000000 write requests, 4096 bytes each, 64 in parallel (starting at offset 4096, step size 8192)
>     Run completed in 19.616 seconds.
>     $ filefrag ~/tmp/test.raw
>     /home/kwolf/tmp/test.raw: 2000000 extents found
>     $ time ./qemu-img map ~/tmp/test.raw
>     Offset          Length          Mapped to       File
>     0               0x1e8480000     0               /home/kwolf/tmp/test.raw
> 
>     real    0m1,279s
>     user    0m0,043s
>     sys     0m1,226s
> 
> With the new default extent size hint of 1 MB:
> 
>     $ ./qemu-img create -f raw -o extent_size_hint=1M ~/tmp/test.raw 10G
>     Formatting '/home/kwolf/tmp/test.raw', fmt=raw size=10737418240 extent_size_hint=1048576
>     $ ./qemu-img bench -f raw -t none -n -w ~/tmp/test.raw -c 1000000 -S 8192 -o 0
>     Sending 1000000 write requests, 4096 bytes each, 64 in parallel (starting at offset 0, step size 8192)
>     Run completed in 11.833 seconds.
>     $ ./qemu-img bench -f raw -t none -n -w ~/tmp/test.raw -c 1000000 -S 8192 -o 4096
>     Sending 1000000 write requests, 4096 bytes each, 64 in parallel (starting at offset 4096, step size 8192)
>     Run completed in 10.155 seconds.
>     $ filefrag ~/tmp/test.raw
>     /home/kwolf/tmp/test.raw: 178 extents found
>     $ time ./qemu-img map ~/tmp/test.raw
>     Offset          Length          Mapped to       File
>     0               0x1e8480000     0               /home/kwolf/tmp/test.raw
> 
>     real    0m0,061s
>     user    0m0,040s
>     sys     0m0,014s
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

I also need to squash in a few trivial qemu-iotests updates, for which I
won't send a v2:

diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 1b0a75c8f9..0d7c5e8342 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -62,6 +62,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -86,6 +87,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -110,6 +112,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -134,6 +137,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -158,6 +162,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -182,6 +187,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -206,6 +212,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -230,6 +237,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -353,6 +361,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -377,6 +386,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -401,6 +411,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -425,6 +436,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -449,6 +461,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -473,6 +486,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -497,6 +511,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
@@ -521,6 +536,7 @@ Supported options:
   encrypt.ivgen-hash-alg=<str> - Name of IV generator hash algorithm
   encrypt.key-secret=<str> - ID of secret providing qcow AES key or LUKS passphrase
   encryption=<bool (on/off)> - Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+  extent_size_hint=<size> - Extent size hint for the image file, 0 to disable
   lazy_refcounts=<bool (on/off)> - Postpone refcount updates
   nocow=<bool (on/off)>  - Turn off copy-on-write (valid only on btrfs)
   preallocation=<str>    - Preallocation mode (allowed values: off, metadata, falloc, full)
diff --git a/tests/qemu-iotests/243 b/tests/qemu-iotests/243
index a61852f6d9..17388a4644 100755
--- a/tests/qemu-iotests/243
+++ b/tests/qemu-iotests/243
@@ -51,7 +51,7 @@ for mode in off metadata falloc full; do
     echo "=== preallocation=$mode ==="
     echo
 
-    _make_test_img -o "preallocation=$mode" 64M
+    _make_test_img -o "preallocation=$mode,extent_size_hint=0" 64M
 
     printf "File size: "
     du -b $TEST_IMG | cut -f1
@@ -68,7 +68,8 @@ for mode in off metadata falloc full; do
     echo "=== External data file: preallocation=$mode ==="
     echo
 
-    _make_test_img -o "data_file=$TEST_IMG.data,preallocation=$mode" 64M
+    _make_test_img \
+        -o "data_file=$TEST_IMG.data,preallocation=$mode,extent_size_hint=0" 64M
 
     echo -n "qcow2 file size: "
     du -b $TEST_IMG | cut -f1
@@ -79,7 +80,7 @@ for mode in off metadata falloc full; do
     echo -n "qcow2 disk usage: "
     [ $(du -B1 $TEST_IMG | cut -f1) -lt 1048576 ] && echo "low" || echo "high"
     echo -n "data disk usage:  "
-    [ $(du -B1 $TEST_IMG.data | cut -f1) -lt 1048576 ] && echo "low" || echo "high"
+    [ $(du -B1 $TEST_IMG.data | cut -f1) -lt 2097152 ] && echo "low" || echo "high"
 
 done
 
diff --git a/tests/qemu-iotests/243.out b/tests/qemu-iotests/243.out
index dcb33fac32..8bd3d79d66 100644
--- a/tests/qemu-iotests/243.out
+++ b/tests/qemu-iotests/243.out
@@ -2,31 +2,31 @@ QA output created by 243
 
 === preallocation=off ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 preallocation=off extent_size_hint=0
 File size: 196616
 Disk usage: low
 
 === preallocation=metadata ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 preallocation=metadata extent_size_hint=0
 File size: 67436544
 Disk usage: low
 
 === preallocation=falloc ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 preallocation=falloc extent_size_hint=0
 File size: 67436544
 Disk usage: high
 
 === preallocation=full ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 preallocation=full extent_size_hint=0
 File size: 67436544
 Disk usage: high
 
 === External data file: preallocation=off ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data preallocation=off
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data preallocation=off extent_size_hint=0
 qcow2 file size: 196616
 data file size:  67108864
 qcow2 disk usage: low
@@ -34,7 +34,7 @@ data disk usage:  low
 
 === External data file: preallocation=metadata ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data preallocation=metadata
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data preallocation=metadata extent_size_hint=0
 qcow2 file size: 327680
 data file size:  67108864
 qcow2 disk usage: low
@@ -42,7 +42,7 @@ data disk usage:  low
 
 === External data file: preallocation=falloc ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data preallocation=falloc
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data preallocation=falloc extent_size_hint=0
 qcow2 file size: 327680
 data file size:  67108864
 qcow2 disk usage: low
@@ -50,7 +50,7 @@ data disk usage:  high
 
 === External data file: preallocation=full ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data preallocation=full
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data preallocation=full extent_size_hint=0
 qcow2 file size: 327680
 data file size:  67108864
 qcow2 disk usage: low


