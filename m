Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1838C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877842086A
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877842086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEcL1-0003t2-MV
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 12:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iEcDW-00060c-Le
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iEcDV-0002mp-DT
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:38:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iEcDS-0002ir-C1; Sun, 29 Sep 2019 12:38:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6B3B9C049D59;
 Sun, 29 Sep 2019 16:38:33 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FD8860C05;
 Sun, 29 Sep 2019 16:38:31 +0000 (UTC)
Message-ID: <7e9c44bc0ca4b195939b0723db11eebc3fe11e2e.camel@redhat.com>
Subject: Re: [PATCH 15/18] iotests: Make 137 work with data_file
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Sun, 29 Sep 2019 19:38:30 +0300
In-Reply-To: <20190927094242.11152-16-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-16-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Sun, 29 Sep 2019 16:38:33 +0000 (UTC)
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
> When using an external data file, there are no refcounts for data
> clusters.  We thus have to adjust the corruption test in this patch to
> not be based around a data cluster allocation, but the L2 table
> allocation (L2 tables are still refcounted with external data files).
> 
> Doing so means this test works both with and without external data
> files.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/137     | 10 ++++++----
>  tests/qemu-iotests/137.out |  4 +---
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
> index 6cf2997577..dd3484205e 100755
> --- a/tests/qemu-iotests/137
> +++ b/tests/qemu-iotests/137
> @@ -138,14 +138,16 @@ $QEMU_IO \
>      "$TEST_IMG" 2>&1 | _filter_qemu_io
>  
>  # The dirty bit must not be set
> -$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
> +# (Filter the external data file bit)
> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features \
> +    | sed -e 's/0x4/0x0/'
Maybe it is better to filter all the feature bits, but the dirty bit,
since only it is needed here, so that when we start running tests with
more features, we won't need to do this again?

>  
>  # Similarly we can test whether corruption detection has been enabled:
> -# Create L1/L2, overwrite first entry in refcount block, allocate something.
> +# Create L1, overwrite refcounts, force allocation of L2 by writing
> +# data.
>  # Disabling the checks should fail, so the corruption must be detected.
>  _make_test_img 64M
> -$QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
> -poke_file "$TEST_IMG" "$((0x20000))" "\x00\x00"
> +poke_file "$TEST_IMG" "$((0x20000))" "\x00\x00\x00\x00\x00\x00\x00\x00"

I am wondering if there is any better way to do this (regardless of this patch),
Basically the above code pokes into the 3rd cluster on the disk I *think*, and I don't
understand why it has to contain refcounts. Hmm...
First cluster I can guess will have the header, 2nd cluster probably L1 table, and 3rd, refcounts?
If so, the test should specify that it needs 64K clusters, because the day will come when
we will need to test this as well, but I guess in a separate patch,


>  $QEMU_IO \
>      -c "reopen -o overlap-check=none,lazy-refcounts=42" \
>      -c "write 64k 64k" \
> diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
> index 1c6569eb2c..bd5f76d604 100644
> --- a/tests/qemu-iotests/137.out
> +++ b/tests/qemu-iotests/137.out
> @@ -38,9 +38,7 @@ wrote 512/512 bytes at offset 0
>  ./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
>  incompatible_features     0x0
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> -wrote 65536/65536 bytes at offset 0
> -64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  qemu-io: Parameter 'lazy-refcounts' expects 'on' or 'off'
> -qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps with qcow2_header); further corruption events will be suppressed
> +qcow2: Marking image as corrupt: Preventing invalid allocation of L2 table at offset 0; further corruption events will be suppressed
>  write failed: Input/output error
>  *** done

Best regards,
	Maxim Levitsky



