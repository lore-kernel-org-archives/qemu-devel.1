Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BD1C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D60120726
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QaS+FZCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D60120726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieGjr-00025E-ML
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 05:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieGip-0001Kd-Cr
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:57:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieGin-0005e1-3K
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:56:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60015
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieGim-0005c2-Le
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 05:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575889015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MyLNwJy5spN/uUGKJwSwII6IVS9lQ48y4YIQ5w8/IR4=;
 b=QaS+FZCh3vlA9J7hYm4hDlWn/hY86rH6I5VSGlPLmcwhQ1e6lOqXWFfUaFD13YZu2fWVIq
 02gjekXQB31uM/lQF4eNLM5PQqCFcijgEoJcQt0pjH1clWb8uJ268QgSgzRyV54F4mLcEf
 5vRmGir2ZKlfB9Qu60LhlqZtAuSwg6I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-OTjYOWx2O-2ubTzDx2D5Dg-1; Mon, 09 Dec 2019 05:56:52 -0500
Received: by mail-wr1-f72.google.com with SMTP id l20so7362317wrc.13
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 02:56:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WjNJQQkZsO+8a1bmft+Oyorvw86PENBNNrPDsjmoKus=;
 b=trnAxCQp2HlLrrNVjuVhD7z7Hcc+A0vp15RDnvFOj+FlpPrakQM1CTW+vPVVL2aC4r
 YPp8IrlZix/5uPXf/YE0lEtk+FcAglJ8n0ClDhWqjBsj7r54StGxHuFL6dJG/+DqKMsy
 GnNNECWJnTvCWJ+YQKa5ZmpLXlw2rGnntHwyz9Ap9LUKX0t8BM2Acti+YUbmqdv3/9z3
 99k8x/bzg3sQNxNsKPzEzIOXY/E4f5JzCbhi9LA/JpwVbzXlTqBqSyC6KdmZ8YBM1Xbw
 vDHlQtXPGXS1HqspVdpormMJzX0D6Uo1r+BbOK68x/hcx2Lsp6jBBrotK5u2rL0GX+P5
 LjUw==
X-Gm-Message-State: APjAAAXGcJcrbJRiAsvbgdMC4QaPmoFvTD2MYhbnmGi7l5WvKXYqShr4
 6mQl9e4yFBsui1PAWVZQsTwqVA+Xk/9dqC7d3d2+IKzJN3dnkP/Bxs94cGbJw5OY3fhuZ6SSxCp
 lw00ie/WbHO0o67Y=
X-Received: by 2002:a5d:4b8f:: with SMTP id b15mr1520254wrt.100.1575889011312; 
 Mon, 09 Dec 2019 02:56:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8/NxkJgUssuIKetq74Jwb56vwNb32qApCH3ThHTiCxkbweCvCG/vldgScvR32sdud2xIfBA==
X-Received: by 2002:a5d:4b8f:: with SMTP id b15mr1520226wrt.100.1575889011060; 
 Mon, 09 Dec 2019 02:56:51 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id l4sm12624415wml.33.2019.12.09.02.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 02:56:50 -0800 (PST)
Subject: Re: [Xen-devel] [PATCH-for-5.0 v3 6/6] hw/pci-host: Add Kconfig entry
 to select the IGD Passthrough Host Bridge
To: Paolo Bonzini <pbonzini@redhat.com>, "Durrant, Paul"
 <pdurrant@amazon.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191209095002.32194-1-philmd@redhat.com>
 <20191209095002.32194-7-philmd@redhat.com>
 <3f1702b0765841b19328366af11fd3ed@EX13D32EUC003.ant.amazon.com>
 <083d0d7f-766d-9e72-5395-b4e82858ef4d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4e9dee3e-05b5-640d-33df-4341c2e01b8b@redhat.com>
Date: Mon, 9 Dec 2019 11:56:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <083d0d7f-766d-9e72-5395-b4e82858ef4d@redhat.com>
Content-Language: en-US
X-MC-Unique: OTjYOWx2O-2ubTzDx2D5Dg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 11:42 AM, Paolo Bonzini wrote:
> On 09/12/19 11:10, Durrant, Paul wrote:
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>> v3: Only default with Xen (Alex Williamson)
>>>
>>> I did not used 'depends on XEN' as suggested by Alex but
>>> 'default y if XEN', so one can build XEN without this feature
>>> (for example, on other ARCH than X86).
>=20
> I think what you want is achieved by
>=20
> =09default y
> =09depends on XEN && PC_I440FX

I think so, but with PC_I440FX -> PCI_I440FX ;)

It would be cleaner to pass the CONFIG_XEN_PCI_PASSTHROUGH variable to=20
Kconfig and use it (use 'depends on XEN_PCI_PASSTHROUGH').

This can be another step, so if this series looks OK to you so far, do=20
you mind fixing this and the comment in the previous patch noticed by=20
Thomas:

- Extract it into a new file, 'hw/pci-host/igd_pt.c'.
+ Extract it into a new file, 'hw/pci-host/xen_igd_pt.c'.

Thanks!

Phil.


