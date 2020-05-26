Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCBBC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E6B2073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rbd+18Y+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E6B2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdX7S-0006PH-5N
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdX6N-0005hD-J7
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:46:31 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54762)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdX6M-0001pa-K1
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:46:31 -0400
Received: by mail-wm1-x342.google.com with SMTP id h4so2655502wmb.4
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 03:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8/2p96nvDB8tgYcEmtJxrf+Si2eiGAU3/SyssBplbhk=;
 b=Rbd+18Y+OL73HXKl+F6pSQBj9nXF+KfxZ3T3MSpjv73y3PG6i4X7uOXWriRxAYIXaq
 BBKDCGmBeH8NGHeEoRWwMUP6OlY1uo2thg4wIP8McresousdTce9t0L4X79O2rUHWUmr
 RXG7JaXGimo8ACd0oV/V89v/qDgqoV/q4o+teri/aq0Zt4wdiWW6at+FIlDPCTels3pl
 tS9H/GQHcrj07oT2srjlwL5CXoFF3sVLYr7XyQbCaCGPlr1MrUks3uh7r+udZNj4eioJ
 u5foWU0gjErFrIjZBn8mF7E1uIIaTAZRcQ3SeUFN67cPeu5Bxb9m+5E89aMyiL9h7SfK
 WUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8/2p96nvDB8tgYcEmtJxrf+Si2eiGAU3/SyssBplbhk=;
 b=oo7dCS39LuYXEKIqZ7eQTHR3d/Nj9HqfHrzrJzgLoBk4hMoKsBCxNMzmJBpYBAh7jv
 EJEcT0UAoSJOfD1VqcQVWI7wETFkwjPA14vLCeL8Evg86vSo2ih9WfyExxpzZVpKtKS2
 8vSvtU5II4Gt4+FDdPKHHj3AJAeAr5kO3HhjFuASdT3mfjC3/h8sz1PfJJhJ0OTDAi2O
 bcVmWYER0JgYHHfAArgCi7HSOZrU6hyx25hW9V+zPbacxbY13dxp2LFTmOvnpQC7VAmu
 IEcpFyZNVT0JWavpvFYJoRS8OHXn3oaXSeRqH9jO6nZ6Hpq+FY0lJbSka0Qgmlo6d3Em
 WjhQ==
X-Gm-Message-State: AOAM531/Kj1w41wTEFy9joV8Erkc/+l9bjl0OS9qz9Smvvx3+aZC5K73
 WvZ+CwUS4SUf0CZj1vN2CdripPhJJOw0Y8F0q7w=
X-Google-Smtp-Source: ABdhPJx7snTIUhch8hpB/9G8S/YPMrNau4I+sBcPu/7SrQg+g9iUCLvgKEc33TASGzfDGCI0UHMrYWXudhBISBIhaDc=
X-Received: by 2002:a1c:18e:: with SMTP id 136mr757343wmb.159.1590489989063;
 Tue, 26 May 2020 03:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
 <20200518200920.17344-21-aleksandar.qemu.devel@gmail.com>
 <dba8f844-e28a-bd13-9655-75f8004ad21f@amsat.org>
 <CAHiYmc6DMA2LRXama80zaPi+7RqFQYWL5OwtRn_Xk-ueASAi_A@mail.gmail.com>
 <3cc6c3d2-19f6-8502-a460-67c5853ff953@amsat.org>
In-Reply-To: <3cc6c3d2-19f6-8502-a460-67c5853ff953@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 26 May 2020 12:46:16 +0200
Message-ID: <CAHiYmc6xuRQ0u+BLotEpKvmF+_vv2madz80oUJqsJz0o3a3JdA@mail.gmail.com>
Subject: Re: [PATCH v6 20/21] hw/mips: Add some logging for bad register
 offset cases
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
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

=D1=83=D1=82=D0=BE, 26. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:38 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 5/26/20 12:05 PM, Aleksandar Markovic wrote:
> > =D1=83=D1=82=D0=BE, 26. =D0=BC=D0=B0=D1=98 2020. =D1=83 09:42 Philippe =
Mathieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
> > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >>
> >> On 5/18/20 10:09 PM, Aleksandar Markovic wrote:
> >>> Log the cases where a guest attempts read or write using bad
> >>> register offset.
> >>>
> >>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >>> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >>
> >> Not well tested apparently, because it doesn't build with GCC 5.4.0
> >> (Ubuntu):
> >>
> >> hw/mips/malta.c: In function =E2=80=98malta_fpga_read=E2=80=99:
> >> hw/mips/malta.c:430:85: error: format =E2=80=98%x=E2=80=99 expects arg=
ument of type
> >> =E2=80=98unsigned int=E2=80=99, but argument 2 has type =E2=80=98hwadd=
r {aka long unsigned int}=E2=80=99
> >> [-Werror=3Dformat=3D]
> >> hw/mips/malta.c: In function =E2=80=98malta_fpga_write=E2=80=99:
> >> hw/mips/malta.c:517:85: error: format =E2=80=98%x=E2=80=99 expects arg=
ument of type
> >> =E2=80=98unsigned int=E2=80=99, but argument 2 has type =E2=80=98hwadd=
r {aka long unsigned int}=E2=80=99
> >> [-Werror=3Dformat=3D]
> >> cc1: all warnings being treated as errors
> >>
> >> I amended this snippet ...:
> >>
> >> -- >8 --
> >> @@ -428,8 +428,8 @@ static uint64_t malta_fpga_read(void *opaque, hwad=
dr
> >> addr,
> >>
> >>      default:
> >>          qemu_log_mask(LOG_GUEST_ERROR,
> >> -                      "malta_fpga_read: Bad register offset 0x"
> >> -                      TARGET_FMT_lx "\n", addr);
> >> +                      "malta_fpga_read: Bad register addr
> >> 0x%"HWADDR_PRIX"\n",
> >> +                      addr);
> >>          break;
> >>      }
> >>      return val;
> >> @@ -515,8 +515,8 @@ static void malta_fpga_write(void *opaque, hwaddr =
addr,
> >>
> >>      default:
> >>          qemu_log_mask(LOG_GUEST_ERROR,
> >> -                      "malta_fpga_write: Bad register offset 0x"
> >> -                      TARGET_FMT_lx "\n", addr);
> >> +                      "malta_fpga_write: Bad register addr
> >> 0x%"HWADDR_PRIX"\n",
> >> +                      addr);
> >>          break;
> >>      }
> >>  }
> >> ---
> >>
> >> ... and queued to mips-next,
> >>
> >
> > Hi, Philippe,
> >
> > Many thanks for correcting my mistake in this patch!
> > May I ask you to refer to your queue as hw/mips-next, rather than
> > mips-next, for the sake of clarity?
>
> Tags with '/' are hard to manage, let's use mips-hw-next,
> mips-target-next for your pull requests and mips-kvm-next for Huacai's on=
es.
>
> > And, when do you plan to send the pull request?
>
> Waiting for Gerd's audio-next one to get merged because he took my
> "mips_fulong2e: Remove unused 'audio/audio.h' include" patch and I don't
> want Peter to have to manually resolve conflicts (there shouldn't be,
> but I don't want to risk bother him with a "automatic 3-way merge" warnin=
g).
>

Philippe, I think you created a lot of problems here without any real need.

We should sync between us rather than sent "surprise" "pull requests".

I am not happy with coordination of our common MIPS work.

> >
> > Thanks,
> > Aleksandar
> >
> >
> >> Thanks,
> >>
> >> Phil.
> >>
> >>> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> >>> ---
> >>>  hw/mips/mips_malta.c | 14 ++++++--------
> >>>  1 file changed, 6 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> >>> index e4c4de1b4e..88869b828e 100644
> >>> --- a/hw/mips/mips_malta.c
> >>> +++ b/hw/mips/mips_malta.c
> >>> @@ -427,10 +427,9 @@ static uint64_t malta_fpga_read(void *opaque, hw=
addr addr,
> >>>          break;
> >>>
> >>>      default:
> >>> -#if 0
> >>> -        printf("malta_fpga_read: Bad register offset 0x" TARGET_FMT_=
lx "\n",
> >>> -               addr);
> >>> -#endif
> >>> +        qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                      "malta_fpga_read: Bad register offset 0x"
> >>> +                      TARGET_FMT_lx "\n", addr);
> >>>          break;
> >>>      }
> >>>      return val;
> >>> @@ -515,10 +514,9 @@ static void malta_fpga_write(void *opaque, hwadd=
r addr,
> >>>          break;
> >>>
> >>>      default:
> >>> -#if 0
> >>> -        printf("malta_fpga_write: Bad register offset 0x" TARGET_FMT=
_lx "\n",
> >>> -               addr);
> >>> -#endif
> >>> +        qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                      "malta_fpga_write: Bad register offset 0x"
> >>> +                      TARGET_FMT_lx "\n", addr);
> >>>          break;
> >>>      }
> >>>  }
> >>>
> >

