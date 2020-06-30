Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5427C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7CA20724
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9JyYNFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7CA20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqI8k-00023F-Uh
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqI2H-0004SO-TY
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:19:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33194
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqI2E-0007hi-BZ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593530337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gV8yS3lKFp4MonAY4pRADQvNCs1Zq1xZQDxDl2a+zfg=;
 b=Y9JyYNFkvJUqZDtlyMstT4fmGDXKOTeUuNstQ6/axG9hepLmuozpzNBd1qV5P5AaC3vIZK
 1LohH2gCtrcIvN+y2bxxNiPZ8VyDOYHbYCIEKmI4ju1uVU2ZiqjeCtdSzlmxBZ3b8c3aRw
 mZLjDZc4ES5VaeLz0NfUHSV8YYn1kSE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-xtbXU82zOUa5ZbJmGpSlzg-1; Tue, 30 Jun 2020 11:18:52 -0400
X-MC-Unique: xtbXU82zOUa5ZbJmGpSlzg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06CC9910280;
 Tue, 30 Jun 2020 15:17:55 +0000 (UTC)
Received: from localhost (ovpn-115-106.ams2.redhat.com [10.36.115.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 330291A90F;
 Tue, 30 Jun 2020 15:17:00 +0000 (UTC)
Date: Tue, 30 Jun 2020 16:17:00 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v7 03/21] multi-process: setup PCI host bridge for remote
 device
Message-ID: <20200630151700.GC109906@stefanha-x1.localdomain>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <77bf485a3bbaeac83f3db50753fe45156ae7e882.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <77bf485a3bbaeac83f3db50753fe45156ae7e882.1593273671.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2020 at 10:09:25AM -0700, elena.ufimtseva@oracle.com wrote:
> diff --git a/hw/pci-host/remote.c b/hw/pci-host/remote.c
> new file mode 100644
> index 0000000000..5ea9af4154
> --- /dev/null
> +++ b/hw/pci-host/remote.c
> @@ -0,0 +1,63 @@
> +/*
> + * Remote PCI host device
> + *
> + * Copyright =A9 2018, 2020 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *

A little more detail would be nice:

  Unlike PCI host devices that model physical hardware, the purpose of
  this PCI host is to host multi-process QEMU remote PCI devices.

  Multi-process QEMU talks to a remote PCI device that runs in a
  separate process. In order to reuse QEMU device models in the remote
  process we need a PCI bus that holds the devices.

  This PCI host is purely a container for PCI devices. It's fake in the
  sense that the guest never sees this PCI host and has no way of
  accessing it. It's job is just to provide the environment that QEMU
  PCI device models need when running in a remote process.

I think this could be restated more clearly but hopefully it
communicates the purpose of hw/pci-host/remote.c. :P

> +typedef struct RemotePCIHost {
> +    /*< private >*/
> +    PCIExpressHost parent_obj;
> +    /*< public >*/
> +
> +    MemoryRegion *mr_pci_mem;
> +    MemoryRegion *mr_sys_mem;

Unused? Please add mr_sys_mem if and when it is used.

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl77V2sACgkQnKSrs4Gr
c8gX5Af9EdpbZT5o8G8oLlOnUl3wNyUm6VeLC3zdcc60z4Tf9yzM8vF7rvR/4LYv
mjxwP1hXr/O37H09GW4GEIiCNLEpqbNrqo9d7INJc84E4haC5/aYMRMUoPGmQsro
vTiNAd181La357Tf04fsipvj8eOQ/uDuyOMDkMmSi9+RaEWG6yNVgFCHCUr2EtZ5
aSJUH4GisypSRtZIZCFE9Ts0EoqmKtTahjhs7eImzQJFhoJSmrc5RJxojBZWZwM5
tCEomiex4h+sDwNknJHVWuHoxL05dw8a6tbnMFZkwrpBZkeqvGbEGi9iFAETRZqZ
/MpIbtqML53VF4xbK6Mp32CmzefjOw==
=FU1u
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--


