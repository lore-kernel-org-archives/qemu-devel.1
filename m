Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8772C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 07:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA8B207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 07:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVN5hdxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA8B207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iojUh-00079t-B2
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 02:41:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iojIg-0000EB-Ms
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:29:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iojIf-000153-FB
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:29:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59302
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iojIf-00014f-BK
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1lac5f+lCdJCAPIpwxxxjQUjln7jv9dN5CbZJSBRoEI=;
 b=ZVN5hdxDluiUEGMXuLLqHn67O+V7JiBBuKKoqKWqDkz8Qe8z+TwVk866nuULZOY/Nzu5mA
 QaGQEDCp5Rn1XSZRk7Zphl7LKq4ZH0TCuOiSShoZPc5xaUhtZbSHVHqw933BWueYy2Ca1Z
 83gl1h1pG7Gd+OXlI1RFqS65vROpktA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-VWrHC2DvOZaKGOJ901-bSg-1; Tue, 07 Jan 2020 02:29:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F3BD107ACC4
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 07:29:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72FA79A84;
 Tue,  7 Jan 2020 07:29:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 812819DA3; Tue,  7 Jan 2020 08:29:03 +0100 (CET)
Date: Tue, 7 Jan 2020 08:29:03 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH] usbredir: Prevent recursion in usbredir_write
Message-ID: <20200107072903.y5ytuxgka5waxi6w@sirius.home.kraxel.org>
References: <20191218113012.13331-1-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191218113012.13331-1-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: VWrHC2DvOZaKGOJ901-bSg-1
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
Cc: marcandre.lureau@redhat.com, uril@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 18, 2019 at 11:30:12AM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> I've got a case where usbredir_write manages to call back into itself
> via spice; this patch causes the recursion to fail (0 bytes) the write;
> this seems to avoid the deadlock I was previously seeing.
>=20
> I can't say I fully understand the interaction of usbredir and spice;
> but there are a few similar guards in spice and usbredir
> to catch other cases especially onces also related to spice_server_char_d=
evice_wakeup
>=20
> This case seems to be triggered by repeated migration+repeated
> reconnection of the viewer; but my debugging suggests the migration
> finished before this hits.
>=20
> The backtrace of the hang looks like:
>   reds_handle_ticket
>   reds_handle_other_links
>   reds_channel_do_link
>   red_channel_connect
>   spicevmc_connect
>   usbredir_create_parser
>   usbredirparser_do_write
>   usbredir_write
>   qemu_chr_fe_write
>   qemu_chr_write
>   qemu_chr_write_buffer
>   spice_chr_write
>   spice_server_char_device_wakeup
>   red_char_device_wakeup
>   red_char_device_write_to_device
>   vmc_write
>   usbredirparser_do_write
>   usbredir_write
>   qemu_chr_fe_write
>   qemu_chr_write
>   qemu_chr_write_buffer
>   qemu_mutex_lock_impl
>=20
> and we fail as we lang through qemu_chr_write_buffer's lock
> twice.
>=20
> Bug: https://bugzilla.redhat.com/show_bug.cgi?id=3D1752320
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/usb/redirect.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Added to usb queue.

thanks,
  Gerd


