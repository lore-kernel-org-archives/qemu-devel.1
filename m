Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F51FC6197
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 20:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2EA21848
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 20:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8BHG9eG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2EA21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTBEk-0003zz-TD
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 15:52:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iTBDj-0002oO-3R
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 15:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iTBDh-0000IJ-En
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 15:51:02 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iTBDh-0000Hy-5R; Fri, 08 Nov 2019 15:51:01 -0500
Received: by mail-wr1-x444.google.com with SMTP id p4so8494326wrm.8;
 Fri, 08 Nov 2019 12:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/WiaEsTIDX7uoX/2NXG1N4EIPVeOpEJFAq1BfVcoLrQ=;
 b=g8BHG9eGjD3XT+m+4abp+NTQe9w/1vhNXlrHBzGWRb96Uu/df9SN6PoesxJWRU1GRg
 yPFphzKLu2sz/W3fZszpDuAaIW+l6IR36WhsrxFjWlWEo7g40ExfI/lZiaiWIuqNOZXW
 ez/xpapEJzpVO7CJbmyfQSVJFayH1a4LsGC7GwTFwkczDCf0u91jX7XSezB2YU55StAE
 aAsAUUy6cpxj0+5NzOIeVkjShY2gOuDiACrEDrEaTh1Be1gRWrEyGK2y1sc3SVKwlook
 LGneRRnZ1WH2Q73+yH7642Onj1hW8TtHWNkoVLppA+ivdQF5GeQo/wtKkpch78hdj7cF
 gCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/WiaEsTIDX7uoX/2NXG1N4EIPVeOpEJFAq1BfVcoLrQ=;
 b=M5Fc2RJ83mxJpcfudE7ZjO/Pe1SfTMbjBXr1E8gUf51Mefxc2iq+Im9l5GoFUqp/d5
 yhDJdYS5a3nMGKkVHsuF/ocMnGrKeizElS/RPXkRHGnFpz26AUin/FDI3rlI1Pr2ilIO
 m8NK287Xp9riT3KTyJSUhwAruQYKoXsjc8MN3TDGgsKEK4j1nJ/Bg8Xg/JgvxZxZGkUo
 IyFuit8z3cjHnvQjfB21xTA2K6f2nl8e66zvKX+4a77M+D9J1Or6+NUB5HQoau6nx3OV
 CwXta1/OkPzDsQUIXvwXSg8o/f0Z8TAG1r7iu15mxU48If6zx4u2y76FXaKTiUekS+TE
 B+Qg==
X-Gm-Message-State: APjAAAUyZDDtD/DS33V7IEu533LoCaI28XvdUvseTRXaGakycXWhu4kr
 AkJgZJfhfd6FQiAodqBvawRMAj9bxROVlLq3Y6qXyvjDSuE=
X-Google-Smtp-Source: APXvYqzbg0rqSaID2GU7Hlhw0f3F/KRETWksf8KIPueMwTihzGXM2ttrveU7tsGumf8t6s0Z+o2o7MSoELv7xuYH/IU=
X-Received: by 2002:a5d:4ad2:: with SMTP id y18mr10054543wrs.396.1573246259368; 
 Fri, 08 Nov 2019 12:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-9-vsementsov@virtuozzo.com>
In-Reply-To: <20191011160552.22907-9-vsementsov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 9 Nov 2019 00:50:47 +0400
Message-ID: <CAJ+F1CJJxQC-oUsmMrOP-iQe=5npQSHZ5pYPwrxThbGzA49MTw@mail.gmail.com>
Subject: Re: [RFC v5 008/126] ppc: well form kvmppc_hint_smt_possible error
 hint helper
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 11, 2019 at 8:14 PM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> Make kvmppc_hint_smt_possible hint append helper well formed:
> rename errp to errp_in, as it is IN-parameter here (which is unusual
> for errp), rename function to be error_append_*_hint.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  target/ppc/kvm_ppc.h | 4 ++--
>  hw/ppc/spapr.c       | 2 +-
>  target/ppc/kvm.c     | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 98bd7d5da6..35f1d499ad 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -28,7 +28,7 @@ void kvmppc_set_papr(PowerPCCPU *cpu);
>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
>  int kvmppc_smt_threads(void);
> -void kvmppc_hint_smt_possible(Error **errp);
> +void error_append_kvmppc_smt_possible_hint(Error **errp_in);
>  int kvmppc_set_smt_threads(int smt);
>  int kvmppc_clear_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
>  int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
> @@ -164,7 +164,7 @@ static inline int kvmppc_smt_threads(void)
>      return 1;
>  }
>
> -static inline void kvmppc_hint_smt_possible(Error **errp)
> +static inline void error_append_kvmppc_smt_possible_hint(Error **errp_in=
)

Please keep the kvmppc_ prefix

other than that:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>  {
>      return;
>  }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 514a17ae74..6729269aa9 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2565,7 +2565,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState *=
spapr, Error **errp)
>                                        " requires the use of VSMT mode %d=
.\n",
>                                        smp_threads, kvm_smt, spapr->vsmt)=
;
>                  }
> -                kvmppc_hint_smt_possible(&local_err);
> +                error_append_kvmppc_smt_possible_hint(&local_err);
>                  goto out;
>              }
>          }
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 820724cc7d..af6e667bf8 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2076,7 +2076,7 @@ int kvmppc_set_smt_threads(int smt)
>      return ret;
>  }
>
> -void kvmppc_hint_smt_possible(Error **errp)
> +void error_append_kvmppc_smt_possible_hint(Error **errp_in)
>  {
>      int i;
>      GString *g;
> @@ -2091,10 +2091,10 @@ void kvmppc_hint_smt_possible(Error **errp)
>              }
>          }
>          s =3D g_string_free(g, false);
> -        error_append_hint(errp, "%s.\n", s);
> +        error_append_hint(errp_in, "%s.\n", s);
>          g_free(s);
>      } else {
> -        error_append_hint(errp,
> +        error_append_hint(errp_in,
>                            "This KVM seems to be too old to support VSMT.=
\n");
>      }
>  }
> --
> 2.21.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

