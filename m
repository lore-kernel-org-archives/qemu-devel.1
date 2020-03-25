Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B1EC18E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 08:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2EFA206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 08:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbhYvmqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EFA206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH1aq-0006ca-0R
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 04:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jH1Zx-0005wk-AK
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 04:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jH1Zv-0001QZ-QD
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 04:40:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:42939)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jH1Zv-0001Ml-Lx
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 04:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585125598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oj9+fEF6iX9KeGzr9qZ1efH95ipYtRL11ods2WNPvzY=;
 b=fbhYvmqLeUvXOpDpqFsqN2QUWwQiJREL4soFmgo7KkDKNTZl21rgfIAHDox0aj4/+Ra+O8
 bhQOfxVSf4FQfJMaW8TN2Ot7GklmpCHbN8IcVYRoU9Vyj3KhrFkBl5ob3S/esDznTMfhuL
 ia/84sfsMhbTTGCVpoZ+f+yHNCbytoY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-8or-D1B-OFSU_ZTf7kTVzw-1; Wed, 25 Mar 2020 04:39:57 -0400
X-MC-Unique: 8or-D1B-OFSU_ZTf7kTVzw-1
Received: by mail-wr1-f70.google.com with SMTP id b11so783321wru.21
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 01:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=igETAkUEJEcc0s0I/9Q/KHY+fSfrEt5W5r2CNhsiwwY=;
 b=pzqg36eHOgWvJsEvGHlt6lMwRS5vbgsyAsTGcgtyyMRUHUOQP2rile/q8AyrtP0NYL
 N/iQCmKozEQ9A0+j+apCNQHx8u5tFB7o1K3fIVqcOdwf/pL+rVOCvGJmwoo2/MQsDZg8
 T9fCQiTtMGf+q2liw2aclXPqyAgvH+4BNdGFk9O+2io63QFesMaw0GtnHQD/IhkjV56i
 mbdn2Lt8XESxySfFKNTyc01Iwlznyk6+S7lV13cCXdGLirphq13lRXnV2wA3BbOKEQ3R
 OOzDuMLAJrQTJo5bIDIeAQRO3sSbmmaCjvlkP/rObcOncbnv2buJcqRvYURnIz2sw3pc
 aVDg==
X-Gm-Message-State: ANhLgQ3tytVZX3RvoVvLggUtsWDicQB2gwlmzk67oIPNIz0PRaMGnaMz
 hVNv/1FucBUMxnbVzvbZj/Rzqmqoe3JMU89srqNR3q2kKup07KL1Qxeo9zo1JMFYdSdXGEHRu/z
 IX2y4e9Z9SFqGidg=
X-Received: by 2002:adf:f1c4:: with SMTP id z4mr2313845wro.342.1585125595730; 
 Wed, 25 Mar 2020 01:39:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs4LwtBl04Rg4yJW4o3bR1J1uagdPuJKv1mvJPcrwLeLVtFDhIpEL6OK7ygR43SbO+VyOdywQ==
X-Received: by 2002:adf:f1c4:: with SMTP id z4mr2313828wro.342.1585125595547; 
 Wed, 25 Mar 2020 01:39:55 -0700 (PDT)
Received: from steredhat (host32-201-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.201.32])
 by smtp.gmail.com with ESMTPSA id y200sm8189003wmc.20.2020.03.25.01.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 01:39:55 -0700 (PDT)
Date: Wed, 25 Mar 2020 09:39:52 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH] nvme: Print 'cqid' for nvme_del_cq
Message-ID: <20200325083952.qchflcbclmxzyhab@steredhat>
References: <20200324140646.8274-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200324140646.8274-1-minwoo.im.dev@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 24, 2020 at 11:06:46PM +0900, Minwoo Im wrote:
> The given argument for this trace should be cqid, not sqid.
>=20
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> ---
>  hw/block/trace-events | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>=20
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index f78939fa9da1..bf6d11b58b85 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -37,7 +37,7 @@ nvme_rw(const char *verb, uint32_t blk_count, uint64_t =
byte_count, uint64_t lba)
>  nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsi=
ze, uint16_t qflags) "create submission queue, addr=3D0x%"PRIx64", sqid=3D%=
"PRIu16", cqid=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"PRIu16""
>  nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t s=
ize, uint16_t qflags, int ien) "create completion queue, addr=3D0x%"PRIx64"=
, cqid=3D%"PRIu16", vector=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"PRIu1=
6", ien=3D%d"
>  nvme_del_sq(uint16_t qid) "deleting submission queue sqid=3D%"PRIu16""
> -nvme_del_cq(uint16_t cqid) "deleted completion queue, sqid=3D%"PRIu16""
> +nvme_del_cq(uint16_t cqid) "deleted completion queue, cqid=3D%"PRIu16""
>  nvme_identify_ctrl(void) "identify controller"
>  nvme_identify_ns(uint16_t ns) "identify namespace, nsid=3D%"PRIu16""
>  nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=3D%"PRI=
u16""
> --=20
> 2.17.1
>=20
>=20


