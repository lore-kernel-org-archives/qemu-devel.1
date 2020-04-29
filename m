Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E266C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CABD52087E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDgbKfkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABD52087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTmcv-0001RP-1p
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 09:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jTmXr-0004vI-8k
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jTmXp-0002Lx-FP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:14:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50643
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jTmXo-0002Ks-TX
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588166070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VlZF6jqW52212bXlhySvhYA7f00ExhGI5CA/NLbPDzI=;
 b=SDgbKfkqptP+RdIG92gqkJ0yokBqES071Ddu7BiEzbnUcr6U1fNZaf4NLUPQuupWloV6QJ
 iy05VZjGWGYQUHeqlYccEFXtbHE59QXH9mUJWXDCKL3QPqDNO7p+GY62rGFIZ4RT/eX75a
 1jBPI075wYeJMeX0HBZ6sfDh3q/Zulo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-hyBGrcyOOD6pO1h4ivTdrQ-1; Wed, 29 Apr 2020 09:14:28 -0400
X-MC-Unique: hyBGrcyOOD6pO1h4ivTdrQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A27E9872FF2;
 Wed, 29 Apr 2020 13:14:27 +0000 (UTC)
Received: from gondolin (ovpn-112-87.ams2.redhat.com [10.36.112.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2E3960C10;
 Wed, 29 Apr 2020 13:14:23 +0000 (UTC)
Date: Wed, 29 Apr 2020 15:01:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v12] s390x: protvirt: Support unpack facility
Message-ID: <20200429150129.5ce6e8f2.cohuck@redhat.com>
In-Reply-To: <20200323083606.24520-1-frankja@linux.ibm.com>
References: <20200319131921.2367-4-frankja@linux.ibm.com>
 <20200323083606.24520-1-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Mar 2020 04:36:06 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> The unpack facility provides the means to setup a protected guest. A
> protected guest cannot be introspected by the hypervisor or any
> user/administrator of the machine it is running on.
> 
> Protected guests are encrypted at rest and need a special boot
> mechanism via diag308 subcode 8 and 10.
> 
> Code 8 sets the PV specific IPLB which is retained separately from
> those set via code 5.
> 
> Code 10 is used to unpack the VM into protected memory, verify its
> integrity and start it.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Co-developed-by: Christian Borntraeger <borntraeger@de.ibm.com> [Changes
> to machine]
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  MAINTAINERS                         |   2 +
>  hw/s390x/Makefile.objs              |   1 +
>  hw/s390x/ipl.c                      |  59 +++++++++++++-
>  hw/s390x/ipl.h                      |  91 ++++++++++++++++++++-
>  hw/s390x/pv.c                       |  98 +++++++++++++++++++++++
>  hw/s390x/s390-virtio-ccw.c          | 119 +++++++++++++++++++++++++++-
>  include/hw/s390x/pv.h               |  55 +++++++++++++
>  include/hw/s390x/s390-virtio-ccw.h  |   1 +
>  target/s390x/cpu.c                  |   1 +
>  target/s390x/cpu_features_def.inc.h |   1 +
>  target/s390x/diag.c                 |  39 ++++++++-
>  target/s390x/kvm-stub.c             |   5 ++
>  target/s390x/kvm.c                  |   5 ++
>  target/s390x/kvm_s390x.h            |   1 +
>  14 files changed, 468 insertions(+), 10 deletions(-)
>  create mode 100644 hw/s390x/pv.c
>  create mode 100644 include/hw/s390x/pv.h

(...)

> diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
> new file mode 100644
> index 0000000000000000..8cf5cd2c9bcd48b0
> --- /dev/null
> +++ b/hw/s390x/pv.c

(...)

> +int s390_pv_set_sec_parms(uint64_t origin, uint64_t length)
> +{
> +    struct kvm_s390_pv_sec_parm args = {
> +        .origin = origin,
> +        .length = length,
> +    };
> +
> +    return s390_pv_cmd(KVM_PV_VM_SET_SEC_PARMS, &args);
> +}
> +
> +/*
> + * Called for each component in the SE type IPL parameter block 0.
> + */
> +int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak)
> +{
> +    struct kvm_s390_pv_unp args = {
> +        .addr = addr,
> +        .size = size,
> +        .tweak = tweak,
> +    };
> +
> +    return s390_pv_cmd(KVM_PV_VM_UNPACK, &args);
> +}
> +
> +void s390_pv_perf_clear_reset(void)
> +{
> +    s390_pv_cmd_exit(KVM_PV_VM_PREP_RESET, NULL);
> +}
> +
> +int s390_pv_verify(void)
> +{
> +    return s390_pv_cmd(KVM_PV_VM_VERIFY, NULL);
> +}
> +
> +void s390_pv_unshare(void)
> +{
> +    s390_pv_cmd_exit(KVM_PV_VM_UNSHARE_ALL, NULL);
> +}

Note that the dummy headers update in this series still had the
KVM_PV_VM_ defines, while the real headers update pulled in the KVM_PV_
defines that went upstream. I fixed this up in s390-next.

(...)


