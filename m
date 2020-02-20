Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AD8C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 20:37:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C52206EF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 20:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmiVa+6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C52206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4sa3-000850-Hg
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 15:37:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j4sZN-0007Ki-Ok
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 15:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j4sZL-0007ji-UV
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 15:37:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50255
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j4sZL-0007jI-IB
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 15:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582231030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GpVntnYFcRNRYp9vd38D9RLd3ZoZgdoVy3FSxPuLQ18=;
 b=RmiVa+6NWfzQl/7OOMT6BahYlKE9SVF7kBaZgREjBHjAJCHvPG8IMCyZ1I7s16ZhX9oaVN
 vIcRftyxfi0v5ZVwb7n2GTu2EMn4G+HPneHM8kfnnB+Nfry4V2WDCaQJBD3q1J6HRka8ku
 SrALkBaUuSROcSR/Mt3VE3AJSYQU960=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-xTnS4s-bPS-feLlXn_SaFA-1; Thu, 20 Feb 2020 15:37:06 -0500
X-MC-Unique: xTnS4s-bPS-feLlXn_SaFA-1
Received: by mail-qt1-f199.google.com with SMTP id k20so3470360qtm.11
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 12:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=so8lauUUoGRoi/jJSytdd24qTKrEHkl0ntF8odMqIEk=;
 b=gn82MnYgKO6OmUCld0D0AyJX8IHW+78I80T4MAhQ+XWL+2Rgs+N8g7fNyluhikSJNz
 5QCys5LlFEkxf45siEEYNmA6ll261UwKGMGasdwx6amK/8k0l2DHpHdrcSo5Fjof1oDQ
 4dt6Y6pItJ8Lvkdou2gSmZwKXGZMj7x1BZvD3Yxv+SKzyYW2bK4c/3BafS7SRFuk0gUM
 RE39J7d5uyF2DUiAd3yUs7xmFhMNpPY5+Z2x3uqDGlA2/A6C5aCU08YzkjyFWW4Li9gv
 GuaEROR/v3fkRrTfle5pVNxLbJ9a/9x/+y3FhQrqAqf+ccyPis0ZC/+QGyDABX51jSTJ
 B+PA==
X-Gm-Message-State: APjAAAVoHvmuGKtLTreenFF9S/Xn0tFkcFjUH5CrcdE/tirdGeWvuAUE
 jdGTWZdtq7WWGz/yIf9DaHxQGmyHombo67TbeOHgNR/WwEHkXUJ7vHoqf9Hf1Pevr3WKcbjpzqJ
 9CF0grNqvbdg4Pf0=
X-Received: by 2002:a05:6214:1708:: with SMTP id
 db8mr26944601qvb.129.1582231025549; 
 Thu, 20 Feb 2020 12:37:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqz2CDQ9YV75e83hj4oP1c/1mOoRGzxY5Z43juejD8dEw+xmm2eKkwPF3YfbhM2cUNmFM6trdQ==
X-Received: by 2002:a05:6214:1708:: with SMTP id
 db8mr26944566qvb.129.1582231025364; 
 Thu, 20 Feb 2020 12:37:05 -0800 (PST)
Received: from redhat.com (bzq-109-67-14-209.red.bezeqint.net. [109.67.14.209])
 by smtp.gmail.com with ESMTPSA id a2sm397978qka.75.2020.02.20.12.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 12:37:04 -0800 (PST)
Date: Thu, 20 Feb 2020 15:36:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 01/20] scripts/git.orderfile: Display Cocci scripts
 before code modifications
Message-ID: <20200220153648-mutt-send-email-mst@kernel.org>
References: <20200220130548.29974-1-philmd@redhat.com>
 <20200220130548.29974-2-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200220130548.29974-2-philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 20, 2020 at 02:05:29PM +0100, Philippe Mathieu-Daud=E9 wrote:
> When we use a Coccinelle semantic script to do automatic
> code modifications, it makes sense to look at the semantic
> patch first.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  scripts/git.orderfile | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/scripts/git.orderfile b/scripts/git.orderfile
> index 1f747b583a..7cf22e0bf5 100644
> --- a/scripts/git.orderfile
> +++ b/scripts/git.orderfile
> @@ -22,6 +22,9 @@ Makefile*
>  qapi/*.json
>  qga/*.json
> =20
> +# semantic patches
> +*.cocci
> +
>  # headers
>  *.h
> =20
> --=20
> 2.21.1


