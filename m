Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AD8C352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 10:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5060C2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 10:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eoipgtmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5060C2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j15vp-0006eS-F3
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 05:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j15ub-0005lA-HQ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:03:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j15ua-0000NQ-47
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:03:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60642
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j15ua-0000ME-0o
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581329006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZjQqRzdzg+WflgdYqNTxILvR89Vqzwk+EBS2DisVZ0=;
 b=EoipgtmfYXYvPEVPrAcF90NQCHveQnyjX4bZsjui+p0C89DlcB946zwxKfECpspmUg2tPV
 n12gls55xNE7i4/yEXslDDhhKtEAKE0uA0H63yeKCiqm0dEpVcA4wmjbyvSGMyJPTCOo3p
 inAG/XQZHHSgCrviYAd8qQnev/1PWgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-LVcXgfryMrmDbBh72SUNqw-1; Mon, 10 Feb 2020 05:03:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D61C800D53;
 Mon, 10 Feb 2020 10:03:20 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C37D07FB60;
 Mon, 10 Feb 2020 10:03:15 +0000 (UTC)
Date: Mon, 10 Feb 2020 11:03:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH v3 13/13] hw/arm/raspi: Extract the cores count from the
 board revision
Message-ID: <20200210110313.5f692138@redhat.com>
In-Reply-To: <20200208165645.15657-14-f4bug@amsat.org>
References: <20200208165645.15657-1-f4bug@amsat.org>
 <20200208165645.15657-14-f4bug@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: LVcXgfryMrmDbBh72SUNqw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat,  8 Feb 2020 17:56:45 +0100
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> The board revision encode the count of ARM cores. Add a helper
s/encode/encodes/
Or better
the count of ARM cores is encoded in ...


> to extract the number of cores, and use it. This will be helpful
> when we add the Raspi0/1 that have a single core.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/raspi.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index bee6ca0a08..90ad9b8115 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -101,6 +101,21 @@ static const char *board_soc_type(uint32_t board_rev=
)
>      return soc_types[proc_id];
>  }
> =20
> +static int cores_count(uint32_t board_rev)
> +{
> +    static const int soc_cores_count[] =3D {
> +        0, BCM283X_NCPUS, BCM283X_NCPUS,
> +    };
> +    int proc_id =3D board_processor_id(board_rev);
> +
> +    if (proc_id >=3D ARRAY_SIZE(soc_cores_count) || !soc_cores_count[pro=
c_id]) {
> +        error_report("Unsupported processor id '%d' (board revision: 0x%=
x)",
> +                     proc_id, board_rev);
> +        exit(1);
> +    }
> +    return soc_cores_count[proc_id];
> +}
> +
>  static const char *board_type(uint32_t board_rev)
>  {
>      static const char *types[] =3D {
> @@ -307,9 +322,7 @@ static void raspi_machine_class_init(ObjectClass *oc,=
 void *data)
>      mc->no_parallel =3D 1;
>      mc->no_floppy =3D 1;
>      mc->no_cdrom =3D 1;
> -    mc->max_cpus =3D BCM283X_NCPUS;
> -    mc->min_cpus =3D BCM283X_NCPUS;
> -    mc->default_cpus =3D BCM283X_NCPUS;
> +    mc->default_cpus =3D mc->min_cpus =3D mc->max_cpus =3D cores_count(b=
oard_rev);
>      mc->default_ram_size =3D board_ram_size(board_rev);
>      if (board_version(board_rev) =3D=3D 2) {
>          mc->ignore_memory_transaction_failures =3D true;


