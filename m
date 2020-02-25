Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F0DC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9F420726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWLvrDkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9F420726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6a9w-0003vL-Je
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:22:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j6ZfX-0003Fm-V9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j6ZfV-00007r-MG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:50:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51121
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j6ZfV-000073-Gk
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582635031;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s5GAgIXA8YgtvcKl9kaK/rGB+vZNEG4XcRF7ws5YT3U=;
 b=YWLvrDkJ1oSr412Pdu1tFmgHGZkNqQss+KmYSo9tq6kuKMsj++cq6UMduS5ZvNtnWxVPcD
 1seCmMny2UC6Crkq6yzV6oClXUMlkRKNhR0yz6hgt+/MlmxRmORArx1AobMItBAiDPDKKT
 R51kntKxtVLL3W8XONUrZtJzh3KayHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-v4G04-LCNve1x-4JWRuSDQ-1; Tue, 25 Feb 2020 07:50:29 -0500
X-MC-Unique: v4G04-LCNve1x-4JWRuSDQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AE3A190B2A1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 12:50:28 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF38C60BF7;
 Tue, 25 Feb 2020 12:50:24 +0000 (UTC)
Date: Tue, 25 Feb 2020 12:50:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH 8/9] virStorageFileGetMetadataRecurse: Allow format
 probing under special circumstances
Message-ID: <20200225125021.GL1148628@redhat.com>
References: <cover.1581959449.git.pkrempa@redhat.com>
 <e6d268fcb8b2e92f2cf0c6b29bab3a9f645a7051.1581959449.git.pkrempa@redhat.com>
 <ef597fda-4b3f-d270-824f-82df391ff223@redhat.com>
 <20200219164034.GF1011498@angien.pipo.sk>
 <fa77907b-1378-b4ed-3a40-fa19fe67f7cf@redhat.com>
 <20200219185740.GA3423556@angien.pipo.sk>
 <6d228d74-0b74-14e0-60cf-5c69dad2a65b@redhat.com>
 <20200224133416.GE3296@andariel.pipo.sk>
 <20200224142415.GP635661@redhat.com>
 <20200224171046.GA864377@angien.pipo.sk>
MIME-Version: 1.0
In-Reply-To: <20200224171046.GA864377@angien.pipo.sk>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: libvir-list@redhat.com, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 24, 2020 at 06:10:46PM +0100, Peter Krempa wrote:
> On Mon, Feb 24, 2020 at 14:24:15 +0000, Daniel Berrange wrote:
> > On Mon, Feb 24, 2020 at 02:34:16PM +0100, Peter Krempa wrote:
> > > On Wed, Feb 19, 2020 at 13:12:53 -0600, Eric Blake wrote:
>=20
> [...]
>=20
> > > I'll reiterate the historical state of the problem because I think it=
's
> > > important:
> > >=20
> > > Pre-blockdev:
> > >   - we internally assumed that if the image format of an backing imag=
e
> > >     was not present in the overlay it is 'raw'
> > >   - this influenced security labelling but not actually how qemu view=
ed
> > >     or probed the file. If it was qcow2 probed as qcow2 qemu opened i=
t
> > >     as qcow2 possibly even including the backing file if selinux or
> > >     other mechanism didn't prevent it.
> > >=20
> > > post-blockdev:
> > >   - the assumption of 'raw' would now be expressed into the qemu
> > >     configuration. This assumption turned into data corruption since =
we
> > >     no longer allowed qemu to probe the format and forced it as raw.
> > >   - fix was to always require the format to be recorded in the overla=
y
> > >   - this made users unhappy who neglected to record the format into t=
he
> > >     overlay when creating it manually
> >=20
> > So the key problem we have is that with -blockdev we are always explici=
tly
> > telling QEMU what the backing file is for every image.
> >=20
> > Can we fix this to have the exact same behaviour as before by *not* tel=
ling
> > QEMU anything about the backing file when using -blockdev, if there is =
no
> > well defined backing format present. ie, use -blockdev, but let QEMU pr=
obe
> > just as it did in non-blockdev days.
> >=20
> > Would there be any downsides to this that did not already exist in the
> > non-blockdev days ?
>=20
> We can, but the price is that:
> 1) we won't allow blockjobs and anything blockdev-related because node
> name would be out of our control. This was possible in pre-blockdev era.

Ok, that's not viable then. We can't switch one regression for a different
regression.

> 2) we will lose control of actually telling qemu to NOT open the backing
> file in that case. Distros using only unix permission still have
> arbitrary file access under permissions of the qemu process.

True, but that is at least historically expected behaviour, which can
be fixed by setting <backingfile/> in the XML file IIUC.

> 3) weird special-case code, because we need to keep some metadata about
> the image to do security labelling
>=20
> > I don't think we can solve the regressions in behaviour of backing file=
s
> > by doing probing of the backing files in libvirt, because that only wor=
ks
> > for the case where libvirt can actually open the file. ie a local file =
on
> > disk. We don't have logic for opening backing files on RBD, GlusterFS,
> > iSCSI, HTTP, SSH, etc, and nor do we want todo that.
>=20
> Now we are back in the teritory where we actually do match what would
> happen with previously. We don't specify these on the command line with
> ehaviour matching what's described above, with the caveats as above.
>=20
> I kept this behaviour because we couldn't do better. This is in place
> even now if the last introspectable image has valid format specified.
>=20
> We can reconsider how to approach this but ideally separately.

I'm a little lost as to exactly which scenarios are broken, and which
we're fixing.

 1. file:top.qcow2 -> file:base.raw

 2. file:top.qcow2 -> file:base.qcow2

 3. file:top.qcow2 -> file:middle.qcow2 -> file:base.raw
=20
 4. file:top.qcow2 -> file:middle.qcow2 -> file:base.qcow2

IIUC, (1) is working before and now, (2) is working before but
broken now, and (3) and (4) were broken before and now.

So (2) is the only one we /must/ to fix

Am I right that by doing probing in libvirt as per this patch,
as well as fixing (2) though, we'll accidentally fix (3) and (4)
even though they were always broken before ?

This all talks about qcow2 images on the file: protocol driver.
What is the situation for, say, the iscsi: protocol driver


 1. iscsi:top.qcow2 -> iscsi:base.raw

 2. iscsi:top.qcow2 -> iscsi:base.qcow2

 3. iscsi:top.qcow2 -> iscsi:middle.qcow2 -> iscsi:base.raw
=20
 4. iscsi:top.qcow2 -> iscsi:middle.qcow2 -> iscsi:base.qcow2

What was the behaviour of this in the pre-blockdev days and
vs current git master ? Is it the same with (1) is working
before and now, (2) is working before but broken now, and
(3) and (4) were broken before and now.

I'm assuming the libvirt probing cannot fix any case other
than file: protocol, or host-device: protocol, since we're
unable to open any other type of storage.


> > > This boils down to whether we want to accept some possibility of imag=
e
> > > corruption in trade for avoiding regression of behaviour in the secur=
e
> > > cases as well as management apps and users not having to re-invent wh=
en
> > > probing an image is actually safe.
> >=20
> > I feel like the risk of image corruption is pretty minor. Our probing
> > handles all normal cases the same way as QEMU and newly introduced
> > image formats are rare.
>=20
> Well, in this case I'm actually for re-considering the original patch
> discussed here. It uses image-format-probing code from libvirt, to allow
> the most common cases which were forbidden in a safe way. This means
> that as long as we can probe the image and the probed image does not
> have a backing file we allow the startup.
>=20
> It restores previous behaviour for valid cases including blockjobs,
> correctly revokes invalid cases (existing chain after image wihtout
> format, images impossible to introspect), is limited to the backing
> store walking code so can be contained and the price is doing the image
> format detection using libvirt's code.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


