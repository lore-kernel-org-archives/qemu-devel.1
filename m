Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27615C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 20:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA02206A1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 20:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wnvq3IeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA02206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMdeC-00005J-4t
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 16:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jMddb-00081b-EB
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 16:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jMdda-0002RB-Gj
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 16:18:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41436
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jMdda-0002Qh-DQ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 16:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586463537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3vKBb5Lc9IFuoMO1BKmiAVROFNQmWaGJXo1mut7TsPs=;
 b=Wnvq3IeQunoV+tmZdBA+136BCP+6AKtJ3uDUm64ghiHcMtjVt+xBAe0Uc8iXRz0rL5HqXw
 lFhnRZTQtj8Pcn1YD5ebrydFa5jPgnXWW/Zxo943peEWESG7br7eYv9D7CNmCwqUL4QmLB
 WSwibjmGryTONhedct0c4EoTe6e6yZc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-jeVownLINX6Ql3F9joc4cw-1; Thu, 09 Apr 2020 16:18:53 -0400
X-MC-Unique: jeVownLINX6Ql3F9joc4cw-1
Received: by mail-wr1-f71.google.com with SMTP id n7so7264842wru.9
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 13:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=AJBticWigxjd1m/sXCH6CS6jcYJfAhFRAd45SGm5I4E=;
 b=r8mHkEOVP/kMzoGtDGQfiEDR6pWCKuf6gSt81sRY2ed6JOC0LK5Ekp9BOkmt1pvrrN
 FNiViuVcjNwChGYV5k37JI2rDbA9sT6r1T8q7/oAALao3KvtWfOWiECAA29wmLIYz9Dt
 xw9jgNY67oPjX4inRrPaxbybjh6HZtkoYNKTBfPCeTLXSBndXkbXdPZJsLAp4i4vykMH
 5As82vdI6DnP29U8ejIpIrHsRHGmqpH4KEsQGTYldXN71Np4MxIMxoT2aFeDNc/tbYyh
 /5qCptGPrleqkuSA26uq7u5EqOIdsdOrwnP2sLz8XQlrpkVwkYL8EwORTU+Mij2/DC7t
 CV7Q==
X-Gm-Message-State: AGi0PubivKgg2C2XDstFgudxnMpXD8CTr5rPhj6rZ0iK5owbqpifThiL
 Q9ecbzNk8C8W0vpdEMTrg3vSql8rpkEoR/IrRJ021/z6d+CSssc1t3tXxk8Dnku4HOMT4zuxbSI
 s/wUKJQt/NoIj9e8=
X-Received: by 2002:a05:600c:a:: with SMTP id
 g10mr1575970wmc.153.1586463532638; 
 Thu, 09 Apr 2020 13:18:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypJdk9bk3/hjz3YKzU0Ix4SHglGYmuclXDqeBf5w8jw/FgBGlxwl4iGZY8rI7kKhKT8VPU2ilA==
X-Received: by 2002:a05:600c:a:: with SMTP id
 g10mr1575949wmc.153.1586463532288; 
 Thu, 09 Apr 2020 13:18:52 -0700 (PDT)
Received: from redhat.com (bzq-109-67-97-76.red.bezeqint.net. [109.67.97.76])
 by smtp.gmail.com with ESMTPSA id
 106sm32337899wrc.46.2020.04.09.13.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 13:18:51 -0700 (PDT)
Date: Thu, 9 Apr 2020 16:18:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Feng <fengli@smartx.com>
Subject: Re: hotplug issue of vhost-user-blk
Message-ID: <20200409161748-mutt-send-email-mst@kernel.org>
References: <CAHckoCzojVSHLAwBP2QhFx3Gw6j9DVPRwNSML9D4GQMzKr9Y3g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHckoCzojVSHLAwBP2QhFx3Gw6j9DVPRwNSML9D4GQMzKr9Y3g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Pan Nengyuan <pannengyuan@huawei.com>, jusual@redhat.com,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 raphael.norwitz@nutanix.com, Kyle Zhang <kyle@smartx.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 08, 2020 at 10:25:42AM +0800, Li Feng wrote:
> Hi all,
>=20
> Hotplug of vhost-user-blk doesn't not work in qemu master branch and
> all previous version.
>=20
> The action I insert a vhost-user-blk disk is:
> (qemu) chardev-add socket,id=3Dspdk_vhost_blk2,path=3D/vhost-blk.0,reconn=
ect=3D1
> (qemu) device_add
> vhost-user-blk-pci,chardev=3Dspdk_vhost_blk2,id=3Dspdk_vhost_blk2,num-que=
ues=3D4
>=20
> Until here, it's well.
>=20
> Then I unplug it from qemu:
> (qemu) device_del spdk_vhost_blk2
> (qemu) chardev-remove spdk_vhost_blk2
> Error: Chardev 'spdk_vhost_blk2' is busy

Pan Nengyuan (cc'd) fixed unplug recently so I expect it
worked for him after the patch ...

> The related code is here:
> qmp_chardev_remove
>     -> qemu_chr_is_busy
>     -> object_unparent(OBJECT(chr));
>=20
>  330 static bool qemu_chr_is_busy(Chardev *s)
>  331 {
>  332     if (CHARDEV_IS_MUX(s)) {
>  333         MuxChardev *d =3D MUX_CHARDEV(s);
>  334         return d->mux_cnt >=3D 0;
>  335     } else {
>  336         return s->be !=3D NULL;
>  337     }
>  338 }
>=20
> My question is:
> 1. s->be is set to NULL when qemu_chr_fe_deinit is called.
> However, the qmp_chardev_remove is blocked at qemu_chr_is_busy check,
> then the object_unparent will not be called.
> 2. Is there a path that device_del will trigger the s->be that been set t=
o NULL?
>=20
> How should I fix this issue?
> I have tested that comment the qemu_chr_is_busy works well.
>=20
> Thanks in advance.
>=20
> Feng Li
>=20
> --=20
> The SmartX email address is only for business purpose. Any sent message=
=20
> that is not related to the business is not authorized or permitted by=20
> SmartX.
> =E6=9C=AC=E9=82=AE=E7=AE=B1=E4=B8=BA=E5=8C=97=E4=BA=AC=E5=BF=97=E5=87=8C=
=E6=B5=B7=E7=BA=B3=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=EF=
=BC=88SmartX=EF=BC=89=E5=B7=A5=E4=BD=9C=E9=82=AE=E7=AE=B1. =E5=A6=82=E6=9C=
=AC=E9=82=AE=E7=AE=B1=E5=8F=91=E5=87=BA=E7=9A=84=E9=82=AE=E4=BB=B6=E4=B8=8E=
=E5=B7=A5=E4=BD=9C=E6=97=A0=E5=85=B3,=E8=AF=A5=E9=82=AE=E4=BB=B6=E6=9C=AA=
=E5=BE=97=E5=88=B0=E6=9C=AC=E5=85=AC=E5=8F=B8=E4=BB=BB=E4=BD=95=E7=9A=84=E6=
=98=8E=E7=A4=BA=E6=88=96=E9=BB=98=E7=A4=BA=E7=9A=84=E6=8E=88=E6=9D=83.
>=20


