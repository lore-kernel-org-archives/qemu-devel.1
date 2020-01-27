Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007BCC33CB7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A12214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzQ8xkSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A12214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw91z-0005pr-1U
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 13:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iw910-0004yR-9Z
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 13:21:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iw90y-0005bc-3e
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 13:21:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27776
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iw90x-0005b4-Kl
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 13:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580149295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l2GUz6MZCI+ErzVvt+jFXb7dJsjljrMUI1rS55mowu4=;
 b=ZzQ8xkSyxgADGLeXtPg/MBYUUoXoF3Y9GJPZ1POV67mu4+0e9oeC3akxFX9rcSJs057pXo
 9OvejMMjJv7IWQaoZ2oUNeec7rtVKb9VDjoqNQkVAZGDk3vtUJTh/jUCGtozyEnOx2utP1
 NKQPlL7mYuD6pa38xZ5pd0RyUxxYvTU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-FpLHdvCiOpmVuFe8cIUu3A-1; Mon, 27 Jan 2020 13:21:33 -0500
Received: by mail-wm1-f72.google.com with SMTP id p26so1752704wmg.5
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 10:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wa+S1rnHsWHtgHsZT02OQSRmrQ4hC8h5NGviPeEUguk=;
 b=mz4HxqnSxBX2NcoVtbjEy45tAOE+s3lgDxoxsnLLvUhHYNYNvC9spxDzTHndBw+BZP
 iP5EWC9+ctThPnPUSu6DlR3e4+CpZg7eM/vMblQ/OgUP1SpR7xkX/exWbhOk2VLPOUja
 wE9Kpqtn5tjAXwKavQWiLSTJ2JXZVT3QJoqx0zr2kf4BKhZJv0llS/g5Gp6TpEL0IYSE
 PQxMme9XmsV07Q+2kbt+noXoOf/Yj+AZlGAiyW3groR4/VXKeCzf+IMq4M3PGcEKT+CO
 +XFd3qdNk5vM+dDs3PQ4F6NiTou4fzMt1Gtfc/U95na3TNTgY3aB0qluykOg9cXhL0Bh
 jQkw==
X-Gm-Message-State: APjAAAXUKlRf40XtCnRIoqeqzLtGm/nyz7nS+iWbu7qRyi1nVm5JDKi9
 8+UMUzHpsQfl8QiuiEpYUu6gewKTiL12yqITk1rklW8+9ixCPOOOQv2m32j/63DmQWbCRiN3qSI
 Y6yiR8lWz5B4MGWk=
X-Received: by 2002:a1c:9c4c:: with SMTP id f73mr266800wme.125.1580149290893; 
 Mon, 27 Jan 2020 10:21:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqxKM5AhUtK0JPELPq70+sSKIsGXemVPhWXJ2wFVg/iaH6LKLJNEUhPdZ7DMZRGZkQSqPfsnDA==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73mr266790wme.125.1580149290626; 
 Mon, 27 Jan 2020 10:21:30 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059?
 ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
 by smtp.gmail.com with ESMTPSA id y12sm7611743wmj.6.2020.01.27.10.21.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 10:21:30 -0800 (PST)
Subject: Re: [PATCH v2] hw/i386: disable smbus migration for xenfv
To: Olaf Hering <olaf@aepfle.de>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200116180321.24968-1-olaf@aepfle.de>
 <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
 <20200117102244.22edd8a6.olaf@aepfle.de>
 <ea3a65c3-bd69-7815-6893-cb1cd8b9cfd6@redhat.com>
 <20200117140616.18cb8c45.olaf@aepfle.de>
 <CACCGGhCO_OqPq__t+V9RrFMYhXCJ5N4PPkq9CASJULV2rTkT-g@mail.gmail.com>
 <d8d31bb7-01d1-8bb9-889e-c03c55818df3@redhat.com>
 <20200127142630.48551ea3.olaf@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cc92d4ad-e6e7-0aaa-ffcb-0b037c3b7e97@redhat.com>
Date: Mon, 27 Jan 2020 19:21:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200127142630.48551ea3.olaf@aepfle.de>
Content-Language: en-US
X-MC-Unique: FpLHdvCiOpmVuFe8cIUu3A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Paul Durrant <pdurrant@gmail.com>, Anthony Perard <anthony.perard@citrix.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/01/20 14:26, Olaf Hering wrote:
>> That's years away, so ideally libxl would have migrated away from
>> xenfv before that.  For now, sticking to a fixed version as in
>> Olaf's patch is a good stopgap measure.
> Is there a way to inspect a running qemu process to see what version
> it is? I assume one thing is to poke at /proc/$PID/cmdline and make
> some guesses. Would a running qemu report what pc-i440fx it supports?

Yes, via QMP. For example on QEMU 3.1 with "-M pc" you would get:

{"execute":"qom-get",
 "arguments":{"path":"/machine", "property":"type"}}
{"return": "pc-i440fx-3.1-machine"}

So libxl would start QEMU with "-M pc,accel=3Dxen -device xen-platform"
when _not_ migrating, but on the destination of live migration it would
query the machine type and use "-Mpc-i440fx-3.1,accel=3Dxen -device
xen-platform".

A cleaner possibility is to do {"execute": "query-machines"} and search
the result for an entry like

{"hotpluggable-cpus": true,
 "name": "pc-i440fx-3.1", "is-default": true, "cpu-max": 255,
 "alias": "pc"}

i.e. the name corresponding to the entry with "alias": "pc" would be
used on the destination.

Thanks,

Paolo

> With such info an enlightened libxl might be able construct a
> compatible commandline for the receiving host.


