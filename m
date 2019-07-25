Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7355EC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C2F2238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJ3MhIGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C2F2238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfXT-0000io-I5
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46202)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hqfXH-0000Fv-TO
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hqfXF-0002Pr-Ca
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:20:03 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hqfX5-0002LZ-9Z
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:19:53 -0400
Received: by mail-wr1-x441.google.com with SMTP id f9so51175501wre.12
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iC4cdz0gyiED1wyHU4WXRGYjRT/rND4cde3G+j1Grng=;
 b=GJ3MhIGIZwVssmgFqHBUryq0b8mXoNc7JF08elMCdli/fW2fTb5XItEZ2GqLIBYLZI
 L/tfns4LuzXb9MFK5RC3B2h8HY0dvT9hIwI1bEvOwPViCaCWm60vqmZTTZdPyakmObL8
 JBvlSLUe50M2IQyumIBIIUMJzO5ULvTZQCLlRphNcQ3/BYaI0oFe7V2hPoIurcBhDkOu
 oq1bBdSKlvuogY6LYPY9UdVuS0+WmRyj8xX6Cqq+yroVxjmMs2lk1vxTxAYBDVKOVefF
 kHFPTkfIweFcTngbJs31r67szE2E2ewXklckfiNfEVdXFuFN9MHOK9vRHL6Y2fToEM9x
 FwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iC4cdz0gyiED1wyHU4WXRGYjRT/rND4cde3G+j1Grng=;
 b=FEzvicNPo3VJDnKDcNYUwIfdyvelMINwiJ9WnyamP3a+gImAdJQ90ugg9Xwik0qXTc
 iNCcbP+J0nQFrKdeP+uPSLa4Dh+ArJwniVBPbo5g45Z4rvi3zK0y1cb8DWJsSbzhztTC
 kQE5TRVyl8iVGkNepvfAwTeCayDiWUnq5538AAGHKFhIKfegHr8NfBl0uIbyqzMpJajN
 vpvtmH8e+wHRuS/zA7hxvWPjg8vFEW++zXn2UmNUgq/YzlNoQ50IRxKYMc/xcLZ0cBqx
 rgZAAqYls0bYmWXNLSnv9wOWExKQw57nu4wLDny3WD+4GJQHyN7x9kDC7+WE88LAW/Io
 R/Rg==
X-Gm-Message-State: APjAAAXtw49XR5GRj8YbB25ras5QE52F7LYfXkkb6+wDeisKKezS78MH
 nFjTrwqsPHiAikAX4l0WP/G+JSfB9SM8/pRdtEI=
X-Google-Smtp-Source: APXvYqwZKdPk1ur7FCmwG/NwhXrUn4g9Uuo3zRqVTucAhSDVw+knsyztKNBdiact9WFXCDqUu8S0aIRRXUwOZ2krRJs=
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr93803425wrm.100.1564067984856; 
 Thu, 25 Jul 2019 08:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190725150832.1180275-1-stefanb@linux.vnet.ibm.com>
 <20190725150832.1180275-3-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20190725150832.1180275-3-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 25 Jul 2019 19:19:32 +0400
Message-ID: <CAJ+F1C+KaTLPztGr3PZKJbFQRaHmY12PU3gzqiQwua+seanVNw@mail.gmail.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2 2/2] tpm_emulator: Translate TPM error
 codes to strings
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
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 25, 2019 at 7:08 PM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> Implement a function to translate TPM error codes to strings so that
> at least the most common error codes can be translated to human
> readable strings.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/tpm/tpm_emulator.c | 60 +++++++++++++++++++++++++++++++++++--------
>  hw/tpm/tpm_int.h      | 13 ++++++++++
>  2 files changed, 63 insertions(+), 10 deletions(-)
>
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 1288cbcb8d..fc0b512f4f 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -82,6 +82,40 @@ typedef struct TPMEmulator {
>      TPMBlobBuffers state_blobs;
>  } TPMEmulator;
>
> +struct tpm_error {
> +    uint32_t tpm_result;
> +    const char *string;
> +};
> +
> +static const struct tpm_error tpm_errors[] =3D {
> +    /* TPM 1.2 error codes */
> +    { TPM_BAD_PARAMETER   , "a parameter is bad" },
> +    { TPM_FAIL            , "operation failed" },
> +    { TPM_KEYNOTFOUND     , "key could not be found" },
> +    { TPM_BAD_PARAM_SIZE  , "bad parameter size"},
> +    { TPM_ENCRYPT_ERROR   , "encryption error" },
> +    { TPM_DECRYPT_ERROR   , "decryption error" },
> +    { TPM_BAD_KEY_PROPERTY, "bad key property" },
> +    { TPM_BAD_MODE        , "bad (encryption) mode" },
> +    { TPM_BAD_VERSION     , "bad version identifier" },
> +    { TPM_BAD_LOCALITY    , "bad locality" },
> +    /* TPM 2 error codes */
> +    { TPM_RC_FAILURE     , "operation failed" },
> +    { TPM_RC_LOCALITY    , "bad locality"     },
> +    { TPM_RC_INSUFFICIENT, "insufficient amount of data" },
> +};
> +
> +static const char *tpm_emulator_strerror(uint32_t tpm_result)
> +{
> +    size_t i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(tpm_errors); i++) {
> +        if (tpm_errors[i].tpm_result =3D=3D tpm_result) {
> +            return tpm_errors[i].string;
> +        }
> +    }
> +    return "";
> +}
>
>  static int tpm_emulator_ctrlcmd(TPMEmulator *tpm, unsigned long cmd, voi=
d *msg,
>                                  size_t msg_len_in, size_t msg_len_out)
> @@ -264,7 +298,8 @@ static int tpm_emulator_stop_tpm(TPMBackend *tb)
>
>      res =3D be32_to_cpu(res);
>      if (res) {
> -        error_report("tpm-emulator: TPM result for CMD_STOP: 0x%x", res)=
;
> +        error_report("tpm-emulator: TPM result for CMD_STOP: 0x%x %s", r=
es,
> +                     tpm_emulator_strerror(res));
>          return -1;
>      }
>
> @@ -293,8 +328,9 @@ static int tpm_emulator_set_buffer_size(TPMBackend *t=
b,
>
>      psbs.u.resp.tpm_result =3D be32_to_cpu(psbs.u.resp.tpm_result);
>      if (psbs.u.resp.tpm_result !=3D 0) {
> -        error_report("tpm-emulator: TPM result for set buffer size : 0x%=
x",
> -                     psbs.u.resp.tpm_result);
> +        error_report("tpm-emulator: TPM result for set buffer size : 0x%=
x %s",
> +                     psbs.u.resp.tpm_result,
> +                     tpm_emulator_strerror(psbs.u.resp.tpm_result));
>          return -1;
>      }
>
> @@ -339,7 +375,8 @@ static int tpm_emulator_startup_tpm_resume(TPMBackend=
 *tb, size_t buffersize,
>
>      res =3D be32_to_cpu(init.u.resp.tpm_result);
>      if (res) {
> -        error_report("tpm-emulator: TPM result for CMD_INIT: 0x%x", res)=
;
> +        error_report("tpm-emulator: TPM result for CMD_INIT: 0x%x %s", r=
es,
> +                     tpm_emulator_strerror(res));
>          goto err_exit;
>      }
>      return 0;
> @@ -399,8 +436,9 @@ static int tpm_emulator_reset_tpm_established_flag(TP=
MBackend *tb,
>
>      res =3D be32_to_cpu(reset_est.u.resp.tpm_result);
>      if (res) {
> -        error_report("tpm-emulator: TPM result for rest establixhed flag=
: 0x%x",
> -                     res);
> +        error_report(
> +            "tpm-emulator: TPM result for rest established flag: 0x%x %s=
",
> +            res, tpm_emulator_strerror(res));
>          return -1;
>      }
>
> @@ -638,7 +676,8 @@ static int tpm_emulator_get_state_blob(TPMEmulator *t=
pm_emu,
>      res =3D be32_to_cpu(pgs.u.resp.tpm_result);
>      if (res !=3D 0 && (res & 0x800) =3D=3D 0) {
>          error_report("tpm-emulator: Getting the stateblob (type %d) fail=
ed "
> -                     "with a TPM error 0x%x", type, res);
> +                     "with a TPM error 0x%x %s", type, res,
> +                     tpm_emulator_strerror(res));
>          return -1;
>      }
>
> @@ -758,7 +797,8 @@ static int tpm_emulator_set_state_blob(TPMEmulator *t=
pm_emu,
>      tpm_result =3D be32_to_cpu(pss.u.resp.tpm_result);
>      if (tpm_result !=3D 0) {
>          error_report("tpm-emulator: Setting the stateblob (type %d) fail=
ed "
> -                     "with a TPM error 0x%x", type, tpm_result);
> +                     "with a TPM error 0x%x %s", type, tpm_result,
> +                     tpm_emulator_strerror(tpm_result));
>          return -1;
>      }
>
> @@ -888,8 +928,8 @@ static void tpm_emulator_shutdown(TPMEmulator *tpm_em=
u)
>          error_report("tpm-emulator: Could not cleanly shutdown the TPM: =
%s",
>                       strerror(errno));
>      } else if (res !=3D 0) {
> -        error_report("tpm-emulator: TPM result for sutdown: 0x%x",
> -                     be32_to_cpu(res));
> +        error_report("tpm-emulator: TPM result for shutdown: 0x%x %s",
> +                     be32_to_cpu(res), tpm_emulator_strerror(be32_to_cpu=
(res)));
>      }
>  }
>
> diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
> index a4c77fbd7e..3fb28a9d6c 100644
> --- a/hw/tpm/tpm_int.h
> +++ b/hw/tpm/tpm_int.h
> @@ -39,7 +39,16 @@ struct tpm_resp_hdr {
>  #define TPM_TAG_RSP_AUTH1_COMMAND 0xc5
>  #define TPM_TAG_RSP_AUTH2_COMMAND 0xc6
>
> +#define TPM_BAD_PARAMETER         3
>  #define TPM_FAIL                  9
> +#define TPM_KEYNOTFOUND           13
> +#define TPM_BAD_PARAM_SIZE        25
> +#define TPM_ENCRYPT_ERROR         32
> +#define TPM_DECRYPT_ERROR         33
> +#define TPM_BAD_KEY_PROPERTY      40
> +#define TPM_BAD_MODE              44
> +#define TPM_BAD_VERSION           46
> +#define TPM_BAD_LOCALITY          61
>
>  #define TPM_ORD_ContinueSelfTest  0x53
>  #define TPM_ORD_GetTicks          0xf1
> @@ -59,4 +68,8 @@ struct tpm_resp_hdr {
>
>  #define TPM2_PT_MAX_COMMAND_SIZE  0x11e
>
> +#define TPM_RC_INSUFFICIENT       0x9a
> +#define TPM_RC_FAILURE            0x101
> +#define TPM_RC_LOCALITY           0x907
> +
>  #endif /* TPM_TPM_INT_H */
> --
> 2.20.1
>


--=20
Marc-Andr=C3=A9 Lureau

