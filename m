Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E447DC54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:00:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA95206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P7h/e5Bw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA95206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYPqA-0004FX-Nw
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 04:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jYPp3-0003Pf-BZ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 03:59:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1jYPp0-0004LG-Vv
 for qemu-devel@nongnu.org; Tue, 12 May 2020 03:59:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C7mGng117527;
 Tue, 12 May 2020 07:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=YnVQjTT/+pZ7DMldMGuzSi+eIuNqO8a7nHaMySuxiGw=;
 b=P7h/e5BwLXrP+hVAC5izfKHc+XSaVWi1mVU1XU56cWwjQMPZi10J+x6TFcJWAk7Bq1fM
 DzoMoUihIbAccYZhkZBtSA1mYQdV/NuXRGjsjY9TRRowxfxP8cB9ob0DD+EhSkJPUWst
 RKhyPzEVUJu0y1+Mmx3nDHVqDZXdqTW93DsHigUX56x7OGMN2gcGvnZe0wKtIicYXI7V
 FokJ4pSIPVn7+Dcy7D5v4T9dhdWxceVsTnTPIumCr3UMFfyk7q8SWt3E8wZiMZZREs3w
 9fA+HM2yAFfqdkZpGzwXmtIp73geKIdie6ymFsfZ23tAGskmERRzBC8+ml9zhGHRDbIO Qg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 30x3gmhe8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 May 2020 07:59:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C7hvxR028655;
 Tue, 12 May 2020 07:59:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 30ydspxbwu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2020 07:59:20 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04C7xJ8f022638;
 Tue, 12 May 2020 07:59:19 GMT
Received: from starbug-mbp.localdomain (/79.97.215.145)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 12 May 2020 00:59:18 -0700
Received: by starbug-mbp.localdomain (Postfix, from userid 501)
 id 4BEA36920AFC; Tue, 12 May 2020 08:59:16 +0100 (IST)
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/4] fuzz: add datadir for oss-fuzz compatability
In-Reply-To: <20200512030133.29896-2-alxndr@bu.edu>
References: <20200512030133.29896-1-alxndr@bu.edu>
 <20200512030133.29896-2-alxndr@bu.edu>
Date: Tue, 12 May 2020 08:59:16 +0100
Message-ID: <m23685mvmz.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=5 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 suspectscore=5
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120067
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=darren.kenny@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 03:59:22
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Monday, 2020-05-11 at 23:01:30 -04, Alexander Bulekov wrote:
> This allows us to keep pc-bios in executable_dir/pc-bios, rather than
> executable_dir/../pc-bios, which is incompatible with oss-fuzz' file
> structure.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  include/sysemu/sysemu.h |  2 ++
>  softmmu/vl.c            |  2 +-
>  tests/qtest/fuzz/fuzz.c | 15 +++++++++++++++
>  3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index ef81302e1a..cc96b66fc9 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -15,6 +15,8 @@ extern const char *qemu_name;
>  extern QemuUUID qemu_uuid;
>  extern bool qemu_uuid_set;
>  
> +void qemu_add_data_dir(const char *path);
> +
>  void qemu_add_exit_notifier(Notifier *notify);
>  void qemu_remove_exit_notifier(Notifier *notify);
>  
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index afd2615fb3..c71485a965 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -1993,7 +1993,7 @@ char *qemu_find_file(int type, const char *name)
>      return NULL;
>  }
>  
> -static void qemu_add_data_dir(const char *path)
> +void qemu_add_data_dir(const char *path)
>  {
>      int i;
>  
> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> index f5c923852e..33365c3782 100644
> --- a/tests/qtest/fuzz/fuzz.c
> +++ b/tests/qtest/fuzz/fuzz.c
> @@ -137,6 +137,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>  {
>  
>      char *target_name;
> +    char *dir;
>  
>      /* Initialize qgraph and modules */
>      qos_graph_init();
> @@ -147,6 +148,20 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>      target_name = strstr(**argv, "-target-");
>      if (target_name) {        /* The binary name specifies the target */
>          target_name += strlen("-target-");
> +        /*
> +         * With oss-fuzz, the executable is kept in the root of a directory (we
> +         * cannot assume the path). All data (including bios binaries) must be
> +         * in the same dir, or a subdir. Thus, we cannot place the pc-bios so
> +         * that it would be in exec_dir/../pc-bios.
> +         * As a workaround, oss-fuzz allows us to use argv[0] to get the
> +         * location of the executable. Using this we add exec_dir/pc-bios to
> +         * the datadirs.
> +         */
> +        dir = g_build_filename(g_path_get_dirname(**argv), "pc-bios", NULL);
> +        if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
> +            qemu_add_data_dir(dir);
> +        }
> +        g_free(dir);
>      } else if (*argc > 1) {  /* The target is specified as an argument */
>          target_name = (*argv)[1];
>          if (!strstr(target_name, "--fuzz-target=")) {
> -- 
> 2.26.2

