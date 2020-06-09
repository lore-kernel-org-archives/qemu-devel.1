Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4D6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D8D2063A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5D8wRLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D8D2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiagX-0000OH-0d
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 05:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jiafP-0007sN-Pt
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 05:35:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59813
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jiafO-0002pR-UE
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 05:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591695334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAkIAYYcIXhXFgvFe2ChrXEyl9P97aTeXkxishXYaRQ=;
 b=Y5D8wRLR5n9h/f2Ak7SSqV4uXhY7eM2mOE9L0ggrixsCS+R0/Nul+KHJnuxURAhfgLp76+
 Z8x9o+pFJSkR+ZhU2isuS2ieBbtpLh4jlrbfsOAS8zhrCfD70y8qe2xUurLxBG9RqMHEpQ
 UQrp5VOno4u+RJFPYFiUUjHCg49XrB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-8-8_apDyN5yy21xlhZF71Q-1; Tue, 09 Jun 2020 05:35:20 -0400
X-MC-Unique: 8-8_apDyN5yy21xlhZF71Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B936107ACCA;
 Tue,  9 Jun 2020 09:35:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D57CD5C1C3;
 Tue,  9 Jun 2020 09:35:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 68F5211386A6; Tue,  9 Jun 2020 11:35:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 02/24] display/xlnx_dp: Fix to realize "i2c-ddc" and
 "aux-to-i2c-bridge"
References: <20200528110444.20456-1-armbru@redhat.com>
 <20200528110444.20456-3-armbru@redhat.com>
 <a64bd91c-58b5-1438-a401-5d6c04441c67@amsat.org>
 <87tuzkssri.fsf@dusky.pond.sub.org>
 <18c2da69-7d2b-59cb-619f-0f2d06cdedf4@amsat.org>
Date: Tue, 09 Jun 2020 11:35:16 +0200
In-Reply-To: <18c2da69-7d2b-59cb-619f-0f2d06cdedf4@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 9 Jun 2020 09:42:17
 +0200")
Message-ID: <87zh9cpoob.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 ehabkost@redhat.com, Alistair Francis <alistair@alistair23.me>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, pbonzini@redhat.com,
 KONRAD Frederic <fred.konrad@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 6/9/20 7:38 AM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>=20
>>> On 5/28/20 1:04 PM, Markus Armbruster wrote:
>>>> xlnx_dp_init() creates these two devices, but they're never realized.
>>>> Affects machine xlnx-zcu102.
>>>>
>>>> In theory, a device becomes real only on realize.  In practice, the
>>>> transition from unreal to real is a fuzzy one.  The work to make a
>>>> device real can be spread between realize methods (fine),
>>>> instance_init methods (wrong), and board code wiring up the device
>>>> (fine as long as it effectively happens on realize).  Depending on
>>>> what exactly is done where, a device can work even when we neglect to
>>>> realize it.
>>>>
>>>> These two appear to work.  Nevertheless, it's a clear misuse of the
>>>> interface.  Even when it works today (more or less by chance), it can
>>>> break tomorrow.
>>>>
>>>> Fix by realizing them in xlnx_dp_realize().
>>>>
>>>> Fixes: 58ac482a66de09a7590f705e53fc6a3fb8a055e8
>>>> Cc: KONRAD Frederic <fred.konrad@greensocs.com>
>>>> Cc: Alistair Francis <alistair@alistair23.me>
>>>> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
>>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>>> Cc: qemu-arm@nongnu.org
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>>> ---
>>>>  hw/display/xlnx_dp.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
>>>> index 3e5fb44e06..bdc229a51e 100644
>>>> --- a/hw/display/xlnx_dp.c
>>>> +++ b/hw/display/xlnx_dp.c
>>>> @@ -1264,9 +1264,13 @@ static void xlnx_dp_realize(DeviceState *dev, E=
rror **errp)
>>>>      DisplaySurface *surface;
>>>>      struct audsettings as;
>>>> =20
>>>> +    qdev_init_nofail(DEVICE(s->aux_bus->bridge));
>>>
>>> Eh??? Why not realize the bridge in aux_init_bus()?
>>=20
>> Because then aux_init_bus() is no longer "init", but "init and realize".
>> Instead: "[PATCH v2 32/58] auxbus: New aux_bus_realize(), pairing with
>> aux_bus_init()".  Okay?
>
> It would be easier to follow having aux_bus_realize() introduced first,

Point taken.

> then used it directly here. Anyway it is reviewed so I don't have a
> problem if this patch goes as it. Thanks.

Appreciated!

[...]


