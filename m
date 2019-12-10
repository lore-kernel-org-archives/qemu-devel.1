Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C18C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AECBF20726
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbLSgmSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECBF20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iee9I-0007rB-SS
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 06:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iee82-0007AJ-Tx
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iee81-0002uD-Tg
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:56:34 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30947
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iee81-0002tz-Pw
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575978993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Paerd3hSGjKBB9A+UbqgE1MwS10pOmkuY9n5HwZdba8=;
 b=DbLSgmSfLmIrU7v6SJRuWbBQdVw0QBSNrP9Lb1gUUiy/4wPl19ByueSMCWDpiV4wTOaKxh
 wm6ohQaoIUtrXZpd/o1guD7dGlSRzxe1Y0vZVp8ufcupZq7hN3l9jwy3CuUY/9pji5yPai
 lISCjjY6nvFWQ/OzZ3NFiAPk1dZ9bOU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-jqaq_V6tM2iAfGDci7OFNA-1; Tue, 10 Dec 2019 06:56:32 -0500
Received: by mail-wr1-f70.google.com with SMTP id b13so8840178wrx.22
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 03:56:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w0diP+uvcrULs1VjHI6DnuEdVd3g9R9d1urRe3G8Fyw=;
 b=X7OaHgECvWRLuxLT9lg1KS+jt2J4Rw3C0fPJuWH1AnS450/xbSR/dP4sYlcWDzb6SO
 zWr79aLsu0SVetajbpgvJzTaWK5WaHVVSelt0dEa4PytXaJ4OSyZmzHSuYacZeNr7HVJ
 Tu5oqzJU+rIhEMPCqdPChdsaDC07r5lXWirNGtJ274KeVRj1/muTldbsbfPhD8YHcACJ
 bHV01T38lTg7UYmUT6zWP0WikkUAPmMQdGpvDYFC2nZ6uLLTCf4h3YW+hs3KwDCEL6kq
 OxTmsvmxnORg4QoRN6ozajt1gtxttAfQjabTMmLV0gHqvhnsmjbWmHRXZ6f064/EmBrr
 1Ywg==
X-Gm-Message-State: APjAAAXng8viOsO+P5jX0J3rXq0mzyv7qSivDE/QT+1klLuzL3HmNQ4S
 jUpJdHS4l7Vf/J1A1tK5KmlaQdaAV4WAdDeA2ePHrBrRRBeRmn+rw+908luVKFNRAOkbNR7tO3S
 7+JUThNQza8pQMX4=
X-Received: by 2002:a1c:4f:: with SMTP id 76mr4576965wma.69.1575978990463;
 Tue, 10 Dec 2019 03:56:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqyv82TPnNwr1wr/OErwbTphxPH7nBQCbzjn0j4x1cvHRIcmCq9O/Hm5jBItnSp7apkI/ozeqQ==
X-Received: by 2002:a1c:4f:: with SMTP id 76mr4576945wma.69.1575978990241;
 Tue, 10 Dec 2019 03:56:30 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id i5sm116327wml.31.2019.12.10.03.56.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 03:56:29 -0800 (PST)
Subject: Re: [PATCH v2 04/18] vl: extract accelerator option processing to a
 separate function
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
 <1575903705-12925-5-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <28ef29de-de71-0d1a-8b6a-a4d0c6db6b70@redhat.com>
Date: Tue, 10 Dec 2019 12:56:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575903705-12925-5-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: jqaq_V6tM2iAfGDci7OFNA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: thuth@redhat.com, elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 4:01 PM, Paolo Bonzini wrote:
> As a first step towards supporting multiple "-accel" options, push the
> late processing of -icount and -accel into a new function, and use
> qemu_opts_foreach to retrieve -accel options instead of stashing
> them into globals.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   vl.c | 28 ++++++++++++++++++++--------
>   1 file changed, 20 insertions(+), 8 deletions(-)
>=20
> diff --git a/vl.c b/vl.c
> index f69fea1..1ad6dfb 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2831,6 +2831,25 @@ static int do_configure_icount(void *opaque, QemuO=
pts *opts, Error **errp)
>       return 0;
>   }
>  =20
> +static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error =
**errp)
> +{
> +    if (tcg_enabled()) {
> +        qemu_tcg_configure(opts, &error_fatal);
> +    }
> +    return 0;
> +}
> +
> +static void configure_accelerators(void)
> +{
> +    qemu_opts_foreach(qemu_find_opts("accel"),
> +                      do_configure_accelerator, NULL, &error_fatal);
> +
> +    if (!tcg_enabled() && use_icount) {
> +        error_report("-icount is not allowed with hardware virtualizatio=
n");
> +        exit(1);
> +    }
> +}
> +
>   int main(int argc, char **argv, char **envp)
>   {
>       int i;
> @@ -4258,14 +4277,7 @@ int main(int argc, char **argv, char **envp)
>       qemu_spice_init();
>  =20
>       cpu_ticks_init();
> -    if (!tcg_enabled() && use_icount) {
> -        error_report("-icount is not allowed with hardware virtualizatio=
n");
> -        exit(1);
> -    }
> -
> -    if (tcg_enabled()) {
> -        qemu_tcg_configure(accel_opts, &error_fatal);
> -    }
> +    configure_accelerators();
>  =20
>       if (default_net) {
>           QemuOptsList *net =3D qemu_find_opts("net");
>=20


