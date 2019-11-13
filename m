Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA513C4742C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7331B238BF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOJVv55P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7331B238BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUvCW-0006Gx-LU
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iUvBQ-0005jC-Eg
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:07:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iUvBN-0000z7-Mq
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:07:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48544
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iUvBN-0000yx-Ie
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573661268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3TFOP5HhhrndeHyfu0+0vsl+n39VTRsiECATSHsmCxg=;
 b=TOJVv55PETJQzOyEotwXd15S9MGBZUsZYwfO5zuXPl3RKqBI1Ou81otpd2o7h47yYFeE04
 Bb5iDAenyVm5hEtFDKLeSR4l7EH5gRdzG33d4dpFVIxJ4jaotmpBGpAcS1U/mpVy0kk8J1
 VjN0rNAq3FgSd3EZnLM72JDmWY9f8kQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-fX_ypdL7PU-PxNYGmF8ilA-1; Wed, 13 Nov 2019 11:07:45 -0500
X-MC-Unique: fX_ypdL7PU-PxNYGmF8ilA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2F9B1087B1C;
 Wed, 13 Nov 2019 16:07:43 +0000 (UTC)
Received: from localhost (ovpn-117-166.ams2.redhat.com [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3ADF91726D;
 Wed, 13 Nov 2019 16:07:38 +0000 (UTC)
Date: Wed, 13 Nov 2019 16:07:37 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 09/49] multi-process: setup PCI host bridge for
 remote device
Message-ID: <20191113160737.GD563983@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <21b8d0f06279f177f2daca8779ced48af14139ee.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <21b8d0f06279f177f2daca8779ced48af14139ee.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 john.g.johnson@oracle.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 quintela@redhat.com, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, ross.lagerwall@citrix.com,
 kanth.ghatraju@oracle.com, kraxel@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, liran.alon@oracle.com, marcandre.lureau@gmail.com,
 mreitz@redhat.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 05:08:50AM -0400, Jagannathan Raman wrote:
> +static void remote_host_realize(DeviceState *dev, Error **errp)
> +{
> +    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
> +    RemPCIHost *s = REMOTE_HOST_DEVICE(dev);
> +
> +    /*
> +     * TODO: the name of the bus would be provided by QEMU. Use
> +     * "pcie.0" for now.
> +     */
> +    pci->bus = pci_root_bus_new(DEVICE(s), "pcie.0",
> +                                s->mr_pci_mem, s->mr_sys_io,
> +                                0, TYPE_PCIE_BUS);

The PCI bus name could be a property and then whatever instantiates
RemPCIHost could set it.

Machine types usually hardcode the name because they assume there is
only one machine instance.  In the case of mpqemu this is an okay
starting point, but maybe multiple busses will become necessary if the
device emulation process handles multiple device instances - especially
if they are served to multiple guests like in a software-defined network
switch use case.

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3MKkkACgkQnKSrs4Gr
c8j9YAf+NLWJIKQnVeo+AsQcSk7wyk40tQBgNFbl/sOH2adzF0BXMvmOvlc4T/0y
BUUYkXhUXWUfB/mWo184X2UFmmEKFQdng2AEmrzTunH9xT7WVNyuKtZJZvE1rKIh
yDEOOpMO9hXhIXeskv3+44LgM298sE+H3VlbY+6BodIhuvEiWkIHoXvzc40L0xCH
yPJnCyIWKXWhGg3xG8qvlTnqoiS5FccFvh4qMQtKGnjgHENRceIEC3wwDVPnGdNF
umPHMMU+Ln8wtElsSpQfL5ZkOqxpslgq1aySh6Jp9mSL9UJdeUoo18ZljE3YUaPo
A5Iua4n60iEPl9opcT5MP49gfnIYNg==
=+42L
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--


