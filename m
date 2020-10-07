Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6334AC4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9436F2076C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l8zLv32X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9436F2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ9wD-0005pS-ER
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 09:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kQ9vG-00054v-UA
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 09:56:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kQ9vE-0008Km-Si
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 09:56:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097DtR8F018393;
 Wed, 7 Oct 2020 13:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=3XBJTDlQAFCCoPHlsA4iQFPizwx3C6TOvt0o4KNaYdc=;
 b=l8zLv32XdnEi4gOuGAJXtADkhWmxmApbrlAwpW08yBsf9zkZAHpRUXE2eJPllTrIZhUC
 Yj4RQj8V12ajY2bxh2Sp/23puBG1eQm4bssnXHieesS1+WiOfEipeW73yvfGp03gp4LO
 xWkfkbUxO8efWtN8Ul0DYDFM7uEQwsPpkCtLLZltk92dKgNwfe0KnWaufGjoK7ImUflW
 4tXGo3/xgi5Eyr9Y9pa2aVvr4se6IPe3hkbj3p80HKcfvuzQ9DBf/b7jcD360WbAloBd
 4LI0PbV6KYKlKU4NEGTYNzEldrahB4EWlSsJJCZFsS5Xu/qRfeDA3AfWhcpKIkz1KdjB Dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 33xhxn1tdg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 07 Oct 2020 13:55:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097DZ6CH144869;
 Wed, 7 Oct 2020 13:53:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 3410jynt71-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Oct 2020 13:53:55 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 097DrqRW005832;
 Wed, 7 Oct 2020 13:53:52 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 07 Oct 2020 06:53:52 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 128251ACBA00; Wed,  7 Oct 2020 14:53:41 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v3 02/16] fuzz: Add general virtual-device fuzzer
In-Reply-To: <20201007133932.ua6tg7hnr3ixpgni@mozz.bu.edu>
References: <20200921022506.873303-1-alxndr@bu.edu>
 <20200921022506.873303-3-alxndr@bu.edu>
 <63ca7622-557b-4217-f15e-ee9b024fbd77@redhat.com>
 <20200921143405.3taiymgzwvscxsry@mozz.bu.edu> <m2h7re6k3b.fsf@oracle.com>
 <20201007133932.ua6tg7hnr3ixpgni@mozz.bu.edu>
Date: Wed, 07 Oct 2020 14:53:40 +0100
Message-ID: <m27ds2dtwb.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=1 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=1 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070090
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=darren.kenny@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 09:55:57
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-10-07 at 09:39:32 -04, Alexander Bulekov wrote:
> On 201001 1629, Darren Kenny wrote:

...

>>
>> It might make sense to put the definition of SEPARATOR and some variant
>> of the above the comments in patch 9 where you're adding this related
>> functionality?
>> 
>> It seems a little out of place here.
>> 
>> Thanks,
>> 
>> Darren.
>> 
>
> Hi Darren,
> If I move the definition of SEPARATOR to Patch 9, I would need some
> different way to parse commands here, to keep everything bisectable. I
> don't think the separator is only important in the context of the
> Crossover functionality (Patch 9) - it is useful in general as a
> "stable" way to parse an input into multiple commands.
> Is it OK if I keep SEPARATOR in this patch and add the comments you
> mention to both this patch and patch 9?

Sounds fine, it was just a suggestion since I hadn't seen it being used
in this file, but maybe I missed something.

Thanks,

Darren.

> Thanks
> -Alex
>
>> >> 
>> >> Can you fuzz writing "FUZZ" in memory? Like:
>> >> OP_WRITE(0x100000, "UsingLibFUZZerString")?
>> >
>> > No.. Hopefully that's not a huge problem.
>> >
>> >> > +
>> >> > +enum cmds {
>> >> > +    OP_IN,
>> >> > +    OP_OUT,
>> >> > +    OP_READ,
>> >> > +    OP_WRITE,
>> >> > +    OP_CLOCK_STEP,
>> >> > +};
>> >> > +
>> >> > +#define DEFAULT_TIMEOUT_US 100000
>> >> > +#define USEC_IN_SEC 100000000
>> >> 
>> >> Are you sure this definition is correct?
>> >> 
>> > Thanks for the catch...
>> >
>> >> > +
>> >> > +typedef struct {
>> >> > +    ram_addr_t addr;
>> >> > +    ram_addr_t size; /* The number of bytes until the end of the I/O region */
>> >> > +} address_range;
>> >> > +
>> >> > +static useconds_t timeout = 100000;
>> >> [...]
>> >> 

