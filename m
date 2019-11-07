Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4702C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EC5E2178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bclaJV3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC5E2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iShvo-0004fZ-LM
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 08:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iShuz-0003aA-5G
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iShuy-0002Dv-6K
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:33:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31086
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iShuy-0002Cs-2q
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573133623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hne8Xc9Prw56eV219P4K2oThuCZJY7wVOK3aW/c/52A=;
 b=bclaJV3vYNtuVVMXFqBB4k6I0UAx1yRD6VBYkifHjnSNR+c2roEgJnIT0Q/VZA0pVXQ0Ff
 bNYTObTgCcbZF92VScLwpNouggeI+wwNnY1jRPIWPDCOmMa9Hhbmxu7dew/yq6hcIfTfxy
 qkUSYeqn45t5QBVer1+ewcAt6lv5zro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-xznmCGDMPz2FDbiVBnClKw-1; Thu, 07 Nov 2019 08:33:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC144477;
 Thu,  7 Nov 2019 13:33:38 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.36.118.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F38A196AE;
 Thu,  7 Nov 2019 13:33:33 +0000 (UTC)
Subject: Re: privileged entropy sources in QEMU/KVM guests
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
References: <03e769cf-a5ad-99ce-cd28-690e0a72a310@redhat.com>
 <CAKv+Gu8gqfu_mOm2zK64dmj5CkVaPvix3gEMEFQScyk1CnOv6w@mail.gmail.com>
 <ef126cd5-7b64-1b8a-ca74-11bd06b5f4b1@redhat.com>
 <20191107115511.GE120292@redhat.com>
 <19fc6a42-e773-f8b8-db4a-c8ed853da30c@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <beea35c7-9608-fc2c-846a-8787c07c9c67@redhat.com>
Date: Thu, 7 Nov 2019 14:33:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <19fc6a42-e773-f8b8-db4a-c8ed853da30c@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: xznmCGDMPz2FDbiVBnClKw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Jian J Wang <jian.j.wang@intel.com>,
 edk2-devel-groups-io <devel@edk2.groups.io>,
 Bret Barkelew <Bret.Barkelew@microsoft.com>,
 qemu devel list <qemu-devel@nongnu.org>, Erik Bjorge <erik.c.bjorge@intel.com>,
 Sean Brogan <sean.brogan@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/07/19 13:50, Paolo Bonzini wrote:
> On 07/11/19 12:55, Daniel P. Berrang=C3=A9 wrote:
>>> Yes, I would make SMM use a cryptographic pseudo-random number generato=
r=20
>>> and seed it from virtio-rng from DXE, way before the OS starts and can=
=20
>>> "attack" it.
>>>
>>> Once you've gotten a seed, you can create a CSPRNG with a stream cipher=
=20
>>> such as ChaCha20, which is literally 30 lines of code.
>> If all we need is a one-time seed then virtio-rng is possibly overkill a=
s
>> that provides a continuous stream. Instead could QEMU read a few bytes
>> from the host's /dev/urandom and pass it to EDK via fw_cfg, which can
>> use it for the CSPRNG seed. EDK would have to erase the fw_cfg field
>> to prevent the seed value leaking to the guest OS, but other than that
>> its quite straightforward.
>=20
> That would need anyway a change to the emulated hardware.  If the guest
> is able to use virtio-rng after the firmware exits (which is the case is
> all the firmware needs is a one-time seed), then using virtio-rng is the
> simplest alternative as it needs no change at all outside the firmware.

This is a really good point!

I'll think more about using virtio-rng, hopefully without horribly
hacking OVMF's BDS code.

Thanks
Laszlo


