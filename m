Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAACCA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 21:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9581B2084C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 21:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhqjAJvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9581B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNO2E-0008EQ-MD
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 17:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iNNyS-0004wt-VJ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 17:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iNNyQ-0002dC-9r
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 17:15:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49570
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iNNyP-0002br-KO
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 17:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571865315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmonXWEQwEaz1G6Y2kqfWwPJsStxLI7N9Gd+VEBWUtY=;
 b=QhqjAJvJWqzSjBuHfVSbS0r2ZDsmgPSmwEM+yjUIxpaAiqj6oaIqnY0S/YajDQqu8BrmnW
 4/CJ8CJo0EyFzIvLErGVnkc3x+VgF6T5qcwLMS8z4UYZ5K37Arhc2cdNsx5FfPv9whNuGU
 38jNlG2geeh393OlWZ9WaV16w9Q/n4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-yz9bPQoWNp-fZW3ZovnZ6g-1; Wed, 23 Oct 2019 17:15:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 434A41005509;
 Wed, 23 Oct 2019 21:15:11 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C11715D6D0;
 Wed, 23 Oct 2019 21:15:01 +0000 (UTC)
Date: Wed, 23 Oct 2019 15:15:00 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v5 02/11] pci: add option for net failover
Message-ID: <20191023151500.547d200a@x1.home>
In-Reply-To: <20191023203137.meh3edoudxulecys@jenstp.localdomain>
References: <20191023082711.16694-1-jfreimann@redhat.com>
 <20191023082711.16694-3-jfreimann@redhat.com>
 <20191023120648.57e50ae1@x1.home>
 <20191023193035.tlcumzmgjw242hgw@jenstp.localdomain>
 <20191023140211.4ada7ff3@x1.home>
 <20191023203137.meh3edoudxulecys@jenstp.localdomain>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: yz9bPQoWNp-fZW3ZovnZ6g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 laine@redhat.com, ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Oct 2019 22:31:37 +0200
Jens Freimann <jfreimann@redhat.com> wrote:

> On Wed, Oct 23, 2019 at 02:02:11PM -0600, Alex Williamson wrote:
> >On Wed, 23 Oct 2019 21:30:35 +0200
> >Jens Freimann <jfreimann@redhat.com> wrote:
> > =20
> >> On Wed, Oct 23, 2019 at 12:06:48PM -0600, Alex Williamson wrote: =20
> >> >On Wed, 23 Oct 2019 10:27:02 +0200
> >> >Jens Freimann <jfreimann@redhat.com> wrote: =20
> [...]
> >> >Are there also multi-function considerations that
> >> >should be prevented or documented?  For example, if a user tries to
> >> >configure both the primary and failover NICs in the same slot, I assu=
me
> >> >bad things will happen. =20
> >>
> >>   I would have expected that this is already checked in pci code, but
> >> it is not. I tried it and when I put both devices into the same slot
> >> they are both unplugged from the guest during boot but nothing else
> >> happens. I don't know what triggers that unplug of the devices.
> >>
> >> I'm not aware of any other problems regarding multi-function, which
> >> doesn't mean there aren't any. =20
> >
> >Hmm, was the hidden device at function #0?  The guest won't find any
> >functions if function #0 isn't present, but I don't know what would
> >trigger the hotplug.  The angle I'm thinking is that we only have slot
> >level granularity for hotplug, so any sort of automatic hotplug of a
> >slot should probably think about bystander devices within the slot. =20
>=20
> Yes that would be a problem, but isn't it the same in the non-failover ca=
se
> where a user configures it wrong? The slot where the device is plugged is=
 not
> chosen automatically it's configured by the user, no? I might be mixing s=
omething
> up here.  I have no idea yet how to check if a slot is already populated,=
 but
> I'll think about it.=20

I don't think libvirt will automatically make use of multifunction
endpoints, except maybe for some built-in devices, so yes it probably
would be up to the user to explicitly create a multifunction device.
But are there other scenarios that generate an automatic hot-unplug?
If a user creates a multifunction slot and then triggers a hot-unplug
themselves, it's easy to place the blame on the user if the result is
unexpected, but is it so obviously a user configuration error if the
hotplug occurs as an automatic response to a migration?  I'm not as
sure about that.

As indicated, I don't know whether this should just be documented or if
we should spend time preventing it, but someone, somewhere will
probably think it's a good idea to put their primary and failover NIC
in the same slot and be confused that the underlying mechanisms cannot
support it.  It doesn't appear that it would be too difficult to test
QEMU_PCI_CAP_MULTIFUNCTION (not set) and PCI_FUNC (is 0) for the
primary, but maybe I'm just being paranoid.  Thanks,

Alex


