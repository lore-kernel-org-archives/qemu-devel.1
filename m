Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B770C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 001F720578
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001F720578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jttB3-00071W-9d
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jtt1D-0004Gj-Ca
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:24:47 -0400
Received: from relay64.bu.edu ([128.197.228.104]:50948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jtt1B-0003IX-Ew
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:24:46 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 06ADNUa2010187
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 10 Jul 2020 09:23:35 -0400
Date: Fri, 10 Jul 2020 09:23:30 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] softmmu/vl: Be less verbose about missing KVM when
 running the qtests
Message-ID: <20200710132330.7xgutur2hhki75ez@mozz.bu.edu>
References: <20200710085020.28222-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710085020.28222-1-thuth@redhat.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 09:24:44
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200710 1050, Thomas Huth wrote:
> Some of the qtests use "-accel kvm -accel tcg" to run real guest code.
> This causes some error messages when kvm is not available. We do not
> really care about these messages since the fallback to tcg is expected
> here. So let's silence them to avoid that they spoil the output of
> the tests.
> 
> Unfortunately, we can not use the qtest_enabled() wrapper in this case,
> since the qtest accelerator itself is not initialized. Thus we have to
> test for the qtest_chrdev variable instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

> ---
>  softmmu/vl.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 3f58ffd4dc..0066f50fb2 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -164,8 +164,9 @@ bool boot_strict;
>  uint8_t *boot_splash_filedata;
>  int only_migratable; /* turn it off unless user states otherwise */
>  bool wakeup_suspend_enabled;
> -
>  int icount_align_option;
> +static const char *qtest_chrdev;
> +static const char *qtest_log;
>  
>  /* The bytes in qemu_uuid are in the order specified by RFC4122, _not_ in the
>   * little-endian "wire format" described in the SMBIOS 2.6 specification.
> @@ -2693,10 +2694,15 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
>      AccelClass *ac = accel_find(acc);
>      AccelState *accel;
>      int ret;
> +    bool qtest_with_kvm;
> +
> +    qtest_with_kvm = g_str_equal(acc, "kvm") && qtest_chrdev != NULL;
>  
>      if (!ac) {
>          *p_init_failed = true;
> -        error_report("invalid accelerator %s", acc);
> +        if (!qtest_with_kvm) {
> +            error_report("invalid accelerator %s", acc);
> +        }
>          return 0;
>      }
>      accel = ACCEL(object_new_with_class(OBJECT_CLASS(ac)));
> @@ -2708,8 +2714,9 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
>      ret = accel_init_machine(accel, current_machine);
>      if (ret < 0) {
>          *p_init_failed = true;
> -        error_report("failed to initialize %s: %s",
> -                     acc, strerror(-ret));
> +        if (!qtest_with_kvm || ret != -ENOENT) {
> +            error_report("failed to initialize %s: %s", acc, strerror(-ret));
> +        }
>          return 0;
>      }
>  
> @@ -2780,7 +2787,7 @@ static void configure_accelerators(const char *progname)
>          exit(1);
>      }
>  
> -    if (init_failed) {
> +    if (init_failed && !qtest_chrdev) {
>          AccelClass *ac = ACCEL_GET_CLASS(current_accel());
>          error_report("falling back to %s", ac->name);
>      }
> @@ -2830,8 +2837,6 @@ void qemu_init(int argc, char **argv, char **envp)
>      MachineClass *machine_class;
>      const char *cpu_option;
>      const char *vga_model = NULL;
> -    const char *qtest_chrdev = NULL;
> -    const char *qtest_log = NULL;
>      const char *incoming = NULL;
>      bool userconfig = true;
>      bool nographic = false;
> -- 
> 2.18.1
> 
> 

