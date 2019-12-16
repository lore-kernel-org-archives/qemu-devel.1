Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9ABC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF0D20717
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yim5ibsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF0D20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igsSz-00037p-0Q
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 10:39:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igsRj-00023z-SW
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:38:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igsRi-00059Z-O5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:38:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42318
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igsRi-00058i-KK
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576510686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aBa2MGn7DCueqf8x4FUEtixtox7g2G365/dy7anp4ic=;
 b=Yim5ibsSezx24tpcRIIxoG/Y/Ve09Au5SCZDSEVvkEhdNv/dc/24LDdCapAJcytV5T3Fmh
 bQCeLBYRQ0ICknbQI7jJWNcg3LciOCdhYIkD6OjyczidBV7S92/gYJe7SvJ8QT13dVusRV
 7/gali3sDby/ea3b/YI70Ip6aU89dQI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-ogUF-YG5N3mwt-gPc7hZyg-1; Mon, 16 Dec 2019 10:38:02 -0500
Received: by mail-wr1-f70.google.com with SMTP id i9so3919366wru.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 07:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0QV9lNd6bej2B81hrPU/3K56BtQwJme8N81caAcyeHo=;
 b=LuufXfZAmryouqXYJYQwSEPbX4v3j9HvJzf0zWLTKhNqMOfuXJdk8C49FJV6CEvG57
 Y++LhMKRCzSlS91tr30/HBoGX/BnFaA5eSWDDIVnJVung9JvGkhrLZB6ARiuaQe8M5Gx
 qn6naCCsVRyffz1atCTbBWt8DXNRrdMQuHDAOgPzx0HOwgfJKiR65uXAxyy41lR8LBro
 8+3ORQHhLaAAlfuPCuPo+zdgNBciPngzntniVfJ+mf0+GMqKk3sC/PNEmD8W/8qtKIC9
 QFbB+ic6RmLOQnpqZnRF5GfbZnccDP2IM41d0SyEOdOQQI5xthc2RLMZVwUQOaVq341a
 Ut0Q==
X-Gm-Message-State: APjAAAW6utUV5TAP33/nDNcGn8lVMfmoxk4JdOjY+2L+nj+A6gA5wS4a
 dhscYTfXwyDucnY64Lu52jdbJCLdayxjut79WzrK9X/1Q3jVAfiGEvmVRh/qzt1rROlu2HEFhiS
 7b4fSZ71LaDkiVKA=
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr30633309wrt.229.1576510681812; 
 Mon, 16 Dec 2019 07:38:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxVFqYNqlSPAPVs60swdvhy63zZvYx1UQ4uo3h1+kQkDGxRT/1HmtmODXpIzHE45ZzE9ki/sw==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr30633290wrt.229.1576510681631; 
 Mon, 16 Dec 2019 07:38:01 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id f1sm21818222wro.85.2019.12.16.07.38.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 07:38:00 -0800 (PST)
Subject: Re: [PATCH 12/12] hw/i386/pc: Move PC-machine specific declarations
 to 'pc_internal.h'
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20191213161753.8051-1-philmd@redhat.com>
 <20191213161753.8051-13-philmd@redhat.com>
 <d9792ff4-bada-fbb9-301d-aeb19826235c@redhat.com>
 <20191215045812-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0d15c735-73b4-7875-ec0f-8c181508f0d4@redhat.com>
Date: Mon, 16 Dec 2019 16:37:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191215045812-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-MC-Unique: ogUF-YG5N3mwt-gPc7hZyg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/15/19 10:58 AM, Michael S. Tsirkin wrote:
> On Fri, Dec 13, 2019 at 05:47:28PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> On 12/13/19 5:17 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Historically, QEMU started with only one X86 machine: the PC.
>>> The 'hw/i386/pc.h' header was used to store all X86 and PC
>>> declarations. Since we have now multiple machines based on the
>>> X86 architecture, move the PC-specific declarations in a new
>>> header.
>>> We use 'internal' in the name to explicit this header is restricted
>>> to the X86 architecture. Other architecture can not access it.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>> Maybe name it 'pc_machine.h'?
>>
>> I forgot to describe here (and in the cover), what's follow after this
>> patch.
>>
>> Patch #13 moves PCMachineClass to
>>
>> If you ignore PCMachineState, "hw/i386/pc.h" now only contains 76 lines,=
 and
>> it is easier to see what is PC machine specific, what is X86 specific, a=
nd
>> what is device generic (not X86 related at all):
>>
>> - GSI is common to X86 (Paolo sent [3], [6])
>> - IOAPIC is common to X86
>> - i8259 is multiarch (Paolo [2])
>> - PCI_HOST definitions and pc_pci_hole64_start() are X86
>> - pc_machine_is_smm_enabled() is X86 (Paolo sent [5])
>> - hpet
>> - tsc (Paolo sent [3])
>> - 3 more functions
>>
>> So we can move half of this file to "pc_internal.h" and the other to
>>
>> One problem is the Q35 MCH north bridge which directly sets the PCI
>> PCMachineState->bus in q35_host_realize(). This seems a QOM violation an=
d is
>> probably easily fixable.
>>
>> Maybe I can apply Paolo's patches instead of this #12, move X86-generic
>> declarations to "hw/i386/x86.h", and directly git-move what's left of
>> "hw/i386/pc.h" to "pc_internal.h".
>=20
> Yea that sounds a bit better.

OK, I'll wait for Paolo's next pull get in, then continue based on that,=20
including Paolo's "x86: allow building without PC machine types" series.

(Thanks Paolo for picking most of this series!)


