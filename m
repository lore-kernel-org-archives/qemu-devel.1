Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F68C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7898A2224E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3o0PD+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7898A2224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUoPx-0004ze-Cu
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 05:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kUoPE-0003mr-NQ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kUoPD-0005cz-1k
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603187889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R43X6qCpAuMH5Tsvm7qepXXCO7Qm0/b1L68xjcNSEfs=;
 b=a3o0PD+GWXB4lNon0Yey+1go69tXhVuKmJNgWWypRu3eEQI9+9axmMjXJ4gFl12YcGxBDX
 AP4+vnShkcGgh9G5P678xnnxp3zGIu9R9VkrcfKpF41fgGEvPu7qs3cv8IBv8bJoy/Y/Td
 aq3en8aEMyc9nSw8QDp23bszXoXeJsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-tlZ1VV2INuqmXFTw82gABw-1; Tue, 20 Oct 2020 05:58:05 -0400
X-MC-Unique: tlZ1VV2INuqmXFTw82gABw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E575687507E;
 Tue, 20 Oct 2020 09:58:03 +0000 (UTC)
Received: from gondolin (ovpn-114-95.ams2.redhat.com [10.36.114.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66E9C5C88D;
 Tue, 20 Oct 2020 09:58:01 +0000 (UTC)
Date: Tue, 20 Oct 2020 11:57:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH] s390x/s390-virtio-ccw: Reset PCI devices during
 subsystem reset
Message-ID: <20201020115758.43f140a7.cohuck@redhat.com>
In-Reply-To: <1602767767-32713-1-git-send-email-mjrosato@linux.ibm.com>
References: <1602767767-32713-1-git-send-email-mjrosato@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 farman@linux.ibm.com, schnelle@linux.ibm.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 15 Oct 2020 09:16:07 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> Currently, a subsystem reset event leaves PCI devices enabled, causing
> issues post-reset in the guest (an example would be after a kexec).  These
> devices need to be reset during a subsystem reset, allowing them to be
> properly re-enabled afterwards.  Add the S390 PCI host bridge to the list
> of qdevs to be reset during subsystem reset.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index e52182f..2e90033 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -101,6 +101,7 @@ static const char *const reset_dev_types[] = {
>      "s390-sclp-event-facility",
>      "s390-flic",
>      "diag288",
> +    TYPE_S390_PCI_HOST_BRIDGE,
>  };
>  
>  static void subsystem_reset(void)

Thanks, applied (with cc:stable added.)


