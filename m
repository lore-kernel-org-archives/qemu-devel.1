Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E680C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C13C5252E6
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kv2IgPUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13C5252E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSNWl-0004JF-FA
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 12:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kSNVj-0003dO-8S
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:50:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1kSNVh-0005nf-A3
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:50:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DGoIk4047608;
 Tue, 13 Oct 2020 16:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=ndTyUv0cPW5h/QU+6mv2r3vB4nV27RHNOuqztS5VsCo=;
 b=Kv2IgPUxqSQDjnrQxGALCaIHA6Mykn1Y/FHmyCIuPfTs1P70/Anm/YJbYfLoT0VMgRep
 1zgMZypAMngKBQHIkACgvlwojn6SPDGsP2KhM2WSA0G/eCIxFQFm81QNvm6vy+QDmYPx
 oWjt79iOv5JtXfTiaC5NzlI+n+afAb5A/+tAlKgwtcqhjgdCi/PjWxW5iaU82HRTv19L
 WiOvv1dGbx2qIb5uG6qM+7SazG8y99hagW1+rFL9q/hvbL8aEWkCPnpPMVw+w88qzOzB
 iysTwSnOX57xk8v26fpJ5eQvKPN0OLPor+eLtchdoQrM5Owwvceno13cyxLGcURG8Iog 5Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 343vae9k40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Oct 2020 16:50:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DGnkHB188515;
 Tue, 13 Oct 2020 16:50:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 344by2ffk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Oct 2020 16:50:44 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09DGoggk013767;
 Tue, 13 Oct 2020 16:50:42 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 13 Oct 2020 09:50:42 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 8C5D91BCC45C; Tue, 13 Oct 2020 17:50:37 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH] fuzz: Disable QEMU's signal handlers
In-Reply-To: <20201013152920.448335-1-alxndr@bu.edu>
References: <20201013152920.448335-1-alxndr@bu.edu>
Date: Tue, 13 Oct 2020 17:50:37 +0100
Message-ID: <m2r1q2m5nm.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773
 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=1 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010130123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773
 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 clxscore=1011
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=1 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130123
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=darren.kenny@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 11:27:50
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

Hi Alex,

This mentions the use of atexit() to perform some cleanup, but I'm not
seeing that being added here, should it be?

Thanks,

Darren.

On Tuesday, 2020-10-13 at 11:29:20 -04, Alexander Bulekov wrote:
> With the fuzzer, we never call main_loop_should_exit, since we manually
> call main_loop_wait. This means that the only way to terminate the
> fuzzer is with SIGKILL. Disable the signal handlers, so there are
> reasonable ways to terminate the fuzzer and use atexit() to clean-up
> after the fuzzer.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
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

