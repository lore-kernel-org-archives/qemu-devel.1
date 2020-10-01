Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB4CC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B46D20759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UpRjnl0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B46D20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO18P-0007Ec-7c
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kO0lA-00074f-8E
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:44:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kO0l5-0004WF-Lj
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:44:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091Fde3h070740;
 Thu, 1 Oct 2020 15:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=zKiUacOBhjrZx41UJn7rlfAWGBkrrgBjE0ynnyqD5/g=;
 b=UpRjnl0/OVZSpjrsbtA9cUA/jMtCELQMfp1vz17H12xYh1VN9xcNdPwoLagxhOLS4esp
 uU7WIr8EnT4BClcBlDAhmbKKcRzqzU31qhT5kRJNHII1UlxUPOJifr2PoxGjwQQrprYi
 kz2npT9+5Td76ZSzM5Ass+5/V++tkoLmXerTrhrhCdE1L5l/DsmN0BukDVnMhfKHVk89
 mQJ1F0vihF80ADS2r6L3j90rH3DycfamMLXJdtzLGae+aC+wP1esgrbilQaHvnJqYyAK
 OaAasNcNY2xDxrs6JV1zBoORdOSo8xFYEWug3kWJu5gIHWQ1uyGsVikyAliVZZ3Hk8Sk SA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 33swkm6scc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 01 Oct 2020 15:44:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091Fdqi3057400;
 Thu, 1 Oct 2020 15:44:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 33tfk1rwr4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 01 Oct 2020 15:44:34 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 091FiXF4013561;
 Thu, 1 Oct 2020 15:44:33 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 01 Oct 2020 08:44:33 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id B811D18EE754; Thu,  1 Oct 2020 16:44:29 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 16/16] fuzz: Add instructions for using general-fuzz
In-Reply-To: <20200921022506.873303-17-alxndr@bu.edu>
References: <20200921022506.873303-1-alxndr@bu.edu>
 <20200921022506.873303-17-alxndr@bu.edu>
Date: Thu, 01 Oct 2020 16:44:29 +0100
Message-ID: <m28scq6jdu.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0
 suspectscore=1 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010133
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=darren.kenny@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 11:44:38
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
Cc: Thomas Huth <thuth@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 bsd@redhat.com, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sunday, 2020-09-20 at 22:25:06 -04, Alexander Bulekov wrote:
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  docs/devel/fuzzing.txt | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
> index 96d71c94d7..208b0c8360 100644
> --- a/docs/devel/fuzzing.txt
> +++ b/docs/devel/fuzzing.txt
> @@ -125,6 +125,44 @@ provided by libfuzzer. Libfuzzer passes a byte array and length. Commonly the
>  fuzzer loops over the byte-array interpreting it as a list of qtest commands,
>  addresses, or values.
>  
> +== The General Fuzzer ==
> +Writing a fuzz target can be a lot of effort (especially if a device driver has
> +not be built-out within libqos). Many devices can be fuzzed to some degree,
> +without any device-specific code, using the general-fuzz target.
> +
> +The general-fuzz target is capable of fuzzing devices over their PIO, MMIO,
> +and DMA input-spaces. To apply the general-fuzz to a device, we need to define
> +two env-variables, at minimum:
> +
> +QEMU_FUZZ_ARGS= is the set of QEMU arguments used to configure a machine, with
> +the device attached. For example, if we want to fuzz the virtio-net device
> +attached to a pc-i440fx machine, we can specify:
> +QEMU_FUZZ_ARGS="-M pc -nodefaults -netdev user,id=user0 \
> +                -device virtio-net,netdev=user0"
> +
> +QEMU_FUZZ_OBJECTS= is a set of space-delimited strings used to identify the
> +MemoryRegions that will be fuzzed. These strings are compared against
> +MemoryRegion names and MemoryRegion owner names, to decide whether each
> +MemoryRegion should be fuzzed. These strings support globbing. For the
> +virtio-net example, we could use
> +QEMU_FUZZ_OBJECTS='virtio-net'
> +QEMU_FUZZ_OBJECTS='virtio*'
> +QEMU_FUZZ_OBJECTS='virtio* pcspk' # Fuzz the virtio-net device and the PC speaker...
> +QEMU_FUZZ_OBJECTS='*' # Fuzz the whole machine
> +

Maybe format these as lists, where each list item is the variable?

> +The "info mtree" and "info qom-tree" monitor commands can be especially useful
> +for identifying the MemoryRegion and Object names used for matching.
> +
> +As a general rule-of-thumb, the more MemoryRegions/Devices we match, the greater
> +the input-space, and the smaller the probability of finding crashing inputs for
> +individual devices. As such, it is usually a good idea to limit the fuzzer to
> +only a few MemoryRegions.
> +
> +To ensure that these env variables have been configured correctly, we can use:

Add a blank line here?

> +./qemu-fuzz-i386 --fuzz-target=general-fuzz -runs=0
> +
> +The output should contain a complete list of matched MemoryRegions.
> +
>  = Implementation Details =
>  
>  == The Fuzzer's Lifecycle ==


Not this patch, but this text file is partially written in Restructured
Text format, but not completely. Should it be converted to RsT format
properly - doesn't have to be now, but something we could consider.

Otherwise, it looks find to me, so:

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

