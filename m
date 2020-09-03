Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AB8C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:11:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030B02071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="csPGGrpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030B02071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDlHV-0004Pv-1f
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 05:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDlFW-0001X4-Nn
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:09:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kDlFV-0006Pc-0L
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:09:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08394wZh024236;
 Thu, 3 Sep 2020 09:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=MK1CHBDqf5eIHDKiCfJipkaD4EzfBdAhHLFJnuQWX/w=;
 b=csPGGrprmCNlw5GQl5HMmLSx6fcGson8P4DZt+EmAvAqF8v8K9cakjlm8wRl9omoXpjX
 A+ezPwtGQlseuoELw2+1IoJxZT7wQqaxg7gXTYfT5ncG4ou2NN9FRt0vFzs9p1bAbMQJ
 eusqsR4j+89EaQ/4Fub96k3XIJjks49dPJ8H40ESQ6zaoTgKP/CRn0VvUrSS/1CdF+d4
 21u7mYoFfZ45EWqHEXQ5FfXbfb6jKDVpztENPstj7KkRrjujKGVMyfw0nUAgutwOY5KK
 JoS5yEqRZG+yD7DeHhPtQkE/w1CM9bJBbgYey5hTC5w2XzhadC8T0iGsAyRq15aSKMXP yA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 337eer7mbk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 03 Sep 2020 09:09:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08395lQg016922;
 Thu, 3 Sep 2020 09:07:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 3380y1hbry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Sep 2020 09:07:36 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08397ZqO003926;
 Thu, 3 Sep 2020 09:07:36 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 03 Sep 2020 02:07:35 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id E36A4134F9C6; Thu,  3 Sep 2020 10:07:32 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 10/15] scripts/oss-fuzz: Add wrapper program for
 generic fuzzer
In-Reply-To: <20200819061110.1320568-11-alxndr@bu.edu>
References: <20200819061110.1320568-1-alxndr@bu.edu>
 <20200819061110.1320568-11-alxndr@bu.edu>
Date: Thu, 03 Sep 2020 10:07:32 +0100
Message-ID: <m2h7sfrzxn.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030084
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

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

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

