Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743B9C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AF620836
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 14:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aYirE5D6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AF620836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUWaJ-00032A-Cp
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 10:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1jUWYD-0008AH-A7
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1jUWVS-0002Xr-6T
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:22:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jUWVR-0002Si-Ki
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:19:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 041EHXl8052381;
 Fri, 1 May 2020 14:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=5fspIhxJk4UBKcDtiq+dUHbwCzY+KAqu5UmvtAdDiCw=;
 b=aYirE5D6jEBg9Pdos/LwEP85ytA0uGfQYmYzMn955/QTdjgUC8G3bZ7SIfdzQQa4iO6s
 kusWymV46RxRI2Lj8jvGWcqPbyHNvi0IsQYehd2gmovrbiKYhoVrZXErhioufjJfOBRS
 27U0LHTyI3IDBWKKXZnw56f3yYqMIi9M8EQdh0Z2wfOxd+opNKIQMpRS2ZV0cn1FQbIG
 EZAgfcWgJ+qQgjUG86g2LCgM1pIK4RgDziN9+T/ECET4LfOM75kCla20xN2CmQ136N7F
 lLQec25Y8gApPWIDyK/ZhSfEAoK+6PuDEkP4r3fTUeM4pNShaNgn9+LapyL8kBqmWZzD ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 30r7f5te5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 May 2020 14:19:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 041EIXxE096077;
 Fri, 1 May 2020 14:19:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 30r7f422e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 May 2020 14:19:02 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 041EIxZ7019292;
 Fri, 1 May 2020 14:18:59 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 01 May 2020 07:18:58 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id E241B67A70F8; Fri,  1 May 2020 15:18:55 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] fuzz: select fuzz target using executable name
In-Reply-To: <20200501135612.32249-1-alxndr@bu.edu>
References: <20200501135612.32249-1-alxndr@bu.edu>
Date: Fri, 01 May 2020 15:18:55 +0100
Message-ID: <m28sib91rk.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9607
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 phishscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9607
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 clxscore=1011 phishscore=0 impostorscore=0 suspectscore=1 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005010114
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=darren.kenny@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 10:19:05
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: Laurent Vivier <lvivier@redhat.com>, peter.maydell@linaro.org,
 Thomas Huth <thuth@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Friday, 2020-05-01 at 09:56:12 -04, Alexander Bulekov wrote:
> The fuzzers are built into a binary (e.g. qemu-fuzz-i386). To select the
> device to fuzz/fuzz target, we usually use the --fuzz-target= argument.
> This commit allows the fuzz-target to be specified using the name of the
> executable. If the executable name ends with -target-FUZZ_TARGET, then
> we select the fuzz target based on this name, rather than the
> --fuzz-target argument. This is useful for systems such as oss-fuzz
> where we don't have control of the arguments passed to the fuzzer.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  tests/qtest/fuzz/fuzz.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> This patch should be free of any changes to the slirp submodule.
>
> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> index 0d78ac8d36..c6932cec4a 100644
> --- a/tests/qtest/fuzz/fuzz.c
> +++ b/tests/qtest/fuzz/fuzz.c
> @@ -91,6 +91,7 @@ static void usage(char *path)
>          printf(" * %s  : %s\n", tmp->target->name,
>                  tmp->target->description);
>      }
> +    printf("Alternatively, add -target-FUZZ_TARGET to the executable name\n");
>      exit(0);
>  }
>  
> @@ -143,18 +144,20 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>      module_call_init(MODULE_INIT_QOM);
>      module_call_init(MODULE_INIT_LIBQOS);
>  
> -    if (*argc <= 1) {
> +    target_name = strstr(**argv, "-target-");
> +    if (target_name) {        /* The binary name specifies the target */
> +                target_name += strlen("-target-");
> +    } else if (*argc > 1) {  /* The target is specified as an argument */
> +        target_name = (*argv)[1];
> +        if (!strstr(target_name, "--fuzz-target=")) {
> +            usage(**argv);
> +        }
> +        target_name += strlen("--fuzz-target=");
> +    } else {
>          usage(**argv);
>      }
>  
>      /* Identify the fuzz target */
> -    target_name = (*argv)[1];
> -    if (!strstr(target_name, "--fuzz-target=")) {
> -        usage(**argv);
> -    }
> -
> -    target_name += strlen("--fuzz-target=");
> -
>      fuzz_target = fuzz_get_target(target_name);
>      if (!fuzz_target) {
>          usage(**argv);
> -- 
> 2.26.2

