Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4F2C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:35:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A80C420737
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHS0Yu7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80C420737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSfl-0002Fa-4N
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jHScc-0006TI-HV
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jHScb-00074r-Ib
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:32:34 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:46659)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jHScb-00074n-Ev
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585229553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btksyhb6+vAKZRoL2HHqaV/Td0srS+PW7Y6H5rJOk08=;
 b=iHS0Yu7paGkl2QP9uahf7c/lc9g01+jde2G4VEchHNkK1CL0D8sOs6nb3vLWzyLV2bNHWa
 CupLhhYfLL0Nejsi0W+XUMuqowLoxBgu9TpYu+ec38ZZSVKXHSe0kHMiQ45ZyOJAp9+kgr
 Y71SAYCpeT+3qdkzLamH9RGLaXjZv+c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-W12Og1-WNU-xLNVwTc7Bhw-1; Thu, 26 Mar 2020 09:32:31 -0400
X-MC-Unique: W12Og1-WNU-xLNVwTc7Bhw-1
Received: by mail-wr1-f69.google.com with SMTP id d17so3025830wrs.7
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 06:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9IzYUeTOPabeIIfbTY749K095rI94tBoejFOooMkO0Q=;
 b=ZzzyAt5jhLSFsnKR3fnFMI4naXSvCAdoHKXgOigdwpSijlsVgG4CIhvipTc5M/55+j
 8YEVU/MjM5vZ4aWLTb8DB6TxDj/aPTB0SCV/HR5GvRLi3rKnKvtcMkZpAf4PW/GCc4/7
 qwNPU4Y2pW6DjICd2hR0C2V4/bFsObL1qB2FEM++ZHKvH1PENxjgfVhp384O24iVllmz
 i9a4hNPIGF/WIWu6O4VvF/bRjP5GCtDu6LA5TTvjUhn39zgT+6rqGszWbKcS2aWJxcls
 B7yYE2AVozpsejckBgOZHU3l9Ar0weeqzAYew655W4iiLNBBij41b4cInCQi1SAHxwRP
 emyA==
X-Gm-Message-State: ANhLgQ2V3W7LP+6lbSZWdV4oWZyWQbdU6GqQMvhebi1HGSXY9Lg2K1lh
 iHrICs8Kq7WhjcqfOIihWFgnYKfz6W+J9nS61NKeDgwodeXj9+0XfsNYI2u0mV3ra1pedxiwtun
 uxQc+0zdlEZfLBvc=
X-Received: by 2002:a5d:5447:: with SMTP id w7mr9317986wrv.299.1585229550081; 
 Thu, 26 Mar 2020 06:32:30 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs1KfauaHN7y4Rvy6g9rj0kXW32FbxsJ0nVEbAOaMZwa6TTqgUX7aeZWSA+O26mxKs6MLnzVQ==
X-Received: by 2002:a5d:5447:: with SMTP id w7mr9317965wrv.299.1585229549874; 
 Thu, 26 Mar 2020 06:32:29 -0700 (PDT)
Received: from redhat.com (bzq-109-67-62-195.red.bezeqint.net. [109.67.62.195])
 by smtp.gmail.com with ESMTPSA id x206sm3575249wmg.17.2020.03.26.06.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 06:32:29 -0700 (PDT)
Date: Thu, 26 Mar 2020 09:32:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v6 0/7] reference implementation of RSS and hash report
Message-ID: <20200326093217-mutt-send-email-mst@kernel.org>
References: <20200320115751.19446-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20200320115751.19446-1-yuri.benditovich@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: yan@daynix.com, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 20, 2020 at 01:57:44PM +0200, Yuri Benditovich wrote:
> Support for VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT
> features in QEMU for reference purpose.
> Implements Toeplitz hash calculation for incoming
> packets according to configuration provided by driver.
> Uses calculated hash for decision on receive virtqueue
> and/or reports the hash in the virtio header

Series:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> Changes from v5:
> RSS migration state moved to subsection and migrated
> only if enabled (patch 7)
> Updated sign off (patch 6)
>=20
> Yuri Benditovich (7):
>   virtio-net: introduce RSS and hash report features
>   virtio-net: implement RSS configuration command
>   virtio-net: implement RX RSS processing
>   tap: allow extended virtio header with hash info
>   virtio-net: reference implementation of hash report
>   vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC macro
>   virtio-net: add migration support for RSS and hash report
>=20
>  hw/net/trace-events            |   3 +
>  hw/net/virtio-net.c            | 448 +++++++++++++++++++++++++++++++--
>  include/hw/virtio/virtio-net.h |  16 ++
>  include/migration/vmstate.h    |  10 +
>  net/tap.c                      |  11 +-
>  5 files changed, 460 insertions(+), 28 deletions(-)
>=20
> --=20
> 2.17.1


