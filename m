Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09FDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 17:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ECF72065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 17:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjZc5CWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECF72065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZHNk-0003V3-D8
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 13:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZHMv-0002oX-5G
 for qemu-devel@nongnu.org; Thu, 14 May 2020 13:10:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29109
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZHMt-0001U3-L5
 for qemu-devel@nongnu.org; Thu, 14 May 2020 13:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589476197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KFZ5AjD6loXJYHYKzj8B/hbMmtmyXauXAqQ50TBn0l4=;
 b=GjZc5CWQQAfRgw7FkpquSdOqKBguFBDXJIQk2QeZTeltS1zEbi9DoA+3XbyHTxtHoj8yI3
 qtzcawPcG09hgzQ1RBB0o5UkBhnpFnAM8Z800JHglhSlqyhcSuVRbf2uVLRXKyrXL9O2/P
 6lz7dUqidztR5v+J9Y6gJQXt2DUzvzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-JjzPKOULPFSVs6x4uzB1PQ-1; Thu, 14 May 2020 13:09:55 -0400
X-MC-Unique: JjzPKOULPFSVs6x4uzB1PQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03AFD108ED68;
 Thu, 14 May 2020 17:09:54 +0000 (UTC)
Received: from work-vm (ovpn-114-247.ams2.redhat.com [10.36.114.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D362F1C933;
 Thu, 14 May 2020 17:09:48 +0000 (UTC)
Date: Thu, 14 May 2020 18:09:46 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC 16/18] use errp for gmpo kvm_init
Message-ID: <20200514170808.GS2787@work-vm>
References: <20200514064120.449050-1-david@gibson.dropbear.id.au>
 <20200514064120.449050-17-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514064120.449050-17-david@gibson.dropbear.id.au>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 12:05:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: brijesh.singh@amd.com, frankja@linux.ibm.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dave:
  You've got some screwy mail headers here, the qemu-devel@nongnu.-rg is
the best one anmd the pair@us.redhat.com is weird as well.

* David Gibson (david@gibson.dropbear.id.au) wrote:
> ---
>  accel/kvm/kvm-all.c                    |  4 +++-
>  include/exec/guest-memory-protection.h |  2 +-
>  target/i386/sev.c                      | 32 +++++++++++++-------------
>  3 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 5451728425..392ab02867 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2045,9 +2045,11 @@ static int kvm_init(MachineState *ms)
>      if (ms->gmpo) {
>          GuestMemoryProtectionClass *gmpc =
>              GUEST_MEMORY_PROTECTION_GET_CLASS(ms->gmpo);
> +        Error *local_err = NULL;
>  
> -        ret = gmpc->kvm_init(ms->gmpo);
> +        ret = gmpc->kvm_init(ms->gmpo, &local_err);
>          if (ret < 0) {
> +            error_report_err(local_err);
>              goto err;
>          }
>      }
> diff --git a/include/exec/guest-memory-protection.h b/include/exec/guest-memory-protection.h
> index 7d959b4910..2a88475136 100644
> --- a/include/exec/guest-memory-protection.h
> +++ b/include/exec/guest-memory-protection.h
> @@ -32,7 +32,7 @@ typedef struct GuestMemoryProtection GuestMemoryProtection;
>  typedef struct GuestMemoryProtectionClass {
>      InterfaceClass parent;
>  
> -    int (*kvm_init)(GuestMemoryProtection *);
> +    int (*kvm_init)(GuestMemoryProtection *, Error **);
>      int (*encrypt_data)(GuestMemoryProtection *, uint8_t *, uint64_t);
>  } GuestMemoryProtectionClass;
>  
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 2051fae0c1..82f16b2f3b 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -617,7 +617,7 @@ sev_vm_state_change(void *opaque, int running, RunState state)
>      }
>  }
>  
> -static int sev_kvm_init(GuestMemoryProtection *gmpo)
> +static int sev_kvm_init(GuestMemoryProtection *gmpo, Error **errp)
>  {
>      SevGuestState *sev = SEV_GUEST(gmpo);
>      char *devname;
> @@ -633,14 +633,14 @@ static int sev_kvm_init(GuestMemoryProtection *gmpo)
>      host_cbitpos = ebx & 0x3f;
>  
>      if (host_cbitpos != sev->cbitpos) {
> -        error_report("%s: cbitpos check failed, host '%d' requested '%d'",
> -                     __func__, host_cbitpos, sev->cbitpos);
> +        error_setg(errp, "%s: cbitpos check failed, host '%d' requested '%d'",
> +                   __func__, host_cbitpos, sev->cbitpos);
>          goto err;
>      }
>  
>      if (sev->reduced_phys_bits < 1) {
> -        error_report("%s: reduced_phys_bits check failed, it should be >=1,"
> -                     " requested '%d'", __func__, sev->reduced_phys_bits);
> +        error_setg(errp, "%s: reduced_phys_bits check failed, it should be >=1,"
> +                   " requested '%d'", __func__, sev->reduced_phys_bits);
>          goto err;
>      }
>  
> @@ -649,20 +649,20 @@ static int sev_kvm_init(GuestMemoryProtection *gmpo)
>      devname = object_property_get_str(OBJECT(sev), "sev-device", NULL);
>      sev->sev_fd = open(devname, O_RDWR);
>      if (sev->sev_fd < 0) {
> -        error_report("%s: Failed to open %s '%s'", __func__,
> -                     devname, strerror(errno));
> -    }
> -    g_free(devname);
> -    if (sev->sev_fd < 0) {
> +        g_free(devname);
> +        error_setg(errp, "%s: Failed to open %s '%s'", __func__,
> +                   devname, strerror(errno));
> +        g_free(devname);

You seem to have double free'd devname - would g_autofree work here?

other than that, looks OK to me.

Dave

>          goto err;
>      }
> +    g_free(devname);
>  
>      ret = sev_platform_ioctl(sev->sev_fd, SEV_PLATFORM_STATUS, &status,
>                               &fw_error);
>      if (ret) {
> -        error_report("%s: failed to get platform status ret=%d "
> -                     "fw_error='%d: %s'", __func__, ret, fw_error,
> -                     fw_error_to_str(fw_error));
> +        error_setg(errp, "%s: failed to get platform status ret=%d "
> +                   "fw_error='%d: %s'", __func__, ret, fw_error,
> +                   fw_error_to_str(fw_error));
>          goto err;
>      }
>      sev->build_id = status.build;
> @@ -672,14 +672,14 @@ static int sev_kvm_init(GuestMemoryProtection *gmpo)
>      trace_kvm_sev_init();
>      ret = sev_ioctl(sev->sev_fd, KVM_SEV_INIT, NULL, &fw_error);
>      if (ret) {
> -        error_report("%s: failed to initialize ret=%d fw_error=%d '%s'",
> -                     __func__, ret, fw_error, fw_error_to_str(fw_error));
> +        error_setg(errp, "%s: failed to initialize ret=%d fw_error=%d '%s'",
> +                   __func__, ret, fw_error, fw_error_to_str(fw_error));
>          goto err;
>      }
>  
>      ret = sev_launch_start(sev);
>      if (ret) {
> -        error_report("%s: failed to create encryption context", __func__);
> +        error_setg(errp, "%s: failed to create encryption context", __func__);
>          goto err;
>      }
>  
> -- 
> 2.26.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


