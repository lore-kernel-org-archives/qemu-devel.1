Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC158C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955AF22525
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hjIzeBbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955AF22525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrJr-0006AZ-E7
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 08:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1icrG6-0003CK-Ua
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:33:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1icrG5-0002P6-Rk
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:33:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57323
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1icrG5-0002Lj-Md
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575552808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTbxbi09I5fekj43Jiszpo4riQGbRYc44vGiv572pHs=;
 b=hjIzeBbBMD0sdOUTxt/Pm9Qo020nUYH5Rxx4kLUdDcPQY6S9AwUY9xx34wYwISqoErhxKU
 O6/n7H7kgjh95cHDfRUzjT8EFsq8Xg1uIYk+T9mOScP8j8SbAEfYaPv1CX4feZWCetm9Gc
 Ja7Bb9wIqDPWpt62BCh1Ql/c/aAun8k=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-3PbrsmZ0Poi2bufCkm8Q-g-1; Thu, 05 Dec 2019 08:33:27 -0500
Received: by mail-qt1-f197.google.com with SMTP id d9so2457642qtq.13
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 05:33:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vqdCMx1izWT0f8k6huFLL52OUMuO6R8bT94Oz4RIfkI=;
 b=R307teO1xZeADc5xkEPJ97asuLlAqkdZe48PECoqh5XW3RRwWWAiaZGHZaKwaZacWR
 ISk9JlvgL0MzCWza44OAHv5duQG2eErYputWzlM8N6Bl2959yL8Fw5nu6by3R8w6UwL6
 pkQ7TuIgL4/gJ0wcV9LP/2tJz895ds7ncNCp0p8HdaYI8YZuLIVjkYbclrMsIV6fgt0X
 lfTUi6QI2ff+Sn/4SLoaNNSfuWlLpALH765j0HFrFOTiGllG42rMLzwTUNkZ6UjhwjvH
 yg2Ve1/t6rDfn3jFqpjSgJSfnamlxZ0+xm3w/xdbRAg01ZoqJgVo9tsSUJkANTE588Aw
 xBHg==
X-Gm-Message-State: APjAAAUWn1WTeZkIc4rJBj9w391KFFjyiHqY/ukSVrkmJAe/GizdzJCk
 pIjsDPsm370UvH+fhmP2rSNqXvY1Rvm0BoH7p7uWjPuzPHaS/3HuMm/DywgXBV0HjCI95MLN2t3
 8tCXtPH+3mtTS3N8=
X-Received: by 2002:a05:620a:1eb:: with SMTP id
 x11mr8569309qkn.254.1575552807229; 
 Thu, 05 Dec 2019 05:33:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqxPy4apWYHQi/c0t3hpW6tkxRPCxU++ZmSW+Mz60OHReJT+15lZ2FNbxrHOnE1B7FEcgmRxUg==
X-Received: by 2002:a05:620a:1eb:: with SMTP id
 x11mr8569280qkn.254.1575552806978; 
 Thu, 05 Dec 2019 05:33:26 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:3f::3])
 by smtp.gmail.com with ESMTPSA id r200sm3319396qke.68.2019.12.05.05.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2019 05:33:25 -0800 (PST)
Date: Thu, 5 Dec 2019 08:33:24 -0500
From: Peter Xu <peterx@redhat.com>
To: Yi Sun <yi.y.sun@linux.intel.com>
Subject: Re: [PATCH v1] intel_iommu: fix bug to read DMAR_RTADDR_REG
Message-ID: <20191205133324.GB9673@xz-x1>
References: <20191205095439.29114-1-yi.y.sun@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191205095439.29114-1-yi.y.sun@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: 3PbrsmZ0Poi2bufCkm8Q-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 05, 2019 at 05:54:39PM +0800, Yi Sun wrote:
> Should directly read DMAR_RTADDR_REG but not using 's->root'.
> Because 's->root' is modified in 'vtd_root_table_setup()' so
> that the first 12 bits are omitted. This causes the guest
> iommu debugfs cannot show pasid tables.
>=20
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


