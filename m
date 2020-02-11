Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04C2C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 10:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E6E20714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 10:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpnBIj0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E6E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Sft-00029i-LO
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 05:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1Set-0001IT-59
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1Seq-0001J3-VQ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:20:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29760
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1Seq-0001IO-LZ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581416443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1s72C7ex/dMKuhxXF26CRUSjnLXZ1e0+ts0EdmugKmo=;
 b=ZpnBIj0gUN/krej4r8P4Uoj+Qz46PpzkZlOwaLxD44r0hsdY6C3BQcKZB1xGWDFUZF4OMN
 cTiB2MjlFIjge0KNBE432JrZxHVuZxTJR0aUrjgXsX+PQv2zIKNMrdmS6OxwUhW3Xb0m/X
 1d6Rfjn2Mn+aZK0n7KiRnYF3V4b9f3Y=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-Wn0wTThpPgGwu9wJ-2ZV1Q-1; Tue, 11 Feb 2020 05:20:41 -0500
Received: by mail-qk1-f200.google.com with SMTP id b23so6737785qkg.17
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 02:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=feQUUY6fJhQS0CpdNBDw+Mk6D8Vvj4K1BxtqjKhBPzE=;
 b=nnl1vkfBMdSmeRcrhSJqs3VMvbaqxIyAu2IbOqmczjKUoP9Fu1rv2nw6FC0xjTLQqw
 5Kz5Q0eiuLvLs9gK070XseM/GE07nJaFzaVdxazb1UYzAw+nBh9EaEA75Cg9AI+SBRhD
 bexdCucxOFzx0hb33Hqto1ct/loUO6WrQST+PeJE8Dmuz5dTm1e/cm73T96pG8HoCYwK
 KzEGmAs9E5TTuDfaqZhmN+lpLTf0vNilEwmL63aepwKBPgCoJwoAd36UfvEC0i0gc+WJ
 FxXf35cfBduKZfhq0niaCv095ZHaQx+8K+PAdUQMEVF2VGT717UhL2WXNhbO/HGmK3kj
 fTOQ==
X-Gm-Message-State: APjAAAUx8Uhal/P+9rh8Jn26bMKF3IxfIeOx0ti2iVpHl5WcBccUZmkh
 /wAAdyRp800ULnxlN56Re8TtlMmSVt53DEEkPMeivxyEiyTFmNMFEE25yUzYs9ogxNok4HxKxBH
 iExkI00ObmUiQA/g=
X-Received: by 2002:ae9:e209:: with SMTP id c9mr4250188qkc.363.1581416441311; 
 Tue, 11 Feb 2020 02:20:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqxE/sU068BeKu2mek+4WU5NDGNB5mtqTMmGP9miz5EtdX3cLS7jhZncz33Fvm/ZTQMJKErZ2A==
X-Received: by 2002:ae9:e209:: with SMTP id c9mr4250177qkc.363.1581416441019; 
 Tue, 11 Feb 2020 02:20:41 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id 65sm1852688qtf.95.2020.02.11.02.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 02:20:40 -0800 (PST)
Date: Tue, 11 Feb 2020 05:20:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 7/7] tests/bios-tables-test: Update arm/virt memhp test
Message-ID: <20200211051953-mutt-send-email-mst@kernel.org>
References: <20200117174522.22044-1-shameerali.kolothum.thodi@huawei.com>
 <20200117174522.22044-8-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200117174522.22044-8-shameerali.kolothum.thodi@huawei.com>
X-MC-Unique: Wn0wTThpPgGwu9wJ-2ZV1Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com,
 shannon.zhaosl@gmail.com, qemu-devel@nongnu.org, xuwei5@hisilicon.com,
 linuxarm@huawei.com, eric.auger@redhat.com, qemu-arm@nongnu.org,
 imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 17, 2020 at 05:45:22PM +0000, Shameer Kolothum wrote:
> Since we now have both pc-dimm and nvdimm support, update
> test_acpi_virt_tcg_memhp() to include those.
>=20
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

And you can add a last patch on top updating the
expected files and blowing out the allowed diff file.
include the ASL changes in the log ...

> ---
>  tests/data/acpi/virt/NFIT.memhp | 0
>  tests/data/acpi/virt/SSDT.memhp | 0
>  tests/qtest/bios-tables-test.c  | 9 +++++++--
>  3 files changed, 7 insertions(+), 2 deletions(-)
>  create mode 100644 tests/data/acpi/virt/NFIT.memhp
>  create mode 100644 tests/data/acpi/virt/SSDT.memhp
>=20
> diff --git a/tests/data/acpi/virt/NFIT.memhp b/tests/data/acpi/virt/NFIT.=
memhp
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/virt/SSDT.memhp b/tests/data/acpi/virt/SSDT.=
memhp
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
> index f1ac2d7e96..695d2e7fac 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -913,12 +913,17 @@ static void test_acpi_virt_tcg_memhp(void)
>      };
> =20
>      data.variant =3D ".memhp";
> -    test_acpi_one(" -cpu cortex-a57"
> +    test_acpi_one(" -machine nvdimm=3Don"
> +                  " -cpu cortex-a57"
>                    " -m 256M,slots=3D3,maxmem=3D1G"
>                    " -object memory-backend-ram,id=3Dram0,size=3D128M"
>                    " -object memory-backend-ram,id=3Dram1,size=3D128M"
>                    " -numa node,memdev=3Dram0 -numa node,memdev=3Dram1"
> -                  " -numa dist,src=3D0,dst=3D1,val=3D21",
> +                  " -numa dist,src=3D0,dst=3D1,val=3D21"
> +                  " -object memory-backend-ram,id=3Dram2,size=3D128M"
> +                  " -object memory-backend-ram,id=3Dnvm0,size=3D128M"
> +                  " -device pc-dimm,id=3Ddimm0,memdev=3Dram2,node=3D0"
> +                  " -device nvdimm,id=3Ddimm1,memdev=3Dnvm0,node=3D1",
>                    &data);
> =20
>      free_test_data(&data);
> --=20
> 2.17.1
>=20


