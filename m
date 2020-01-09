Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07BDC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 16:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B3C92067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 16:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5ykeiCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3C92067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipafs-0005Mu-Oa
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 11:28:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ipafB-0004l9-0s
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:28:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ipaf7-00086j-Ih
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:27:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22368
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ipaf7-0007zM-04
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578587276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FpuGEH+efGC2/lc8mf2D/omKm/DYUYu5LDMiAooiHFc=;
 b=B5ykeiCNqLrST+2lGrRQ5JZxk0/B41lVgl2IXkpYPuGKFZB+ybEQR91T91H6rITiSqL3H5
 xtNMSSXkii91aXljBuZL5tsqxNdfsRDUK40BmRrcSQqbIfiIXujAP6VQ9/JYusY00uiG3f
 wCdXcXn9s0vt48ADXO0fjJM3yHUxmLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-KPEF5CQXOXCAFXC7gEn2vg-1; Thu, 09 Jan 2020 11:27:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7B3E1194C71;
 Thu,  9 Jan 2020 16:27:51 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BD885C290;
 Thu,  9 Jan 2020 16:27:47 +0000 (UTC)
Date: Thu, 9 Jan 2020 16:27:45 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org,
 jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] hyperv/synic: Allocate as ram_device
Message-ID: <20200109162745.GL6795@work-vm>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-3-dgilbert@redhat.com>
 <20200109064527-mutt-send-email-mst@kernel.org>
 <20200109120820.GB6795@work-vm>
 <20200109071454-mutt-send-email-mst@kernel.org>
 <20200109122237.GD6795@work-vm>
 <87r208rdin.fsf@vitty.brq.redhat.com>
 <20200109132432.GD3147@rkaganb.sw.ru>
 <20200109132821.GG6795@work-vm>
 <20200109161156.GE3147@rkaganb.sw.ru>
MIME-Version: 1.0
In-Reply-To: <20200109161156.GE3147@rkaganb.sw.ru>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: KPEF5CQXOXCAFXC7gEn2vg-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Roman Kagan (rkagan@virtuozzo.com) wrote:
> On Thu, Jan 09, 2020 at 01:28:21PM +0000, Dr. David Alan Gilbert wrote:
> > * Roman Kagan (rkagan@virtuozzo.com) wrote:
> > > On Thu, Jan 09, 2020 at 02:00:00PM +0100, Vitaly Kuznetsov wrote:
> > > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> > > >=20
> > > > > And I think vhost-user will fail if you have too many sections - =
and
> > > > > the 16 sections from synic I think will blow the slots available.
> > > > >
> > > >=20
> > > > SynIC is percpu, it will allocate two 4k pages for every vCPU the g=
uest
> > > > has so we're potentially looking at hundreds of such regions.
> > >=20
> > > Indeed.
> > >=20
> > > I think my original idea to implement overlay pages word-for-word to =
the
> > > HyperV spec was a mistake, as it lead to fragmentation and memslot
> > > waste.
> > >=20
> > > I'll look into reworking it without actually mapping extra pages over
> > > the existing RAM, but achieving overlay semantics by just shoving the
> > > *content* of the "overlaid" memory somewhere.
> > >=20
> > > That said, I haven't yet fully understood how the reported issue came
> > > about, and thus whether the proposed approach would resolve it too.
> >=20
> > The problem happens when we end up with:
> >=20
> >  a)  0-512k  RAM
> >  b)  512k +  synic
> >  c)  570kish-640k  RAM
> >=20
> > the page alignment code rounds
> >   (a) to 0-2MB   - aligning to the hugepage it's in
> >   (b) leaves as is
> >   (c) aligns to 0-2MB
> >=20
> >   it then tries to coalesce (c) and (a) and notices (b) got in the way
> > and fails it.
>=20
> I see, thanks.  The only bit I still haven't quite followed is how this
> failure results in a quiet vhost malfunction rather than a refusal to
> start vhost.

Because there's no way to fail in vhost_region_add_section other than to
abort;

            if (mrs_gpa < prev_gpa_start) {
                error_report("%s:Section rounded to %"PRIx64
                             " prior to previous %"PRIx64,
                             __func__, mrs_gpa, prev_gpa_start);
                /* A way to cleanly fail here would be better */
                return;
            }

> > Given the guest can put Synic anywhere I'm not sure that changing it's
> > implementatino would help here.
>=20
> There would be no (b) nor (separate) (c): synic would just refer to some
> memory straight from (a), regardless of its paging granularity.

Oh, if it's actually memory from main RAM, then sure, but I guess you'd
have to reserve that somehow to stop the OS using it.

> > (And changing it's implementation would probably break migration
> > compatibility).
>=20
> I'm afraid I see no better option.

Migration compatibility!

Dave

> Thanks,
> Roman.
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


