Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CBDC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD3E20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaclFHkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD3E20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZwG-0004eK-4s
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j6ZUh-0004v6-MA
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:39:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j6ZUg-00046Q-DV
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:39:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30210
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j6ZUg-00045z-9r
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:39:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582634361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=prlOgWgQ9Ik+E3eF9Wnb1i83rqLIAzGc5kS9vOvkF4o=;
 b=LaclFHkbyTVvUaX1oKImu1lcEsuV9onscLy4+fQP934U5eKkfT4vyxcCoVVoxxVqNoPwJc
 50mhbMCSz32nlpkwLqXwutRwM0qbjfwf23XW0PJAo+ahLyOqudah6sMp4Add+Wd5mMiJoP
 WNypK9+8s7LAkQA8iwFJzuOX+1gNWxg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-Dk8ekPLXODuX4FaDc2a1-A-1; Tue, 25 Feb 2020 07:39:19 -0500
X-MC-Unique: Dk8ekPLXODuX4FaDc2a1-A-1
Received: by mail-wm1-f72.google.com with SMTP id 7so974004wmf.9
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:39:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kztbPaVB/2XMFABxpPNGrrCj9r6pdnumsQimldYZmLg=;
 b=SgWGmV6nOFgMfEgEfwiE1jYF/72CHnrxhBy3pN+vrbAGrGWQlv8PCn/eGxSTpxGMa3
 EZBxSOzTZHjkXPV9qKRs4YV8eXcMEipsYiwHGDNIUe77RxDM7pyuYMdEGB9liGyx8vzy
 wJh8W48t1oETALdxhDqmLuji+Kvg7S3KLZsmc1Vbubg+u6tzoMlbu4DEhJzBiytbLFF8
 nJuKp+y9jzTj9aVk/itTPh38x/WNsdbeZl24VmGooQk7tLetgFqU17g+JnhrMiFGbxv4
 z/MB5DBQldnytT1cvErpt0kyd0PVjj1vCconrfluIJJ1QKZzBcxXUX4jVE+WYX5AdAJ2
 amqg==
X-Gm-Message-State: APjAAAV5JtWvNByo8JFkWnpdeJkTsHBKZYgSiPL9jZsVF8e7JxooplM+
 /ztcqOnnhpOOfMVWvuK8dHFvbkh1VOxDKP4euBU/mIqA94QymExHDicX03iFwVzRpLNjEHAqyom
 2WBsa6XbdenyHYWY=
X-Received: by 2002:a1c:541b:: with SMTP id i27mr5524326wmb.137.1582634358169; 
 Tue, 25 Feb 2020 04:39:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqwMxOydfsyqbVFz+9ojWD99h41Ff9l0Bl/3ROeYCCGkjzMVH3uMtzNaJvjeoky0SS3gZviSrg==
X-Received: by 2002:a1c:541b:: with SMTP id i27mr5524296wmb.137.1582634357874; 
 Tue, 25 Feb 2020 04:39:17 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3577:1cfe:d98a:5fb6?
 ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
 by smtp.gmail.com with ESMTPSA id w8sm3982443wmm.0.2020.02.25.04.39.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:39:17 -0800 (PST)
Subject: Re: [PATCH RESEND v2 18/32] hw/i386/pc_sysfw: Simplify using
 memory_region_init_alias()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200224205533.23798-1-philmd@redhat.com>
 <20200224205533.23798-19-philmd@redhat.com>
 <532522f3-fc33-4405-1819-fe89c3ed088e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <683355b0-cf04-d57a-92aa-500dbf1b94a8@redhat.com>
Date: Tue, 25 Feb 2020 13:39:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <532522f3-fc33-4405-1819-fe89c3ed088e@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/02/20 11:05, Philippe Mathieu-Daud=C3=A9 wrote:
>>
>> pc_isa_bios_init() does a manual copy of a part of the BIOS,
>> from a read-only region. We can simplify by directly aliasing
>> the same part.
>>
>> Before:
>>
>> =C2=A0=C2=A0 (qemu) info mtree
>> =C2=A0=C2=A0 memory-region: system
>> =C2=A0=C2=A0=C2=A0=C2=A0 0000000000000000-ffffffffffffffff (prio 0, i/o)=
: system
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0000000000000000-0000000007ffffff (=
prio 0, ram): alias
>> ram-below-4g @pc.ram 0000000000000000-0000000007ffffff
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0000000000000000-ffffffffffffffff (=
prio -1, i/o): pci
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000000a0000-000000=
00000bffff (prio 1, i/o): vga-lowmem
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000000c0000-000000=
00000dffff (prio 1, rom): pc.rom
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000000e0000-000000=
00000fffff (prio 1, rom): isa-bios
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000fff00000-00000000ffffffff (=
prio 0, romd): system.flash0
>>
>> After:
>>
>> =C2=A0=C2=A0 (qemu) info mtree
>> =C2=A0=C2=A0 memory-region: system
>> =C2=A0=C2=A0=C2=A0=C2=A0 0000000000000000-ffffffffffffffff (prio 0, i/o)=
: system
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0000000000000000-0000000007ffffff (=
prio 0, ram): alias
>> ram-below-4g @pc.ram 0000000000000000-0000000007ffffff
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0000000000000000-ffffffffffffffff (=
prio -1, i/o): pci
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000000a0000-000000=
00000bffff (prio 1, i/o): vga-lowmem
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000000c0000-000000=
00000dffff (prio 1, rom): pc.rom
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000000e0000-000000=
00000fffff (prio 1, romd): alias
>> isa-bios @system.flash0 00000000000e0000-00000000000fffff
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000fff00000-00000000ffffffff (=
prio 0, romd): system.flash0
>=20
> IIUC migrating old -> new is OK, the previous ROM copy is discarded.
>=20
> What about new -> old, does it require specific handling? Do we care?

Old->new is broken because the "isa-bios" memory region is not found.

qemu-system-x86_64: Unknown ramblock "isa-bios", cannot accept migration
qemu-system-x86_64: error while loading state for instance 0x0 of device 'r=
am'
qemu-system-x86_64: load of migration failed: Invalid argument

Paolo


