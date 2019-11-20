Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E435C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A8C20714
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="WsyUh3mu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A8C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSTg-00038n-Gp
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:05:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1iXS42-0007QL-J7
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:38:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1iXS40-00052P-TX
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:38:42 -0500
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:5162)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1iXS40-0004zs-HC; Wed, 20 Nov 2019 10:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1574264320;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=q4cQ/IEwn90EKgMaEUYZoywzlLWnxhr8D/zbZJc7Sno=;
 b=WsyUh3muT8zoo7NoUB1G9UhJWQb7d3I6iqbsp+GbwsW9TWfV3ciBX3xV
 5qubYrrel2xSu5ntPTqVkbHqm24Xc1vwcxCobk2aWF6j7y/Um3Ao6heTK
 y8LhknKl6KJauYtyEpboM1WSD+f+eSkj5zfGAYgEF+QCUrv42zHZpPsAO Y=;
Authentication-Results: esa5.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: G61FxiAVsGhQ9E+e0u1ih7Vz0zZiPp0xf+UlfprhxZNfwqgw3HOd16hEteTqL/mXa42vhrQDBo
 iXx0mR9RafRBGuiAA9vzwXw/jeB4qHux/H0WJNpkSSztSBC9aQUf68oLruS78uKxZCHj2/7UNo
 xkALqH7SYSRs9WKUDew2A+eIJjEflTQ4Opnfk5Tri6Lsfmmw4wvoiVLOn/bC864YZFKJnXcrHz
 gWdSewjwc8FvdXxTGb+UvmTTTRfn5WoYgKPsgdwE1H1OLjH0X/1K0Orryr5AEcgpOqGb4EN4ll
 2oU=
X-SBRS: 2.7
X-MesageID: 8959617
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,222,1571716800"; 
   d="scan'208";a="8959617"
Date: Wed, 20 Nov 2019 15:38:31 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [RFC v5 031/126] xen: introduce ERRP_AUTO_PROPAGATE
Message-ID: <20191120153831.GF1425@perard.uk.xensource.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-32-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191011160552.22907-32-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.155.168
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul
 Durrant <paul@xen.org>, armbru@redhat.com, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 xen-devel@lists.xenproject.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 11, 2019 at 07:04:17PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -915,15 +903,15 @@ static void xen_block_device_create(XenBackendInstance *backend,
>          goto fail;
>      }
>  
> -    drive = xen_block_drive_create(vdev, device_type, opts, &local_err);
> +    drive = xen_block_drive_create(vdev, device_type, opts, errp);
>      if (!drive) {
> -        error_propagate_prepend(errp, local_err, "failed to create drive: ");
> +        error_prepend(errp, "failed to create drive: ");
>          goto fail;
>      }
>  
> -    iothread = xen_block_iothread_create(vdev, &local_err);
> -    if (local_err) {
> -        error_propagate_prepend(errp, local_err,
> +    iothread = xen_block_iothread_create(vdev, errp);
> +    if (*errp) {
> +        error_prepend(errp,
>                                  "failed to create iothread: ");

These two line could be joined now.

>          goto fail;
>      }

And there are more indentation issues like that in the patch. It would be
nice to fix, but otherwise the patch looks fine:

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

