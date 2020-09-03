Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4D0C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:12:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688A420709
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cuRIZuPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688A420709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDlIM-0005LM-FA
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 05:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDlGY-0003Cg-M3
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:10:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDlGW-0006jX-7k
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:10:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08393etE136483;
 Thu, 3 Sep 2020 09:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=/xDjZTKcnQdtCMZYCy9844ZgSRqm3zPjXnju1oTDeLY=;
 b=cuRIZuPIM4cZNOk4KxPqxf+vXdG5RedlXSNsUpuMNdjo7KqXSqPGO2sehW43aqgwEMaQ
 N8mROlIaowctvWycF/3zxYsXDQz2+wbbmBto4d1+y+S6hffww9JaQjQqPnWZYbti67y0
 J6uyA6ApQ0DNFCEg9hQfUlgXfTAIEHNHwMULMmX8yrGWb1LCBmqWXdRrXgJdOBEKsA7P
 qz3nT5bztC7vf1tzolo7JIZP7lbjTRWDhgcFfuXaQkVZIbpTz1D/xFmu9rpX9e/4FK8G
 ibylRITB7FbJRuA71LcbTWc6BAU60j9WnK3Q3Q7SXYKdVWOtO+35O5MAHswfotfypJGh Vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 339dmn619v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 03 Sep 2020 09:10:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08395GF5174252;
 Thu, 3 Sep 2020 09:10:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 3380kre9n0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Sep 2020 09:10:40 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0839Ac7M028308;
 Thu, 3 Sep 2020 09:10:38 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 03 Sep 2020 02:10:38 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id CAC59134FAC3; Thu,  3 Sep 2020 10:10:35 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 10/15] scripts/oss-fuzz: Add wrapper program for
 generic fuzzer
In-Reply-To: <20200819061110.1320568-11-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
 <20200819061110.1320568-11-alxndr@bu.edu>
Date: Thu, 03 Sep 2020 10:10:35 +0100
Message-ID: <m2eenjrzsk.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=1 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=1
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030084
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=darren.kenny@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:43:20
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

Just thinking after reading later code, that maybe this should be
renamed to something like target.c.tmpl, target_template.c, or similar
so that it is clearer that this is not used directly, but as a template
for generation of other targets.

Thanks,

Darren.


On Wednesday, 2020-08-19 at 02:11:05 -04, Alexander Bulekov wrote:
> On oss-fuzz we need some sort of wrapper to specify command-line
> arguments or environment variables. When we had a similar problem with
> other targets that I fixed with
> 05509c8e6d ("fuzz: select fuzz target using executable name")
> by selecting the fuzz target based on the executable's name. In the
> future should probably commit to one approach (wrapper binary or
> argv0-based target selection).
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  scripts/oss-fuzz/target.c | 40 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 scripts/oss-fuzz/target.c
>
> diff --git a/scripts/oss-fuzz/target.c b/scripts/oss-fuzz/target.c
> new file mode 100644
> index 0000000000..4a7257412a
> --- /dev/null
> +++ b/scripts/oss-fuzz/target.c
> @@ -0,0 +1,40 @@
> +/*
> + * Copyright Red Hat Inc., 2020
> + *
> + * Authors:
> + *  Alexander Bulekov   <alxndr@bu.edu>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <limits.h>
> +#include <libgen.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +
> +/* Required for oss-fuzz to consider the binary a target. */
> +static const char *magic __attribute__((used)) = "LLVMFuzzerTestOneInput";
> +static const char args[] = {QEMU_FUZZ_ARGS, 0x00};
> +static const char objects[] = {QEMU_FUZZ_OBJECTS, 0x00};
> +
> +int main(int argc, char *argv[])
> +{
> +    char path[PATH_MAX] = {0};
> +    char *dir = dirname(argv[0]);
> +    strncpy(path, dir, PATH_MAX);
> +    strcat(path, "/deps/qemu-fuzz-i386-target-general-fuzz");
> +
> +    setenv("QEMU_FUZZ_ARGS", args, 0);
> +    setenv("QEMU_FUZZ_OBJECTS", objects, 0);
> +
> +    argv[0] = path;
> +    int ret = execvp(path, argv);
> +    if (ret) {
> +        perror("execv");
> +    }
> +    return ret;
> +}
> -- 
> 2.27.0

