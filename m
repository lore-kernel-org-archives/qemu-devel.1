Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED10C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 07:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01FAA206F7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 07:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eISS4NUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FAA206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCIB8-00087a-44
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 03:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCIAK-0007EH-1X
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCIAI-0005GF-4T
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:21:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40054
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCIAI-0005Fx-0k
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583997717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Wl7RPZSZWCMfFeE2+akTWk3PjIGDcNNkNd9oQ5tAgc=;
 b=eISS4NUrZ9ZkB5iELGa7WelbArb9qkeF7SO3P5KTBgaH6k/mMiz0TO+Yd/CneL7/R9kqZ9
 nDF+13lp/94RfvG371he2/OPErGD7uaEhyxgbF+vb/dh9N8i8vGOFK42WCFFXUuD4imXGF
 OiccuNr9IuOMVcgmnA1texYJqIpBL3s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-fjVLkX72Mke_5BaAVYJYEQ-1; Thu, 12 Mar 2020 03:21:55 -0400
X-MC-Unique: fjVLkX72Mke_5BaAVYJYEQ-1
Received: by mail-qk1-f198.google.com with SMTP id j10so3242886qkm.12
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 00:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bHP9MbRUEpuMxNhY1+MEEUd5AEeKIia3Fb4M9Cs0bpY=;
 b=uEUE9x0G+pLHLjhD4RnQXVPdo4D5YNg8V7I2n7hN8UQ344yFZMbps0t79+t1bqJkF9
 2GHgDhJ0AZoiqEDn1p5Ly2XQxyMTjg4B50+zgijNGEQKJQNSfVPljAqZSDAAz/tp2owB
 AWmR0CEimsVP/yIezI3kVGAcKXcD0bsY9ChAgniNdm9atcsYdRF5YQ5sBgTpwn3Q75u0
 JkO1lYKNa2e7ylPVsaVOoRMmhPI/aOjjoMntHTubhp2mTg1vuYqmOOXx3qLOzo4H2HXC
 Vpoq2WTdwMvY0aY9FAvaeg4pOYI7r9XYCJMppebUldP0x4R3WMG4Y17ifyKcurMKviaU
 jAfA==
X-Gm-Message-State: ANhLgQ3cD8P22huqHJc6ui+8EqLB6jsOrxx6jWQoM2KaJzUMGlmAcQMg
 d0/9VtPkgoN9skef0FGc9YMQGS++jm4wPPQSDYt0/7/VybU49rDdHR8UZHabJW0XpGiG+MwDphH
 ZON5Uczjd6IpfNoE=
X-Received: by 2002:a37:67c2:: with SMTP id b185mr6226932qkc.292.1583997715095; 
 Thu, 12 Mar 2020 00:21:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs/b/ga2tlZ+QhgbUN+6/jei1n7LjaOIXlvIsehQeP5bUiMvZrrxOMq7MEpIsioG+vxdwLyRA==
X-Received: by 2002:a37:67c2:: with SMTP id b185mr6226913qkc.292.1583997714802; 
 Thu, 12 Mar 2020 00:21:54 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id p73sm8022500qka.14.2020.03.12.00.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 00:21:53 -0700 (PDT)
Date: Thu, 12 Mar 2020 03:21:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v3 1/6] virtio-net: introduce RSS and hash report features
Message-ID: <20200312031427-mutt-send-email-mst@kernel.org>
References: <20200311123518.4025-1-yuri.benditovich@daynix.com>
 <20200311123518.4025-2-yuri.benditovich@daynix.com>
 <20200311094553-mutt-send-email-mst@kernel.org>
 <CAOEp5OdgDB5u-SeZO3y4iCTjFy6hpNfPA-ADaBbnvx=MHD_dTw@mail.gmail.com>
 <20200311161819-mutt-send-email-mst@kernel.org>
 <CAOEp5OcrWewBYNT8TT6r1oFc=diq-HoGfe-zXwXPNSP0RguFkQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5OcrWewBYNT8TT6r1oFc=diq-HoGfe-zXwXPNSP0RguFkQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
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
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 09:02:38AM +0200, Yuri Benditovich wrote:
>     >=A0 =A0 =A0> +#define virtio_net_config virtio_net_config_with_rss
>     >
>     >=A0 =A0 =A0Do we have to? Let's just tweak code to do the right thin=
g...
>     >
>     >
>     > Are we going to update the virtio_net some time?
>     > If yes, IMO makes sense to do less tweaking in the middle of the co=
de.
>     > Then, upon update of virtio_net.h - easily remove all these defines=
 that
>     were
>     > added in virtio-net.c=A0
>=20
>     We'll update it in a month or two. But I'd be reluctant to merge hack=
s
>     since people tend to copy-paste code ...
>=20
>=20
> I agree that merging hacks is very bad practice.
> Which change is more looks like a hack: redefine the struct to its _real_
> layout or change the type of the struct in 5 places?

Anything that would be unacceptable as a permanent solution is a hack.
In this case how about
=09virtio_net_config_rss {
=09=09struct virtio_net_config config;
=09=09/* RSS things */
=09}


--=20
MST


