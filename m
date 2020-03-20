Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A176FC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:25:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660DD20724
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvhLvntk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660DD20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFKSP-00034Z-Iu
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 12:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrampazz@redhat.com>) id 1jFKRX-0002BH-V4
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:24:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrampazz@redhat.com>) id 1jFKRW-0000Bl-NV
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:24:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35787)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrampazz@redhat.com>) id 1jFKRW-0000BY-Jv
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584721458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JTUzNrD9W1Ks5NW4ILFDGYfoKhdB8E3D2QHkFH18rzs=;
 b=dvhLvntk4IpoHXNxV9RySyH5yco+7/ENKqPySdO0X16WAQgHlsbyyXBQ9XpbisV3zaSQVq
 50f9OtsvV8+vlv5NuHXbFfvHj2j458oZWXc6xHBAAI9ARaTfcYabLs0l6A/D7jnQFVuMdS
 HyM7hYEryDKAXyAlypBKhCSEPQxlcaI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-mlJtNuZvOXmjlLQtMpp4Ng-1; Fri, 20 Mar 2020 12:24:16 -0400
X-MC-Unique: mlJtNuZvOXmjlLQtMpp4Ng-1
Received: by mail-wm1-f72.google.com with SMTP id g26so2557506wmk.6
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 09:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kZPWtmLfiOsD761IhLQwHgjHSApyOLbgCNjrrMvZqNw=;
 b=dEmqF0HNbu9fEYIthp1zrrIUz1u0SSDzWURNWEPCTeLLINWlOQHiouLJX/H6etPRg2
 fjCZCMs6uNk+KXkfxmk5KsQ+lkaGSCkG2+yCQzQ+hPEhokWals7BLXEWF3Rk4LTwzle8
 fykMVT/7ET6vhhiuyXBU3og3aWE0Y1GFc/mgupl0OzjCa0H6KCrhBoWBqzaESqL9KdU+
 B/GvR4uasUb3J5iyzkJsjlyRu6EtSjLkJ2S/ZnNGAwD6c8TvnbPcNZ/Xm2gUlZ4Fr6i6
 PYZKtb+y7TboXmqN8MVeHkcojLxviMutKOJ8KYNM1SlZVuaDdkyP8tZAN7ft4Mc6Kqtq
 ispA==
X-Gm-Message-State: ANhLgQ2StM7BQnc/tZ6XsG7VVkB9/mTc9m/vK5Tz6qpLq71ibuKCJEDO
 5nYfx9JcNyFaJNn1n7FcggLiuaCqc0htpYIZpQ9RTeN+m8uNViYyW4EVOzAfJtXSeIx+DUu0u8X
 t3h6NEzVOWGwejoOalLm6gfT3IB3XgSw=
X-Received: by 2002:a5d:6146:: with SMTP id y6mr12128476wrt.107.1584721454832; 
 Fri, 20 Mar 2020 09:24:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vun/QyCQuXo/C+xkgywJYHI1yH6FehNAjOIiGgB9V8wDqtKVGQngLfFTXuYd1wreg+x1sj53q+F1Zfr0Iodz9U=
X-Received: by 2002:a5d:6146:: with SMTP id y6mr12128443wrt.107.1584721454520; 
 Fri, 20 Mar 2020 09:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200320151254.16766-1-ovoshcha@redhat.com>
 <20200320151254.16766-4-ovoshcha@redhat.com>
In-Reply-To: <20200320151254.16766-4-ovoshcha@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Fri, 20 Mar 2020 13:24:03 -0300
Message-ID: <CAKJDGDZQyxWa+c5E9-=PULTsU3hahSTZV2mm_63axg8s65gu4A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Acceptance test: provides to use RDMA transport
 for migration test
To: Oksana Vohchana <ovoshcha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Wainer Moschetta <wainersm@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Oksana,

On Fri, Mar 20, 2020 at 12:16 PM Oksana Vohchana <ovoshcha@redhat.com> wrot=
e:
>
> Adds test for RDMA migration check
>
> Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
> ---
>  tests/acceptance/migration.py | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.p=
y
> index a783f3915b..c8673114a9 100644
> --- a/tests/acceptance/migration.py
> +++ b/tests/acceptance/migration.py
> @@ -105,3 +105,15 @@ class Migration(Test):
>          """
>          free_port =3D self._get_free_port()
>          dest_uri =3D 'exec:nc -l localhost %u' % free_port
> +
> +    @skipUnless(_if_rdma_enable(None), "Unit rdma.service could not be f=
ound")
> +    @skipUnless(_get_interface_rdma(None), 'RDMA service or interface no=
t configured')

If you change these two methods to be static, you will not need to use
the `None` parameter, as I mentioned in patch 2 of this series.

> +    def test_migration_with_rdma_localhost(self):
> +        iface =3D self._get_interface_rdma()
> +        ip =3D self._get_ip_rdma(iface)
> +        if ip:
> +            free_port =3D self._get_free_port(address=3Dip)
> +        else:
> +            self.cancel("Ip address isn't configured")
> +        dest_uri =3D 'rdma:%s:%u' % (ip, free_port)
> +        self.do_migrate(dest_uri)
> --
> 2.21.1
>
>


