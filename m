Received: from eggs.gnu.org ([2001:4830:134:3::10]:37421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIa7V-0002jT-GN
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIa7U-0004DW-IM
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:31:29 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:35954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIa7U-0004DR-CV
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:31:28 -0400
Received: by mail-wr0-x232.google.com with SMTP id v111so5479060wrc.3
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 05:31:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <878tlct0o3.fsf@dusky.pond.sub.org>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
	<20170531135709.345-6-marcandre.lureau@redhat.com>
	<878tlct0o3.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Jun 2017 13:31:06 +0100
Message-ID: <CAFEAcA8C2yfwJHyf63pWc5Sxbb+sbTeTpDJG6H4VYARwX=Yxcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 1 June 2017 at 12:19, Markus Armbruster <armbru@redhat.com> wrote:
> Lovely cleanup.
>
> The interesting part is the move of the bits controlling use of ->defval
> from Property member .qtype (set only by DEFINE_PROP_foo() macros) to
> its PropertyInfo method .info->set_default_value().  No functional
> change if (1) we preserve existing use of ->defval and (2) we don't add
> new uses of ->defval, or at least not uses that matter.
>
> Direction (1) is obvious for DEFINE_PROP_BIT(), DEFINE_PROP_BIT64(),
> DEFINE_PROP_BOOL().  They set .info to &qdev_prop_bit, &qdev_prop_bit64,
> &qdev_prop_bool, respectively.  These all get .set_default_value =
> set_default_value_bool, which preserves the effect of .qtype =
> QTYPE_BOOL.  Good.
>
> DEFINE_PROP_DEFAULT() sets .info to point to its argument _prop.  The
> following arguments occur:
>
> * In include/hw/qdev-properties.h: qdev_prop_uint8, qdev_prop_uint16,
>   qdev_prop_uint32, qdev_prop_int32, qdev_prop_uint64, qdev_prop_size,
>   qdev_prop_pci_devfn, qdev_prop_on_off_auto, qdev_prop_losttickpolicy,
>   qdev_prop_blockdev_on_error, qdev_prop_bios_chs_trans,
>   qdev_prop_blocksize
>
> * In hw/block/fdc.c: qdev_prop_fdc_drive_type
>
> * In hw/net/e1000e.c: local copies of qdev_prop_uint8, qdev_prop_uint16.
>
> To preserve the effect of .qtype = QTYPE_QINT, these PropertyInfo need
> .set_default_value = set_default_value_int or .set_default_value =
> set_default_value_enum, depending on .enum_table.  They get it.  Good.
>
> DEFINE_PROP_ARRAY() sets .info to &qdev_prop_arraylen.  Needs and gets
> .set_default_value = set_default_value_int.  Good.
>
> DEFINE_PROP_ARRAY() also takes a PropertyInfo argument, but it's not
> relevant here, as the .qtype you remove doesn't apply to it.  I'm
> mentioning this, because it confused me briefly.
>
> Direction (2) isn't as visible in the patch.  For each PropertyInfo you
> change, we need to find and check stores into .info not wrapped in the
> DEFINE_PROP_foo() macros you change.
>
> I can't find any.  Good.

I think this is going to break a patch I was halfway through
writing :-(

What I want is "DEFINE_PROP_UINT32, but don't set the default value"
(because the default value in this case (a) isn't constant and
(b) is already in the struct field that the property modifies).
My plan for doing this was:
 static Property arm_cpu_pmsav7_dregion_property =
    DEFINE_PROP("pmsav7-dregion", ARMCPU, pmsav7_dregion,
                qdev_prop_uint32, uint32_t);

This won't work any more if qdev_property_add_static
assumes that "qdev_prop_uint32" implies "always set the default value".
So how should I obtain those semantics with this cleanup in place ?

thanks
-- PMM
