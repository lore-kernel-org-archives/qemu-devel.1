Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8117EC432C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A89F20748
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cJEW0aP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A89F20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibnP6-0007Ip-HR
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 10:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibnO7-0006kA-6X
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:13:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibnO5-0003Jk-Nd
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:13:23 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42996)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibnO5-0003JQ-Hp
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:13:21 -0500
Received: by mail-oi1-x243.google.com with SMTP id j22so2370130oij.9
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 07:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=q51OprDEZ8c6nQUVqt2JoEFN8OvtbrXdTiVDSXhbGb8=;
 b=cJEW0aP8PES+gRwEKtGz9dMqSNPngYb7wJxUvc6U3MX0R3MK6oaIBXrjt5NpnBLS2V
 QRVYjRKIcD/C4n8b8eVh0k82J6h8bKWejbXYN2HqiKXUVK5zhqtgJQ98SvFRJHRuLhay
 z2g0Eee5QMcxbm0OmTKeU0QChgVZ/fdibiLQOlN9mtzmrHJ+owL1MA5nibYpslPpFMc1
 Xdrhex1QRTb7wZvM8Zhm2BbIVUyB9vujBN6cvutUuMG1/2lThoPCDm7uRqQq79TEPn46
 t56iO9NO+3fR7ZSipFxwXI3r++Og7Vz3MeFeyQmD0q+rbqxKSNAq9J1AlLeXMpxx0ASu
 8+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=q51OprDEZ8c6nQUVqt2JoEFN8OvtbrXdTiVDSXhbGb8=;
 b=s04vk1AEBBMd259al6bMgL/GUUlCM2MG5mnNaJ+2som8B5p+31Xsvmq2dubC2U1yUH
 rJfdOYZ2E2VwrSP5W/NUah7jshofiq2xisnSIbrl9GmeFy6CYbB+UIrfnpx3IC834LP4
 fILQshT6gnkGPWCduaWtP4m7xv01BGVHEOK7gvxglka/8f1Vmo4TxigbNP+nbVJJYt3K
 7epm/29PHIJrg3szrfOUmy0D84SfDj3bzD0klIudZR9Qu3VGk0w7kXKY0dTUTkX7WJ0q
 pfRGPWFjhi1L9bos+RfO7mB21ccqHTh7xWfQeGWOZgfE98sGSDXQj7Me3gFhYvn2MXsM
 ZyTg==
X-Gm-Message-State: APjAAAXSzQdgAg9zqlR7ROLjiFfLjB+5SouAk9UpQXzIyuW8j/CNiiAP
 OmIdle+UKd/K9KJJSy2pPGxXgOE+D7fkXY62UfTOCg==
X-Google-Smtp-Source: APXvYqz4OvS0zGSt6PTg0wSfxwNZcQHBi17DbYKQl2JSJckiTAcrFokpe7L1TyLVsKDftW8RaoEtoW9K8jVeRq2vZ2Q=
X-Received: by 2002:aca:f484:: with SMTP id s126mr9353276oih.48.1575299600734; 
 Mon, 02 Dec 2019 07:13:20 -0800 (PST)
MIME-Version: 1.0
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-6-damien.hedde@greensocs.com>
In-Reply-To: <20190904125531.27545-6-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2019 15:13:09 +0000
Message-ID: <CAFEAcA_Dc7K+NfVAScCk8MYykZ-VrbgJjJwFQCiQ3F7yyseNDQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] qdev-clock: introduce an init array to ease the
 device construction
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Sep 2019 at 13:56, Damien Hedde <damien.hedde@greensocs.com> wrot=
e:
>
> Introduce a function and macro helpers to setup several clocks
> in a device from a static array description.
>
> An element of the array describes the clock (name and direction) as
> well as the related callback and an optional offset to store the
> created object pointer in the device state structure.
>
> The array must be terminated by a special element QDEV_CLOCK_END.
>
> This is based on the original work of Frederic Konrad.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/core/qdev-clock.c    | 26 ++++++++++++++++
>  include/hw/qdev-clock.h | 67 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
>
> diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
> index bebdd8fa15..32ad45c061 100644
> --- a/hw/core/qdev-clock.c
> +++ b/hw/core/qdev-clock.c
> @@ -153,3 +153,29 @@ void qdev_connect_clock_out(DeviceState *dev, const =
char *name, ClockIn *clk,
>
>      clock_connect(clk, clkout);
>  }
> +
> +void qdev_init_clocks(DeviceState *dev, const ClockPortInitArray clocks)
> +{
> +    const struct ClockPortInitElem *elem;
> +
> +    assert(dev);
> +    assert(clocks);

More unnecessary asserts, I think.



> +/**
> + * ClockInitElem:
> + * @name: name of the clock (can't be NULL)
> + * @is_output: indicates whether the clock is input or output
> + * @callback: for inputs, optional callback to be called on clock's upda=
te
> + * with device as opaque
> + * @offset: optional offset to store the ClockIn or ClockOut pointer in =
device
> + * state structure (0 means unused)
> + */
> +struct ClockPortInitElem {
> +    const char *name;
> +    bool is_output;
> +    ClockCallback *callback;
> +    size_t offset;
> +};
> +
> +#define clock_offset_value(_type, _devstate, _field) \
> +    (offsetof(_devstate, _field) + \
> +     type_check(_type *, typeof_field(_devstate, _field)))

Avoid leading underscores, please.

> +
> +#define QDEV_CLOCK(_is_output, _type, _devstate, _field, _callback) { \
> +    .name =3D (stringify(_field)), \
> +    .is_output =3D _is_output, \
> +    .callback =3D _callback, \
> +    .offset =3D clock_offset_value(_type, _devstate, _field), \
> +}
> +
> +/**
> + * QDEV_CLOCK_(IN|OUT):
> + * @_devstate: structure type. @dev argument of qdev_init_clocks below m=
ust be
> + * a pointer to that same type.

It's a bit unclear what "below" here is referring to. Maybe
just have this be "@devstate: name of a C struct type"
and then explain below...

> + * @_field: a field in @_devstate (must be ClockIn* or ClockOut*)
> + * @_callback: (for input only) callback (or NULL) to be called with the=
 device
> + * state as argument
> + *

...here, where we can have a paragraph giving the purpose
of the macro:

"Define an entry in a ClockPortInitArray which is intended
to be passed to qdev_init_clocks(), which should be called
with an @dev argument which is a pointer to the @devstate
struct type."

> + * The name of the clock will be derived from @_field

Derived how? Guessing from the stringify(_field) above that it
will be the same as the field name ?

It makes sense to hardcode the opaque pointer for the callback to be
the device pointer.


> + */
> +#define QDEV_CLOCK_IN(_devstate, _field, _callback) \
> +    QDEV_CLOCK(false, ClockIn, _devstate, _field, _callback)
> +
> +#define QDEV_CLOCK_OUT(_devstate, _field) \
> +    QDEV_CLOCK(true, ClockOut, _devstate, _field, NULL)
> +
> +/**
> + * QDEV_CLOCK_IN_NOFIELD:
> + * @_name: name of the clock
> + * @_callback: callback (or NULL) to be called with the device state as =
argument
> + */
> +#define QDEV_CLOCK_IN_NOFIELD(_name, _callback) { \
> +    .name =3D _name, \
> +    .is_output =3D false, \
> +    .callback =3D _callback, \
> +    .offset =3D 0, \
> +}

When would we want to use this one ?

> +
> +#define QDEV_CLOCK_END { .name =3D NULL }
> +
> +typedef struct ClockPortInitElem ClockPortInitArray[];
> +
> +/**
> + * qdev_init_clocks:
> + * @dev: the device to add clocks

"to add clocks to"

> + * @clocks: a QDEV_CLOCK_END-terminated array which contains the
> + * clocks information.
> + */
> +void qdev_init_clocks(DeviceState *dev, const ClockPortInitArray clocks)=
;
> +
>  #endif /* QDEV_CLOCK_H */
> --
> 2.22.0
>

thanks
-- PMM

