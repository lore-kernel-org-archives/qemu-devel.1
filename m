Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDBBC433ED
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6490A2086A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="muz+IqYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6490A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyb5d-0003S8-MO
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 09:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jyb4W-0002Pf-8f
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:15:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jyb4T-0003Vn-Vr
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:15:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06ND9FOS016379;
 Thu, 23 Jul 2020 13:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=TVNCDIC1zW06l3Yq0/i7lLF2cvv3DV8EEqvuIBHkrOs=;
 b=muz+IqYmEoIyqnxK9PG/YDrJB1/A41MB6/c3L8i0H7b1wMXkxEqJzuEG25HxhDu8U41V
 6Pllz0iD375D0W8bv0nxdnpwaV1e56H5krDSqu20EnRWgT6Imkc++YqNwvvvLFU5QeAn
 OK4VEPRnI6TkS0L/4tsBBjdwwFZm2ZqvJ+LDYlSGK0TMBSbd9XW9q25rJhE6ZeOQeCRN
 igo+oKgqs+fOzMaT2ryheUmE28hLhw0iGBlIJgCnHA91rGcZKm6OX3Vj5XKNUTgZGEw4
 Q3IzzOX4/rNarLlL6LubctcfvV3MnfKjCVJJRcAMcs5tZHwaofk9jKU7cvL6iRP5yWyp KA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 32brgrs97v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 Jul 2020 13:15:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06ND8JJY137910;
 Thu, 23 Jul 2020 13:15:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 32f5pxeg8g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jul 2020 13:15:23 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06NDFLT4023735;
 Thu, 23 Jul 2020 13:15:21 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 23 Jul 2020 06:15:21 -0700
Received: by localhost.localdomain (Postfix, from userid 501)
 id CBF84D762DD; Thu, 23 Jul 2020 14:15:17 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH 01/12] fuzz: Change the way we write qtest log to stderr
In-Reply-To: <20200723033933.21883-2-alxndr@bu.edu>
References: <20200723033933.21883-1-alxndr@bu.edu>
 <20200723033933.21883-2-alxndr@bu.edu>
Date: Thu, 23 Jul 2020 14:15:17 +0100
Message-ID: <m21rl2tlsq.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9690
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007230098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9690
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=1 adultscore=0 clxscore=1011 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007230098
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=darren.kenny@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 09:15:34
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
Cc: Laurent Vivier <lvivier@redhat.com>, thuth@redhat.com, f4bug@amsat.org,
 Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com, dstepanov.src@gmail.com,
 stefanha@redhat.com, andrew@coatesdev.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-07-22 at 23:39:22 -04, Alexander Bulekov wrote:
> Telling QTest to log to /dev/fd/2, essentially results in dup(2). This
> is fine, if other code isn't logging to stderr. Otherwise, the order of
> the logs is mixed due to buffering issues, since two file-descriptors
> are used to write to the same file. We can avoid this, since just
> specifying "-qtest" sets the log fd to stderr. If we want to disable
> qtest logs, we can just add -qtest-log none.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  tests/qtest/fuzz/fuzz.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> index 031594a686..8234b68754 100644
> --- a/tests/qtest/fuzz/fuzz.c
> +++ b/tests/qtest/fuzz/fuzz.c
> @@ -202,9 +202,8 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>  
>      /* Run QEMU's softmmu main with the fuzz-target dependent arguments */
>      GString *cmd_line = fuzz_target->get_init_cmdline(fuzz_target);
> -    g_string_append_printf(cmd_line,
> -                           " -qtest /dev/null -qtest-log %s",
> -                           getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/null");
> +    g_string_append_printf(cmd_line, " %s -qtest /dev/null ",
> +                           getenv("QTEST_LOG") ? "" : "-qtest-log none");
>  
>      /* Split the runcmd into an argv and argc */
>      wordexp_t result;
> -- 
> 2.27.0

