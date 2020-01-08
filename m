Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0754C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE46206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjJ2JEGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE46206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip9XP-0002i1-Mf
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 06:30:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ip9WS-00023j-SA
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ip9WR-0000Kt-OF
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:29:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24985
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ip9WR-0000KY-Jo
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578482951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLohV8IuPrDwgD/FBT7V9AWBN1NYg8wO5blctv1ibWc=;
 b=fjJ2JEGhkPm1h2FCkLfOaArF1YgT5lPnV7ptf2xxWacL2vYoTT47I1MTlqFqi5fjl+fXSA
 BT3sJlmgmqgKV23DFte7seTHsnahz43zeDQKGhiezKSfFg3fx2XhZyDPgYkllNnPc8JfLe
 K4je528/HA+T3kot2rx4dPI5RS1rzqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-Ug_xdIz2OXmzzUC7I6XcUA-1; Wed, 08 Jan 2020 06:29:10 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3442E8C2F21;
 Wed,  8 Jan 2020 11:29:09 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90F2660CD3;
 Wed,  8 Jan 2020 11:29:05 +0000 (UTC)
Date: Wed, 8 Jan 2020 11:29:02 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 2/3] tpm-ppi: page-align PPI RAM
Message-ID: <20200108112902.GB3184@work-vm>
References: <20200103074000.1006389-1-marcandre.lureau@redhat.com>
 <20200103074000.1006389-3-marcandre.lureau@redhat.com>
 <20200103100233.GA3804@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200103100233.GA3804@work-vm>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Ug_xdIz2OXmzzUC7I6XcUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> * Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> > post-copy migration fails on destination with error such as:
> > 2019-12-26T10:22:44.714644Z qemu-kvm: ram_block_discard_range:
> > Unaligned start address: 0x559d2afae9a0
>=20
> Ah good, we got a sane error message!
>=20
> > Use qemu_memalign() to constrain the PPI RAM memory alignment.
> >=20
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > ---
> >  hw/tpm/tpm_ppi.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
> > index ff314592b4..6d9c1a3e40 100644
> > --- a/hw/tpm/tpm_ppi.c
> > +++ b/hw/tpm/tpm_ppi.c
> > @@ -43,7 +43,8 @@ void tpm_ppi_reset(TPMPPI *tpmppi)
> >  void tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
> >                    hwaddr addr, Object *obj)
> >  {
> > -    tpmppi->buf =3D g_malloc0(HOST_PAGE_ALIGN(TPM_PPI_ADDR_SIZE));
> > +    tpmppi->buf =3D qemu_memalign(qemu_real_host_page_size,
> > +                                HOST_PAGE_ALIGN(TPM_PPI_ADDR_SIZE));
>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

I just noticed a bit in the CODING_STYLE that says:

  Memory allocated by qemu_memalign or qemu_blockalign must be freed with
  qemu_vfree, since breaking this will cause problems on Win32.

so I guess this is wrong?

Dave

>=20
> >      memory_region_init_ram_device_ptr(&tpmppi->ram, obj, "tpm-ppi",
> >                                        TPM_PPI_ADDR_SIZE, tpmppi->buf);
> >      vmstate_register_ram(&tpmppi->ram, DEVICE(obj));
> > --=20
> > 2.24.0.308.g228f53135a
> >=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


