Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F36EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFBB620663
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jgc77Iuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFBB620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtSo7-0004tE-6u
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 05:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jtSnX-0004SJ-OH
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 05:24:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39511
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jtSnV-00089c-EB
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 05:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594286691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aiThxBoby+0IE52woVDOQLzr/eDX3mKKDoB0pVaOw8w=;
 b=Jgc77IuquS7vELG6kpxV9kVvUP55lubtApeymxsdpH4bWkTh6MTENMI5lukx0irC1PAdMs
 Gcl5hLQstgENHEfgTYI54oNaeUBSeSkBbuG1Fo0m4eDgfFffKM2fm6NVBn2FhDkkph1NF5
 tahvl2P7J//1DXmdz8Nrf9xFWYbzUO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-Jj6kbq7UOeSOR1JdltekVQ-1; Thu, 09 Jul 2020 05:24:49 -0400
X-MC-Unique: Jj6kbq7UOeSOR1JdltekVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E813A100D929;
 Thu,  9 Jul 2020 09:24:47 +0000 (UTC)
Received: from gondolin (ovpn-113-62.ams2.redhat.com [10.36.113.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C3EE10016DA;
 Thu,  9 Jul 2020 09:24:38 +0000 (UTC)
Date: Thu, 9 Jul 2020 11:24:36 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 4/5] s390x: implement virtio-mem-ccw
Message-ID: <20200709112436.0ca1e95f.cohuck@redhat.com>
In-Reply-To: <20200708185135.46694-5-david@redhat.com>
References: <20200708185135.46694-1-david@redhat.com>
 <20200708185135.46694-5-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:20:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  8 Jul 2020 20:51:34 +0200
David Hildenbrand <david@redhat.com> wrote:

> Add a proper CCW proxy device, similar to the PCI variant.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/virtio-ccw-mem.c | 165 ++++++++++++++++++++++++++++++++++++++
>  hw/s390x/virtio-ccw.h     |  13 +++
>  2 files changed, 178 insertions(+)
>  create mode 100644 hw/s390x/virtio-ccw-mem.c

(...)

> +static void virtio_ccw_mem_instance_init(Object *obj)
> +{
> +    VirtIOMEMCcw *ccw_mem = VIRTIO_MEM_CCW(obj);
> +    VirtIOMEMClass *vmc;
> +    VirtIOMEM *vmem;
> +

I think you want

    ccw_dev->force_revision_1 = true;

here (similar to forcing virtio-pci to modern-only.)

> +    virtio_instance_init_common(obj, &ccw_mem->vdev, sizeof(ccw_mem->vdev),
> +                                TYPE_VIRTIO_MEM);
> +
> +    ccw_mem->size_change_notifier.notify = virtio_ccw_mem_size_change_notify;
> +    vmem = VIRTIO_MEM(&ccw_mem->vdev);
> +    vmc = VIRTIO_MEM_GET_CLASS(vmem);
> +    /*
> +     * We never remove the notifier again, as we expect both devices to
> +     * disappear at the same time.
> +     */
> +    vmc->add_size_change_notifier(vmem, &ccw_mem->size_change_notifier);
> +
> +    object_property_add_alias(obj, VIRTIO_MEM_BLOCK_SIZE_PROP,
> +                              OBJECT(&ccw_mem->vdev),
> +                              VIRTIO_MEM_BLOCK_SIZE_PROP);
> +    object_property_add_alias(obj, VIRTIO_MEM_SIZE_PROP, OBJECT(&ccw_mem->vdev),
> +                              VIRTIO_MEM_SIZE_PROP);
> +    object_property_add_alias(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP,
> +                              OBJECT(&ccw_mem->vdev),
> +                              VIRTIO_MEM_REQUESTED_SIZE_PROP);
> +}

(...)

(have not looked at the rest yet)


