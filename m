Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E24C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 10:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A602073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 10:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggeC0a9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A602073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2BKO-0003AJ-Hn
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 05:02:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j2BJT-0002Y2-Ot
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:01:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j2BJP-0002lT-JQ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:01:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44763
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j2BJP-0002l8-FP
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581588094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UHClk2EHpgO/ADK4SlyeCSvRRQQ8xiTgwrW1CY9EtLg=;
 b=ggeC0a9qcu7FAYt+G7n99ie3CdxtuqdS3s63IFnFfrgzkOoxehG4rjMYagxI88fnLJzOPO
 M6cYfAcN3DE+72zoHAPDM3YAh3fNL+JfxwnaDmdjdzssac6+0cdMkmrJEL1Njb6lQ47aRN
 ezq4Z8RFx+exo2PK1d+Ogl1G+reX91s=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-m7UBjBLzMLSHN5vED5Em2Q-1; Thu, 13 Feb 2020 05:01:32 -0500
Received: by mail-qt1-f199.google.com with SMTP id k20so3310047qtm.11
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 02:01:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VpZoB4GrpUIgkdkN6Dtlyj9nCRM5Wrf7DwmyfIBWrA0=;
 b=bQFx7NEtZmf9964UGt4g1ur2Y6u/K2SUSzGytavoV1b/OYp2oTfwKQAUOfMsHu2jfE
 GitmHGE20cv0x/UZwhFWiS0hdiTOSGBXIa5W71rON7tTtDKsETIhVW8unw9ZUux5Fmw7
 l00Dh6nqmsDj9/kke6/dxuWqy7EER8o/j1wzI/YQe8hgBfUJtnR2FriNTaZRz64Y2Uew
 wl8SnH0GOsMSDO7aIiN/ddZBxxNi8MYrSvH2i5SgBQY/7MTBVpuFVq6t9/bp/5j+Kj9T
 bW+GuTU/Bm6ysd+6ctaqI1hcJecHu8dfcO8/2Kp9U/7+s2rINf9gBPLPiCfX6WMwMRhH
 BYAA==
X-Gm-Message-State: APjAAAWL+5BLWMo8QggRizoX/BBHxmk891NhyqvUsa67QKbtQQf7eYrk
 Tacct03LymldOutACM1ef0HF+z32Xsq648OU8W+CqiVKQxe7K2KiWxYuebWs2evwf8mT+5kH5fF
 MEQO+h5oYzn4Nufw=
X-Received: by 2002:ac8:7392:: with SMTP id t18mr10373254qtp.332.1581588092420; 
 Thu, 13 Feb 2020 02:01:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqz5cjCYVzNIAfh/2augo/MQI2OY4EEsYdBQGsZQdpHxrO9egotbuDVW6f7cxX94hHixJ/UE1Q==
X-Received: by 2002:ac8:7392:: with SMTP id t18mr10373243qtp.332.1581588092163; 
 Thu, 13 Feb 2020 02:01:32 -0800 (PST)
Received: from redhat.com (bzq-79-176-28-95.red.bezeqint.net. [79.176.28.95])
 by smtp.gmail.com with ESMTPSA id
 o21sm993109qki.56.2020.02.13.02.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 02:01:31 -0800 (PST)
Date: Thu, 13 Feb 2020 05:01:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH] acpi: cpuhp: document CPHP_GET_CPU_ID_CMD command
Message-ID: <20200213050121-mutt-send-email-mst@kernel.org>
References: <1580306781-228371-1-git-send-email-imammedo@redhat.com>
 <3c6d3232-f5d3-3d42-da19-2aa5a3c7ef02@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3c6d3232-f5d3-3d42-da19-2aa5a3c7ef02@redhat.com>
X-MC-Unique: m7UBjBLzMLSHN5vED5Em2Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Igor Mammedov <imammedo@redhat.com>, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 11:27:34PM +0100, Laszlo Ersek wrote:
> Michael,
>=20
> On 01/29/20 15:06, Igor Mammedov wrote:
> > Commit 3a61c8db9d25 introduced CPHP_GET_CPU_ID_CMD command but
> > did not sufficiently describe it. Fix it by adding missing command
> > documentation.
> >=20
> > Fixes: 3a61c8db9d25 ("acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command")
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> > ---
> >  docs/specs/acpi_cpu_hotplug.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotp=
lug.txt
> > index a8ce5e7..9bb22d1 100644
> > --- a/docs/specs/acpi_cpu_hotplug.txt
> > +++ b/docs/specs/acpi_cpu_hotplug.txt
> > @@ -94,6 +94,8 @@ write access:
> >                 register in QEMU
> >              2: following writes to 'Command data' register set OST sta=
tus
> >                 register in QEMU
> > +            3: following reads from 'Command data' and 'Command data 2=
' return
> > +               architecture specific CPU ID value for currently select=
ed CPU.
> >              other values: reserved
> >      [0x6-0x7] reserved
> >      [0x8] Command data: (DWORD access)
> >=20
>=20
> can you please merge this?
>=20
> It's a docs patch, but 3a61c8db9d25 (noted in "Fixes:") had gone in
> through your tree.
>=20
> Thank you!
> Laszlo

Will do, thanks!


