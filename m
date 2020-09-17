Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DC6C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15A92078D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6/UO3EN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15A92078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwwL-0008Rw-T7
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kIwtM-0005gk-EA
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kIwtK-0001kj-4w
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600360573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ChLdayVjX8ZWfmVVjxCnF3WKTnlhTghAbOompQAeYzw=;
 b=d6/UO3ENFcsYxxhQ6YPtDeoUJg1I43DQ4Q0t4AV+YRH9IYkYkmtz8ot3uRPy7r/5tEOJ5f
 LjHDDIARomr6JxReJnBlfoGUtq7AMPJBk7UXt4rR5HdCJpdRz2zCTTvL+9FpYDrQhDrjFk
 dy9+h1J/586CUJ4dHWNjJk2p4xmfBs8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-0GYMnudsNWCK5DC6bUlG5g-1; Thu, 17 Sep 2020 12:36:11 -0400
X-MC-Unique: 0GYMnudsNWCK5DC6bUlG5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF9AC106B348;
 Thu, 17 Sep 2020 16:36:09 +0000 (UTC)
Received: from work-vm (ovpn-114-108.ams2.redhat.com [10.36.114.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4892A6886C;
 Thu, 17 Sep 2020 16:36:04 +0000 (UTC)
Date: Thu, 17 Sep 2020 17:36:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 1/5] sev/i386: Add initial support for SEV-ES
Message-ID: <20200917163601.GP2793@work-vm>
References: <cover.1600205384.git.thomas.lendacky@amd.com>
 <e2456cc461f329f52aa6eb3fcd0d0ce9451b8fa7.1600205384.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2456cc461f329f52aa6eb3fcd0d0ce9451b8fa7.1600205384.git.thomas.lendacky@amd.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Brijesh Singh <brijesh.singh@amd.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Connor Kuehl <ckuehl@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Tom Lendacky (thomas.lendacky@amd.com) wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Provide initial support for SEV-ES. This includes creating a function to
> indicate the guest is an SEV-ES guest (which will return false until all
> support is in place), performing the proper SEV initialization and
> ensuring that the guest CPU state is measured as part of the launch.
> 
> Co-developed-by: Jiri Slaby <jslaby@suse.cz>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  target/i386/cpu.c      |  1 +
>  target/i386/sev-stub.c |  5 +++++
>  target/i386/sev.c      | 46 ++++++++++++++++++++++++++++++++++++++++--
>  target/i386/sev_i386.h |  1 +
>  4 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 588f32e136..bbbe581d35 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5969,6 +5969,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          break;
>      case 0x8000001F:
>          *eax = sev_enabled() ? 0x2 : 0;
> +        *eax |= sev_es_enabled() ? 0x8 : 0;

If that also came from a nicely defined constant it would be great.

Other than that;


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>          *ebx = sev_get_cbit_position();
>          *ebx |= sev_get_reduced_phys_bits() << 6;
>          *ecx = 0;
> diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
> index 88e3f39a1e..040ac90563 100644
> --- a/target/i386/sev-stub.c
> +++ b/target/i386/sev-stub.c
> @@ -49,3 +49,8 @@ SevCapability *sev_get_capabilities(Error **errp)
>      error_setg(errp, "SEV is not available in this QEMU");
>      return NULL;
>  }
> +
> +bool sev_es_enabled(void)
> +{
> +    return false;
> +}
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index c3ecf86704..6c9cd0854b 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -359,6 +359,12 @@ sev_enabled(void)
>      return !!sev_guest;
>  }
>  
> +bool
> +sev_es_enabled(void)
> +{
> +    return false;
> +}
> +
>  uint64_t
>  sev_get_me_mask(void)
>  {
> @@ -578,6 +584,22 @@ sev_launch_update_data(SevGuestState *sev, uint8_t *addr, uint64_t len)
>      return ret;
>  }
>  
> +static int
> +sev_launch_update_vmsa(SevGuestState *sev)
> +{
> +    int ret, fw_error;
> +
> +    ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL, &fw_error);
> +    if (ret) {
> +        error_report("%s: LAUNCH_UPDATE_VMSA ret=%d fw_error=%d '%s'",
> +                __func__, ret, fw_error, fw_error_to_str(fw_error));
> +        goto err;
> +    }
> +
> +err:
> +    return ret;
> +}
> +
>  static void
>  sev_launch_get_measure(Notifier *notifier, void *unused)
>  {
> @@ -590,6 +612,14 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
>          return;
>      }
>  
> +    if (sev_es_enabled()) {
> +        /* measure all the VM save areas before getting launch_measure */
> +        ret = sev_launch_update_vmsa(sev);
> +        if (ret) {
> +            exit(1);
> +        }
> +    }
> +
>      measurement = g_new0(struct kvm_sev_launch_measure, 1);
>  
>      /* query the measurement blob length */
> @@ -684,7 +714,7 @@ sev_guest_init(const char *id)
>  {
>      SevGuestState *sev;
>      char *devname;
> -    int ret, fw_error;
> +    int ret, fw_error, cmd;
>      uint32_t ebx;
>      uint32_t host_cbitpos;
>      struct sev_user_data_status status = {};
> @@ -745,8 +775,20 @@ sev_guest_init(const char *id)
>      sev->api_major = status.api_major;
>      sev->api_minor = status.api_minor;
>  
> +    if (sev_es_enabled()) {
> +        if (!(status.flags & SEV_STATUS_FLAGS_CONFIG_ES)) {
> +            error_report("%s: guest policy requires SEV-ES, but "
> +                         "host SEV-ES support unavailable",
> +                         __func__);
> +            goto err;
> +        }
> +        cmd = KVM_SEV_ES_INIT;
> +    } else {
> +        cmd = KVM_SEV_INIT;
> +    }
> +
>      trace_kvm_sev_init();
> -    ret = sev_ioctl(sev->sev_fd, KVM_SEV_INIT, NULL, &fw_error);
> +    ret = sev_ioctl(sev->sev_fd, cmd, NULL, &fw_error);
>      if (ret) {
>          error_report("%s: failed to initialize ret=%d fw_error=%d '%s'",
>                       __func__, ret, fw_error, fw_error_to_str(fw_error));
> diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
> index 4db6960f60..4f9a5e9b21 100644
> --- a/target/i386/sev_i386.h
> +++ b/target/i386/sev_i386.h
> @@ -29,6 +29,7 @@
>  #define SEV_POLICY_SEV          0x20
>  
>  extern bool sev_enabled(void);
> +extern bool sev_es_enabled(void);
>  extern uint64_t sev_get_me_mask(void);
>  extern SevInfo *sev_get_info(void);
>  extern uint32_t sev_get_cbit_position(void);
> -- 
> 2.28.0
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


