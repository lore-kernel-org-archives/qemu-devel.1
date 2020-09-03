Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D23C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB22206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XFwvP2cY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB22206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDlRA-0004t4-3F
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 05:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDlQD-0003tk-4Q
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:20:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDlQB-00080J-4E
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:20:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0839FBAn044558;
 Thu, 3 Sep 2020 09:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=J3AjharIWio8HH3ZC4GWfZLdP0bg8iidapeVSomeYFs=;
 b=XFwvP2cYLwq/+b2+6mnWEtQxAHSBXzWg9hYZyG41SFdXUpLgw2b+0jipWCrYcIyZGUJy
 fJ5XErNN/womKxtoqbLBneswSRBz06kk5UBgDzsr4GQJIDcc/GFYwxZiHd+DS/Fp5dym
 +D1uNLz9cBWuIWMrH6hk62NkItvWyZsu3TzBGIPX4v2Y4VG9QxmJhCRgJ9v6QXZqNGtm
 vdeEO1ELwAx3P/XhzvGO7GcWmUoSzUmXNmceA+1reXOuELNvF+BY6016upvKoc659B3k
 grlb+oJzKKWaFAQaM3Q5JVAcpYepqgvjwBeqhD70bV107V/6h0DFogDTtZQPKih10oqw SQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 337eer7nyp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 03 Sep 2020 09:20:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0839AmOZ153756;
 Thu, 3 Sep 2020 09:20:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 3380x9cveb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Sep 2020 09:20:38 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0839KcrN002523;
 Thu, 3 Sep 2020 09:20:38 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 03 Sep 2020 02:20:37 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 337C1134FFB0; Thu,  3 Sep 2020 10:20:35 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 14/15] scripts/oss-fuzz: Add script to reorder a
 general-fuzzer trace
In-Reply-To: <20200819061110.1320568-15-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
 <20200819061110.1320568-15-alxndr@bu.edu>
Date: Thu, 03 Sep 2020 10:20:35 +0100
Message-ID: <m21rjjrzbw.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=2 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030085
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=darren.kenny@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:48:18
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

On Wednesday, 2020-08-19 at 02:11:09 -04, Alexander Bulekov wrote:
> The general-fuzzer uses hooks to fulfill DMA requests just-in-time.
> This means that if we try to use QTEST_LOG=1 to build a reproducer, the
> DMA writes will be logged _after_ the in/out/read/write that triggered
> the DMA read. To work work around this, the general-fuzzer annotates
> these just-in time DMA fulfilments with a tag that we can use to
> discern them. This script simply iterates over a raw qtest
> trace (including log messages, errors, timestamps etc), filters it and
> re-orders it so that DMA fulfillments are placed directly _before_ the
> qtest command that will cause the DMA access.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  .../oss-fuzz/reorder_fuzzer_qtest_trace.py    | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100755 scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
>
> diff --git a/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py b/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
> new file mode 100755
> index 0000000000..9fb7edb6ee
> --- /dev/null
> +++ b/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
> @@ -0,0 +1,94 @@
> +#!/usr/bin/env python3
> +# -*- coding: utf-8 -*-
> +
> +"""
> +Use this to convert qtest log info from a generic fuzzer input into a qtest
> +trace that you can feed into a standard qemu-system process. Example usage:
> +
> +QEMU_FUZZ_ARGS="-machine q35,accel=qtest" QEMU_FUZZ_OBJECTS="*" \
> +        ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=general-pci-fuzz
> +# .. Finds some crash
> +QTEST_LOG=1 FUZZ_SERIALIZE_QTEST=1 \
> +QEMU_FUZZ_ARGS="-machine q35,accel=qtest" QEMU_FUZZ_OBJECTS="*" \
> +        ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=general-pci-fuzz
> +        /path/to/crash 2> qtest_log_output
> +scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py qtest_log_output > qtest_trace
> +./i386-softmmu/qemu-fuzz-i386 -machine q35,accel=qtest \
> +        -qtest stdin < qtest_trace
> +
> +### Details ###
> +
> +Some fuzzer make use of hooks that allow us to populate some memory range, just
> +before a DMA read from that range. This means that the fuzzer can produce
> +activity that looks like:
> +    [start] read from mmio addr
> +    [end]   read from mmio addr
> +    [start] write to pio addr
> +        [start] fill a DMA buffer just in time
> +        [end]   fill a DMA buffer just in time
> +        [start] fill a DMA buffer just in time
> +        [end]   fill a DMA buffer just in time
> +    [end]   write to pio addr
> +    [start] read from mmio addr
> +    [end]   read from mmio addr
> +
> +We annotate these "nested" DMA writes, so with QTEST_LOG=1 the QTest trace
> +might look something like:
> +[R +0.028431] readw 0x10000
> +[R +0.028434] outl 0xc000 0xbeef  # Triggers a DMA read from 0xbeef and 0xbf00
> +[DMA][R +0.034639] write 0xbeef 0x2 0xAAAA
> +[DMA][R +0.034639] write 0xbf00 0x2 0xBBBB
> +[R +0.028431] readw 0xfc000
> +
> +This script would reorder the above trace so it becomes:
> +readw 0x10000
> +write 0xbeef 0x2 0xAAAA
> +write 0xbf00 0x2 0xBBBB
> +outl 0xc000 0xbeef
> +readw 0xfc000
> +
> +I.e. by the time, 0xc000 tries to read from DMA, those DMA buffers have already
> +been set up, removing the need for the DMA hooks. We can simply provide this
> +reordered trace via -qtest stdio to reproduce the input
> +
> +Note: this won't work for traces where the device tries to read from the same
> +DMA region twice in between MMIO/PIO commands. E.g:
> +    [R +0.028434] outl 0xc000 0xbeef
> +    [DMA][R +0.034639] write 0xbeef 0x2 0xAAAA
> +    [DMA][R +0.034639] write 0xbeef 0x2 0xBBBB
> +"""
> +
> +import sys
> +
> +__author__     = "Alexander Bulekov <alxndr@bu.edu>"
> +__copyright__  = "Copyright (C) 2020, Red Hat, Inc."
> +__license__    = "GPL version 2 or (at your option) any later version"
> +
> +__maintainer__ = "Alexander Bulekov"
> +__email__      = "alxndr@bu.edu"
> +
> +
> +def usage():
> +    sys.exit("Usage: {} /path/to/qtest_log_output".format((sys.argv[0])))
> +
> +
> +def main(filename):
> +    with open(filename, "r") as f:
> +        trace = f.readlines()
> +
> +    # Leave only lines that look like logged qtest commands
> +    trace[:] = [x.strip() for x in trace if "[R +" in x
> +                or "[S +" in x and "CLOSED" not in x]
> +
> +    for i in range(len(trace)):
> +        if i+1 < len(trace):
> +            if "[DMA]" in trace[i+1]:
> +                trace[i], trace[i+1] = trace[i+1], trace[i]
> +    for line in trace:
> +        print(line.split("]")[-1].strip())
> +
> +
> +if __name__ == '__main__':
> +    if len(sys.argv) == 1:
> +        usage()
> +    main(sys.argv[1])
> -- 
> 2.27.0

