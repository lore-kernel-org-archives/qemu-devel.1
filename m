Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE80C1747C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 13:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 546A421928
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 13:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BxR9bJD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546A421928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRzLT-0002He-E8
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 08:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1iRzKk-0001cd-Im
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 08:57:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1iRzKh-0004M1-MW
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 08:57:22 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49788)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1iRzKh-0004Jn-D6
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 08:57:19 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA5DsP0I151403;
 Tue, 5 Nov 2019 13:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=oAqK6I15l/l+8k5sOGeuSz29Iy9S+FoV4KjOd0QtTR8=;
 b=BxR9bJD/YFpv8yXEJPcr3NVluuiiSOVH6IcmxyN6Ws4mCkf5kKgwfzP76OoEM5AbPIy0
 d5PaEsCl1b4a/JIXpiPUXSuOSomwysq+faR/XUXPm0GfnuV5RWF6GDZDJbp7E3gl1Nqb
 MEcfV8l1eG2TBOar2n3frOkW/g1SnuUBwMDZFf8GUfonVxJiL86a0oupMEw9MvVkeB7E
 dvPrMNZpxqMekKgfXlxjXbId93dr1mAxjQi9heg7fg1UQ1GzWA0xcCLa8mxJQ6W1kVAR
 cqpJDBrcCyek4wsu5233JGZh2boKqVFBKfgRCcmMxgq5ApmpeiDJx0LBB7bvkbtvuUrx Xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2w117txe2d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Nov 2019 13:57:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA5Ds7XQ086379;
 Tue, 5 Nov 2019 13:57:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2w3161bsqk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Nov 2019 13:57:15 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA5DvEgS026347;
 Tue, 5 Nov 2019 13:57:14 GMT
Received: from starbug-mbp.localdomain (/10.169.111.121)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 05 Nov 2019 05:57:14 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 362AB4AA202C;
 Tue,  5 Nov 2019 13:57:12 +0000 (GMT)
Date: Tue, 5 Nov 2019 13:57:12 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 00/20] Add virtual device fuzzing support
Message-ID: <20191105135711.lld344zgbin2tz72@starbug-mbp>
Mail-Followup-To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191030144926.11873-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-1-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911050116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911050116
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alexander,

I've been trying out these patches, and I'm seeing a high volume of
crashes - where for v3, there were none in a run of over 3 weeks -
so it was a bit of a surprise :)

The question is what may have changed that is causing that level of
crashes - are you seeing this for the virtio-net-fork-fuzz tests?

But also, I've been trying to debug some of these crashes - and the
expectation is that you pass the crash-XXXX file as an argument to
the qemu-fuzz-* binary - and when I do, I see the crash - but when I
try to debug it, it ends up running through and exiting.

My assumption is that because of the fork in the test, the crash is
in one of the children.

(ASIDE: I think it might be worth adding a debugging/analysing
section to the documentation you've added to help people debug such
crashes)

Setting follow-fork-mode to child does get me there, and each crash
seems, at least in the samples that I've taken, to be in iov_copy:

  #0  0x00007ffff4cff377 in raise () from /lib64/libc.so.6
  #1  0x00007ffff4d00a68 in abort () from /lib64/libc.so.6
  #2  0x00007ffff4cf8196 in __assert_fail_base () from
  /lib64/libc.so.6
  #3  0x00007ffff4cf8242 in __assert_fail () from /lib64/libc.so.6
  #4  0x00005555574d4026 in iov_copy ()
  #5  0x000055555640dbd8 in virtio_net_flush_tx ()
  #6  0x000055555640c8ef in virtio_net_tx_bh ()
  #7  0x00005555574a05bb in aio_bh_call ()
  #8  0x00005555574a0a34 in aio_bh_poll ()
  #9  0x00005555574b1687 in aio_dispatch ()
  #10 0x00005555574a35f9 in aio_ctx_dispatch ()
  #11 0x00007ffff5e5d099 in g_main_context_dispatch () from
  /lib64/libglib-2.0.so.0
  #12 0x00005555574ae9fd in glib_pollfds_poll ()
  #13 0x00005555574ad972 in os_host_main_loop_wait ()
  #14 0x00005555574ad62c in main_loop_wait ()
  #15 0x000055555736c653 in flush_events ()
  #16 0x00005555573710a4 in virtio_net_fork_fuzz ()
  #17 0x000055555736cb85 in LLVMFuzzerTestOneInput ()
  ...

Have you seen these kind of crashes, or is this just me?

Just wondering if I should dig into it as a real issue, or some
mis-merge I've done (not all the patches were cleanly applied for
me when I cloned from master).

Thanks,

Darren.

On Wed, Oct 30, 2019 at 02:49:47PM +0000, Oleinik, Alexander wrote:
>This series adds a framework for coverage-guided fuzzing of
>virtual-devices. Fuzzing targets are based on qtest and can make use of
>the libqos abstractions.
>
>V4:
> * add/transfer license headers to new files
> * restructure the added QTestClientTransportOps struct
> * restructure the FuzzTarget struct and fuzzer skeleton
> * fork-based fuzzer now directly mmaps shm over the coverage bitmaps
> * fixes to i440 and virtio-net fuzz targets
> * undo the changes to qtest_memwrite
> * possible to build /fuzz and /all in the same build-dir
> * misc fixes to address V3 comments
>
>V3:
> * rebased onto v4.1.0+
> * add the fuzzer as a new build-target type in the build-system
> * add indirection to qtest client/server communication functions
> * remove ramfile and snapshot-based fuzzing support
> * add i440fx fuzz-target as a reference for developers.
> * add linker-script to assist with fork-based fuzzer
>
>V2:
> * split off changes to qos virtio-net and qtest server to other patches
> * move vl:main initialization into new func: qemu_init
> * moved useful functions from qos-test.c to a separate object
> * use struct of function pointers for add_fuzz_target(), instead of
>   arguments
> * move ramfile to migration/qemu-file
> * rewrite fork-based fuzzer pending patch to libfuzzer
> * pass check-patch
>
>Alexander Oleinik (20):
>  softmmu: split off vl.c:main() into main.c
>  libqos: Rename i2c_send and i2c_recv
>  fuzz: Add FUZZ_TARGET module type
>  qtest: add qtest_server_send abstraction
>  libqtest: Add a layer of abstraciton to send/recv
>  module: check module wasn't already initialized
>  qtest: add in-process incoming command handler
>  tests: provide test variables to other targets
>  libqos: split qos-test and libqos makefile vars
>  libqos: move useful qos-test funcs to qos_external
>  libqtest: make qtest_bufwrite send "atomic"
>  libqtest: add in-process qtest.c tx/rx handlers
>  fuzz: add configure flag --enable-fuzzing
>  fuzz: Add target/fuzz makefile rules
>  fuzz: add fuzzer skeleton
>  fuzz: add support for fork-based fuzzing.
>  fuzz: add support for qos-assisted fuzz targets
>  fuzz: add i440fx fuzz targets
>  fuzz: add virtio-net fuzz target
>  fuzz: add documentation to docs/devel/
>
> Makefile                     |  16 ++-
> Makefile.objs                |   4 +
> Makefile.target              |  18 ++-
> configure                    |  39 ++++++
> docs/devel/fuzzing.txt       | 119 ++++++++++++++++++
> exec.c                       |  12 +-
> include/qemu/module.h        |   4 +-
> include/sysemu/qtest.h       |   4 +
> include/sysemu/sysemu.h      |   4 +
> main.c                       |  52 ++++++++
> qtest.c                      |  30 ++++-
> tests/Makefile.include       |  75 +++++------
> tests/fuzz/Makefile.include  |  11 ++
> tests/fuzz/fork_fuzz.c       |  51 ++++++++
> tests/fuzz/fork_fuzz.h       |  23 ++++
> tests/fuzz/fork_fuzz.ld      |  37 ++++++
> tests/fuzz/fuzz.c            | 177 ++++++++++++++++++++++++++
> tests/fuzz/fuzz.h            |  66 ++++++++++
> tests/fuzz/i440fx_fuzz.c     | 176 ++++++++++++++++++++++++++
> tests/fuzz/qos_fuzz.c        | 232 +++++++++++++++++++++++++++++++++++
> tests/fuzz/qos_fuzz.h        |  33 +++++
> tests/fuzz/virtio_net_fuzz.c | 123 +++++++++++++++++++
> tests/libqos/i2c-imx.c       |   8 +-
> tests/libqos/i2c-omap.c      |   8 +-
> tests/libqos/i2c.c           |  10 +-
> tests/libqos/i2c.h           |   4 +-
> tests/libqos/qos_external.c  | 168 +++++++++++++++++++++++++
> tests/libqos/qos_external.h  |  28 +++++
> tests/libqtest.c             | 109 ++++++++++++++--
> tests/libqtest.h             |   4 +
> tests/pca9552-test.c         |  10 +-
> tests/qos-test.c             | 140 +--------------------
> util/module.c                |   7 ++
> vl.c                         |  36 ++----
> 34 files changed, 1601 insertions(+), 237 deletions(-)
> create mode 100644 docs/devel/fuzzing.txt
> create mode 100644 main.c
> create mode 100644 tests/fuzz/Makefile.include
> create mode 100644 tests/fuzz/fork_fuzz.c
> create mode 100644 tests/fuzz/fork_fuzz.h
> create mode 100644 tests/fuzz/fork_fuzz.ld
> create mode 100644 tests/fuzz/fuzz.c
> create mode 100644 tests/fuzz/fuzz.h
> create mode 100644 tests/fuzz/i440fx_fuzz.c
> create mode 100644 tests/fuzz/qos_fuzz.c
> create mode 100644 tests/fuzz/qos_fuzz.h
> create mode 100644 tests/fuzz/virtio_net_fuzz.c
> create mode 100644 tests/libqos/qos_external.c
> create mode 100644 tests/libqos/qos_external.h
>
>-- 
>2.23.0
>
>

