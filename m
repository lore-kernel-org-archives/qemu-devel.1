Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE6FC04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447A420578
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fNpU+/Kv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447A420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCPnE-0003G0-FP
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 10:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1iCPjk-0007Ng-4B
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1iCPjh-0003vl-K3
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:54:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1iCPjh-0003tY-Aj
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:54:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8NEruBa142903;
 Mon, 23 Sep 2019 14:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=cT5uyIv9lzbn0gUBZibIhEtXddkbRU+2bRIGARlpFnI=;
 b=fNpU+/KvMlEkyqtdK8dHViekhQAq/Ea4IkOzcT9R3fOtxVmiLXsES7GEHSFxqb8nrbwN
 bIqygsI/A7HO8ReisnT0G7WgG647YRUa+Czzv9LLryxo87Z6eTVhmNgkQANFsw3ud+NJ
 rikitMgfl5ppCR+mM7Wyk2KKuMYdWIX2vm78iQTusozLA309rsNnl2EhCEoDSBmoQEuZ
 MIxDlVgGEblDwGQThvMFHc/RyGicDgSIhb2QHucLXO7qNPOsd0VPYAEN+BJQLVn3+Kfx
 xM4Sf73HOeV24BQZpZPePPeRwv/qREtxranPdFpOS+052DRwjYWS8CYix3SYDNgu6sr5 uQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2v5b9tfgbn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2019 14:54:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8NErRse031115;
 Mon, 23 Sep 2019 14:54:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2v6yvpgx3c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2019 14:54:38 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8NEsZ3k031513;
 Mon, 23 Sep 2019 14:54:36 GMT
Received: from starbug-lenovo.ie.oracle.com (/10.169.104.251)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 23 Sep 2019 07:54:35 -0700
Date: Mon, 23 Sep 2019 15:54:33 +0100
From: Darren Kenny <darren.kenny@oracle.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [Qemu-devel] [PATCH v3 22/22] fuzz: add documentation to
 docs/devel/
Message-ID: <20190923145433.xnpfmjfzaqvedltp@starbug-lenovo.ie.oracle.com>
Mail-Followup-To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-23-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20190918231846.22538-23-alxndr@bu.edu>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909230142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909230142
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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

Some comments, and questions below...

On Wed, Sep 18, 2019 at 11:19:48PM +0000, Oleinik, Alexander wrote:
>Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
>---
> docs/devel/fuzzing.txt | 114 +++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 114 insertions(+)
> create mode 100644 docs/devel/fuzzing.txt
>
>diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
>new file mode 100644
>index 0000000000..53a1f858f5
>--- /dev/null
>+++ b/docs/devel/fuzzing.txt
>@@ -0,0 +1,114 @@
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
>+NOTE: If possible, build a 32-bit binary. When forking, the page map ends up
>+being much smaller. On 64-bit AddressSanitizer consumes 20 Terabytes of virtual
>+memory.

It might be worth having a little more on this, since I would
imagine most people would be more interested in 64-bit these days,
but are unlikely to have 20Tb available :)

But if there is little to be gained by the 64-bit vs 32-bit if
fuzzing a device, then it might be worth explaining why.

>+
>+To build the fuzzers, install a recent version of clang:
>+Configure with (substitute the clang binaries with the version you installed):
>+
>+    CC=clang-8 CXX=clang++-8 /path/to/configure --enable-fuzzing
>+
>+Fuzz targets are built similarily to system/softmmu:

Typo: s/similarily/similarly/

>+
>+    make i386-softmmu/fuzz
>+
>+This builds ./i386-softmmu/qemu-fuzz-i386

Reading this, it kind of implies that it should be also possible to
build i386-softmmu/all still - which from what I can see it isn't,
the build fails with an undefined 'main' - most likely the main.o
object is not being linked in for this target?

Unfortunately, also doing the above build command is also failing
for me after applying this set of patches:

  qemu-upstream-libfuzz/tests/fuzz/fuzz.c:149:28: error: expected expression
      fuzz_qts = qtest_setup(void);
                             ^
  1 error generated.
  make[1]: *** [tests/fuzz/fuzz.o] Error 1

This is due to the (void) in the calling of the function, will comment on the
patch separately.

>+
>+The first option to this command is: --FUZZER_NAME
>+To list all of the available fuzzers run qemu-fuzz-i386 with no arguments.
>+
>+Libfuzzer parses all arguments that do not begin with "--". Information about
>+these is available by passing -help=1
>+
>+Now the only thing left to do is wait for the fuzzer to trigger potential
>+crashes.

I would suggest adding an example of doing a run for this here.

>+
>+== Adding a new fuzzer ==
>+Coverage over virtual devices can be improved by adding additional fuzzers.
>+Fuzzers are kept in tests/fuzz/ and should be added to
>+tests/fuzz/Makefile.include
>+
>+Fuzzers can rely on both qtest and libqos to communicate with virtual devices.
>+
>+1. Create a new source file. For example ``tests/fuzz/fuzz-foo-device.c``.
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
>+
>+= Implmentation Details =
>+
>+== The Fuzzer's Lifecycle ==
>+
>+The fuzzer has two entrypoints that libfuzzer calls.
>+
>+LLVMFuzzerInitialize: called prior to fuzzing. Used to initialize all of the
>+necessary state
>+
>+LLVMFuzzerTestOneInput: called for each fuzzing run. Processes the input and
>+resets the state at the end of each run.

It might be worth explicitly mentioning that Libfuzzer provides it's
own main() function which calls these.

>+
>+In more detail:
>+
>+LLVMFuzzerInitialize parses the arguments to the fuzzer (must start with two
>+dashes, so they are ignored by libfuzzer main()). Currently, the arguments
>+select the fuzz target. Then, the qtest client is initialized. If the target
>+requires qos, qgraph is set up and the QOM/LIBQOS modules are initailized.
>+Then the QGraph is walked and the QEMU cmd_line is determined and saved.
>+
>+After this, the vl.c:real_main is called to set up the guest. After this, the
>+fuzzer saves the initial vm/device state to ram, after which the initilization
>+is complete.

Is this still true with this patchset? I don't see real_main being
defined any more in vl.c.

>+
>+LLVMFuzzerTestOneInput: Uses qtest/qos functions to act based on the fuzz
>+input. It is also responsible for manually calling the main loop/main_loop_wait
>+to ensure that bottom halves are executed. Finally, it calls reset() which
>+restores state from the ramfile and/or resets the guest.
>+
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
>+   Example target: --virtio-net-ctrl-fuzz
>+2. Run each test case in a separate forked process and copy the coverage
>+   information back to the parent. This is fairly similar to AFL's "deferred"
>+   fork-server mode [3]
>+   Pros: Relatively fast. Devices only need to be initialized once. No need
>+   to do slow reboots or vmloads.
>+   Cons: Not officially supported by libfuzzer and the implementation is very
>+   flimsy. Does not work well for devices that rely on dedicated threads.
>+   Example target: --qtest-fork-fuzz
>+

Thanks,

Darren.


