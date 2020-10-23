Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F52C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 20:08:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 236FE2074B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 20:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HRQsuc01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236FE2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW3MF-00069Z-2v
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 16:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kW3L5-0004dS-E8
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 16:07:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kW3L1-0003iJ-OM
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 16:07:03 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09NK1i9o099463; Fri, 23 Oct 2020 16:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=OTfcehDknONaImhz4tafuHRcB91Lpv5LpoHNfqLgmAM=;
 b=HRQsuc01Kqn+LEubUVEXYB3wdmrMeXTx09tp5Hdel/QnNVIMme3Eup7peQ/6AXebX4iG
 f5Jw4lhDNGQGx7D8pDN8/HTx1G9eU7HN0ANKf918KZQqkxOWlV8AgFENddB5cE7yKaFp
 Adcc6Ri4nlUQ8rn/+ER1Stp/TxnOQkYfgI9tLDZGujITi/mTaQGv4ZBvM6N6O0lR9ANu
 lC5T2y0ZBWpOuiRoLlAl12gk11LEanV1zybFno0d4aXb76fuiK+EWb1Tm5o70a8HLn8N
 07DsAYzuz+Yk2jUCwcCd9Ck8kyG/Z2jOuAxtdWeBDO4HMtQkVL2013wWfpfeGHhHtIRo Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34c4t9htf7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 16:06:55 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09NK1lah101266;
 Fri, 23 Oct 2020 16:06:55 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34c4t9htf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 16:06:55 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09NJv12r011838;
 Fri, 23 Oct 2020 20:06:54 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma01dal.us.ibm.com with ESMTP id 34bhyqhars-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2020 20:06:54 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09NK6lbH26280680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2020 20:06:47 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D341D6A051;
 Fri, 23 Oct 2020 20:06:52 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C1F86A047;
 Fri, 23 Oct 2020 20:06:52 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.65.212.19])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 23 Oct 2020 20:06:51 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] Add support for Control-Flow Integrity
Date: Fri, 23 Oct 2020 16:06:38 -0400
Message-Id: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-23_14:2020-10-23,
 2020-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010230119
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 16:06:56
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniele Buono <dbuono@linux.vnet.ibm.com>, Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2: Several months (and structural changes in QEMU) have passed since v1.
While the spirit of the patch is similar, the implementation is changed
in multiple points, and should address most if not all the comments
received in v1.
* Instead of disabling CFI in specific functions by using a filter file,
  disable cfi by using a new decorator to be prefixed to the function
  definition. The decorator is automatically expanded to an attribute
  asking clang to disable cfi-icall on the function.
  This should simplify tracking of sensitive function, compared to
  keeping the list in a separate file
  I tentatively added myself as maintainer of a new include file defined for
  that purpose, in case a maintainer is considered needed.
* Updated patch to work with the new build system based on meson
* Split LTO and CFI options. Now LTO can be used independently of CFI.
  LTO uses the meson option to build and can now work, in general, with
  any linker (ld, gold, lld). LTO with meson works fine with clang >=6
  and requires the use of LLVM's ar to handle shared libraries with
  intermediate code (selectable by setting the environment variable
  AR to llvm-ar-xx).
* Introduce a small patch for the linker script used by fuzzing targets,
  so that it works properly with both bfd and lld >=12
* Disable a couple of warning check that trigger errors with clang >= 11 
* Add additional checks for fuzzing and LTO. At the moment, only LLVM's
  lld linker v12 is able to support fuzzing and LTO, because of a bug in the
  bfd linker when handling --wrap with LTO. Therefore, automatically
  select lld if fuzzing and LTO are both enabled.
* Made sure that fuzzing works with LTO and CFI enabled.

-----
v1's cover letter starts here
-----

LLVM/Clang supports multiple types of forward-edge Control-Flow Integrity
(CFI), including runtime checks on indirect function calls.

CFI on indirect function calls can have a huge impact in enhancing QEMU
security, by significantly limiting one of the most used attack vectors
for VM Escape. Attacks demonstrated in [1],[2] and [3] will, at some
point, change a function pointer in a QEMU data structure.

At high level, LLVM's implementation relies on compile-time information
to create a range of consecutive trampolines for "compatible functions".
At runtime, if the pointer is not in the valid range, it is assumed that
the control flow was hijacked, and the process is terminated with an
"Illegal Instruction" exception.

CAVEATS:

1) For this CFI check to work, the code must always respect the function
signature when using function pointer. While this is generally true
in QEMU, there are a few instances where pointers are handled as
generic void* from the caller. Since this is a common approach, Clang
offer a flag to relax pointer checks and consider all pointer types
to be compatible.

2) Since CFI relies on compile-time information, it requires using
link-time optimization (LTO) to support CFI across compilation units.
This adds a requirement for the gold linker, and LLVM's versions of
static libraries tools (ar, ranlib, nm).

3) CFI checks cannot be performed on shared libraries (given that functions
are not known at compile time). This means that indirect function calls
will fail if the function pointer belong to a shared library.
This does not seem to be a big issue for a standard QEMU deployment today,
but QEMU modules won't be able to work when CFI is enabled.
There is a way to allow shared library pointers, but it is experimental
in LLVM, requires some work and reduces performance and security. For
these reasons, I think it's best to start with this version, and discuss
an extension for modules later.

4) CFI cannot be fully applied to TCG. The purpose of TCG is to transform
code on-the-fly from one ISA to another. In doing so, binary blobs of
executable code are created and called with function pointers.
Since the code did not exist at compile time, runtime CFI checks find such
functions illegal. To allow the code to keep running, CFI checks are not
performed in the core function of TCG/TCI, and in the code that
implements TCG plugins.
This does not affect QEMU when executed with KVM, and all the device
emulation code is always protected, even when using TCG.

5) Most of the logic to enable CFI goes in the configure, since it's
just a matter of checking for dependencies and incompatible options.
However, I had to disable CFI checks for a few TCG functions.
This can only be done through a blacklist file. I added a file in the
root of QEMU, called cfi-blacklist.txt for such purpose. I am open to
suggestions on where the file should go, and I am willing to become the
maintainer of it, if deemed necessary.

PERFORMANCE:

Enabling CFI creates a larger binary, which may be an issue in some use
cases. However, the increase is not exceptionally large. On my Ubuntu
system, with default options, I see an increase of stripped size from
14MiB to 15.3MiB when enabling CFI with Clang v9.

There is also a possible performance issue, since for every indirect
function call, and additional address check is performed, followed by
an additional indirect call to the trampoline function.
However, especially in the case of KVM-based virtualization, the impact
should be minimal, since indirect function pointers should be used mostly
for device emulation.

I used Kata Container's metrics tests since that is a simple,
reproducible set of tests to stress storage and network between VMs,
and run a Lifecycle test to measure VM startup times under a specific
workload. A full report is available here [4].

The difference between LLVM with and without CFI is generally low.
Sometimes CFI is actually offering better performance, which may be
explained by having a different binary layout because of LTO.
Lifecycle and network do not seem to be affected much. With storage,
the situation is a bit more variable, but the oscillations seem to be
more related to the benchmark variability than the CFI overhead.

I also run a quick check-acceptance on full system VMs with and without CFI,
the results are at [4] and show comparable results, with CFI slightly
outperforming the default binary produced by LLVM.

----

[1] Mehdi Talbi and Paul Fariello. VM escape - QEMU Case Study
[2] Nelson Elhage. Virtunoid: Breaking out of KVM
[3] Marco Grassi and Kira. Vulnerability Discovery and Exploitation
of Virtualization Solutions for Cloud Computing and Desktops
[4] https://github.com/dbuono/QEMU-CFI-Performance

*** BLURB HERE ***

Daniele Buono (6):
  fuzz: Make fork_fuzz.ld compatible with LLVM's LLD
  configure: avoid new clang 11+ warnings
  configure: add option to enable LTO
  cfi: Initial support for cfi-icall in QEMU
  check-block: enable iotests with cfi-icall
  configure: add support for Control-Flow Integrity

 MAINTAINERS                   |   5 +
 accel/tcg/cpu-exec.c          |   9 ++
 configure                     | 214 ++++++++++++++++++++++++++++++++++
 include/qemu/sanitizers.h     |  22 ++++
 meson.build                   |   3 +
 plugins/core.c                |  25 ++++
 plugins/loader.c              |   5 +
 tcg/tci.c                     |   5 +
 tests/check-block.sh          |  18 +--
 tests/qtest/fuzz/fork_fuzz.ld |  12 +-
 util/main-loop.c              |   9 ++
 util/oslib-posix.c            |   9 ++
 12 files changed, 328 insertions(+), 8 deletions(-)
 create mode 100644 include/qemu/sanitizers.h

-- 
2.17.1


