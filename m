Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24C7C3A59D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 00:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B59020578
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 00:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hAIQZDa0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B59020578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hymDn-0000HB-GN
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 20:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <scw@google.com>) id 1hymCi-0007sd-MJ
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 20:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <scw@google.com>) id 1hymCh-0005TT-0z
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 20:04:20 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33]:33469)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <scw@google.com>) id 1hymCg-0005T5-Ig
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 20:04:18 -0400
Received: by mail-io1-xd33.google.com with SMTP id z3so9609835iog.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 17:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pyan4/kFojvqTolurfUXxXXfCYo1p+UJQiF8rp77EWQ=;
 b=hAIQZDa00kCZ6IYwD2e1mQKrn/KVfyWoAdW36tPadCl7KTiEnJodeEFhb180mRlguy
 efP+rORz1DwPFM73y3j7xG/lHoD1gbUKZUzHqOGtthTKdHU7QwmnMzNYvKgEA8qaLvtK
 hPMQ2uZQez5fouVyeWv56cMoWVN0lKchvpX/eiMPVSihnz+i4qISpkbBuoK+KLi5fKqU
 65u0ZW64F7pLQprP3UNixK5cSJDu0n+V2Pz/tLNCy+I8Z7Er2UtItAl3fZxzqueZ36bL
 OM4jZkDd/BQks2J/VYt0EOIT7H7wq0GU1F8BYI2V9Jo7GfFTtQNb/+C76fUwbrNCLSOi
 aRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pyan4/kFojvqTolurfUXxXXfCYo1p+UJQiF8rp77EWQ=;
 b=FCOgjYUIOGfHlo7/nRV2fEZjq+M5eyQ6Bq7MpbafVGgR7i5Lc6KQN1gTDk58FHDgB0
 YhJb7t8LuXLU4hP7yrQo2FJBDxydlVTiVzqVjIIlvfRZipbeox0vDiYXGESE7sTIxelq
 BHJWymnXgM7GWQg8HIZz4F84XGhrIBTvKvdvVkluIwMhmSVIOf/ouMdm/O6hgVyP1x0r
 ODxpR3aK5Lwi507R5PTBHvcIsKBPHAAtzC4GiqqhDZN3rZwpuuoyQ3ESRJcQil57pFJX
 dWX/MQBaDsSrywwzU3qcRR6MQRW36GAU9+7+kOsRP+inQ8sfAWfTf5RP+M9dQ6bwxjY6
 sHew==
X-Gm-Message-State: APjAAAUvViAlUo0cdyPyi+CLt6kSXTBRrimFHxg6zLyklqkDNjTWNSHQ
 BdLRT8QslcW25XSa5/+fjuFlCxAbhFUUMKSDzj4/nw==
X-Google-Smtp-Source: APXvYqzRpcDtwCKPKE0LEd3nF3qo4fCOeDaog+gChQcoEYIMjwHt+Y9IMj9jhFQWC2yavaBOs0Vd0JXDN2v65gMVq04=
X-Received: by 2002:a02:8663:: with SMTP id e90mr8085281jai.98.1566000256782; 
 Fri, 16 Aug 2019 17:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190816211356.59244-1-scw@google.com>
 <CAL1e-=hMssOVfvGWsyWmUgPyG-1ovMva9W5-T+GJgoyn_29-VQ@mail.gmail.com>
In-Reply-To: <CAL1e-=hMssOVfvGWsyWmUgPyG-1ovMva9W5-T+GJgoyn_29-VQ@mail.gmail.com>
Date: Fri, 16 Aug 2019 17:04:04 -0700
Message-ID: <CAF3nBxiu9i8=07+1QqHj2bWiBmHkwCGyg2Y+bK6eVrhhroiJzw@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="00000000000010f6b1059044d9f7"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d33
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] Add support for ethtool via
 TARGET_SIOCETHTOOL ioctls.
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
From: Shu-Chun Weng via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Shu-Chun Weng <scw@google.com>
Cc: Arun Kalyanasundaram <arunkaly@google.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000010f6b1059044d9f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Aleksandar,

I've updated the patch description and will send out v2 soon.

As for the length of the line: all lines in file syscall_defs.h are of
length 81 with a fixed width comment at the end. I'm not sure if making the
one line I add 80-character-wide is the right choice.

Shu-Chun

On Fri, Aug 16, 2019 at 3:37 PM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
> 16.08.2019. 23.28, "Shu-Chun Weng via Qemu-devel" <qemu-devel@nongnu.org>
> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > The ioctl numeric values are platform-independent and determined by
> > the file include/uapi/linux/sockios.h in Linux kernel source code:
> >
> >   #define SIOCETHTOOL   0x8946
> >
> > These ioctls get (or set) the field ifr_data of type char* in the
> > structure ifreq. Such functionality is achieved in QEMU by using
> > MK_STRUCT() and MK_PTR() macros with an appropriate argument, as
> > it was done for existing similar cases.
> >
> > Signed-off-by: Shu-Chun Weng <scw@google.com>
> > ---
>
> Shu-Chun, hi, and welcome!
>
> Just a couple of cosmetic things:
>
>   - by convention, the title of this patch should start with
> "linux-user:", since this patch affects linux user QEMU module;
>
>   - the patch title is too long (and has some minor mistakes) -
> "linux-user: Add support for SIOCETHTOOL ioctl" should be good enough;
>
>   - the lenght of the code lines that you add or modify must not be
> greater than 80.
>
> Sincerely,
> Aleksandar
>
> >  linux-user/ioctls.h       | 1 +
> >  linux-user/syscall_defs.h | 2 ++
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> > index 3281c97ca2..9d231df665 100644
> > --- a/linux-user/ioctls.h
> > +++ b/linux-user/ioctls.h
> > @@ -208,6 +208,7 @@
> >    IOCTL(SIOCGIFINDEX, IOC_W | IOC_R,
> MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
> >    IOCTL(SIOCSIFPFLAGS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
> >    IOCTL(SIOCGIFPFLAGS, IOC_W | IOC_R,
> MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
> > +  IOCTL(SIOCETHTOOL, IOC_R | IOC_W, MK_PTR(MK_STRUCT(STRUCT_ptr_ifreq)=
))
> >    IOCTL(SIOCSIFLINK, 0, TYPE_NULL)
> >    IOCTL_SPECIAL(SIOCGIFCONF, IOC_W | IOC_R, do_ioctl_ifconf,
> >                  MK_PTR(MK_STRUCT(STRUCT_ifconf)))
> > diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> > index 0662270300..276f96039f 100644
> > --- a/linux-user/syscall_defs.h
> > +++ b/linux-user/syscall_defs.h
> > @@ -819,6 +819,8 @@ struct target_pollfd {
> >  #define TARGET_SIOCGIFTXQLEN   0x8942          /* Get the tx queue
> length      */
> >  #define TARGET_SIOCSIFTXQLEN   0x8943          /* Set the tx queue
> length      */
> >
> > +#define TARGET_SIOCETHTOOL     0x8946          /* Ethtool interface
>         */
> > +
> >  /* ARP cache control calls. */
> >  #define TARGET_OLD_SIOCDARP    0x8950          /* old delete ARP table
> entry   */
> >  #define TARGET_OLD_SIOCGARP    0x8951          /* old get ARP table
> entry      */
> > --
> > 2.23.0.rc1.153.gdeed80330f-goog
> >
> >
>

--00000000000010f6b1059044d9f7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS4QYJKoZIhvcNAQcCoIIS0jCCEs4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBHMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
--00000000000010f6b1059044d9f7--

