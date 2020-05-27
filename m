Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5F0C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 13:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1C6207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 13:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pj1bMnHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1C6207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdwFT-0004Tn-Se
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 09:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdwEf-0003WY-MW
 for qemu-devel@nongnu.org; Wed, 27 May 2020 09:36:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51822
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdwEd-0002Gy-Ie
 for qemu-devel@nongnu.org; Wed, 27 May 2020 09:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590586601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZBuOzhkSMa4jTSlzlkfDTcaOnRT4FiitzG5grCTJKzY=;
 b=Pj1bMnHYDhSBCGme3bPf73KnB/a5mb/aWziTRaGrN2mDOsKBfYKMBV4Y9XQbNBIysYzgIq
 MA6pCo69tvJwgL2W1vW6mgQEPxL1MK7eM8IYkGFV71uuynWHwb/6uavxy+eUkF1aUJLepx
 Tk7czfKcPDYVnMqDvZo2WTJRsLIK+yk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-za3VZAiAOY-dNw7fSHrCgw-1; Wed, 27 May 2020 09:36:37 -0400
X-MC-Unique: za3VZAiAOY-dNw7fSHrCgw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 725D41005510;
 Wed, 27 May 2020 13:36:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB4AD5D9E5;
 Wed, 27 May 2020 13:36:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6891E113864A; Wed, 27 May 2020 15:36:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3] arm/aspeed: Rework NIC attachment
References: <20200527124406.329503-1-clg@kaod.org>
Date: Wed, 27 May 2020 15:36:33 +0200
In-Reply-To: <20200527124406.329503-1-clg@kaod.org> (=?utf-8?Q?=22C=C3=A9d?=
 =?utf-8?Q?ric?= Le Goater"'s
 message of "Wed, 27 May 2020 14:44:06 +0200")
Message-ID: <87lfldzehq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:49:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> The number of MACs supported by an Aspeed SoC is defined by "macs_num"
> under the SoC model, that is two for the AST2400 and AST2500 and four
> for the AST2600. The model initializes the maximum number of supported
> MACs but the number of realized devices is capped by the number of
> network device back-ends defined on the command line. This can leave
> unrealized devices hanging around in the QOM composition tree.
>
> Modify the machine initialization to define which MACs are attached to
> a network device back-end using a bit-field property "macs-mask" and
> let the SoC realize all network devices.
>
> The default setting of "macs-mask" is "use MAC0" only, which works for
> all our AST2400 and AST2500 machines. The AST2600 machines have
> different configurations. The AST2600 EVB machine activates MAC1, MAC2
> and MAC3 and the Tacoma BMC machine activates MAC2.

Let's be more clear on what this means, and "This is actually a device
modelling fix for these two machines."  Okay?

> Inactive MACs will have no peer and QEMU may warn the user with :
>
>     qemu-system-arm: warning: nic ftgmac100.0 has no peer
>     qemu-system-arm: warning: nic ftgmac100.1 has no peer
>     qemu-system-arm: warning: nic ftgmac100.3 has no peer
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Here's the "info qom-tree" change for tacoma-bmc:

     /machine (tacoma-bmc-machine)
       /peripheral (container)
       /peripheral-anon (container)
       /soc (ast2600-a1)
         [...]
         /ftgmac100[0] (ftgmac100)
           /ftgmac100[0] (qemu:memory-region)
         /ftgmac100[1] (ftgmac100)
    +      /ftgmac100[0] (qemu:memory-region)
         /ftgmac100[2] (ftgmac100)
    +      /ftgmac100[0] (qemu:memory-region)
         /ftgmac100[3] (ftgmac100)
    +      /ftgmac100[0] (qemu:memory-region)
         [...]
         /mii[0] (aspeed-mmi)
           /aspeed-mmi[0] (qemu:memory-region)
         /mii[1] (aspeed-mmi)
    +      /aspeed-mmi[0] (qemu:memory-region)
         /mii[2] (aspeed-mmi)
    +      /aspeed-mmi[0] (qemu:memory-region)
         /mii[3] (aspeed-mmi)
    +      /aspeed-mmi[0] (qemu:memory-region)

These changes are due to realizing MAC1, MAC2, MAC3.  Looks good.

Here's "info qtree":

       dev: ftgmac100, id ""
         gpio-out "sysbus-irq" 1
         aspeed =3D true
    -    mac =3D "52:54:00:12:34:56"
    -    netdev =3D "hub0port0"
    +    mac =3D "52:54:00:12:34:57"
    +    netdev =3D ""
         mmio 000000001e660000/0000000000002000
       dev: ftgmac100, id ""
    -    aspeed =3D false
    -    mac =3D "00:00:00:00:00:00"
    +    gpio-out "sysbus-irq" 1
    +    aspeed =3D true
    +    mac =3D "52:54:00:12:34:58"
         netdev =3D ""
    +    mmio 000000001e680000/0000000000002000
       dev: ftgmac100, id ""
    -    aspeed =3D false
    -    mac =3D "00:00:00:00:00:00"
    -    netdev =3D ""
    +    gpio-out "sysbus-irq" 1
    +    aspeed =3D true
    +    mac =3D "52:54:00:12:34:56"
    +    netdev =3D "hub0port0"
    +    mmio 000000001e670000/0000000000002000
       dev: ftgmac100, id ""
    -    aspeed =3D false
    -    mac =3D "00:00:00:00:00:00"
    +    gpio-out "sysbus-irq" 1
    +    aspeed =3D true
    +    mac =3D "52:54:00:12:34:59"
         netdev =3D ""
    +    mmio 000000001e690000/0000000000002000
       [...]
       dev: aspeed-mmi, id ""
         mmio 000000001e650000/0000000000000008
       dev: aspeed-mmi, id ""
    +    mmio 000000001e650008/0000000000000008
       dev: aspeed-mmi, id ""
    +    mmio 000000001e650010/0000000000000008
       dev: aspeed-mmi, id ""
    +    mmio 000000001e650018/0000000000000008

Here we can see the network backend now gets connected to MAC2 instead
of MAC0.

This is without any networking-related options, i.e. we get just the
single default network backend.

> ---
>
>  To be applied on top of patch :
>
>  "arm/aspeed: Compute the number of CPUs from the SoC definition"=20
>  http://patchwork.ozlabs.org/project/qemu-devel/patch/20200519091631.1006=
073-1-clg@kaod.org/
>
>  Markus, do you mind taking this patch in your QOM series also ?

On the contrary!

I'll work my "info qom-tree" and "info qtree" diffs into the commit
message, if you don't mind.


