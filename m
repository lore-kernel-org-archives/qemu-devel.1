Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1424C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690142178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qapj4ZB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690142178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iShrG-0001WI-I1
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 08:29:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iShpX-0000HR-OZ
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:28:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iShpU-0003KS-GG
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:28:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46053
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iShpU-0003K4-AG
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 08:28:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573133282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ji4YmVyb04OS5tZjjisxk/iUYDXsfFM1J6L534DDCZs=;
 b=Qapj4ZB+m1rG9UsoxmhnX27knW828OJJl7kBmHLsgDrQEWCe9QnfQI7qrWrGS2iwudCH6C
 lwBg3G3mIR1DjoxdQ5xABpGZVz/KfUMWPuAmUFvXEAm+HlTjcZkRv4J030AZCiAImSPAa+
 bc+mW7s5syIj25dfUEuEN0H7WLizWJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-jUKHCsBPPduA5n88e7630g-1; Thu, 07 Nov 2019 08:27:59 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C6E08017DD;
 Thu,  7 Nov 2019 13:27:58 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.36.118.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AE6060BFB;
 Thu,  7 Nov 2019 13:27:53 +0000 (UTC)
Subject: Re: privileged entropy sources in QEMU/KVM guests
To: Paolo Bonzini <pbonzini@redhat.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <03e769cf-a5ad-99ce-cd28-690e0a72a310@redhat.com>
 <CAKv+Gu8gqfu_mOm2zK64dmj5CkVaPvix3gEMEFQScyk1CnOv6w@mail.gmail.com>
 <ef126cd5-7b64-1b8a-ca74-11bd06b5f4b1@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <421cf4ef-ea84-c7e6-81aa-c24a91459de5@redhat.com>
Date: Thu, 7 Nov 2019 14:27:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ef126cd5-7b64-1b8a-ca74-11bd06b5f4b1@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: jUKHCsBPPduA5n88e7630g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Jian J Wang <jian.j.wang@intel.com>,
 edk2-devel-groups-io <devel@edk2.groups.io>,
 Bret Barkelew <Bret.Barkelew@microsoft.com>,
 qemu devel list <qemu-devel@nongnu.org>, Erik Bjorge <erik.c.bjorge@intel.com>,
 Sean Brogan <sean.brogan@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/07/19 12:37, Paolo Bonzini wrote:
> On 07/11/19 11:25, Ard Biesheuvel wrote:
>>> This looks problematic on QEMU. Entropy is a valuable resource, and
>>> whatever resource SMM drivers depend on, should not be possible for e.g=
.
>>> a 3rd party UEFI driver (or even for the runtime OS) to exhaust.
>>> Therefore, it's not *only* the case that SMM drivers must not consume
>>> EFI_RNG_PROTOCOL (which exists at a less critical privilege level, i.e.
>>> outside of SMM/SMRAM), but also that SMM drivers must not depend on the
>>> same piece of *hardware* that feeds EFI_RNG_PROTOCOL.
>>>
>> The typical model is to seed a DRBG [deterministic pseudorandom
>> sequence generator] using a sufficient amount of high quality entropy.
>> Once you have done that, it is rather hard to exhaust a DRBG - it is a
>> mathematical construction that is designed to last for a long time (<=3D
>> 2^48 invocations [not bytes] according to the NIST spec), after which
>> it does not degrade although it may have generated so much output that
>> its internal state may be inferred if you have captured enough of it
>> (which is a rather theoretical issue IMHO)
>>
>> The problem is that using the output of a DRBG as a seed is
>> non-trivial - the spec describes ways to do this, but wiring
>> virtio-rng to a DRBG in the host and using its output to seed a DRBG
>> in the guest is slighly problematic.
>>
>> So it seems to me that the correct way to model this is to make the
>> host's true entropy source a shared resource like any other.
>>
>=20
> Yes, I would make SMM use a cryptographic pseudo-random number generator=
=20
> and seed it from virtio-rng from DXE,

The VirtioRngDxe driver is a UEFI driver that follows the UEFI driver
model. Meaning (in this context), it is connected to the virtio-rng
device in the BDS phase, by platform BDS code.

The variable SMM driver is necessary for producing the UEFI Variable and
Variable Write architectural protocols. BDS can only be entered when all
the architectural protocols have been installed.

Therefore we have a circular dependency with the above -- assuming we
intend to delay the *startup* of the variable SMM driver until after
EFI_RNG_PROTOCOL is available.

But, perhaps, could the variable SMM driver start up anyway, and consume
EFI_RNG_PROTOCOL just when it really needs the random seed? I doubt it:
other EFI_RNG_PROTOCOL instances could be produced by other (3rd party)
UEFI drivers. Or other (3rd party) modules could "attack" VirtioRngDxe.
A privileged (SMM) driver should not consume such sensitive data from a
non-privileged driver, unless the latter was built into the platform
firmware, and the consumption occurred before the End-of-Dxe event
(which is signaled by platform BDS, early in the BDS phase).

Put differently, the non-privileged driver that's the source of the
sensitive data would have to be a "platform DXE driver". The virtio
drivers are not such drivers however.

I can imagine a roundabout way to hack this around in OVMF's platform
BDS, quite horribly, but I'd like to consider other approaches first.

Thank you!
Laszlo

> way before the OS starts and can=20
> "attack" it.
>=20
> Once you've gotten a seed, you can create a CSPRNG with a stream cipher=
=20
> such as ChaCha20, which is literally 30 lines of code.
>=20
> Paolo
>=20
> #define ROTL(a,b) (((a) << (b)) | ((a) >> (32 - (b))))
> #define QR(a, b, c, d) (=09=09=09\
> =09a +=3D b,  d ^=3D a,  d =3D ROTL(d,16),=09\
> =09c +=3D d,  b ^=3D c,  b =3D ROTL(b,12),=09\
> =09a +=3D b,  d ^=3D a,  d =3D ROTL(d, 8),=09\
> =09c +=3D d,  b ^=3D c,  b =3D ROTL(b, 7))
> #define ROUNDS 20
>=20
> // initial state:
> // in[0] =3D 0x65787061
> // in[1] =3D 0x6e642033
> // in[2] =3D 0x322d6279
> // in[3] =3D 0x7465206b
> // in[4]..in[11] =3D key (seed)
> // in[12]..in[13] =3D 0
> // in[14]..in[15] =3D nonce, can probably use RDTSC?
> static uint32_t in[16];
>=20
> uint32_t chacha_rng(void)
> {
> =09int i;
> =09static uint32_t x[16], p;
> =09if (p < 16)
> =09=09return in[p++] + x[p++];
>=20
> =09if (++in[12] =3D=3D 0)
> =09=09++in[13];
>=20
> =09for (i =3D 0; i < 16; ++i)
> =09=09x[i] =3D in[i];
>=20
> =09// 10 loops =C3=97 2 rounds/loop =3D 20 rounds
> =09for (i =3D 0; i < ROUNDS; i +=3D 2) {
> =09=09// Odd round
> =09=09QR(x[0], x[4], x[ 8], x[12]); // column 0
> =09=09QR(x[1], x[5], x[ 9], x[13]); // column 1
> =09=09QR(x[2], x[6], x[10], x[14]); // column 2
> =09=09QR(x[3], x[7], x[11], x[15]); // column 3
> =09=09// Even round
> =09=09QR(x[0], x[5], x[10], x[15]); // diagonal 1 (main diagonal)
> =09=09QR(x[1], x[6], x[11], x[12]); // diagonal 2
> =09=09QR(x[2], x[7], x[ 8], x[13]); // diagonal 3
> =09=09QR(x[3], x[4], x[ 9], x[14]); // diagonal 4
> =09}
> =09p =3D 1;
> =09return in[0] + x[0];
> }
>=20


