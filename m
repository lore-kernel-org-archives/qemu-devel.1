Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52E6C3F2CE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 08:57:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8472720674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 08:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8ReyUz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8472720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE82v-0005JE-Op
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 04:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jE82E-0004tL-Qe
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jE82A-0005KZ-TP
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:57:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22223)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jE82A-0005Bz-J2
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584435429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fT2EDnyJ6YoBm46yocsuFCVo6kMvPpzmPtAv90IVxFA=;
 b=X8ReyUz8LUtfa98FpiABgaNKVQbjwUikVUADovFIAudKZGckN6ABwvy+LpO8bbBsgHOli7
 oz5epx5RWiFU5MHcM0qVVNPp6g15iX3YMAuJnnB7dY+vi/pKFwN5T76kSbxVgZWvaP4TiP
 V+4QvJuppO/ONCOPdjve2RAFOOPqL0Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-gB7GD_neMFa_jgeh1LWIMQ-1; Tue, 17 Mar 2020 04:57:08 -0400
X-MC-Unique: gB7GD_neMFa_jgeh1LWIMQ-1
Received: by mail-wm1-f72.google.com with SMTP id i24so4896195wml.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 01:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NCMI3690fbVF46qhvyZiBzM/HnbcNn308/4UMZs7SGk=;
 b=jE8CgRGo4z30Myoul5PpqFGL2T60VMoPkf2JWjATHRhq+chpixqi0dBLDqC8wdGCZn
 A6SgJ6R47qmJdJO9StZ2xkAk/fjhUukUsT6loQzmhSgozHRE4nWmeCnEvBECjtaJivmz
 aFxVFd5ajW6qEv4xDE/5uokjKWp7MaKirDKMkXtFGNFGGjNM/7RYUHW6suYjyQHo9InC
 u5K5cWTtAFJuGDUvZL77xUNzrfXo9FMfYJbZT3eP1Q1tAF58VR0jgoDs4rZzJs8YX2TO
 j1PTSg9pxCPyz39Ih3mGpg9yOKvaZBiehzRJszvlgsp/K5VnpuJS0Ayl7Oeh15RMal46
 u4YA==
X-Gm-Message-State: ANhLgQ1SU1lFz1x74HZaVt2/p0kmWTmsjkQ53+GRmEYXssoHPQWZFF8N
 DWEoxs9b9RWu+SZE4pnimIr/OGlJvKU/U1Uz0RKjoA475oU/a4U1OK9CCEd+PZR3DYIVhNrdGMJ
 dZUthXKSR0v4d70c=
X-Received: by 2002:a1c:a750:: with SMTP id q77mr4093681wme.120.1584435427305; 
 Tue, 17 Mar 2020 01:57:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv2OcW2Dh/lLFFk9N7n6QcFkK0vcPwVAE/b4ehbwIkQ2PomzppIM6RI8SI7bfzd8+b64bRKqA==
X-Received: by 2002:a1c:a750:: with SMTP id q77mr4093655wme.120.1584435427049; 
 Tue, 17 Mar 2020 01:57:07 -0700 (PDT)
Received: from redhat.com (bzq-109-67-31-208.red.bezeqint.net. [109.67.31.208])
 by smtp.gmail.com with ESMTPSA id g7sm3725391wrq.21.2020.03.17.01.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 01:57:06 -0700 (PDT)
Date: Tue, 17 Mar 2020 04:57:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v4 0/6] reference implementation of RSS and hash report
Message-ID: <20200317045655-mutt-send-email-mst@kernel.org>
References: <20200316100933.11499-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20200316100933.11499-1-yuri.benditovich@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: yan@daynix.com, jasowang@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 16, 2020 at 12:09:27PM +0200, Yuri Benditovich wrote:
> Support for VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT
> features in QEMU for reference purpose.
> Implements Toeplitz hash calculation for incoming
> packets according to configuration provided by driver.
> Uses calculated hash for decision on receive virtqueue
> and/or reports the hash in the virtio header

Patches 1-5:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> Changes from v3
> Use pointer for indirections table instead of array
> Cosmetic changes per v3 review
>=20
> Changes from v2:
> Implemented migration support
> Added implementation of hash report
> Changed reporting of error during processing of command
> (per review of v2)
> Cosmetic changes per v2 review
>=20
> Yuri Benditovich (6):
>   virtio-net: introduce RSS and hash report features
>   virtio-net: implement RSS configuration command
>   virtio-net: implement RX RSS processing
>   tap: allow extended virtio header with hash info
>   virtio-net: reference implementation of hash report
>   virtio-net: add migration support for RSS and hash report
>=20
>  hw/net/trace-events            |   3 +
>  hw/net/virtio-net.c            | 437 +++++++++++++++++++++++++++++++--
>  include/hw/virtio/virtio-net.h |  16 ++
>  net/tap.c                      |  11 +-
>  4 files changed, 439 insertions(+), 28 deletions(-)
>=20
> --=20
> 2.17.1


