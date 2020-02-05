Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDF9C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 477B020702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qPpCBJnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477B020702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKrE-0002ZT-FS
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1izKoH-000643-No
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:33:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1izKoF-0003pV-WC
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:33:41 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38210)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1izKoF-0003mZ-LT
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:33:39 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015DOGWv105884;
 Wed, 5 Feb 2020 13:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=SGgNbc6hlzFJj81WKlniWx3UYzUf9J4IUZbGBDxN7KU=;
 b=qPpCBJnJAq/SvHT1c8plTWn4JCfK07/vsYie4/iwnZ329AchOIcykoIRPCf58yJ/7m1p
 pqg9GR4DK7e1U9y2QDu9J1fPorvOVdKYmKRBlwmhtXQLe6qazrPJ2a4OrCtLB5jeAFPO
 etJFF9thwMVa2hpCUOqpN8Fi3uq4vBY3GbEP3+HiMSmsohqJPkXZ/LgdIkSbf1/eZm0C
 Bhv07+55DPiyfHoFqi8VwNb8IqzlK2TwqatGEPq8Y7SWZMs5JFBFDTst2fPbUvU+/Wnn
 npRUYnKvpDd/h5nATUZqiCpbAgcJymKEMTbz9/K0c/XxUp1g/zuzrandZJgppGfeqkqs jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2xykbp30aq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 13:33:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015DTQ0o121249;
 Wed, 5 Feb 2020 13:33:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2xykc2vk7u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 13:33:36 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 015DXZ7t000457;
 Wed, 5 Feb 2020 13:33:35 GMT
Received: from starbug-mbp.localdomain (/10.169.111.17)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 05:33:35 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 0DD0457DBCCC;
 Wed,  5 Feb 2020 13:33:32 +0000 (GMT)
Date: Wed, 5 Feb 2020 13:33:32 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 21/21] fuzz: add documentation to docs/devel/
Message-ID: <20200205133332.6tns5uwq4tqoiwv4@starbug-mbp>
Mail-Followup-To: "Bulekov, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-22-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129053357.27454-22-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050109
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

On Wed, Jan 29, 2020 at 05:34:29AM +0000, Bulekov, Alexander wrote:
>Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> docs/devel/fuzzing.txt | 116 +++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 116 insertions(+)
> create mode 100644 docs/devel/fuzzing.txt
>
>diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
>new file mode 100644
>index 0000000000..324d2cd92b
>--- /dev/null
>+++ b/docs/devel/fuzzing.txt
>@@ -0,0 +1,116 @@
>+= Fuzzing =
>+
>+== Introduction ==
>+
>+This document describes the virtual-device fuzzing infrastructure in QEMU and
>+how to use it to implement additional fuzzers.
>+
>+== Basics ==
>+
>+Fuzzing operates by passing inputs to an entry point/target function. The
>+fuzzer tracks the code coverage triggered by the input. Based on these
>+findings, the fuzzer mutates the input and repeats the fuzzing.
>+
>+To fuzz QEMU, we rely on libfuzzer. Unlike other fuzzers such as AFL, libfuzzer
>+is an _in-process_ fuzzer. For the developer, this means that it is their
>+responsibility to ensure that state is reset between fuzzing-runs.
>+
>+== Building the fuzzers ==
>+
>+NOTE: If possible, build a 32-bit binary. When forking, the 32-bit fuzzer is
>+much faster, since the page-map has a smaller size. This is due to the fact that
>+AddressSanitizer mmaps ~20TB of memory, as part of its detection. This results
>+in a large page-map, and a much slower fork().
>+
>+To build the fuzzers, install a recent version of clang:
>+Configure with (substitute the clang binaries with the version you installed):
>+
>+    CC=clang-8 CXX=clang++-8 /path/to/configure --enable-fuzzing
>+
>+Fuzz targets are built similarly to system/softmmu:
>+
>+    make i386-softmmu/fuzz
>+
>+This builds ./i386-softmmu/qemu-fuzz-i386
>+
>+The first option to this command is: --fuzz_taget=FUZZ_NAME
>+To list all of the available fuzzers run qemu-fuzz-i386 with no arguments.
>+
>+eg:
>+    ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=virtio-net-fork-fuzz
>+
>+Internally, libfuzzer parses all arguments that do not begin with "--".
>+Information about these is available by passing -help=1
>+
>+Now the only thing left to do is wait for the fuzzer to trigger potential
>+crashes.
>+
>+== Adding a new fuzzer ==
>+Coverage over virtual devices can be improved by adding additional fuzzers.
>+Fuzzers are kept in tests/qtest/fuzz/ and should be added to
>+tests/qtest/fuzz/Makefile.include
>+
>+Fuzzers can rely on both qtest and libqos to communicate with virtual devices.
>+
>+1. Create a new source file. For example ``tests/qtest/fuzz/foo-device-fuzz.c``.
>+
>+2. Write the fuzzing code using the libqtest/libqos API. See existing fuzzers
>+for reference.
>+
>+3. Register the fuzzer in ``tests/fuzz/Makefile.include`` by appending the
>+corresponding object to fuzz-obj-y
>+
>+Fuzzers can be more-or-less thought of as special qtest programs which can
>+modify the qtest commands and/or qtest command arguments based on inputs
>+provided by libfuzzer. Libfuzzer passes a byte array and length. Commonly the
>+fuzzer loops over the byte-array interpreting it as a list of qtest commands,
>+addresses, or values.
>+
>+= Implementation Details =
>+
>+== The Fuzzer's Lifecycle ==
>+
>+The fuzzer has two entrypoints that libfuzzer calls. libfuzzer provides it's
>+own main(), which performs some setup, and calls the entrypoints:
>+
>+LLVMFuzzerInitialize: called prior to fuzzing. Used to initialize all of the
>+necessary state
>+
>+LLVMFuzzerTestOneInput: called for each fuzzing run. Processes the input and
>+resets the state at the end of each run.
>+
>+In more detail:
>+
>+LLVMFuzzerInitialize parses the arguments to the fuzzer (must start with two
>+dashes, so they are ignored by libfuzzer main()). Currently, the arguments
>+select the fuzz target. Then, the qtest client is initialized. If the target
>+requires qos, qgraph is set up and the QOM/LIBQOS modules are initialized.
>+Then the QGraph is walked and the QEMU cmd_line is determined and saved.
>+
>+After this, the vl.c:qemu__main is called to set up the guest. There are
>+target-specific hooks that can be called before and after qemu_main, for
>+additional setup(e.g. PCI setup, or VM snapshotting).
>+
>+LLVMFuzzerTestOneInput: Uses qtest/qos functions to act based on the fuzz
>+input. It is also responsible for manually calling the main loop/main_loop_wait
>+to ensure that bottom halves are executed and any cleanup required before the
>+next input.
>+
>+Since the same process is reused for many fuzzing runs, QEMU state needs to
>+be reset at the end of each run. There are currently two implemented
>+options for resetting state:
>+1. Reboot the guest between runs.
>+   Pros: Straightforward and fast for simple fuzz targets.
>+   Cons: Depending on the device, does not reset all device state. If the
>+   device requires some initialization prior to being ready for fuzzing
>+   (common for QOS-based targets), this initialization needs to be done after
>+   each reboot.
>+   Example target: i440fx-qtest-reboot-fuzz
>+2. Run each test case in a separate forked process and copy the coverage
>+   information back to the parent. This is fairly similar to AFL's "deferred"
>+   fork-server mode [3]
>+   Pros: Relatively fast. Devices only need to be initialized once. No need
>+   to do slow reboots or vmloads.
>+   Cons: Not officially supported by libfuzzer. Does not work well for devices
>+   that rely on dedicated threads.
>+   Example target: virtio-net-fork-fuzz
>-- 
>2.23.0
>
>

