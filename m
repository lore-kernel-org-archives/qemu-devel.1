Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFC9C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 15:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D82592073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 15:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNru9avV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82592073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKNu5-00022f-Ud
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 11:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jKNtI-0001Ox-Sa
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jKNtG-0003od-TE
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:05:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58806
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jKNtG-0003nu-NW
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585926349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fF0ddw+zmmwJm/jiFrRBYpLXNeZiP+DPImXN2rhP/J4=;
 b=XNru9avV2y1+bkzuZsc/LOdJsyyn/O11JS9gRw6r4KvabtWIaYDElmgMf0cKZErqBis7xw
 HzSBi6SQwE8t/ymjVFIYndY8XlA1KqbCg2izqM+qliKMDWbmI0Sjp07RN23ECNhcqtyX+D
 1t6E3teZ0favFZIdcHIKhXTCjOsWw1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-ab3TiZRUP4izipRVi9Xh2w-1; Fri, 03 Apr 2020 11:05:45 -0400
X-MC-Unique: ab3TiZRUP4izipRVi9Xh2w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C2D38017F3;
 Fri,  3 Apr 2020 15:05:44 +0000 (UTC)
Received: from work-vm (ovpn-112-11.ams2.redhat.com [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C9565DA2C;
 Fri,  3 Apr 2020 15:05:38 +0000 (UTC)
Date: Fri, 3 Apr 2020 16:05:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 0/5] fix migration with bitmaps and mirror
Message-ID: <20200403150536.GE3335@work-vm>
References: <20191219085106.22309-1-vsementsov@virtuozzo.com>
 <20191219103638.GJ4914@andariel.pipo.sk>
 <a5015250-46f4-c6ed-92b9-779f885e8a4a@virtuozzo.com>
 <20200403112358.GV578401@andariel.pipo.sk>
 <bfd71b93-41a4-33fb-b6ff-5f7602af14fa@virtuozzo.com>
 <f53ec85f-e8c8-5717-2246-9ce8d6dd8e0a@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <f53ec85f-e8c8-5717-2246-9ce8d6dd8e0a@virtuozzo.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: fam@euphon.net, kwolf@redhat.com, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> 03.04.2020 14:29, Vladimir Sementsov-Ogievskiy wrote:
> > 03.04.2020 14:23, Peter Krempa wrote:
> > > On Fri, Apr 03, 2020 at 14:02:47 +0300, Vladimir Sementsov-Ogievskiy =
wrote:
> > > > 19.12.2019 13:36, Peter Krempa wrote:
> > > > > On Thu, Dec 19, 2019 at 11:51:01 +0300, Vladimir Sementsov-Ogievs=
kiy wrote:
> > > > > > Hi all!
> > > > > >=20
> > > > > > It's a continuation for
> > > > > > "bitmap migration bug with -drive while block mirror runs"
> > > > > > <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
> > > > > > https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg07241.=
html
> > > > > >=20
> > > > > > The problem is that bitmaps migrated to node with same node-nam=
e or
> > > > > > blk-parent name. And currently only the latter actually work in=
 libvirt.
> > > > > > And with mirror-top filter it doesn't work, because
> > > > > > bdrv_get_device_or_node_name don't go through filters.
> > > > >=20
> > > > > I want to point out that since libvirt-5.10 we use -blockdev to
> > > > > configure the backend of storage devices with qemu-4.2 and later.=
 This
> > > > > means unfortunately that the BlockBackend of the drive does not h=
ave a
> > > > > name any more and thus the above will not work even if you make t=
he
> > > > > lookup code to see through filters.
> > > >=20
> > > > Not that this series doesn't make things worse, as it loops through=
 named
> > > > block backends when trying to use their name for migration. So with=
 these
> > > > patches applied, qemu will just work in more possible scenarios.
> > >=20
> > > Okay, if that's so it's fair enough in this case.
> > >=20
> > > I'm just very firmly against baking in the assumption that
> > > node names mean the same thing accross migration, because that will
> > > create a precedent situation and more stuff may be baked in on top of
> > > this in the future. It seems that it has already happened though and
> > > it's wrong. And the worst part is that it's never mentioned that this
> > > might occur. But again, don't do that and preferrably remove the
> > > matching of node names for bitmaps altogether until we can control it
> > > arbitrarily.
> > >=20
> > > We've also seen this already before with the backend name of memory
> > > devices being baked in to the migration stream which creates an unwan=
ted
> > > dependancy.
> > >=20
> >=20
> > Hmm. Actually, matching by node-name never worked. May be just drop it =
now, and allow only matching by blk-name?
> >=20
> > And then (in 5.1) implement special qmp commands for precise mapping.
> >=20
>=20
> Hmm, it may break someones setup... Bad idea. Probably we can forbid auto=
-generated node-names.

If we want to remove it I guess we have to go through a proper
deprecation; but that's OK.

The thing to keep in mind is that when people say 'the commandline
should match' on source/destination - that's just not true;
so we have to define what actually needs to stay the same for bitmap
migration to work.

Dave

> --=20
> Best regards,
> Vladimir
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


