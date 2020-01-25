Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBBEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 11:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D75206D3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 11:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iApWdsGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D75206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivK03-0007ME-0T
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 06:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ivJzS-0006uv-RC
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 06:52:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ivJzR-0008Sg-8q
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 06:52:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44807
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ivJzR-0008PG-1V
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 06:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579953156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nIa8eklz4ln12MJkxTp0qhxDX/r52j4QynmNdGHYrU4=;
 b=iApWdsGvZsdEeAswrn9pVgm+zVfBr4Fj0os5ddkO7VobNNqGNJeTejZUMLZb480lfiJjQ1
 XmtlSsPtj9tjhuAhJ9Z8E6VNQOxD3EcFKk9gNhsfjbl8QVO/ns5YzgQhcnP+G6iOOfw8Iq
 DhInWBB/yBuBxRBUxipaoQDUNMfLooI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-wg_1l5G1PjqJxzU8y__knQ-1; Sat, 25 Jan 2020 06:52:34 -0500
Received: by mail-wr1-f69.google.com with SMTP id d8so2860768wrq.12
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2020 03:52:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vqHYDnSs3oDLTLSQ4Aw2QU78Aot33NnQ6B9wZEFOpgo=;
 b=iAFMYiUDV/Fesh7LC/j4dIt8BU/YxG3HeDGsKMZPVWO4eDmaEgFA7CzK0JcID2Vb0Z
 5qWsu/72wHxkXJmZj+/Bro1uy0rx4XYwboOTK9/lV7P1+Y2MULhTnpszNVAmhMQ3sLPs
 MQKatVOEVktwrLr7kEbjJzPkWqZjTN3CJMnufyaeJgEB+lmac61gNBCVqVAb9t3Or1FK
 CXn8rTp7KDUba+IBMjxbFcgRLcjDV/TQrQpgj38T12iReCmHGmLds1XDziM0LLil1fzk
 Emr0zMxGENfEqK0jFvDE8IDrqVRLuvVQ5YQ/yyn1GJSO7z06gjSAHqcndBrX2AgGt2ku
 B3tw==
X-Gm-Message-State: APjAAAXTJBGBpYFIJk7V/6WtuOwv2zJ8+mIcxLvR7hrPiVrf1H5FyImr
 8YP0hPd1MDWhQ9kRz/T9ZuFXqhIHXg9x+RiVyr0EKeKOdQQCq5rfhFn/0n+HIJ5WMaErW8nqx/N
 W0adwfE4LXqNRGD4=
X-Received: by 2002:adf:82f3:: with SMTP id 106mr9843052wrc.69.1579953152800; 
 Sat, 25 Jan 2020 03:52:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjwhKK7ktNnsfWLFxkd21cboGVLtBRmYLyh8yRtwC6beRr5rSsf3X2MNuOSLFav2Rt7ybUPA==
X-Received: by 2002:adf:82f3:: with SMTP id 106mr9843033wrc.69.1579953152582; 
 Sat, 25 Jan 2020 03:52:32 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:784d:f09c:63f4:b9cb?
 ([2001:b07:6468:f312:784d:f09c:63f4:b9cb])
 by smtp.gmail.com with ESMTPSA id u188sm10649101wme.10.2020.01.25.03.52.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2020 03:52:31 -0800 (PST)
Subject: Re: Making QEMU easier for management tools and applications
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org> <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <20200124095027.GA824327@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <47e06198-34cb-a0af-1086-4b72c88c5dc1@redhat.com>
Date: Sat, 25 Jan 2020 12:52:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200124095027.GA824327@redhat.com>
Content-Language: en-US
X-MC-Unique: wg_1l5G1PjqJxzU8y__knQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/01/20 10:50, Daniel P. Berrang=C3=A9 wrote:
>   * qemu-launcher-$TARGET
>=20
>     A binary that is able to launch qemu-runtime-$TARGET
>     with jailers active.
>=20
>     This has no command line arguments except for a pair
>     of UNIX socket paths. One is a QMP server, the other
>     is the path for the QMP of qemu-runtime-$TARGET.
>=20
>     Commands it processes will be in automatically proxied
>     through to the qemu-runtime-$TARGET QMP, with appropriate
>     jailer updates being done in between.
>=20

What would be the advantage of this over the Libvirt embedded driver?
Especially if you include in the picture something like libvirt-go-xml
(or libvirt-GObject, does it still exist?) that hides the XML from the
code that uses it.

The main complication in the launcher is hotplug, which means that a
simple "do a couple bind mounts, unshare, drop privileges and forget
about it" approach doesn't work.  Proxying QMP commands doesn't seem
that easy, and I don't see much code being shared between the launcher
and QEMU; if the existing QEMU code is not suitable for Libvirt, it
wouldn't be suitable for a qemu.git launcher either.

Also, as you mentioned earlier, QEMU wants to keep its vocabulary
lower-level, and therefore the launcher's vocabulary would end up
diverging from QEMU.  Some example:

- QEMU wants a qemu-pr-helper socket path, the launcher would take care
of launching qemu-pr-helper itself

- QEMU wants the complete configuration on the migration destination,
the launcher might take care of sending it from the source?

At this point, you get something that looks very much like Libvirt and,
especially if you include live migration, it has to take into account
the same compatibility considerations as Libvirt.

Thanks,

Paolo


