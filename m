Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE41C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E519521789
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0b1Jh01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E519521789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKIPz-0004d9-0N
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 05:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kKIOv-0003wj-2s
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:46:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kKIOs-0003Sc-Qt
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600681580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0GEFx06t/OwKjcPuzCjLPh5UPP2kUWjSYrPVcdQbyvw=;
 b=d0b1Jh01lt0oaJHXZSGW6MMOtHBHWVcqgZYwwz6INiyu038ScEO2oeLBZY9sgBlsk2Ut8r
 mN9L/CVkCKHekENjrYb9ERbdAxmRM0JCOTOEHyU8Gz446NU0M4TYQqT6BfVXnIB0bmZZlT
 pZtszdp8KtPY/jvI1Nwqknyq4D6K5Rk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-PArGVvP6Pk-2aGH4T6p6NQ-1; Mon, 21 Sep 2020 05:46:18 -0400
X-MC-Unique: PArGVvP6Pk-2aGH4T6p6NQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E76DB18B9ECD;
 Mon, 21 Sep 2020 09:46:16 +0000 (UTC)
Received: from gondolin (ovpn-112-187.ams2.redhat.com [10.36.112.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 442505C1DC;
 Mon, 21 Sep 2020 09:46:05 +0000 (UTC)
Date: Mon, 21 Sep 2020 11:46:02 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v4 2/4] vhost-vsock-pci: force virtio version 1
Message-ID: <20200921114602.46372eb4.cohuck@redhat.com>
In-Reply-To: <20200921083807.48380-3-sgarzare@redhat.com>
References: <20200921083807.48380-1-sgarzare@redhat.com>
 <20200921083807.48380-3-sgarzare@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Thomas Huth <thuth@redhat.com>, Qinghua Cheng <qcheng@redhat.com>,
 Qian Cai <caiqian@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-stable@nongnu.org, David Hildenbrand <david@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Sep 2020 10:38:05 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> Commit 9b3a35ec82 ("virtio: verify that legacy support is not
> accidentally on") added a safety check that requires to set
> 'disable-legacy=on' on vhost-vsock-pci device:
> 
>     $ ./qemu-system-x86_64 ... -device vhost-vsock-pci,guest-cid=5
>         qemu-system-x86_64: -device vhost-vsock-pci,guest-cid=5:
>         device is modern-only, use disable-legacy=on
> 
> virtio-vsock was introduced after the release of VIRTIO 1.0
> specifications, so it should be 'modern-only'.
> In addition Cornelia verified that forcing a legacy mode on
> vhost-vsock-pci device using x86-64 host and s390x guest, so with
> different endianness, produces strange behaviours.
> 
> This patch forces virtio version 1 and removes the 'transitional_name'
> property removing the need to specify 'disable-legacy=on' on
> vhost-vsock-pci device.
> 
> To avoid migration issues, we force virtio version 1 only when
> legacy check is enabled in the new machine types (>= 5.1).

Maybe add

"As the transitional device name is not commonly used, we do not
provide compatibility handling for it." ?

> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Qian Cai <caiqian@redhat.com>
> Reported-by: Qinghua Cheng <qcheng@redhat.com>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1868449
> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v3:
>  - forced virtio version 1 only with new machine types
> v2:
>  - fixed commit message [Cornelia]
> ---
>  hw/virtio/vhost-vsock-pci.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


