Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1721C352A2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 08:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8174520720
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 08:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JK1TsqVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8174520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izcMf-0002I3-Mk
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 03:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1izcLW-00017N-A6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1izcLT-0006X7-Sl
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:17:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26506
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1izcLT-0006T1-L9
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580977027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/u+TQJHJ1eLTdpR3eCBBZ21zZcPX2Cx3Xxw6eLxuNQ=;
 b=JK1TsqVo3zWIMfHX6H0vReeE/BC/k4hy+GXZVZHlu9vosxjb3fWujwAXfcUokrne+FFlR+
 t/4o5CSEYrPJofy641Fz+bOCXUqhn9jCjy6ReSdzome/BOrV+snfmPH5Gt7OgrbiEVoLhD
 tO7XBM4LIaTg0dBBNjcXERvDKvrGHRc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-zZp2hzIpNteFQQuUOca0Zg-1; Thu, 06 Feb 2020 03:17:05 -0500
Received: by mail-qt1-f199.google.com with SMTP id e8so3320985qtg.9
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 00:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Y3kGc2goMKgkECxh+2YvUGoa4u7Ge4Hm6g9gSW0iboU=;
 b=PkWWu8F4Rl8zz+yX2IZ1BEjZksT7iFWKxhr04T4mWan463uXXZZdLNG/qVY+By4yOZ
 ZPZbKxQNeYFtvqaZsY57+Y9qmWaSfyeIYToCNFt2euklwyR0EY2mI69pu9Jiys4xiq2E
 KyNH4P1a0U0wdHikSP3kVkqWyn7eWGYcsPmv9sm5XbEi8gZYdTBn4P/TmU+Fg47Agimk
 IqX2g7nr31GN1QpGT477dTiud5NXSxaKl28Pr3E/e29SzmGnuyPb4MYf/XFQtw5ACxrb
 lSD/W5WzQufHrtodVX5te/cMgkyExQWnNEIBy69CcQFrra6QgFcFBdK0tlxJBrRfm75g
 HhGw==
X-Gm-Message-State: APjAAAVW9/stvbOY2d9/LWP01aHrKJXXPQuktSc6FBEe9nVlJTjFPdml
 fCeE6jMFsIaw+1kkarwm6RwerLCtmHPIeShagC3aN5ErYjKQXdHT3O/O8Eggx5UBUcgxUyiqL3j
 tASJqfJ85aYYwreQ=
X-Received: by 2002:ac8:3853:: with SMTP id r19mr1561925qtb.69.1580977024725; 
 Thu, 06 Feb 2020 00:17:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqwsiongd9J6PshkLVHp8Qey3o0OXCVJ9klcMPPRXKK4152a+EHyK2fsgDE8N7Q4MX2yze0GtA==
X-Received: by 2002:ac8:3853:: with SMTP id r19mr1561910qtb.69.1580977024483; 
 Thu, 06 Feb 2020 00:17:04 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id z8sm1286290qth.16.2020.02.06.00.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 00:17:03 -0800 (PST)
Date: Thu, 6 Feb 2020 03:17:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH v2 1/3] Fixed assert in vhost_user_set_mem_table_postcopy
Message-ID: <20200206031645-mutt-send-email-mst@kernel.org>
References: <1579143426-18305-1-git-send-email-raphael.norwitz@nutanix.com>
 <1579143426-18305-2-git-send-email-raphael.norwitz@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <1579143426-18305-2-git-send-email-raphael.norwitz@nutanix.com>
X-MC-Unique: zZp2hzIpNteFQQuUOca0Zg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Turschmid <peter.turschm@nutanix.com>, raphael.s.norwitz@gmail.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 15, 2020 at 09:57:04PM -0500, Raphael Norwitz wrote:
> The current vhost_user_set_mem_table_postcopy() implementation
> populates each region of the VHOST_USER_SET_MEM_TABLE message without
> first checking if there are more than VHOST_MEMORY_MAX_NREGIONS already
> populated. This can cause memory corruption if too many regions are
> added to the message during the postcopy step.
>=20
> This change moves an existing assert up such that attempting to
> construct a VHOST_USER_SET_MEM_TABLE message with too many memory
> regions will gracefully bring down qemu instead of corrupting memory.
>=20
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>


Could you pls add Fixes: and stable tags?

> ---
>  hw/virtio/vhost-user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 2e81f55..cce851a 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -443,6 +443,7 @@ static int vhost_user_set_mem_table_postcopy(struct v=
host_dev *dev,
>                                       &offset);
>          fd =3D memory_region_get_fd(mr);
>          if (fd > 0) {
> +            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
>              trace_vhost_user_set_mem_table_withfd(fd_num, mr->name,
>                                                    reg->memory_size,
>                                                    reg->guest_phys_addr,
> @@ -455,7 +456,6 @@ static int vhost_user_set_mem_table_postcopy(struct v=
host_dev *dev,
>              msg.payload.memory.regions[fd_num].guest_phys_addr =3D
>                  reg->guest_phys_addr;
>              msg.payload.memory.regions[fd_num].mmap_offset =3D offset;
> -            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
>              fds[fd_num++] =3D fd;
>          } else {
>              u->region_rb_offset[i] =3D 0;
> --=20
> 1.8.3.1


