Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB7AC11D30
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D83C02080D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fp1L9+Cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83C02080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Eij-0006H1-Vz
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 09:28:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j6Ef0-0007dC-8z
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j6Eex-0007V9-5s
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:24:37 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53268
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j6Eew-0007Ui-V7
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582554271;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ukXQRli8+QrX/PiWYNdL6MhSs7xjaDM55ABp7oTpH9c=;
 b=Fp1L9+CmR+tXvZxUOU8MciKOdcEANXA487Lr+VTteM2SAkwTpQDmnClawV83+ndVSxE8FV
 05iX2W7Sx/nkaL9i5ORPjuUcvVpG6n2RVy3FA3cAxj0YIeDXL/YtfIMJWGF5XUZ4NSKBaQ
 BAbu8DQWG85773HVu/Oqs7I/ZZ1DJ10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-8wehWcNSONCXmdxqTybFew-1; Mon, 24 Feb 2020 09:24:22 -0500
X-MC-Unique: 8wehWcNSONCXmdxqTybFew-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37B011005513
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:24:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A1EF1CB;
 Mon, 24 Feb 2020 14:24:17 +0000 (UTC)
Date: Mon, 24 Feb 2020 14:24:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH 8/9] virStorageFileGetMetadataRecurse: Allow format
 probing under special circumstances
Message-ID: <20200224142415.GP635661@redhat.com>
References: <cover.1581959449.git.pkrempa@redhat.com>
 <e6d268fcb8b2e92f2cf0c6b29bab3a9f645a7051.1581959449.git.pkrempa@redhat.com>
 <ef597fda-4b3f-d270-824f-82df391ff223@redhat.com>
 <20200219164034.GF1011498@angien.pipo.sk>
 <fa77907b-1378-b4ed-3a40-fa19fe67f7cf@redhat.com>
 <20200219185740.GA3423556@angien.pipo.sk>
 <6d228d74-0b74-14e0-60cf-5c69dad2a65b@redhat.com>
 <20200224133416.GE3296@andariel.pipo.sk>
MIME-Version: 1.0
In-Reply-To: <20200224133416.GE3296@andariel.pipo.sk>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

On Mon, Feb 24, 2020 at 02:34:16PM +0100, Peter Krempa wrote:
> On Wed, Feb 19, 2020 at 13:12:53 -0600, Eric Blake wrote:
> > [adding qemu]
>=20
> Adding Daniel as he objected to qemu-img.
>=20
> >=20
> > On 2/19/20 12:57 PM, Peter Krempa wrote:
>=20
> [...]
>=20
> > > Additionally I think that we could just get rid of the copy of the im=
age
> > > detection copy in libvirt and replace it by invocation of qemu-img. T=
hat
> > > way we could avoid any discrepancies in the detection process in the
> > > first place.
> >=20
> > Now there's an interesting thought.  Since data corruption occurs when =
there
> > is disagreement about which mode to use, getting libvirt out of the pro=
bing
> > business by deferring all decisions to qemu-img info is a smart move - =
if
> > qemu says an image probes as qcow2 (in an environment where probing is
> > safe), then libvirt passing an explicit qcow2 to qemu for guest usage (=
in an
> > environment where probing is not safe) will at least see the same
> > guest-visible data.  Less code to maintain in libvirt, and no chance fo=
r a
> > mismatch between the two projects on which format a probe should result=
 in.
>=20
> I raised the use of qemu-img to Daniel and he disagreed with use of
> qemu-img in libvirt for doing the probing on multiple reasons:
>  - qemu-img instantiates many data structures relevant to the format so
>    it has a huge attack surface

This was the most critical reason why we have this code in libvirt
in the first place.

NB, we need to be sure we are comparing the same things between
libvirt and QEMU when we discuss "probing".

What we're talking about by probing in libvirt context is

  - Detect the image format
  - Detect the image virtual size
  - Detect the image physical size
  - Detect the image backing store location
  - Detect the image backing store format
  - Detect the image encryption usage

In QEMU 'format probing' (as impl by bdrv_probe in QEMU's block layer)
only covers the very first point, 'detect the image format'. All the
other information can only be acquired by opening the image (bdrv_open
in QEMU's block layer).

The issue is that bdrv_open does waaaaaay more than we desire here,
because it is serving the broader purpose of allowing QEMU to actually
use the image. qcow2 is probably the worst case example, as it has
to parse the image and setup data structures for l1, l2 tables,
refcount tables, snapshots, and initialize the encryption layer if
present.

It is known that this code is vulnerable to maliciously created
qcow2 images. This resulted in OpenStack being vulnerable to
CVE-2015-5162 https://bugs.launchpad.net/ossa/+bug/1449062

It isn't possible to do anything to avoid this risk if you are
invoking qemu-img on untrustworthy images. The best you can do
is to mitigate the effects by placing memory/CPU ulimits on
the qemu-img process. Determining these limits then introduces
a new problem, as you have to pick a limit which is low enough
to avoid DoS, while large enough to allow all valid usage.

Since mitigating CVE-2015-5162 OpenStack has faced this problem
with users reporting that the limits it set were breaking valid
usage, as so had to increase the limits, which increases the
DoS impact.  Then there's also the pain that OSP suffered when
QEMU introduced mandatory locking which broke all existing
usage of 'qemu-img info' when a VM was running.

Of course when you launch QEMU later, it is susceptible to the
DoS in the system emulator, but this is mitigated by fact that
upfront probing is going to reject some malicious images. If
some bad images do get past, then it will be dealt with by the
mgmt apps normal monitoring of a running VM resource usage
and/or cgroups limits.

The libvirt probing code is designed to do the minimal work
needed to get the information we require. Of course there may
be bugs in libvirt's code, but it is much more straightforward
for us to analyse & understand risks, as most of the problematic
code that QEMU has simply doesn't exist in libvirt.

>  - performance of spawning extra processes would be way worse

Yes, this was the second motivation for having this code in libvirt
originally. The QEMU VM startup case wasn't the target, but rather
storage pools code. When we start a storage pool with 100's of images,
the time to spawn 100's of instances of qemu-img adds up very quickly.
Even if qemu-img had exactly the same minimalist code as libvirt's
current probing logic it would still be worse. The overhead of process
startup vs the time spent probing the image is a poor ratio, such that
process startup/exec time dominates.


The third reason why libvirt has this code is because historically
the error reporting from qemu-img has been quite unhelpful - many
errors just end up being a generic EINVAL error message. Things have
improved over time, but error reporting is always a challenge when
spawning external commands to do work.


The fourth reason why libvirt has this image file detection code is
that it is used by non-QEMU drivers in libvirt, mostly notably the
storage pool driver, and we didn't wish to force people to install
qemu-img on hosts which were not running the QEMU virt driver.
I don't think this reason is especially a technical show stopper,
since these days all distros allow you to install qemu-img, without
pulling in the rest of QEMU. In fact the storage pool driver RPM
depends on qemu-img explicitly since we dropped support for the
Xen tools for image creation a while ago.



There is scope for something to replace the current libvirt probing
code, but spawning 'qemu-img info' is certainly not that something.

Libvirt (and apps above libvirt in general) would really benefit from
having a library that they can use for readonly querying of information
about disk images. Of course that library can't just spawn qemu-img
otherwise that defeats the point of using a library.

Unfortunately QEMU's block layer can't practically serve this role
because its GPLv2-only licensing is too restrictive for some apps
needs.=20

It would have to be something conceptually similar in complexity to
what libvirt's current probing code does, so that we can have good
confidence in its behaviour in the face of malicious input.

> I'll reiterate the historical state of the problem because I think it's
> important:
>=20
> Pre-blockdev:
>   - we internally assumed that if the image format of an backing image
>     was not present in the overlay it is 'raw'
>   - this influenced security labelling but not actually how qemu viewed
>     or probed the file. If it was qcow2 probed as qcow2 qemu opened it
>     as qcow2 possibly even including the backing file if selinux or
>     other mechanism didn't prevent it.
>=20
> post-blockdev:
>   - the assumption of 'raw' would now be expressed into the qemu
>     configuration. This assumption turned into data corruption since we
>     no longer allowed qemu to probe the format and forced it as raw.
>   - fix was to always require the format to be recorded in the overlay
>   - this made users unhappy who neglected to record the format into the
>     overlay when creating it manually

So the key problem we have is that with -blockdev we are always explicitly
telling QEMU what the backing file is for every image.

Can we fix this to have the exact same behaviour as before by *not* telling
QEMU anything about the backing file when using -blockdev, if there is no
well defined backing format present. ie, use -blockdev, but let QEMU probe
just as it did in non-blockdev days.

Would there be any downsides to this that did not already exist in the
non-blockdev days ?

I don't think we can solve the regressions in behaviour of backing files
by doing probing of the backing files in libvirt, because that only works
for the case where libvirt can actually open the file. ie a local file on
disk. We don't have logic for opening backing files on RBD, GlusterFS,
iSCSI, HTTP, SSH, etc, and nor do we want todo that.

So to me it looks like the only viable option is to not specify the
backing file info to QEMU at all.

> Now this adds an interresting dimension to this problem. If libvirt
> forces the users to specify the image format, and the users don't know
> it they will probe. So we are basically making this a problem of
> somebody else. [2] As you can see in that patch, it uses 'qemu-img'
> anyways and also additionally actually allows the chain to continue
> deeper! [3]

Yeah, this is a really bad situation given the difficulty in safely
using qemu-img, without also breaking valid usage.

We don't want to push this off to apps

> This boils down to whether we want to accept some possibility of image
> corruption in trade for avoiding regression of behaviour in the secure
> cases as well as management apps and users not having to re-invent when
> probing an image is actually safe.

I feel like the risk of image corruption is pretty minor. Our probing
handles all normal cases the same way as QEMU and newly introduced
image formats are rare.

>=20
> Finally I think we should either decide to fix it in this release, or
> stick with the error message forever. Fixing it later will not make
> much sense as many users already fixed their scripts and we'd just add
> back the trade-off of possible image corruption.
>=20
> Peter
>=20
> [1] If e.g. the security subsystem of the host didn't forbid the use of
> the backing file such a qcow2 qemu would happily open it.
>=20
> [2] https://www.redhat.com/archives/libguestfs/2020-February/msg00013.htm=
l
>=20
> [3] As implemented in [2] the backing image is not checked whether it
> has a backing file or not but the format is probed, which way result
> into accessing the backing chain of the probed image.
>=20
> Prior to this detection, it would be prevented by sVirt or alternatively
> also by libvit itself in -blockdev mode when this patch would be
> accepted.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


