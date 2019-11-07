Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51250C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 11:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D68218AE
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 11:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfXe+F0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D68218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41315 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSgRx-00055i-4u
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 06:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iSgR1-0004bn-Cs
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iSgR0-000231-3t
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:58:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54090
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iSgR0-00022n-02
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:58:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573127921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=viHoCAThrSI4JRu4Bv6Nl9KQyIv4AUk+4YwSLgRs/N0=;
 b=DfXe+F0ONokukNyN4pCVVHDCS86429XD7aL8bMwTcATzfVCffzk0KS3PbAPov/LcgEPvVa
 zIqLh0xfj28lVpMz0r8xFeJXVFfQBIHR/UrVXN0WhMqBgtOV4VpzH/AWevySJzCrs8KONn
 OuMv45wBgC789VdeOk698PUp/f4kfJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-Fo3Z1EELOp-aQmpAAUS4Vw-1; Thu, 07 Nov 2019 06:58:39 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E7651005500;
 Thu,  7 Nov 2019 11:58:38 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.36.118.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5318E5C290;
 Thu,  7 Nov 2019 11:58:32 +0000 (UTC)
Subject: Re: privileged entropy sources in QEMU/KVM guests
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <03e769cf-a5ad-99ce-cd28-690e0a72a310@redhat.com>
 <CAKv+Gu8gqfu_mOm2zK64dmj5CkVaPvix3gEMEFQScyk1CnOv6w@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2a8ac02c-e934-3474-5d40-01b8308d1fa9@redhat.com>
Date: Thu, 7 Nov 2019 12:58:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8gqfu_mOm2zK64dmj5CkVaPvix3gEMEFQScyk1CnOv6w@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Fo3Z1EELOp-aQmpAAUS4Vw-1
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
 Sean Brogan <sean.brogan@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/07/19 11:25, Ard Biesheuvel wrote:
> On Thu, 7 Nov 2019 at 11:11, Laszlo Ersek <lersek@redhat.com> wrote:

>> (1) For UEFI HTTPS boot, TLS would likely benefit from good quality
>> entropy. If the VM config includes virtio-rng (hence the guest firmware
>> has EFI_RNG_PROTOCOL), then it should be used as a part of HTTPS boot.
>>
>> However, what if virtio-rng (hence EFI_RNG_PROTOCOL) are absent? Should
>> UEFI HTTPS boot be disabled completely (or prevented / rejected
>> somehow), blaming lack of good entropy? Or should TLS silently fall back
>> to "mixing some counters [such as TSC] together and applying a
>> deterministic cryptographic transformation"?
>>
>> IOW, knowing that the TLS setup may not be based on good quality
>> entropy, should we allow related firmware services to "degrade silently"
>> (not functionally, but potentially in security), or should we deny the
>> services altogether?
>>
>=20
> TLS uses a source of randomness to establish symmetric session keys
> for encryption. So it really depends on the use case whether HTTPS is
> used for authentication or for confidentiality, and it seems to me
> that it would typically be the former. So disabling HTTPS boot in this
> case seems counterproductive to me.

OK. So this might be an argument for an RngLib instance that tries to
consume EFI_RNG_PROTOCOL, and if the protocol is absent, the lib
instance falls back to a TSC-seeded PRNG.

We'd have to make sure (or prove) that the protocol lookup in the lib
occurs *after* BDS made an attempt to connect the virtio-rng device(s).

>> (2) It looks like the SMM driver implementing the privileged part of the
>> UEFI variable runtime service could need access to good quality entropy,
>> while running in SMM; in the future.
>>
>> This looks problematic on QEMU. Entropy is a valuable resource, and
>> whatever resource SMM drivers depend on, should not be possible for e.g.
>> a 3rd party UEFI driver (or even for the runtime OS) to exhaust.
>> Therefore, it's not *only* the case that SMM drivers must not consume
>> EFI_RNG_PROTOCOL (which exists at a less critical privilege level, i.e.
>> outside of SMM/SMRAM), but also that SMM drivers must not depend on the
>> same piece of *hardware* that feeds EFI_RNG_PROTOCOL.
>>
>=20
> The typical model is to seed a DRBG [deterministic pseudorandom
> sequence generator] using a sufficient amount of high quality entropy.
> Once you have done that, it is rather hard to exhaust a DRBG - it is a
> mathematical construction that is designed to last for a long time (<=3D
> 2^48 invocations [not bytes] according to the NIST spec), after which
> it does not degrade although it may have generated so much output that
> its internal state may be inferred if you have captured enough of it
> (which is a rather theoretical issue IMHO)

Thanks! I think this helps.

Because then the guest SMM code could read the seed from (for example) a
well-known PCI BDF (such as 0/0/0), at either a fixed config space
offset, or from a vendor capability. This doesn't depend on PCI
enumeration, and it also cannot be interfered with by 3rd party UEFI
code or OS code, because the only such reads would occur in the subject
SMM drivers' entry point functions.

On the Q35 board in QEMU, we already use some config space registers
that are left unspecified in Intel datasheet 316966-002, Table 5-1 "DRAM
Controller Register Address Map (D0:F0)", for various paravirt purposes.
We haven't run out of such "free for the taking" config space registers
yet, and for this particular purpose we only need a single byte
register. (The first read would expose whether the feature were
supported, the other reads would provide bytes for the seed.)

>=20
> The problem is that using the output of a DRBG as a seed is
> non-trivial - the spec describes ways to do this, but wiring
> virtio-rng to a DRBG in the host and using its output to seed a DRBG
> in the guest is slighly problematic.

Can we forward /dev/urandom from the host to the guest through an
interface like described above? (Single byte config space register.)

> So it seems to me that the correct way to model this is to make the
> host's true entropy source a shared resource like any other.

I don't know enough to agree or disagree. I guess this might require
additional permission management on the host side.

(NB my only purpose with this thread is to ensure that the internal edk2
interfaces, such as lib class APIs and possible SMM protocols, will
offer the dynamism that's necessary when running on QEMU.)

Thanks!
Laszlo


