Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A208C5518A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3771820781
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OrLGt80i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3771820781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRDRC-0006Kr-Cc
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 07:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1jRDQ7-0005ox-Se
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1jRDQ6-0006yi-U2
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:19:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jRDQ6-0006uE-C3
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:19:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03MBIZI7044344;
 Wed, 22 Apr 2020 11:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=o5SMV7VH2DvSdjXnCMp92CSKpogG1zUKj426g/sMlMQ=;
 b=OrLGt80i11eA7fKbSo5vwcJyTbNexORYnJ25wRFBKdVupGaXcjqu1j+zf6RiMuqRfIIy
 mECTb0DcH6I6ceXkLi3mFJPqgQXHIPQ2EU4aUCepJLkjgKWOKruMGGUtRTb+cUeh+POz
 R1frjp5qnynhx2LNDx11YqDmRxZSN0JRLXuA0FFhA6JBZnzrda8xe6qZLk2WTEzLrDVN
 ybBb2ApslbnzNW0UVRRIW4dMlvb7jA0cGNFKm0tJ/o0RyrVkwLBwNdBvZ5DsME/rh4HB
 lVXVSIBe6MgtjWHysePHBYpdaKyJpapnQ4V5zswdHH0Q04Z86m4NT46mLLpWdFOlKkro FQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 30grpgpmqt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Apr 2020 11:19:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03MBII2g116134;
 Wed, 22 Apr 2020 11:19:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 30gb1jbb1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Apr 2020 11:19:52 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03MBJpcj011775;
 Wed, 22 Apr 2020 11:19:51 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 04:19:51 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 286C465D51D9; Wed, 22 Apr 2020 12:19:48 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH] fuzz: select fuzz target using executable name
In-Reply-To: <20200421182230.6313-1-alxndr@bu.edu>
References: <20200421182230.6313-1-alxndr@bu.edu>
Date: Wed, 22 Apr 2020 12:19:48 +0100
Message-ID: <m2368vhinf.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=1 spamscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004220090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=1 bulkscore=0 clxscore=1011
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004220090
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=darren.kenny@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 07:19:55
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On Tuesday, 2020-04-21 at 14:22:30 -04, Alexander Bulekov wrote:
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
> 2.25.0

