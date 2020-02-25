Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E980C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7C52064A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTIgqPID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7C52064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aOO-00065f-K4
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1j6a9d-0003dy-0f
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:21:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1j6a9b-0004jw-9A
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:21:40 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41337
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1j6a9b-0004jJ-5D
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582636896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Xv/t6Zo0cGBtney6znCCDmF0+wveWYK2dAj4m2bjOs=;
 b=MTIgqPIDPnJxX6WWKBXLiZJGwcpd9YV2yBJT5X5HfUTQZMSS8fwq0nv04czuPPonCeiwr/
 UGCEnnf3y1X7f9tOVWdFZ+QAT+JAYxtefdUbXybiOGQJa6k/DuuO45pEAy9M3CV7yDktr3
 lxQourJ20UtQ7tGsjPG1uHwlj3iKYn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-bxQyWYwFOsKyZt_7tBrLcg-1; Tue, 25 Feb 2020 08:21:35 -0500
X-MC-Unique: bxQyWYwFOsKyZt_7tBrLcg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D135DB61
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 13:21:32 +0000 (UTC)
Received: from andariel.pipo.sk (ovpn-204-29.brq.redhat.com [10.40.204.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F4665DA2C;
 Tue, 25 Feb 2020 13:21:28 +0000 (UTC)
Date: Tue, 25 Feb 2020 14:21:25 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 8/9] virStorageFileGetMetadataRecurse: Allow format
 probing under special circumstances
Message-ID: <20200225132125.GH3296@andariel.pipo.sk>
References: <e6d268fcb8b2e92f2cf0c6b29bab3a9f645a7051.1581959449.git.pkrempa@redhat.com>
 <ef597fda-4b3f-d270-824f-82df391ff223@redhat.com>
 <20200219164034.GF1011498@angien.pipo.sk>
 <fa77907b-1378-b4ed-3a40-fa19fe67f7cf@redhat.com>
 <20200219185740.GA3423556@angien.pipo.sk>
 <6d228d74-0b74-14e0-60cf-5c69dad2a65b@redhat.com>
 <20200224133416.GE3296@andariel.pipo.sk>
 <20200224142415.GP635661@redhat.com>
 <20200224171046.GA864377@angien.pipo.sk>
 <20200225125021.GL1148628@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200225125021.GL1148628@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: libvir-list@redhat.com, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 12:50:21 +0000, Daniel Berrange wrote:
> On Mon, Feb 24, 2020 at 06:10:46PM +0100, Peter Krempa wrote:
> > On Mon, Feb 24, 2020 at 14:24:15 +0000, Daniel Berrange wrote:
> > > On Mon, Feb 24, 2020 at 02:34:16PM +0100, Peter Krempa wrote:

[...]

> > > Would there be any downsides to this that did not already exist in th=
e
> > > non-blockdev days ?
> >=20
> > We can, but the price is that:
> > 1) we won't allow blockjobs and anything blockdev-related because node
> > name would be out of our control. This was possible in pre-blockdev era=
.
>=20
> Ok, that's not viable then. We can't switch one regression for a differen=
t
> regression.
>=20
> > 2) we will lose control of actually telling qemu to NOT open the backin=
g
> > file in that case. Distros using only unix permission still have
> > arbitrary file access under permissions of the qemu process.
>=20
> True, but that is at least historically expected behaviour, which can
> be fixed by setting <backingfile/> in the XML file IIUC.

Yes, but if you specify any <backingStore> including the terminator you
basically configure the image chain yourselves. The part which is
configured explicitly will not undergo any form of detection, not even
looking for the backing file.

> > 3) weird special-case code, because we need to keep some metadata about
> > the image to do security labelling
> >=20
> > > I don't think we can solve the regressions in behaviour of backing fi=
les
> > > by doing probing of the backing files in libvirt, because that only w=
orks
> > > for the case where libvirt can actually open the file. ie a local fil=
e on
> > > disk. We don't have logic for opening backing files on RBD, GlusterFS=
,
> > > iSCSI, HTTP, SSH, etc, and nor do we want todo that.
> >=20
> > Now we are back in the teritory where we actually do match what would
> > happen with previously. We don't specify these on the command line with
> > ehaviour matching what's described above, with the caveats as above.
> >=20
> > I kept this behaviour because we couldn't do better. This is in place
> > even now if the last introspectable image has valid format specified.
> >=20
> > We can reconsider how to approach this but ideally separately.
>=20
> I'm a little lost as to exactly which scenarios are broken, and which
> we're fixing.
>=20
>  1. file:top.qcow2 -> file:base.raw
>=20
>  2. file:top.qcow2 -> file:base.qcow2
>=20
>  3. file:top.qcow2 -> file:middle.qcow2 -> file:base.raw
> =20
>  4. file:top.qcow2 -> file:middle.qcow2 -> file:base.qcow2

I assume you meant that none of the 'qcow2' files have format of the
backing file recorded in the metadata.

> IIUC, (1) is working before and now, (2) is working before but
> broken now, and (3) and (4) were broken before and now.

1) was working before, but is now forbidden
2) was working before, and is now forbidden
3,4) were possibly working (without sVirt), or would get permission
denied reported by qemu during startup, currently they are forbidden by
a libvirt error message

After this patch:
1) will be fixed by this patch
2) will be fixed by this patch
3, 4) will report a libvirt error rather than relying on sVirt or others

> So (2) is the only one we /must/ to fix
>=20
> Am I right that by doing probing in libvirt as per this patch,
> as well as fixing (2) though, we'll accidentally fix (3) and (4)
> even though they were always broken before ?
>
> This all talks about qcow2 images on the file: protocol driver.
> What is the situation for, say, the iscsi: protocol driver
>=20
>=20
>  1. iscsi:top.qcow2 -> iscsi:base.raw
>=20
>  2. iscsi:top.qcow2 -> iscsi:base.qcow2
>=20
>  3. iscsi:top.qcow2 -> iscsi:middle.qcow2 -> iscsi:base.raw
> =20
>  4. iscsi:top.qcow2 -> iscsi:middle.qcow2 -> iscsi:base.qcow2
>=20
> What was the behaviour of this in the pre-blockdev days and
> vs current git master ? Is it the same with (1) is working
> before and now, (2) is working before but broken now, and
> (3) and (4) were broken before and now.

Pre-blockdev and post-blockdev every scenario of the above is working.
We can't even inspect the top file for backing store so everything is
just ignored.

Now what partially changes is when we have something introspectable in
the way:

1,2) file:top.qcow2 -> iscsi:base.whatever

The current code would report an error if the format was not recorded
in the overlay (top.qcow2) and we can't introspect the backing file
we'll reject it.

This can be relaxed though.

3,4) will work if top.qcow2 has the format but any subsequent don't since
we don't introspect it

> I'm assuming the libvirt probing cannot fix any case other
> than file: protocol, or host-device: protocol, since we're
> unable to open any other type of storage.

It fixes also gluster since the backends for that are already
implemented.

I'll post another rebased version with some updated docs and one fix. We
can continue there perhaps.


