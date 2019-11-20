Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BF2C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DD0520674
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hh3ZTSoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD0520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSZV-0000pF-B4
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iXSLJ-0005V7-6p
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iXSLH-00044c-TH
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:56:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49667
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iXSLH-00044O-Pa
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574265390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tVRKRRK3FGt+XivNgAdKhvbSv5nDErdoLTLlWuEPupg=;
 b=hh3ZTSoICJXIMCTXfZHpWqXBM8CDvNrAmB9DrhETeTYIY5PHbW1nAKQcBiO9AlA2DFavL4
 rlPKml2/o/9sQbnnVOMlHZPw/mRkUEyk6wnl4NgCbF1UM5EawmyoRMb03NyXpJN9eQelp4
 Wm2GHTuKcoEcFP9XyCLtwciPo+gRTl4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-9Uu8OhvVNr6STdGhkflT_g-1; Wed, 20 Nov 2019 10:56:27 -0500
Received: by mail-qt1-f197.google.com with SMTP id b26so107916qtr.23
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 07:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fYaMb6ycYvZvmfQnZJxPFTE+guLCMQQb8omBaCS+GYQ=;
 b=Jbw/uC+6DVsu+zjkC1fqgyzylviEPDcParJo2Fpl9Bf0VZE3t+a3lQsNPoIYVoApU/
 MFk6o1AJdkxLyPoPBwO2bTIBxtOa5En8XX0GJnX09yDJwAUmeFSwVUD3Ad3CwRIfmfsb
 iaBPwmF5rwHhBk+qDv7QUsqR9WmxwqFOsTRn6VA3szP5WQzYozOTHXl8LfFN5w2O+/qI
 zJKTomzz1FwXUmmqqrqEA38/WWWKYV7kXm9VoICm9/bneMFAWf47cvASwsekSBUo2VyG
 +0zAZGKVFP9Zb5yxHkBahJbXcdJteIl5WNfEMqRa8ArCOarmqffpSq/JD35Ku3HJXQa0
 yNmA==
X-Gm-Message-State: APjAAAWOE8Ygrx+yw/7K4xFlG+7pkeVoOr4wfJn+2KckuRzh0PEVUkZN
 1z7SKWXFhva9YPw7t2vY34+IAypOfnvBj1WePAyh4x7wvUbG6UkemrM5J1a1nijjfP2TwQ2mSor
 tr1EccKRD1w8DJzk=
X-Received: by 2002:ae9:ef50:: with SMTP id d77mr3102730qkg.430.1574265386658; 
 Wed, 20 Nov 2019 07:56:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqwhdWs5ueyfFu0lop01+iecvl9Cll1hU+O/S8erqV0x8NDR6Fs9ONMgak2KIKa4XyAZOUfsUA==
X-Received: by 2002:ae9:ef50:: with SMTP id d77mr3102709qkg.430.1574265386474; 
 Wed, 20 Nov 2019 07:56:26 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id u22sm14761421qtb.59.2019.11.20.07.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 07:56:25 -0800 (PST)
Date: Wed, 20 Nov 2019 10:56:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v3 0/4] net/virtio: fixes for failover
Message-ID: <20191120105606-mutt-send-email-mst@kernel.org>
References: <20191120154951.27877-1-jfreimann@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191120154951.27877-1-jfreimann@redhat.com>
X-MC-Unique: 9Uu8OhvVNr6STdGhkflT_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 04:49:47PM +0100, Jens Freimann wrote:
> This series fixes bugs found by coverity and one reported by David
> Gilbert.


Looks good.  Jason can you merge this pls?

> v2->v3:
>  * change patch description and subject of patch 3/4
>=20
> Jens Freimann (4):
>   net/virtio: fix dev_unplug_pending
>   net/virtio: return early when failover primary alread added
>   net/virtio: fix re-plugging of primary device
>   net/virtio: return error when device_opts arg is NULL
>=20
>  hw/net/virtio-net.c | 58 +++++++++++++++++++++++++++++----------------
>  migration/savevm.c  |  3 ++-
>  2 files changed, 40 insertions(+), 21 deletions(-)
>=20
> --=20
> 2.21.0


