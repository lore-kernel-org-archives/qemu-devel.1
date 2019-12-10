Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4994EC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 133F22077B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMMXiQv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133F22077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iel3C-00085U-88
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 14:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iel1Y-0006om-M6
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iel1X-0001K8-IP
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:18:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29266
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iel1X-0001Ju-EZ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576005499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c3++B6jGigoLFuo/3hQZOpMhqfas1y5qS8ZZuYwehX0=;
 b=aMMXiQv2M5zit0TLB6GOuOQgrxzGIJ/InfCvvcDt8Z21VuM8rYbU9rUX1AOau1/9FrXHFa
 uWcZJ4Hlk0Z1K3iYHUpLBVFEHqUKx1F6x/z7pX6q4D1+yVB9CKqAAl+6VP40PvU22qf/tE
 ad7uKvQVZ2IYf0vO5/Y+TA7zhVOEb1o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-e-ZNxJi8MbGRij8V2qeHog-1; Tue, 10 Dec 2019 14:18:17 -0500
Received: by mail-qv1-f69.google.com with SMTP id r8so7507133qvp.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 11:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=71U6KlP9jDk1ZWVrATst8QhUNwH9m6eIUrRigEc9LaE=;
 b=L/uSQKtdCrVbSEdr/XUrBHF8XIA2b453cKWyDavkLLKVnRqjG9TeqnHwPl79IZnv8M
 HVHzeT300Y1HOpYZqZkTTfPLS89GTfpaMg44DHi2fflY6pNGYN5dEEM0xCkQRAUIaTBU
 GeUVSFaokjtdvFcQFJhukwWlvu3HkbEcRSCfPyDXorfp7uJYRlgJNh7R3Lu8ZRsq3uaQ
 IZwOdRQRXoQF9F3CDrasr0Zn5s9lOdOEE3LoJso1Rc4/m6K+aIwWP2SAaJnC17FzBlmE
 Ax4sm1i4S4aLOPMVBu8Yr4wUqkHXGSNRdvTyhuwKs1rINM9rvzBxd3zzDAVyD5TDA8YF
 nheg==
X-Gm-Message-State: APjAAAX40RkigrTcBl2nMScxA2Zj68jTt9boXc+RvY0UgaIO96ZT/3ZU
 SVFF8zGRzFdOm87/SkKe/HS+v9PKNPf1ixmz75xi9ZmWdWNWACdMQNKMqDNSjC/JkULqRn1Dz02
 KRWiYuNpbFQNuao8=
X-Received: by 2002:aed:3ac6:: with SMTP id o64mr32220046qte.219.1576005497137; 
 Tue, 10 Dec 2019 11:18:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqzjGUdBcIM4JgpryqhUhkVAonqfsXZjPyRrrQIqrpRP0Gvo8pW6ggjTVBWB0P1+jWL3uKrGGQ==
X-Received: by 2002:aed:3ac6:: with SMTP id o64mr32220030qte.219.1576005496972; 
 Tue, 10 Dec 2019 11:18:16 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id q30sm1387181qtd.5.2019.12.10.11.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 11:18:16 -0800 (PST)
Date: Tue, 10 Dec 2019 14:18:14 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 04/20] virtio-iommu: Add the iommu regions
Message-ID: <20191210191814.GI3352@xz-x1>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-5-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191122182943.4656-5-eric.auger@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-MC-Unique: e-ZNxJi8MbGRij8V2qeHog-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 07:29:27PM +0100, Eric Auger wrote:
> This patch initializes the iommu memory regions so that
> PCIe end point transactions get translated. The translation
> function is not yet implemented though.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Either with/without Jean's comment addressed:

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


