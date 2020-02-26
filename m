Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4038C4BA1E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF6824653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCG1OkU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF6824653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j71Mq-00028b-Mk
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 13:25:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j71MI-0001fr-GL
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j71MH-0003Hz-EO
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:24:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43045
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j71MH-0003HC-BC
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582741472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CurRZE+3qfT75qopMsRnajFL37Z2hDhrLmcF88m0vbo=;
 b=OCG1OkU9MMP5znO5wuI8XS6QldxpPeX34GdBgF7l8syQtfKez9JTJZXXB0EwW+QoJkLPFW
 mw3dJfLKThPQwuMKfqvqDMW7OUl3KsbnRKxAe5COw+4WHUcBc9A5dVCXWNbe1GOlvB1RSt
 VgT5Ww3RJi079fu2EgT8XoH7u/RGIxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-kHzmTKUhN4W_Q8RMuGwM-A-1; Wed, 26 Feb 2020 13:24:28 -0500
X-MC-Unique: kHzmTKUhN4W_Q8RMuGwM-A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E50971005512;
 Wed, 26 Feb 2020 18:24:26 +0000 (UTC)
Received: from gondolin (ovpn-117-69.ams2.redhat.com [10.36.117.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E230610027BA;
 Wed, 26 Feb 2020 18:24:22 +0000 (UTC)
Date: Wed, 26 Feb 2020 19:24:04 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v5 07/18] s390x: protvirt: Inhibit balloon when
 switching to protected mode
Message-ID: <20200226192404.57b6ef61.cohuck@redhat.com>
In-Reply-To: <556c23cb-7648-f4f6-aef4-728a164d9502@linux.ibm.com>
References: <20200226122038.61481-1-frankja@linux.ibm.com>
 <20200226122038.61481-8-frankja@linux.ibm.com>
 <ed51d194-1b63-1c54-953a-d2031336a90e@redhat.com>
 <9e8c83c2-5d17-2887-4073-698c12c40e79@de.ibm.com>
 <53287b24-6cab-2110-226c-f10cef3c8eb0@redhat.com>
 <556c23cb-7648-f4f6-aef4-728a164d9502@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/ubyr+N0EAwPjWiE_SpjUCO8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/ubyr+N0EAwPjWiE_SpjUCO8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Feb 2020 16:30:32 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 2/26/20 4:16 PM, David Hildenbrand wrote:
> > On 26.02.20 16:06, Christian Borntraeger wrote: =20
> >>
> >>
> >> On 26.02.20 15:59, David Hildenbrand wrote: =20
> >>> On 26.02.20 13:20, Janosch Frank wrote: =20
> >>>> Ballooning in protected VMs can only be done when the guest shares t=
he
> >>>> pages it gives to the host. Hence, until we have a solution for this
> >>>> in the guest kernel, we inhibit ballooning when switching into
> >>>> protected mode and reverse that once we move out of it. =20
> >>>
> >>> I don't understand what you mean here, sorry. zapping a page will mea=
n
> >>> that a fresh one will be faulted in when accessed. And AFAIK, that me=
ans
> >>> it will be encrypted again when needed.
> >>>
> >>> Is that more like the UV will detect this as an integrity issue and
> >>> crash the VM? =20
> >>
> >> yes, the UV will detect a fresh page as an integrity issue.
> >> Only if the page was defined to be shared by the guest, we would avoid=
 the
> >> integrity check.
> >> =20
> >=20
> > Please make that clearer in the patch description. With that
> >=20
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> >  =20
>=20
> How about:
> s390x: protvirt: Inhibit balloon when switching to protected mode
>=20
> Ballooning in protected VMs can only be done when the guest shares the
> pages it gives to the host. If pages are not shared, the integrity
> checks will fail once those pages have been altered and are given back
> to the guest.

This makes sense to me...

>=20
> Hence, until we have a solution for this in the guest kernel, we
> inhibit ballooning when switching into protected mode and reverse that
> once we move out of it.

...however, I'm scratching my head here.

If we have a future guest that knows how to handle this, how do we
know? We know that the current Linux driver clears
VIRTIO_F_IOMMU_PLATFORM during feature negotiation, and presumably a
guest that knows how to handle this will not do that. But it still
won't work as expected, as we inhibit ballooning...

So, either
- we don't inhibit ballooning now; any guest that clears the (required)
  virtio feature bit won't be able to drive the virtio-balloon device
  anyway, but a future guest that negotiates the bit would work; or
- we inhibit ballooning now; no guest can therefore use ballooning,
  regardless what they are doing or not doing (this includes guests
  that negotiate the feature bit, but fail to handle pages properly).

Or is there some other reason why we need to inhibit ballooning for
protected vms?

--Sig_/ubyr+N0EAwPjWiE_SpjUCO8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl5Wt8QACgkQ3s9rk8bw
L69Fpg/8Dc4s9QIU0ZQkMpGM56jPQmURAl8n+tPRKV35M9J1gOw18hv2PDltzNLm
chZCbUFLT+Do7HwErNdYLf5DEcETsCGoMiw/FNJHgCdwQ8wJAI0Q++tU6jBjcCHt
4Q3XUhbLvwj48ALYmrlyS5rGIUGNy2AY1BtYmTLskFgn5AoXuExNF+sYpEOukX8a
UgS/0ZHWHRGrgM6weV+RLQ4T6fKRfMm3VVcsBlHCY4nA/fdVRa0mV3mJ7BD7Wqmb
tE89WUZlxxpyBmbOHWGn3LKlmYMZeYNV7VBJzOsFhMViQ42pXCJA1VQH1VEQB9ka
3UL1LDKk7POalI5UsgwO0FQgN4bhMTn9ymLAPMExN4InZFfGqkOUjVNfAtXxzkeH
savxFRbIlwN5nEh2pJUOPdoKahcu3s2RV2Btax8uls4SNAMedoFJOdP2dCX7egsc
bIJO+Vk36d64AhqUZm0E75gQ2hqefUxc06fIxe/U4LwM+hBV8aY9DEEv8QIQJAPh
niFEEXXTyhbIF24LPqS3V5BcOlbFVb8gmWJDAAaQlVow/TE4HkzgwmDM2VrSAo3M
PshTu/0r0yUY2cVXcjyrug/U7Mdh4MNpSxZpHUlPJuvVEEfe4Vrg52BnlIIeOHCF
Vtc16ofKOouSsaWeyEgASw78sOPRTc215ew6zEZoVo6893KzXJM=
=qxnM
-----END PGP SIGNATURE-----

--Sig_/ubyr+N0EAwPjWiE_SpjUCO8--


