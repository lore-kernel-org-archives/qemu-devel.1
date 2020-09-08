Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4777AC2D0A7
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647DE224DF
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+adkvP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647DE224DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFf7u-0006Io-Jz
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 11:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFf7A-0005l6-OJ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 11:00:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60704
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFf78-0003ac-EC
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 11:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599577252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uRsvEignnJo/MSGGx84k8R3/+Sw8IR09NyTB8NxA/fg=;
 b=d+adkvP+k3BNnSLIt7ZvYpoXrlRvpjj3iguXFHKuijzW/S7TWLE/I2HzaM8tMpFrHIq9nf
 DmfqLLDtukNaik5ipcjPXcMnpqoMSknOKFs7J91B23PcjHeL18rcuSH5dPT0rlyC8cF7MP
 4A1XoZ0dKk9Uof9ITWwaYDGCsHj5Z9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-7xuEKNtsP-G2Uz3eZ-sesA-1; Tue, 08 Sep 2020 11:00:49 -0400
X-MC-Unique: 7xuEKNtsP-G2Uz3eZ-sesA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB70164088;
 Tue,  8 Sep 2020 15:00:47 +0000 (UTC)
Received: from localhost (ovpn-112-16.ams2.redhat.com [10.36.112.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28CE658824;
 Tue,  8 Sep 2020 15:00:41 +0000 (UTC)
Date: Tue, 8 Sep 2020 16:00:38 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v4 6/9] scsi/scsi-bus: scsi_device_find: don't return
 unrealized devices
Message-ID: <20200908150038.GE7154@stefanha-x1.localdomain>
References: <20200831150124.206267-1-mlevitsk@redhat.com>
 <20200831150124.206267-7-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200831150124.206267-7-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:08:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2020 at 06:01:21PM +0300, Maxim Levitsky wrote:
> The device core first places a device on the bus and then realizes it.
> Make scsi_device_find avoid returing such devices to avoid
> races in drivers that use an iothread (currently virtio-scsi)
>=20
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1812399
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/scsi/scsi-bus.c | 88 ++++++++++++++++++++++++++++------------------
>  1 file changed, 53 insertions(+), 35 deletions(-)
>=20
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index 92d412b65c..7ceae2c92b 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -51,6 +51,56 @@ static const TypeInfo scsi_bus_info =3D {
>  };
>  static int next_scsi_bus;
> =20
> +static SCSIDevice *_scsi_device_find(SCSIBus *bus, int channel, int id, =
int lun,
> +                                     bool include_unrealized)

Declaring an identifier with a leading underscore with file scope is
undefined behavior according to the C99 standard (7.1.3 Reserved
identifiers). QEMU code usually avoids doing this by calling the
function do_scsi_device_find() or similar.

I'm not aware of any practical problem though, so don't worry about
changing it unless you respin the series:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9XnJYACgkQnKSrs4Gr
c8itmAgAxBQLAMYItqrl1ONKhG6Vx8wNCvAJPJI10LYxRrNyP4lrhgapulJCsd01
EeGiQkWuPwAvWeSeg/uVxYlbTPD0jyRQnMMn4RzIASjqR2rHpb1GDEjXC+TosjeP
JuLXgZCAAvq6Rsev3LRAXsY3SWDJTQVYWFi1bovq3rXBRscdkq17yb5qLXCLyqX5
Gd5w3G5qo2Z97lH2ZcNyiN/wCJSQpnISuyCwZAPkPndWx/bb2ryNHUAhTbJI3hR7
FXBxj859LzjQ4QqoGEB0XKVyu8h3yE6BfzpqQ0LkJ43PJx1BKT6+IRd8reAH2h/5
PoUT7OalxmffAalZevhW3KWdseSc0A==
=k5mZ
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--


