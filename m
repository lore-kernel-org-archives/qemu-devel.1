Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B34C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF999206C1
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jeGnboac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF999206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0kT-0005yD-Qn
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kO0WL-0006sD-6X
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:29:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kO0WI-0001mo-4h
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:29:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091FJA7L003665;
 Thu, 1 Oct 2020 15:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=S0VVepJldlhplNlO5roQ4HUuf861U5hrJiC2ntMjPxk=;
 b=jeGnboacDKtFFwLbXQUE62L5+kqmtl+WFokXM21XSdEimhgXSpbNfxKBVxCT9QNaoj3C
 HqvsFEEApBSncWUgbDjkKK5FjN+JhjDsNm1XtVFicim1MyddsfNg7vTD1/lSTDkKSyNP
 3T1u+toaV6sr484sfbQ2GZqqjWwuV6WipUMDWtwdCnjcVy4FfviCCORjo6nXNLPg0FZV
 s+FOlFDSaM423kcUwzgs0PZXzY496lUrmVCgCMs4G3kTwpnbIaz8R2IfcIYkxEiIRnzC
 mQzSWhxm/nl79uVDne54qNkx0s1NkAq1UhnXa77HnBQPhIJTz5aMAyA65aIGQHOi0pCu 3w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 33sx9nen5r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 01 Oct 2020 15:29:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091FL0M1093264;
 Thu, 1 Oct 2020 15:29:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 33uv2h336y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 01 Oct 2020 15:29:17 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 091FTGm6012036;
 Thu, 1 Oct 2020 15:29:16 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 01 Oct 2020 08:29:16 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 958A818EE03C; Thu,  1 Oct 2020 16:29:12 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 02/16] fuzz: Add general virtual-device fuzzer
In-Reply-To: <20200921143405.3taiymgzwvscxsry@mozz.bu.edu>
References: <20200921022506.873303-1-alxndr@bu.edu>
 <20200921022506.873303-3-alxndr@bu.edu>
 <63ca7622-557b-4217-f15e-ee9b024fbd77@redhat.com>
 <20200921143405.3taiymgzwvscxsry@mozz.bu.edu>
Date: Thu, 01 Oct 2020 16:29:12 +0100
Message-ID: <m2h7re6k3b.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010132
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=darren.kenny@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 11:29:20
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On Monday, 2020-09-21 at 10:34:05 -04, Alexander Bulekov wrote:
> On 200921 0743, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Alexander,
>>=20
>> On 9/21/20 4:24 AM, Alexander Bulekov wrote:
>> > This is a generic fuzzer designed to fuzz a virtual device's
>> > MemoryRegions, as long as they exist within the Memory or Port IO (if =
it
>> > exists) AddressSpaces. The fuzzer's input is interpreted into a sequen=
ce
>> > of qtest commands (outb, readw, etc). The interpreted commands are
>> > separated by a magic seaparator, which should be easy for the fuzzer to
>> > guess. Without ASan, the separator can be specified as a "dictionary
>> > value" using the -dict argument (see libFuzzer documentation).
>> >=20
>> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>> > ---
>> >  tests/qtest/fuzz/general_fuzz.c | 498 ++++++++++++++++++++++++++++++++
>> >  tests/qtest/fuzz/meson.build    |   1 +
>> >  2 files changed, 499 insertions(+)
>> >  create mode 100644 tests/qtest/fuzz/general_fuzz.c
>> >=20
>> > diff --git a/tests/qtest/fuzz/general_fuzz.c b/tests/qtest/fuzz/genera=
l_fuzz.c
>> > new file mode 100644
>> > index 0000000000..bf75b215ca
>> > --- /dev/null
>> > +++ b/tests/qtest/fuzz/general_fuzz.c
>> > @@ -0,0 +1,498 @@
>> > +/*
>> > + * General Virtual-Device Fuzzing Target
>> > + *
>> > + * Copyright Red Hat Inc., 2020
>> > + *
>> > + * Authors:
>> > + *  Alexander Bulekov   <alxndr@bu.edu>
>> > + *
>> > + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.
>> > + * See the COPYING file in the top-level directory.
>> > + */
>> > +
>> > +#include "qemu/osdep.h"
>> > +
>> > +#include <wordexp.h>
>> > +
>> > +#include "hw/core/cpu.h"
>> > +#include "tests/qtest/libqos/libqtest.h"
>> > +#include "fuzz.h"
>> > +#include "fork_fuzz.h"
>> > +#include "exec/address-spaces.h"
>> > +#include "string.h"
>> > +#include "exec/memory.h"
>> > +#include "exec/ramblock.h"
>> > +#include "exec/address-spaces.h"
>> > +#include "hw/qdev-core.h"
>> > +
>> > +/*
>> > + * SEPARATOR is used to separate "operations" in the fuzz input
>> > + */
>> > +#define SEPARATOR "FUZZ"
>>=20
>> Why use a separator when all pkt sizes are known?
> Good point.=20
> 1. When we add the DMA Pattern OP in patch 04/16, we now have
> variable-width OPs.
> 2. Even when everything has a known size, take for example the input:
> Acb Bd Caaaa Effff
> Where Operation A has size 3, B: size 2, C size 5 ...:
> Simply by removing the first byte, we now have a completely different
> sequence of operations:
> Cbbdc Aaa Aef Ff...
> Thus the separators "add some stability" to random mutations:
> Cb FUZZ Bd FUZZ Caaaa FUZZ Effff ...
> (Cb is now invalid/ignored, but the rest of the commands are still
> intact)
> There is some libfuzzer documentation about this technique:
> https://github.com/google/fuzzing/blob/master/docs/split-inputs.md#magic-=
separator
>
> There is also a promising "FuzzDataProvider" header library that lets
> you directly call functions, such as ConsumeBytes, or
> ConsumeIntegralInRange, but unfortunately it is a C++ header.

It might make sense to put the definition of SEPARATOR and some variant
of the above the comments in patch 9 where you're adding this related
functionality?

It seems a little out of place here.

Thanks,

Darren.

>>=20
>> Can you fuzz writing "FUZZ" in memory? Like:
>> OP_WRITE(0x100000, "UsingLibFUZZerString")?
>
> No.. Hopefully that's not a huge problem.
>
>> > +
>> > +enum cmds {
>> > +    OP_IN,
>> > +    OP_OUT,
>> > +    OP_READ,
>> > +    OP_WRITE,
>> > +    OP_CLOCK_STEP,
>> > +};
>> > +
>> > +#define DEFAULT_TIMEOUT_US 100000
>> > +#define USEC_IN_SEC 100000000
>>=20
>> Are you sure this definition is correct?
>>=20
> Thanks for the catch...
>
>> > +
>> > +typedef struct {
>> > +    ram_addr_t addr;
>> > +    ram_addr_t size; /* The number of bytes until the end of the I/O =
region */
>> > +} address_range;
>> > +
>> > +static useconds_t timeout =3D 100000;
>> [...]
>>=20

