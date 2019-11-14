Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FD2C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 082E8206EF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mHtLUUyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082E8206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVCnj-0001Vm-71
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 05:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1iVCn4-00016L-EV
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:55:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1iVCn2-0004bq-Mi
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:55:54 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1iVCn2-0004ai-9L
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:55:52 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEAsOxH097597;
 Thu, 14 Nov 2019 10:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=xkaCC0/Yn4FWYhHnv5+vH4MkUAhFHK41lAvE5zk5XfQ=;
 b=mHtLUUyfrhE3ryFq7R06wpgN/6gM4LLUw4nVXxsGGUwRoUcXTV3jic8+sOV1nk30Z3eY
 SKdYiKV3g6lpWFpV/Eu41gz7ouhltncru0QSk2uJy2CctVQqsc8BnMXi749/kbM8sc+X
 7qnWn6Rv+rzxCmENAzC0DDnqisFH89fprc02F+m/3KA/yvkgzPinEAwfh2iDj/aTNWSH
 NRI2j83IKnbLgBUCfZppNwPPnJ2DKBNdRVFcFhEhqXy08kDGTq9fUMOovIV+AdN3mwHo
 zADGlwIGt9gPNB9FdQj1rZoPsqEApZf9isS3hu2NQVxeRYT//0GGs9yImLenI9D4kU/z nA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2w5mvu2eaq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2019 10:55:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEAs9mI139634;
 Thu, 14 Nov 2019 10:55:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2w8g1968sv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2019 10:55:47 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAEAtkIE023210;
 Thu, 14 Nov 2019 10:55:46 GMT
Received: from starbug-mbp.localdomain (/10.175.200.230)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 14 Nov 2019 02:55:45 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 314AA4C0AF4E;
 Thu, 14 Nov 2019 10:55:43 +0000 (GMT)
Date: Thu, 14 Nov 2019 10:55:43 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v5 00/20] Add virtual device fuzzing support
Message-ID: <20191114105542.d56y5egnd3qm6yuf@starbug-mbp>
Mail-Followup-To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
References: <20191113225030.17023-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191113225030.17023-1-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911140101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911140102
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alexander,

A quick comment on the fact that you omitted any Reviewed-by's that
you have received so far.

Was that intentional?

Thanks,

Darren.

On Wed, Nov 13, 2019 at 10:50:41PM +0000, Oleinik, Alexander wrote:
>This series adds a framework for coverage-guided fuzzing of
>virtual-devices. Fuzzing targets are based on qtest and can make use of
>the libqos abstractions.
>
>V5:
> * misc fixes addressing V4 comments
> * cleanup in-process handlers/globals in libqtest.c
> * small fixes to fork-based fuzzing and support for multiple workers
> * changes to the virtio-net fuzzer to kick after each vq add
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
>Alexander Bulekov (20):
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
>  libqtest: make bufwrite rely on the TransportOps
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
> main.c                       |  53 ++++++++
> qtest.c                      |  31 ++++-
> tests/Makefile.include       |  75 +++++------
> tests/fuzz/Makefile.include  |  11 ++
> tests/fuzz/fork_fuzz.c       |  55 +++++++++
> tests/fuzz/fork_fuzz.h       |  23 ++++
> tests/fuzz/fork_fuzz.ld      |  37 ++++++
> tests/fuzz/fuzz.c            | 179 +++++++++++++++++++++++++++
> tests/fuzz/fuzz.h            |  94 ++++++++++++++
> tests/fuzz/i440fx_fuzz.c     | 176 ++++++++++++++++++++++++++
> tests/fuzz/qos_fuzz.c        | 232 +++++++++++++++++++++++++++++++++++
> tests/fuzz/qos_fuzz.h        |  33 +++++
> tests/fuzz/virtio_net_fuzz.c | 100 +++++++++++++++
> tests/libqos/i2c.c           |  10 +-
> tests/libqos/i2c.h           |   4 +-
> tests/libqos/qos_external.c  | 168 +++++++++++++++++++++++++
> tests/libqos/qos_external.h  |  28 +++++
> tests/libqtest.c             | 108 ++++++++++++++--
> tests/libqtest.h             |   4 +
> tests/pca9552-test.c         |  10 +-
> tests/qos-test.c             | 140 +--------------------
> util/module.c                |   7 ++
> vl.c                         |  38 ++----
> 32 files changed, 1607 insertions(+), 229 deletions(-)
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

