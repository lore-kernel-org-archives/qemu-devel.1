Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB36C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA702082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtPs6KqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA702082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyVJv-0001iq-RP
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iyVJ6-0000pf-NO
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iyVJ5-0004fX-7o
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:34:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28880
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iyVJ5-0004f1-3e
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580711642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HMK/I7jEsJC66/zUyTtxaMzjOqg3G9UL/RvUyPT7oPM=;
 b=ZtPs6KqHZbYzJAVg5ZRCpVIYh1JJTui/46giedrJLupP7gct0oILRTtszbLB/HKCB7/T+g
 4CigtP/hslIA92GMgVBdYIiPshrSQiE77eizIFJ3q7sTDw+4zOXBtR10LA1cEgC0UC+oY6
 RfeOhTT2XIl/F3+XzK6n1VrzXNqIOUs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-Vque0HSIM0G0lwuz9GQzbg-1; Mon, 03 Feb 2020 01:33:58 -0500
Received: by mail-wr1-f69.google.com with SMTP id f10so7756738wro.14
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 22:33:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lgzN2p9qkacoDbUm8WFgWm1v17u1NeFijwpHZSQ47hQ=;
 b=KtXauIpOvDoivcuqor6r1ODMMJcvyoFSSJ+mkwxMVx5DSrrlqKIopO/ZqW18JuoJUT
 F9JCvdQFIzDxIYgLuoAAWVbaLq+s5kBAIfnLWXizmJxPqkxMf0BV6WcTLfKH5sZ4rRzT
 M+B0R2mMuMuI38LLe1OhggUwzisbIz90RbZ6FQbfQ0hgfHYBb+BbHzhFbjGf2umjPqo1
 v8LB3Ux89WdZzSCjLVPSDHHWiyG/mq7Ax1pmm/p0zi92MtA/xHqM25yOmzFq35WR+E/+
 ZH6XXgvYRxAqVCtAdfyxCi++w2bH4E43bB5Y/5soHhSsMyRYKS0N/33LnDATL7fcipG3
 Gr8Q==
X-Gm-Message-State: APjAAAXjNgHNw+t6oUsQaGa/IMRYbCJQqEcBHgJcEBtfjElZxNenfgHy
 aAbCEIHzgOV3pahQKftyExNomn+vkGE2ASWEnqbkeTvdPkb2TUVZtBJgNq6z9JviDpId7MeA1kx
 nXEQu+u2Y7IquLbw=
X-Received: by 2002:a1c:df09:: with SMTP id w9mr25399883wmg.143.1580711637849; 
 Sun, 02 Feb 2020 22:33:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqxTjF/8rAg8BJzHbHeLvidHyVDDtpX4laHC3mhC06DrIgXqpzNrDWxAJX5eB0Bny0WXmU7Okg==
X-Received: by 2002:a1c:df09:: with SMTP id w9mr25399855wmg.143.1580711637600; 
 Sun, 02 Feb 2020 22:33:57 -0800 (PST)
Received: from redhat.com (ip-82-36-244-173.west.us.northamericancoax.com.
 [173.244.36.82])
 by smtp.gmail.com with ESMTPSA id s8sm22693851wrt.57.2020.02.02.22.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2020 22:33:56 -0800 (PST)
Date: Mon, 3 Feb 2020 01:33:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v3 17/18] i386:acpi: Remove _HID from the SMBus ACPI entry
Message-ID: <20200203013334-mutt-send-email-mst@kernel.org>
References: <20200123070913.626488-1-mst@redhat.com>
 <20200123070913.626488-18-mst@redhat.com>
 <CAFEAcA98iqJkTp4F6qmO5f4VYNhE3Fs4toBuV1qNtujAo6=OJg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA98iqJkTp4F6qmO5f4VYNhE3Fs4toBuV1qNtujAo6=OJg@mail.gmail.com>
X-MC-Unique: Vque0HSIM0G0lwuz9GQzbg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Corey Minyard <cminyard@mvista.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 30, 2020 at 07:05:16PM +0000, Peter Maydell wrote:
> On Thu, 23 Jan 2020 at 07:11, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > From: Corey Minyard <cminyard@mvista.com>
> >
> > Per the ACPI spec (version 6.1, section 6.1.5 _HID) it is not required
> > on enumerated buses (like PCI in this case), _ADR is required (and is
> > already there).  And the _HID value is wrong.  Linux appears to ignore
> > the _HID entry, but Windows 10 detects it as 'Unknown Device' and there
> > is no driver available.  See https://bugs.launchpad.net/qemu/+bug/18567=
24
>=20
> Is this commit in fact a fix for LP:1856724 ? If so, we could
> usefully add a comment to that bug noting the commit which
> fixes it and mark the bug 'fix committed', since it seems
> to affect various users who would like to know the status.
>=20
> thanks
> -- PMM

Right. Corey could you do that pls?


