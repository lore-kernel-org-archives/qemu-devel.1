Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D59C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 11:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 633522074B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 11:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUGcoIzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633522074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIrhL-0000Jn-S0
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 07:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kIrgF-0007rQ-4J
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 07:02:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kIreI-0001ES-Kn
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 07:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600340421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K4zvvZhlDZM4LiBTk+RVjFX99L6wrDDNAjA4ZF7NjEk=;
 b=EUGcoIzc4zbi/jRYr1zLTp2oK8BQRlgoRHPhs+6VOIN0Pu8PZvoiK7k28sYQ6VD7HjHsIj
 I9CR+ZPGsUEch93beHJba8qEOe9aDufOMcRdPit9d0kgZ+lpMYKiv7Z6DQctvOw8/mFKDj
 RvKdv6GEKA4yeWTwA2p0w3ohMDQ6Ymc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-SAB04_uDNqGpAfSZaH59eQ-1; Thu, 17 Sep 2020 07:00:18 -0400
X-MC-Unique: SAB04_uDNqGpAfSZaH59eQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FB17801AFF;
 Thu, 17 Sep 2020 11:00:17 +0000 (UTC)
Received: from gondolin (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F6C068865;
 Thu, 17 Sep 2020 11:00:12 +0000 (UTC)
Date: Thu, 17 Sep 2020 13:00:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v2] virtio: skip legacy support check on machine types
 less than 5.1
Message-ID: <20200917130008.79a1637b.cohuck@redhat.com>
In-Reply-To: <20200917104721.pbfik4t6zszflama@steredhat>
References: <20200915130514.80989-1-sgarzare@redhat.com>
 <20200916110848.47395807.cohuck@redhat.com>
 <20200917084828.p7j3fc6p4almxbxw@steredhat>
 <20200917112256.796f620d.cohuck@redhat.com>
 <20200917100000.GF2793@work-vm>
 <20200917104721.pbfik4t6zszflama@steredhat>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Sep 2020 12:47:21 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> Okay, so I'll leave the device property.
> 
> 
> I also need to update a series [1] that I sent to force virtio version 1
> on vhost-vsock devices.
> Also in this case I need to care about migration and force it only on new
> machine types.
> 
> Do you think I can reuse the same property also in vhost-vsock-pci and
> vhost-vsock-ccw to force virtio version 1, or it is better to add a new
> property for each device.
> 
> The two things (disable legacy check and force version 1) are related,
> so maybe I can use a single property in the virtio-device class,

So, 'x-disable-legacy-check==false' -> 'we need to force version 1'?
Seems reasonable to me.

> 
> Thanks,
> Stefano
> 
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg04437.html
> 


