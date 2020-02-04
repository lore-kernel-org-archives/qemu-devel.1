Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE18C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:16:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87F1B20730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZgSQxwqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F1B20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0sA-0008Dp-Q7
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsuvorov@redhat.com>) id 1iz0q6-0005jX-6J
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:14:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsuvorov@redhat.com>) id 1iz0q4-0007az-9Z
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:14:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31238
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsuvorov@redhat.com>) id 1iz0q4-0007Zh-5K
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580832851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0gYjOT2kbI9xPd0ISilvGQX7i0aKnbaqUe06Ldv1G8=;
 b=ZgSQxwqvJVgUf5teHGFgEIaK5L3/NlKEpXnTrY267TjM7NltPnV6+BDnoZMPNwnPp+pSmo
 KoX4v+8XxQZE8j+SYmabzMK2o7ba2GS4D1N+CsLuBuCcFJpH+mqWiO8WEisYcs1g6d5pJd
 LPrrNrAgbUwLw+/YV2jpHdSsuk7jHb8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-OnfLCx1lNYGhEq8kffdLyQ-1; Tue, 04 Feb 2020 11:14:09 -0500
Received: by mail-lj1-f198.google.com with SMTP id z17so5444708ljz.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 08:14:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FwD4jbGJdWWtNG4zqArChJAt2AQbjqVRvNFb97AuilY=;
 b=KQVH+qrgbUqIlBeoIv3QhH7blLlLwe5ZDxQxN5VztchlIWdy12pX9M8nFNqCzjIA9P
 T/d5o8iisk2hmNOlmP8M7OtlfwP4q3fXL12xDL53P5MVEiv16+9x06WYSsqROUGlSOAt
 lGM911ofY4yoBMHNHnf6SEt3pKU8p8NTyDyaY8Tcx+ulhHsdEEISXcYGZiisGjmIiK50
 JrmWz7+gY9fk54fD2s6Ed9x31RITv9UqtOKyKhiDx5oIgZzG/N7u4uWCzo4CTKakMF3e
 3CIGj6VAsK+350UNapGQxLvAHWL7Y1KHYZbB55XODa6qP81WtBRpK63WBS6UhjqNTVJj
 HQzw==
X-Gm-Message-State: APjAAAUZbGy5dCKjny8AZrAob+3beF3vj/XSeeEsWE5yIqodkLpGap8m
 MnBuwpsH1R5Q2u5TAxdNSZlY/u5DaKjkljSAciHSxjuo28+DdrbY9vIFjuAS6pzXgC2crUrsCV3
 Y3HiS8+4eI1iAiSyYlbo3pzOJMZ0vIyE=
X-Received: by 2002:a2e:a361:: with SMTP id i1mr17481230ljn.29.1580832845185; 
 Tue, 04 Feb 2020 08:14:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqziOTt8nLFcZyYW1gm5Q3fotlMwf0Wu+Ksde3FmgNXBpV5OPnTGwMOcHSj0mtGB+1hVgQ8mcuS4w6DELYzcg5M=
X-Received: by 2002:a2e:a361:: with SMTP id i1mr17481217ljn.29.1580832844992; 
 Tue, 04 Feb 2020 08:14:04 -0800 (PST)
MIME-Version: 1.0
References: <16db1dcd-d1a3-5bd9-2daa-d16a0f2d168e@redhat.com>
 <20200204013947-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200204013947-mutt-send-email-mst@kernel.org>
From: Julia Suvorova <jusual@redhat.com>
Date: Tue, 4 Feb 2020 17:13:54 +0100
Message-ID: <CAMDeoFVkoTZSQ=PV=mc_AGoZ445Wug4F+RV5utaYb+jhPEtkJg@mail.gmail.com>
Subject: Re: Disabling PCI "hot-unplug" for a guest (and/or a single PCI
 device)
To: "Michael S. Tsirkin" <mst@redhat.com>
X-MC-Unique: OnfLCx1lNYGhEq8kffdLyQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org,
 Laine Stump <laine@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 4, 2020 at 11:26 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Feb 03, 2020 at 05:19:51PM -0500, Laine Stump wrote:
> > 3) qemu could add a "hotpluggable=3Dno" commandline option to all PCI d=
evices
> > (including vfio-pci) and then do whatever is necessary to make sure thi=
s is
> > honored in the emulated hardware (is it possible to set this on a per-s=
lot
> > basis in a PCI controller? Or must it be done for an entire controller?
>
> I think it's possible on a per-slot basis, yes.

There's a "Hot-Plug Capable" option in Slot Capability register, so we
can switch it off. But it's only for pcie devices, can't say anything
about conventional pci.

Best regards, Julia Suvorova.


