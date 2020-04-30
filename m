Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE84C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B703A20774
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKPlTCBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B703A20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUA9Q-0004xC-LO
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:26:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jUA39-0002j9-Cn
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jUA38-00045w-OA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:20:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24903
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jUA38-00044v-6r
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588256425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hENF0FGoJUbOvLJ36rJah8rTBFASrjou5y4CgJUkXzY=;
 b=LKPlTCBT7ttSCmOw9bDukU4esYg+nQI0MXM0B6ggBwQGMahCXhFlfU+gNzJS40IntZ2CDB
 d+aJQUXCusaKFAPm9Sh0LOst4bXOnwo51LgC+qnC7+esjGfhdZzroNzCutRYYe2URoVvTi
 h1rVGkCyRFbEcfwuAo/pYNmJffYzVh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-WsPyCr9AM2GPCvJGXcsktA-1; Thu, 30 Apr 2020 10:20:23 -0400
X-MC-Unique: WsPyCr9AM2GPCvJGXcsktA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C83C100CCCE
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 14:20:22 +0000 (UTC)
Received: from work-vm (ovpn-114-228.ams2.redhat.com [10.36.114.228])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8103C5D9C5;
 Thu, 30 Apr 2020 14:20:16 +0000 (UTC)
Date: Thu, 30 Apr 2020 15:20:13 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] virtiofsd: Show submounts
Message-ID: <20200430142013.GI2874@work-vm>
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm> <20200429145720.GA2835@work-vm>
 <8c73f374-fcc8-1684-b581-84a9ab501aa9@redhat.com>
 <20200430085812.GC2874@work-vm>
 <20200430135639.GA260081@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200430135639.GA260081@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vivek Goyal (vgoyal@redhat.com) wrote:
> On Thu, Apr 30, 2020 at 09:58:12AM +0100, Dr. David Alan Gilbert wrote:
> [..]
> > > > Even without this patch, the SLAVE stuff worked so if you start the
> > > > daemon and *then* mount under the shared directory, the guest sees =
it
> > > > with or without this patch.
> > >=20
> > > Hm, I don=E2=80=99t.  Do you really?
> >=20
> > Yes! With your patch reverted:
> >=20
> > Start virtiofsd, mount in the guest:
> >=20
> > host:
> > # ./virtiofsd --socket-path=3D/tmp/vhostqemu -o source=3D/home/dgilbert=
/virtio-fs/fs  -o log_level=3Dwarn -o no_writeback
> >=20
> > guest:
> > # mount -t virtiofs myfs /sysroot
> >=20
> > host:
> > # findmnt -o +PROPAGATION -N 6100
> > TARGET SOURCE                                                          =
    FSTYPE OPTIONS                                                      PRO=
PAGATION
> > /      /dev/mapper/fedora_dgilbert--t580-root[/home/dgilbert/virtio-fs/=
fs] xfs    rw,relatime,seclabel,attr2,inode64,logbufs=3D8,logbsize=3D32k,no=
 private,slave
> > # mount -t tmpfs /dev/null /home/dgilbert/virtio-fs/fs/tmp
> > # findmnt -o +PROPAGATION -N 6100
> > TARGET SOURCE                                                          =
    FSTYPE OPTIONS                                                      PRO=
PAGATION
> > /      /dev/mapper/fedora_dgilbert--t580-root[/home/dgilbert/virtio-fs/=
fs] xfs    rw,relatime,seclabel,attr2,inode64,logbufs=3D8,logbsize=3D32k,no=
 private,slave
> > =E2=94=94=E2=94=80/tmp /dev/null                                       =
                    tmpfs  rw,relatime,seclabel                            =
             private,slave
>=20
> Why is it showing a mount point at "/tmp". If mount point propagated, the=
n
> inside guest we should see a mount point at /sysroot/tmp?

That findmnt is on the host.

> So there are two things.
>=20
> A. Propagation of mount from host to virtiofsd.
> B. Visibility of that mount inside guest over fuse protocol (submount
>   functionality).
>=20
> I think A works for me without any patches. But don't think B is working
> for me. I don't see the submount inside guest.=20
>=20
> > # touch /home/dgilbert/virtio-fs/fs/tmp/hello
> >=20
> > guest:
> > # ls -l /sysroot/tmp
> > total 0
> > -rw-r--r-- 1 root root 0 Apr 30 08:50 hello
>=20
> Do a "findmnt /sysroot/tmp" inside guest and see what do you see.
>=20
> You will be able to see "hello" as long as virtiofsd sees the new
> mount point, I think. And guest does not have to see that mount point
> for this simple test to work.

Right, the guest just sees:

`-/sysroot                            myfs       virtiof rw,relatime

Dave

> Vivek
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


