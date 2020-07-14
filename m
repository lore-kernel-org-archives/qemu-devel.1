Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3A7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 18:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF8A22582
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 18:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qpoLFamb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF8A22582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvPF4-0002wN-2S
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 14:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jvPE9-0002Ob-LM
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 14:00:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33680)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jvPE7-000268-Hu
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 14:00:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06EHq5r1034562;
 Tue, 14 Jul 2020 18:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=M5VvhOhaY11jqQnuKJwMbdI860Sao92ka9qy2jGvZZo=;
 b=qpoLFambMZ7wPURNw5AGG1cphngMmaxGR9g3hAW6o1fvHjkOnHwVCuzvsUDYMtqfWtdp
 0i6IM1b8nnxakSX0hShQLbwCVE+TLDVuDjOdqwS0wz4MBlndl+7JWux5y9Yo1FzYw12r
 2zYxwhdS4t3r3XekuDXFnWZNzYidoThxdcCQWj7yoH/J5ZuFqatQmxp2cztLUpGzZetO
 fg88KbKNjeA1oHP+JvNXyo4I8gNeJA38WPhCRF5e9M3Cchxrx7usZqAiuZBfypV+Uw6B
 /xyQUKJeE1NgherqAUM4kLY/gj2uYU1wN3M0i6pImnKSN8+k206Lr5lklPZyUj8rN6Yb 9Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 3274ur70ds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 14 Jul 2020 18:00:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06EHqdqB024132;
 Tue, 14 Jul 2020 17:58:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 327qby5fyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2020 17:58:15 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06EHwExq009653;
 Tue, 14 Jul 2020 17:58:14 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 14 Jul 2020 10:58:14 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 6DC5CB94F18; Tue, 14 Jul 2020 18:58:06 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH] fuzz: Expect the cmdline in a freeable GString
In-Reply-To: <20200714174616.20709-1-alxndr@bu.edu>
References: <20200714174616.20709-1-alxndr@bu.edu>
Date: Tue, 14 Jul 2020 18:58:06 +0100
Message-ID: <m2eepekmhd.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9682
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=5
 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9682
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 impostorscore=0
 suspectscore=5 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007140130
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=darren.kenny@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 14:00:19
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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
 f4bug@amsat.org, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tuesday, 2020-07-14 at 13:46:16 -04, Alexander Bulekov wrote:
> In the initial FuzzTarget, get_init_cmdline returned a char *. With this
> API, we had no guarantee about where the string came from. For example,
> i440fx-qtest-reboot-fuzz simply returned a pointer to a string literal,
> while the QOS-based targets build the arguments out in a GString an
> return the gchar *str pointer. Since we did not try to free the cmdline,
> we have a leak for any targets that do not simply return string
> literals. Clean up this mess by forcing fuzz-targets to return
> a GString, that we can free.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  tests/qtest/fuzz/fuzz.c        | 13 ++++++-------
>  tests/qtest/fuzz/fuzz.h        |  6 +++---
>  tests/qtest/fuzz/i440fx_fuzz.c |  4 ++--
>  tests/qtest/fuzz/qos_fuzz.c    |  6 +++---
>  4 files changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> index 0b66e43409..6bc17ef313 100644
> --- a/tests/qtest/fuzz/fuzz.c
> +++ b/tests/qtest/fuzz/fuzz.c
> @@ -199,16 +199,15 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>      }
>  
>      /* Run QEMU's softmmu main with the fuzz-target dependent arguments */
> -    const char *init_cmdline = fuzz_target->get_init_cmdline(fuzz_target);
> -    init_cmdline = g_strdup_printf("%s -qtest /dev/null -qtest-log %s",
> -                                   init_cmdline,
> -                                   getenv("QTEST_LOG") ? "/dev/fd/2"
> -                                                       : "/dev/null");
> -
> +    GString *cmd_line = fuzz_target->get_init_cmdline(fuzz_target);
> +    g_string_append_printf(cmd_line,
> +                           " -qtest /dev/null -qtest-log %s",
> +                           getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/null");
>  
>      /* Split the runcmd into an argv and argc */
>      wordexp_t result;
> -    wordexp(init_cmdline, &result, 0);
> +    wordexp(cmd_line->str, &result, 0);
> +    g_string_free(cmd_line, true);
>  
>      qemu_init(result.we_wordc, result.we_wordv, NULL);
>  
> diff --git a/tests/qtest/fuzz/fuzz.h b/tests/qtest/fuzz/fuzz.h
> index 72d5710f6c..9ca3d107c5 100644
> --- a/tests/qtest/fuzz/fuzz.h
> +++ b/tests/qtest/fuzz/fuzz.h
> @@ -50,10 +50,10 @@ typedef struct FuzzTarget {
>  
>  
>      /*
> -     * returns the arg-list that is passed to qemu/softmmu init()
> -     * Cannot be NULL
> +     * Returns the arguments that are passed to qemu/softmmu init(). Freed by
> +     * the caller.
>       */
> -    const char* (*get_init_cmdline)(struct FuzzTarget *);
> +    GString *(*get_init_cmdline)(struct FuzzTarget *);
>  
>      /*
>       * will run once, prior to running qemu/softmmu init.
> diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_fuzz.c
> index e2f31e56f9..bf966d478b 100644
> --- a/tests/qtest/fuzz/i440fx_fuzz.c
> +++ b/tests/qtest/fuzz/i440fx_fuzz.c
> @@ -158,9 +158,9 @@ static void i440fx_fuzz_qos_fork(QTestState *s,
>  
>  static const char *i440fx_qtest_argv = TARGET_NAME " -machine accel=qtest"
>                                         " -m 0 -display none";
> -static const char *i440fx_argv(FuzzTarget *t)
> +static GString *i440fx_argv(FuzzTarget *t)
>  {
> -    return i440fx_qtest_argv;
> +    return g_string_new(i440fx_qtest_argv);
>  }
>  
>  static void fork_init(void)
> diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
> index 0c68f5361f..d52f3ebd83 100644
> --- a/tests/qtest/fuzz/qos_fuzz.c
> +++ b/tests/qtest/fuzz/qos_fuzz.c
> @@ -66,7 +66,7 @@ void *qos_allocate_objects(QTestState *qts, QGuestAllocator **p_alloc)
>      return allocate_objects(qts, current_path + 1, p_alloc);
>  }
>  
> -static const char *qos_build_main_args(void)
> +static GString *qos_build_main_args(void)
>  {
>      char **path = fuzz_path_vec;
>      QOSGraphNode *test_node;
> @@ -88,7 +88,7 @@ static const char *qos_build_main_args(void)
>      /* Prepend the arguments that we need */
>      g_string_prepend(cmd_line,
>              TARGET_NAME " -display none -machine accel=qtest -m 64 ");
> -    return cmd_line->str;
> +    return cmd_line;
>  }
>  
>  /*
> @@ -189,7 +189,7 @@ static void walk_path(QOSGraphNode *orig_path, int len)
>      g_free(path_str);
>  }
>  
> -static const char *qos_get_cmdline(FuzzTarget *t)
> +static GString *qos_get_cmdline(FuzzTarget *t)
>  {
>      /*
>       * Set a global variable that we use to identify the qos_path for our
> -- 
> 2.26.2

