Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50B1C2BBC7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2695206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+8hNgGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2695206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOJEN-0002qz-Qi
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 06:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jOJD2-0001ou-RK
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jOJCx-0002UA-DX
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:54:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24505)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jOJCx-0002TY-6g
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586861661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kcBvEz/gcIjry6QgbD6r6ZCvYrqYgRay4MpmDAq0jYQ=;
 b=U+8hNgGALu7Mk/1YzuvuOjKDrW1YwSwXoEd+QJV435RCGgOrppQg5k7sUaLWmFd0JRa+NV
 QOLAmtLJgjFmM5nuS3x9E4zmskNKPpWG8PxYmWyk0R2+uOwnBRTeJge758OmNdEG7cpmUs
 LRztT7LDorQtbBVXElqUYcAa6bf1Lwo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-x1NgsTWoNtaOpy5o8B4D_A-1; Tue, 14 Apr 2020 06:54:19 -0400
X-MC-Unique: x1NgsTWoNtaOpy5o8B4D_A-1
Received: by mail-wr1-f72.google.com with SMTP id j22so8510213wrb.4
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 03:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BXOPiFT8Bm/J9GCfOFyotPt7Zt+/5g3g0aeDp3009U8=;
 b=IUzk6Ih154HQpcSHovt7fdSLU+YGzxgHgJIj3BiA/ogQYkod9PcD5hcXRhS3IhtxXN
 8rbLWeW4sbVVasO4P6XNeKtDZz/RvO/FRzGMXL6EkKrUQvPAunn1jjhQ2VLSf775E3rZ
 cAYU1cN+37FrAQ66Rc8C2TMtMAk+kFgN2MK5wBVEIw0Q136x+sONoJsgu0UeHI4yqggE
 uf/ytDZSnclJe1dbCuHs/8iZxeBkIoJ4p0/U4FCiiZbBsXUDBL/lTdFKerabfCJ1/7K7
 wFWkC5eOdz8h/+/EB/krfoRVxQEIpnXE1NjDGpc3mB8+di1Auby/FURdg/J7q4+kkmCs
 4YvA==
X-Gm-Message-State: AGi0Pubj7BG567IKUZpR0IWvPuqUVfaDW1M4X3iVvgIhuUWCZDX6ReaB
 vG2rM3TwMd5pKgMiKhr0WUJB1aRmGPc3w/Nby1JrEFQWHQvxyQ0oe/yhIGn5STjyWuoU5XOB7tO
 1wDJXA/KsX7QuXBU=
X-Received: by 2002:a1c:9652:: with SMTP id y79mr22899335wmd.89.1586861658673; 
 Tue, 14 Apr 2020 03:54:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypLZC11P0ANwQhQhEyaCTGYsPtYPScqG1YeOM2iXcEbCd0CO1TLSoxLKx+zsWs/eP21+7FyM8A==
X-Received: by 2002:a1c:9652:: with SMTP id y79mr22899315wmd.89.1586861658386; 
 Tue, 14 Apr 2020 03:54:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:503c:7b97:e286:9d8e?
 ([2001:b07:6468:f312:503c:7b97:e286:9d8e])
 by smtp.gmail.com with ESMTPSA id l185sm18248087wml.44.2020.04.14.03.54.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 03:54:17 -0700 (PDT)
Subject: Re: Replace GSource with AioContext for chardev
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200409124601.toh6jpbfcwiwzb6z@r>
 <CAMxuvayJjHH_dqyoPCweQDysubzv=bKnJqgp9TxZNcNKnLTJhw@mail.gmail.com>
 <20200409132441.GS1202384@redhat.com> <87imi2zfy1.fsf@dusky.pond.sub.org>
 <20200414102753.GJ1338838@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <802d831b-e13a-7256-77d8-03c7a064522a@redhat.com>
Date: Tue, 14 Apr 2020 12:54:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200414102753.GJ1338838@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Coiby Xu <coiby.xu@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/04/20 12:27, Daniel P. Berrang=C3=A9 wrote:
> Ignoring back compat, what would be our ideal CLI syntax ?
>=20
> Current syntax is
>=20
>   -chardev socket,id=3Dcharnet1,path=3D/tmp/vhost1.sock
>   -netdev vhost-user,chardev=3Dcharnet1,id=3Dhostnet1=20
>=20
> Should we have an option that expresses a "SocketAddress" struct on the
> CLI ?
>=20
>    -socket type=3Dunix,path=3D/tmp/vhost1.sock,id=3Dsock0
>    -netdev vhost-user,socket=3Dsock0,id=3Dhostnet1

I think this should be just a "-object socket" that under the covers
creates a QIOChannel.  There are also ideas of switching "-chardev" to
"-object"; we could do the reverse of Marc-Andr=C3=A9's suggestion, and hav=
e
"chardev=3D" take both a "chardev-foo" object or a QIOChannel object
(converting the latter to a socket-based chardev).

IOW, the new "-object socket" QOM type can act as both a chardev or a
QIOChannel factory.  The C side of that should not be hard.

Paolo

> IIUC, Marc-Andr=C3=A9 is suggesting that we carry on using -chardev, but
> detect when it is a socket chardev, and then ignore chardev APIs and
> create a QIOChannel.  I can see some appeal in this as it provides a
> way to get all existing usage switched over, but I feel uneasy about
> sticking with -chardev forever, if we're not actually using a chardev.
>=20
> We could do the magic -chardev -> -socket conversion though, for a
> short period of time to ease the transition.
>=20
> We would have to
>=20
>  1. Introduce the new -socket and add "socket=3D$id" to devices that need=
 it
>  2. Deprecate -chardev with type !=3D socket, with no repacement intended
>  3. Deprecate -chardev with type =3D=3D socket, translating to -socket
>  ...wait 2 releases...
>  4. Delete support for "chardev=3D$id" from devices with "socket=3D$id"
>=20
> The hardest part is probably deciding exactly which set of devices can
> be restricted to only sockets, and which must have the full range of
> chardev backends available.
>=20
> Regards,
> Daniel
>=20


