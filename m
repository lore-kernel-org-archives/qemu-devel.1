Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C84C388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAEA320674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tc241hG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEA320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc4jJ-0006bO-SM
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 05:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kc4iT-00064i-Af
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 05:48:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kc4iR-0008AO-DK
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 05:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604918882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5xhQO0ta8Zk7YojdbHZFj2vc+4a/lBAf0TXONvmSYBs=;
 b=Tc241hG1kJuEeofbWlWp2f/BXZ2qHtlLSZeHUqFDdEFL1P9PiUlEb454XRFGU8VTj7+KpC
 Wp7qTy3ET8PubDLydne6xkResh5qk2kDXmng70yzK8Ct/A5j2YbCq2LcD+ONXOFVbL008+
 wum8twR6iB/Ts2GVMJimBzKR+rl0bkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-4D-q5n4QNqulbb6oiE2qdQ-1; Mon, 09 Nov 2020 05:47:57 -0500
X-MC-Unique: 4D-q5n4QNqulbb6oiE2qdQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B2481074653;
 Mon,  9 Nov 2020 10:47:55 +0000 (UTC)
Received: from gondolin (ovpn-113-28.ams2.redhat.com [10.36.113.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3AF175125;
 Mon,  9 Nov 2020 10:47:43 +0000 (UTC)
Date: Mon, 9 Nov 2020 11:47:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 6/7] qom: Add FIELD_PTR, a type-safe wrapper for
 object_field_prop_ptr()
Message-ID: <20201109114740.19e727d9.cohuck@redhat.com>
In-Reply-To: <20201104172512.2381656-7-ehabkost@redhat.com>
References: <20201104172512.2381656-1-ehabkost@redhat.com>
 <20201104172512.2381656-7-ehabkost@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, "Daniel P.
 Berrange" <berrange@redhat.com>, xen-devel@lists.xenproject.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-s390x@nongnu.org,
 Paul Durrant <paul@xen.org>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  4 Nov 2020 12:25:11 -0500
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Introduce a FIELD_PTR macro that will ensure the size of the area
> we are accessing has the correct size, and will return a pointer
> of the correct type.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: xen-devel@lists.xenproject.org
> Cc: qemu-block@nongnu.org
> Cc: qemu-s390x@nongnu.org
> ---
>  include/qom/field-property.h     | 21 ++++++++++-
>  backends/tpm/tpm_util.c          |  6 ++--
>  hw/block/xen-block.c             |  4 +--
>  hw/core/qdev-properties-system.c | 50 +++++++++++++-------------
>  hw/s390x/css.c                   |  4 +--
>  hw/s390x/s390-pci-bus.c          |  4 +--
>  hw/vfio/pci-quirks.c             |  4 +--
>  qom/field-property.c             |  3 +-
>  qom/property-types.c             | 60 +++++++++++++++++---------------
>  9 files changed, 89 insertions(+), 67 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>


