Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCF2C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 16:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C88120717
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 16:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTbODs0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C88120717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwTYA-0001kq-H1
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 12:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jwTWR-0007qE-Sq
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 12:47:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52380
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jwTWP-00079D-Vs
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 12:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595004461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=KCW7lkINR0cqCAj6iqZQCrYOReF5qdC/AWRruHlV0vI=;
 b=YTbODs0rTs0ZLxOhhBpD/Lf0w11Zwj4tkRPqAo+q9coJf73olzxEvdNmu50PyOELfwpOrt
 NX1hTrGb5oK0/t0vuEuHF3YwYZlAhb1aBzhb1obgzWD6ERZtITsPS0tbqA5hNrj7fBQowV
 R/14jwGO0X4A9CX6TELlU78spxjL3W4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-GBeGt08GN8aEGklgP8R_VQ-1; Fri, 17 Jul 2020 12:47:39 -0400
X-MC-Unique: GBeGt08GN8aEGklgP8R_VQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 996901080;
 Fri, 17 Jul 2020 16:47:38 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-141.ams2.redhat.com [10.36.113.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1320E70BAB;
 Fri, 17 Jul 2020 16:47:27 +0000 (UTC)
Subject: Re: [PATCH] fuzz: Fix leak when assembling datadir path string
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200717163523.1591-1-alxndr@bu.edu>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1d2f13f1-d467-0616-8ea4-9254e1c4b855@redhat.com>
Date: Fri, 17 Jul 2020 18:47:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200717163523.1591-1-alxndr@bu.edu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/07/2020 18.35, Alexander Bulekov wrote:
> We freed the string containing the final datadir path, but did not free
> the path to the executable's directory that we get from
> g_path_get_dirname(). Fix that.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
> 
> I ran it with Thomas' fixed build-oss-fuzz job:
> https://gitlab.com/a1xndr/qemu/-/jobs/644463736

Looks like the fuzzer triggered a crash there, see line 5850 ...
shouldn't the job fail in that case? ... i.e. is the fuzzer still
exiting with return code 0?

> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> index 6bc17ef313..031594a686 100644
> --- a/tests/qtest/fuzz/fuzz.c
> +++ b/tests/qtest/fuzz/fuzz.c
> @@ -143,7 +143,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>  {
>  
>      char *target_name;
> -    char *dir;
> +    char *bindir, *datadir;
>      bool serialize = false;
>  
>      /* Initialize qgraph and modules */
> @@ -164,11 +164,13 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>           * location of the executable. Using this we add exec_dir/pc-bios to
>           * the datadirs.
>           */
> -        dir = g_build_filename(g_path_get_dirname(**argv), "pc-bios", NULL);
> -        if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
> -            qemu_add_data_dir(dir);
> +        bindir = g_path_get_dirname(**argv);
> +        datadir = g_build_filename(bindir, "pc-bios", NULL);
> +        g_free(bindir);
> +        if (g_file_test(datadir, G_FILE_TEST_IS_DIR)) {
> +            qemu_add_data_dir(datadir);
>          }
> -        g_free(dir);
> +        g_free(datadir);
>      } else if (*argc > 1) {  /* The target is specified as an argument */
>          target_name = (*argv)[1];
>          if (!strstr(target_name, "--fuzz-target=")) {
> 

Patch looks fine, thanks!

Reviewed-by: Thomas Huth <thuth@redhat.com>


