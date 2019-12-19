Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A97C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFDBA20716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ds1YRyF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDBA20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvcq-000795-J6
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ihv0P-0003bA-1q
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ihv0N-0005JL-O4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:34:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51628
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ihv0N-0005HE-Ig
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YRNPtma/3WE/kvoa6afVUuYhFZ+t2zgVhExflDvAOjY=;
 b=ds1YRyF12jk54eUrb6lvv/MYVQyM2XpQ1yZjIU5NttYZYLMMgsdVuasnylmxZ4tmnHyfj3
 dSB8gY7DYZKUQN1/4sfApqILY1hoTEpx/jap4qudb1MIi8yDDbeQfA71kMOSt7nT+4uMFD
 BQG9tPGi0ktFgKmBtpxhJViUnEOYsjA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-LFEK7r3kMamoSMmC6Ct4UQ-1; Thu, 19 Dec 2019 07:34:06 -0500
Received: by mail-qk1-f198.google.com with SMTP id s9so3483206qkg.21
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 04:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AjXvfsZCkYMFAkb3r9vpjMS8Igac5xbX3o5d2D7sCkQ=;
 b=ax23esu396LPHzZkwKqyRggqxk3f77PtmeQeyEdadJZCEahqh4Mgm6JYrSum0rcOtq
 f5HIYybWeDonjg1aGEjyMFKxsyCa2mGYwxnAiox8cdQGXIGeyav5Gl6kDMCZFA+2HIfo
 3Ynw0sjB/E7V6ulC16IPKhsx5v4k1WcKnXPFS3TgAdmy3gVLyzmOl/hi8DqaRMZGtNKN
 5L3Ry3k5m1Hd+7HW3POmcBCXu5VyCQ1Tp0xvA5T1DxVg/t/ZSpcCtcrjvrfMVjgWYl1/
 Zx80ZLpu9EO+qfLPJ+izbdOsB3kV3ljEVfRCUugNrftJuukBBYEOmHndnQ62ryUyyUkc
 8siw==
X-Gm-Message-State: APjAAAVcewkM6A9V7N0cE9sHJ4+H1nIvfW5voQ/5/4EvHnJ0xmn0arhV
 iMNnJ/x+RJJMO35TRFwS5Rl5MknJF318xBzgMxMVbLclYvs+Ql2TFdMK52Jp0fUz0fKgdipjMC+
 q6btnUFKFFXS2o3o=
X-Received: by 2002:a05:6214:6f0:: with SMTP id
 bk16mr7347925qvb.23.1576758846407; 
 Thu, 19 Dec 2019 04:34:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqwhRknQm16GUWPU3clhApOYjgFwd8cWJtttiYPWUsMsDAiDWltgrT0G9EQ6ZYmV82noqmEPmQ==
X-Received: by 2002:a05:6214:6f0:: with SMTP id
 bk16mr7347904qvb.23.1576758846198; 
 Thu, 19 Dec 2019 04:34:06 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id t15sm1674215qkg.49.2019.12.19.04.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 04:34:05 -0800 (PST)
Date: Thu, 19 Dec 2019 07:34:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [PATCH 0/2] Some cleanup in arm/virt/acpi
Message-ID: <20191219073344-mutt-send-email-mst@kernel.org>
References: <20191219064759.35053-1-guoheyi@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20191219064759.35053-1-guoheyi@huawei.com>
X-MC-Unique: LFEK7r3kMamoSMmC6Ct4UQ-1
X-Mimecast-Spam-Score: 0
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 02:47:57PM +0800, Heyi Guo wrote:
> Remove useless device node and conflict _ADR objects in ACPI/DSDT.
>=20
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-devel@nongnu.org

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Pls feel free to merge through ARM tree.

> Heyi Guo (2):
>   arm/virt/acpi: remove meaningless sub device "PR0" from PCI0
>   arm/virt/acpi: remove _ADR from devices identified by _HID
>=20
>  hw/arm/virt-acpi-build.c          |  12 ------------
>  tests/data/acpi/virt/DSDT         | Bin 18462 -> 18426 bytes
>  tests/data/acpi/virt/DSDT.memhp   | Bin 19799 -> 19763 bytes
>  tests/data/acpi/virt/DSDT.numamem | Bin 18462 -> 18426 bytes
>  4 files changed, 12 deletions(-)
>=20
> --=20
> 2.19.1


