Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B22FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 21:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F35206DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 21:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sX+NTzwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F35206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeQDJ-0005Oa-DN
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 17:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jejb@linux.ibm.com>)
 id 1jePdL-0004Yi-HC
 for qemu-devel@nongnu.org; Thu, 28 May 2020 17:00:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jejb@linux.ibm.com>)
 id 1jePdK-0004ZQ-2J
 for qemu-devel@nongnu.org; Thu, 28 May 2020 17:00:11 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04SKbCXc078489
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 17:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=+dW+vPE30EIX2bgUN+dNUE4nh8+kdwYv8SIHTjjAi/E=;
 b=sX+NTzweWXRoJa/h3G53/Az2HLEb/aeLH6/lwefnXmUcpBFKgeswaTaHFrR3+kBckUnm
 np6EdDlhaq7RuWvmgqQ8qCM9CjNmw2pdxgkWo5ze2MNXmwfnC0LiXJ9XQyAg7S6FVJAz
 8h3UqIjA4ab3gtjCRocCjPAe3ELqbeYqvceXbVACtJr3ObtmrwnjCbKYKYS2D6iVGM/t
 QyUSS/qQ9coylnPGTrZgaea3lKHvTC/tWh4O0LrwKK/VFMaeqLBDjCnV0nS/KEnEQG4u
 6LaUmpHPLnjE7YLqtdfEp8XFvFPYTe0jvhnfhsx6yPfGDRWv9j/RsQuYMytOiiu0YT7N QA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 319shjr05u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 17:00:06 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04SKf8ts031292
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 21:00:05 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma02dal.us.ibm.com with ESMTP id 316ufb9ef5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 21:00:05 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04SL02Vx22872352
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 May 2020 21:00:02 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C59A578063;
 Thu, 28 May 2020 21:00:03 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AD207805E;
 Thu, 28 May 2020 21:00:02 +0000 (GMT)
Received: from [153.66.254.194] (unknown [9.85.161.209])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 28 May 2020 21:00:02 +0000 (GMT)
Message-ID: <1590699601.3449.48.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] sev: add sev-inject-launch-secret
From: James Bottomley <jejb@linux.ibm.com>
To: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Date: Thu, 28 May 2020 14:00:01 -0700
In-Reply-To: <20200528205114.42078-2-tobin@linux.vnet.ibm.com>
References: <20200528205114.42078-1-tobin@linux.vnet.ibm.com>
 <20200528205114.42078-2-tobin@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-28_07:2020-05-28,
 2020-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 cotscore=-2147483648 mlxscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1011 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280132
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jejb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 16:51:19
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 28 May 2020 17:35:50 -0400
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
Reply-To: jejb@linux.ibm.com
Cc: tobin@ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-05-28 at 16:51 -0400, Tobin Feldman-Fitzthum wrote:
> --- a/qapi/misc-target.json
> +++ b/qapi/misc-target.json
> @@ -200,6 +200,26 @@
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
> +        GPA provided here will be ignored if guest ROM specifies 
> +        the a launch secret GPA.

Shouldn't we eliminate the gpa argument to this now the gpa is
extracted from OVMF?  You add it here but don't take it out in the next
patch.

> +# Since: 5.0.0
> +#
> +##
> +{ 'command': 'sev-inject-launch-secret',
> +  'data': { 'packet_hdr': 'str', 'secret': 'str', 'gpa': 'uint64' },

Java (i.e. Json) people hate underscores and abbreviations.  I bet
they'll want this to be 'packet-header'

> +  'if': 'defined(TARGET_I386)' }
> +
>  ##
>  # @dump-skeys:
>  #
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 27ebfa3ad2..5c2b7d2c17 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -736,3 +736,11 @@ SevCapability *qmp_query_sev_capabilities(Error
> **errp)
>  
>      return data;
>  }
> +
> +void qmp_sev_inject_launch_secret(const char *packet_hdr,
> +                                  const char *secret, uint64_t gpa,
> +                                  Error **errp)
> +{
> +    if (sev_inject_launch_secret(packet_hdr,secret,gpa) != 0)
> +      error_setg(errp, "SEV inject secret failed");
> +}
> diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
> index e5ee13309c..2b8c5f1f53 100644
> --- a/target/i386/sev-stub.c
> +++ b/target/i386/sev-stub.c
> @@ -48,3 +48,8 @@ SevCapability *sev_get_capabilities(void)
>  {
>      return NULL;
>  }
> +int sev_inject_launch_secret(const char *hdr, const char *secret,
> +		                             uint64_t gpa)
> +{
> +	    return 1;
> +}
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 846018a12d..774e47d9d1 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -28,6 +28,7 @@
>  #include "sysemu/runstate.h"
>  #include "trace.h"
>  #include "migration/blocker.h"
> +#include "exec/address-spaces.h"
>  
>  #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
>  #define DEFAULT_SEV_DEVICE      "/dev/sev"
> @@ -743,6 +744,88 @@ sev_encrypt_data(void *handle, uint8_t *ptr,
> uint64_t len)
>      return 0;
>  }
>  
> +
> +static void *
> +gpa2hva(hwaddr addr, uint64_t size)
> +{
> +    MemoryRegionSection mrs =
> memory_region_find(get_system_memory(),
> +                                                 addr, size);
> +
> +    if (!mrs.mr) {
> +        error_report("No memory is mapped at address 0x%"
> HWADDR_PRIx, addr);
> +        return NULL;
> +    }
> +
> +    if (!memory_region_is_ram(mrs.mr) &&
> !memory_region_is_romd(mrs.mr)) {
> +        error_report("Memory at address 0x%" HWADDR_PRIx "is not
> RAM", addr);
> +        memory_region_unref(mrs.mr);
> +        return NULL;
> +    }

We can still check this, but it should be like an assertion failure. 
Since the GPA is selected by the OVMF build there should be no way it
can't be mapped into the host.

[...]
> --- a/tests/qtest/qmp-cmd-test.c
> +++ b/tests/qtest/qmp-cmd-test.c
> @@ -93,10 +93,10 @@ static bool query_is_blacklisted(const char *cmd)
>          /* Success depends on target-specific build configuration:
> */
>          "query-pci",              /* CONFIG_PCI */
>          /* Success depends on launching SEV guest */
> -        "query-sev-launch-measure",
> +        // "query-sev-launch-measure",
>          /* Success depends on Host or Hypervisor SEV support */
> -        "query-sev",
> -        "query-sev-capabilities",
> +        // "query-sev",
> +        // "query-sev-capabilities",

We're eliminating existing tests ... is that just a stray hunk that you
forgot to remove?

James


