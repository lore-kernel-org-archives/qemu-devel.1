Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BFBCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 063ED20679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="u6PTN9wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063ED20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNc6S-0002Ia-F2
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1iNbIB-0003l1-8e
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geoff@hostfission.com>) id 1iNbI7-00005d-FO
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:33 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:44254)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <geoff@hostfission.com>) id 1iNbI4-0008WB-Jd
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:29 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
 by mail1.hostfission.com (Postfix) with ESMTP id 7ECFC4B25A;
 Thu, 24 Oct 2019 22:28:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1571916505;
 bh=soJyGi1Ly7uM+HrPRC6ujhgOZJg6JnaBHFf4UxZNIJc=;
 h=To:Subject:Date:From:Cc:In-Reply-To:References:From;
 b=u6PTN9wzWh7+aCxb5HUUpe2Pl9sfSq4KGAhXGl93YX8uL+W/zJNc8oS2umg1gJYII
 S39Z9dIfZQjT6f45wSKRGCBwKOT+qDe4UEMjwd+WqUyw9Kd4FDZQQMLGXxMYvlR+b8
 xImM72uYEM/YXmgQox17h9YoMeETA2ZDtcJ2cPYc=
Received: by www1.hostfission.com (Postfix, from userid 1000)
 id 7677083493; Thu, 24 Oct 2019 22:28:25 +1100 (AEDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: Adding a memory alias breaks v-rings
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 24 Oct 2019 22:28:25 +1100
Cc: qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, KONRAD
 Frederic <frederic.konrad@adacore.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <45003cbd-2fdd-248d-85e8-302b4b87957d@redhat.com>
References: <19efadd24a38e4e877459404ff12ac20@hostfission.com>
 <45003cbd-2fdd-248d-85e8-302b4b87957d@redhat.com>
Message-ID: <0acd3f63dff2db6888dfa6635b6023f3@hostfission.com>
X-Sender: geoff@hostfission.com
User-Agent: Roundcube Webmail/1.2.3
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 139.99.139.48
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: geoff@hostfission.com
From: geoff--- via <qemu-devel@nongnu.org>

Hi Phil

On 2019-10-24 22:07, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Geoffrey,
>=20
> On 10/24/19 10:27 AM, geoff@hostfission.com wrote:
>> Hi All,
>>=20
>> I have been working on adding a feature as a proof of concept to=20
>> improve the performance of applications like Looking Glass by avoiding=
=20
>> additional memory copies. My goal is to alias part of the IVSHMEM=20
>> shared memory over a pointer provided by the guest OS capture API=20
>> (DXGI Desktop Duplication or NVIDIA Frame Buffer Capture). I have=20
>> managed to get this working by adding a few additional configuration=20
>> registers to the IVSHMEM device and enhanced the IVSHMEM windows=20
>> driver with suitable IOCTLs to set this all up. While this concept is=20
>> backwards it needs to work this way as we do not have control over the=
=20
>> destination buffer allocation by the GPU driver.
>>=20
>> This all works, however, it has exposed a bug (or I am doing things=20
>> improperly) with the way that vhost tracks memory. When calling=20
>> memory_region_add_subregion_overlap the memory listener in vhost fires=
=20
>> triggering vhost_region_add_section. According to the comments this=20
>> code depends on being called in memory address order, but because I am=
=20
>> adding the alias region late, it's out of order, and also splits the=20
>> upper memory region. This has the effect of corrupting/breaking one or=
=20
>> more random vrings, as evidenced by the crash/hang of vhost-net or=20
>> other virtio devices.
>=20
> I'm not sure this is the same issue I had before, but you might
> find Frederic and Alexey suggestions from this thread helpful:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg525833.html
>=20
> Also note vhost_region_add_section() you mentioned has this comment:
>=20
>     if (need_add) {
>         ...
>         /* The flatview isn't stable and we don't use it, making it=20
> NULL
>          * means we can memcmp the list.
>          */
>         dev->tmp_sections[dev->n_tmp_sections - 1].fv =3D NULL;
>=20
> Maybe you need this change:
>=20
> -- >8 --
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -642,6 +642,7 @@ static void vhost_region_add_section(struct=20
> vhost_dev *dev,
>           */
>          dev->tmp_sections[dev->n_tmp_sections - 1].fv =3D NULL;
>          memory_region_ref(section->mr);
> +        memory_region_update_container_subregions(section->mr);
>      }
>  }
>=20
> ---

Unfortunately not, `memory_region_update_container_subregions` is=20
private in memory.c hangs the VM even if I expose it and call it as you=20
suggested. It is also already called via=20
memory_region_add_subregion_overlap anyway.

Thanks for the suggestion though :)

>=20
> Regards,
>=20
> Phil.
>=20
>> The following and errors are also logged regarding section alignment:
>>=20
>> qemu-system-x86_64: vhost_region_add_section:Section rounded to=20
>> 3c0000000 prior to previous 3fc4f9000
>> qemu-system-x86_64: vhost_region_add_section:Section rounded to=20
>> 3c0000000 prior to previous 3fc4f9000
>>=20
>> Here is the flat view after the alias has been added.
>>=20
>>  =C2=A0 0000000100000000-00000003fc4f8fff (prio 0, ram): mem=20
>> @0000000080000000 kvm
>>  =C2=A0 00000003fc4f9000-00000003fc4f9fff (prio 1, ram): ivshmem kvm
>>  =C2=A0 00000003fc4fa000-000000043fffffff (prio 0, ram): mem=20
>> @000000037c4fa000 kvm
>>=20
>> When the guest doesn't crash out due to the obvious corruption it is=20
>> possible to verify that the alias is in the right place and fully=20
>> functional. Unfortunately, I simply do not have enough of a grasp on=20
>> vhost to understand exactly what is going on and how to correct it.
>>=20
>> Getting this feature working is highly desirable as it should be=20
>> possible to obtain GPU -> GPU memory transfers between guests without=20
>> requiring workstation/professional graphics cards.
>>=20
>> Kind Regards,
>> Geoffrey McRae
>>=20

