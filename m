Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A592BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B6F220760
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRDoi2QD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6F220760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigs5-0007uj-6i
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jigla-0007wL-2J
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:06:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39578
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jiglY-0004Jm-0c
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591718778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MH2y5hdKyKWamfkscXeCoZyov5Qz8+OiniqspCNJ1sQ=;
 b=QRDoi2QDyji+7ZwUYf9TeW6uIx8/+tMHykc9ZplV8M34HYPitMQfT6q+AthvGHOaKomq8w
 RgQPGQC9zOBChM8fol2eSz/pNpJGcCwH0pp/dOphQHWHKHUHm6OgHkWKCNiehcg9WKu8rh
 1grUkCHFfRDJze1pOzqAOQHfnglK55Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-r-NcVRxPM4-YqGtocYqfCw-1; Tue, 09 Jun 2020 12:06:14 -0400
X-MC-Unique: r-NcVRxPM4-YqGtocYqfCw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 689171883607;
 Tue,  9 Jun 2020 16:06:12 +0000 (UTC)
Received: from gondolin (ovpn-114-205.ams2.redhat.com [10.36.114.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F16765C1C5;
 Tue,  9 Jun 2020 16:06:01 +0000 (UTC)
Date: Tue, 9 Jun 2020 18:05:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200609180559.52298647.cohuck@redhat.com>
In-Reply-To: <20200609174747.4e300818@ibm-vm>
References: <20200514221155.32079-1-pasic@linux.ibm.com>
 <20200520121507-mutt-send-email-mst@kernel.org>
 <20200606013217.2cffa3ed.pasic@linux.ibm.com>
 <20200608181428.3c6f127c.cohuck@redhat.com>
 <20200608190045.319dd68b.pasic@linux.ibm.com>
 <20200609084402.35d317ec.cohuck@redhat.com>
 <20200609114130.0ca9190b.pasic@linux.ibm.com>
 <20200609174747.4e300818@ibm-vm>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 9 Jun 2020 17:47:47 +0200
Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:

> On Tue, 9 Jun 2020 11:41:30 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> [...]
> 
> > I don't know. Janosch could answer that, but he is on vacation. Adding
> > Claudio maybe he can answer. My understanding is, that while it might
> > be possible, it is ugly at best. The ability to do a transition is
> > indicated by a CPU model feature. Indicating the feature to the guest
> > and then failing the transition sounds wrong to me.  
> 
> I agree. If the feature is advertised, then it has to work. I don't
> think we even have an architected way to fail the transition for that
> reason.
> 
> What __could__ be done is to prevent qemu from even starting if an
> incompatible device is specified together with PV.

Seems reasonable, if an incompatible device can crash the whole guest.
Better not even let it start. (And prevent hotplugging it into a
running guest.)

> 
> Another option is to disable PV at the qemu level if an incompatible
> device is present. This will have the effect that trying to boot a
> secure guest will fail mysteriously, which is IMHO also not too great.

Yes, if that is not architected, and no other possible failure code can
map to that case.

> 
> do we really have that many incompatible devices?

Which devices are compatible in the end? It seems the only ones that
are known to be working are virtio-ccw devices with IOMMU_PLATFORM on.
virtio-pci devices and non-virtio ccw (vfio-ccw, 3270) seem to be out,
as far as I understand it. What about non-ccw? PCI in general, vfio-ap?


