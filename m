Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04F3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0FE206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eh4YJhx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0FE206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Gkf-0008NU-Oe
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3Gjp-0007Qz-Kx
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:33:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3Gjm-0004iw-S3
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596623614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cI/+VorT1Ljnb6BhASmU+msZvXbdHZEE05ALnx+JrnY=;
 b=Eh4YJhx6boAFGBQH/gYC5jVjmuu9f9r5HPeiu5psNTSaeV2YSZaEaA2hXyMT7sDFPfH0XW
 /ZGpKkZvj/XuQ0JrMcSjOWSC0ZQ4IEFTDsWJClXUOAFlpeW7m1X/sJcFVLlnOuIywdA7uK
 DSs+oaljK7pcK4qwYUtSn9J07buYjUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-4IBPnd10OzWGYHxJghib6Q-1; Wed, 05 Aug 2020 06:33:31 -0400
X-MC-Unique: 4IBPnd10OzWGYHxJghib6Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8B2510059A2;
 Wed,  5 Aug 2020 10:33:30 +0000 (UTC)
Received: from localhost (ovpn-114-155.ams2.redhat.com [10.36.114.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A4A15F21A;
 Wed,  5 Aug 2020 10:33:27 +0000 (UTC)
Date: Wed, 5 Aug 2020 11:33:26 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 4/7] device-core: use atomic_set on .realized property
Message-ID: <20200805103326.GB361702@stefanha-x1.localdomain>
References: <20200715150159.95050-1-mlevitsk@redhat.com>
 <20200715150159.95050-5-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200715150159.95050-5-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 03:37:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 06:01:56PM +0300, Maxim Levitsky wrote:
> Some code might race with placement of new devices on a bus.
> We currently first place a (unrealized) device on the bus
> and then realize it.
>=20
> As a workaround, users that scan the child device list, can
> check the realized property to see if it is safe to access such a device.
> Use an atomic write here too to aid with this.
>=20
> A separate discussion is what to do with devices that are unrealized:
> It looks like for this case we only call the hotplug handler's unplug
> callback and its up to it to unrealize the device.
> An atomic operation doesn't cause harm for this code path though.
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/core/qdev.c         | 19 ++++++++++++++++++-
>  include/hw/qdev-core.h |  2 ++
>  2 files changed, 20 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8qivYACgkQnKSrs4Gr
c8h66AgApcTydXq58WdArWM6fyeUiwZfKpuBNuwC9KtO4lFPiEzzlulRWK2bjD8y
6mt+QqjiCKD1EFfctk2Xi/A6JzxC96tEu2h2Vfb+CxdvAaL9bsWA65422s1Blegr
2hW1nCBxflwamEmPgRVTMAexSyyusIiJT5MKZIuMacPk9xu+OmsgG3u/s+suX2WF
vIHNXDgS9hMjUmfE6hUGY1I8HXNh5p1k6aS6KvXbpc6+IIL0QcV57Nca6+h/Rmas
ZXbt0WonxpomNN595CJ26Mr1QLaUKUc1o+2hmEv+B7S1WoBq7yx75CgrGoAMh144
hhsOMAozS9sFFGLXXw3y5oHVNmMBkw==
=9Y/d
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--


