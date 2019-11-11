Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E25C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F070320656
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSKNTqxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F070320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCZP-0005GW-IN
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iUCI7-0002FK-6C
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:11:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iUCI2-0006Bp-AX
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:11:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23855
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iUCHz-00069t-1N
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573488697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2fuRljcPrX0n6JAMXFKZPic1W8wiLyJlEn7JPLjCa3w=;
 b=iSKNTqxqOREAZxqGMW8EceVCheb04AfUIpKDzCPMViwpkFZdk8yaZyPo0koLthNjrv5ZbZ
 dBuYmxncCoCQYV0ruWSSsxh+wcH+th/Z84nDV5JpGCPVtmdk1lyQCUzdF+9wsrte+RAV1k
 zJarRJxC5HoGFKRDpGjRKdNZ1tva+q0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-qExX0ohGOJG8j0EobsC2Gw-1; Mon, 11 Nov 2019 11:11:36 -0500
Received: by mail-qt1-f200.google.com with SMTP id e2so13709259qtq.11
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 08:11:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=SrlfUnx++blPBC2NWHQdAx2NCBjdhuXIt93XlmTSMKw=;
 b=JkRQgrdc93kCz6cQVbEDgyjrsA96M6oasH5yHF5M12riKWzjK5H9dAy2dvim3mYgZQ
 pfzCT3G1eKilp/CBKrKwYIw2IwfWflp7uivLJka87rNpyhUiiCt/xNOnSut4mqVqo1pU
 CJCQjB6yX5/om1srgcivxvQT4o8d2NemIDy2DkXQWBkrqAQKxu28s/43EvFoPb+tOgoJ
 2BOHiNomPENuFWpfhCa/4CBL6HZyAFZJmUhyPul5LbkHiDe84fVzxWRiWrAiHX/t+nRX
 7+UfTXDFbzGhotoIsT65HIs/8tgwxmfm+FNOZHQWIPg/9wycjPWGACh5EkmWYSdejhol
 CUQw==
X-Gm-Message-State: APjAAAVqviaGFtOZFM8RfMe0rX8jnH/vkNg84ewbjtccCN98MfdM5frT
 56UXoHEJslabY9RKjOJq2Hkv9l3bcBWYEvlT3gAKqA+f4tsFgvBYgAQrnM2xekjICT8Lt8w/8g5
 Fu1L5oSUWjLmS3Jc=
X-Received: by 2002:ac8:13ca:: with SMTP id i10mr25526862qtj.214.1573488695626; 
 Mon, 11 Nov 2019 08:11:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqzZ61tryHf/4KBuZ/jlX2fs9bwpLgeUR1Ba5Dbd+hC4jB/lfv1Y2LkR0thEd0nJyn72yla0lg==
X-Received: by 2002:ac8:13ca:: with SMTP id i10mr25526828qtj.214.1573488695388; 
 Mon, 11 Nov 2019 08:11:35 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id j25sm7053345qkk.3.2019.11.11.08.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 08:11:34 -0800 (PST)
Date: Mon, 11 Nov 2019 11:11:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC][PATCH 2/3] docs/specs: Add specification of ivshmem device
 revision 2
Message-ID: <20191111105850-mutt-send-email-mst@kernel.org>
References: <cover.1573477032.git.jan.kiszka@siemens.com>
 <f5996d934d24775160bcedbf28ac975a95d91101.1573477032.git.jan.kiszka@siemens.com>
 <20191111084327-mutt-send-email-mst@kernel.org>
 <0b0475c1-2564-f433-46d8-ff1a06c13569@siemens.com>
 <20191111100607-mutt-send-email-mst@kernel.org>
 <20191111152743.GM814211@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191111152743.GM814211@redhat.com>
X-MC-Unique: qExX0ohGOJG8j0EobsC2Gw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: liang yan <lyan@suse.com>, Jailhouse <jailhouse-dev@googlegroups.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Hannes Reinecke <hare@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 11, 2019 at 03:27:43PM +0000, Daniel P. Berrang=E9 wrote:
> On Mon, Nov 11, 2019 at 10:08:20AM -0500, Michael S. Tsirkin wrote:
> > On Mon, Nov 11, 2019 at 02:59:07PM +0100, Jan Kiszka wrote:
> > > On 11.11.19 14:45, Michael S. Tsirkin wrote:
> > > > On Mon, Nov 11, 2019 at 01:57:11PM +0100, Jan Kiszka wrote:
> > > > > +| Offset | Register               | Content                     =
                         |
> > > > > +|-------:|:-----------------------|:----------------------------=
-------------------------|
> > > > > +|    00h | Vendor ID              | 1AF4h                       =
                         |
> > > > > +|    02h | Device ID              | 1110h                       =
                         |
> > > >=20
> > > > Given it's a virtio vendor ID, please reserve a device ID
> > > > with the virtio TC.
> > >=20
> > > Yeah, QEMU's IVSHMEM was always using that. I'm happy to make this fi=
nally
> > > official.
> > >=20
> >=20
> > And I guess we will just mark it reserved or something right?
> > Since at least IVSHMEM 1 isn't a virtio device.
> > And will you be reusing same ID for IVSHMEM 2 or a new one?
>=20
> 1110h isn't under either of the virtio PCI device ID allowed ranges
> according to the spec:
>=20
>   "Any PCI device with PCI Vendor ID 0x1AF4, and PCI Device
>    ID 0x1000 through 0x107F inclusive is a virtio device.
>    ...
>    Additionally, devices MAY utilize a Transitional PCI Device=20
>    ID range, 0x1000 to 0x103F depending on the device type. "
>=20
> So there's no need to reserve 0x1110h from the virtio spec POV.

Well we do have:

=09B.3
=09What Device Number?
=09Device numbers can be reserved by the OASIS committee: email virtio-dev@=
lists.oasis-open.org to secure
=09a unique one.
=09Meanwhile for experimental drivers, use 65535 and work backwards.

So it seems it can  in theory conflict at least with experimental virtio de=
vices.

Really it's messy that people are reusing the virtio vendor ID for
random stuff - getting a vendor ID is only hard for a hobbyist, any big
company already has an ID - but if it is a hobbyist and they at least
register then doesn't cause much harm.

E.g. Red Hat switched to 1b36 for new non virtio devices and I think that's
nicer.


> I have, however, ensured it is assigned to ivshmem from POV of
> Red Hat's own internal tracking of allocated device IDs, under
> its vendor ID.

Thanks!

> If ivshmem 2 is now a virtio device, then it is a good thing that
> it will get a new/different PCI device ID, to show that it is not
> compatible with the old device impl.
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|


