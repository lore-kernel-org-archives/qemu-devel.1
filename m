Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C0BC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 08:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E7920720
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 08:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGMEn57Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E7920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izcP3-00047C-Is
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 03:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1izcOS-0003da-9n
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:20:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1izcOR-00047q-9f
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:20:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31106
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1izcOR-00045q-5R
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580977210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCpKpdvw4Ai0lbDjhpUJj5bqWKF1VyfYUg1rR3x3aLA=;
 b=DGMEn57YeodAtwZy8iT/otiDJBFXidgqeZbKyA1ar0g55Zlggr6k7O0frfLdF0LEbLo/Ey
 3VMR6zLpk4zVRfaaRmZumLTQUX6avK2vNpx1tKAd55LXccCAYHnCLXARhVepS2reB2Kq7+
 w4zKF1Kasb89AUTFj4ZUe8kINK0U9x8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-LxFHDjTeNfuVvVtdJKpsZg-1; Thu, 06 Feb 2020 03:20:06 -0500
Received: by mail-qk1-f199.google.com with SMTP id 12so3058489qkf.20
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 00:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=G31dZjoMYgb4DG3OqYocoUKlsWJoYfbAsh0hSZFhimQ=;
 b=jwRcp96eImXQ+ncfLOadF3Icr1LHsII8AXpgu+AKdsBQzw5BBkaW4u9jI9m7Ybw7zf
 UDu2x/Jt7pB3P7V2A2An+pdHI4rI8n9x3gptzJyejM/TfTPROXlYnEW+spK4OsNb+VyE
 guRXICwwO04ct011LGTvt8bO2PcBrnS/VBpXUIhbPqzFgKQIaDLUXdPQX6xPpHT9FEUx
 VDM/AaKOVRH8+/cuR//tcSqDk6iFKEBhP4bJhwNprRBumoqCfMXeHwuw+A2BMVG596fl
 TmMJoIfdMCf2E3PUz6oyf4m49HfaW8idw2yLr5UueM7/6V/YyNIOlAky6BA/gRkDxlBS
 AZZA==
X-Gm-Message-State: APjAAAWJ5lFfqyrmUj3RCjVddqPARoc0jLyefbvyZYhVaTCumRGfcXph
 nSi7jmsKNFlgpUpCpaS0SwCshR2x85N/c1rPCYSxtqsWIxQqLxrsVF2ABMVYfH8hwiLMZ2dD+TZ
 vjyaUlefI1SI70Pk=
X-Received: by 2002:a37:9c07:: with SMTP id f7mr1476250qke.103.1580977206287; 
 Thu, 06 Feb 2020 00:20:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqzKGz2EYxhDaK52AKC27ZmJ829HJuJuw9xLPh9p4vtUMnrhM0UjtgPXC0wd9rZeZ2NFMeYxJA==
X-Received: by 2002:a37:9c07:: with SMTP id f7mr1476233qke.103.1580977206070; 
 Thu, 06 Feb 2020 00:20:06 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id d206sm1102765qke.66.2020.02.06.00.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 00:20:05 -0800 (PST)
Date: Thu, 6 Feb 2020 03:20:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH v2 1/3] Fixed assert in vhost_user_set_mem_table_postcopy
Message-ID: <20200206031922-mutt-send-email-mst@kernel.org>
References: <1579143426-18305-1-git-send-email-raphael.norwitz@nutanix.com>
 <1579143426-18305-2-git-send-email-raphael.norwitz@nutanix.com>
 <20200206031645-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200206031645-mutt-send-email-mst@kernel.org>
X-MC-Unique: LxFHDjTeNfuVvVtdJKpsZg-1
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
Cc: Peter Turschmid <peter.turschm@nutanix.com>, raphael.s.norwitz@gmail.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 06, 2020 at 03:17:04AM -0500, Michael S. Tsirkin wrote:
> On Wed, Jan 15, 2020 at 09:57:04PM -0500, Raphael Norwitz wrote:
> > The current vhost_user_set_mem_table_postcopy() implementation
> > populates each region of the VHOST_USER_SET_MEM_TABLE message without
> > first checking if there are more than VHOST_MEMORY_MAX_NREGIONS already
> > populated. This can cause memory corruption if too many regions are
> > added to the message during the postcopy step.
> >=20
> > This change moves an existing assert up such that attempting to
> > construct a VHOST_USER_SET_MEM_TABLE message with too many memory
> > regions will gracefully bring down qemu instead of corrupting memory.
> >=20
> > Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> > Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
>=20
>=20
> Could you pls add Fixes: and stable tags?

oh wait no, this is just a theoretical thing, right?
it doesn't actually trigger, it's just a cleanup.

no fixes/stable needed then, sorry

> > ---
> >  hw/virtio/vhost-user.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 2e81f55..cce851a 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -443,6 +443,7 @@ static int vhost_user_set_mem_table_postcopy(struct=
 vhost_dev *dev,
> >                                       &offset);
> >          fd =3D memory_region_get_fd(mr);
> >          if (fd > 0) {
> > +            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
> >              trace_vhost_user_set_mem_table_withfd(fd_num, mr->name,
> >                                                    reg->memory_size,
> >                                                    reg->guest_phys_addr=
,
> > @@ -455,7 +456,6 @@ static int vhost_user_set_mem_table_postcopy(struct=
 vhost_dev *dev,
> >              msg.payload.memory.regions[fd_num].guest_phys_addr =3D
> >                  reg->guest_phys_addr;
> >              msg.payload.memory.regions[fd_num].mmap_offset =3D offset;
> > -            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
> >              fds[fd_num++] =3D fd;
> >          } else {
> >              u->region_rb_offset[i] =3D 0;
> > --=20
> > 1.8.3.1


