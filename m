Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FE5C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:15:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7D5120836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fnoj1+NF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D5120836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6HKV-00007I-FT
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 12:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1j6HFx-0002dQ-Ms
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1j6HFv-0000zK-RQ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:10:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47406
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1j6HFv-0000z2-Mb
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582564254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+qTweN/bWjWgLV6DmapX575GF3w2l1flaFTSScif5Zs=;
 b=Fnoj1+NF5GKJX7Xs8tsRAjmPJRi0m4ZYUvtcTJ3EDksHLoJXWwOdprZCos2iJtYpTtDvbz
 U04AbhaYqWKm+PA7LUWF1vsEiqVZQdcqA+TXPRTPbl5aBS1HtTUs2+U+BEO1EN/XxGQ2DV
 VeIAb4g+FVUe70qID127sSPhdYMPYUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-EKAocOE8O9uKsNmkd2FLgg-1; Mon, 24 Feb 2020 12:10:52 -0500
X-MC-Unique: EKAocOE8O9uKsNmkd2FLgg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14EF210B783D
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 17:10:52 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72C5A5C241;
 Mon, 24 Feb 2020 17:10:48 +0000 (UTC)
Date: Mon, 24 Feb 2020 18:10:46 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 8/9] virStorageFileGetMetadataRecurse: Allow format
 probing under special circumstances
Message-ID: <20200224171046.GA864377@angien.pipo.sk>
References: <cover.1581959449.git.pkrempa@redhat.com>
 <e6d268fcb8b2e92f2cf0c6b29bab3a9f645a7051.1581959449.git.pkrempa@redhat.com>
 <ef597fda-4b3f-d270-824f-82df391ff223@redhat.com>
 <20200219164034.GF1011498@angien.pipo.sk>
 <fa77907b-1378-b4ed-3a40-fa19fe67f7cf@redhat.com>
 <20200219185740.GA3423556@angien.pipo.sk>
 <6d228d74-0b74-14e0-60cf-5c69dad2a65b@redhat.com>
 <20200224133416.GE3296@andariel.pipo.sk>
 <20200224142415.GP635661@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200224142415.GP635661@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: libvir-list@redhat.com, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 24, 2020 at 14:24:15 +0000, Daniel Berrange wrote:
> On Mon, Feb 24, 2020 at 02:34:16PM +0100, Peter Krempa wrote:
> > On Wed, Feb 19, 2020 at 13:12:53 -0600, Eric Blake wrote:

[...]

> > I'll reiterate the historical state of the problem because I think it's
> > important:
> >=20
> > Pre-blockdev:
> >   - we internally assumed that if the image format of an backing image
> >     was not present in the overlay it is 'raw'
> >   - this influenced security labelling but not actually how qemu viewed
> >     or probed the file. If it was qcow2 probed as qcow2 qemu opened it
> >     as qcow2 possibly even including the backing file if selinux or
> >     other mechanism didn't prevent it.
> >=20
> > post-blockdev:
> >   - the assumption of 'raw' would now be expressed into the qemu
> >     configuration. This assumption turned into data corruption since we
> >     no longer allowed qemu to probe the format and forced it as raw.
> >   - fix was to always require the format to be recorded in the overlay
> >   - this made users unhappy who neglected to record the format into the
> >     overlay when creating it manually
>=20
> So the key problem we have is that with -blockdev we are always explicitl=
y
> telling QEMU what the backing file is for every image.
>=20
> Can we fix this to have the exact same behaviour as before by *not* telli=
ng
> QEMU anything about the backing file when using -blockdev, if there is no
> well defined backing format present. ie, use -blockdev, but let QEMU prob=
e
> just as it did in non-blockdev days.
>=20
> Would there be any downsides to this that did not already exist in the
> non-blockdev days ?

We can, but the price is that:
1) we won't allow blockjobs and anything blockdev-related because node
name would be out of our control. This was possible in pre-blockdev era.
2) we will lose control of actually telling qemu to NOT open the backing
file in that case. Distros using only unix permission still have
arbitrary file access under permissions of the qemu process.
3) weird special-case code, because we need to keep some metadata about
the image to do security labelling

> I don't think we can solve the regressions in behaviour of backing files
> by doing probing of the backing files in libvirt, because that only works
> for the case where libvirt can actually open the file. ie a local file on
> disk. We don't have logic for opening backing files on RBD, GlusterFS,
> iSCSI, HTTP, SSH, etc, and nor do we want todo that.

Now we are back in the teritory where we actually do match what would
happen with previously. We don't specify these on the command line with
ehaviour matching what's described above, with the caveats as above.

I kept this behaviour because we couldn't do better. This is in place
even now if the last introspectable image has valid format specified.

We can reconsider how to approach this but ideally separately.

> So to me it looks like the only viable option is to not specify the
> backing file info to QEMU at all.
>=20
> > Now this adds an interresting dimension to this problem. If libvirt
> > forces the users to specify the image format, and the users don't know
> > it they will probe. So we are basically making this a problem of
> > somebody else. [2] As you can see in that patch, it uses 'qemu-img'
> > anyways and also additionally actually allows the chain to continue
> > deeper! [3]
>=20
> Yeah, this is a really bad situation given the difficulty in safely
> using qemu-img, without also breaking valid usage.
>=20
> We don't want to push this off to apps
>=20
> > This boils down to whether we want to accept some possibility of image
> > corruption in trade for avoiding regression of behaviour in the secure
> > cases as well as management apps and users not having to re-invent when
> > probing an image is actually safe.
>=20
> I feel like the risk of image corruption is pretty minor. Our probing
> handles all normal cases the same way as QEMU and newly introduced
> image formats are rare.

Well, in this case I'm actually for re-considering the original patch
discussed here. It uses image-format-probing code from libvirt, to allow
the most common cases which were forbidden in a safe way. This means
that as long as we can probe the image and the probed image does not
have a backing file we allow the startup.

It restores previous behaviour for valid cases including blockjobs,
correctly revokes invalid cases (existing chain after image wihtout
format, images impossible to introspect), is limited to the backing
store walking code so can be contained and the price is doing the image
format detection using libvirt's code.


