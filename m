Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960FAC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60AC220873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SK/pDUVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60AC220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2FIY-0002ck-IC
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:16:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2FHf-0001ah-Df
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:16:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2FHd-0000nF-PI
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:16:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50470
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2FHd-0000kF-LH
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581603361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1KIyTd1KNufXatXvynb29Zy6em2ZrIr5HGYCIBXf7/Q=;
 b=SK/pDUVrcVK3mnAG9suGYWipUH1lSWPUghnstf2NiYVPHNl9XLPl/LwnHBjQ4mV/e1r1IL
 mIl/gGed1C9NF3CwMRqSRytXdz9ES0NoBsqO2hH/J7O2EWCteEEMkDUxxY+ka/+mglygb4
 ++/U1BxpyNI5i3aYD2Wqh6B+W+Mjl3A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-a9qLZJzVMue3oKhH2kBPpw-1; Thu, 13 Feb 2020 09:15:58 -0500
Received: by mail-wr1-f70.google.com with SMTP id o9so2389370wrw.14
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M7EQH5112ZLgoZmp0GZhZ+qjnFhTzRPphsDLuND2OfY=;
 b=nzBWdvWUPm3SszK5PYsjCuI2EANssWDfv4EGL6cRalV4CJJVoC3GmVlIokgKgR7sPW
 tc37xH9//0t9nQSB8x/jyT6TpIlbpG3nYxMvHhVSo7pEQG3Ce3k/z5GSBcxHuuSXvj/z
 gQWoD16eHQ8nCHKVaLPZSNn1/SjT3QgZWtvK2IRwtiwMPEtw46EK0FsJfFzhzbSsvImT
 HjKAfvVpF55615S+d5sZTkoqXzo8uf0kHk8VRfiymDHR5PTf4i4P4gO5a8/MORDgaeoj
 SEFEh8FLel1QG1GyM6LrLET9jbZF+2L8os1UwxO9neCnbL82ChSVqCh1y21bXam+jK8z
 icMA==
X-Gm-Message-State: APjAAAX1p2Kp3idoTUP0nWOF+TsycfYJZTmVgVV8PgCw1smLMS5D1mb2
 VdWiCjKTwETthKLIzFaF0y966jP1JPp0pXN7BKuysQmAsH5aCJ35C/iSY8uiuk126LRQByikZmJ
 +hQ6u7SFTbgYX4G4=
X-Received: by 2002:a5d:5403:: with SMTP id g3mr23120263wrv.302.1581603356826; 
 Thu, 13 Feb 2020 06:15:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqyuZgqg5afF9M+EUgu0+U1uCiL5S4kgZRzzh0xMk6eZVgl7GYez9PRHOKCyPGCo2iC0G7/uaA==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr23120232wrv.302.1581603356480; 
 Thu, 13 Feb 2020 06:15:56 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id x21sm2956931wmi.30.2020.02.13.06.15.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2020 06:15:55 -0800 (PST)
Subject: Re: [PATCH v3 12/13] hw/arm/raspi: Use a unique
 raspi_machine_class_init() method
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Igor Mammedov <imammedo@redhat.com>
References: <20200208165645.15657-1-f4bug@amsat.org>
 <20200208165645.15657-13-f4bug@amsat.org>
 <CAFEAcA8e4NqwKPM6qx=vKm6NOz__=S90trhUuhaSNe_yJ8GeXg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0d72fad3-3eef-66ff-2162-f0c07ba01ff2@redhat.com>
Date: Thu, 13 Feb 2020 15:15:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8e4NqwKPM6qx=vKm6NOz__=S90trhUuhaSNe_yJ8GeXg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: a9qLZJzVMue3oKhH2kBPpw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 2:59 PM, Peter Maydell wrote:
> On Sat, 8 Feb 2020 at 16:57, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>>
>> With the exception of the ignore_memory_transaction_failures
>> flag set for the raspi2, both machine_class_init() methods
>> are now identical. Merge them to keep a unique method.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   hw/arm/raspi.c | 31 ++++++-------------------------
>>   1 file changed, 6 insertions(+), 25 deletions(-)
>>
>> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
>> index 0537fc0a2d..bee6ca0a08 100644
>> --- a/hw/arm/raspi.c
>> +++ b/hw/arm/raspi.c
>> @@ -294,7 +294,7 @@ static void raspi_machine_init(MachineState *machine=
)
>>       setup_boot(machine, version, machine->ram_size - vcram_size);
>>   }
>>
>> -static void raspi2_machine_class_init(ObjectClass *oc, void *data)
>> +static void raspi_machine_class_init(ObjectClass *oc, void *data)
>>   {
>>       MachineClass *mc =3D MACHINE_CLASS(oc);
>>       RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
>> @@ -311,41 +311,22 @@ static void raspi2_machine_class_init(ObjectClass =
*oc, void *data)
>>       mc->min_cpus =3D BCM283X_NCPUS;
>>       mc->default_cpus =3D BCM283X_NCPUS;
>>       mc->default_ram_size =3D board_ram_size(board_rev);
>> -    mc->ignore_memory_transaction_failures =3D true;
>> +    if (board_version(board_rev) =3D=3D 2) {
>> +        mc->ignore_memory_transaction_failures =3D true;
>> +    }
>>   };
>=20
> This isn't really the correct condition here. What we want is:
>   * for the board named 'raspi2' which was introduced before
>     we added the transaction-failure support to Arm CPU emulation,
>     disable signaling transaction failures
>   * for any other board, leave it enabled (whether that new
>     board is BCM2836 based or anything else)
>=20
> (This kind of follows on from my remark on patch 3: we should
> be suspicious of anything that's conditional on board_version();
> it should probably be testing something else.)
>=20
> The natural way to implement this is to have the .class_data
> be a pointer to a struct which is in an array and defines
> relevant per-class stuff, the same way we do in
> bcm2836_register_types(). That way the struct can indicate
> both the board revision number and also "is this a legacy
> board that needs transaction-failures disabled?".

IIUC Igor insists explaining that he doesn't accept anymore a=20
".class_data pointer to a struct which is in an array and defines=20
relevant per-class stuff" and we should not use this pattern anymore.

> The other approach here, as discussed on IRC, is that if
> we're confident we really have all the devices in the SoC
> either present or stubbed out with unimplemented-device
> then we could disable ignore_memory_transaction_failures
> for raspi2. (The flag is only there because I didn't want
> to try to do the auditing and fielding of potential bug
> reports if I changed the behaviour of a bunch of our
> existing not-very-maintained board models: the real
> correct behaviour in almost all cases would be to allow
> transaction failures and just make sure we have stub devices
> as needed.)

Yes, the plan is to add all the unimplemented peripherals (patches=20
ready, but out of scope of this series) and remove this flag.

> That said, this does give the right answer for our current boards,
> so I'm ok with taking this series if you want to address this
> in a followup patch.

If you are OK, I prefer to address this in a later series than delaying=20
this one more longer.

Thanks!


