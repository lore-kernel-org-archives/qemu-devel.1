Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA374C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8764B20658
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UChNYupm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8764B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGfl1-0005B0-LH
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 05:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jGfkN-0004cw-1r
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jGfkL-0008OW-1M
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:21:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:37899)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jGfkK-0008O8-Pm
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585041675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JIxwzPB+yT56KQyK6vcPsMdsd+Q7c4DrYD1zko733oM=;
 b=UChNYupmLZVExSRLfZ60H5MNlbFmEa87fNjTuy0GZj/WCR4m/c1Jk8JQx+Ke+9kzvsQKQo
 Sd470jPWj8xVn2OcCBrfoXn6QbKD3zfDzKyKCHE3f9VfH1h6RT0KRKhgZ5pbHILo6cNKRZ
 w66fyRc10C8L3T85RZx8nY4Gl8Qxmyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-KH6BiqRmMaKRYz_A-9-Rqg-1; Tue, 24 Mar 2020 05:21:08 -0400
X-MC-Unique: KH6BiqRmMaKRYz_A-9-Rqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5335107ACC7;
 Tue, 24 Mar 2020 09:21:07 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-119.ams2.redhat.com [10.36.113.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EC045C1A1;
 Tue, 24 Mar 2020 09:21:05 +0000 (UTC)
Date: Tue, 24 Mar 2020 10:21:04 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Roman Kagan <rvkagan@yandex-team.ru>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH] block: make BlockConf.*_size properties 32-bit
Message-ID: <20200324092104.GB5417@linux.fritz.box>
References: <20200211115401.43230-1-rvkagan@yandex-team.ru>
 <c79721ac-357f-6b9f-6d71-53f2cb72ef6e@redhat.com>
 <20200213080151.GA85593@rvkaganb>
 <d869f498-0d6b-1a7f-72b5-bc5f2088b119@redhat.com>
 <20200213135544.GA103102@rvkaganb>
 <20200302105502.GA96019@rvkaganb>
 <20200324085508.GA934879@rvkaganb.lan>
MIME-Version: 1.0
In-Reply-To: <20200324085508.GA934879@rvkaganb.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 24.03.2020 um 09:55 hat Roman Kagan geschrieben:
> On Mon, Mar 02, 2020 at 01:55:02PM +0300, Roman Kagan wrote:
> > On Thu, Feb 13, 2020 at 04:55:44PM +0300, Roman Kagan wrote:
> > > On Thu, Feb 13, 2020 at 06:47:10AM -0600, Eric Blake wrote:
> > > > On 2/13/20 2:01 AM, Roman Kagan wrote:
> > > > > On Wed, Feb 12, 2020 at 03:44:19PM -0600, Eric Blake wrote:
> > > > > > On 2/11/20 5:54 AM, Roman Kagan wrote:
> > > > > > > Devices (virtio-blk, scsi, etc.) and the block layer are happ=
y to use
> > > > > > > 32-bit for logical_block_size, physical_block_size, and min_i=
o_size.
> > > > > > > However, the properties in BlockConf are defined as uint16_t =
limiting
> > > > > > > the values to 32768.
> > > > > > >=20
> > > > > > > This appears unnecessary tight, and we've seen bigger block s=
izes handy
> > > > > > > at times.
> > > > > >=20
> > > > > > What larger sizes?  I could see 64k or maybe even 1M block size=
s,...
> > > > >=20
> > > > > We played exactly with these two :)
> > > > >=20
> > > > > > >=20
> > > > > > > Make them 32 bit instead and lift the limitation.
> > > > > > >=20
> > > > > > > Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
> > > > > > > ---
> > > > > > >    hw/core/qdev-properties.c    | 21 ++++++++++++---------
> > > > > > >    include/hw/block/block.h     |  8 ++++----
> > > > > > >    include/hw/qdev-properties.h |  2 +-
> > > > > > >    3 files changed, 17 insertions(+), 14 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-propert=
ies.c
> > > > > > > index 7f93bfeb88..5f84e4a3b8 100644
> > > > > > > --- a/hw/core/qdev-properties.c
> > > > > > > +++ b/hw/core/qdev-properties.c
> > > > > > > @@ -716,30 +716,32 @@ const PropertyInfo qdev_prop_pci_devfn =
=3D {
> > > > > > >    /* --- blocksize --- */
> > > > > > > +#define MIN_BLOCK_SIZE 512
> > > > > > > +#define MAX_BLOCK_SIZE 2147483648
> > > > > >=20
> > > > > > ...but 2G block sizes are going to have tremendous performance =
problems.
> > > > > >=20
> > > > > > I'm not necessarily opposed to the widening to a 32-bit type, b=
ut think you
> > > > > > need more justification or a smaller number for the max block s=
ize,
> > > > >=20
> > > > > I thought any smaller value would just be arbitrary and hard to r=
eason
> > > > > about, so I went ahead with the max value that fit in the type an=
d could
> > > > > be made visibile to the guest.
> > > >=20
> > > > You've got bigger problems than what is visible to the guest. block=
/qcow2.c
> > > > operates on a cluster at a time; if you are stating that it now req=
uires
> > > > reading multiple clusters to operate on one, qcow2 will have to do =
lots of
> > > > wasteful read-modify-write cycles.
> > >=20
> > > I'm failing to see how this is supposed to happen.  The guest will is=
sue
> > > requests bigger than the cluster size; why would it cause RMW?
> > >=20
> > > Big logical_block_size would cause RMW in the guest if it wants to
> > > perform smaller writes, but that's up to the user to take this tradeo=
ff,
> > > isn't it?
> > >=20
> > > > You really need a strong reason to
> > > > support a maximum larger than 2M other than just "so the guest can
> > > > experiment with it".
> > >=20
> > > Do I get you right that your suggestion is to cap the block size
> > > property at 2MB?
> > >=20
> > > Thanks,
> > > Roman.
> >=20
> > Ping?
>=20
> Ping?

Eric, I think this was a question for you.

But anyway, capping at 2 MB sounds reasonable enough to me.

Kevin

> > > > >=20
> > > > > Besides this is a property that is set explicitly, so I don't see=
 a
> > > > > problem leaving this up to the user.
> > > > >=20
> > > > > > particularly since qcow2 refuses to use cluster sizes larger th=
an 2M and it
> > > > > > makes no sense to allow a block size larger than a cluster size=
.
> > > > >=20
> > > > > This still doesn't contradict passing a bigger value to the guest=
, for
> > > > > experimenting if nothing else.
> > > > >=20
> > > > > Thanks,
> > > > > Roman.
> > > > >=20
> > > >=20
> > > > --=20
> > > > Eric Blake, Principal Software Engineer
> > > > Red Hat, Inc.           +1-919-301-3226
> > > > Virtualization:  qemu.org | libvirt.org
>=20


