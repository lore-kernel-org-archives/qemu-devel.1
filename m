Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81EBC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 12:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801902074A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 12:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EN70Xi0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801902074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAY51-0004St-Rr
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 08:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kAY4T-000431-UP
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 08:29:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28720
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kAY4R-0005yF-21
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 08:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598358536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ticVfOFh3f5q2X59ZMHN1R2urXyxoLWMt6iu/Ucaxys=;
 b=EN70Xi0/n6MVHon+L6N/Fp19Cts20foDOlJ38BOPI9Y5HI+o6DRAlTWscO19BFA60MAIUM
 qZKvX2RydeD73yC2Yof5WBg+6qSIuKVbxmUpQ7JyPHUwmZn9UCrCn4iAPw22Hrju+fCO4L
 jyi1B0M7XRQoofjSUVRsCoMINGh83hw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-TJ5f-3ljMb-cLVc_e11xdg-1; Tue, 25 Aug 2020 08:28:53 -0400
X-MC-Unique: TJ5f-3ljMb-cLVc_e11xdg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BB5510ABDAE;
 Tue, 25 Aug 2020 12:28:52 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-0.ams2.redhat.com
 [10.36.113.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CCF32AAA1;
 Tue, 25 Aug 2020 12:28:51 +0000 (UTC)
Subject: Re: [PATCH v4 1/6] x86: lpc9: let firmware negotiate 'CPU hotplug
 with SMI' features
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <7fa8fa3f-7b7a-895b-ff17-2222ec55bc9c@redhat.com>
 <20200824110038.1365178-1-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8aa82754-cf0c-ae54-300d-aaa8b6118c10@redhat.com>
Date: Tue, 25 Aug 2020 14:28:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200824110038.1365178-1-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:37:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: boris.ostrovsky@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/24/20 13:00, Igor Mammedov wrote:
> It will allow firmware to notify QEMU that firmware requires SMI
> being triggered on CPU hot[un]plug, so that it would be able to account
> for hotplugged CPU and relocate it to new SMM base and/or safely remove
> CPU on unplug.
>
> Using negotiated features, follow up patches will insert SMI upcall
> into AML code, to make sure that firmware processes hotplug before
> guest OS would attempt to use new CPU.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> ---
> v4:
>   - fix 5.2 machine types so they won't apply pc_compat_5_1
>      (Laszlo Ersek <lersek@redhat.com>)
> v3:
>   - rebase on top of "[PATCH v2] hw: add compat machines for 5.2"
>     so apply that before this patch
> v2:
>   - rebase on top of 5.1 (move compat values to 5.1 machine)
>   - make "x-smi-cpu-hotunplug" false by default (Laszlo Ersek <lersek@redhat.com>)
>
> fixup
> ---
>  include/hw/i386/ich9.h |  2 ++
>  hw/i386/pc.c           |  4 +++-
>  hw/isa/lpc_ich9.c      | 13 +++++++++++++
>  3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
> index a98d10b252..d1bb3f7bf0 100644
> --- a/include/hw/i386/ich9.h
> +++ b/include/hw/i386/ich9.h
> @@ -247,5 +247,7 @@ typedef struct ICH9LPCState {
>
>  /* bit positions used in fw_cfg SMI feature negotiation */
>  #define ICH9_LPC_SMI_F_BROADCAST_BIT            0
> +#define ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT          1
> +#define ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT       2
>
>  #endif /* HW_ICH9_H */
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 9aa813949c..583db11d28 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -97,7 +97,9 @@
>  #include "fw_cfg.h"
>  #include "trace.h"
>
> -GlobalProperty pc_compat_5_1[] = {};
> +GlobalProperty pc_compat_5_1[] = {
> +    { "ICH9-LPC", "x-smi-cpu-hotplug", "off" },
> +};
>  const size_t pc_compat_5_1_len = G_N_ELEMENTS(pc_compat_5_1);
>
>  GlobalProperty pc_compat_5_0[] = {
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index cd6e169d47..19f32bed3e 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -373,6 +373,15 @@ static void smi_features_ok_callback(void *opaque)
>          /* guest requests invalid features, leave @features_ok at zero */
>          return;
>      }
> +    if (!(guest_features & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT)) &&
> +        guest_features & (BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT) |
> +                          BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT))) {
> +        /*
> +         * cpu hot-[un]plug with SMI requires SMI broadcast,
> +         * leave @features_ok at zero
> +         */
> +        return;
> +    }
>
>      /* valid feature subset requested, lock it down, report success */
>      lpc->smi_negotiated_features = guest_features;
> @@ -747,6 +756,10 @@ static Property ich9_lpc_properties[] = {
>      DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, true),
>      DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_features,
>                        ICH9_LPC_SMI_F_BROADCAST_BIT, true),
> +    DEFINE_PROP_BIT64("x-smi-cpu-hotplug", ICH9LPCState, smi_host_features,
> +                      ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT, true),
> +    DEFINE_PROP_BIT64("x-smi-cpu-hotunplug", ICH9LPCState, smi_host_features,
> +                      ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
>

This patch doesn't apply with git-am, as of commit 44423107e7b5 ("Merge
remote-tracking branch 'remotes/xtensa/tags/20200821-xtensa' into
staging", 2020-08-24).

The reason is that commit 2becc36a3e53 ("meson: infrastructure for
building emulators", 2020-08-21) introduced

#include CONFIG_DEVICES

to "hw/i386/pc.c", just above the (then) "pc_compat_5_0" array.

Then Cornelia's commit 3ff3c5d31740 ("hw: add compat machines for 5.2",
2020-08-19), which introduced "pc_compat_5_1" independently of the Meson
conversion, needed explicit resolution against CONFIG_DEVICES for
merging into master. That was covered in merge commit ca489cd037e4
("Merge remote-tracking branch
'remotes/ehabkost/tags/machine-next-pull-request' into staging",
2020-08-22).

So the patch applies on top of 3ff3c5d31740, but not on the merge
(ca489cd037e4) that brought 3ff3c5d31740 into master.

Not a problem though: I can apply the patch on 3ff3c5d31740, and then
cleanly (automatically) rebase to current HEAD (44423107e7b5) from
there. This is the range-diff across the rebase:

> 1:  9066fa4ccb49 ! 1:  05188fffe6aa x86: lpc9: let firmware negotiate 'CPU hotplug with SMI' features
>     @@ -31,8 +31,8 @@
>      --- a/hw/i386/pc.c
>      +++ b/hw/i386/pc.c
>      @@
>     - #include "fw_cfg.h"
>       #include "trace.h"
>     + #include CONFIG_DEVICES
>
>      -GlobalProperty pc_compat_5_1[] = {};
>      +GlobalProperty pc_compat_5_1[] = {


So it's indeed just a context update.

Having applied this series to QEMU, my test results are:

  OVMF has 5ba203b54e59  machine type  plug gate  unplug gate  gating result
  ---------------------  ------------  ---------  -----------  -------------
  no                     pc-q35-5.1    reject     reject       pass
  no                     pc-q35-5.2    reject     reject       pass
  yes                    pc-q35-5.1    reject     reject       pass
  yes                    pc-q35-5.2    accept     reject       pass

The results are the same after S3 suspend/resume. (This is relevant
because the features are re-negotiated during S3 resume.)

Thus, for this one patch, so far:

- (just to confirm:)
Reviewed-by: Laszlo Ersek <lersek@redhat.com>

- also:
Tested-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo


