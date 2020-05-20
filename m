Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BE4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 06:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267DD207C4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 06:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bo2qbxZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267DD207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbID4-0008OV-D2
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 02:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jbICW-0007t6-8L
 for qemu-devel@nongnu.org; Wed, 20 May 2020 02:27:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59442
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jbICV-0005qC-5C
 for qemu-devel@nongnu.org; Wed, 20 May 2020 02:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589956054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRGr/V1Fo1fxrgW/hPXMbejWN60H8c1LZW5/vQKsb4I=;
 b=bo2qbxZatfsS7qsn0v9Db+w0zb1oY/cROWi2Xf3ld81hB155TonHOXM7vVAIJUwLY/VchC
 lI2dY0SpizKLekO6gyn6kMSRc1kD1f1YOXwLwQNphPNEgqciivArkrPdOG087dsthSOh9V
 fznUVYGXMKuNLlD0x4C7tnfbpeKrVEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-m53EhrshNk6rJS_RSjDyoQ-1; Wed, 20 May 2020 02:27:32 -0400
X-MC-Unique: m53EhrshNk6rJS_RSjDyoQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61A01464;
 Wed, 20 May 2020 06:27:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DB5282A24;
 Wed, 20 May 2020 06:27:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 80A5911358BC; Wed, 20 May 2020 08:27:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] arm/aspeed: Compute the number of CPUs from the SoC
 definition
References: <20200519091631.1006073-1-clg@kaod.org>
Date: Wed, 20 May 2020 08:27:28 +0200
In-Reply-To: <20200519091631.1006073-1-clg@kaod.org> (=?utf-8?Q?=22C=C3=A9?=
 =?utf-8?Q?dric?= Le Goater"'s
 message of "Tue, 19 May 2020 11:16:31 +0200")
Message-ID: <875zcrunn3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I figure this replaces my "[PATCH 05/24] aspeed: Don't create unwanted
"cortex-a7-arm-cpu" devices".  Correct?

Let's mention it gets rid of unrealized CPUs then.  Let me try.

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> Commit ece09beec457 ("aspeed: introduce a configurable number of CPU
> per machine") was a convient change during bringup but the Aspeed SoCs
> have a fixed number of CPUs : one for the AST2400 and AST2500, and two
> for the AST2600.

Please add something like:

  When the configured number of CPUs is less than the SoC's fixed
  number, the "unconfigured" CPUs are left unrealized.

> Remove the "num-cpu" property from the SoC state and use the fixed
> number of CPUs defined in the SoC class instead. Compute the default,
> min, max number of CPUs of the machine directly from the SoC class
> definition.

Suggest to add:

  Visible in "info qom-tree"; here's the change for ast2600-evb:

     /machine (ast2600-evb-machine)
       /peripheral (container)
       /peripheral-anon (container)
       /soc (ast2600-a1)
         /a7mpcore (a15mpcore_priv)
           /a15mp-priv-container[0] (qemu:memory-region)
           /gic (arm_gic)
             /gic_cpu[0] (qemu:memory-region)
             /gic_cpu[1] (qemu:memory-region)
    +        /gic_cpu[2] (qemu:memory-region)
             /gic_dist[0] (qemu:memory-region)
             /gic_vcpu[0] (qemu:memory-region)
             /gic_viface[0] (qemu:memory-region)
             /gic_viface[1] (qemu:memory-region)
    +        /gic_viface[2] (qemu:memory-region)
             /unnamed-gpio-in[0] (irq)
             [...]
    +        /unnamed-gpio-in[160] (irq)
             [same for 161 to 190...]
    +        /unnamed-gpio-in[191] (irq)

  Also visible in "info qtree"; here's the change for ast2600-evb:

     bus: main-system-bus
       type System
       dev: a15mpcore_priv, id ""
         gpio-in "" 128
    -    gpio-out "sysbus-irq" 5
    -    num-cpu =3D 1 (0x1)
    +    gpio-out "sysbus-irq" 10
    +    num-cpu =3D 2 (0x2)
         num-irq =3D 160 (0xa0)
         mmio 0000000040460000/0000000000008000
       dev: arm_gic, id ""
    -    gpio-in "" 160
    -    num-cpu =3D 1 (0x1)
    +    gpio-in "" 192
    +    num-cpu =3D 2 (0x2)
         num-irq =3D 160 (0xa0)
         revision =3D 2 (0x2)
         has-security-extensions =3D true
         has-virtualization-extensions =3D true
         num-priority-bits =3D 8 (0x8)
         mmio ffffffffffffffff/0000000000001000
         mmio ffffffffffffffff/0000000000002000
         mmio ffffffffffffffff/0000000000001000
         mmio ffffffffffffffff/0000000000002000
         mmio ffffffffffffffff/0000000000000100
    +    mmio ffffffffffffffff/0000000000000100
    +    mmio ffffffffffffffff/0000000000000200
         mmio ffffffffffffffff/0000000000000200

> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Patch looks good.

Preferably with an improved commit message:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

I'd like to pick your patch into v2 of my "Fixes around device
realization".  May I amend your commit message as shown above?


