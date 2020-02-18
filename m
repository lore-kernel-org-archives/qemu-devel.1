Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC95CC34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 21:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75EE9206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 21:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNhi8WqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75EE9206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Al5-00055T-I0
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 16:50:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4AkO-0004ba-Mz
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 16:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4AkM-0004AT-NU
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 16:49:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39884
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4AkM-00047q-JK
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 16:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582062576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k2V6HGOExK0pRE+q0LbFpmelaLKVlIC10gOLv60IVF8=;
 b=VNhi8WqM0AAu+2QlxCMC8BASDTL88jApIg0EnEcJ18wh6GQpARA0s7w388AOXldfSa4qsi
 tu1fQp+3HJTfnqUP0oAxVHs1xRpcbhdlbdIe81Td7s/ytLVC3waD1/ZEXoqVs6hAMe5egt
 Lu3z2gZMZ5xz7MqgK0IGWptz/o2Gk0s=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-fl74iOO9NuKEkat0Uxe4cw-1; Tue, 18 Feb 2020 16:49:34 -0500
Received: by mail-qv1-f72.google.com with SMTP id e26so13319912qvb.4
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 13:49:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=N1ZFjhw3YnA48X38On5DhzUeUi1I3zviTc31I5Gkx4I=;
 b=oCa5z7oMEj8tQNrqUewjEFvmdmxspr/zgwfECb4rihHBhVkG4lqAdwC66RY/1VuMOK
 iBNwy5MzQPJGIRNkiCSlv5JpMDCWmDz4jgb4cC+eQUpdtrJgt+QmXkf86HpPSWJtehvJ
 Ud8v8OLfxhqu/1MBVZrB8B8xDCI87l7CyTIPUfDAPybKpmBnty3XCyi5DdEaAQjxlNpE
 jKlGWz+K6l2/noBsz33rdUtpu61bhYunbduopIv5MXgaXqUUhP+7GiHHFSmjzMM/omx+
 sx9w3NJIIbgk90/yyvKBasmpQt843ssu1FyPIu+gUAA7LM3tCozwlzL0KwLkTgtpjNac
 wxIw==
X-Gm-Message-State: APjAAAV1A8FJokcW7Bu03outKhY868mqO3l6+CsSZsN6PxLVruCLN34Y
 ehC+JGD4eNQ+tiBAd3hADaFkl6HQmfOQU2k0gC7bM00exrsaTN9Sw4fI0WfdoOWTzGzKgzYTY86
 ljmaLarSxDSwusM0=
X-Received: by 2002:ac8:750e:: with SMTP id u14mr18605577qtq.320.1582062574166; 
 Tue, 18 Feb 2020 13:49:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqyofLNNcFDO9XwEd6UNakKhDzak/6ec0kj2j3jzYh7v1C+mzsfaYt63GXKOIBNNLlP41/nbNw==
X-Received: by 2002:ac8:750e:: with SMTP id u14mr18605561qtq.320.1582062573925; 
 Tue, 18 Feb 2020 13:49:33 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id t3sm2600050qtc.8.2020.02.18.13.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 13:49:33 -0800 (PST)
Date: Tue, 18 Feb 2020 16:49:32 -0500
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] memory: batch allocate ioeventfds[] in
 address_space_update_ioeventfds()
Message-ID: <20200218214932.GD7090@xz-x1>
References: <20200218182226.913977-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200218182226.913977-1-stefanha@redhat.com>
X-MC-Unique: fl74iOO9NuKEkat0Uxe4cw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 18, 2020 at 06:22:26PM +0000, Stefan Hajnoczi wrote:
> Reallocing the ioeventfds[] array each time an element is added is very
> expensive as the number of ioeventfds increases.  Batch allocate instead
> to amortize the cost of realloc.
>=20
> This patch reduces Linux guest boot times from 362s to 140s when there
> are 2 virtio-blk devices with 1 virtqueue and 99 virtio-blk devices with
> 32 virtqueues.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  memory.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/memory.c b/memory.c
> index aeaa8dcc9e..2d6f931f8c 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -794,10 +794,18 @@ static void address_space_update_ioeventfds(Address=
Space *as)
>      FlatView *view;
>      FlatRange *fr;
>      unsigned ioeventfd_nb =3D 0;
> -    MemoryRegionIoeventfd *ioeventfds =3D NULL;
> +    unsigned ioeventfd_max;
> +    MemoryRegionIoeventfd *ioeventfds;
>      AddrRange tmp;
>      unsigned i;
> =20
> +    /*
> +     * It is likely that the number of ioeventfds hasn't changed much, s=
o use
> +     * the previous size as the starting value.
> +     */
> +    ioeventfd_max =3D as->ioeventfd_nb;
> +    ioeventfds =3D g_new(MemoryRegionIoeventfd, ioeventfd_max);

Would the ioeventfd_max being cached and never goes down but it can
only keep or increase?  I'm not sure if that's a big problem, but
considering the commit message mentioned 99 virtio-blk with 32 queues
each, I'm not sure... :)

I'm thinking maybe start with a relative big number but always under
control (e.g., 64), then...

> +
>      view =3D address_space_get_flatview(as);
>      FOR_EACH_FLAT_RANGE(fr, view) {
>          for (i =3D 0; i < fr->mr->ioeventfd_nb; ++i) {
> @@ -806,8 +814,11 @@ static void address_space_update_ioeventfds(AddressS=
pace *as)
>                                               int128_make64(fr->offset_in=
_region)));
>              if (addrrange_intersects(fr->addr, tmp)) {
>                  ++ioeventfd_nb;
> -                ioeventfds =3D g_realloc(ioeventfds,
> -                                          ioeventfd_nb * sizeof(*ioevent=
fds));
> +                if (ioeventfd_nb > ioeventfd_max) {
> +                    ioeventfd_max +=3D 64;

... do exponential increase here (max*=3D2) instead so still easy to
converge?

Thanks,

> +                    ioeventfds =3D g_realloc(ioeventfds,
> +                            ioeventfd_max * sizeof(*ioeventfds));
> +                }
>                  ioeventfds[ioeventfd_nb-1] =3D fr->mr->ioeventfds[i];
>                  ioeventfds[ioeventfd_nb-1].addr =3D tmp;
>              }
> --=20
> 2.24.1
>=20

--=20
Peter Xu


