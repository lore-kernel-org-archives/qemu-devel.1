Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D025CC4346E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49080216C4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqncN1si"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49080216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKRKi-00080M-72
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 15:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kKRIe-0006dG-Do
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:16:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kKRIb-00043A-IZ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600715786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lxtE/ggVs0zcsL6PYHM6/oBFd/YGVen/WjGfaaJf/Ww=;
 b=YqncN1si0Z5qRAjtZCDt2yxduGROR4tmAuCwGAUeiScQzwKOmTe+REoQIE3ecQGge3/jOn
 2UzCgmOhRiShy2E+RRY3ahYTNKOlNA+ThMTKPqR+emNRS73/ecyMz5tFJDCagMb+sbUPgc
 hdwHHpPSbAL8PQ7Qj0kKwOME5STP7iQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-m6Y7Gm70O8WqFqjhV-p-WQ-1; Mon, 21 Sep 2020 15:16:23 -0400
X-MC-Unique: m6Y7Gm70O8WqFqjhV-p-WQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEAA7873079;
 Mon, 21 Sep 2020 19:16:21 +0000 (UTC)
Received: from work-vm (ovpn-114-207.ams2.redhat.com [10.36.114.207])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 911F83782;
 Mon, 21 Sep 2020 19:16:19 +0000 (UTC)
Date: Mon, 21 Sep 2020 20:16:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] SEV: QMP support for Inject-Launch-Secret
Message-ID: <20200921190800.GA32491@work-vm>
References: <20200706215451.59179-1-tobin@linux.vnet.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200706215451.59179-1-tobin@linux.vnet.ibm.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, jejb@linux.ibm.com,
 tobin@ibm.com, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Tobin Feldman-Fitzthum (tobin@linux.vnet.ibm.com) wrote:
> AMD SEV allows a guest owner to inject a secret blob
> into the memory of a virtual machine. The secret is
> encrypted with the SEV Transport Encryption Key and
> integrity is guaranteed with the Transport Integrity
> Key. Although QEMU faciliates the injection of the
> launch secret, it cannot access the secret.
> 
> Signed-off-by: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>

Hi Tobin,
  Did the ovmf stuff for agreeing the GUID for automating this ever
happen?

Dave

> ---
>  include/monitor/monitor.h |  3 ++
>  include/sysemu/sev.h      |  2 ++
>  monitor/misc.c            |  8 ++---
>  qapi/misc-target.json     | 18 +++++++++++
>  target/i386/monitor.c     |  9 ++++++
>  target/i386/sev-stub.c    |  5 +++
>  target/i386/sev.c         | 66 +++++++++++++++++++++++++++++++++++++++
>  target/i386/trace-events  |  1 +
>  8 files changed, 108 insertions(+), 4 deletions(-)
> 
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 1018d754a6..bf049c5b00 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -4,6 +4,7 @@
>  #include "block/block.h"
>  #include "qapi/qapi-types-misc.h"
>  #include "qemu/readline.h"
> +#include "include/exec/hwaddr.h"
>  
>  extern __thread Monitor *cur_mon;
>  typedef struct MonitorHMP MonitorHMP;
> @@ -36,6 +37,8 @@ void monitor_flush(Monitor *mon);
>  int monitor_set_cpu(int cpu_index);
>  int monitor_get_cpu_index(void);
>  
> +void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp);
> +
>  void monitor_read_command(MonitorHMP *mon, int show_prompt);
>  int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
>                            void *opaque);
> diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
> index 98c1ec8d38..b279b293e8 100644
> --- a/include/sysemu/sev.h
> +++ b/include/sysemu/sev.h
> @@ -18,4 +18,6 @@
>  
>  void *sev_guest_init(const char *id);
>  int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
> +int sev_inject_launch_secret(const char *hdr, const char *secret,
> +                             uint64_t gpa);
>  #endif
> diff --git a/monitor/misc.c b/monitor/misc.c
> index 89bb970b00..b9ec8ba410 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -674,10 +674,10 @@ static void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
>      memory_dump(mon, count, format, size, addr, 1);
>  }
>  
> -static void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, Error **errp)
> +void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
>  {
>      MemoryRegionSection mrs = memory_region_find(get_system_memory(),
> -                                                 addr, 1);
> +                                                 addr, size);
>  
>      if (!mrs.mr) {
>          error_setg(errp, "No memory is mapped at address 0x%" HWADDR_PRIx, addr);
> @@ -701,7 +701,7 @@ static void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
>      MemoryRegion *mr = NULL;
>      void *ptr;
>  
> -    ptr = gpa2hva(&mr, addr, &local_err);
> +    ptr = gpa2hva(&mr, addr, 1, &local_err);
>      if (local_err) {
>          error_report_err(local_err);
>          return;
> @@ -777,7 +777,7 @@ static void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
>      void *ptr;
>      uint64_t physaddr;
>  
> -    ptr = gpa2hva(&mr, addr, &local_err);
> +    ptr = gpa2hva(&mr, addr, 1, &local_err);
>      if (local_err) {
>          error_report_err(local_err);
>          return;
> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
> index dee3b45930..d145f916b3 100644
> --- a/qapi/misc-target.json
> +++ b/qapi/misc-target.json
> @@ -200,6 +200,24 @@
>  { 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
>    'if': 'defined(TARGET_I386)' }
>  
> +##
> +# @sev-inject-launch-secret:
> +#
> +# This command injects a secret blob into memory of SEV guest.
> +#
> +# @packet-header: the launch secret packet header encoded in base64
> +#
> +# @secret: the launch secret data to be injected encoded in base64
> +#
> +# @gpa: the guest physical address where secret will be injected.
> +#
> +# Since: 5.1
> +#
> +##
> +{ 'command': 'sev-inject-launch-secret',
> +  'data': { 'packet-header': 'str', 'secret': 'str', 'gpa': 'uint64' },
> +  'if': 'defined(TARGET_I386)' }
> +
>  ##
>  # @dump-skeys:
>  #
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 27ebfa3ad2..42bcfe6dc0 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -736,3 +736,12 @@ SevCapability *qmp_query_sev_capabilities(Error **errp)
>  
>      return data;
>  }
> +
> +void qmp_sev_inject_launch_secret(const char *packet_hdr,
> +                                  const char *secret, uint64_t gpa,
> +                                  Error **errp)
> +{
> +    if (sev_inject_launch_secret(packet_hdr, secret, gpa) != 0) {
> +        error_setg(errp, "SEV inject secret failed");
> +    }
> +}
> diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
> index e5ee13309c..fed4588185 100644
> --- a/target/i386/sev-stub.c
> +++ b/target/i386/sev-stub.c
> @@ -48,3 +48,8 @@ SevCapability *sev_get_capabilities(void)
>  {
>      return NULL;
>  }
> +int sev_inject_launch_secret(const char *hdr, const char *secret,
> +                             uint64_t gpa)
> +{
> +    return 1;
> +}
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index d273174ad3..cbeb8f2e02 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -28,6 +28,8 @@
>  #include "sysemu/runstate.h"
>  #include "trace.h"
>  #include "migration/blocker.h"
> +#include "exec/address-spaces.h"
> +#include "monitor/monitor.h"
>  
>  #define TYPE_SEV_GUEST "sev-guest"
>  #define SEV_GUEST(obj)                                          \
> @@ -769,6 +771,70 @@ sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
>      return 0;
>  }
>  
> +int sev_inject_launch_secret(const char *packet_hdr,
> +                             const char *secret, uint64_t gpa)
> +{
> +    struct kvm_sev_launch_secret input;
> +    guchar *data = NULL, *hdr = NULL;
> +    int error, ret = 1;
> +    void *hva;
> +    gsize hdr_sz = 0, data_sz = 0;
> +    Error *local_err = NULL;
> +    MemoryRegion *mr = NULL;
> +
> +    /* secret can be inject only in this state */
> +    if (!sev_check_state(sev_guest, SEV_STATE_LAUNCH_SECRET)) {
> +        error_report("SEV: Not in correct state. (LSECRET) %x",
> +                     sev_guest->state);
> +        return 1;
> +    }
> +
> +    hdr = g_base64_decode(packet_hdr, &hdr_sz);
> +    if (!hdr || !hdr_sz) {
> +        error_report("SEV: Failed to decode sequence header");
> +        return 1;
> +    }
> +
> +    data = g_base64_decode(secret, &data_sz);
> +    if (!data || !data_sz) {
> +        error_report("SEV: Failed to decode data");
> +        goto err;
> +    }
> +
> +    hva = gpa2hva(&mr, gpa, data_sz, &local_err);
> +    if (!hva) {
> +        error_report("SEV: Failed to calculate guest address.");
> +        goto err;
> +    }
> +
> +    input.hdr_uaddr = (uint64_t)(unsigned long)hdr;
> +    input.hdr_len = hdr_sz;
> +
> +    input.trans_uaddr = (uint64_t)(unsigned long)data;
> +    input.trans_len = data_sz;
> +
> +    input.guest_uaddr = (uint64_t)(unsigned long)hva;
> +    input.guest_len = data_sz;
> +
> +    trace_kvm_sev_launch_secret(gpa, input.guest_uaddr,
> +                                input.trans_uaddr, input.trans_len);
> +
> +    ret = sev_ioctl(sev_guest->sev_fd, KVM_SEV_LAUNCH_SECRET,
> +                    &input, &error);
> +    if (ret) {
> +        error_report("SEV: failed to inject secret ret=%d fw_error=%d '%s'",
> +                     ret, error, fw_error_to_str(error));
> +        goto err;
> +    }
> +
> +    ret = 0;
> +
> +err:
> +    g_free(data);
> +    g_free(hdr);
> +    return ret;
> +}
> +
>  static void
>  sev_register_types(void)
>  {
> diff --git a/target/i386/trace-events b/target/i386/trace-events
> index 789c700d4a..9f299e94a2 100644
> --- a/target/i386/trace-events
> +++ b/target/i386/trace-events
> @@ -15,3 +15,4 @@ kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session
>  kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRIu64
>  kvm_sev_launch_measurement(const char *value) "data %s"
>  kvm_sev_launch_finish(void) ""
> +kvm_sev_launch_secret(uint64_t hpa, uint64_t hva, uint64_t secret, int len) "hpa 0x%" PRIx64 " hva 0x%" PRIx64 " data 0x%" PRIx64 " len %d"
> -- 
> 2.20.1 (Apple Git-117)
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


