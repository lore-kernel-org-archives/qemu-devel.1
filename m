Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DB0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B330221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1dPb9L0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B330221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3eCs-0001BL-Hv
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3dwu-0005B7-Fv
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:20:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26818
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3dwr-0003aQ-G1
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596712836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pt4sn0IFHYYIi0tx1BQ5JODQemWdLxBjk0Yp6eucqjA=;
 b=G1dPb9L0cxZ17eI5fasUODgx09iI+DyTbGmJm2EOkk69uF3QrQKYAyd/21w13fVMUvyROx
 8nKOV6+lDr98HVGYyAhO/VEnbKz/qfZsJXmfZ38L85NX97AQgalfJj7lOwpwIJadVjx92J
 GG78FNi6L8F/im3sZqPm+ijKP1OkN9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-nlM3YCtRObuyK7rrB8Q4jA-1; Thu, 06 Aug 2020 07:20:34 -0400
X-MC-Unique: nlM3YCtRObuyK7rrB8Q4jA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 406428017FB;
 Thu,  6 Aug 2020 11:20:33 +0000 (UTC)
Received: from gondolin (ovpn-113-2.ams2.redhat.com [10.36.113.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 576367B904;
 Thu,  6 Aug 2020 11:20:31 +0000 (UTC)
Date: Thu, 6 Aug 2020 13:20:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for-5.2 v2 5/9] pc-bios/s390-ccw: Do not bail out early
 if not finding a SCSI disk
Message-ID: <20200806132028.6a534f96.cohuck@redhat.com>
In-Reply-To: <20200806105349.632-6-thuth@redhat.com>
References: <20200806105349.632-1-thuth@redhat.com>
 <20200806105349.632-6-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:03:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  6 Aug 2020 12:53:45 +0200
Thomas Huth <thuth@redhat.com> wrote:

> In case the user did not specify a boot device, we want to continue
> looking for other devices if there are no valid SCSI disks on a virtio-
> scsi controller. As a first step, do not panic in this case and let
> the control flow carry the error to the upper functions instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/main.c          | 14 ++++++++++----
>  pc-bios/s390-ccw/s390-ccw.h      |  2 +-
>  pc-bios/s390-ccw/virtio-blkdev.c |  7 +++++--
>  pc-bios/s390-ccw/virtio-scsi.c   | 28 ++++++++++++++++++++--------
>  pc-bios/s390-ccw/virtio-scsi.h   |  2 +-
>  5 files changed, 37 insertions(+), 16 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


