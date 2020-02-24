Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5550FC35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 13:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AA12072D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 13:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lyk7RH+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AA12072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6DtG-0007Cy-Jw
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 08:35:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1j6DsU-0006kw-IH
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:34:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1j6DsS-0001yc-U6
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:34:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32108
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1j6DsS-0001xm-PJ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:34:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582551267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IxoLkaPvvEx2r6pf1K5+07hx+EPfr4EXzYxCKEVjEnw=;
 b=Lyk7RH+LPuF3T1EEZfVg7DmwksTf+YhtKSC2LKlreaZ8CVmdjBhzsUziJBX6s+flhd0DJB
 Ohq9e82/Nt2t0ybgAHYHUfoCKsBcrSDmq1hloQ5lN0PyaB+op+PN3w/fqOeEjPIf8Me8im
 wo85PhEXSZalCgw4lmMjkbkIcVuWfik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-6BCCBKISOZ-6QLqTqu8o2Q-1; Mon, 24 Feb 2020 08:34:24 -0500
X-MC-Unique: 6BCCBKISOZ-6QLqTqu8o2Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD0CB13F6
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 13:34:23 +0000 (UTC)
Received: from andariel.pipo.sk (ovpn-204-29.brq.redhat.com [10.40.204.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DB165C554;
 Mon, 24 Feb 2020 13:34:19 +0000 (UTC)
Date: Mon, 24 Feb 2020 14:34:16 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 8/9] virStorageFileGetMetadataRecurse: Allow format
 probing under special circumstances
Message-ID: <20200224133416.GE3296@andariel.pipo.sk>
References: <cover.1581959449.git.pkrempa@redhat.com>
 <e6d268fcb8b2e92f2cf0c6b29bab3a9f645a7051.1581959449.git.pkrempa@redhat.com>
 <ef597fda-4b3f-d270-824f-82df391ff223@redhat.com>
 <20200219164034.GF1011498@angien.pipo.sk>
 <fa77907b-1378-b4ed-3a40-fa19fe67f7cf@redhat.com>
 <20200219185740.GA3423556@angien.pipo.sk>
 <6d228d74-0b74-14e0-60cf-5c69dad2a65b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6d228d74-0b74-14e0-60cf-5c69dad2a65b@redhat.com>
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
Cc: libvir-list@redhat.com, Daniel Berrange <berrange@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 19, 2020 at 13:12:53 -0600, Eric Blake wrote:
> [adding qemu]

Adding Daniel as he objected to qemu-img.

>=20
> On 2/19/20 12:57 PM, Peter Krempa wrote:

[...]

> > Additionally I think that we could just get rid of the copy of the imag=
e
> > detection copy in libvirt and replace it by invocation of qemu-img. Tha=
t
> > way we could avoid any discrepancies in the detection process in the
> > first place.
>=20
> Now there's an interesting thought.  Since data corruption occurs when th=
ere
> is disagreement about which mode to use, getting libvirt out of the probi=
ng
> business by deferring all decisions to qemu-img info is a smart move - if
> qemu says an image probes as qcow2 (in an environment where probing is
> safe), then libvirt passing an explicit qcow2 to qemu for guest usage (in=
 an
> environment where probing is not safe) will at least see the same
> guest-visible data.  Less code to maintain in libvirt, and no chance for =
a
> mismatch between the two projects on which format a probe should result i=
n.

I raised the use of qemu-img to Daniel and he disagreed with use of
qemu-img in libvirt for doing the probing on multiple reasons:
 - qemu-img instantiates many data structures relevant to the format so
   it has a huge attack surface
 - performance of spawning extra processes would be way worse

While at least from the point of view of VM startup both can be
challenged this adds a complete new orthogonal dimension to the problem
I'm attempting to fix.

I'll reiterate the historical state of the problem because I think it's
important:

Pre-blockdev:
  - we internally assumed that if the image format of an backing image
    was not present in the overlay it is 'raw'
  - this influenced security labelling but not actually how qemu viewed
    or probed the file. If it was qcow2 probed as qcow2 qemu opened it
    as qcow2 possibly even including the backing file if selinux or
    other mechanism didn't prevent it.

post-blockdev:
  - the assumption of 'raw' would now be expressed into the qemu
    configuration. This assumption turned into data corruption since we
    no longer allowed qemu to probe the format and forced it as raw.
  - fix was to always require the format to be recorded in the overlay
  - this made users unhappy who neglected to record the format into the
    overlay when creating it manually

Now since qemu didn't discourage the creation of overlays without format
there still are many users which will inevitably hit this problem when
used with libvirt.

My proposal tries to mitigate the regressions in behaviour in the valid
and secure use cases. (If the image whose format we detect doesn't have
a backing image)

This comes at a trade-off though. As Eric pointed out, if the format
probed by libvirt's internal code disagrees with qemu's format we are
getting into the image corruption region.

As a mitigation to the above I suggested using qemu-img to probe but
that's a complex change and as mentioned above not really welcome
upstream.

Now this adds an interresting dimension to this problem. If libvirt
forces the users to specify the image format, and the users don't know
it they will probe. So we are basically making this a problem of
somebody else. [2] As you can see in that patch, it uses 'qemu-img'
anyways and also additionally actually allows the chain to continue
deeper! [3]

A partial relief to the image detection problem is that qemu would
refuse to start if an non-qcow2 image is used in qcow2, thus we really
only run into problems if qcow2 is mis-detected as raw.

This boils down to whether we want to accept some possibility of image
corruption in trade for avoiding regression of behaviour in the secure
cases as well as management apps and users not having to re-invent when
probing an image is actually safe.

Finally I think we should either decide to fix it in this release, or
stick with the error message forever. Fixing it later will not make
much sense as many users already fixed their scripts and we'd just add
back the trade-off of possible image corruption.

Peter

[1] If e.g. the security subsystem of the host didn't forbid the use of
the backing file such a qcow2 qemu would happily open it.

[2] https://www.redhat.com/archives/libguestfs/2020-February/msg00013.html

[3] As implemented in [2] the backing image is not checked whether it
has a backing file or not but the format is probed, which way result
into accessing the backing chain of the probed image.

Prior to this detection, it would be prevented by sVirt or alternatively
also by libvit itself in -blockdev mode when this patch would be
accepted.


