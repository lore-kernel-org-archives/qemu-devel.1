Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE249C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 10:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895C020672
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 10:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bj7bGc96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895C020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inJnn-0006i0-T4
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 05:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1inJn4-00065r-Dy
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 05:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1inJn3-0001Vm-BZ
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 05:02:46 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34870
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1inJn3-0001Sx-3v
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 05:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578045764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=krQtQVAd0GGGlfhxNdsGBWJX6kugDPJ7Jiuev0ph14A=;
 b=Bj7bGc96yovPw9z+Xqo9lZu1VbnZJxdj8A+A96oGaIhRAureJJak9po4ZNqhvTwY/taniq
 WFXfyd21J+OwTLTbT53b2WwwTGjS+KcGxsTE4J6TRHqjkel4n+qGZ4SjK3rObj7wjbephP
 bzd6f9Hs4eElmWGly9iXAJSq5SjOZeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-NxF2Dq0tOZaU7LwlkB9BQg-1; Fri, 03 Jan 2020 05:02:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 442B4108838B;
 Fri,  3 Jan 2020 10:02:40 +0000 (UTC)
Received: from work-vm (ovpn-117-78.ams2.redhat.com [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A54477BFB0;
 Fri,  3 Jan 2020 10:02:36 +0000 (UTC)
Date: Fri, 3 Jan 2020 10:02:33 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 2/3] tpm-ppi: page-align PPI RAM
Message-ID: <20200103100233.GA3804@work-vm>
References: <20200103074000.1006389-1-marcandre.lureau@redhat.com>
 <20200103074000.1006389-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200103074000.1006389-3-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: NxF2Dq0tOZaU7LwlkB9BQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> post-copy migration fails on destination with error such as:
> 2019-12-26T10:22:44.714644Z qemu-kvm: ram_block_discard_range:
> Unaligned start address: 0x559d2afae9a0

Ah good, we got a sane error message!

> Use qemu_memalign() to constrain the PPI RAM memory alignment.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  hw/tpm/tpm_ppi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
> index ff314592b4..6d9c1a3e40 100644
> --- a/hw/tpm/tpm_ppi.c
> +++ b/hw/tpm/tpm_ppi.c
> @@ -43,7 +43,8 @@ void tpm_ppi_reset(TPMPPI *tpmppi)
>  void tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
>                    hwaddr addr, Object *obj)
>  {
> -    tpmppi->buf =3D g_malloc0(HOST_PAGE_ALIGN(TPM_PPI_ADDR_SIZE));
> +    tpmppi->buf =3D qemu_memalign(qemu_real_host_page_size,
> +                                HOST_PAGE_ALIGN(TPM_PPI_ADDR_SIZE));

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>      memory_region_init_ram_device_ptr(&tpmppi->ram, obj, "tpm-ppi",
>                                        TPM_PPI_ADDR_SIZE, tpmppi->buf);
>      vmstate_register_ram(&tpmppi->ram, DEVICE(obj));
> --=20
> 2.24.0.308.g228f53135a
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


