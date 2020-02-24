Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB497C35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 13:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B760420836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 13:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoD+S2Mj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B760420836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Dlx-0004v2-Sj
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 08:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j6DlF-0004Pw-HZ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:27:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j6DlD-0007rC-Vb
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:27:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29227)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j6DlD-0007qv-Rs
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582550819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LweV1LzNzThk3R4MiLdz3gS3KrTzFEgrb7NvsPgzhvc=;
 b=NoD+S2MjxZczZmVDDSJUPc+dsRfdwX5g3nkR1QVuOxQOp7UBbrveLgIzhA8DtSWjSPwGgp
 iOq/stCc/Gd0WU9x7uR4Kaq7PwMTxDCUhl2nTRKCkcSZjp6E3i2w0yMWRaOr8eCFL5rZi7
 tYxDMixWnoPUwmPeIpYrabxh9VgKWWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-YJe6hq__MVqX2X5fwWj97w-1; Mon, 24 Feb 2020 08:26:56 -0500
X-MC-Unique: YJe6hq__MVqX2X5fwWj97w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B19A3801E66;
 Mon, 24 Feb 2020 13:26:54 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-134.ams2.redhat.com [10.36.117.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B6578C066;
 Mon, 24 Feb 2020 13:26:53 +0000 (UTC)
Date: Mon, 24 Feb 2020 14:26:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Ring <stefanrin@gmail.com>
Subject: Re: Strange data corruption issue with gluster (libgfapi) and ZFS
Message-ID: <20200224132652.GA7088@linux.fritz.box>
References: <CAAxjCEzHQz4cG_8m7S6=CwCBoN5daQs+KVyuU5GL5Tq3Bky1NA@mail.gmail.com>
 <CAAxjCEx79Fkjw9tFbSMo+b1LGv2LNivLRXf1GS9JsYnXrNVVkQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAxjCEx79Fkjw9tFbSMo+b1LGv2LNivLRXf1GS9JsYnXrNVVkQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: integration@gluster.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 24.02.2020 um 13:35 hat Stefan Ring geschrieben:
> On Thu, Feb 20, 2020 at 10:19 AM Stefan Ring <stefanrin@gmail.com> wrote:
> >
> > Hi,
> >
> > I have a very curious problem on an oVirt-like virtualization host
> > whose storage lives on gluster (as qcow2).
> >
> > The problem is that of the writes done by ZFS, whose sizes according
> > to blktrace are a mixture of 8, 16, 24, ... 256 (512 byte)
> > blocks,sometimes the first 4KB or more, but at least the first 4KB,
> > end up zeroed out when read back later from storage. To clarify: ZFS
> > is only used in the guest. In my current test scenario, I write
> > approx. 3GB to the guest machine, which takes roughly a minute.
> > Actually it=E2=80=99s around 35 GB which gets compressed down to 3GB by=
 lz4.
> > Within that, I end up with close to 100 data errors when I read it
> > back from storage afterwards (zpool scrub).
> >
> > There are quite a few machines running on this host, and we have not
> > experienced other problems so far. So right now, only ZFS is able to
> > trigger this for some reason. The guest has 8 virtual cores. I also
> > tried writing directly to the affected device from user space in
> > patterns mimicking what I see in blktrace, but so far have been unable
> > to trigger the same issue that way. Of the many ZFS knobs, I know at
> > least one that makes a huge difference: When I set
> > zfs_vdev_async_write_max_active to 1 (as opposed to 2 or 10), the
> > error count goes through the roof (11.000).

Wait, that does this setting actually do? Does it mean that QEMU should
never sees more than a single active write request at the same time?
So if this makes the error a lot more prominent, does this mean that
async I/O actually makes the problem _less_ likely to occur?

This sounds weird, so probably I'm misunderstanding the setting?

> > Curiously, when I switch
> > off ZFS compression, the data amount written increases almost
> > 10-fold,while the absolute error amount drops to close to, but not
> > entirely,zero. Which I guess supports my suspicion that this must be
> > somehow related to timing.
> >
> > Switching the guest storage driver between scsi and virtio does not
> > make a difference.
> >
> > Switching the storage backend to file on glusterfs-fuse does make a
> > difference, i.e. the problem disappears.
> >
> > Any hints? I'm still trying to investigate a few things, but what bugs
> > me most that only ZFS seems to trigger this behavior, although I am
> > almost sure that ZFS is not really at fault here.
> >
> > Software versions used:
> >
> > Host
> > kernel 3.10.0-957.12.1.el7.x86_64
> > qemu-kvm-ev-2.12.0-18.el7_6.3.1.x86_64
> > glusterfs-api-5.6-1.el7.x86_64
> >
> > Guest
> > kernel 3.10.0-1062.12.1.el7.x86_64
> > kmod-zfs-0.8.3-1.el7.x86_64 (from the official ZoL binaries)
>=20
> I can actually reproduce this on my Fedora 31 home machine with 3 VMs.

This means QEMU 4.1.1, right?

> All 3 running CentOS 7.7. Two for glusterd, one for ZFS. Briefly, I
> also got rid of the 2 glusterd VMs altogether, i.e. running glusterd
> (the Fedora version) directly on the host, and it would still occur.
> So my impression is that the server side of GlusterFS does not matter
> much =E2=80=93 I=E2=80=99ve seen it happen on 4.x, 6.x, 7.2 and 7.3. Also=
, as it
> happens in the same way on a Fedora 31 qemu as well as a CentOS 7 one,
> the qemu version is equally irrelevant.
>=20
> The main conclusion so far is that it has to do with growing the qcow2
> image. With a fully pre-populated image, I cannot trigger it.

Ok, that's a good data point.

Is the corruption that you're seeing only in the guest data or is qcow2
metadata also affected (does 'qemu-img check' report errors)?

> I poked around a little in the glfs api integration, but trying to
> make sense of two unknown asynchronous io systems (QEMU's and
> GlusterFS's) interacting with each other is demanding a bit much for a
> single weekend ;). The one thing I did verify so far is that there is
> only one thread ever calling qemu_gluster_co_rw. As already stated in
> the original post, the problem only occurs with multiple parallel
> write requests happening.
>=20
> What I plan to do next is look at the block ranges being written in
> the hope of finding overlaps there.

Either that, or other interesting patterns.

Did you try to remove the guest from the equation? If you say that the
problem is with multiple parallel requests, maybe 'qemu-img bench' can
cause the same kind of corruption? (Though if it's only corruption in
the content rather than qcow2 metadata, it may be hard to detect.
Giving qemu-io an explicit list of requests could still be an option
once we have a suspicion what pattern creates the problem.)

Kevin


