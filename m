Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5960DC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A6920678
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d8RnsC3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A6920678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFIoQ-0001q0-8S
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 11:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1kFInV-0001BC-Lc; Mon, 07 Sep 2020 11:11:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1kFInS-0004pJ-PC; Mon, 07 Sep 2020 11:11:08 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 087F3iDa065914; Mon, 7 Sep 2020 11:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=0uT1Wh3NsrCyhry/BDzdibfaWs2fQbiYxDW51MVpoaI=;
 b=d8RnsC3GWpqKB8EVHSVfUXP4kWt6nvv+tKT+MOXciV5luzqfH5tySxcB979+PetploWV
 6PCnByP7NaQJrpQb5giUYlo+8ggkZGjK5iz7YegXCrpBpEcd76thYGkRf4JHmIRzt26A
 emvqWGDFhUXmG7ZgAAQcxPQeKvMxNFoUwbB6If5gPqAjZJWG3diiFkWsfwJQCDvjAdRb
 VQtYVf2GoAVmbXS8yg2CEug4y8iCNy5UOuFMWcA70hEJjq769Htt0gkbOx25ncDGAHe6
 yGTzYf5PyGIrmdKUYZfWlErvxRc/EikV9NxVsP83Du3yCytztAmeNb7jWsQ825uplDIv 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33dq2d8apn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2020 11:10:56 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 087F4HAB067012;
 Mon, 7 Sep 2020 11:10:55 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33dq2d8ans-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2020 11:10:55 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 087F28JI014122;
 Mon, 7 Sep 2020 15:10:52 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma03ams.nl.ibm.com with ESMTP id 33c2a82h2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2020 15:10:52 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 087FAnZb36307338
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Sep 2020 15:10:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC76F42041;
 Mon,  7 Sep 2020 15:10:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D370542042;
 Mon,  7 Sep 2020 15:10:48 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.173.93])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  7 Sep 2020 15:10:48 +0000 (GMT)
Date: Mon, 7 Sep 2020 17:10:46 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [for-5.2 v4 09/10] host trust limitation: Alter virtio default
 properties for protected guests
Message-ID: <20200907171046.18211111.pasic@linux.ibm.com>
In-Reply-To: <20200724025744.69644-10-david@gibson.dropbear.id.au>
References: <20200724025744.69644-1-david@gibson.dropbear.id.au>
 <20200724025744.69644-10-david@gibson.dropbear.id.au>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-07_10:2020-09-07,
 2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1011 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009070149
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 11:11:03
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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
Cc: pair@us.ibm.com, Cornelia Huck <cohuck@redhat.com>, brijesh.singh@amd.com,
 frankja@linux.ibm.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, dgilbert@redhat.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-ppc@nongnu.org,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Bjoern Walk <bwalk@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>,
 mdroth@linux.vnet.ibm.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jul 2020 12:57:43 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> The default behaviour for virtio devices is not to use the platforms normal
> DMA paths, but instead to use the fact that it's running in a hypervisor
> to directly access guest memory.  That doesn't work if the guest's memory
> is protected from hypervisor access, such as with AMD's SEV or POWER's PEF.
> 
> So, if a host trust limitation mechanism is enabled, then apply the
> iommu_platform=on option so it will go through normal DMA mechanisms.
> Those will presumably have some way of marking memory as shared with the
> hypervisor or hardware so that DMA will work.

Sorry for being this late. I had to do some high priority debugging,
which made me drop everything else, and after that I had some vacation.

I have some questions about the bigger picture. The promised benefit of
this patch for users that invoke QEMU manually is relatively clear: it
alters the default value of some virtio properties, so that using the
defaults does not result in a bugous configuration.

This comes at a price. I used to think of device property default values
like this. If I don't specify it and I use the default machine, I will
effectively get the the default value of of the property (as reported by
qemu -device dev-name,?). If I use a compat machine, then I will get the
compatibility default value: i.e. the what is reported as the default
value, if I invoke the binary whose default machine is my compat machine.

With this patch, that reasoning is not valid any more. Did we do
something like this before, or is this the first time we introduce this
complication?

In any case, I suppose, this change needs a documentation update, which I
could not find in the series.

How are things supposed to pan out when QEMU is used with management
software?

I was told that libvirt's policy is to be explicit and not let QEMU use
defaults. But this policy does not seem to apply to iommu_platform -- at
least not on s390x. Why is this? Is this likely to change in the future?

Furthermore, the libvirt documentation is IMHO not that great when it
comes to iommu_platform. All I've found is 

"""
Virtio-related options


QEMU's virtio devices have some attributes related to the virtio transport under the driver element: The iommu attribute enables the use of emulated IOMMU by the device. 
"""

which:
* Is not explicit about the default, but suggests that default is off
  (because it needs to be enabled), which would reflect the current state
  of affairs (without this patch).
* Makes me wonder, to what extent does the libvirt concept correspond
  to the virtio semantics of _F_ACCESS_PLATFORM. I.e. we don't really
  do any IOMMU emulation with virtio-ccw.

I guess host trust limitation is something that is to be expressed in
libvirt, or? Do we have a design for that?

I was also reflecting on how does this patch compare to on/off/auto, but
this email is already too long, so decided keep my thoughts for myself
-- for now.

Regards,
Halil

> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/core/machine.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index b599b0ba65..2a723bf07b 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -28,6 +28,8 @@
>  #include "hw/mem/nvdimm.h"
>  #include "migration/vmstate.h"
>  #include "exec/host-trust-limitation.h"
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/virtio-pci.h"
>  
>  GlobalProperty hw_compat_5_0[] = {
>      { "virtio-balloon-device", "page-poison", "false" },
> @@ -1161,6 +1163,15 @@ void machine_run_board_init(MachineState *machine)
>           * areas.
>           */
>          machine_set_mem_merge(OBJECT(machine), false, &error_abort);
> +
> +        /*
> +         * Virtio devices can't count on directly accessing guest
> +         * memory, so they need iommu_platform=on to use normal DMA
> +         * mechanisms.  That requires disabling legacy virtio support
> +         * for virtio pci devices
> +         */
> +        object_register_sugar_prop(TYPE_VIRTIO_PCI, "disable-legacy", "on");
> +        object_register_sugar_prop(TYPE_VIRTIO_DEVICE, "iommu_platform", "on");
>      }
>  
>      machine_class->init(machine);




