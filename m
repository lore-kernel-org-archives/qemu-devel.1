Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE892C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:00:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F16F206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F16F206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7m1-0002Uc-Cx
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kD7Pd-0004Ir-9J
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:37:29 -0400
Received: from relay64.bu.edu ([128.197.228.104]:36235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kD7Pb-0007fj-JU
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:37:28 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 081EaDxk006419
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 1 Sep 2020 10:36:17 -0400
Date: Tue, 1 Sep 2020 10:36:13 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 01/13] fuzz: use qemu_get_exec_dir
Message-ID: <20200901143613.buw75sln6zncrllk@mozz.bu.edu>
References: <20200901062020.26660-1-pbonzini@redhat.com>
 <20200901062020.26660-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901062020.26660-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:37:26
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200901 0220, Paolo Bonzini wrote:
> Make things consistent with how softmmu/vl.c uses os_find_datadir.
> Initializing the path to the executables will also be needed for
> get_relocatable_path to work.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/qtest/fuzz/fuzz.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> index 1ceea84702..391223219d 100644
> --- a/tests/qtest/fuzz/fuzz.c
> +++ b/tests/qtest/fuzz/fuzz.c
> @@ -152,6 +152,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>      module_call_init(MODULE_INIT_QOM);
>      module_call_init(MODULE_INIT_LIBQOS);
>  
> +    qemu_init_exec_dir(**argv);
>      target_name = strstr(**argv, "-target-");
>      if (target_name) {        /* The binary name specifies the target */
>          target_name += strlen("-target-");
> @@ -164,7 +165,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>           * location of the executable. Using this we add exec_dir/pc-bios to
>           * the datadirs.
>           */
> -        bindir = g_path_get_dirname(**argv);
> +        bindir = qemu_get_exec_dir();
>          datadir = g_build_filename(bindir, "pc-bios", NULL);
>          g_free(bindir);
>          if (g_file_test(datadir, G_FILE_TEST_IS_DIR)) {
> -- 
> 2.26.2
> 
> 
> 

Thanks.

I think this should be applied after
[PATCH 02/13] oslib: do not call g_strdup from qemu_get_exec_dir
for bisectability, since before 02/13, calling qemu_init_exec_dir
twice causes an assertion failure.

Otherwise,
Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

