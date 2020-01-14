Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE10CC33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 07:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97185207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 07:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUMExDhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97185207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irGJ5-00064K-LQ
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 02:08:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1irGIH-0005dH-CK
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 02:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1irGIE-0008PD-Ek
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 02:07:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50406
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1irGIE-0008OD-3v
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 02:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578985633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZXSn+oexxF1AI6xZEsb2wPrg9z1bncoApm3CqyoY/2I=;
 b=DUMExDhdq1qUPBpIjqlGRpk6QWyTGHDOZWuBefR5UBDxs5ofHAOe+Vd3Uy8GUE5/LJIwq6
 wGNoHsPSquk54a5Ek4DdhzHxkKmsR5Ikm1+Lon3gzdOhApR0X+Jh8Tn4nxwBMpaifDdqAP
 fR3I55js9dMHjwuH1Z/eIm8LC1E09QU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-SwOYpHrhNCWH8I2JCfWahA-1; Tue, 14 Jan 2020 02:07:09 -0500
Received: by mail-qk1-f197.google.com with SMTP id 12so7673921qkf.20
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 23:07:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4Gq7RA26CpwpTi03QgnVBclqJOz7TYGmTOq1R3/PQ7g=;
 b=NSmHHwIxN0vQvl2+cjn8i7fRu8iRk/RyDlUbnoX7La46GosRQA7/UjZzhp8yrdqk8F
 V7KFbwho92djUw87lhSQeSCZTQbLYgP9o04LpHKMsTtIKLVk/rA4CIMmn8IoGyZJlhSM
 aQxYN8R0dv3L9e83Wip1j5jiW7kdfRNTtuGb53PcV9lZnmZmrmpvserPqUam8+o+FPDp
 XeNTGjD+vAfYFii3RB4xZeLz4w3aPFbEN32mXahDSjvwhzBg7XzkUEVKXFydCdnUQGED
 dp4w56n2biBA+vmDcUcDoNzttox59KaJPosFhhmDPHrDD6/xLXRNlqhopUDshofjMM+y
 Gwhg==
X-Gm-Message-State: APjAAAVPTv40yj5osrl//lVtLnJ6PX/+jGO6+XBBzSyWEvV0SC1qKr8l
 0MPCq6dnugTcL25ckqGzMiua5aNoxmsZQwe6dkEV8yOcEz48+WbH4ykb3oD/c2FRaZWNgdi6t2V
 7R7vnfrbfzBmI8XI=
X-Received: by 2002:a0c:b515:: with SMTP id d21mr15387561qve.106.1578985628596; 
 Mon, 13 Jan 2020 23:07:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqyFOas06lKEdmSH0WZVgofnz9ZTvTTCfnjkhOyK24YIQVi67uZw/7xDGQKBkK+sPnWftLB3pw==
X-Received: by 2002:a0c:b515:: with SMTP id d21mr15387549qve.106.1578985628380; 
 Mon, 13 Jan 2020 23:07:08 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id k14sm6199339qki.66.2020.01.13.23.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 23:07:07 -0800 (PST)
Date: Tue, 14 Jan 2020 02:07:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [RFC PATCH 1/3] Fixed Error Handling in
 vhost_user_set_mem_table_postcopy
Message-ID: <20200114015843-mutt-send-email-mst@kernel.org>
References: <1575874847-5792-1-git-send-email-raphael.norwitz@nutanix.com>
 <1575874847-5792-2-git-send-email-raphael.norwitz@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <1575874847-5792-2-git-send-email-raphael.norwitz@nutanix.com>
X-MC-Unique: SwOYpHrhNCWH8I2JCfWahA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: raphael.s.norwitz@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 09, 2019 at 02:00:45AM -0500, Raphael Norwitz wrote:
> The current vhost_user_set_mem_table_postcopy() implementation
> populates each region of the VHOST_USER_SET_MEM_TABLE
> message without first checking if there are more than
> VHOST_MEMORY_MAX_NREGIONS already populated. This can
> cause memory corruption and potentially a crash if too many
> regions are added to the message during the postcopy step.
>=20
> Additionally, after populating each region, the current
> implementation asserts that the current region index is less than
> VHOST_MEMORY_MAX_NREGIONS. Thus, even if the aforementioned
> bug is fixed by moving the existing assert up, too many hot-adds
> during the postcopy step will bring down qemu instead of
> gracefully propogating up the error as in
> vhost_user_set_mem_table().
>=20
> This change cleans up error handling in
> vhost_user_set_mem_table_postcopy() such that it handles
> an unsupported number of memory hot-adds like
> vhost_user_set_mem_table(), gracefully propogating an error
> up instead of corrupting memory and crashing qemu.
>=20
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

Unfortunately all the nice error handling is mostly
futile since vhost_commit does:

        r =3D dev->vhost_ops->vhost_set_mem_table(dev, dev->mem);
        if (r < 0) {
            VHOST_OPS_DEBUG("vhost_set_mem_table failed");
        }
        goto out;

so the reason there's an assert is that we really must never
hit this path at all.  So moving assert up seems cleaner.

> ---
>  hw/virtio/vhost-user.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 02a9b25..f74ff3b 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -441,6 +441,10 @@ static int vhost_user_set_mem_table_postcopy(struct =
vhost_dev *dev,
>                                       &offset);
>          fd =3D memory_region_get_fd(mr);
>          if (fd > 0) {
> +            if (fd_num =3D=3D VHOST_MEMORY_MAX_NREGIONS) {
> +                error_report("Failed preparing vhost-user memory table m=
sg");
> +                return -1;
> +            }
>              trace_vhost_user_set_mem_table_withfd(fd_num, mr->name,
>                                                    reg->memory_size,
>                                                    reg->guest_phys_addr,
> @@ -453,7 +457,6 @@ static int vhost_user_set_mem_table_postcopy(struct v=
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


