Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF76C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 07:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989922071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 07:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAU2h5WE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989922071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd7GV-0003nO-RW
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 03:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jd7FE-0002YL-Cr
 for qemu-devel@nongnu.org; Mon, 25 May 2020 03:09:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51990
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jd7FC-0006xp-IX
 for qemu-devel@nongnu.org; Mon, 25 May 2020 03:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590390593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ANlVNtOlTC0ycej1WoTiAcxni43KHeGVrRD12xPwRUo=;
 b=FAU2h5WEh2l1tASu56X9UYsMA7YqzXMKls3BIyzjy4v241Ps7v+fJPofgIIlqeV+lw38xY
 ACHNghuc9WvEMicT1mEhBInq/Mi1MmRldM3IG9wFhwXkD0xDCXiqxmllzS5J4Htb74DENH
 G7G/gO/kyrg0D4LkNy7rJEWjlabKUeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-VKk1kW7QM6-WXJJL0UUGvw-1; Mon, 25 May 2020 03:09:32 -0400
X-MC-Unique: VKk1kW7QM6-WXJJL0UUGvw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBFF61005510;
 Mon, 25 May 2020 07:09:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 118675C1B2;
 Mon, 25 May 2020 07:09:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 77168113864A; Mon, 25 May 2020 09:09:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] arm/aspeed: Rework NIC attachment
References: <20200519161957.1056027-1-clg@kaod.org>
 <87zha3t8qg.fsf@dusky.pond.sub.org>
 <3ead6228-b61b-ca8b-6ebc-dd9299f1a334@kaod.org>
 <87367uobma.fsf@dusky.pond.sub.org>
 <836e30f9-d029-5ec9-3b05-b0d8541869ff@kaod.org>
Date: Mon, 25 May 2020 09:09:28 +0200
In-Reply-To: <836e30f9-d029-5ec9-3b05-b0d8541869ff@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Thu, 21 May 2020 09:36:05 +0200")
Message-ID: <87eer8fq3b.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:54:11
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

> On 5/20/20 5:43 PM, Markus Armbruster wrote:
>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>=20
>>> On 5/20/20 8:34 AM, Markus Armbruster wrote:
>>>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>>>
>>>>> The AST2400 and AST2500 SoCs have two MACs but only the first MAC0 is
>>>>> active on the Aspeed machines using these SoCs. The AST2600 has four
>>>>> MACs. The AST2600 EVB machine activates MAC1, MAC2 and MAC3 and the
>>>>> Tacoma BMC machine activates MAC2.
>>>>>
>>>>> Introduce a bit-field property "macs-mask" under the Aspeed SoC model
>>>>> to link the active MACs of the machine being started with the availab=
le
>>>>> network devices.
>>>>>
>>>>> Inactive MACs will have no peer and QEMU will warn the user with :
>>>>>
>>>>>     qemu-system-arm: warning: nic ftgmac100.0 has no peer
>>>>>     qemu-system-arm: warning: nic ftgmac100.1 has no peer
>>>>>     qemu-system-arm: warning: nic ftgmac100.3 has no peer
>>>>
>>>> I can't reproduce this warning.  What's your exact command line?
>>>
>>> Get a witherspoon-tacoma flash image :
>>>
>>>     $ wget https://openpower.xyz/job/openbmc-build/distro=3Dubuntu,labe=
l=3Dbuilder,target=3Dwitherspoon-tacoma/lastSuccessfulBuild/artifact/deploy=
/images/witherspoon-tacoma/flash-witherspoon-tacoma
>>>
>>> Run :
>>>
>>>     $ qemu-system-arm -M tacoma-bmc -nic user -drive file=3D./flash-wit=
herspoon-tacoma,format=3Draw,if=3Dmtd -nographic -nodefaults -serial mon:st=
dio
>>>     qemu-system-arm: warning: nic ftgmac100.0 has no peer
>>>     qemu-system-arm: warning: nic ftgmac100.1 has no peer
>>>     qemu-system-arm: warning: nic ftgmac100.3 has no peer
>>=20
>> I must have run the wrong binary somehow.
>>=20
>>>>
>>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>>> ---
>>>>>
>>>>>  To be applied on top of patch "arm/aspeed: Compute the number of CPU=
s
>>>>>  from the SoC definition"=20
>>>>> =20
>>>>>  http://patchwork.ozlabs.org/project/qemu-devel/patch/20200519091631.=
1006073-1-clg@kaod.org/
>>>>> =20
>>>>>  include/hw/arm/aspeed.h     |  1 +
>>>>>  include/hw/arm/aspeed_soc.h |  6 ++++++
>>>>>  hw/arm/aspeed.c             |  6 ++++++
>>>>>  hw/arm/aspeed_ast2600.c     | 11 ++++++++---
>>>>>  hw/arm/aspeed_soc.c         | 10 ++++++++--
>>>>>  5 files changed, 29 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
>>>>> index 18521484b90e..842dff485f5b 100644
>>>>> --- a/include/hw/arm/aspeed.h
>>>>> +++ b/include/hw/arm/aspeed.h
>>>>> @@ -39,6 +39,7 @@ typedef struct AspeedMachineClass {
>>>>>      const char *fmc_model;
>>>>>      const char *spi_model;
>>>>>      uint32_t num_cs;
>>>>> +    uint32_t macs_mask;
>>>>>      void (*i2c_init)(AspeedBoardState *bmc);
>>>>>  } AspeedMachineClass;
>>>>> =20
>>>>> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.=
h
>>>>> index 914115f3ef77..fdb9e05bc47c 100644
>>>>> --- a/include/hw/arm/aspeed_soc.h
>>>>> +++ b/include/hw/arm/aspeed_soc.h
>>>>> @@ -34,6 +34,11 @@
>>>>>  #define ASPEED_CPUS_NUM  2
>>>>>  #define ASPEED_MACS_NUM  4
>>>>> =20
>>>>> +#define ASPEED_MAC0_ON   (1 << 0)
>>>>> +#define ASPEED_MAC1_ON   (1 << 1)
>>>>> +#define ASPEED_MAC2_ON   (1 << 2)
>>>>> +#define ASPEED_MAC3_ON   (1 << 3)
>>>>> +
>>>>>  typedef struct AspeedSoCState {
>>>>>      /*< private >*/
>>>>>      DeviceState parent;
>>>>> @@ -55,6 +60,7 @@ typedef struct AspeedSoCState {
>>>>>      AspeedSDMCState sdmc;
>>>>>      AspeedWDTState wdt[ASPEED_WDTS_NUM];
>>>>>      FTGMAC100State ftgmac100[ASPEED_MACS_NUM];
>>>>> +    uint32_t macs_mask;
>>>>
>>>> What's the purpose of this member?  When and how would it be different
>>>> from AspeedMachineClass's macs_mask?
>>>
>>> Each machine activates a different set of MACs even if using the same S=
oC.
>>> So, the SoC macs_mask is overiden when the machine initializes the SoC =
in=20
>>> aspeed_machine_init().
>>=20
>> Let me try to rephrase my question below.
>>=20
>>> That said, I think the default SoC macs_mask should be all MACS, a valu=
e=20
>>> of 0xFFFFFFFF would be fine, and not only the first MAC as this patch d=
oes.
>>>
>>>>>      AspeedMiiState mii[ASPEED_MACS_NUM];
>>>>>      AspeedGPIOState gpio;
>>>>>      AspeedGPIOState gpio_1_8v;
>>>>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>>>>> index 6f8f4b88f8ab..79c683864d7e 100644
>>>>> --- a/hw/arm/aspeed.c
>>>>> +++ b/hw/arm/aspeed.c
>>>>> @@ -283,6 +283,8 @@ static void aspeed_machine_init(MachineState *mac=
hine)
>>>>>                              &error_abort);
>>>>>      object_property_set_int(OBJECT(&bmc->soc), amc->num_cs, "num-cs"=
,
>>>>>                              &error_abort);
>>>>> +    object_property_set_int(OBJECT(&bmc->soc), amc->macs_mask, "macs=
-mask",
>>>>> +                            &error_abort);
>>=20
>> Here, you set AspeedSocState member macs_mask to AspeedMachineClass
>> member macs_mask.
>
> yes. aspeed_machine_init() is common to all machines. AspeedMachineClass
> gathers the differences.
>
>>=20
>>>>>      object_property_set_link(OBJECT(&bmc->soc), OBJECT(&bmc->ram_con=
tainer),
>>>>>                               "dram", &error_abort);
>>>>>      if (machine->kernel_filename) {
>>>>> @@ -556,12 +558,14 @@ static int aspeed_soc_num_cpus(const char *soc_=
name)
>>>>>  static void aspeed_machine_class_init(ObjectClass *oc, void *data)
>>>>>  {
>>>>>      MachineClass *mc =3D MACHINE_CLASS(oc);
>>>>> +    AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);
>>>>> =20
>>>>>      mc->init =3D aspeed_machine_init;
>>>>>      mc->no_floppy =3D 1;
>>>>>      mc->no_cdrom =3D 1;
>>>>>      mc->no_parallel =3D 1;
>>>>>      mc->default_ram_id =3D "ram";
>>>>> +    amc->macs_mask =3D ASPEED_MAC0_ON;
>>=20
>> Abstract base type's .class_init() sets AspeedMachineClass's macs_mask
>> to "just first one".
>
> Yes. This covers all AST2400 and AST2500 machines. Only the AST2600=20
> use a different set of MACs.
> =20
>>=20
>>>>> =20
>>>>>      aspeed_machine_class_props_init(oc);
>>>>>  }
>>>>> @@ -680,6 +684,7 @@ static void aspeed_machine_ast2600_evb_class_init=
(ObjectClass *oc, void *data)
>>>>>      amc->fmc_model =3D "w25q512jv";
>>>>>      amc->spi_model =3D "mx66u51235f";
>>>>>      amc->num_cs    =3D 1;
>>>>> +    amc->macs_mask  =3D ASPEED_MAC1_ON | ASPEED_MAC2_ON | ASPEED_MAC=
3_ON;
>>>>>      amc->i2c_init  =3D ast2600_evb_i2c_init;
>>>>>      mc->default_ram_size =3D 1 * GiB;
>>>>>      mc->default_cpus =3D mc->min_cpus =3D mc->max_cpus =3D
>>>>> @@ -698,6 +703,7 @@ static void aspeed_machine_tacoma_class_init(Obje=
ctClass *oc, void *data)
>>>>>      amc->fmc_model =3D "mx66l1g45g";
>>>>>      amc->spi_model =3D "mx66l1g45g";
>>>>>      amc->num_cs    =3D 2;
>>>>> +    amc->macs_mask  =3D ASPEED_MAC2_ON;
>>>>>      amc->i2c_init  =3D witherspoon_bmc_i2c_init; /* Same board layou=
t */
>>>>>      mc->default_ram_size =3D 1 * GiB;
>>>>>      mc->default_cpus =3D mc->min_cpus =3D mc->max_cpus =3D
>>=20
>> Two concrete types' .class_init() override this default.
>
> yes.
> =20
>> Fine with me.
>>=20
>>>>> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
>>>>> index 114b94f8f44d..fa85122f6d78 100644
>>>>> --- a/hw/arm/aspeed_ast2600.c
>>>>> +++ b/hw/arm/aspeed_ast2600.c
>>>>> @@ -247,6 +247,7 @@ static void aspeed_soc_ast2600_realize(DeviceStat=
e *dev, Error **errp)
>>>>>      AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
>>>>>      Error *err =3D NULL, *local_err =3D NULL;
>>>>>      qemu_irq irq;
>>>>> +    NICInfo *nd =3D &nd_table[0];
>>>>> =20
>>>>>      /* IO space */
>>>>>      create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_I=
OMEM],
>>>>> @@ -462,8 +463,12 @@ static void aspeed_soc_ast2600_realize(DeviceSta=
te *dev, Error **errp)
>>>>>      }
>>>>> =20
>>>>>      /* Net */
>>>>> -    for (i =3D 0; i < nb_nics && i < sc->macs_num; i++) {
>>>>> -        qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), &nd_table[=
i]);
>>>>> +    for (i =3D 0; i < sc->macs_num; i++) {
>>>>> +        if ((s->macs_mask & (1 << i)) && nd->used) {
>>=20
>> This checks AspeedSocState's member.
>>
>>>>> +            qemu_check_nic_model(nd, TYPE_FTGMAC100);
>>>>> +            qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), nd);
>>>>> +            nd++;
>>>>> +        }
>>>>>          object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "as=
peed",
>>>>>                                   &err);
>>>>>          object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "re=
alized",
>>>>> @@ -471,7 +476,7 @@ static void aspeed_soc_ast2600_realize(DeviceStat=
e *dev, Error **errp)
>>>>>          error_propagate(&err, local_err);
>>>>>          if (err) {
>>>>>              error_propagate(errp, err);
>>>>> -           return;
>>>>> +            return;
>>>>>          }
>>>>>          sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
>>>>>                          sc->memmap[ASPEED_ETH1 + i]);
>>>>> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
>>>>> index 984d29087dce..d2c6a5760790 100644
>>>>> --- a/hw/arm/aspeed_soc.c
>>>>> +++ b/hw/arm/aspeed_soc.c
>>>>> @@ -234,6 +234,7 @@ static void aspeed_soc_realize(DeviceState *dev, =
Error **errp)
>>>>>      AspeedSoCState *s =3D ASPEED_SOC(dev);
>>>>>      AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
>>>>>      Error *err =3D NULL, *local_err =3D NULL;
>>>>> +    NICInfo *nd =3D &nd_table[0];
>>>>> =20
>>>>>      /* IO space */
>>>>>      create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_I=
OMEM],
>>>>> @@ -405,8 +406,12 @@ static void aspeed_soc_realize(DeviceState *dev,=
 Error **errp)
>>>>>      }
>>>>> =20
>>>>>      /* Net */
>>>>> -    for (i =3D 0; i < nb_nics && i < sc->macs_num; i++) {
>>>>> -        qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), &nd_table[=
i]);
>>>>> +    for (i =3D 0; i < sc->macs_num; i++) {
>>>>> +        if ((s->macs_mask & (1 << i)) && nd->used) {
>>=20
>> Likewise.
>>=20
>> Now my rephrased question: why do you need to store macs_mask both in
>> AspeedSoCState and in AspeedMachineClass?  As far as I can tell, their
>> values are the same for any given machine.
>
> yes, they are the same because the parent machine "propagates" the top=20
> level configuration to all sub-devices. The SoC is one of these and its=
=20
> initial settings are generic and do not make assumption on the machine=20
> characteristics.
>
> The general case is "use MAC0" only, which works for all AST2400 and
> AST2500 machines but the AST2600 machines have a different configuration.=
=20
>
> I agree there is some redundancy in this design pattern. What do you=20
> have in mind ?=20

I'd drop AspeedSoCState's copy of @macs_mask.  That way, readers don't
have to trace the data flow to find out that the two copies of
@macs_mask are actually identical.

This is not a demand.  Having two copies isn't wrong.  It's just mildly
confusing.

>>>>> +            qemu_check_nic_model(nd, TYPE_FTGMAC100);
>>>>> +            qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), nd);
>>>>> +            nd++;
>>>>> +        }
>>>>>          object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "as=
peed",
>>>>>                                   &err);
>>>>>          object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "re=
alized",
>>>>> @@ -455,6 +460,7 @@ static void aspeed_soc_realize(DeviceState *dev, =
Error **errp)
>>>>>                         aspeed_soc_get_irq(s, ASPEED_SDHCI));
>>>>>  }
>>>>>  static Property aspeed_soc_properties[] =3D {
>>>>> +    DEFINE_PROP_UINT32("macs-mask", AspeedSoCState, macs_mask, 0x1),
>>=20
>> Shouldn't this be ASPEED_MAC0_ON rather than 0x1?
>
> yes. or 0x0 ? and let the machine fully in charge of the configuration.

Works for me.

>> Hmm, isn't aspeed_machine_class_init()'s amc->macs_mask =3D ASPEED_MAC0_=
ON
>> redundant with this?
>
> yes. So 0x0 is better.
>
> Thanks,
>
> C.
>
>>=20
>>>>>      DEFINE_PROP_LINK("dram", AspeedSoCState, dram_mr, TYPE_MEMORY_RE=
GION,
>>>>>                       MemoryRegion *),
>>>>>      DEFINE_PROP_END_OF_LIST(),
>>>>
>>=20


