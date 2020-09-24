Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAF0C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F15D2068E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tsri/jBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F15D2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLMix-0007Lf-EB
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 04:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLMfj-00044T-HN
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLMfg-0007g8-4b
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600936327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A71+gFxpsDET7VKeOiJPUPf98qiNRB4WnVBPFj53jzQ=;
 b=Tsri/jBQIVKLlGacavuhmya77a9E9g2CobntlRmIQ23jOTp0bazUWY9XmOtuwarKFFtIn0
 4Cv2jOHWTlcC5bp4F/+35ZiCBam07Ndl1FB9SeDmlIG5jJyVGM5nENImFK6W5OUIm1jRQa
 VWFQ3kBlkgwEh8QbzdSY1vtd3VL34fE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-uP_Pt_6OOSmjGfJIB7Y3uw-1; Thu, 24 Sep 2020 04:32:05 -0400
X-MC-Unique: uP_Pt_6OOSmjGfJIB7Y3uw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EE6A100746C;
 Thu, 24 Sep 2020 08:32:03 +0000 (UTC)
Received: from localhost (ovpn-114-133.ams2.redhat.com [10.36.114.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40D1460C15;
 Thu, 24 Sep 2020 08:31:57 +0000 (UTC)
Date: Thu, 24 Sep 2020 09:31:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v9 18/20] multi-process: perform device reset in the
 remote process
Message-ID: <20200924083156.GN62770@stefanha-x1.localdomain>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
 <20200827181231.22778-19-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200827181231.22778-19-elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="McpcKDxJRrEJVmOH"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--McpcKDxJRrEJVmOH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2020 at 11:12:29AM -0700, elena.ufimtseva@oracle.com wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> Perform device reset in the remote process when QEMU performs
> device reset. This is required to reset the internal state
> (like registers, etc...) of emulated devices
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>  hw/i386/remote-msg.c     | 25 +++++++++++++++++++++++++
>  hw/pci/proxy.c           | 20 ++++++++++++++++++++
>  include/io/mpqemu-link.h |  1 +
>  3 files changed, 46 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--McpcKDxJRrEJVmOH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9sWXwACgkQnKSrs4Gr
c8jTQggAvcViK6kB7n1zswyYOreNBiuBHnXi1j3i3RrrkXqCiq4rfYcwQ8CumZnh
bQsXKkeOe4KAWT5jWKPbJxi1iMz949mD0WMT+FEtK+SIkqJgvGJt06Vdv6XGRDQ5
ooVoPgBIp1FYpYh+xDFpNs/gziu9br77/OqIKJzNZFOKDxddVTkQuMbW1Xd569+c
iyzwLITTb++h9znIJMODpkQo5lcPAq6Oa5hIfLxuxQNxHLQc+BGV9h+cMQE6yh8e
4yqsbJ6HflchklTEMSD4EAy6Qf6+7Xg6HvIJLtYu1nM1ERUOQ2boZ9jXH1vOzgSm
nZNqeQX6q4hByX9pDARgLIiSjn/RVA==
=7wH3
-----END PGP SIGNATURE-----

--McpcKDxJRrEJVmOH--


