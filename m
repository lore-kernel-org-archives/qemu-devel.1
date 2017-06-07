Received: from eggs.gnu.org ([2001:4830:134:3::10]:48947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIail-0005YF-Nh
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIaii-0006El-Gd
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:09:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dIaii-0006DE-8L
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:09:56 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
	<20170531135709.345-6-marcandre.lureau@redhat.com>
	<878tlct0o3.fsf@dusky.pond.sub.org>
	<CAFEAcA8C2yfwJHyf63pWc5Sxbb+sbTeTpDJG6H4VYARwX=Yxcw@mail.gmail.com>
Date: Wed, 07 Jun 2017 15:09:51 +0200
In-Reply-To: <CAFEAcA8C2yfwJHyf63pWc5Sxbb+sbTeTpDJG6H4VYARwX=Yxcw@mail.gmail.com>
	(Peter Maydell's message of "Wed, 7 Jun 2017 13:31:06 +0100")
Message-ID: <87fufct04g.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 05/45] qdev: remove PropertyInfo.qtype
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 1 June 2017 at 12:19, Markus Armbruster <armbru@redhat.com> wrote:
>> Lovely cleanup.
>>
>> The interesting part is the move of the bits controlling use of ->defval
>> from Property member .qtype (set only by DEFINE_PROP_foo() macros) to
>> its PropertyInfo method .info->set_default_value().  No functional
>> change if (1) we preserve existing use of ->defval and (2) we don't add
>> new uses of ->defval, or at least not uses that matter.
>>
>> Direction (1) is obvious for DEFINE_PROP_BIT(), DEFINE_PROP_BIT64(),
>> DEFINE_PROP_BOOL().  They set .info to &qdev_prop_bit, &qdev_prop_bit64,
>> &qdev_prop_bool, respectively.  These all get .set_default_value =
>> set_default_value_bool, which preserves the effect of .qtype =
>> QTYPE_BOOL.  Good.
>>
>> DEFINE_PROP_DEFAULT() sets .info to point to its argument _prop.  The
>> following arguments occur:
>>
>> * In include/hw/qdev-properties.h: qdev_prop_uint8, qdev_prop_uint16,
>>   qdev_prop_uint32, qdev_prop_int32, qdev_prop_uint64, qdev_prop_size,
>>   qdev_prop_pci_devfn, qdev_prop_on_off_auto, qdev_prop_losttickpolicy,
>>   qdev_prop_blockdev_on_error, qdev_prop_bios_chs_trans,
>>   qdev_prop_blocksize
>>
>> * In hw/block/fdc.c: qdev_prop_fdc_drive_type
>>
>> * In hw/net/e1000e.c: local copies of qdev_prop_uint8, qdev_prop_uint16.
>>
>> To preserve the effect of .qtype = QTYPE_QINT, these PropertyInfo need
>> .set_default_value = set_default_value_int or .set_default_value =
>> set_default_value_enum, depending on .enum_table.  They get it.  Good.
>>
>> DEFINE_PROP_ARRAY() sets .info to &qdev_prop_arraylen.  Needs and gets
>> .set_default_value = set_default_value_int.  Good.
>>
>> DEFINE_PROP_ARRAY() also takes a PropertyInfo argument, but it's not
>> relevant here, as the .qtype you remove doesn't apply to it.  I'm
>> mentioning this, because it confused me briefly.
>>
>> Direction (2) isn't as visible in the patch.  For each PropertyInfo you
>> change, we need to find and check stores into .info not wrapped in the
>> DEFINE_PROP_foo() macros you change.
>>
>> I can't find any.  Good.
>
> I think this is going to break a patch I was halfway through
> writing :-(
>
> What I want is "DEFINE_PROP_UINT32, but don't set the default value"
> (because the default value in this case (a) isn't constant and
> (b) is already in the struct field that the property modifies).
> My plan for doing this was:
>  static Property arm_cpu_pmsav7_dregion_property =
>     DEFINE_PROP("pmsav7-dregion", ARMCPU, pmsav7_dregion,
>                 qdev_prop_uint32, uint32_t);
>
> This won't work any more if qdev_property_add_static
> assumes that "qdev_prop_uint32" implies "always set the default value".

After this patch, qdev_property_add_static() delegates assigning a
default value to prop->info->set_default_value(obj, prop).

qdev_prop_uint32.set_default_value() assigns prop->defval.

> So how should I obtain those semantics with this cleanup in place ?

Two ways come to mind:

* Define a PropertyInfo like qdev_prop_uint32 with a null
  set_default_value(), and use that.

* Add a flag to Property that makes qdev_property_add_static() skip
  prop->info->set_default_value(), set it for your property.

  Actually, I'd probably do it the other way: call ->set_default_value()
  only when the flag is set.  No need to check it's non-null then.
  Setting the flag when it's null is a programming error.

Could one of these two work for you?
