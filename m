Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9525AC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 15:44:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8D22076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 15:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvT42Msu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8D22076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUBM3-0000ly-Hu
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 11:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1jUBKw-00084w-3D
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1jUBJS-0005m9-5R
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:42:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27077
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jUBJR-0005m2-Ng
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588261280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WISaus3baP4Zrt/Oh57RNx8CavHVOv3Qte68zDNz+Kk=;
 b=JvT42MsujA1QTWBgdEGuLgDDmcXXeGuCmUK1HYHCjHyNc81T/50eM9veTcRm+hI8mVA6zk
 Lu6R8kKbHG2rip73IW5eV3A8HKoeq+2D5mXS4OabZg7Gq2nVM3WU5xH1ejHwDfSNT9/BOA
 cubeJ0H4SMOavrbgnaslZbL8wiMyru4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-HuaSpBEbPZykGepF3R4dIQ-1; Thu, 30 Apr 2020 11:41:17 -0400
X-MC-Unique: HuaSpBEbPZykGepF3R4dIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7441846269
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 15:41:16 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-229.rdu2.redhat.com [10.10.115.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DB4F6116F;
 Thu, 30 Apr 2020 15:41:06 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id C3B83223620; Thu, 30 Apr 2020 11:41:05 -0400 (EDT)
Date: Thu, 30 Apr 2020 11:41:05 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] virtiofsd: Show submounts
Message-ID: <20200430154105.GE260081@redhat.com>
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm> <20200429145720.GA2835@work-vm>
 <8c73f374-fcc8-1684-b581-84a9ab501aa9@redhat.com>
 <20200430085812.GC2874@work-vm>
 <20200430135639.GA260081@redhat.com>
 <20200430142013.GI2874@work-vm>
 <20200430143425.GD2184629@redhat.com>
 <20200430144116.GD260081@redhat.com>
 <20200430144704.GG2184629@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200430144704.GG2184629@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:24:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: virtio-fs@redhat.com, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 30, 2020 at 03:47:04PM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Apr 30, 2020 at 10:41:16AM -0400, Vivek Goyal wrote:
> > On Thu, Apr 30, 2020 at 03:34:25PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > > On Thu, Apr 30, 2020 at 03:20:13PM +0100, Dr. David Alan Gilbert wrot=
e:
> > > > * Vivek Goyal (vgoyal@redhat.com) wrote:
> > > > > On Thu, Apr 30, 2020 at 09:58:12AM +0100, Dr. David Alan Gilbert =
wrote:
> > > > > [..]
> > > > > > > > Even without this patch, the SLAVE stuff worked so if you s=
tart the
> > > > > > > > daemon and *then* mount under the shared directory, the gue=
st sees it
> > > > > > > > with or without this patch.
> > > > > > >=20
> > > > > > > Hm, I don=E2=80=99t.  Do you really?
> > > > > >=20
> > > > > > Yes! With your patch reverted:
> > > > > >=20
> > > > > > Start virtiofsd, mount in the guest:
> > > > > >=20
> > > > > > host:
> > > > > > # ./virtiofsd --socket-path=3D/tmp/vhostqemu -o source=3D/home/=
dgilbert/virtio-fs/fs  -o log_level=3Dwarn -o no_writeback
> > > > > >=20
> > > > > > guest:
> > > > > > # mount -t virtiofs myfs /sysroot
> > > > > >=20
> > > > > > host:
> > > > > > # findmnt -o +PROPAGATION -N 6100
> > > > > > TARGET SOURCE                                                  =
            FSTYPE OPTIONS                                                 =
     PROPAGATION
> > > > > > /      /dev/mapper/fedora_dgilbert--t580-root[/home/dgilbert/vi=
rtio-fs/fs] xfs    rw,relatime,seclabel,attr2,inode64,logbufs=3D8,logbsize=
=3D32k,no private,slave
> > > > > > # mount -t tmpfs /dev/null /home/dgilbert/virtio-fs/fs/tmp
> > > > > > # findmnt -o +PROPAGATION -N 6100
> > > > > > TARGET SOURCE                                                  =
            FSTYPE OPTIONS                                                 =
     PROPAGATION
> > > > > > /      /dev/mapper/fedora_dgilbert--t580-root[/home/dgilbert/vi=
rtio-fs/fs] xfs    rw,relatime,seclabel,attr2,inode64,logbufs=3D8,logbsize=
=3D32k,no private,slave
> > > > > > =E2=94=94=E2=94=80/tmp /dev/null                               =
                            tmpfs  rw,relatime,seclabel                    =
                     private,slave
> > > > >=20
> > > > > Why is it showing a mount point at "/tmp". If mount point propaga=
ted, then
> > > > > inside guest we should see a mount point at /sysroot/tmp?
> > > >=20
> > > > That findmnt is on the host.
> > > >=20
> > > > > So there are two things.
> > > > >=20
> > > > > A. Propagation of mount from host to virtiofsd.
> > > > > B. Visibility of that mount inside guest over fuse protocol (subm=
ount
> > > > >   functionality).
> > > > >=20
> > > > > I think A works for me without any patches. But don't think B is =
working
> > > > > for me. I don't see the submount inside guest.=20
> > > > >=20
> > > > > > # touch /home/dgilbert/virtio-fs/fs/tmp/hello
> > > > > >=20
> > > > > > guest:
> > > > > > # ls -l /sysroot/tmp
> > > > > > total 0
> > > > > > -rw-r--r-- 1 root root 0 Apr 30 08:50 hello
> > > > >=20
> > > > > Do a "findmnt /sysroot/tmp" inside guest and see what do you see.
> > > > >=20
> > > > > You will be able to see "hello" as long as virtiofsd sees the new
> > > > > mount point, I think. And guest does not have to see that mount p=
oint
> > > > > for this simple test to work.
> > > >=20
> > > > Right, the guest just sees:
> > > >=20
> > > > `-/sysroot                            myfs       virtiof rw,relatim=
e
> > >=20
> > > That is a good thing surely ? If I'm exporting "/sysroot" from the ho=
st,
> > > I want the content in "/sysroot/some/sub/mount" to be visible to the
> > > guest, but I don't want the guest to see "/sysroot/some/sub/mount"
> > > as an actual mount point. That would be leaking information about the
> > > host storage setup into the guest. The host admin should be free to
> > > re-arrange submounts in the host OS, to bring more storage space onli=
ne,
> > > and have this be transparent to the guest OS.
> >=20
> > If we don't see mount inside guest, we run into the possibility of inod=
e
> > number collision. On host two files in shared dir can have same inode
> > number (if they are on two different filesystem with different device
> > numbers). But inside guest, we will show device number of virtiofs,
> > and it will look as if two files in this filesystem have same inode
> > number, breaking some workloads.
> >=20
> > By propagating mounts (submounts), we can assign a unique device number
> > to these submounts and hence <dev,inode> number pair will become unique=
.
>=20
> Ah, yes, that's true.  In 9pfs there was recent changes precisely
> because of this clash possibility:
>=20
> commit 1a6ed33cc56997479bbe5b48337ff8da44585bd4
> Author: Antonios Motakis <antonios.motakis@huawei.com>
> Date:   Thu Oct 10 11:36:05 2019 +0200
>=20
>     9p: Added virtfs option 'multidevs=3Dremap|forbid|warn'
>    =20
>     'warn' (default): Only log an error message (once) on host if more th=
an one
>     device is shared by same export, except of that just ignore this conf=
ig
>     error though. This is the default behaviour for not breaking existing
>     installations implying that they really know what they are doing.
>    =20
>     'forbid': Like 'warn', but except of just logging an error this
>     also denies access of guest to additional devices.
>    =20
>     'remap': Allows to share more than one device per export by remapping
>     inodes from host to guest appropriately. To support multiple devices =
on the
>     9p share, and avoid qid path collisions we take the device id as inpu=
t to
>     generate a unique QID path. The lowest 48 bits of the path will be se=
t
>     equal to the file inode, and the top bits will be uniquely assigned b=
ased
>     on the top 16 bits of the inode and the device id.
>=20
>=20
> Perhaps we should try to support the same options in virtio-fs. At least
> the "forbid" and "remap" options make sense I think. "warn" was only
> really there for backcompat.  If we can expose it to the guest, then a
> further "expose" option would be viable.

Providing options in virtiofsd daemon so that use can tweak these settings
makes sense.

Given we are already allowing accessing multiple device inside guest, we
also probably need a mode to continue to allow that so that not to break
existing setups.

"forbid", "remap" make sense. And I like the option "expose" too.

"remap" will require little thought that how do we do that. We briefly
discussed encoding device number in higher inode bits and Miklos was
not too keen on it. What if filesystem is using all 64bits of inode. We
also need to do encoding in such a way so that inode number is persistent.

Thanks
Vivek


