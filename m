Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DEFC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A8B2217F5
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8B2217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEcFO-0007Ea-Gx
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 12:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iEc9F-0001gt-It
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iEc9D-0005SH-Ap
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:34:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54950)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iEc94-0005AY-7a; Sun, 29 Sep 2019 12:34:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A9C948AC6E0;
 Sun, 29 Sep 2019 16:33:58 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D663611DB;
 Sun, 29 Sep 2019 16:33:57 +0000 (UTC)
Message-ID: <79526395923f4a9ffc0eced407fe316dc38898dd.camel@redhat.com>
Subject: Re: [PATCH 12/18] iotests: Avoid cp/mv of test images
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Sun, 29 Sep 2019 19:33:56 +0300
In-Reply-To: <20190927094242.11152-13-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-13-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Sun, 29 Sep 2019 16:33:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-09-27 at 11:42 +0200, Max Reitz wrote:
> This will not work with external data files, so try to get tests working
> without it as far as possible.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/063     | 12 ++++--------
>  tests/qemu-iotests/063.out |  3 ++-
>  tests/qemu-iotests/085     |  9 +++------
>  tests/qemu-iotests/085.out |  8 ++++----
>  4 files changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/tests/qemu-iotests/063 b/tests/qemu-iotests/063
> index eef2b8a534..c750b3806e 100755
> --- a/tests/qemu-iotests/063
> +++ b/tests/qemu-iotests/063
> @@ -51,15 +51,13 @@ _unsupported_imgopts "subformat=monolithicFlat" \
>  _make_test_img 4M
>  
>  echo "== Testing conversion with -n fails with no target file =="
> -# check .orig file does not exist
> -rm -f "$TEST_IMG.orig"
>  if $QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG.orig" >/dev/null 2>&1; then
>      exit 1
>  fi
>  
>  echo "== Testing conversion with -n succeeds with a target file =="
> -rm -f "$TEST_IMG.orig"
> -cp "$TEST_IMG" "$TEST_IMG.orig"
> +_rm_test_img "$TEST_IMG.orig"
> +TEST_IMG="$TEST_IMG.orig" _make_test_img 4M
>  if ! $QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG.orig" ; then
>      exit 1
>  fi
> @@ -85,10 +83,8 @@ fi
>  _check_test_img
>  
>  echo "== Testing conversion to a smaller file fails =="
> -rm -f "$TEST_IMG.orig"
> -mv "$TEST_IMG" "$TEST_IMG.orig"
> -_make_test_img 2M
> -if $QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n "$TEST_IMG.orig" "$TEST_IMG" >/dev/null 2>&1; then
> +TEST_IMG="$TEST_IMG.target" _make_test_img 2M
> +if $QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG.target" >/dev/null 2>&1; then
>      exit 1
>  fi
>  
> diff --git a/tests/qemu-iotests/063.out b/tests/qemu-iotests/063.out
> index 7b691b2c9e..890b719bf0 100644
> --- a/tests/qemu-iotests/063.out
> +++ b/tests/qemu-iotests/063.out
> @@ -2,11 +2,12 @@ QA output created by 063
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
>  == Testing conversion with -n fails with no target file ==
>  == Testing conversion with -n succeeds with a target file ==
> +Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=4194304
>  == Testing conversion to raw is the same after conversion with -n ==
>  == Testing conversion back to original format ==
>  No errors were found on the image.
>  == Testing conversion to a smaller file fails ==
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2097152
> +Formatting 'TEST_DIR/t.IMGFMT.target', fmt=IMGFMT size=2097152
>  == Regression testing for copy offloading bug ==
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
>  Formatting 'TEST_DIR/t.IMGFMT.target', fmt=IMGFMT size=1048576
> diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
> index bbea1252d2..46981dbb64 100755
> --- a/tests/qemu-iotests/085
> +++ b/tests/qemu-iotests/085
> @@ -105,8 +105,7 @@ add_snapshot_image()
>  {
>      base_image="${TEST_DIR}/$((${1}-1))-${snapshot_virt0}"
>      snapshot_file="${TEST_DIR}/${1}-${snapshot_virt0}"
> -    _make_test_img -u -b "${base_image}" "$size"
> -    mv "${TEST_IMG}" "${snapshot_file}"
> +    TEST_IMG=$snapshot_file _make_test_img -u -b "${base_image}" "$size"
>      do_blockdev_add "$1" "'backing': null, " "${snapshot_file}"
>  }
>  
> @@ -122,10 +121,8 @@ blockdev_snapshot()
>  
>  size=128M
>  
> -_make_test_img $size
> -mv "${TEST_IMG}" "${TEST_IMG}.1"
> -_make_test_img $size
> -mv "${TEST_IMG}" "${TEST_IMG}.2"
> +TEST_IMG="$TEST_IMG.1" _make_test_img $size
> +TEST_IMG="$TEST_IMG.2" _make_test_img $size
>  
>  echo
>  echo === Running QEMU ===
> diff --git a/tests/qemu-iotests/085.out b/tests/qemu-iotests/085.out
> index 2a5f256cd3..313198f182 100644
> --- a/tests/qemu-iotests/085.out
> +++ b/tests/qemu-iotests/085.out
> @@ -1,6 +1,6 @@
>  QA output created by 085
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
> +Formatting 'TEST_DIR/t.IMGFMT.1', fmt=IMGFMT size=134217728
> +Formatting 'TEST_DIR/t.IMGFMT.2', fmt=IMGFMT size=134217728
>  
>  === Running QEMU ===
>  
> @@ -55,10 +55,10 @@ Formatting 'TEST_DIR/10-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_fil
>  
>  === Create a couple of snapshots using blockdev-snapshot ===
>  
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/10-snapshot-v0.IMGFMT
> +Formatting 'TEST_DIR/11-snapshot-v0.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/10-snapshot-v0.IMGFMT
>  {"return": {}}
>  {"return": {}}
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/11-snapshot-v0.IMGFMT
> +Formatting 'TEST_DIR/12-snapshot-v0.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/11-snapshot-v0.IMGFMT
>  {"return": {}}
>  {"return": {}}
>  
Looks good.
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>



