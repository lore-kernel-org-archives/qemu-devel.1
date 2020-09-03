Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF659C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898C1206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PhrNJNI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898C1206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDlYX-0006ix-LU
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 05:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDlXy-0006Id-De
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:28:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDlXs-0000Kn-KG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:28:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0839OOh2135360;
 Thu, 3 Sep 2020 09:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=Pfmp9WOY1Dw3f9z7FXh5Vy+/ZjrVDnNaoTKC13v5PHI=;
 b=PhrNJNI7nZbNCsBdS6QbW2UTvBzS/Jif7AOt7mzGL8Jj1AEq6E+mDOU6OTTvxHhU7ZWO
 J0ivuusTOiwg6jhZbflbQCMEHN6+oUHH49T96iiGTeB4MF5DCHwgoggZe056cVgVjqM7
 qoHAVldTn6sWdTuGFqbbRoAty4CnLICroc1izyG34CwPQ31MhApad4kI2f0mL1igIqBT
 8lhevGzY8GXQqkgADwCOd0zf1chjNuVjGrpPVtq2YSmDjVtWQdy8mpu55Qvl6DsDmJ7r
 /E/gem1tR/ZkfJHhQQtrPsGqSmMlHTMva8tBcziJURGaJKqd9/zDuDGY7eoByjmbKsZh Hw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 337eymfkxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 03 Sep 2020 09:28:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0839PWcc043652;
 Thu, 3 Sep 2020 09:28:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 3380krf619-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Sep 2020 09:28:35 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0839SXfe003300;
 Thu, 3 Sep 2020 09:28:33 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 03 Sep 2020 02:28:33 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 0E02513502D6; Thu,  3 Sep 2020 10:28:30 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 15/15] scripts/oss-fuzz: Add crash trace minimization
 script
In-Reply-To: <20200819061110.1320568-16-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
 <20200819061110.1320568-16-alxndr@bu.edu>
Date: Thu, 03 Sep 2020 10:28:29 +0100
Message-ID: <m2y2lrqkea.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=2 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030086
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=darren.kenny@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:47:13
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, f4bug@amsat.org,
 Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-08-19 at 02:11:10 -04, Alexander Bulekov wrote:
> Once we find a crash, we can convert it into a QTest trace. Usually this
> trace will contain many operations that are unneeded to reproduce the
> crash. This script tries to minimize the crashing trace, by removing
> operations and trimming QTest bufwrite(write addr len data...) commands.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  scripts/oss-fuzz/minimize_qtest_trace.py | 118 +++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100755 scripts/oss-fuzz/minimize_qtest_trace.py
>
> diff --git a/scripts/oss-fuzz/minimize_qtest_trace.py b/scripts/oss-fuzz/minimize_qtest_trace.py
> new file mode 100755
> index 0000000000..2f1f4f368e
> --- /dev/null
> +++ b/scripts/oss-fuzz/minimize_qtest_trace.py
> @@ -0,0 +1,118 @@
> +#!/usr/bin/env python3
> +# -*- coding: utf-8 -*-
> +
> +"""
> +This takes a crashing qtest trace and tries to remove superflous operations
> +"""
> +
> +import sys
> +import os
> +import subprocess
> +import time
> +
> +QEMU_ARGS = None
> +QEMU_PATH = None
> +TIMEOUT = 5
> +CRASH_TOKEN = None
> +
> +
> +def usage():
> +    sys.exit("""\
> +Usage: QEMU_PATH="/path/to/qemu" QEMU_ARGS="args" {} input_trace output_trace
> +By default, will try to use the second-to-last line in the output to identify
> +whether the crash occred. Optionally, manually set a string that idenitifes the
> +crash by setting CRASH_TOKEN=
> +""".format((sys.argv[0])))
> +
> +
> +def check_if_trace_crashes(trace, path):
> +    global CRASH_TOKEN
> +    with open(path, "w") as tracefile:
> +        tracefile.write("".join(trace))
> +    rc = subprocess.Popen("timeout -s 9 {}s {} {} 2>&1 < {}".format(TIMEOUT,
> +                          QEMU_PATH, QEMU_ARGS, path),
> +                          shell=True, stdin=subprocess.PIPE,
> +                          stdout=subprocess.PIPE)

NIT: Similar comment to before, it is nicer to name the placeholders if
     there are more than 1 and you can.

> +    stdo = rc.communicate()[0]
> +    output = stdo.decode('unicode_escape')
> +    if rc.returncode == 137:    # Timed Out
> +        return False
> +    if len(output.splitlines()) < 2:
> +        return False
> +
> +    if CRASH_TOKEN is None:
> +        CRASH_TOKEN = output.splitlines()[-2]
> +
> +    return CRASH_TOKEN in output
> +
> +
> +def minimize_trace(inpath, outpath):
> +    global TIMEOUT
> +    with open(inpath) as f:
> +        trace = f.readlines()
> +    start = time.time()
> +    if not check_if_trace_crashes(trace, outpath):
> +        sys.exit("The input qtest trace didn't cause a crash...")
> +    end = time.time()
> +    print("Crashed in {} seconds".format(end-start))
> +    TIMEOUT = (end-start)*5
> +    print("Setting the timeout for {} seconds".format(TIMEOUT))
> +    print("Identifying Crashes by this string: {}".format(CRASH_TOKEN))
> +
> +    i = 0
> +    newtrace = trace[:]
> +    while i < len(newtrace):
> +        prior = newtrace[i]
> +        print("Trying to remove {}".format(newtrace[i]))
> +        # Try to remove the line completely
> +        newtrace[i] = ""
> +        if check_if_trace_crashes(newtrace, outpath):
> +            i += 1
> +            continue
> +        newtrace[i] = prior
> +        # Try to split up writes into multiple commands, each of which can be
> +        # removed.
> +        if newtrace[i].startswith("write "):

NIT: Would be good to document the assumptions here, just in case things
     change in future.

> +            addr = int(newtrace[i].split()[1], 16)
> +            length = int(newtrace[i].split()[2], 16)
> +            data = newtrace[i].split()[3][2:]
> +            if length > 1:
> +                leftlength = int(length/2)
> +                rightlength = length - leftlength
> +                newtrace.insert(i+1, "")
> +                while leftlength > 0:
> +                    newtrace[i] = "write {} {} 0x{}\n".format(
> +                            hex(addr),
> +                            hex(leftlength),
> +                            data[:leftlength*2])
> +                    newtrace[i+1] = "write {} {} 0x{}\n".format(
> +                            hex(addr+leftlength),
> +                            hex(rightlength),
> +                            data[leftlength*2:])

NIT: Similar comment w.r.t. naming the placeholders.

> +                    if check_if_trace_crashes(newtrace, outpath):
> +                        break
> +                    else:
> +                        leftlength -= 1
> +                        rightlength += 1
> +                if check_if_trace_crashes(newtrace, outpath):
> +                    i -= 1
> +                else:
> +                    newtrace[i] = prior
> +                    del newtrace[i+1]
> +        i += 1
> +    check_if_trace_crashes(newtrace, outpath)
> +
> +
> +if __name__ == '__main__':
> +    if len(sys.argv) < 3:
> +        usage()
> +
> +    QEMU_PATH = os.getenv("QEMU_PATH")
> +    QEMU_ARGS = os.getenv("QEMU_ARGS")
> +    if QEMU_PATH is None or QEMU_ARGS is None:
> +        usage()
> +    if "accel" not in QEMU_ARGS:
> +        QEMU_ARGS += " -accel qtest"
> +    CRASH_TOKEN = os.getenv("CRASH_TOKEN")
> +    QEMU_ARGS += " -qtest stdio -monitor none -serial none "
> +    minimize_trace(sys.argv[1], sys.argv[2])

Since all only nits:

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

