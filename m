Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EAFC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CAAE20735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azfuUF4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAAE20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEB7X-0000Ex-AJ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jEAv6-0001y2-Um
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jEAv1-0006pt-M8
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:02:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40934)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jEAv1-0006i2-GT
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6NugTnAcCq7Oc2hM8bnHTii06KuFEIoiLb9jHiIOtzQ=;
 b=azfuUF4CmNY+QXLGar6n0pJUl97tjQk8oZQ6IqZkoSgDgcJ1ajf557mD4GzEiqr22eCt58
 xdDtFG/w57QL8flY/7BBE5YyKpKXrwMNlxYsa8X/X1JnoZO0bVJBp2WAm3Z6f/ZGpLx1zD
 XYu+9KWNDj0mJVsO+UbBs/wyJ/MVzQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-HsaF-LkZM9i20NzYtggC8g-1; Tue, 17 Mar 2020 08:01:52 -0400
X-MC-Unique: HsaF-LkZM9i20NzYtggC8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05EE5190D346;
 Tue, 17 Mar 2020 12:01:51 +0000 (UTC)
Received: from gondolin (ovpn-113-156.ams2.redhat.com [10.36.113.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6C057E327;
 Tue, 17 Mar 2020 12:01:49 +0000 (UTC)
Date: Tue, 17 Mar 2020 13:01:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9 08/15] s390x: protvirt: SCLP interpretation
Message-ID: <20200317130138.0765e2ad.cohuck@redhat.com>
In-Reply-To: <511c84ef-950f-ab82-04db-d0fb08e76973@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-9-frankja@linux.ibm.com>
 <da7d6747-bf56-6888-2d9f-8f689fa42b32@de.ibm.com>
 <20200317120529.3c5cd2b2.cohuck@redhat.com>
 <511c84ef-950f-ab82-04db-d0fb08e76973@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/PdPl5EoHQGxgnUiQat0iZl1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/PdPl5EoHQGxgnUiQat0iZl1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Mar 2020 12:54:54 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 3/17/20 12:05 PM, Cornelia Huck wrote:
> > On Fri, 13 Mar 2020 14:14:35 +0100
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >  =20
> >> On 11.03.20 14:21, Janosch Frank wrote: =20
> >>> SCLP for a protected guest is done over the SIDAD, so we need to use
> >>> the s390_cpu_pv_mem_* functions to access the SIDAD instead of guest
> >>> memory when reading/writing SCBs.
> >>>
> >>> To not confuse the sclp emulation, we set 0x4000 as the SCCB address,
> >>> since the function that injects the sclp external interrupt would
> >>> reject a zero sccb address.
> >>>
> >>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >>> Reviewed-by: David Hildenbrand <david@redhat.com>
> >>> ---
> >>>  hw/s390x/sclp.c         | 30 ++++++++++++++++++++++++++++++
> >>>  include/hw/s390x/sclp.h |  2 ++
> >>>  target/s390x/kvm.c      | 24 +++++++++++++++++++-----
> >>>  3 files changed, 51 insertions(+), 5 deletions(-) =20
> >  =20
> >>> +int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
> >>> +                                uint32_t code)
> >>> +{
> >>> +    SCLPDevice *sclp =3D get_sclp_device();
> >>> +    SCLPDeviceClass *sclp_c =3D SCLP_GET_CLASS(sclp);
> >>> +    SCCB work_sccb;
> >>> +    hwaddr sccb_len =3D sizeof(SCCB);
> >>> +
> >>> +    /*
> >>> +     * Only a very limited amount of calls is permitted by the
> >>> +     * Ultravisor and we support all of them, so we don't check for
> >>> +     * them. All other specification exceptions are also interpreted
> >>> +     * by the Ultravisor and hence never cause an exit we need to
> >>> +     * handle.
> >>> +     *
> >>> +     * Setting the CC is also done by the Ultravisor.
> >>> +     */   =20
> >>
> >> This is fine for the current architecture which specifies a list of sc=
lp=20
> >> commands that are passed through (and this is fine). Question is still=
 if
> >> we replace this comment with an assertion that this is the case?
> >> Or maybe even really do the same as sclp_service_call and return 0x1f0=
 for
> >> unknown commands? =20
> >=20
> > That would be a case of older QEMU on newer hardware, right? Signaling
> > that the command is unsupported seems the most reasonable to me
> > (depending on what the architecture allows.) =20
>=20
> Question is if we want to check for the non-pv codes as the hardware
> will currently only allow a smaller subset anyway. Then if the IO codes
> are passed through by SIE we would support them right away.

Depending on if the passed-through codes would work without any further
changes, I guess (which seems likely?) You probably have a better idea
about that :)

>=20
> >  =20
> >>
> >> Anyway, whatever you decide.
> >>
> >> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> =20
> >>> +    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
> >>> +    sclp_c->execute(sclp, &work_sccb, code);
> >>> +    s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
> >>> +                          be16_to_cpu(work_sccb.h.length));
> >>> +    sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
> >>> +    return 0;
> >>> +}
> >>> + =20
> >=20
> >  =20
>=20
>=20


--Sig_/PdPl5EoHQGxgnUiQat0iZl1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl5wvCIACgkQ3s9rk8bw
L69P/g/+NRdkY/+AuOikHqkrhXlmvh1VwtEAMdtKbSN51BeAjNQSUnChOyMUjjib
jbzRpUagWUu3kd9XQiLmnJYOR9mkqUtxxnXX0bVA5SyWQkWvfzcYBnanfADjElHL
VJj7ECl0Ks4lUcWOYJJ4My8EbLND7O1lBi5nKMYo2AOt19AMCJX2lpfvRWUtnlxo
onI9YP/DVavd+mzr1KlxmqRbwNVTGgZu6JjJxALyGsded//u8Sg9LQMUcp2h12D0
W11QR0gPogmXIq3Ck85zhiPkw9lgnICnA3YF7nQzzwNfsO8QZ0GyIAm9UT5sxz94
xBlysxa/v6tX0Whesve0odovklyoe9gcOvAr7xSJ5rvQ1TbyDfq0BbO+1I4r297w
Pjn1IW5w1GvlIEkdo7MM6mhK4uEbLdX8/dg5g9WbxphBPG158spPNmNm3RuD7buF
XQAPbEv4lgmQKaReNmqyLDTt6b9tFZzvc9JbEI1wgSC8QFgJ+otnxFLpNSyKxJ13
72G1qOhwUX0UieavUoerXkz7RjeErkP8sJTkuUs2cWleQ1uJsvz36boDhkDEQiRy
NPe1u1MYwwNTOFo+hmRwu8UnLVN9UIodG776e2w/JoxuFqXZQIeY+7C95Tibovb7
d/tYn2SoOh7x4cPJ8Wc/H9iXBnSxnLVTpZeJRnvJklR54oFHhIA=
=mRCo
-----END PGP SIGNATURE-----

--Sig_/PdPl5EoHQGxgnUiQat0iZl1--


