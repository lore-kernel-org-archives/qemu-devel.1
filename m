Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2633FC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C5C20575
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GL5KPnlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C5C20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU525-000166-5W
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 04:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jU51W-0000fX-7Z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jU51V-0006i9-M6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:58:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50961
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jU51V-0006i1-8Z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588237104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZWJbyskEh/t4LoyVabnWcxeWz+O95/+yCmDnV6MJtI=;
 b=GL5KPnlmls70nUyTzVtuaOYQiI2NsVKZ6HzzhIj+EOtwq0u1dAAHcyo9iOZTAoHWcRRrfr
 WgjhQ7fTUYwpJRhHcyIQDmSQ5Rng3IZBLt0vn+H6Lbz6lnPmzzCfsP6FvOv33heyCAn3GY
 otAhTzpyvOOa8Tu1nHeEUyqCSLcTBYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-Xw65-uleP62JVs03yBntyw-1; Thu, 30 Apr 2020 04:58:22 -0400
X-MC-Unique: Xw65-uleP62JVs03yBntyw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD603EC1A0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 08:58:21 +0000 (UTC)
Received: from work-vm (ovpn-114-228.ams2.redhat.com [10.36.114.228])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15CCA605DD;
 Thu, 30 Apr 2020 08:58:14 +0000 (UTC)
Date: Thu, 30 Apr 2020 09:58:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH] virtiofsd: Show submounts
Message-ID: <20200430085812.GC2874@work-vm>
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm> <20200429145720.GA2835@work-vm>
 <8c73f374-fcc8-1684-b581-84a9ab501aa9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8c73f374-fcc8-1684-b581-84a9ab501aa9@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
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
Cc: virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Max Reitz (mreitz@redhat.com) wrote:
> On 29.04.20 16:57, Dr. David Alan Gilbert wrote:
> > * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> >> * Max Reitz (mreitz@redhat.com) wrote:
> >>> Currently, setup_mounts() bind-mounts the shared directory without
> >>> MS_REC.  This makes all submounts disappear.
> >>>
> >>> Pass MS_REC so that the guest can see submounts again.
> >>
> >> Thanks!
> >>
> >>> Fixes: 3ca8a2b1c83eb185c232a4e87abbb65495263756
> >>
> >> Should this actually be 5baa3b8e95064c2434bd9e2f312edd5e9ae275dc ?
> >>
> >>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>> ---
> >>>  tools/virtiofsd/passthrough_ll.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passt=
hrough_ll.c
> >>> index 4c35c95b25..9d7f863e66 100644
> >>> --- a/tools/virtiofsd/passthrough_ll.c
> >>> +++ b/tools/virtiofsd/passthrough_ll.c
> >>> @@ -2643,7 +2643,7 @@ static void setup_mounts(const char *source)
> >>>      int oldroot;
> >>>      int newroot;
> >>> =20
> >>> -    if (mount(source, source, NULL, MS_BIND, NULL) < 0) {
> >>> +    if (mount(source, source, NULL, MS_BIND | MS_REC, NULL) < 0) {
> >>>          fuse_log(FUSE_LOG_ERR, "mount(%s, %s, MS_BIND): %m\n", sourc=
e, source);
> >>>          exit(1);
> >>>      }
> >>
> >> Do we want MS_SLAVE to pick up future mounts that might happenf rom th=
e
> >> host?
> >> What's the interaction between this and the MS_REC|MS_SLAVE that we ha=
ve
> >> a few lines above for / ?
> >=20
> > Just to confirm something from vgoyal, and what had confused me about
> > why we hadn't spotted this earlier.
> >=20
> > Even without this patch, the SLAVE stuff worked so if you start the
> > daemon and *then* mount under the shared directory, the guest sees it
> > with or without this patch.
>=20
> Hm, I don=E2=80=99t.  Do you really?

Yes! With your patch reverted:

Start virtiofsd, mount in the guest:

host:
# ./virtiofsd --socket-path=3D/tmp/vhostqemu -o source=3D/home/dgilbert/vir=
tio-fs/fs  -o log_level=3Dwarn -o no_writeback

guest:
# mount -t virtiofs myfs /sysroot

host:
# findmnt -o +PROPAGATION -N 6100
TARGET SOURCE                                                              =
FSTYPE OPTIONS                                                      PROPAGA=
TION
/      /dev/mapper/fedora_dgilbert--t580-root[/home/dgilbert/virtio-fs/fs] =
xfs    rw,relatime,seclabel,attr2,inode64,logbufs=3D8,logbsize=3D32k,no pri=
vate,slave
# mount -t tmpfs /dev/null /home/dgilbert/virtio-fs/fs/tmp
# findmnt -o +PROPAGATION -N 6100
TARGET SOURCE                                                              =
FSTYPE OPTIONS                                                      PROPAGA=
TION
/      /dev/mapper/fedora_dgilbert--t580-root[/home/dgilbert/virtio-fs/fs] =
xfs    rw,relatime,seclabel,attr2,inode64,logbufs=3D8,logbsize=3D32k,no pri=
vate,slave
=E2=94=94=E2=94=80/tmp /dev/null                                           =
                tmpfs  rw,relatime,seclabel                                =
         private,slave
# touch /home/dgilbert/virtio-fs/fs/tmp/hello

guest:
# ls -l /sysroot/tmp
total 0
-rw-r--r-- 1 root root 0 Apr 30 08:50 hello

Maybe this is related to what Vivek said about default behaviours on
systemd's, what does:

# findmnt -o +PROPAGATION
TARGET    SOURCE         FSTYPE     OPTIONS                                =
                                                  PROPAGATION
/         /dev/mapper/fedora_dgilbert--t580-root
=E2=94=82                        xfs        rw,relatime,seclabel,attr2,inod=
e64,logbufs=3D8,logbsize=3D32k,noquota                        shared

say for your source=3D directory?

Dave

> Max
>=20



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


