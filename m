Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A35C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47AE820709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3fqdBBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47AE820709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv3ma-0001qH-Fc
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 13:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iv3lA-00012j-46
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iv3l8-0004ts-SZ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:32:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20632
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iv3l8-0004tc-PW
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579890766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izavSsxcwUrMlYUla+3YciBED2HxUWMm/iURuc2ywps=;
 b=M3fqdBBO7Ssoc844RIZXyOBR334bExJ3aNJ1bk+LDYj4Xb29ISrM4e1ioLUuVzG1LJOkzn
 opWbiALJwpoBRlhh/kgqedUle5AwJzHZIUsMSTSL6cs4yje3jhOp76LuvqDoAZn9rIrsJO
 1OaHmU2102wcUpVpY8vKwV/BFipE+io=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-a56t_AQoM4evXPIYtO8zkw-1; Fri, 24 Jan 2020 13:32:44 -0500
Received: by mail-wr1-f69.google.com with SMTP id h30so1838355wrh.5
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 10:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UTTe2tjGkF4XZVJ7Ze13xFZS8sVWgvhXGdJX0orWY7Q=;
 b=HZTZExoVpq3NR4F7u6vjz3XzyBHxHGTovj/bVYLczVeS26cjQVmOPoDYLasO4H+gqK
 w7cFZ4nWZfqt2jQikTm5Nyu6oUhCTQ5UUMgcgfZHrcLtq4IIHq/gLc2x9cnYXqIMDlsh
 C5lGBbS6tV/RwQhPwnyZy5ii1D5RuvX59XqgXNggJRFZfWoTPrJ6IKhXyCXMI6zYvYr7
 OAZiYSbH2Py1YrB5yM/zEAStiJ28hYOvxwdXNxl36dXasNiPLHkMpcG++0qpXNC2JQZD
 ueqA2yOAP7pacAfUZ0PWGvaqi5YjpBSmusPfKqR6a4mzF0Rrk5GRL4fpUvadROrAps9w
 W4Fg==
X-Gm-Message-State: APjAAAWgHJiMaQaky7J7/Xd2zeW9H2A5kT4qmSM870d9FZebDkmlFbBL
 Obg32/Qi9O5/VQ63gi/ir6umkDIevIFMJ4urhKC9iBJzC6vlxn35Ox1bROJF4Mwvs2ErFE8fAG8
 k5M+HcCdGMY7QGf0=
X-Received: by 2002:adf:cf06:: with SMTP id o6mr5684810wrj.349.1579890763567; 
 Fri, 24 Jan 2020 10:32:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5Yg9k4dzpXTvvGIhBpU4Ezgli51eicbsCf4wf9D4blmKBbU0GvBSBsozzmOaYbcDHaFNRKA==
X-Received: by 2002:adf:cf06:: with SMTP id o6mr5684797wrj.349.1579890763349; 
 Fri, 24 Jan 2020 10:32:43 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059?
 ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
 by smtp.gmail.com with ESMTPSA id d16sm9476771wrg.27.2020.01.24.10.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 10:32:42 -0800 (PST)
Subject: Re: Integrating QOM into QAPI
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
References: <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200120100849.GB345995@stefanha-x1.localdomain>
 <871rrtmkko.fsf@dusky.pond.sub.org>
 <20200121113224.GD630615@stefanha-x1.localdomain>
 <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
 <87wo9lc4oe.fsf_-_@dusky.pond.sub.org> <20200121143658.GB597037@redhat.com>
 <871rrs97ld.fsf@dusky.pond.sub.org>
 <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
 <87y2tzzrwo.fsf@linaro.org> <87wo9ju19n.fsf@dusky.pond.sub.org>
 <CAJ+F1CLu6xNJ834qWpJ6Bx1PHhv5QutdK2-Nzp+J2q80YV5tzA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c68f8ffd-dc8a-f282-3195-aa9e8760de7a@redhat.com>
Date: Fri, 24 Jan 2020 19:32:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLu6xNJ834qWpJ6Bx1PHhv5QutdK2-Nzp+J2q80YV5tzA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: a56t_AQoM4evXPIYtO8zkw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/01/20 13:42, Marc-Andr=C3=A9 Lureau wrote:
> From the top of my mind, this is the pain point when trying to use GObjec=
t:
> - static/inlined object, not supported by GObject, unlikely to ever be
> - few users in qemu, transition possible.
> - 64k limit of GObject, for some reason, unlikely to change but I will
> take a look. Some users in qemu, code adaptation possible.
> - dynamic properties, possible in GObject with hacks, but not
> recommended and going to be deprecated from what I remember
> - "array" properties - would need extra layer/tweaks for compatibility
> - link properties - would need special handling
> - different limitations for type names and properties names

The properties in general are very different between QOM and QAPI.  They
have different limitations and features as Marc-Andr=C3=A9 mentioned, but a=
n
especially important one is the integration with QAPI visitors.  This is
what allows us to support -object and object-add with the same code, and
is what separates QOM from GObject the most.

Maybe it would be possible to build an adapter, but having written in
the past code that uses GType to do marshalling and unmarshalling, I'm
not really fond of repeating the experience...

Paolo


