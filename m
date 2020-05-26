Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E59C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F4A22068D
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEyWSqKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4A22068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdWU4-0003aK-Lw
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdWTQ-0002q8-K7
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:06:16 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:47016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdWTP-0001Mn-MB
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:06:16 -0400
Received: by mail-wr1-x443.google.com with SMTP id x6so6184030wrm.13
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 03:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DjesSjagvnceMIWbIg2XOpbnKvgMUWf3aV7FFEj9N1w=;
 b=dEyWSqKg91ElWx4b8ObP3J0GUpQ7zaJ4H1vPXYJ4YcMQ+yqyTMwhnb+Un/R6NHCEh4
 MDnr3UgkQIKyiZDbqzNm2+IiJ9hv0cekSchaym+AbMpOxmkJk2wm58cunZ5HZpai0eVD
 h1Ij5XYw5jFsPZtpnOU+QHITI8MeNE4JLIHOV+xzoB4wJeMIY9xUD58LfABBdg3YBH4O
 CUku6z0qqlTyHIpYJKbsISy8Dnl2dorpH2vwAh6J2gy0PE0NAyWSu1n8Tpkb21dwWj9K
 4QyiFzO6y32tTxc983cN/7jbdA0SJ2BE+TLJi6DNh8LbVo3nIOnGTsPPlpJv19RABsaI
 5+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DjesSjagvnceMIWbIg2XOpbnKvgMUWf3aV7FFEj9N1w=;
 b=m91p34WqiS/eYbkfAKWJM0nRE78ewHB4vdhRHjUCQ09NkXDC9zpWcNGtGtCCYyu1aM
 +8MD+4hgUQ2hn2/dURuJTbkMKu0VAh9BbuYdA44sHRELiGuL75miJ3aT6GNbnu9YQCS8
 tHfK7hD3lf1F/s5h2zqXXTdKEZyurToY5YYjo0U29g9MCfRGWk82l0vYUpXYfd8zlRIm
 Qft8CQXMXFbzrhloVsXPv4tT70bciuGVVC70T2QyivT8IU7IAH46pFqOl804rnGl9+7T
 3kO0TY050E20pirKJVlCxBdKFiGUm3ZBcjgyoCfWdsH6sNt85nzaPHKH7oBd6oJrGQun
 IcPQ==
X-Gm-Message-State: AOAM532EshvVxYx8K5wusZh8dhcBWy8QEdxmjiQqOGJVuEcyFVoFbqu2
 2GrRq5NIKEVsooe2i6yCLasQfIYQWgvJLhKaHZA=
X-Google-Smtp-Source: ABdhPJwjoIUnXiin7R+O1J3QtJtpZdtNdZPwDGllrkLi8dGVckYYoI/24qUzhSvlvHBlhB8iBexcUkokf7QXIXcXcDo=
X-Received: by 2002:adf:dc50:: with SMTP id m16mr19446170wrj.329.1590487572807; 
 Tue, 26 May 2020 03:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
 <20200518200920.17344-21-aleksandar.qemu.devel@gmail.com>
 <dba8f844-e28a-bd13-9655-75f8004ad21f@amsat.org>
In-Reply-To: <dba8f844-e28a-bd13-9655-75f8004ad21f@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 26 May 2020 12:05:51 +0200
Message-ID: <CAHiYmc6DMA2LRXama80zaPi+7RqFQYWL5OwtRn_Xk-ueASAi_A@mail.gmail.com>
Subject: Re: [PATCH v6 20/21] hw/mips: Add some logging for bad register
 offset cases
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@syrmia.com, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=83=D1=82=D0=BE, 26. =D0=BC=D0=B0=D1=98 2020. =D1=83 09:42 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 5/18/20 10:09 PM, Aleksandar Markovic wrote:
> > Log the cases where a guest attempts read or write using bad
> > register offset.
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Not well tested apparently, because it doesn't build with GCC 5.4.0
> (Ubuntu):
>
> hw/mips/malta.c: In function =E2=80=98malta_fpga_read=E2=80=99:
> hw/mips/malta.c:430:85: error: format =E2=80=98%x=E2=80=99 expects argume=
nt of type
> =E2=80=98unsigned int=E2=80=99, but argument 2 has type =E2=80=98hwaddr {=
aka long unsigned int}=E2=80=99
> [-Werror=3Dformat=3D]
> hw/mips/malta.c: In function =E2=80=98malta_fpga_write=E2=80=99:
> hw/mips/malta.c:517:85: error: format =E2=80=98%x=E2=80=99 expects argume=
nt of type
> =E2=80=98unsigned int=E2=80=99, but argument 2 has type =E2=80=98hwaddr {=
aka long unsigned int}=E2=80=99
> [-Werror=3Dformat=3D]
> cc1: all warnings being treated as errors
>
> I amended this snippet ...:
>
> -- >8 --
> @@ -428,8 +428,8 @@ static uint64_t malta_fpga_read(void *opaque, hwaddr
> addr,
>
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR,
> -                      "malta_fpga_read: Bad register offset 0x"
> -                      TARGET_FMT_lx "\n", addr);
> +                      "malta_fpga_read: Bad register addr
> 0x%"HWADDR_PRIX"\n",
> +                      addr);
>          break;
>      }
>      return val;
> @@ -515,8 +515,8 @@ static void malta_fpga_write(void *opaque, hwaddr add=
r,
>
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR,
> -                      "malta_fpga_write: Bad register offset 0x"
> -                      TARGET_FMT_lx "\n", addr);
> +                      "malta_fpga_write: Bad register addr
> 0x%"HWADDR_PRIX"\n",
> +                      addr);
>          break;
>      }
>  }
> ---
>
> ... and queued to mips-next,
>

Hi, Philippe,

Many thanks for correcting my mistake in this patch!
May I ask you to refer to your queue as hw/mips-next, rather than
mips-next, for the sake of clarity?
And, when do you plan to send the pull request?

Thanks,
Aleksandar


> Thanks,
>
> Phil.
>
> > Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > ---
> >  hw/mips/mips_malta.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> > index e4c4de1b4e..88869b828e 100644
> > --- a/hw/mips/mips_malta.c
> > +++ b/hw/mips/mips_malta.c
> > @@ -427,10 +427,9 @@ static uint64_t malta_fpga_read(void *opaque, hwad=
dr addr,
> >          break;
> >
> >      default:
> > -#if 0
> > -        printf("malta_fpga_read: Bad register offset 0x" TARGET_FMT_lx=
 "\n",
> > -               addr);
> > -#endif
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "malta_fpga_read: Bad register offset 0x"
> > +                      TARGET_FMT_lx "\n", addr);
> >          break;
> >      }
> >      return val;
> > @@ -515,10 +514,9 @@ static void malta_fpga_write(void *opaque, hwaddr =
addr,
> >          break;
> >
> >      default:
> > -#if 0
> > -        printf("malta_fpga_write: Bad register offset 0x" TARGET_FMT_l=
x "\n",
> > -               addr);
> > -#endif
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "malta_fpga_write: Bad register offset 0x"
> > +                      TARGET_FMT_lx "\n", addr);
> >          break;
> >      }
> >  }
> >

