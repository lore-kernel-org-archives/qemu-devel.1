Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC825C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B0420678
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPyl6YDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B0420678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipUx2-0007Rh-L7
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 05:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ipUwI-00070h-A0
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 05:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ipUwG-0001WK-Fq
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 05:21:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40800
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ipUwG-0001Rn-9J
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 05:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578565275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tz6apLSre/2RioPNoqROPU4xmcz2JKRcYLPVO64iAzA=;
 b=cPyl6YDBlqeb7/5FynlafHvgJj12j7KpOlpEP9cKF47XeqkgTsQKdWh/JRl3RY/qp1e0nB
 WmfXxrvCeDR/FJYYGD8wLdGH/VMBX9VDV60Z3L6cTXglGlFAveUEJodTr2XQHblqcmgIUj
 qG+UZ7m8lLGvtAYleEy9kXE3gX+UgGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-80Mx2TB8NXqo5aWpowdzEg-1; Thu, 09 Jan 2020 05:21:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EECC263CC1
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 10:21:12 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C15F47C464;
 Thu,  9 Jan 2020 10:21:06 +0000 (UTC)
Date: Thu, 9 Jan 2020 11:21:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/smbios/smbios: Use MachineState::ram_size instead of
 global one
Message-ID: <20200109112105.66cb5eaa@redhat.com>
In-Reply-To: <20200108233138.20434-1-philmd@redhat.com>
References: <20200108233138.20434-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 80Mx2TB8NXqo5aWpowdzEg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  9 Jan 2020 00:31:38 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> The smbios_get_tables() function has access the a machine state.
> Use the field instead of accessing the global ram_size variable.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/smbios/smbios.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 11d476c4a2..ded5f1f4e2 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -630,7 +630,7 @@ static void smbios_build_type_11_table(void)
> =20
>  #define MAX_T16_STD_SZ 0x80000000 /* 2T in Kilobytes */
> =20
> -static void smbios_build_type_16_table(unsigned dimm_cnt)
> +static void smbios_build_type_16_table(ram_addr_t ram_size, unsigned dim=
m_cnt)
>  {
>      uint64_t size_kb;
> =20
> @@ -847,6 +847,7 @@ void smbios_get_tables(MachineState *ms,
>                         uint8_t **anchor, size_t *anchor_len)
>  {
>      unsigned i, dimm_cnt;
> +    ram_addr_t ram_size =3D ms->ram_size;
> =20
>      if (smbios_legacy) {
>          *tables =3D *anchor =3D NULL;
> @@ -876,7 +877,7 @@ void smbios_get_tables(MachineState *ms,
> =20
>          dimm_cnt =3D QEMU_ALIGN_UP(ram_size, MAX_DIMM_SZ) / MAX_DIMM_SZ;
> =20
> -        smbios_build_type_16_table(dimm_cnt);
> +        smbios_build_type_16_table(ram_size, dimm_cnt);
> =20
>          for (i =3D 0; i < dimm_cnt; i++) {
>              smbios_build_type_17_table(i, GET_DIMM_SZ);


