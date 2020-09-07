Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28467C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B782087D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bZTlj66V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B782087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFJVf-0006Kj-L1
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 11:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kFJV7-0005sp-87
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 11:56:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kFJV2-0002qo-8x
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 11:56:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 087Fs0fs058721;
 Mon, 7 Sep 2020 15:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=Bf+bkoH31Zm+QBFCbTi7T0GT23lPAQhvbkN6wRn4/z4=;
 b=bZTlj66VmRZ1FzBKVvYK/NVAWVzgszTNPuJLLK9ep1gxgV74VFbV96Rar01x9I7Nq6p6
 lRH0Xv/EISaQlY18ir0eLKMW5SB3NVRCgIVJWWghR5f3hc14ooCDlktCSC5sVW7mxjTr
 QXer6WT3Y29KnrxV1AhQKza/557nYyJk+/zEQ9zh+jGKe5wH6pFmWzwxGzGdOw+YPBF/
 Coq5MgkJvdyHxkeoiAjbDMH+/CfagOGwFPItdwnaG0Er62hTm9+A0M8aqENkh/Hm3V3K
 aBqykTkFwjP6IrnkHPM809D9gnxcGN8/gbGboLbybYP1V0MDRXZcjC4IjnyyaoekCcKM SA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 33c3amq6ta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 07 Sep 2020 15:56:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 087FtdZf097087;
 Mon, 7 Sep 2020 15:56:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 33dacgtacp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Sep 2020 15:56:02 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 087Fu1ta010176;
 Mon, 7 Sep 2020 15:56:01 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 07 Sep 2020 08:56:00 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id A484613EC8DE; Mon,  7 Sep 2020 16:55:58 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v2 02/15] fuzz: Add general virtual-device fuzzer
In-Reply-To: <20200907153932.pyzeiegsa3plzm37@mozz.bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
 <20200819061110.1320568-3-alxndr@bu.edu> <m2a6y8ts0n.fsf@oracle.com>
 <20200907153932.pyzeiegsa3plzm37@mozz.bu.edu>
Date: Mon, 07 Sep 2020 16:55:58 +0100
Message-ID: <m2sgbt4m41.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9737
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9737
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 priorityscore=1501
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070154
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=darren.kenny@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 11:56:05
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, f4bug@amsat.org, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Monday, 2020-09-07 at 11:39:32 -04, Alexander Bulekov wrote:
> On 200902 1103, Darren Kenny wrote:

...

>> > +
>> > +    while (ind >= 0 && fuzzable_memoryregions->len) {
>> > +        *result = (address_range){0, 0};
>> > +        mr = g_ptr_array_index(fuzzable_memoryregions, i);
>> > +        if (mr->enabled) {
>> > +            abs_addr = mr->addr;
>> > +            for (root = mr; root->container; ) {
>> > +                root = root->container;
>> > +                abs_addr += root->addr;
>> > +            }
>> > +            /*
>> > +             * Only consider the region if it is rooted at the io_space we want
>> > +             */
>> > +            if (root == io_space) {
>> > +                hwaddr xlat, len;
>> > +                if(address_space_translate(as, abs_addr, &xlat, &len, true, MEMTXATTRS_UNSPECIFIED) == mr){
>> > +                    ind--;
>> 
>> I'm wondering what is the purpose of ind, we never really do anything
>> with it except possibly decrement it here and test in the while
>> condition.
>> 
>> With candidate_regions also only being incremented here, we could just
>> as easily compare that against index.
>> 
>
> Yes it is not clear. The overall idea here is:
> * fuzzable_memoryregions contains regions that belong both to the
>   Memory/MMIO AddressSpace and the PIO AddressSpace. 
> * Thus fuzzable_mr can look like [PIO_1, MMIO_1, MMIO_2, PIO_2, PIO_3]
> * If index == 4 and we want an MMIO region, we need to use that as an
>   index into the sub-array of only MMIO-Type regions
>
> I think instead, I should either
> 1. Have separate arrays for PIO/MMIO MRs. This will simplify this
>    function, but I'm also not sure whether it is always possible to
>    identify whether the mr is pio/mmio (e.g. when a PCI BAR has not yet
>    been mapped)
> 2. Have a single read/write operation instead of in/out and read/write.
>    Then, instead of differentiating between MMIO and PIO here, we could
>    do that in the OP.
> 3. Instead of keeping track of MemoryRegions here, try instead to walk
>    the corresponding "flatview" and match the memory-region pointers.
>
> I'll try out (3) first. hopefully that will clear this up and make
> everything more legible. 

OK, thanks.

...

>> > +/*
>> > + * Here, we interpret random bytes from the fuzzer, as a sequence of commands.
>> > + * Our commands are variable-width, so we use a separator, SEPARATOR, to specify
>> > + * the boundaries between commands. This is just a random 32-bit value, which
>> > + * is easily identified by libfuzzer+AddressSanitizer, as long as we use
>> > + * memmem. It can also be included in the fuzzer's dictionary. More details
>> > + * here:
>> > + * https://github.com/google/fuzzing/blob/master/docs/split-inputs.md
>> > + *
>> > + * As a result, the stream of bytes is converted into a sequence of commands.
>> > + * In a simplified example where SEPARATOR is 0xFF:
>> > + * 00 01 02 FF 03 04 05 06 FF 01 FF ...
>> > + * becomes this sequence of commands:
>> > + * 00 01 02    -> op00 (0102)   -> in (0102, 2)
>> > + * 03 04 05 06 -> op03 (040506) -> write (040506, 3)
>> > + * 01          -> op01 (-,0)    -> out (-,0)
>> > + * ...
>> > + *
>> > + * Note here that it is the job of the individual opcode functions to check
>> > + * that enough data was provided. I.e. in the last command out (,0), out needs
>> > + * to check that there is not enough data provided to select an address/value
>> > + * for the operation.
>> > + */
>> 
>> Out if curiosity, do any of our corpus actually make use of the FUZZ string, or are we
>> just falling back to always using the full size of the provided input?
>> 
>
> Do you mean if there is some case where "FUZZ" needs to be used as a
> real value, rather than a magical separator?
>
> Or are asking whether the fuzzer actually generates inputs with the
> "FUZZ" separator?
> With ASan enabled, libfuzzer immediately figures out that "FUZZ" is an
> interesting string (because it instruments memmem) and starts inserting
> it all over the place. Without --enable-sanitizers, I add it to a fuzzer
> dictionary for the same effect (see bullet-point 1 in PATCH v2 00/15).

Should have responded to this, saw that you also used FUZZ later in the
patchset when I finally got there :)

Thanks,

Darren.

