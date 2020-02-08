Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFF2C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C13A21741
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZnwOYwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C13A21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0QOO-0000fc-AL
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 08:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j0QN0-00080y-Ri
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 08:42:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j0QMy-0006E3-Qg
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 08:42:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37770
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j0QMy-0006Cn-MQ
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 08:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581169320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7hTkU97E43YATmx6OfAiwt/jQnFE0FV/B1tScVLFLWw=;
 b=JZnwOYwxITDGjMx75T4Fe3UuoBivwBS9fd+dylJg8z1ctZu1KWgeMC5OkrKcqePRcktwVu
 eXJheub084t//t5WtrduwydhkfAmU3cYb+RySRvNfp2F19/06hdahwO4PxcsQYtwXLwaSm
 jBINBuTppdF76e4d6oYpZQ/BsDqnz1E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-Z--puu9vMqCAy588PMmIlA-1; Sat, 08 Feb 2020 08:41:58 -0500
Received: by mail-qv1-f72.google.com with SMTP id cn2so1515097qvb.1
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 05:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YKFimlBCt0tode6uI7G4ZnKvAwhYl19BYX1ehrjhP44=;
 b=NoDnxaCbcVAxauARS8f3WQgxLIhMMMlLQWziBmOYlPC1Z5mq2H+XoN5uGAceT7qCt0
 wpGbG2efFmwa1qTlDS0PmXJuWKja5TULFuNgvx7TUN9HID9HlDt2JC26wwzFxnkyORCl
 jhKka6Iluei96FqahKMVDQRPFgW9wkIHl9LXGtg/79d22OmwkytRQ7EtZo5gS2jxZIxs
 CLk3RiPkifLKk8v3G0Izd/Wyxyv6ADQ6L+tx7ZwkPwF1l12s5mkmQL4vzlKaEa03C7RW
 yo0jyIKDy1gOt25Zosvl/vI76q5bnf4gW90Xa3tlgL8DlL+tBp79YKxVEbvyd/q4AW2z
 5mtQ==
X-Gm-Message-State: APjAAAUy+LsjZPteqjIXmelhGlB0iiZ1nhSRfsvHsw79EXy4uXEDW+jJ
 MepQHuzX0sqEBLwy99woGcJkFKfLJeRpSH7EXEme/1qnEAKLJimWlkp8WLx8xECX5W8hMCgxlFW
 PSIY+hpSZd5RLLQs=
X-Received: by 2002:a0c:f193:: with SMTP id m19mr2749207qvl.154.1581169318167; 
 Sat, 08 Feb 2020 05:41:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqwV+pv4tCtzk9/cElKl4tF3YCVH7K6ZmHcIRKu5R10pCEiEzj8afZeYiLKdoz8RGibTYEsP0A==
X-Received: by 2002:a0c:f193:: with SMTP id m19mr2749191qvl.154.1581169317955; 
 Sat, 08 Feb 2020 05:41:57 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id r37sm3054538qtj.44.2020.02.08.05.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 05:41:57 -0800 (PST)
Date: Sat, 8 Feb 2020 08:41:54 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v15 3/9] virtio-iommu: Implement attach/detach command
Message-ID: <20200208134154.GD823968@xz-x1>
References: <20200208120022.1920-1-eric.auger@redhat.com>
 <20200208120022.1920-4-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200208120022.1920-4-eric.auger@redhat.com>
X-MC-Unique: Z--puu9vMqCAy588PMmIlA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 mst@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Feb 08, 2020 at 01:00:16PM +0100, Eric Auger wrote:
> This patch implements the endpoint attach/detach to/from
> a domain.
>=20
> Domain and endpoint internal datatypes are introduced.
> Both are stored in RB trees. The domain owns a list of
> endpoints attached to it. Also helpers to get/put
> end points and domains are introduced.
>=20
> As for the IOMMU memory regions, a callback is called on
> PCI bus enumeration that initializes for a given device
> on the bus hierarchy an IOMMU memory region. The PCI bus
> hierarchy is stored locally in IOMMUPciBus and IOMMUDevice
> objects.
>=20
> At the time of the enumeration, the bus number may not be
> computed yet.
>=20
> So operations that will need to retrieve the IOMMUdevice
> and its IOMMU memory region from the bus number and devfn,
> once the bus number is garanteed to be frozen, use an array
> of IOMMUPciBus, lazily populated.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

(Hope this is the last one missing r-b besides patch 8, I'll leave
 patch 8 for the others or Michael when merging)

Thanks,

--=20
Peter Xu


