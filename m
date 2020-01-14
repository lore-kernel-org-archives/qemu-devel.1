Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3C8C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ADBB24655
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0FpqdrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADBB24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irRMe-0005W5-IK
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 13:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1irRLi-0004xQ-DT
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1irRLe-0007Jg-K9
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:55:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27141
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1irRLe-0007JR-Gm
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579028129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ttx8wCKDBH1eCxadZzRZloFU6gGuskBxM/MoipQ6vW4=;
 b=R0FpqdrNS/qVoCLzZzLkmEcphjUniSTKtF6HtRMq7WPALlVPhQ4R5IeCCCRapf6QNa/Z9a
 E5Qrtqs7lTPOpG/B1QZHOWXcPLjmmBdTlTiS8uTZ/xtqfCh2xGgZDhWciF8n3Dz6yO5hiI
 MFDli8DJLmaQrS6zZBiePifa/7Dr+Uc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-rRHlrgMoNWeYZo6Ch9YQPw-1; Tue, 14 Jan 2020 13:55:26 -0500
Received: by mail-qt1-f197.google.com with SMTP id l56so9545407qtk.11
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 10:55:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1Y99xzUgXTtHmmArnFdjZ5QIC8gpsaKjcndyu1C8r0s=;
 b=Lyqq3OT6FDbPj4wcvwZwAY58YxSupAEtfmCSk7u7R8x9RcCxuCjwSk4HAWBtQm68m4
 qGLzYyI347orya/fudTJrv773lKFj+tCSuWjfAhybLiVc+WMjiuqev94TLB0gLxLpEdI
 pMH/mfkAuZJYWiDRtEfxVkL7tQHy+vdA1fw0qPvRqhZsOxwVHGFGW8TxgNJOQ2qxvUNz
 qwmX6Yl2Ziq8H/cS5KpHrQNKgsK8Zv5pnBmelaFYjdJRM+Qzc/jrWwl5Fgm+UkgxTBll
 c5vmPYwA+03dZtPqpJrzj2mnGGinpV2/JjGDNUYFTjOu23lLff7MO3mAlOlckJ4A+7/N
 Avcw==
X-Gm-Message-State: APjAAAUIVawwtMJ63ZtBpMlyuvIKuG0TA3QAiUD+rPo7KQMxW4oLKeZh
 q5U/v50B3tYDe0IGe39xUmXK17tIY87JmihekxxV20ILTDyfe1tIsLXyMMSbwEiesuT+F50Nqzm
 /c+tifxGH1q3Psi0=
X-Received: by 2002:ac8:33a5:: with SMTP id c34mr5108098qtb.359.1579028126123; 
 Tue, 14 Jan 2020 10:55:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqxwlRhoIzKAb3/vu8UoNL5+UUHzb0rchSTzmPov/AczBHNkaDUlb945NvYdI4Gy8XOgySXvVw==
X-Received: by 2002:ac8:33a5:: with SMTP id c34mr5108084qtb.359.1579028125994; 
 Tue, 14 Jan 2020 10:55:25 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id n55sm1125960qta.91.2020.01.14.10.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 10:55:25 -0800 (PST)
Date: Tue, 14 Jan 2020 13:55:24 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v12 07/13] virtio-iommu: Implement map/unmap
Message-ID: <20200114185524.GD225163@xz-x1>
References: <20200109144319.15912-1-eric.auger@redhat.com>
 <20200109144319.15912-8-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200109144319.15912-8-eric.auger@redhat.com>
X-MC-Unique: rRHlrgMoNWeYZo6Ch9YQPw-1
X-Mimecast-Spam-Score: 0
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

On Thu, Jan 09, 2020 at 03:43:13PM +0100, Eric Auger wrote:
> This patch implements virtio_iommu_map/unmap.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


