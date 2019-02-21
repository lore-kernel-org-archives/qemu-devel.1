Received: from eggs.gnu.org ([209.51.188.92]:47818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwtCu-0003Kj-M8
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwtCt-0004A3-MI
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:36:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwtCs-000476-Tj
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:36:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so31725857wrw.5
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 10:36:26 -0800 (PST)
References: <1550748288-30598-1-git-send-email-thuth@redhat.com>
	<895254c7-745e-e594-ceed-df09a1dc84c5@redhat.com>
	<4f733c0a-a502-f9b9-7d78-d1833744d366@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5a2b7368-bff5-ed38-00ea-d96186ebf862@redhat.com>
Date: Thu, 21 Feb 2019 19:36:22 +0100
MIME-Version: 1.0
In-Reply-To: <4f733c0a-a502-f9b9-7d78-d1833744d366@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/ppc: Use object_initialize_child for
 correct reference counting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org

On 2/21/19 7:17 PM, Cédric Le Goater wrote:
> On 2/21/19 7:14 PM, Philippe Mathieu-Daudé wrote:
>> On 2/21/19 12:24 PM, Thomas Huth wrote:
>>> Both functions, object_initialize() and object_property_add_child() increase
>>> the reference counter of the new object, so one of the references has to be
>>> dropped afterwards to get the reference counting right. Otherwise the child
>>> object will not be properly cleaned up when the parent gets destroyed.
>>> Thus let's use now object_initialize_child() instead to get the reference
>>> counting here right.
>>>
>>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  hw/ppc/pnv.c     | 12 ++++++------
>>>  hw/ppc/pnv_psi.c |  4 ++--
>>>  hw/ppc/spapr.c   |  6 +++---
>>>  3 files changed, 11 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>>> index da54086..9e03e9c 100644
>>> --- a/hw/ppc/pnv.c
>>> +++ b/hw/ppc/pnv.c
>>> @@ -736,18 +736,18 @@ static void pnv_chip_power8_instance_init(Object *obj)
>>>  {
>>>      Pnv8Chip *chip8 = PNV8_CHIP(obj);
>>>  
>>> -    object_initialize(&chip8->psi, sizeof(chip8->psi), TYPE_PNV_PSI);
>>> -    object_property_add_child(obj, "psi", OBJECT(&chip8->psi), NULL);
>>> +    object_initialize_child(obj, "psi",  &chip8->psi, sizeof(chip8->psi),
>>> +                            TYPE_PNV_PSI, &error_abort, NULL);
>>>      object_property_add_const_link(OBJECT(&chip8->psi), "xics",
>>>                                     OBJECT(qdev_get_machine()), &error_abort);
>>>  
>>> -    object_initialize(&chip8->lpc, sizeof(chip8->lpc), TYPE_PNV_LPC);
>>> -    object_property_add_child(obj, "lpc", OBJECT(&chip8->lpc), NULL);
>>> +    object_initialize_child(obj, "lpc",  &chip8->lpc, sizeof(chip8->lpc),
>>> +                            TYPE_PNV_LPC, &error_abort, NULL);
>>>      object_property_add_const_link(OBJECT(&chip8->lpc), "psi",
>>>                                     OBJECT(&chip8->psi), &error_abort);
>>>  
>>> -    object_initialize(&chip8->occ, sizeof(chip8->occ), TYPE_PNV_OCC);
>>> -    object_property_add_child(obj, "occ", OBJECT(&chip8->occ), NULL);
>>> +    object_initialize_child(obj, "occ",  &chip8->occ, sizeof(chip8->occ),
>>> +                            TYPE_PNV_OCC, &error_abort, NULL);
>>>      object_property_add_const_link(OBJECT(&chip8->occ), "psi",
>>>                                     OBJECT(&chip8->psi), &error_abort);
>>>  }
>>> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
>>> index 8ced095..44bc0cb 100644
>>> --- a/hw/ppc/pnv_psi.c
>>> +++ b/hw/ppc/pnv_psi.c
>>> @@ -444,8 +444,8 @@ static void pnv_psi_init(Object *obj)
>>>  {
>>>      PnvPsi *psi = PNV_PSI(obj);
>>>  
>>> -    object_initialize(&psi->ics, sizeof(psi->ics), TYPE_ICS_SIMPLE);
>>> -    object_property_add_child(obj, "ics-psi", OBJECT(&psi->ics), NULL);
>>> +    object_initialize_child(obj, "ics-psi",  &psi->ics, sizeof(psi->ics),
>>> +                            TYPE_ICS_SIMPLE, &error_abort, NULL);
>>>  }
>>>  
>>>  static const uint8_t irq_to_xivr[] = {
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index abf9ebc..6c58dca 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -1696,9 +1696,9 @@ static void spapr_create_nvram(sPAPRMachineState *spapr)
>>>  
>>>  static void spapr_rtc_create(sPAPRMachineState *spapr)
>>>  {
>>> -    object_initialize(&spapr->rtc, sizeof(spapr->rtc), TYPE_SPAPR_RTC);
>>> -    object_property_add_child(OBJECT(spapr), "rtc", OBJECT(&spapr->rtc),
>>> -                              &error_fatal);
>>> +    object_initialize_child(OBJECT(spapr), "rtc",
>>> +                            &spapr->rtc, sizeof(spapr->rtc), TYPE_SPAPR_RTC,
>>> +                            &error_fatal, NULL);
>>>      object_property_set_bool(OBJECT(&spapr->rtc), true, "realized",
>>>                                &error_fatal);
>>>      object_property_add_alias(OBJECT(spapr), "rtc-time", OBJECT(&spapr->rtc),
>>>
>>
>> What about intc/spapr_xive.c?
> 
> I have used the same pattern in many files :) In ARM also.

OK, tested a cocci script so will send a patch.

Regards,

Phil.
