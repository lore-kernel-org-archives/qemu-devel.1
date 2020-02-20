Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1BDC11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:28:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4BEF20801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M14yqPwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BEF20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4i88-00006d-TU
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 04:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4i77-000755-Rd
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:27:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4i76-0002BN-ND
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:27:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45449
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4i76-0002Av-Ij
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582190840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LtMorEAYApZkhDnAczB4MvTDkA55XdDs0OLOj6RgD0c=;
 b=M14yqPwOeD+j1VxzY8nSv/ESEjj/xq5RHGNf5VQgi/teggePzq3BHshypOuWe/jwi/Z6xV
 Im/8V0qeutS4eTcSHvcOmWugs3Mz7+GQstDP/P6S6PgwKASLbNAps1/aQL/NOgTMQgYFLN
 R8enEiduILfWso3dI2w0sify9aAN/uM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-VaUdvtj_P6-RtzHVw_iYYw-1; Thu, 20 Feb 2020 04:27:17 -0500
Received: by mail-ed1-f72.google.com with SMTP id n12so2223606edq.13
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 01:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EpCqc0cjKzBAXDO299Y8JUpfdPXRmgF0sVsdTblKd2w=;
 b=VEqQJbqY8jOEjb69r00wsgT3aGc6g/e+vjvrEc1iVvB4UiaU8Xz7hjOM8Ib4DOObpd
 g9bx/JKbvPTFpkbtVBo+++6opE8i2EUGXe0jbR32TxDKAqUzuV74a/Qcti9yQXgnYLo1
 JGWmYLLO4Qs0hdck3hPZVKTKyCIjm4pyIEspHMVHsZdAaOZjB9nju9J+1M5+qFqx6FKn
 mVx+PN2k+N/LSAy0tbUPlkD1/6LstB7/SRFSSRmm4jSbCRg0e+o73P4MY4HGgNF8UutH
 5YPRvZtOQ29c/zLJUi5TZ56MSJk+HXsoBh8XGVhmnP+tjMj9JK0wMy17WrBhp/+qtzBk
 Ji/g==
X-Gm-Message-State: APjAAAUcqVMglS2I7K8SK8sy2SbzE3SFyTltRJqRlKAh/YN3R2B6Cvyq
 L8bC/x8gh3YX5L9/1KIwAWWYwBSJzvbfTQW3dRezTkqzMGcus4bxSX+JY5R4/qBNm2h9rwneY+w
 gavfTdgtMHc718jQ=
X-Received: by 2002:aa7:da5a:: with SMTP id w26mr27866546eds.274.1582190836751; 
 Thu, 20 Feb 2020 01:27:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqyto2WPHavrVXyXInS5dQLU5BfS0kx18Q0Ft3ALok7ktpfD2SGyEv+VlrJUC7qgWDheoY2vkw==
X-Received: by 2002:aa7:da5a:: with SMTP id w26mr27866495eds.274.1582190836356; 
 Thu, 20 Feb 2020 01:27:16 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id i11sm65915eds.23.2020.02.20.01.27.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2020 01:27:15 -0800 (PST)
Subject: Re: [PATCH v2] Avoid address_space_rw() with a constant is_write
 argument
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200218112457.22712-1-peter.maydell@linaro.org>
 <f87dbeeb-2259-9eb9-45c7-a30819eec2ee@redhat.com>
Message-ID: <31660c9b-ad1c-5d3f-b6db-fba69ee5e563@redhat.com>
Date: Thu, 20 Feb 2020 10:27:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f87dbeeb-2259-9eb9-45c7-a30819eec2ee@redhat.com>
Content-Language: en-US
X-MC-Unique: VaUdvtj_P6-RtzHVw_iYYw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/18/20 1:56 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/18/20 12:24 PM, Peter Maydell wrote:
>> The address_space_rw() function allows either reads or writes
>> depending on the is_write argument passed to it; this is useful
>> when the direction of the access is determined programmatically
>> (as for instance when handling the KVM_EXIT_MMIO exit reason).
>> Under the hood it just calls either address_space_write() or
>> address_space_read_full().
>>
>> We also use it a lot with a constant is_write argument, though,
>> which has two issues:
>> =C2=A0 * when reading "address_space_rw(..., 1)" this is less
>> =C2=A0=C2=A0=C2=A0 immediately clear to the reader as being a write than
>> =C2=A0=C2=A0=C2=A0 "address_space_write(...)"
>> =C2=A0 * calling address_space_rw() bypasses the optimization
>> =C2=A0=C2=A0=C2=A0 in address_space_read() that fast-paths reads of a
>> =C2=A0=C2=A0=C2=A0 fixed length
>>
>> This commit was produced with the included Coccinelle script
>> scripts/coccinelle/as-rw-const.patch.

Script is "scripts/coccinelle/as_rw_const.cocci".

I plan to respin this patch (fixed) in a larger series.

>>
>> Two lines in hw/net/dp8393x.c that Coccinelle produced that
>> were over 80 characters were re-wrapped by hand.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> I could break this down into separate patches by submaintainer,
>> but the patch is not that large and I would argue that it's
>> better for the project if we can try to avoid introducing too
>> much friction into the process of doing 'safe' tree-wide
>> minor refactorings.
>>
>> v1->v2: put the coccinelle script in scripts/coccinelle rather
>> than just in the commit message.
>> ---
>> =C2=A0 accel/kvm/kvm-all.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +--
>> =C2=A0 dma-helpers.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 4 +-
>> =C2=A0 exec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
>> =C2=A0 hw/dma/xlnx-zdma.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 ++---
>> =C2=A0 hw/net/dp8393x.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
68 ++++++++++++++--------------
>> =C2=A0 hw/net/i82596.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 25 +++++-----
>> =C2=A0 hw/net/lasi_i82596.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +-
>> =C2=A0 hw/ppc/pnv_lpc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 8 ++--
>> =C2=A0 hw/s390x/css.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 12 ++---
>> =C2=A0 qtest.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 52 ++++++++++-----------
>> =C2=A0 target/i386/hvf/x86_mmu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ++---
>> =C2=A0 scripts/coccinelle/as_rw_const.cocci | 30 ++++++++++++
>> =C2=A0 12 files changed, 133 insertions(+), 104 deletions(-)
>> =C2=A0 create mode 100644 scripts/coccinelle/as_rw_const.cocci


