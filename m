Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A190C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175D9206C0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYXres/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175D9206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Gzz-0001YK-D5
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3Gyg-0000cV-FK
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:48:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46385
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3Gye-000786-VL
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596624536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PDeGNr5hZom9FNfsrNwi+omfJxZZwG/t9HAQ+o9p2Nw=;
 b=EYXres/uuM7MJsU1FH7B6IxNkSnTtwWHHFkbMpR9bcvWSp3fcl/lv5ypMrYdaYY7T82PR4
 i712EzBvUTgbhE8WMapW0REX0xILkphz1yAXNHciybqMhHkbQBfLQeYvY+MAC9xKz0yFi9
 L79fhx+ZTWWNSfpNDokCaKlzxP/lixA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-AdkZmxHUPlK3wUnq3jBSPA-1; Wed, 05 Aug 2020 06:48:51 -0400
X-MC-Unique: AdkZmxHUPlK3wUnq3jBSPA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B84318C63CA;
 Wed,  5 Aug 2020 10:48:50 +0000 (UTC)
Received: from localhost (ovpn-114-155.ams2.redhat.com [10.36.114.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F5047B903;
 Wed,  5 Aug 2020 10:48:46 +0000 (UTC)
Date: Wed, 5 Aug 2020 11:48:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 0/7] Fix scsi devices plug/unplug races w.r.t
 virtio-scsi iothread
Message-ID: <20200805104845.GD361702@stefanha-x1.localdomain>
References: <20200715150159.95050-1-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200715150159.95050-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 01:46:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 06:01:52PM +0300, Maxim Levitsky wrote:
> Hi!
>=20
> This is a patch series that is a result of my discussion with Paulo on
> how to correctly fix the root cause of the BZ #1812399.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8qjo0ACgkQnKSrs4Gr
c8hIcwf/ZbIDL1NMJ4BLmED7AR/pJepV/BGfrzEXKTPkW885CQ77XVkxFVLMWtAj
DTvjYzjp4+04Ey94ZPEhAU7iAeZvAvv0jfpbR/6dOtTgKMYQGpNcqcoJEigBojwi
y33OFSh6mzsxdpkNzsFU66jvfuBJo/jvKu0IShJzsQkQ45LnQFlyjg6a+7B4R+eZ
CteEkFN/I1c1p6g6bPcPG8xQKsZPGdvx/kE6CPe4ynfYlb3rhXLrK4zSG1sZVjc9
TMdIcbQKhgz1NhOvKNiznXPKZc1C9QhxAsjpDHetAfKNn/DmXyf52wVzx48InvJk
ddbvMNxcBNabh6cwmrhMG8RX8WVsZA==
=aJgU
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--


