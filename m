Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9C0C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E2020674
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="huxrGjzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E2020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEVEf-0007wq-Ej
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 05:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jEVDo-0006zF-Tu
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jEVDn-0004Bd-Jp
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:42:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:35951)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jEVDn-00049u-FS
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584524562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4xRijCvBqp7q/mT6bHlqCr6dMFJcV+DS608GCiahVbA=;
 b=huxrGjzUunYRpnRjGHfVTJ5JYakABa0MNy6B9Hhgp9hBstCi4VYzbn4/80p9ij4rzDHur/
 E3woGi3mzjZb4ub4VEArEFsiAwzIeusoG9NreIcXwgApDt5t/hKJwwWfE9hySwd7YWISEW
 7+ZSmyPP2ZDwELV0Egn0uJzCMY6q/6o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-ToX9KQA-PO-GxvvjHiyj3Q-1; Wed, 18 Mar 2020 05:42:41 -0400
X-MC-Unique: ToX9KQA-PO-GxvvjHiyj3Q-1
Received: by mail-wr1-f70.google.com with SMTP id c3so307868wrx.13
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 02:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=txD5gqI/hxUivedHX2o6onAkiDhvyWuXiB73q/XgHj8=;
 b=JiGqCubcPaoFVSLk34e+Vyj39yLUHYHrHzQwD4LekN0aKPUj/uIs+fbTk6FfiuSH8U
 2nvbuodowl2PEYw2VpWYby9lQtddtF6J5Y+PJmuKApu+88xqteJy1oiMbf+XiNwNkneW
 zTLGJOZArQHeOz3Bx199YRag7zr+x/lQ1MnmIPaaNx7X8hY4HLjOwiRwJeSD5j9Xuodm
 y18xJBohz/yNWx5sAZo3cUe5Py6Bp8fJgR7kyn79Ntsddv0qPg8qVdAl8X0fnzN9c7f6
 LobzamHIiEFpD51KEifH+J/wo1tugL9+3ji3kwsUbJA+Fi9Df5PrylfcACFgE8F/fir2
 F5Jw==
X-Gm-Message-State: ANhLgQ0zZxqzoqha6hTTkjDJW8N5NQ8gZ4FM4bWEFrz7N5oxQ/YFpTdp
 lz8l2eqYUqNK7aOJR4FnTZyj2Wx7caW2frgQew48tPagONZUJyTskIQFeudwzrz0/cFHgpqs9Yb
 tHrLBEE0UfVvYF38=
X-Received: by 2002:a1c:f008:: with SMTP id a8mr4199839wmb.81.1584524560126;
 Wed, 18 Mar 2020 02:42:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsflguF704xBbcUAaXnPSns5hb8z+8jjLN+hk14lc3eyJHyOYybHd0YeZtswxsJGCkKykexdQ==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr4199814wmb.81.1584524559932;
 Wed, 18 Mar 2020 02:42:39 -0700 (PDT)
Received: from redhat.com (bzq-79-183-62-79.red.bezeqint.net. [79.183.62.79])
 by smtp.gmail.com with ESMTPSA id
 m10sm3155698wmc.24.2020.03.18.02.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 02:42:39 -0700 (PDT)
Date: Wed, 18 Mar 2020 05:42:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v5 6/7] vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC
 macro
Message-ID: <20200318054039-mutt-send-email-mst@kernel.org>
References: <20200318091525.27044-1-yuri.benditovich@daynix.com>
 <20200318091525.27044-7-yuri.benditovich@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20200318091525.27044-7-yuri.benditovich@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: yan@daynix.com, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 18, 2020 at 11:15:24AM +0200, Yuri Benditovich wrote:
> Similar to VMSTATE_VARRAY_UINT32_ALLOC, but the size is
> 16-bit field.
>=20
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>

Hmm this is exactly my patch isn't it? If yes pls fix up attribution
(if this is not reposted, then when applying):

From: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  include/migration/vmstate.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 30667631bc..baaefb6b9b 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -432,6 +432,16 @@ extern const VMStateInfo vmstate_info_qlist;
>      .offset     =3D vmstate_offset_pointer(_state, _field, _type),     \
>  }
> =20
> +#define VMSTATE_VARRAY_UINT16_ALLOC(_field, _state, _field_num, _version=
, _info, _type) {\
> +    .name       =3D (stringify(_field)),                               \
> +    .version_id =3D (_version),                                        \
> +    .num_offset =3D vmstate_offset_value(_state, _field_num, uint16_t),\
> +    .info       =3D &(_info),                                          \
> +    .size       =3D sizeof(_type),                                     \
> +    .flags      =3D VMS_VARRAY_UINT16 | VMS_POINTER | VMS_ALLOC,       \
> +    .offset     =3D vmstate_offset_pointer(_state, _field, _type),     \
> +}
> +
>  #define VMSTATE_VARRAY_UINT16_UNSAFE(_field, _state, _field_num, _versio=
n, _info, _type) {\
>      .name       =3D (stringify(_field)),                               \
>      .version_id =3D (_version),                                        \
> --=20
> 2.17.1


