Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2720C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 11:16:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F4F82071A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 11:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMB6jPY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4F82071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl9a6-0001u5-Q3
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 07:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jl9ZA-0001AN-Ej
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 07:15:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32460
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jl9Z7-0000cZ-Sb
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 07:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592306139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pYSKsXL+pnx61xyecaq/GtOTccglyqOTBFHHIKn9p34=;
 b=DMB6jPY4IctuDkxdjD658rIQeakcr0lKszFpV9QnWhxEnESccYhWSMe77a0C0c35lEncmo
 0nYGX5/jKmRHuwUXGb93zUonq19mWkveAMcH0AdsN0SK2a01VGSSwUGGmvhFpKErTytoCj
 y38lWtjmtIxPGEDS142xwznCjhF0bEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-GIrWrF5nNIy0nLIXdanXcw-1; Tue, 16 Jun 2020 07:15:36 -0400
X-MC-Unique: GIrWrF5nNIy0nLIXdanXcw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FC1C100A8F0;
 Tue, 16 Jun 2020 11:15:34 +0000 (UTC)
Received: from gondolin (ovpn-112-222.ams2.redhat.com [10.36.112.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B87C66ED96;
 Tue, 16 Jun 2020 11:15:22 +0000 (UTC)
Date: Tue, 16 Jun 2020 13:15:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 02/21] vfio: Convert to ram_block_discard_disable()
Message-ID: <20200616131520.3eb92b8c.cohuck@redhat.com>
In-Reply-To: <20200610115419.51688-3-david@redhat.com>
References: <20200610115419.51688-1-david@redhat.com>
 <20200610115419.51688-3-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:46:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 10 Jun 2020 13:54:00 +0200
David Hildenbrand <david@redhat.com> wrote:

> VFIO is (except devices without a physical IOMMU or some mediated devices)
> incompatible with discarding of RAM. The kernel will pin basically all VM
> memory. Let's convert to ram_block_discard_disable(), which can now
> fail, in contrast to qemu_balloon_inhibit().
> 
> Leave "x-balloon-allowed" named as it is for now.
> 
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Pierre Morel <pmorel@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/vfio/ap.c                  | 10 +++----
>  hw/vfio/ccw.c                 | 11 ++++----
>  hw/vfio/common.c              | 53 +++++++++++++++++++----------------
>  hw/vfio/pci.c                 |  6 ++--
>  include/hw/vfio/vfio-common.h |  4 +--
>  5 files changed, 45 insertions(+), 39 deletions(-)

Did not have time to review in detail, but looks sane.

Acked-by: Cornelia Huck <cohuck@redhat.com>


