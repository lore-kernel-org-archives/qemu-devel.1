Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D145C33CA2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF2E2067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bry8Nq4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF2E2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipZyl-0003i8-8F
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 10:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ipZsx-0003X9-PB
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ipZsv-0002rK-UE
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:38:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41425
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ipZsv-0002kO-Ni
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578584288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WehvuzyeF8mf2IdWbytmu7J2YOAFixUN4rzh0E4cOu0=;
 b=Bry8Nq4phkMDpvCWNKSgLgEd5jjOaC6BkF8VtVAFHctde+J64nEXJnlB5YpMcrQJkyArzl
 jKpuJKYAsEkGkF5wCe13tptRVVe5Dfrax4kMuQuWP/v2NGnaQxm1iRFzde/6Xn7ojw/Azw
 8xaE4S9qP2JCWiRzRYdweUttPbrQjLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-sosroMSPNmCKXDH1KY4oXw-1; Thu, 09 Jan 2020 10:38:07 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37433CF98E
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 15:38:06 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4726385;
 Thu,  9 Jan 2020 15:38:02 +0000 (UTC)
Date: Thu, 9 Jan 2020 15:38:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] hyperv/synic: Allocate as ram_device
Message-ID: <20200109153800.GJ6795@work-vm>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-3-dgilbert@redhat.com>
 <20200109064527-mutt-send-email-mst@kernel.org>
 <20200109120820.GB6795@work-vm>
 <20200109071454-mutt-send-email-mst@kernel.org>
 <20200109122237.GD6795@work-vm>
 <20200109080412-mutt-send-email-mst@kernel.org>
 <20200109132242.GF6795@work-vm>
 <3162676e-da40-7a3f-1777-2ed4f3efffe1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3162676e-da40-7a3f-1777-2ed4f3efffe1@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: sosroMSPNmCKXDH1KY4oXw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: jasowang@redhat.com, vkuznets@redhat.com, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 09/01/20 14:22, Dr. David Alan Gilbert wrote:
> > * Michael S. Tsirkin (mst@redhat.com) wrote:
> >> On Thu, Jan 09, 2020 at 12:22:37PM +0000, Dr. David Alan Gilbert wrote=
:
> >>> Do we want a new memory_region_init for that or just to be able to ad=
d
> >>> a flag?
> >>>
> >> I think a flag API is preferable since this can apply to any kind of
> >> region. But can go either way, Paolo's the maintainer there.
> >=20
> > (Copying Paolo in)
> > So what exactly does this flag mean; to me it's 'no vhost' - but is it
> > actually more general?
>=20
> It has two more effects in addition to no vhost:
>=20
> 1) it is skipped when dumping the guest (is this a good or bad idea for
> SynIC?)
>=20
> 2) accesses to the region will use the specified size (e.g. 4-bytes for
> address_space_stl, 1-byte for address_space_stb) instead of a memcpy.
> Doesn't really matter for SynIC regions.
>=20
> If (1) is a good idea, then it's 2 out of 3 and I guess the patch is okay=
.

It's probably best  to keep them in the dump because they give some info
on the current state of the windows guest and interrupts.
Also, as Roman points out the ram-device pages aren't migrated, so we
need to fix that as well.

So, do we add a new flag? If so, is no-vhost what we want?

Dave

> Paolo
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


