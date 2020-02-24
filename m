Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87331C35669
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 03:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520AE20828
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 03:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOw6qM/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520AE20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j64eb-0007iz-He
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 22:43:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1j64dy-0007DR-9z
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 22:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1j64dw-0005ID-4n
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 22:42:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52330
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1j64dw-0005Hw-1I
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 22:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582515771;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iWYznB1aog+O7WLZyGgtypBDYjXWjOFl/A1ZuJAFEzo=;
 b=WOw6qM/3HPZQ+pJO7cAaaDlpJzEr64M8p4bHEO+4fdB74V0n1XLuV2rFqzwKpRPVhOy3+w
 J1L5vizpRoTIYorGhFg5vZfu1W2xv4bwj/CCNBXoaUDW03yAu1LPywIWUjJieNuMRG/7cj
 v4ZqRcJWR4YuiyOFCF5Y++O2vr0Sj9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-P8hYfd4tPGSW0lQwMTcmJg-1; Sun, 23 Feb 2020 22:42:45 -0500
X-MC-Unique: P8hYfd4tPGSW0lQwMTcmJg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3B23189F762;
 Mon, 24 Feb 2020 03:42:43 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-48.bne.redhat.com [10.64.54.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85FD682063;
 Mon, 24 Feb 2020 03:42:35 +0000 (UTC)
Subject: Re: [PATCH] hw/char/pl011: Enable TxFIFO and async transmission
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <158226649422.712.7285415168506294704@a1bbccc8075a>
 <5d569175-55de-b182-a338-cc04ba9b0afd@redhat.com>
 <e24f7030-a703-0887-7dc3-0024af63678b@redhat.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <e414349b-6d33-f849-0ed2-256330912714@redhat.com>
Date: Mon, 24 Feb 2020 14:42:33 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <e24f7030-a703-0887-7dc3-0024af63678b@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Reply-To: Gavin Shan <gshan@redhat.com>
Cc: peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, maz@kernel.org, qemu-arm@nongnu.org,
 shan.gavin@gmail.com, marcandre.lureau@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/21/20 8:46 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/21/20 10:37 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Cc'ing Igor & Drew.
>>
>> On 2/21/20 7:28 AM, no-reply@patchew.org wrote:
>>> Patchew URL: https://patchew.org/QEMU/20200221044908.266883-1-gshan@red=
hat.com/
>> =C2=A0>
>>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>>> #!/bin/bash
>>> make docker-image-centos7 V=3D1 NETWORK=3D1
>>> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
>>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>> [...]
>> =C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 check-qtest-aarch64: tests/qtest/bio=
s-tables-test
>>> **
>>> ERROR:/tmp/qemu-test/src/tests/qtest/acpi-utils.c:145:acpi_find_rsdp_ad=
dress_uefi: code should not be reached
>>> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/acpi-utils.c:145=
:acpi_find_rsdp_address_uefi: code should not be reached
>>> make: *** [check-qtest-aarch64] Error 1
>>
>> The virt machine is not happy, busy-looping?
>>
>> $ QTEST_QEMU_BINARY=3Daarch64-softmmu/qemu-system-aarch64 \
>> =C2=A0=C2=A0 tests/qtest/bios-tables-test
>> /aarch64/acpi/virt: ^C
>=20
> So this test runs:
>=20
> $ qemu-system-aarch64 -M virt -pflash pc-bios/edk2-aarch64-code.fd -pflas=
h pc-bios/edk2-arm-vars.fd -cdrom tests/data/uefi-boot-images/bios-tables-t=
est.aarch64.iso.qcow2 -cpu cortex-a57 -serial stdio

.../...

>=20
> 12638@1582277983.172625:pl011_read addr 0x00000018 value 0x00000010
> 12638@1582277983.172629:pl011_read addr 0x00000018 value 0x00000010
> 12638@1582277983.172633:pl011_read addr 0x00000018 value 0x00000010
> 12638@1582277983.172636:pl011_read addr 0x00000018 value 0x00000010
> 12638@1582277983.172640:pl011_read addr 0x00000018 value 0x00000010
> 12638@1582277983.172643:pl011_read addr 0x00000018 value 0x00000010
> 12638@1582277983.172647:pl011_read addr 0x00000018 value 0x00000010
> 12638@1582277983.172650:pl011_read addr 0x00000018 value 0x00000010
> 12638@1582277983.172654:pl011_read addr 0x00000018 value 0x00000010
> 12638@1582277983.172658:pl011_read addr 0x00000018 value 0x00000010
> 12638@1582277983.172661:pl011_read addr 0x00000018 value 0x00000010
> 12638@1582277983.172665:pl011_read addr 0x00000018 value 0x00000010
> 12638@1582277983.172668:pl011_read addr 0x00000018 value 0x00000010
> 12638@1582277983.172672:pl011_read addr 0x00000018 value 0x00000010
> 12638@1582277983.172675:pl011_read addr 0x00000018 value 0x00000010
> 12638@1582277983.172679:pl011_read addr 0x00000018 value 0x00000010
> 12638@1582277983.172682:pl011_read addr 0x00000018 value 0x00000010
> 12638@1582277983.172686:pl011_read addr 0x00000018 value 0x00000010
> [keep looping]
>=20

Thanks, Phil. It seems there is some race, which causes the PL011_FLAG_TXFF
isn't cleared properly. It should be fixed in v2, which was just posted.
At least, I didn't see the error locally with v2 :)

    # QTEST_QEMU_BINARY=3Daarch64-softmmu/qemu-system-aarch64 tests/qtest/b=
ios-tables-test
      :
    # End of virt tests
    # End of acpi tests
    # End of aarch64 tests

Thanks,
Gavin




