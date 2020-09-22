Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADA9C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9908E2395C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4RZi4W7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9908E2395C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfMw-000633-FE
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kKfMG-0005aB-It
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kKfME-0004TR-Id
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600769829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSocmPHYqjEda5mFL2M3W+XcIJKAiTKuDLlDJf3zPUQ=;
 b=a4RZi4W71jCt9kGOzQvFBIUY+itq301hvs20311YfNU97Z8vUjs7pVmq4v/4rvHpZUtyRi
 mmnQmAF6mE5Rjr6G2pkZ/W+6o1pPo50BodMOXCykeUCukAdxE2D7GRwCqzkguVj8HPpQqf
 tAMARHLXwNRg2uW0hpai8aC/b2iiJ9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-M3UaLETcNgSPFmAbIN35Rg-1; Tue, 22 Sep 2020 06:17:08 -0400
X-MC-Unique: M3UaLETcNgSPFmAbIN35Rg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C8491868410;
 Tue, 22 Sep 2020 10:17:05 +0000 (UTC)
Received: from gondolin (ovpn-112-114.ams2.redhat.com [10.36.112.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E5305DE19;
 Tue, 22 Sep 2020 10:16:52 +0000 (UTC)
Date: Tue, 22 Sep 2020 12:16:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v4 5/5] s390x/pci: Honor DMA limits set by vfio
Message-ID: <20200922121650.1bdd0ea6.cohuck@redhat.com>
In-Reply-To: <1600352445-21110-6-git-send-email-mjrosato@linux.ibm.com>
References: <1600352445-21110-1-git-send-email-mjrosato@linux.ibm.com>
 <1600352445-21110-6-git-send-email-mjrosato@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
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
Cc: thuth@redhat.com, kvm@vger.kernel.org, pmorel@linux.ibm.com,
 david@redhat.com, schnelle@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 alex.williamson@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Sep 2020 10:20:45 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> When an s390 guest is using lazy unmapping, it can result in a very
> large number of oustanding DMA requests, far beyond the default
> limit configured for vfio.  Let's track DMA usage similar to vfio
> in the host, and trigger the guest to flush their DMA mappings
> before vfio runs out.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c  | 16 +++++++++++-----
>  hw/s390x/s390-pci-bus.h  |  9 +++++++++
>  hw/s390x/s390-pci-inst.c | 45 +++++++++++++++++++++++++++++++++++++++------
>  hw/s390x/s390-pci-inst.h |  3 +++
>  hw/s390x/s390-pci-vfio.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  hw/s390x/s390-pci-vfio.h |  5 +++++
>  6 files changed, 109 insertions(+), 11 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


