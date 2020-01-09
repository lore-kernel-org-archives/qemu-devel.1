Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE63C3F68F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:31:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEEE920661
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVJNMCJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEEE920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipXtv-0000sl-8Q
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 08:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ipXrT-0007aH-Ve
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ipXrS-0003Gd-RK
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:28:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33919
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ipXrS-0003EO-MD
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578576510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6AVBfRtfwuMEztusIH4++UCty1Jo+w+nLEgEvCvCjIk=;
 b=UVJNMCJrODXSsix6XfYRwb+jMxHAyf858T4Hr85yqG5rPVWL9WVXDoNSuSMCv6avqCAlbS
 GjIDbyn4cQKVKvacZcILBueBERIORYT1KcJkLiVVB8BXzUlRoLiMWCzoC78Qh3DONb5JRg
 ABdXadHHHtESXBQOTrOp36U5YSRT7Tk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-X19nO7igPv21CxfvHMbL5A-1; Thu, 09 Jan 2020 08:28:28 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3EBF10054E3;
 Thu,  9 Jan 2020 13:28:27 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C59C519C69;
 Thu,  9 Jan 2020 13:28:23 +0000 (UTC)
Date: Thu, 9 Jan 2020 13:28:21 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org,
 jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] hyperv/synic: Allocate as ram_device
Message-ID: <20200109132821.GG6795@work-vm>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-3-dgilbert@redhat.com>
 <20200109064527-mutt-send-email-mst@kernel.org>
 <20200109120820.GB6795@work-vm>
 <20200109071454-mutt-send-email-mst@kernel.org>
 <20200109122237.GD6795@work-vm>
 <87r208rdin.fsf@vitty.brq.redhat.com>
 <20200109132432.GD3147@rkaganb.sw.ru>
MIME-Version: 1.0
In-Reply-To: <20200109132432.GD3147@rkaganb.sw.ru>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: X19nO7igPv21CxfvHMbL5A-1
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
> On Thu, Jan 09, 2020 at 02:00:00PM +0100, Vitaly Kuznetsov wrote:
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> >=20
> > > And I think vhost-user will fail if you have too many sections - and
> > > the 16 sections from synic I think will blow the slots available.
> > >
> >=20
> > SynIC is percpu, it will allocate two 4k pages for every vCPU the guest
> > has so we're potentially looking at hundreds of such regions.
>=20
> Indeed.
>=20
> I think my original idea to implement overlay pages word-for-word to the
> HyperV spec was a mistake, as it lead to fragmentation and memslot
> waste.
>=20
> I'll look into reworking it without actually mapping extra pages over
> the existing RAM, but achieving overlay semantics by just shoving the
> *content* of the "overlaid" memory somewhere.
>=20
> That said, I haven't yet fully understood how the reported issue came
> about, and thus whether the proposed approach would resolve it too.

The problem happens when we end up with:

 a)  0-512k  RAM
 b)  512k +  synic
 c)  570kish-640k  RAM

the page alignment code rounds
  (a) to 0-2MB   - aligning to the hugepage it's in
  (b) leaves as is
  (c) aligns to 0-2MB

  it then tries to coalesce (c) and (a) and notices (b) got in the way
and fails it.

Given the guest can put Synic anywhere I'm not sure that changing it's
implementatino would help here.
(And changing it's implementation would probably break migration
compatibility).

Dave

> Thanks,
> Roman.
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


