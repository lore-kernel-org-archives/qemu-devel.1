Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ED9C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 07:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B7121736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 07:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anNf7qzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B7121736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaawA-0003aP-Up
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 02:43:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iaakA-0005rm-LS
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 02:31:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iaak8-0007iw-LN
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 02:31:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59542
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iaak8-0007Um-Gq
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 02:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575012665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRCKGbY4P/zHgbYamS/LOrlSPsKZAx1h+lCbJDxur34=;
 b=anNf7qzWvpfEoSyu0dbD8WZQE5cf8JCeB7xo3dgE8RZMS1XYCC1jE4O2gd0YDERacuwoEU
 +Y9rPdjAqxTBQpB8vyyDKD/Uewzas17fqwFbBwKWeZIHtKZgQQ6nXDxp7C2wkshZkOHb+f
 lSb2cuOKm0wIgwkBY4eJflkdIB4dl24=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-z8tkAhU-ON6lEaeHSrvPdA-1; Fri, 29 Nov 2019 02:31:04 -0500
Received: by mail-ot1-f72.google.com with SMTP id o14so2955842otp.4
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 23:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pRCKGbY4P/zHgbYamS/LOrlSPsKZAx1h+lCbJDxur34=;
 b=VVTJW8bsZ+hLpn9pxBQu/lx8RKVpB5OTLAw9eJXbRgd1rMk+BwfY4rZ3y+d5yVCRGo
 Iwlwzuj33pWN9VYGfmJ1uM0AJHFvAWboOviSm9iSSXL+GgfKMnjNbJqSeh/pH2thfD1h
 h1NLyFJWdVfRue6/P7zsdeuLTDr0nN0BvKjsg6NcfJjDqZoMrF56ei8sW+Pse85Mbz+A
 1ZHaUwPS0Eypc27rWkv1WKbQyPg0pWghtqVfY+iWB4tv7tKcGNc+WebnbSd+ulSLBobO
 6Exgiu2iaS7UjNt28WFGgq1VstZC20AtmOaGZ5N1lF4rSOkRWBBvVlzajKGufQWcB1uS
 SgvQ==
X-Gm-Message-State: APjAAAUzELlEFKnZwbrn7SoasdvZBGeO2VaS66+jMIgHtgWB88d1VTKs
 G8DidGe4oPQREyg97TWLU80R0G/ho21z/N8D/qDv1f7TgD9Ydw6ylqPPxAZgVoy3Mp+e9wJxyyZ
 siwEJs9rs6WYLM/abBcow7OnmaidlgaU=
X-Received: by 2002:aca:cc87:: with SMTP id c129mr6881723oig.13.1575012663601; 
 Thu, 28 Nov 2019 23:31:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwyJygAsEQgf4My4EosaS830cYVy1+z7TQoGDDZPVhd/f8G4Z77AB4ctmwnas5CRjoD3Iscej0Kd+iC1EAURfA=
X-Received: by 2002:aca:cc87:: with SMTP id c129mr6881703oig.13.1575012663350; 
 Thu, 28 Nov 2019 23:31:03 -0800 (PST)
MIME-Version: 1.0
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191129070253.5hwksjrapomk434x@sirius.home.kraxel.org>
In-Reply-To: <20191129070253.5hwksjrapomk434x@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 29 Nov 2019 11:30:51 +0400
Message-ID: <CAMxuvawieN7JQZkRku19v5X-o6q664Wz1Rtx3+Wz3d33m-7Tug@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
To: Gerd Hoffmann <kraxel@redhat.com>
X-MC-Unique: z8tkAhU-ON6lEaeHSrvPdA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Nov 29, 2019 at 11:03 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Nov 28, 2019 at 06:15:16PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi,
> >
> > Setting up shared memory for vhost-user is a bit complicated from
> > command line, as it requires NUMA setup such as: m 4G -object
> > memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm,share=3Don -=
numa
> > node,memdev=3Dmem.
> >
> > Instead, I suggest to add a -mem-shared option for non-numa setups,
> > that will make the -mem-path or anonymouse memory shareable.
>
> Is it an option to just use memfd by default (if available)?

Yes, with a fallback path currently using a temporary file under /tmp
(we may want to use shm_open() instead, or a different location such
as XDG_RUNTIME_DIR? - and use O_TMPFILE)


