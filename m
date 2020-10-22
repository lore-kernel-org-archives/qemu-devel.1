Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384D6C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B01F2245F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y40rlV+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B01F2245F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVTJM-0007Bc-Bl
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 01:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.ibm.com>)
 id 1kVTHu-0006kd-EF
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:37:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10402)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.ibm.com>)
 id 1kVTHr-0004jT-Qd
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:37:21 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09M5Z3S2083686; Thu, 22 Oct 2020 01:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=mime-version : date :
 from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=qfEpOuGbrJ4NRrgeNcx0sCQHjueUMK4d9zrZeUl6nCg=;
 b=Y40rlV+dxW01n01TkMpy0I6ez3eyjvCO5RJyYwvk39NKGSfhm36Q4elzjmjxYhY6t94K
 kM926Hb679xp/wcQhdct1jLgPo0i3fdX4VLLvrz3AX7BwmLIdZX0bF604UmzOSCyeNWx
 FjZj3L1i/IOJH+JPtUXFubWDFfXpSYoKz0hD51XbA3SSOlxwbWufVI1kGp/uGW3aTDVo
 qlRfmm9/BBugY9t4yvKjmoPsskSPq4Op3fheOIvjgdRlfjafHkSaJWOSElE9vpYWWEmz
 jN/3vrjetbauF5Sjv6w4rfTg8cw+tBA2Dx9mpIjR3u0EZPVip0tfqixw1kK/BYKxm8US uw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34b0ekcfe9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2020 01:37:16 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09M5ZEOl083936;
 Thu, 22 Oct 2020 01:37:15 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34b0ekcfe1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2020 01:37:15 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09M5RNsG018867;
 Thu, 22 Oct 2020 05:37:15 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma04wdc.us.ibm.com with ESMTP id 347r89dmxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2020 05:37:15 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09M5bET126870106
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Oct 2020 05:37:14 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C87DEAC05F;
 Thu, 22 Oct 2020 05:37:14 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCBBAAC060;
 Thu, 22 Oct 2020 05:37:13 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 22 Oct 2020 05:37:13 +0000 (GMT)
MIME-Version: 1.0
Date: Thu, 22 Oct 2020 01:37:13 -0400
From: Tobin Feldman-Fitzthum <tobin@linux.ibm.com>
To: tobin@linux.ibm.com
Subject: Re: [PATCH v6] sev: add sev-inject-launch-secret
In-Reply-To: <20201022041630.33690-1-tobin@linux.ibm.com>
References: <20201022041630.33690-1-tobin@linux.ibm.com>
Message-ID: <ad82ca2244ec0c5d00fb0346da8c289b@linux.vnet.ibm.com>
X-Sender: tobin@linux.ibm.com
User-Agent: Roundcube Webmail/1.0.1
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.737
 definitions=2020-10-22_01:2020-10-20,
 2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=1 adultscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220033
Received-SPF: pass client-ip=148.163.158.5; envelope-from=tobin@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 00:17:13
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, ehabkost@redhat.com,
 jejb@linux.ibm.com, tobin@ibm.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 berrange@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-10-22 00:16, tobin@linux.ibm.com wrote:
> From: Tobin Feldman-Fitzthum <tobin@linux.ibm.com>
> 
> AMD SEV allows a guest owner to inject a secret blob
> into the memory of a virtual machine. The secret is
> encrypted with the SEV Transport Encryption Key and
> integrity is guaranteed with the Transport Integrity
> Key. Although QEMU facilitates the injection of the
> launch secret, it cannot access the secret.
> 
> Signed-off-by: Tobin Feldman-Fitzthum <tobin@linux.ibm.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  include/monitor/monitor.h |  3 ++
>  include/sysemu/sev.h      |  2 ++
>  monitor/misc.c            | 13 +++++---
>  qapi/misc-target.json     | 18 +++++++++++
>  target/i386/monitor.c     |  7 +++++
>  target/i386/sev-stub.c    |  5 +++
>  target/i386/sev.c         | 65 +++++++++++++++++++++++++++++++++++++++
>  target/i386/trace-events  |  1 +
>  8 files changed, 110 insertions(+), 4 deletions(-)
> 
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 348bfad3d5..af3887bb71 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -4,6 +4,7 @@
>  #include "block/block.h"
>  #include "qapi/qapi-types-misc.h"
>  #include "qemu/readline.h"
> +#include "include/exec/hwaddr.h"
> 
>  typedef struct MonitorHMP MonitorHMP;
>  typedef struct MonitorOptions MonitorOptions;
> @@ -37,6 +38,8 @@ void monitor_flush(Monitor *mon);
>  int monitor_set_cpu(Monitor *mon, int cpu_index);
>  int monitor_get_cpu_index(Monitor *mon);
> 
> +void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error 
> **errp);
> +
>  void monitor_read_command(MonitorHMP *mon, int show_prompt);
>  int monitor_read_password(MonitorHMP *mon, ReadLineFunc 
> *readline_func,
>                            void *opaque);
> diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
> index 98c1ec8d38..7ab6e3e31d 100644
> --- a/include/sysemu/sev.h
> +++ b/include/sysemu/sev.h
> @@ -18,4 +18,6 @@
> 
>  void *sev_guest_init(const char *id);
>  int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
> +int sev_inject_launch_secret(const char *hdr, const char *secret,
> +                             uint64_t gpa, Error **errp);
>  #endif
> diff --git a/monitor/misc.c b/monitor/misc.c
> index 4a859fb24a..dd148be5da 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -667,10 +667,10 @@ static void hmp_physical_memory_dump(Monitor
> *mon, const QDict *qdict)
>      memory_dump(mon, count, format, size, addr, 1);
>  }
> 
> -static void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, Error **errp)
> +void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error 
> **errp)
>  {
>      MemoryRegionSection mrs = memory_region_find(get_system_memory(),
> -                                                 addr, 1);
> +                                                 addr, size);
> 
>      if (!mrs.mr) {
>          error_setg(errp, "No memory is mapped at address 0x%"
> HWADDR_PRIx, addr);
> @@ -683,6 +683,11 @@ static void *gpa2hva(MemoryRegion **p_mr, hwaddr
> addr, Error **errp)
>          return NULL;
>      }
> 
> +    if (mrs.size < size) {
> +        error_setg(errp, "Size of memory region at 0x%" HWADDR_PRIx
> +                   " exceeded.", addr);
> +    }
> +

Forgot to return :( Will update.

>      *p_mr = mrs.mr;
>      return qemu_map_ram_ptr(mrs.mr->ram_block, 
> mrs.offset_within_region);
>  }
> @@ -694,7 +699,7 @@ static void hmp_gpa2hva(Monitor *mon, const QDict 
> *qdict)
>      MemoryRegion *mr = NULL;
>      void *ptr;
> 
> -    ptr = gpa2hva(&mr, addr, &local_err);
> +    ptr = gpa2hva(&mr, addr, 1, &local_err);
>      if (local_err) {
>          error_report_err(local_err);
>          return;
> @@ -770,7 +775,7 @@ static void hmp_gpa2hpa(Monitor *mon, const QDict 
> *qdict)
>      void *ptr;
>      uint64_t physaddr;
> 
> -    ptr = gpa2hva(&mr, addr, &local_err);
> +    ptr = gpa2hva(&mr, addr, 1, &local_err);
>      if (local_err) {
>          error_report_err(local_err);
>          return;
> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
> index 1e561fa97b..4486a543ae 100644
> --- a/qapi/misc-target.json
> +++ b/qapi/misc-target.json
> @@ -201,6 +201,24 @@
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
> +# Since: 5.2
> +#
> +##
> +{ 'command': 'sev-inject-launch-secret',
> +  'data': { 'packet-header': 'str', 'secret': 'str', 'gpa': 'uint64' 
> },
> +  'if': 'defined(TARGET_I386)' }
> +
>  ##
>  # @dump-skeys:
>  #
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 7abae3c8df..f9d4951465 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -728,3 +728,10 @@ SevCapability *qmp_query_sev_capabilities(Error 
> **errp)
>  {
>      return sev_get_capabilities(errp);
>  }
> +
> +void qmp_sev_inject_launch_secret(const char *packet_hdr,
> +                                  const char *secret, uint64_t gpa,
> +                                  Error **errp)
> +{
> +    sev_inject_launch_secret(packet_hdr, secret, gpa, errp);
> +}
> diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
> index 88e3f39a1e..c1fecc2101 100644
> --- a/target/i386/sev-stub.c
> +++ b/target/i386/sev-stub.c
> @@ -49,3 +49,8 @@ SevCapability *sev_get_capabilities(Error **errp)
>      error_setg(errp, "SEV is not available in this QEMU");
>      return NULL;
>  }
> +int sev_inject_launch_secret(const char *hdr, const char *secret,
> +                             uint64_t gpa, Error **errp)
> +{
> +    return 1;
> +}
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 93c4d60b82..1546606811 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -29,6 +29,8 @@
>  #include "trace.h"
>  #include "migration/blocker.h"
>  #include "qom/object.h"
> +#include "exec/address-spaces.h"
> +#include "monitor/monitor.h"
> 
>  #define TYPE_SEV_GUEST "sev-guest"
>  OBJECT_DECLARE_SIMPLE_TYPE(SevGuestState, SEV_GUEST)
> @@ -785,6 +787,69 @@ sev_encrypt_data(void *handle, uint8_t *ptr, 
> uint64_t len)
>      return 0;
>  }
> 
> +int sev_inject_launch_secret(const char *packet_hdr, const char 
> *secret,
> +                             uint64_t gpa, Error **errp)
> +{
> +    struct kvm_sev_launch_secret input;
> +    g_autofree guchar *data = NULL, *hdr = NULL;
> +    int error, ret = 1;
> +    void *hva;
> +    gsize hdr_sz = 0, data_sz = 0;
> +    MemoryRegion *mr = NULL;
> +
> +    if (!sev_guest) {
> +        error_setg(errp, "SEV: SEV not enabled.");
> +        return 1;
> +    }
> +
> +    /* secret can be injected only in this state */
> +    if (!sev_check_state(sev_guest, SEV_STATE_LAUNCH_SECRET)) {
> +        error_setg(errp, "SEV: Not in correct state. (LSECRET) %x",
> +                     sev_guest->state);
> +        return 1;
> +    }
> +
> +    hdr = g_base64_decode(packet_hdr, &hdr_sz);
> +    if (!hdr || !hdr_sz) {
> +        error_setg(errp, "SEV: Failed to decode sequence header");
> +        return 1;
> +    }
> +
> +    data = g_base64_decode(secret, &data_sz);
> +    if (!data || !data_sz) {
> +        error_setg(errp, "SEV: Failed to decode data");
> +        return 1;
> +    }
> +
> +    hva = gpa2hva(&mr, gpa, data_sz, errp);
> +    if (!hva) {
> +        error_prepend(errp, "SEV: Failed to calculate guest address: 
> ");
> +        return 1;
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
> +        error_setg(errp, "SEV: failed to inject secret ret=%d
> fw_error=%d '%s'",
> +                     ret, error, fw_error_to_str(error));
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
>  static void
>  sev_register_types(void)
>  {
> diff --git a/target/i386/trace-events b/target/i386/trace-events
> index 789c700d4a..9f299e94a2 100644
> --- a/target/i386/trace-events
> +++ b/target/i386/trace-events
> @@ -15,3 +15,4 @@ kvm_sev_launch_start(int policy, void *session, void
> *pdh) "policy 0x%x session
>  kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" 
> PRIu64
>  kvm_sev_launch_measurement(const char *value) "data %s"
>  kvm_sev_launch_finish(void) ""
> +kvm_sev_launch_secret(uint64_t hpa, uint64_t hva, uint64_t secret,
> int len) "hpa 0x%" PRIx64 " hva 0x%" PRIx64 " data 0x%" PRIx64 " len
> %d"

