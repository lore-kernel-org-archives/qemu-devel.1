Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A855CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 07:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC07207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 07:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSr151Eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC07207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeCin-0001vk-II
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 03:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeCi8-00015U-15
 for qemu-devel@nongnu.org; Thu, 28 May 2020 03:12:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22287
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeCi7-0003mV-17
 for qemu-devel@nongnu.org; Thu, 28 May 2020 03:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590649934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJoozorhkG9T5DfjHFlznEGcxGK753quRco6hdAGu+M=;
 b=hSr151Ebw/j2DQbB7tH2ADxiPdeSYtt095yZjw3fNsRCVGvTlOWjKOmpqTgv6+yU8SxLDm
 scW54sppBle/PG7ZCapkRs2boLgNeHQKoM7b2oTTXuWj0mkNzPpo675ZTSe88xMD9L10EB
 Nnf7d3NSF73gFaacUvhIsn926RW7z7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-0gFLEV12O1u5iHyIANzjSQ-1; Thu, 28 May 2020 03:12:09 -0400
X-MC-Unique: 0gFLEV12O1u5iHyIANzjSQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A21D80183C;
 Thu, 28 May 2020 07:12:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B5C85C1B0;
 Thu, 28 May 2020 07:12:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 11436113864A; Thu, 28 May 2020 09:12:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3] arm/aspeed: Rework NIC attachment
References: <20200527124406.329503-1-clg@kaod.org>
 <87lfldzehq.fsf@dusky.pond.sub.org>
 <d862f70c-aebd-c1f0-ded6-79a85fbc82f2@kaod.org>
Date: Thu, 28 May 2020 09:12:06 +0200
In-Reply-To: <d862f70c-aebd-c1f0-ded6-79a85fbc82f2@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Wed, 27 May 2020 17:46:25 +0200")
Message-ID: <87y2pcv8hl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> On 5/27/20 3:36 PM, Markus Armbruster wrote:
>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>=20
>>> The number of MACs supported by an Aspeed SoC is defined by "macs_num"
>>> under the SoC model, that is two for the AST2400 and AST2500 and four
>>> for the AST2600. The model initializes the maximum number of supported
>>> MACs but the number of realized devices is capped by the number of
>>> network device back-ends defined on the command line. This can leave
>>> unrealized devices hanging around in the QOM composition tree.
>>>
>>> Modify the machine initialization to define which MACs are attached to
>>> a network device back-end using a bit-field property "macs-mask" and
>>> let the SoC realize all network devices.
>>>
>>> The default setting of "macs-mask" is "use MAC0" only, which works for
>>> all our AST2400 and AST2500 machines. The AST2600 machines have
>>> different configurations. The AST2600 EVB machine activates MAC1, MAC2
>>> and MAC3 and the Tacoma BMC machine activates MAC2.
>>=20
>> Let's be more clear on what this means, and "This is actually a device
>> modelling fix for these two machines."  Okay?
>
> Well, I guess so. It's a fix in the way we attach network backends to=20
> the MACs of the machines.=20

Yes, it's that too.

> On the tacoma-bmc, we had to use '-nic <foo> -nic <bar> -nic <good one>'=
=20
> to configure the MAC2 in use by the machine. Which was dubious.

I think you had to use something like

    -nic none -nic none -nic GOOD-ONE -nic none

to get virtual hardware that matches the physical hardware, which I
understand has all four MACs on the die, but only MAC2 connected to the
outside.

In particular, the default configuration (no -nic, -nodefaults, etc.)
got you only MAC0.  With just -nodefaults, you got none at all.

> Now, a single -nic is enough.

Now you get all four MACs regardless of configuration, but only MAC2 can
be connected to a backend, e.g. with a single -nic.

The default configuration (no -nic, -nodefaults, etc.) just works: MAC2
connected to the default network backend.

With just -nodefaults, MAC2 remains unconnected.

This matches how other machines work.

>>> Inactive MACs will have no peer and QEMU may warn the user with :
>>>
>>>     qemu-system-arm: warning: nic ftgmac100.0 has no peer
>>>     qemu-system-arm: warning: nic ftgmac100.1 has no peer
>>>     qemu-system-arm: warning: nic ftgmac100.3 has no peer
>>>
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>=20
>> Here's the "info qom-tree" change for tacoma-bmc:
>>=20
>>      /machine (tacoma-bmc-machine)
>>        /peripheral (container)
>>        /peripheral-anon (container)
>>        /soc (ast2600-a1)
>>          [...]
>>          /ftgmac100[0] (ftgmac100)
>>            /ftgmac100[0] (qemu:memory-region)
>>          /ftgmac100[1] (ftgmac100)
>>     +      /ftgmac100[0] (qemu:memory-region)
>>          /ftgmac100[2] (ftgmac100)
>>     +      /ftgmac100[0] (qemu:memory-region)
>>          /ftgmac100[3] (ftgmac100)
>>     +      /ftgmac100[0] (qemu:memory-region)
>
> Yes. All are realized now.
>
>>          [...]
>>          /mii[0] (aspeed-mmi)
>>            /aspeed-mmi[0] (qemu:memory-region)
>>          /mii[1] (aspeed-mmi)
>>     +      /aspeed-mmi[0] (qemu:memory-region)
>>          /mii[2] (aspeed-mmi)
>>     +      /aspeed-mmi[0] (qemu:memory-region)
>>          /mii[3] (aspeed-mmi)
>>     +      /aspeed-mmi[0] (qemu:memory-region)
>
> Same for the MMI interfaces on AST2600.
>
>> These changes are due to realizing MAC1, MAC2, MAC3.  Looks good.
>>=20
>> Here's "info qtree":
>>=20
>>        dev: ftgmac100, id ""
>>          gpio-out "sysbus-irq" 1
>>          aspeed =3D true
>>     -    mac =3D "52:54:00:12:34:56"
>>     -    netdev =3D "hub0port0"
>>     +    mac =3D "52:54:00:12:34:57"
>>     +    netdev =3D ""
>>          mmio 000000001e660000/0000000000002000
>>        dev: ftgmac100, id ""
>>     -    aspeed =3D false
>>     -    mac =3D "00:00:00:00:00:00"
>>     +    gpio-out "sysbus-irq" 1
>>     +    aspeed =3D true
>>     +    mac =3D "52:54:00:12:34:58"
>>          netdev =3D ""
>>     +    mmio 000000001e680000/0000000000002000
>>        dev: ftgmac100, id ""
>>     -    aspeed =3D false
>>     -    mac =3D "00:00:00:00:00:00"
>>     -    netdev =3D ""
>>     +    gpio-out "sysbus-irq" 1
>>     +    aspeed =3D true
>>     +    mac =3D "52:54:00:12:34:56"
>>     +    netdev =3D "hub0port0"
>>     +    mmio 000000001e670000/0000000000002000
>>        dev: ftgmac100, id ""
>>     -    aspeed =3D false
>>     -    mac =3D "00:00:00:00:00:00"
>>     +    gpio-out "sysbus-irq" 1
>>     +    aspeed =3D true
>>     +    mac =3D "52:54:00:12:34:59"
>>          netdev =3D ""
>>     +    mmio 000000001e690000/0000000000002000
>>        [...]
>>        dev: aspeed-mmi, id ""
>>          mmio 000000001e650000/0000000000000008
>>        dev: aspeed-mmi, id ""
>>     +    mmio 000000001e650008/0000000000000008
>>        dev: aspeed-mmi, id ""
>>     +    mmio 000000001e650010/0000000000000008
>>        dev: aspeed-mmi, id ""
>>     +    mmio 000000001e650018/0000000000000008
>>=20
>> Here we can see the network backend now gets connected to MAC2 instead
>> of MAC0.
>
> yes.
>
> With only one nic on the command line, the backend was attached to the=20
> first (unused) MAC0 of the machine and now it is attached to the first=20
> active MAC2 of the machine.
>
>>=20
>> This is without any networking-related options, i.e. we get just the
>> single default network backend.
>>=20
>>> ---
>>>
>>>  To be applied on top of patch :
>>>
>>>  "arm/aspeed: Compute the number of CPUs from the SoC definition"=20
>>>  http://patchwork.ozlabs.org/project/qemu-devel/patch/20200519091631.10=
06073-1-clg@kaod.org/
>>>
>>>  Markus, do you mind taking this patch in your QOM series also ?
>>=20
>> On the contrary!
>>=20
>> I'll work my "info qom-tree" and "info qtree" diffs into the commit
>> message, if you don't mind.
>
> Sure.=20

Today, I hope.  Thanks!


