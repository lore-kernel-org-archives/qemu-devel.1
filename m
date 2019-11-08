Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ECBC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:45:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED7420659
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LkjUck8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED7420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5WK-0003tD-8U
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 09:45:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iT5UY-0002Ok-Qn
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iT5UW-0002C2-SF
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:44:02 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35320)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iT5UW-0002Bo-MB
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:44:00 -0500
Received: by mail-oi1-x244.google.com with SMTP id n16so5446548oig.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 06:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1yolX350RikgspNGqXnpbhsMD0ygO5qfrBMQwb1uQOE=;
 b=LkjUck8G6OTsye2KDLb/3YWOGM3eRJkjFeWCM9z2pjE3DQ8/NdrsM8PGq7U9dy2OCi
 O/YgCFf0SeDFOcfEZNmRwjKvtJw2RhH6QOYaL0W1efS7zTQed88y4YLLbvDs3WreGMYQ
 ZaxzetERmj5WoinrStEqgJMiR0zHOAQmrETL4DILgKKpCGVquzWqSd6SvTEaxNE7RfAX
 tzjzCQHM/kYy8k8pL3XBfaBIY0XTNl+5K00rkWqQW2r++l25ivevpuk1vFRPta4W5LuY
 3v9N+1XYBuNJAR2hSF6l2aRqkH0yfWe63qJ0Ktb4ncSfhWRM2TguYjD7gJgDMCZ2RQpD
 98IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1yolX350RikgspNGqXnpbhsMD0ygO5qfrBMQwb1uQOE=;
 b=PXtg1GqMXZ/pNV5xtm8ka30yv7hbCwAT5pjE/OyqFkLrwmINbsGob1qdIyX++VSDFa
 RHkqZkD3EEGpLhZs9PTKdx18zo1C1Bzwox7wpzNa+QISzh5iSEKAihbAem2Hqpf2W7T4
 dbSsPes+vDnfoOkOR6l64rF2zBB6i9hlY/ypvClKMrRQatjGrxk6dhINaC3n55hLXp2G
 9yGgs27AHsyaj7BHR9LN7fiP4qCH4rzYBor+1uAQI88CUvpfvIZQ9P5mLn5lBRr8d/Ag
 08Z13mkU/5gDg6IjEBSQc0RibdUGM2m5kNSFffr87gkF5T0d6udTsqO/IDYigmBDkrzd
 hJDg==
X-Gm-Message-State: APjAAAU74ZL+EgHueQk2nqD6BClhNBAzF6yxaJASY1w9jvzggEAZ3W8q
 A7EbmO74KTe6b8g56/g8NY13SN68XxJ6zlHDvaIoDg==
X-Google-Smtp-Source: APXvYqwUZgFlH1xjAqaqhUR3zUXHR5SpfUfvGghnpa8T32ZKF1LjGGgbALDJY5/Dasjb6L5O7OZBxk4RJww4eOTC89g=
X-Received: by 2002:a05:6808:7d1:: with SMTP id
 f17mr10273400oij.163.1573224239534; 
 Fri, 08 Nov 2019 06:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20191104131836.12566-1-alex.bennee@linaro.org>
In-Reply-To: <20191104131836.12566-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2019 14:43:48 +0000
Message-ID: <CAFEAcA-42Fg-ihBm3JVET41SJ1Mot7m-i1ZGt+Y1afOY1wZ0Ow@mail.gmail.com>
Subject: Re: [PATCH] tcg plugins: expose an API version concept
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 4 Nov 2019 at 13:18, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> This is a very simple versioning API which allows the plugin
> infrastructure to check the API a plugin was built against. We also
> expose a min/cur API version to the plugin via the info block in case
> it wants to avoid using old deprecated APIs in the future.

I think the general idea here is fine, and I want to see
us get the version-check into 4.2, because I don't think
we should release a QEMU which doesn't do a basic version
sanity check. I have some minor comments below.


> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  include/qemu/qemu-plugin.h | 19 +++++++++++++++++++
>  plugins/loader.c           | 15 +++++++++++++++
>  plugins/plugin.h           |  2 ++
>  tests/plugin/bb.c          |  2 ++
>  tests/plugin/empty.c       |  2 ++
>  tests/plugin/hotpages.c    |  2 ++
>  tests/plugin/howvec.c      |  2 ++
>  tests/plugin/insn.c        |  2 ++
>  tests/plugin/mem.c         |  2 ++
>  9 files changed, 48 insertions(+)
>
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index a00a7deb461..5502e112c81 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h

As an aside, is this the header file used for building
the plugins? It seems a bit odd to have put it
in include/qemu, which is for headers used when building
QEMU itself.

> @@ -38,9 +38,28 @@
>
>  typedef uint64_t qemu_plugin_id_t;
>
> +/*
> + * Versioning plugins:
> + *
> + * The plugin API will pass a minimum and current API version that
> + * QEMU currently supports. The minimum API will be incremented if an
> + * API needs to be deprecated.
> + *
> + * The plugins export the API they were built against by exposing the
> + * symbol qemu_plugin_version which can be checked.
> + */
> +
> +extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
> +
> +#define QEMU_PLUGIN_VERSION 0
> +
>  typedef struct {
>      /* string describing architecture */
>      const char *target_name;
> +    struct {
> +        int min;
> +        int cur;
> +    } version;
>      /* is this a full system emulation? */
>      bool system_emulation;
>      union {
> diff --git a/plugins/loader.c b/plugins/loader.c
> index ce724ed5839..1bcca909691 100644
> --- a/plugins/loader.c
> +++ b/plugins/loader.c
> @@ -178,6 +178,19 @@ static int plugin_load(struct qemu_plugin_desc *desc=
, const qemu_info_t *info)
>          goto err_symbol;
>      }
>
> +    if (!g_module_symbol(ctx->handle, "qemu_plugin_version", &sym)) {
> +        warn_report("%s: missing version %s", __func__, g_module_error()=
);

Failure to declare the required version should be an error,
not just a warning.

> +    } else {
> +        int version =3D *(int *)sym;
> +        if (version < QEMU_PLUGIN_MIN_VERSION ||
> +            version > QEMU_PLUGIN_VERSION) {
> +            error_report("%s: bad plugin version %d vs %d/%d",
> +                         __func__, version, QEMU_PLUGIN_MIN_VERSION,
> +                         QEMU_PLUGIN_VERSION);

I think this message is too cryptic, and would prefer
something more like:
 "TCG plugin %s requires API version %d, but this QEMU supports only
versions %d to %d"

where the first %s is the name of the plugin binary, not
the __func__ of this function (which is not useful to
the end user).

Better still, special case the MIN_VERSION =3D=3D VERSION
case to avoid saying "versions 1 to 1".

> +            goto err_symbol;
> +        }
> +    }
> +
>      qemu_rec_mutex_lock(&plugin.lock);
>
>      /* find an unused random id with &ctx as the seed */
> @@ -248,6 +261,8 @@ int qemu_plugin_load_list(QemuPluginList *head)
>      g_autofree qemu_info_t *info =3D g_new0(qemu_info_t, 1);
>
>      info->target_name =3D TARGET_NAME;
> +    info->version.min =3D QEMU_PLUGIN_MIN_VERSION;
> +    info->version.cur =3D QEMU_PLUGIN_VERSION;
>  #ifndef CONFIG_USER_ONLY
>      MachineState *ms =3D MACHINE(qdev_get_machine());
>      info->system_emulation =3D true;

thanks
-- PMM

