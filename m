Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6247C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 00:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E60F24649
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 00:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SsujOrFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E60F24649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBTEs-0008K7-GT
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 20:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBTDq-0007bl-9n
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 20:58:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBTDi-00018V-Fo
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 20:58:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBTDh-00016F-Rm
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 20:58:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02A0rL0n173777;
 Tue, 10 Mar 2020 00:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ThpUsgwbsuyMZO4Wsulw6C7gSuwBH3BrXz1lXptbZns=;
 b=SsujOrFX7OF/paw8QTzRFXFGV9xbrOsU1KhPX6tjbI3BXjHnYbqvKeukZtZYV++Os/pw
 aA6DilIm+wvafg4D1V2kHbmz1ug4uqhwWOrDCPqS/hyhXMl14FBRlhksEg73rTRma6oC
 yif2eUhE9JrjzP+h5qOzfcsR2WEoKXFi58KWGrpAJCFm5K0Rv5qRVw/MTQGukI9oGJrA
 33bD7v1PAVo/w+awDEX5Ab8FgQd0KFc1ZaCL4rS9uhspqnqRQgM1B15SmeXPPbA25KyX
 ZjUL+m6Lp6CDw/06OMw2gKLdCMi62Xe6T/OSwdhzXB/c/XAfLLyUyZiU//6hS+6xfJS3 MQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2ym48st632-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 00:58:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02A0vCTO125341;
 Tue, 10 Mar 2020 00:58:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2ymn3hn4xr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 00:58:02 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02A0w0Gi026358;
 Tue, 10 Mar 2020 00:58:00 GMT
Received: from Lirans-MacBook-Pro.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 09 Mar 2020 17:57:58 -0700
Subject: Re: [PATCH 00/14]: hw/i386/vmport: Bug fixes and improvements
To: qemu-devel@nongnu.org
References: <158380163917.20878.9764229854603722791@39012742ff91>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <3f058206-7361-54f3-e43b-44433cec1547@oracle.com>
Date: Tue, 10 Mar 2020 02:57:55 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158380163917.20878.9764229854603722791@39012742ff91>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 impostorscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100002
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: pbonzini@redhat.com, mst@redhat.com, ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 10/03/2020 2:54, no-reply@patchew.org wrote:
> Patchew URL: https://urldefense.com/v3/__https://patchew.org/QEMU/20200309235411.76587-1-liran.alon@oracle.com/__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnVicygP6jf4$
>
>
>
> Hi,
>
> This series failed the asan build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
These failures doesn't seem to relate to the patch-series I have 
submitted...
The test seems to be broken.

-Liran

>
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> export ARCH=x86_64
> make docker-image-fedora V=1 NETWORK=1
> time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14 NETWORK=1
> === TEST SCRIPT END ===
>
> PASS 1 fdc-test /x86_64/fdc/cmos
> PASS 2 fdc-test /x86_64/fdc/no_media_on_start
> PASS 3 fdc-test /x86_64/fdc/read_without_media
> ==6572==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 4 fdc-test /x86_64/fdc/media_change
> PASS 5 fdc-test /x86_64/fdc/sense_interrupt
> PASS 6 fdc-test /x86_64/fdc/relative_seek
> ---
> PASS 32 test-opts-visitor /visitor/opts/range/beyond
> PASS 33 test-opts-visitor /visitor/opts/dict/unvisited
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-coroutine -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-coroutine"
> ==6620==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==6620==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7ffd8e97f000; bottom 0x7fc55e2d3000; size: 0x0038306ac000 (241330470912)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 1 test-coroutine /basic/no-dangling-access
> ---
> PASS 12 test-aio /aio/event/flush
> PASS 13 test-aio /aio/event/wait/no-flush-cb
> PASS 14 test-aio /aio/timer/schedule
> ==6635==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 15 test-aio /aio/coroutine/queue-chaining
> PASS 16 test-aio /aio-gsource/flush
> PASS 17 test-aio /aio-gsource/bh/schedule
> ---
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img tests/qtest/ide-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="ide-test"
> PASS 28 test-aio /aio-gsource/timer/schedule
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-aio-multithread -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-aio-multithread"
> ==6646==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 test-aio-multithread /aio/multi/lifecycle
> ==6643==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 ide-test /x86_64/ide/identify
> ==6663==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 2 test-aio-multithread /aio/multi/schedule
> PASS 2 ide-test /x86_64/ide/flush
> ==6674==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 3 ide-test /x86_64/ide/bmdma/simple_rw
> PASS 3 test-aio-multithread /aio/multi/mutex/contended
> ==6680==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 4 ide-test /x86_64/ide/bmdma/trim
> ==6691==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 4 test-aio-multithread /aio/multi/mutex/handoff
> PASS 5 test-aio-multithread /aio/multi/mutex/mcs
> PASS 6 test-aio-multithread /aio/multi/mutex/pthread
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-throttle -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-throttle"
> ==6708==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 test-throttle /throttle/leak_bucket
> PASS 2 test-throttle /throttle/compute_wait
> PASS 3 test-throttle /throttle/init
> ---
> PASS 14 test-throttle /throttle/config/max
> PASS 15 test-throttle /throttle/config/iops_size
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-thread-pool -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-thread-pool"
> ==6712==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 test-thread-pool /thread-pool/submit
> PASS 2 test-thread-pool /thread-pool/submit-aio
> PASS 3 test-thread-pool /thread-pool/submit-co
> PASS 4 test-thread-pool /thread-pool/submit-many
> ==6779==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 5 test-thread-pool /thread-pool/cancel
> PASS 6 test-thread-pool /thread-pool/cancel-async
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-hbitmap -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-hbitmap"
> ---
> PASS 28 test-hbitmap /hbitmap/truncate/shrink/medium
> PASS 29 test-hbitmap /hbitmap/truncate/shrink/large
> PASS 30 test-hbitmap /hbitmap/meta/zero
> ==6789==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 31 test-hbitmap /hbitmap/meta/one
> PASS 32 test-hbitmap /hbitmap/meta/byte
> PASS 33 test-hbitmap /hbitmap/meta/word
> ==6795==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 34 test-hbitmap /hbitmap/meta/sector
> PASS 35 test-hbitmap /hbitmap/serialize/align
> PASS 36 test-hbitmap /hbitmap/serialize/basic
> ---
> PASS 44 test-hbitmap /hbitmap/next_dirty_area/next_dirty_area_4
> PASS 45 test-hbitmap /hbitmap/next_dirty_area/next_dirty_area_after_truncate
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-bdrv-drain -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-bdrv-drain"
> ==6802==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 test-bdrv-drain /bdrv-drain/nested
> PASS 2 test-bdrv-drain /bdrv-drain/multiparent
> PASS 3 test-bdrv-drain /bdrv-drain/set_aio_context
> ---
> PASS 41 test-bdrv-drain /bdrv-drain/bdrv_drop_intermediate/poll
> PASS 42 test-bdrv-drain /bdrv-drain/replace_child/mid-drain
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-bdrv-graph-mod -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-bdrv-graph-mod"
> ==6841==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 test-bdrv-graph-mod /bdrv-graph-mod/update-perm-tree
> PASS 2 test-bdrv-graph-mod /bdrv-graph-mod/should-update-child
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-blockjob -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-blockjob"
> ==6845==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 test-blockjob /blockjob/ids
> PASS 2 test-blockjob /blockjob/cancel/created
> PASS 3 test-blockjob /blockjob/cancel/running
> ---
> PASS 7 test-blockjob /blockjob/cancel/pending
> PASS 8 test-blockjob /blockjob/cancel/concluded
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-blockjob-txn -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-blockjob-txn"
> ==6849==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 test-blockjob-txn /single/success
> PASS 2 test-blockjob-txn /single/failure
> PASS 3 test-blockjob-txn /single/cancel
> ---
> PASS 6 test-blockjob-txn /pair/cancel
> PASS 7 test-blockjob-txn /pair/fail-cancel-race
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-block-backend -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-block-backend"
> ==6853==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 test-block-backend /block-backend/drain_aio_error
> PASS 2 test-block-backend /block-backend/drain_all_aio_error
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-block-iothread -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-block-iothread"
> ==6857==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 test-block-iothread /sync-op/pread
> PASS 2 test-block-iothread /sync-op/pwrite
> PASS 3 test-block-iothread /sync-op/load_vmstate
> ---
> PASS 15 test-block-iothread /propagate/diamond
> PASS 16 test-block-iothread /propagate/mirror
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-image-locking -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-image-locking"
> ==6877==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 test-image-locking /image-locking/basic
> PASS 2 test-image-locking /image-locking/set-perm-abort
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-x86-cpuid -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-x86-cpuid"
> ---
> PASS 22 test-vmstate /vmstate/qlist/save/saveqlist
> PASS 23 test-vmstate /vmstate/qlist/load/loadqlist
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-cutils -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-cutils"
> ==6886==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 test-cutils /cutils/parse_uint/null
> PASS 2 test-cutils /cutils/parse_uint/empty
> PASS 3 test-cutils /cutils/parse_uint/whitespace
> ---
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-rcu-list -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-rcu-list"
> PASS 1 test-rcu-list /rcu/qlist/single-threaded
> PASS 2 test-rcu-list /rcu/qlist/short-few
> ==6968==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 3 test-rcu-list /rcu/qlist/long-many
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-rcu-simpleq -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-rcu-simpleq"
> PASS 1 test-rcu-simpleq /rcu/qsimpleq/single-threaded
> PASS 2 test-rcu-simpleq /rcu/qsimpleq/short-few
> PASS 3 test-rcu-simpleq /rcu/qsimpleq/long-many
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-rcu-tailq -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-rcu-tailq"
> ==7007==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 test-rcu-tailq /rcu/qtailq/single-threaded
> PASS 2 test-rcu-tailq /rcu/qtailq/short-few
> PASS 3 test-rcu-tailq /rcu/qtailq/long-many
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-rcu-slist -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-rcu-slist"
> PASS 1 test-rcu-slist /rcu/qslist/single-threaded
> ==7052==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 2 test-rcu-slist /rcu/qslist/short-few
> PASS 3 test-rcu-slist /rcu/qslist/long-many
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-qdist -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-qdist"
> ---
> PASS 7 test-qdist /qdist/binning/expand
> PASS 8 test-qdist /qdist/binning/shrink
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-qht -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-qht"
> ==7092==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 5 ide-test /x86_64/ide/bmdma/various_prdts
> ==7098==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7098==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7fffe055e000; bottom 0x7fae24ffe000; size: 0x0051bb560000 (351035326464)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 6 ide-test /x86_64/ide/bmdma/no_busmaster
> PASS 7 ide-test /x86_64/ide/flush/nodev
> ==7109==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 8 ide-test /x86_64/ide/flush/empty_drive
> ==7114==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 9 ide-test /x86_64/ide/flush/retry_pci
> ==7120==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 10 ide-test /x86_64/ide/flush/retry_isa
> ==7126==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 11 ide-test /x86_64/ide/cdrom/pio
> ==7132==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 12 ide-test /x86_64/ide/cdrom/pio_large
> PASS 1 test-qht /qht/mode/default
> ==7138==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 13 ide-test /x86_64/ide/cdrom/dma
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img tests/qtest/ahci-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="ahci-test"
> PASS 2 test-qht /qht/mode/resize
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-qht-par -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-qht-par"
> ==7161==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 ahci-test /x86_64/ahci/sanity
> PASS 1 test-qht-par /qht/parallel/2threads-0%updates-1s
> ==7167==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 2 ahci-test /x86_64/ahci/pci_spec
> PASS 2 test-qht-par /qht/parallel/2threads-20%updates-1s
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-bitops -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-bitops"
> ==7179==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 3 ahci-test /x86_64/ahci/pci_enable
> PASS 1 test-bitops /bitops/sextract32
> PASS 2 test-bitops /bitops/sextract64
> ---
> PASS 3 test-bitcnt /bitcnt/ctpop32
> PASS 4 test-bitcnt /bitcnt/ctpop64
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-qdev-global-props -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-qdev-global-props"
> ==7188==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 test-qdev-global-props /qdev/properties/static/default
> PASS 2 test-qdev-global-props /qdev/properties/static/global
> PASS 3 test-qdev-global-props /qdev/properties/dynamic/global
> ---
> PASS 18 test-qemu-opts /qemu-opts/to_qdict/filtered
> PASS 19 test-qemu-opts /qemu-opts/to_qdict/duplicates
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-keyval -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-keyval"
> ==7219==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 test-keyval /keyval/keyval_parse
> PASS 2 test-keyval /keyval/keyval_parse/list
> PASS 3 test-keyval /keyval/visit/bool
> ---
> PASS 3 test-crypto-hmac /crypto/hmac/prealloc
> PASS 4 test-crypto-hmac /crypto/hmac/digest
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-crypto-cipher -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-crypto-cipher"
> ==7236==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 test-crypto-cipher /crypto/cipher/aes-ecb-128
> PASS 2 test-crypto-cipher /crypto/cipher/aes-ecb-192
> PASS 3 test-crypto-cipher /crypto/cipher/aes-ecb-256
> ---
> PASS 6 ahci-test /x86_64/ahci/identify
> PASS 1 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/perfectserver
> PASS 2 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/perfectclient
> ==7263==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 7 ahci-test /x86_64/ahci/max
> PASS 3 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodca1
> PASS 4 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodca2
> ==7269==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 8 ahci-test /x86_64/ahci/reset
> ==7275==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 5 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodca3
> PASS 6 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badca1
> PASS 7 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badca2
> PASS 8 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badca3
> ==7275==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7fff002bd000; bottom 0x7f9d075fe000; size: 0x0061f8cbf000 (420785942528)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 9 ahci-test /x86_64/ahci/io/pio/lba28/simple/zero
> PASS 9 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver1
> PASS 10 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver2
> ==7281==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 11 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver3
> ==7281==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7ffd61bc4000; bottom 0x7f2f5cffe000; size: 0x00ce04bc6000 (884842717184)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 10 ahci-test /x86_64/ahci/io/pio/lba28/simple/low
> ==7287==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 12 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver4
> PASS 13 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver5
> ==7287==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7ffe34264000; bottom 0x7fe2117fe000; size: 0x001c22a66000 (120840413184)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 11 ahci-test /x86_64/ahci/io/pio/lba28/simple/high
> ==7293==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7293==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7fff56b64000; bottom 0x7f62601fe000; size: 0x009cf6966000 (674151948288)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 12 ahci-test /x86_64/ahci/io/pio/lba28/double/zero
> PASS 14 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver6
> ==7299==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7299==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7ffc64720000; bottom 0x7f64605fe000; size: 0x009804122000 (652903325696)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 13 ahci-test /x86_64/ahci/io/pio/lba28/double/low
> ---
> PASS 32 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/inactive1
> PASS 33 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/inactive2
> PASS 34 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/inactive3
> ==7305==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 35 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/chain1
> PASS 36 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/chain2
> PASS 37 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/missingca
> PASS 38 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/missingserver
> PASS 39 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/missingclient
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-crypto-tlssession -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-crypto-tlssession"
> ==7305==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7fff6cc4c000; bottom 0x7f56a17fe000; size: 0x00a8cb44e000 (724964794368)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 14 ahci-test /x86_64/ahci/io/pio/lba28/double/high
> PASS 1 test-crypto-tlssession /qcrypto/tlssession/psk
> ==7315==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7315==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7ffc227fc000; bottom 0x7f83a1ffe000; size: 0x0078807fe000 (517551939584)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 2 test-crypto-tlssession /qcrypto/tlssession/basicca
> ---
> PASS 15 ahci-test /x86_64/ahci/io/pio/lba28/long/zero
> PASS 4 test-crypto-tlssession /qcrypto/tlssession/altname1
> PASS 5 test-crypto-tlssession /qcrypto/tlssession/altname2
> ==7321==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 6 test-crypto-tlssession /qcrypto/tlssession/altname3
> ==7321==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7fff81f6d000; bottom 0x7f44809fe000; size: 0x00bb0156f000 (803181359104)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 16 ahci-test /x86_64/ahci/io/pio/lba28/long/low
> PASS 7 test-crypto-tlssession /qcrypto/tlssession/altname4
> ==7327==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7327==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7fffe5714000; bottom 0x7fad17dfe000; size: 0x0052cd916000 (355636174848)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 17 ahci-test /x86_64/ahci/io/pio/lba28/long/high
> PASS 8 test-crypto-tlssession /qcrypto/tlssession/altname5
> ==7333==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 18 ahci-test /x86_64/ahci/io/pio/lba28/short/zero
> ==7339==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 9 test-crypto-tlssession /qcrypto/tlssession/altname6
> PASS 19 ahci-test /x86_64/ahci/io/pio/lba28/short/low
> ==7345==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 10 test-crypto-tlssession /qcrypto/tlssession/wildcard1
> PASS 20 ahci-test /x86_64/ahci/io/pio/lba28/short/high
> PASS 11 test-crypto-tlssession /qcrypto/tlssession/wildcard2
> ==7351==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7351==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7ffcf3a3b000; bottom 0x7f3c985fe000; size: 0x00c05b43d000 (826164891648)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 12 test-crypto-tlssession /qcrypto/tlssession/wildcard3
> PASS 21 ahci-test /x86_64/ahci/io/pio/lba48/simple/zero
> PASS 13 test-crypto-tlssession /qcrypto/tlssession/wildcard4
> PASS 14 test-crypto-tlssession /qcrypto/tlssession/wildcard5
> ==7357==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7357==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7ffdcaf2c000; bottom 0x7f5027dfe000; size: 0x00ada312e000 (745765265408)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 22 ahci-test /x86_64/ahci/io/pio/lba48/simple/low
> PASS 15 test-crypto-tlssession /qcrypto/tlssession/wildcard6
> ==7363==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7363==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7ffffd000000; bottom 0x7f21b2ffe000; size: 0x00de4a002000 (954724261888)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 23 ahci-test /x86_64/ahci/io/pio/lba48/simple/high
> PASS 16 test-crypto-tlssession /qcrypto/tlssession/cachain
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-qga -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-qga"
> ==7369==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7369==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7ffef2970000; bottom 0x7f88655fe000; size: 0x00768d372000 (509175341056)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 24 ahci-test /x86_64/ahci/io/pio/lba48/double/zero
> ---
> PASS 6 test-qga /qga/get-vcpus
> PASS 7 test-qga /qga/get-fsinfo
> PASS 8 test-qga /qga/get-memory-block-info
> ==7383==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 9 test-qga /qga/get-memory-blocks
> PASS 10 test-qga /qga/file-ops
> PASS 11 test-qga /qga/file-write-read
> ---
> PASS 15 test-qga /qga/invalid-cmd
> PASS 16 test-qga /qga/invalid-args
> PASS 17 test-qga /qga/fsfreeze-status
> ==7383==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7ffd9e89e000; bottom 0x7fbbaaffe000; size: 0x0041f38a0000 (283258781696)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 25 ahci-test /x86_64/ahci/io/pio/lba48/double/low
> ==7392==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7392==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7ffeae63d000; bottom 0x7f5c7b7fe000; size: 0x00a232e3f000 (696638500864)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 26 ahci-test /x86_64/ahci/io/pio/lba48/double/high
> ---
> PASS 19 test-qga /qga/config
> PASS 20 test-qga /qga/guest-exec
> PASS 21 test-qga /qga/guest-exec-invalid
> ==7398==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7398==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7fffe5b49000; bottom 0x7fd2477fe000; size: 0x002d9e34b000 (195927781376)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 27 ahci-test /x86_64/ahci/io/pio/lba48/long/zero
> ---
> PASS 24 test-qga /qga/guest-get-timezone
> PASS 25 test-qga /qga/guest-get-users
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-timed-average -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-timed-average"
> ==7416==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 test-timed-average /timed-average/average
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-util-filemonitor -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-util-filemonitor"
> ==7416==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7ffe3805e000; bottom 0x7fe46437c000; size: 0x0019d3ce2000 (110927683584)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 1 test-util-filemonitor /util/filemonitor
> ---
> PASS 5 test-authz-list /auth/list/explicit/deny
> PASS 6 test-authz-list /auth/list/explicit/allow
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-authz-listfile -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-authz-listfile"
> ==7436==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 test-authz-listfile /auth/list/complex
> PASS 2 test-authz-listfile /auth/list/default/deny
> PASS 3 test-authz-listfile /auth/list/default/allow
> PASS 4 test-authz-listfile /auth/list/explicit/deny
> PASS 5 test-authz-listfile /auth/list/explicit/allow
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-io-task -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-io-task"
> ==7436==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7ffc0b00a000; bottom 0x7f6e47b24000; size: 0x008dc34e6000 (608867082240)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 1 test-io-task /crypto/task/complete
> ---
> PASS 4 test-io-channel-file /io/channel/pipe/sync
> PASS 5 test-io-channel-file /io/channel/pipe/async
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-io-channel-tls -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-io-channel-tls"
> ==7503==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 30 ahci-test /x86_64/ahci/io/pio/lba48/short/zero
> PASS 1 test-io-channel-tls /qio/channel/tls/basic
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-io-channel-command -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-io-channel-command"
> ---
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-io-channel-buffer -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-io-channel-buffer"
> PASS 1 test-io-channel-buffer /io/channel/buf
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-base64 -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-base64"
> ==7522==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 test-base64 /util/base64/good
> PASS 2 test-base64 /util/base64/embedded-nul
> PASS 3 test-base64 /util/base64/not-nul-terminated
> ---
> PASS 3 test-crypto-afsplit /crypto/afsplit/sha256/big
> PASS 4 test-crypto-afsplit /crypto/afsplit/sha1/1000
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-crypto-xts -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-crypto-xts"
> ==7547==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 test-crypto-xts /crypto/xts/t-1-key-32-ptx-32/basic
> PASS 2 test-crypto-xts /crypto/xts/t-1-key-32-ptx-32/split
> PASS 3 test-crypto-xts /crypto/xts/t-1-key-32-ptx-32/unaligned
> ---
> PASS 3 test-logging /logging/logfile_write_path
> PASS 4 test-logging /logging/logfile_lock_path
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-replication -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-replication"
> ==7572==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7568==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 1 test-replication /replication/primary/read
> PASS 2 test-replication /replication/primary/write
> PASS 33 ahci-test /x86_64/ahci/io/dma/lba28/fragmented
> ==7580==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 3 test-replication /replication/primary/start
> PASS 4 test-replication /replication/primary/stop
> PASS 5 test-replication /replication/primary/do_checkpoint
> PASS 6 test-replication /replication/primary/get_error_all
> PASS 34 ahci-test /x86_64/ahci/io/dma/lba28/retry
> ==7586==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 7 test-replication /replication/secondary/read
> PASS 35 ahci-test /x86_64/ahci/io/dma/lba28/simple/zero
> ==7592==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 8 test-replication /replication/secondary/write
> PASS 36 ahci-test /x86_64/ahci/io/dma/lba28/simple/low
> ==7598==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 37 ahci-test /x86_64/ahci/io/dma/lba28/simple/high
> ==7604==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 38 ahci-test /x86_64/ahci/io/dma/lba28/double/zero
> ==7611==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7572==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7fff0833c000; bottom 0x7f0912b5b000; size: 0x00f5f57e1000 (1056385667072)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 39 ahci-test /x86_64/ahci/io/dma/lba28/double/low
> ==7632==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 9 test-replication /replication/secondary/start
> PASS 40 ahci-test /x86_64/ahci/io/dma/lba28/double/high
> ==7638==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7638==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7ffc7cf43000; bottom 0x7f5f3bf7b000; size: 0x009d40fc8000 (675400155136)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 41 ahci-test /x86_64/ahci/io/dma/lba28/long/zero
> ==7645==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7645==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7ffeeffac000; bottom 0x7f25ed57b000; size: 0x00d902a31000 (932052144128)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 42 ahci-test /x86_64/ahci/io/dma/lba28/long/low
> PASS 10 test-replication /replication/secondary/stop
> ==7653==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7653==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7ffcc3883000; bottom 0x7f6c5af23000; size: 0x009068960000 (620229951488)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 43 ahci-test /x86_64/ahci/io/dma/lba28/long/high
> ==7660==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 44 ahci-test /x86_64/ahci/io/dma/lba28/short/zero
> ==7666==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 45 ahci-test /x86_64/ahci/io/dma/lba28/short/low
> PASS 11 test-replication /replication/secondary/continuous_replication
> ==7672==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 46 ahci-test /x86_64/ahci/io/dma/lba28/short/high
> ==7678==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 47 ahci-test /x86_64/ahci/io/dma/lba48/simple/zero
> ==7684==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 12 test-replication /replication/secondary/do_checkpoint
> PASS 48 ahci-test /x86_64/ahci/io/dma/lba48/simple/low
> ==7690==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 13 test-replication /replication/secondary/get_error_all
> PASS 49 ahci-test /x86_64/ahci/io/dma/lba48/simple/high
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-bufferiszero -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-bufferiszero"
> ==7696==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 50 ahci-test /x86_64/ahci/io/dma/lba48/double/zero
> ==7705==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 51 ahci-test /x86_64/ahci/io/dma/lba48/double/low
> ==7711==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 52 ahci-test /x86_64/ahci/io/dma/lba48/double/high
> ==7717==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7717==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7ffc31157000; bottom 0x7faabaf23000; size: 0x005176234000 (349874372608)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 53 ahci-test /x86_64/ahci/io/dma/lba48/long/zero
> ==7724==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7724==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7ffe83130000; bottom 0x7f6ac49fd000; size: 0x0093be733000 (634555412480)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 54 ahci-test /x86_64/ahci/io/dma/lba48/long/low
> ==7731==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7731==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7fffaec42000; bottom 0x7f0618123000; size: 0x00f996b1f000 (1071975100416)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 55 ahci-test /x86_64/ahci/io/dma/lba48/long/high
> ==7738==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 56 ahci-test /x86_64/ahci/io/dma/lba48/short/zero
> ==7744==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 57 ahci-test /x86_64/ahci/io/dma/lba48/short/low
> ==7750==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 58 ahci-test /x86_64/ahci/io/dma/lba48/short/high
> ==7756==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 59 ahci-test /x86_64/ahci/io/ncq/simple
> ==7762==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 60 ahci-test /x86_64/ahci/io/ncq/retry
> ==7768==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 61 ahci-test /x86_64/ahci/flush/simple
> ==7774==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 62 ahci-test /x86_64/ahci/flush/retry
> ==7780==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7786==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 63 ahci-test /x86_64/ahci/flush/migrate
> ==7794==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7800==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 64 ahci-test /x86_64/ahci/migrate/sanity
> ==7808==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7814==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 65 ahci-test /x86_64/ahci/migrate/dma/simple
> ==7822==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7828==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 66 ahci-test /x86_64/ahci/migrate/dma/halted
> ==7836==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7842==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 67 ahci-test /x86_64/ahci/migrate/ncq/simple
> ==7850==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7856==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 68 ahci-test /x86_64/ahci/migrate/ncq/halted
> ==7864==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 69 ahci-test /x86_64/ahci/cdrom/eject
> ==7869==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 70 ahci-test /x86_64/ahci/cdrom/dma/single
> ==7875==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 71 ahci-test /x86_64/ahci/cdrom/dma/multi
> PASS 1 test-bufferiszero /cutils/bufferiszero
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-uuid -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-uuid"
> ==7881==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 72 ahci-test /x86_64/ahci/cdrom/pio/single
> PASS 1 test-uuid /uuid/is_null
> PASS 2 test-uuid /uuid/generate
> ---
> PASS 1 test-qapi-util /qapi/util/qapi_enum_parse
> PASS 2 test-qapi-util /qapi/util/parse_qapi_name
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  tests/test-qgraph -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="test-qgraph"
> ==7890==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7890==WARNING: ASan is ignoring requested __asan_handle_no_return: stack top: 0x7ffff9df0000; bottom 0x7f72e9fba000; size: 0x008d0fe36000 (605856948224)
> False positive error reports may follow
> For details see https://urldefense.com/v3/__https://github.com/google/sanitizers/issues/189__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnViceiqsExY$
> PASS 1 test-qgraph /qgraph/init_nop
> ---
> PASS 22 test-qgraph /qgraph/test_test_in_path
> PASS 23 test-qgraph /qgraph/test_double_edge
> PASS 73 ahci-test /x86_64/ahci/cdrom/pio/multi
> ==7906==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 74 ahci-test /x86_64/ahci/cdrom/pio/bcl
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img tests/qtest/hd-geo-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="hd-geo-test"
> PASS 1 hd-geo-test /x86_64/hd-geo/ide/none
> ==7920==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 2 hd-geo-test /x86_64/hd-geo/ide/drive/cd_0
> ==7926==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 3 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/blank
> ==7932==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 4 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/lba
> ==7938==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 5 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/chs
> ==7944==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 6 hd-geo-test /x86_64/hd-geo/ide/device/mbr/blank
> ==7950==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 7 hd-geo-test /x86_64/hd-geo/ide/device/mbr/lba
> ==7956==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 8 hd-geo-test /x86_64/hd-geo/ide/device/mbr/chs
> ==7962==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 9 hd-geo-test /x86_64/hd-geo/ide/device/user/chs
> ==7967==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 10 hd-geo-test /x86_64/hd-geo/ide/device/user/chst
> ==7973==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7977==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7981==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7985==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7989==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7993==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==7997==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8001==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8004==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 11 hd-geo-test /x86_64/hd-geo/override/ide
> ==8011==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8015==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8019==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8023==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8027==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8031==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8035==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8039==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8042==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 12 hd-geo-test /x86_64/hd-geo/override/scsi
> ==8049==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8053==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8057==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8061==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8065==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8069==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8073==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8077==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8080==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 13 hd-geo-test /x86_64/hd-geo/override/scsi_2_controllers
> ==8087==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8091==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8095==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8099==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8102==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 14 hd-geo-test /x86_64/hd-geo/override/virtio_blk
> ==8109==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8113==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8116==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 15 hd-geo-test /x86_64/hd-geo/override/zero_chs
> ==8123==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8127==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8131==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8135==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8138==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 16 hd-geo-test /x86_64/hd-geo/override/scsi_hot_unplug
> ==8145==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8149==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8153==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8157==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> ==8160==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 17 hd-geo-test /x86_64/hd-geo/override/virtio_hot_unplug
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img tests/qtest/boot-order-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="boot-order-test"
> PASS 1 boot-order-test /x86_64/boot-order/pc
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or directory
> qemu-system-x86_64: falling back to tcg
> ==8229==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/pc/FACP'
> Using expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or directory
> qemu-system-x86_64: falling back to tcg
> ==8235==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/q35/FACP'
> Using expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or directory
> qemu-system-x86_64: falling back to tcg
> ==8241==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/pc/FACP.bridge'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or directory
> qemu-system-x86_64: falling back to tcg
> ==8247==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/pc/FACP.ipmikcs'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or directory
> qemu-system-x86_64: falling back to tcg
> ==8253==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/pc/FACP.cphp'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or directory
> qemu-system-x86_64: falling back to tcg
> ==8260==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/pc/FACP.memhp'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or directory
> qemu-system-x86_64: falling back to tcg
> ==8266==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/pc/FACP.numamem'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or directory
> qemu-system-x86_64: falling back to tcg
> ==8272==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/pc/FACP.dimmpxm'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or directory
> qemu-system-x86_64: falling back to tcg
> ==8281==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/pc/FACP.acpihmat'
> Looking for expected file 'tests/data/acpi/pc/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or directory
> qemu-system-x86_64: falling back to tcg
> ==8288==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/q35/FACP.bridge'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or directory
> qemu-system-x86_64: falling back to tcg
> ==8294==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/q35/FACP.mmio64'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or directory
> qemu-system-x86_64: falling back to tcg
> ==8300==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/q35/FACP.ipmibt'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or directory
> qemu-system-x86_64: falling back to tcg
> ==8306==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/q35/FACP.cphp'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or directory
> qemu-system-x86_64: falling back to tcg
> ==8313==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/q35/FACP.memhp'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or directory
> qemu-system-x86_64: falling back to tcg
> ==8319==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/q35/FACP.numamem'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or directory
> qemu-system-x86_64: falling back to tcg
> ==8325==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/q35/FACP.dimmpxm'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or directory
> qemu-system-x86_64: falling back to tcg
> ==8334==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>
> Looking for expected file 'tests/data/acpi/q35/FACP.acpihmat'
> Looking for expected file 'tests/data/acpi/q35/FACP'
> ---
> PASS 1 i440fx-test /x86_64/i440fx/defaults
> PASS 2 i440fx-test /x86_64/i440fx/pam
> PASS 3 i440fx-test /x86_64/i440fx/firmware/bios
> ==8426==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 4 i440fx-test /x86_64/i440fx/firmware/pflash
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img tests/qtest/fw_cfg-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="fw_cfg-test"
> PASS 1 fw_cfg-test /x86_64/fw_cfg/signature
> ---
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img tests/qtest/drive_del-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="drive_del-test"
> PASS 1 drive_del-test /x86_64/drive_del/without-dev
> PASS 2 drive_del-test /x86_64/drive_del/after_failed_device_add
> ==8519==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> PASS 3 drive_del-test /x86_64/blockdev/drive_del_device_del
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img tests/qtest/wdt_ib700-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-name="wdt_ib700-test"
> PASS 1 wdt_ib700-test /x86_64/wdt_ib700/pause
> ---
> dbus-daemon[8689]: Could not get password database information for UID of current process: User "???" unknown or no memory to allocate password entry
>
> **
> ERROR:/tmp/qemu-test/src/tests/qtest/dbus-vmstate-test.c:114:get_connection: assertion failed (err == NULL): The connection is closed (g-io-error-quark, 18)
> cleaning up pid 8689
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/dbus-vmstate-test.c:114:get_connection: assertion failed (err == NULL): The connection is closed (g-io-error-quark, 18)
> make: *** [/tmp/qemu-test/src/tests/Makefile.include:632: check-qtest-x86_64] Error 1
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
>    File "./tests/docker/docker.py", line 664, in <module>
> ---
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=7b3f2786458443e69818e5382692a70b', '-u', '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=x86_64-softmmu', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-25lfez9y/src/docker-src.2020-03-09-20.27.01.14215:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run', 'test-debug']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=7b3f2786458443e69818e5382692a70b
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-25lfez9y/src'
> make: *** [docker-run-test-debug@fedora] Error 2
>
> real    26m57.844s
> user    0m8.803s
>
>
> The full log is available at
> https://urldefense.com/v3/__http://patchew.org/logs/20200309235411.76587-1-liran.alon@oracle.com/testing.asan/?type=message__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnVicvfj4wMY$ .
> ---
> Email generated automatically by Patchew [https://urldefense.com/v3/__https://patchew.org/__;!!GqivPVa7Brio!N5car8IBDE_QFIGGfZAaPfF3gc3sv_CIDltJvgI8K5bvOLgPcGxKnVicsceQOUQ$ ].
> Please send your feedback to patchew-devel@redhat.com

