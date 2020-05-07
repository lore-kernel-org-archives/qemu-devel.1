Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0370BC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 20:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE9A208CA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 20:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNBWao3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE9A208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWnFV-00082L-0B
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 16:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jWnEc-0007Dh-S0
 for qemu-devel@nongnu.org; Thu, 07 May 2020 16:35:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57447
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jWnEb-0005bO-7j
 for qemu-devel@nongnu.org; Thu, 07 May 2020 16:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588883705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XAYXFNluzkqZAaoDrXjzfBjhIDXLC7BCe0VUcK7y9fk=;
 b=LNBWao3i9NiSKaD4Gp0uzm652/AVhoGmBATPUDmwOmRJxKRyUlQuEkqepNawRY3eD+dsod
 4dg279uRKerk4oLhxAZSb18W6PsWwEK51w/wy0yNSn4XjZyBPz+Xjs1z2MULoe0/lBEZhS
 FgCoJb873ux9TIhj0nGcC0KBRsxOfB0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-oxQXONALMZeTeSfeFh9Jqg-1; Thu, 07 May 2020 16:35:03 -0400
X-MC-Unique: oxQXONALMZeTeSfeFh9Jqg-1
Received: by mail-wm1-f71.google.com with SMTP id w189so382603wmg.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 13:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=IZlgMjFm//amAEpDGqg31nfjDi38pg58wDcj7AnHmFI=;
 b=fm+OZJyiARSE8SLZTtrABJUiHk3wQnIF4yQybUp13RZGRr0+i/J3X//YYdvkEZSb6U
 6QMMBzUGzeOU829PnhYb6ThpuC5pZcYcTzTUEjmYnOCG9a4UF4p8BiJFtuTx7ViGlIri
 3sRUOPNmcCrTQyFVAVuBrGtKLdxbj+Ft/Awu/4BSRVaWc9xLNiApPNNyVV6w9ZlpOLUW
 KSFev1jxQOVWqcuAO0bgxL7sext8aWKsrnXBo8VNrAWYhIu0hP7CbUr8yQca60ozmKx0
 ORJ1CxJ2y/snUocL8SPEpG4VpQyPymqFGPHmQImtc5HzIo2lLG51GDXaTxVjqisIP6V1
 j4nA==
X-Gm-Message-State: AGi0PuYEGiwfmqaZOarze9VDfeRUQ0MLtKyzBPLJ6lov8DTA5iy+MXFd
 g+ImpoGp7d5oKiVETG/CI2A+TVrDlJXyk9jYpfy/cg+UykUKwx9bu5U6g3DP/UQti7K/jzbIUlO
 NvKlY9IWVZEx95EE=
X-Received: by 2002:a1c:6a17:: with SMTP id f23mr11621939wmc.136.1588883701439; 
 Thu, 07 May 2020 13:35:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypJuoKTJIECeCifsho4oEs+utMlWnW7kOK5hHxFqUEuROdjU/nIs/TZqArP5oQmbLclKU+zdfQ==
X-Received: by 2002:a1c:6a17:: with SMTP id f23mr11621930wmc.136.1588883701226; 
 Thu, 07 May 2020 13:35:01 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 h2sm10038598wmf.34.2020.05.07.13.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 13:35:00 -0700 (PDT)
Date: Thu, 7 May 2020 16:34:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH] Fix erroneous double negation in conditional
Message-ID: <20200507163220-mutt-send-email-mst@kernel.org>
References: <1588046669-24706-1-git-send-email-raphael.norwitz@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <1588046669-24706-1-git-send-email-raphael.norwitz@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:15:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, raphael.s.norwitz@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 28, 2020 at 12:04:29AM -0400, Raphael Norwitz wrote:
> In vhost_migration_log() there is the following check:
>     if(!!enable =3D=3D dev->log_enabled) {
>         return 0;
>     }
>=20
> The double negative =E2=80=9C!!=E2=80=9D is unnecessary and bad coding st=
yle.

It converts the value to bool.

> This
> change removes it.
>=20
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> ---
>  hw/virtio/vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index aff98a0..83be0c8 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -814,7 +814,7 @@ static int vhost_migration_log(MemoryListener *listen=
er, int enable)
>      struct vhost_dev *dev =3D container_of(listener, struct vhost_dev,
>                                           memory_listener);
>      int r;
> -    if (!!enable =3D=3D dev->log_enabled) {
> +    if (enable =3D=3D dev->log_enabled) {
>          return 0;
>      }
>      if (!dev->started) {
> --=20
> 1.8.3.1


