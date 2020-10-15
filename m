Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394B1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 08:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646EC2224A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 08:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XYWQMvPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646EC2224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSymu-00060N-38
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 04:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kSymK-0005ZN-EQ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 04:38:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kSymI-0008WI-GH
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 04:38:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09F8YM2C061810;
 Thu, 15 Oct 2020 08:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=ElvZVF+Wb6acF9WOvtnBc4UKu2pcq7ucoEAFHyR5Gj4=;
 b=XYWQMvPxCaf1+LA17ao2+ZlF1UDwC1OlC9+HfU+qZZHyA7WFz9hekurYl0aVaI+oc/xk
 WL3TGAAz2ZBSFlINUoycTMUReIa4iWlbcTIuTTL0ZEI+SZqgz5VXdGFityK2Mkvia4cB
 9Tl9fBJQ9/ewM2bz4RfQdjO0fLxVMlua+6YbLQFDw9mFtIv6w8xeP6ResX0w423g25gJ
 OBxaZkTxySZ37+Go4rpTepgUvJvUwmjL2S5Oyl2NHYHrPZOpZrHiCy+ptRUYYnbHR/E+
 p9COKj7287kgaxyGSRiIsACr32q76blYjoipLVVRe/vVeAvcOON5pSZvz86GqK9PQkz3 0Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 3434wkugpd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Oct 2020 08:38:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09F8ZLEi144015;
 Thu, 15 Oct 2020 08:38:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 343pv1h81y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Oct 2020 08:38:16 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09F8cDeS016817;
 Thu, 15 Oct 2020 08:38:13 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 15 Oct 2020 01:38:13 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 1313C1C341BA; Thu, 15 Oct 2020 09:38:10 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] fuzz: Disable QEMU's SIG{INT,HUP,TERM} handlers
In-Reply-To: <20201014142157.46028-1-alxndr@bu.edu>
References: <20201014142157.46028-1-alxndr@bu.edu>
Date: Thu, 15 Oct 2020 09:38:10 +0100
Message-ID: <m28sc7natp.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=796
 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=1 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=1 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=803
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150061
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=darren.kenny@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 04:38:18
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
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-10-14 at 10:21:57 -04, Alexander Bulekov wrote:
> Prior to this patch, the only way I found to terminate the fuzzer was
> either to:
>  1. Explicitly specify the number of fuzzer runs with the -runs= flag
>  2. SIGKILL the process with "pkill -9 qemu-fuzz-*" or similar
>
> In addition to being annoying to deal with, SIGKILLing the process skips
> over any exit handlers(e.g. registered with atexit()). This is bad,
> since some fuzzers might create temporary files that should ideally be
> removed on exit using an exit handler. The only way to achieve a clean
> exit now is to specify -runs=N , but the desired "N" is tricky to
> identify prior to fuzzing.
>
> Why doesn't the process exit with standard SIGINT,SIGHUP,SIGTERM
> signals? QEMU installs its own handlers for these signals in
> os-posix.c:os_setup_signal_handling, which notify the main loop that an
> exit was requested. The fuzzer, however, does not run qemu_main_loop,
> which performs the main_loop_should_exit() check.  This means that the
> fuzzer effectively ignores these signals. As we don't really care about
> cleanly stopping the disposable fuzzer "VM", this patch uninstalls
> QEMU's signal handlers. Thus, we can stop the fuzzer with
> SIG{INT,HUP,TERM} and the fuzzing code can optionally use atexit() to
> clean up temporary files/resources.
>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Much clearer Alex, thanks for rewording it :)

Darren.

> ---
>  tests/qtest/fuzz/fuzz.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> index d926c490c5..eb0070437f 100644
> --- a/tests/qtest/fuzz/fuzz.c
> +++ b/tests/qtest/fuzz/fuzz.c
> @@ -217,5 +217,13 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>      /* re-enable the rcu atfork, which was previously disabled in qemu_init */
>      rcu_enable_atfork();
>  
> +    /*
> +     * Disable QEMU's signal handlers, since we manually control the main_loop,
> +     * and don't check for main_loop_should_exit
> +     */
> +    signal(SIGINT, SIG_DFL);
> +    signal(SIGHUP, SIG_DFL);
> +    signal(SIGTERM, SIG_DFL);
> +
>      return 0;
>  }
> -- 
> 2.28.0

