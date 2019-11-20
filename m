Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D344C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4778620715
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYPCqW7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4778620715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSOI-0002KZ-5o
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:59:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iXSKu-0004i0-67
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:56:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iXSKr-0003yY-A1
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:56:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43776
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iXSKr-0003yI-5P
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574265363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dG1jDAkZjtJQ+wQQHHS+QYvheV5NTaym2NMbhvczy0o=;
 b=XYPCqW7OWUG7OJxHGRPltbFA7iXPqrbPQxs1KYEiV2F3rZdcFeT9mwd/Hx8OV3xM4J30O2
 1eAg7ruaSDchLPegVHyss2Q30dDt53XHGhGDlz9/bQ/tgjWNC3yrVRw4EawffnMA7pa/Lc
 FgGkc2zL0xwuYOUEQNPSaX6TrPlMcG8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-GqSeS7U2OzmPc78P63fQcA-1; Wed, 20 Nov 2019 10:56:02 -0500
Received: by mail-qk1-f197.google.com with SMTP id a129so16058698qkg.22
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 07:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aJldszurJTfTC5FLA1JbIBG/Mrx28zninuyRKVveJMs=;
 b=oLB9aPieWqAhH/I74E/c36kaxGJ+WorDh/d1iaFSMhridOsDQ5RBoL3hqzwm3RBLxw
 eUNM8k1gzmc+0nvU3hSls+jHLSDnR3XzE7GY7k5YC6dCMBBsaz8ObA5B0uGK04Qgqz9I
 x9Xlacn7tdZHUqyaQcuM2FukKTBzFDqe5Q83unB9BpCZJwxfXkt6lmdC/YyCKyNEcdmh
 YeQuDUQnwes4iQoGGKbxu+QKD9s5ZMS2I0RyZzcnY8+lW+fseKw4W49pCQL695jdPWft
 AQH0aQTHtdH+BKpuyGaa4APqypBDAfH4giKjCilr5hJWCRPweglyEVW+o445AK5tUo1g
 K07Q==
X-Gm-Message-State: APjAAAUisSAf/MNfBQ9G3/c0eQFpXjnUErH0tqG3D48HlKu/BBj7QY+f
 d9O7cf2fnPwLoZhfEgeQfDdCigbdapm05Wjbh7s6mfj6+dXx5Re41UEv0QYR4PCH5vckI+LBLiV
 VDXLu4M5z34rVmPA=
X-Received: by 2002:a37:aa8b:: with SMTP id t133mr3149690qke.449.1574265361677; 
 Wed, 20 Nov 2019 07:56:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqy4ssBFLPw2KGmXXdEwRMey0KcKrIVtLBNDIDQTh9UDcOfVZU1XnDOB3Kim3dwpFf5K3Td7Qw==
X-Received: by 2002:a37:aa8b:: with SMTP id t133mr3149661qke.449.1574265361422; 
 Wed, 20 Nov 2019 07:56:01 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id p3sm11931221qkf.107.2019.11.20.07.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 07:56:00 -0800 (PST)
Date: Wed, 20 Nov 2019 10:55:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v3 2/4] net/virtio: return early when failover primary
 alread added
Message-ID: <20191120105529-mutt-send-email-mst@kernel.org>
References: <20191120154951.27877-1-jfreimann@redhat.com>
 <20191120154951.27877-3-jfreimann@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191120154951.27877-3-jfreimann@redhat.com>
X-MC-Unique: GqSeS7U2OzmPc78P63fQcA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

in case you repost:

>Subject: Re: [PATCH v3 2/4] net/virtio: return early when failover primary=
 alread added

s/alread/already/


On Wed, Nov 20, 2019 at 04:49:49PM +0100, Jens Freimann wrote:
> Bail out when primary device was already added before.
> This avoids printing a wrong warning message during reboot.
>=20
> Fixes: 9711cd0dfc3f ("net/virtio: add failover support")
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/net/virtio-net.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 946039c0dc..ac4d19109e 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -759,6 +759,10 @@ static void failover_add_primary(VirtIONet *n, Error=
 **errp)
>  {
>      Error *err =3D NULL;
> =20
> +    if (n->primary_dev) {
> +        return;
> +    }
> +
>      n->primary_device_opts =3D qemu_opts_find(qemu_find_opts("device"),
>              n->primary_device_id);
>      if (n->primary_device_opts) {
> --=20
> 2.21.0


