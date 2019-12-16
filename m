Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A1FC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E062053B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awyeXq+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E062053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igqCB-00040j-A8
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 08:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1igqA6-0001m4-MA
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:11:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1igqA4-0006pm-8x
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:11:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37566
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1igqA3-0006o9-DD
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576501902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=scG5Kx9flS/O+fWEMZ9AL1b4bI3lFixtW/AfHlhLa/g=;
 b=awyeXq+OVvqkzQ+wYkw8iNLvGTvPsL9CV5bY9dVYQK/zw+ThuOfa60TZB3LgrNp0NEtW/W
 k7iXPxftjQE71MiGlbpFLTBF2CpdJJxxa/Z2u6bqYUCr5ZPy+w/zFW7FJ9NUzgtcVO6kPj
 DRAsNL7NQr7HDSADN9+qzKg5lM4uXic=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-3LckmZTLOJucljhadButEQ-1; Mon, 16 Dec 2019 08:11:41 -0500
Received: by mail-wr1-f72.google.com with SMTP id b13so2295547wrx.22
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 05:11:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GGy7hA1R/Ff1cUj5iexZAw7T35hQcQ6yTVuO7Q49ddg=;
 b=uPARs8QClErNE/ogbEkNpcakxOjFGDJ5V77n5dWt3oSTf78Y4LTS3V4o4cy+uSESJ0
 +UpVZjmsd5aUhXcmbA+m6gwZis4mrw2WwkMns/DBK5aFYIDnFUYWlVB3+8btYe6c/JoV
 r35gP+ZuiKLb6Lf7FGWyZEzouV5DJJlPOXD/q8ISAf3WPbbNHvpAHjTeKx48CAcjljQk
 Gkt3i450W0HC06fRNavYGRkfBboUuPxvAUebe6MO5EJ4hwHc5SbmxFXd0q3/GySUAsau
 uVmwts9R1+r1o6seGKAGwVcj+pXH4wxpOUexbDDCx6nxWZNM7KAvxjlyFzhkkoJ+GR34
 kPEA==
X-Gm-Message-State: APjAAAWuJhBSOC2baLFiCVWXEUjwESyeMPYcW7hRAmCNgAFbZtuKtedt
 rXoNXhorKPVA7kywHTxrTUl6v0cWkKeBppbbAMhQXcKTLMs3s270zZjtit9VOwzgNXks6QkBSH+
 Nv3baSKaSmp1e3Yc=
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr29446731wrn.214.1576501900354; 
 Mon, 16 Dec 2019 05:11:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqyGHJubMRcjF3rMhfF0ZkDV3XSz2Wf97J4Nphi2H0AX4FuSFFoF7H4ntveSXYPOaUHPW1jkNg==
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr29446705wrn.214.1576501900156; 
 Mon, 16 Dec 2019 05:11:40 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:cde8:2463:95a9:1d81?
 ([2001:b07:6468:f312:cde8:2463:95a9:1d81])
 by smtp.gmail.com with ESMTPSA id z21sm21002520wml.5.2019.12.16.05.11.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 05:11:39 -0800 (PST)
Subject: Re: [PATCH 07/12] hw/ide/piix: Remove superfluous DEVICE() cast
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191213161753.8051-1-philmd@redhat.com>
 <20191213161753.8051-8-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ea21857-7304-1016-2bd4-d2beb2b75551@redhat.com>
Date: Mon, 16 Dec 2019 14:11:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191213161753.8051-8-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: 3LckmZTLOJucljhadButEQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/12/19 17:17, Philippe Mathieu-Daud=C3=A9 wrote:
> Commit 02a9594b4f0 already converted 'dev' to DeviceState.
> Since the cast is superfluous, remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/ide/piix.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
> index db313dd3b1..ffeff4e095 100644
> --- a/hw/ide/piix.c
> +++ b/hw/ide/piix.c
> @@ -193,7 +193,8 @@ int pci_piix3_xen_ide_unplug(DeviceState *dev, bool a=
ux)
>              blk_unref(blk);
>          }
>      }
> -    qdev_reset_all(DEVICE(dev));
> +    qdev_reset_all(dev);
> +
>      return 0;
>  }
> =20
>=20

Queued, thanks.

Paolo


