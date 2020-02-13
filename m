Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57E3C3B18B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47FC24670
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="eLd84K1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47FC24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Eyw-0001NH-UM
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rvkagan@yandex-team.ru>) id 1j2EyF-0000t9-Rd
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:56:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rvkagan@yandex-team.ru>) id 1j2EyE-0004hS-J2
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:55:59 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:59684)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rvkagan@yandex-team.ru>)
 id 1j2Ey8-0004Zk-UJ; Thu, 13 Feb 2020 08:55:53 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id E3A732E1499;
 Thu, 13 Feb 2020 16:55:49 +0300 (MSK)
Received: from sas1-9998cec34266.qloud-c.yandex.net
 (sas1-9998cec34266.qloud-c.yandex.net [2a02:6b8:c14:3a0e:0:640:9998:cec3])
 by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 D1tmjkwwKL-tkDaKjK7; Thu, 13 Feb 2020 16:55:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1581602149; bh=jZYTCpwFF8xFglMbM2jQWwFxXoTxoB2OukxsAclx/r8=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=eLd84K1hE+JGWvPZeoFJTIDjjMEiqCQ3pmdO+beW3/gBnzRPIok11MARiB1XtGJzz
 5BkgQ717KPOYBU6mSgSRiQfRW3OxcfwjD+3pg8kDemoDdqWudFDdXeGC1m0LvQEn4p
 dYL/S/zjv2eakxMhnTX2OLlYnBjtr0fJiJJUq+X4=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:5417:48f1:724b:1a04])
 by sas1-9998cec34266.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 3Oky1AkYN0-tkWi3dKb; Thu, 13 Feb 2020 16:55:46 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Date: Thu, 13 Feb 2020 16:55:44 +0300
From: Roman Kagan <rvkagan@yandex-team.ru>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] block: make BlockConf.*_size properties 32-bit
Message-ID: <20200213135544.GA103102@rvkaganb>
Mail-Followup-To: Roman Kagan <rvkagan@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org
References: <20200211115401.43230-1-rvkagan@yandex-team.ru>
 <c79721ac-357f-6b9f-6d71-53f2cb72ef6e@redhat.com>
 <20200213080151.GA85593@rvkaganb>
 <d869f498-0d6b-1a7f-72b5-bc5f2088b119@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d869f498-0d6b-1a7f-72b5-bc5f2088b119@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.45.199.163
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 06:47:10AM -0600, Eric Blake wrote:
> On 2/13/20 2:01 AM, Roman Kagan wrote:
> > On Wed, Feb 12, 2020 at 03:44:19PM -0600, Eric Blake wrote:
> > > On 2/11/20 5:54 AM, Roman Kagan wrote:
> > > > Devices (virtio-blk, scsi, etc.) and the block layer are happy to use
> > > > 32-bit for logical_block_size, physical_block_size, and min_io_size.
> > > > However, the properties in BlockConf are defined as uint16_t limiting
> > > > the values to 32768.
> > > > 
> > > > This appears unnecessary tight, and we've seen bigger block sizes handy
> > > > at times.
> > > 
> > > What larger sizes?  I could see 64k or maybe even 1M block sizes,...
> > 
> > We played exactly with these two :)
> > 
> > > > 
> > > > Make them 32 bit instead and lift the limitation.
> > > > 
> > > > Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
> > > > ---
> > > >    hw/core/qdev-properties.c    | 21 ++++++++++++---------
> > > >    include/hw/block/block.h     |  8 ++++----
> > > >    include/hw/qdev-properties.h |  2 +-
> > > >    3 files changed, 17 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> > > > index 7f93bfeb88..5f84e4a3b8 100644
> > > > --- a/hw/core/qdev-properties.c
> > > > +++ b/hw/core/qdev-properties.c
> > > > @@ -716,30 +716,32 @@ const PropertyInfo qdev_prop_pci_devfn = {
> > > >    /* --- blocksize --- */
> > > > +#define MIN_BLOCK_SIZE 512
> > > > +#define MAX_BLOCK_SIZE 2147483648
> > > 
> > > ...but 2G block sizes are going to have tremendous performance problems.
> > > 
> > > I'm not necessarily opposed to the widening to a 32-bit type, but think you
> > > need more justification or a smaller number for the max block size,
> > 
> > I thought any smaller value would just be arbitrary and hard to reason
> > about, so I went ahead with the max value that fit in the type and could
> > be made visibile to the guest.
> 
> You've got bigger problems than what is visible to the guest. block/qcow2.c
> operates on a cluster at a time; if you are stating that it now requires
> reading multiple clusters to operate on one, qcow2 will have to do lots of
> wasteful read-modify-write cycles.

I'm failing to see how this is supposed to happen.  The guest will issue
requests bigger than the cluster size; why would it cause RMW?

Big logical_block_size would cause RMW in the guest if it wants to
perform smaller writes, but that's up to the user to take this tradeoff,
isn't it?

> You really need a strong reason to
> support a maximum larger than 2M other than just "so the guest can
> experiment with it".

Do I get you right that your suggestion is to cap the block size
property at 2MB?

Thanks,
Roman.

> > 
> > Besides this is a property that is set explicitly, so I don't see a
> > problem leaving this up to the user.
> > 
> > > particularly since qcow2 refuses to use cluster sizes larger than 2M and it
> > > makes no sense to allow a block size larger than a cluster size.
> > 
> > This still doesn't contradict passing a bigger value to the guest, for
> > experimenting if nothing else.
> > 
> > Thanks,
> > Roman.
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 

