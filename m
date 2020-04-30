Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC70C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A237D2051A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ai+tplJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A237D2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUAOG-0008G1-LZ
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1jUANT-0007Yz-61
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1jUANS-0006NG-5r
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:41:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33884
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jUANR-0006Mq-Ol
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588257684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CRMcS/N/RB3Jh+coDAGr/dO1d8nsBfCOaSlqIughXHk=;
 b=ai+tplJYGx/UtiV/iHlqPWAUfjidLdp6MP3gz2e+l8kImi/pUsPKtN4+bQgEyDEFpePrN9
 Y/pCyPLx4gvlWZfTkaPoTFk5HOBhcSxVDqTi7Dwa1mTMUyUMiX0cjGfptuJ/264SHRwAJa
 zd1YtNb3795eAtBMWMp0NxnGm/bweOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-W1T9JJA3OLGPjKGcfhw2Fg-1; Thu, 30 Apr 2020 10:41:23 -0400
X-MC-Unique: W1T9JJA3OLGPjKGcfhw2Fg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CA5D18FE863
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 14:41:22 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-229.rdu2.redhat.com [10.10.115.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 324075C1B0;
 Thu, 30 Apr 2020 14:41:17 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id B15F9223620; Thu, 30 Apr 2020 10:41:16 -0400 (EDT)
Date: Thu, 30 Apr 2020 10:41:16 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] virtiofsd: Show submounts
Message-ID: <20200430144116.GD260081@redhat.com>
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm> <20200429145720.GA2835@work-vm>
 <8c73f374-fcc8-1684-b581-84a9ab501aa9@redhat.com>
 <20200430085812.GC2874@work-vm>
 <20200430135639.GA260081@redhat.com>
 <20200430142013.GI2874@work-vm>
 <20200430143425.GD2184629@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200430143425.GD2184629@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: virtio-fs@redhat.com, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 30, 2020 at 03:34:25PM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Apr 30, 2020 at 03:20:13PM +0100, Dr. David Alan Gilbert wrote:
> > * Vivek Goyal (vgoyal@redhat.com) wrote:
> > > On Thu, Apr 30, 2020 at 09:58:12AM +0100, Dr. David Alan Gilbert wrot=
e:
> > > [..]
> > > > > > Even without this patch, the SLAVE stuff worked so if you start=
 the
> > > > > > daemon and *then* mount under the shared directory, the guest s=
ees it
> > > > > > with or without this patch.
> > > > >=20
> > > > > Hm, I don=E2=80=99t.  Do you really?
> > > >=20
> > > > Yes! With your patch reverted:
> > > >=20
> > > > Start virtiofsd, mount in the guest:
> > > >=20
> > > > host:
> > > > # ./virtiofsd --socket-path=3D/tmp/vhostqemu -o source=3D/home/dgil=
bert/virtio-fs/fs  -o log_level=3Dwarn -o no_writeback
> > > >=20
> > > > guest:
> > > > # mount -t virtiofs myfs /sysroot
> > > >=20
> > > > host:
> > > > # findmnt -o +PROPAGATION -N 6100
> > > > TARGET SOURCE                                                      =
        FSTYPE OPTIONS                                                     =
 PROPAGATION
> > > > /      /dev/mapper/fedora_dgilbert--t580-root[/home/dgilbert/virtio=
-fs/fs] xfs    rw,relatime,seclabel,attr2,inode64,logbufs=3D8,logbsize=3D32=
k,no private,slave
> > > > # mount -t tmpfs /dev/null /home/dgilbert/virtio-fs/fs/tmp
> > > > # findmnt -o +PROPAGATION -N 6100
> > > > TARGET SOURCE                                                      =
        FSTYPE OPTIONS                                                     =
 PROPAGATION
> > > > /      /dev/mapper/fedora_dgilbert--t580-root[/home/dgilbert/virtio=
-fs/fs] xfs    rw,relatime,seclabel,attr2,inode64,logbufs=3D8,logbsize=3D32=
k,no private,slave
> > > > =E2=94=94=E2=94=80/tmp /dev/null                                   =
                        tmpfs  rw,relatime,seclabel                        =
                 private,slave
> > >=20
> > > Why is it showing a mount point at "/tmp". If mount point propagated,=
 then
> > > inside guest we should see a mount point at /sysroot/tmp?
> >=20
> > That findmnt is on the host.
> >=20
> > > So there are two things.
> > >=20
> > > A. Propagation of mount from host to virtiofsd.
> > > B. Visibility of that mount inside guest over fuse protocol (submount
> > >   functionality).
> > >=20
> > > I think A works for me without any patches. But don't think B is work=
ing
> > > for me. I don't see the submount inside guest.=20
> > >=20
> > > > # touch /home/dgilbert/virtio-fs/fs/tmp/hello
> > > >=20
> > > > guest:
> > > > # ls -l /sysroot/tmp
> > > > total 0
> > > > -rw-r--r-- 1 root root 0 Apr 30 08:50 hello
> > >=20
> > > Do a "findmnt /sysroot/tmp" inside guest and see what do you see.
> > >=20
> > > You will be able to see "hello" as long as virtiofsd sees the new
> > > mount point, I think. And guest does not have to see that mount point
> > > for this simple test to work.
> >=20
> > Right, the guest just sees:
> >=20
> > `-/sysroot                            myfs       virtiof rw,relatime
>=20
> That is a good thing surely ? If I'm exporting "/sysroot" from the host,
> I want the content in "/sysroot/some/sub/mount" to be visible to the
> guest, but I don't want the guest to see "/sysroot/some/sub/mount"
> as an actual mount point. That would be leaking information about the
> host storage setup into the guest. The host admin should be free to
> re-arrange submounts in the host OS, to bring more storage space online,
> and have this be transparent to the guest OS.

If we don't see mount inside guest, we run into the possibility of inode
number collision. On host two files in shared dir can have same inode
number (if they are on two different filesystem with different device
numbers). But inside guest, we will show device number of virtiofs,
and it will look as if two files in this filesystem have same inode
number, breaking some workloads.

By propagating mounts (submounts), we can assign a unique device number
to these submounts and hence <dev,inode> number pair will become unique.

W.r.t information lea, may be we can mask some of the information in
submounts inside guest.

Thanks
Vivek


