Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5924AC10DAA
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA52218AC
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="TzNonolZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA52218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFvka-0006Hr-R2
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kFvhJ-0000aa-Hn; Wed, 09 Sep 2020 04:43:21 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kFvhH-0007rp-AU; Wed, 09 Sep 2020 04:43:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1599640986; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=hOIIb2uCkOzPwyGKGj03MMzTDkYP+MXfUhw0fCCbUvqhPyLB0BsEYOo+8x7mvNHy8dSONQZCVPhhuHctyesbKKueQmjTugFuXelO/8Ux0WRqpoKSGnl7SKXpIcD0gHcpkkByDONULL+o7IwSj0gM1SobZkhdfnxLiPEa1V9/LHA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1599640986;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=+LMPiyDSSs3Z6l3ICKMiB1XDjhXOf71JuIUDn4eKJco=; 
 b=MFk3wYG81OlS5jPHaQoX1Xe7BNN4G3BD/j8j9CxDOXQPW9G/8t3Si6AsiMr78b3j13WqzArCLeyWjD/SCnBMYVQPR3EFRSGLL1xhYXZIP9KVrIjvNWcUt7uYezBt47AFGjqVAtS9IKNyvzitV0AwzYeTkU3zVbbvURkrmtrK2nA=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=euphon.net;
 spf=pass  smtp.mailfrom=fam@euphon.net;
 dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1599640986; 
 s=zoho; d=euphon.net; i=fam@euphon.net;
 h=Date:From:To:Cc:Message-ID:Subject:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
 bh=+LMPiyDSSs3Z6l3ICKMiB1XDjhXOf71JuIUDn4eKJco=;
 b=TzNonolZYTZpCxNy8XVC2kFe7MwFuBJg3N7dMPPB1c0gYxYkxaNyusBp/6beHqec
 v0kDWPr2ujKTJX5DcDX2QkSBgP4O8BaegvcmCZRRsB7U9Ri/kw0KqTZtkageGsJlSNB
 CpuCokEWUec+DxafTWuJRE/EOswkdcdQnhS6NipU=
Received: from localhost (ec2-52-56-101-76.eu-west-2.compute.amazonaws.com
 [52.56.101.76]) by mx.zoho.com.cn
 with SMTPS id 1599640984231768.1586655308606;
 Wed, 9 Sep 2020 16:43:04 +0800 (CST)
Date: Wed, 9 Sep 2020 08:43:00 +0000
From: Fam Zheng <fam@euphon.net>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20200909084300.hvxihi2oy5fezc7q@dev>
Subject: Re: [RFC PATCH v5 0/4] util/vfio-helpers: Add support for multiple
 IRQs
References: <20200908180342.280749-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200908180342.280749-1-philmd@redhat.com>
X-ZohoCNMailClient: External
Received-SPF: pass client-ip=163.53.93.243; envelope-from=fam@euphon.net;
 helo=sender2-op-o12.zoho.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 04:38:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-09-08 20:03, Philippe Mathieu-Daud=E9 wrote:
> This series intends to setup the VFIO helper to allow
> binding notifiers on different IRQs.
>=20
> For the NVMe use case, we only care about MSIX interrupts.
> To not disrupt other users, introduce the qemu_vfio_pci_init_msix_irqs
> function to initialize multiple MSIX IRQs and attach eventfd to
> them.
>=20
> Since RFC v4:
> - addressed Alex review comment:
>   check ioctl(VFIO_DEVICE_SET_IRQS) return value

Reviewed-by: Fam Zheng <fam@euphon.net>


