Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7272EC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD7420674
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="1uvJNFWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD7420674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icTYh-0005S9-8D
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1icST7-0002Ic-Dv
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:05:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1icSSu-0000I6-T7
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:05:09 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:44230)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1icSSi-0007Mo-8r; Wed, 04 Dec 2019 06:04:53 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id A476D96EF0;
 Wed,  4 Dec 2019 11:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575457483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hcjwxM4UObU02Iu0FnUFEfgmhSEGsz5B6l28uOEWu2U=;
 b=1uvJNFWEMFotdydoqOGFrDvv/196PrbDBQalc4K9pVlXsGCmQtjKOK2xOFpH8fagwYtzBf
 nz4qX9BQtv92JW+ViG8XeQkY/JQ72MaJwxEMHuLkFzLBZBwNoEoWXHnUgxsCwWiqrVxWPK
 sL/M3+QFGiZwHcJ09A2/VDI6la7QFyQ=
Subject: Re: [PATCH v6 5/9] qdev-clock: introduce an init array to ease the
 device construction
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-6-damien.hedde@greensocs.com>
 <CAFEAcA_Dc7K+NfVAScCk8MYykZ-VrbgJjJwFQCiQ3F7yyseNDQ@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <102dda6f-ca2d-7d16-0a65-8f6d5a6d1d46@greensocs.com>
Date: Wed, 4 Dec 2019 12:04:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Dc7K+NfVAScCk8MYykZ-VrbgJjJwFQCiQ3F7yyseNDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575457483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hcjwxM4UObU02Iu0FnUFEfgmhSEGsz5B6l28uOEWu2U=;
 b=rVwR/jUlT7f/nrP/jeiZzwLoeaVKbTGAbtVgjWOOSJkz+T3XKLsYSe1v9hCdRaGGF4I/Ob
 sulxMi3qF/yBiUCqOsgSHRXTf3WgtgvPWR/h5turZ2ncYRn+Sx9cPSa5XmN60qpCdJIGEN
 xNQtVwmZy5B1eN4ctPh8NofjwEYLGBA=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575457483; a=rsa-sha256; cv=none;
 b=Oqs2WeakP7YcTe0+dleEMc/eRA3F9RRrNMMczPRsT5NuYJCdCVJPSv0gIIu6NEC1ElX3XY
 Rg1HC6j38PTiO1aarrSKB508ta64OFjrj4OM4LxLog/slhLbit0jRQleMVkTWZ0gq5OfYP
 OFOjdB4XZLwWBRmTRU7mnmBS2PuxXAI=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/2/19 4:13 PM, Peter Maydell wrote:
> On Wed, 4 Sep 2019 at 13:56, Damien Hedde <damien.hedde@greensocs.com> =
wrote:
>>
>> Introduce a function and macro helpers to setup several clocks
>> in a device from a static array description.
>>
>> An element of the array describes the clock (name and direction) as
>> well as the related callback and an optional offset to store the
>> created object pointer in the device state structure.
>>
>> The array must be terminated by a special element QDEV_CLOCK_END.
>>
>> This is based on the original work of Frederic Konrad.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  hw/core/qdev-clock.c    | 26 ++++++++++++++++
>>  include/hw/qdev-clock.h | 67 ++++++++++++++++++++++++++++++++++++++++=
+
>>  2 files changed, 93 insertions(+)
>>
>> diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
>> index bebdd8fa15..32ad45c061 100644
>> --- a/hw/core/qdev-clock.c
>> +++ b/hw/core/qdev-clock.c
>> @@ -153,3 +153,29 @@ void qdev_connect_clock_out(DeviceState *dev, con=
st char *name, ClockIn *clk,
>>
>>      clock_connect(clk, clkout);
>>  }
>> +
>> +void qdev_init_clocks(DeviceState *dev, const ClockPortInitArray cloc=
ks)
>> +{
>> +    const struct ClockPortInitElem *elem;
>> +
>> +    assert(dev);
>> +    assert(clocks);
>=20
> More unnecessary asserts, I think.
>=20
>=20
>=20
>> +/**
>> + * ClockInitElem:
>> + * @name: name of the clock (can't be NULL)
>> + * @is_output: indicates whether the clock is input or output
>> + * @callback: for inputs, optional callback to be called on clock's u=
pdate
>> + * with device as opaque
>> + * @offset: optional offset to store the ClockIn or ClockOut pointer =
in device
>> + * state structure (0 means unused)
>> + */
>> +struct ClockPortInitElem {
>> +    const char *name;
>> +    bool is_output;
>> +    ClockCallback *callback;
>> +    size_t offset;
>> +};
>> +
>> +#define clock_offset_value(_type, _devstate, _field) \
>> +    (offsetof(_devstate, _field) + \
>> +     type_check(_type *, typeof_field(_devstate, _field)))
>=20
> Avoid leading underscores, please.
>=20
>> +
>> +#define QDEV_CLOCK(_is_output, _type, _devstate, _field, _callback) {=
 \
>> +    .name =3D (stringify(_field)), \
>> +    .is_output =3D _is_output, \
>> +    .callback =3D _callback, \
>> +    .offset =3D clock_offset_value(_type, _devstate, _field), \
>> +}
>> +
>> +/**
>> + * QDEV_CLOCK_(IN|OUT):
>> + * @_devstate: structure type. @dev argument of qdev_init_clocks belo=
w must be
>> + * a pointer to that same type.
>=20
> It's a bit unclear what "below" here is referring to. Maybe
> just have this be "@devstate: name of a C struct type"
> and then explain below...
>=20
>> + * @_field: a field in @_devstate (must be ClockIn* or ClockOut*)
>> + * @_callback: (for input only) callback (or NULL) to be called with =
the device
>> + * state as argument
>> + *
>=20
> ...here, where we can have a paragraph giving the purpose
> of the macro:
>=20
> "Define an entry in a ClockPortInitArray which is intended
> to be passed to qdev_init_clocks(), which should be called
> with an @dev argument which is a pointer to the @devstate
> struct type."

Sounds good.

>=20
>> + * The name of the clock will be derived from @_field
>=20
> Derived how? Guessing from the stringify(_field) above that it
> will be the same as the field name ?

yes.

>=20
> It makes sense to hardcode the opaque pointer for the callback to be
> the device pointer.
>=20
>=20
>> + */
>> +#define QDEV_CLOCK_IN(_devstate, _field, _callback) \
>> +    QDEV_CLOCK(false, ClockIn, _devstate, _field, _callback)
>> +
>> +#define QDEV_CLOCK_OUT(_devstate, _field) \
>> +    QDEV_CLOCK(true, ClockOut, _devstate, _field, NULL)
>> +
>> +/**
>> + * QDEV_CLOCK_IN_NOFIELD:
>> + * @_name: name of the clock
>> + * @_callback: callback (or NULL) to be called with the device state =
as argument
>> + */
>> +#define QDEV_CLOCK_IN_NOFIELD(_name, _callback) { \
>> +    .name =3D _name, \
>> +    .is_output =3D false, \
>> +    .callback =3D _callback, \
>> +    .offset =3D 0, \
>> +}
>=20
> When would we want to use this one ?

If the callback interaction is enough, we don't need to access the clock
object directly. So we don't need the field in the device state
structure. I can remove this macro for sake of simplicity.

--
Damien

