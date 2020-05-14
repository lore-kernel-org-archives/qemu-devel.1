Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86866C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 16:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2A42065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 16:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P844F0Pv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2A42065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZGjH-0006HD-Cn
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 12:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZGiF-0005ny-4e
 for qemu-devel@nongnu.org; Thu, 14 May 2020 12:27:59 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38434)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZGiD-0000LA-UR
 for qemu-devel@nongnu.org; Thu, 14 May 2020 12:27:58 -0400
Received: by mail-wr1-x441.google.com with SMTP id e1so5072389wrt.5
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=P7W9sfbxWoUhpr0SYGqb56nma6XoiAYAYi8x/POFzME=;
 b=P844F0PvwN54XekkdAAnQcOm9G/h1nPPkfZ9BJnWa942YHcWVmfB+idqAKn5yxdB2b
 F5p2kLsRMl7Sv3FjGNTeY3sFY4XgBvUN/Vm8M8a2sm2J76ml4p+AAft5Cj/dEiEPaHYL
 pQN6c3RN4Z+ltzJlimMCartSb1oJk6mAAwLjAPV2xW5NhEbmkCIQq2juunHN6T1Y6niw
 nZMzqybyP+blTJ4AuXcxp0eUVCK5VZgR8jSfETO+LQ/ycwfXf+bziu6yxPiojVrldpxg
 Q9s14XPpgq448vM95HfIB/d4su0rO/cZvFdLXh+PFdsindWJCN8BhvrvSaGaz6YUX2bd
 x00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=P7W9sfbxWoUhpr0SYGqb56nma6XoiAYAYi8x/POFzME=;
 b=Zfz+yi0Ug/36AREIZGMgV4z6MiMah5yiFWKaOvU6fG4VDmbdwni4mDTAYEnVcPu8QB
 IIN8wgpnLB/hXUKpoSAUF1YMtKnAb8Xl6megE+GgzrkRFAOq0Lujb1sDBKLGuoAzNcI+
 FDzMaxy+o58sP0saPglh3cydHRQRmKwULEbBQ8xNDu3mgn0/kiQ+qWRh+xxY+PDULQ8j
 5fmz7Iq/FUX3GWKRhkBlp7zpzPSMf6sCh7YiuerAv9dTcdV425VGmPN9hCr2/oXx9b5a
 k5xZD8ttBqjH9DXJJfak2GrFw70O9OP5KzojktzeAcwCg9FRXKcSBvIyOAnyAulSA/F6
 uk6w==
X-Gm-Message-State: AOAM532NQujK/8L9AhGSBTLxzz3XtpbHxPokld82D5kMKoULkQNEuEst
 R+6yPFSROhApXPpVdc5SP4wS6w==
X-Google-Smtp-Source: ABdhPJxrabEaj6vP8bki22dYjIPn1Pk4YU+IlwtPdwPpCtDG8gL/G4O4sIMRYdqMq9UcUrgp5WP9zQ==
X-Received: by 2002:a5d:61d2:: with SMTP id q18mr6090609wrv.46.1589473675146; 
 Thu, 14 May 2020 09:27:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w9sm5183374wrc.27.2020.05.14.09.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 09:27:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3A75E1FF7E;
 Thu, 14 May 2020 17:27:53 +0100 (BST)
References: <20200513173200.11830-1-alex.bennee@linaro.org>
 <20200513173200.11830-6-alex.bennee@linaro.org>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH  v1 5/8] cpus-common: ensure auto-assigned cpu_indexes
 don't clash
In-reply-to: <20200513173200.11830-6-alex.bennee@linaro.org>
Date: Thu, 14 May 2020 17:27:53 +0100
Message-ID: <87y2pucwhi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Nikolay Igotti <igotti@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

a
Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Basing the cpu_index on the number of currently allocated vCPUs fails
> when vCPUs aren't removed in a LIFO manner. This is especially true
> when we are allocating a cpu_index for each guest thread in
> linux-user where there is no ordering constraint on their allocation
> and de-allocation.
>
> [I've dropped the assert which is there to guard against out-of-order
> removal as this should probably be caught higher up the stack. Maybe
> we could just ifdef CONFIG_SOFTTMU it?]
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Nikolay Igotti <igotti@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  cpus-common.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/cpus-common.c b/cpus-common.c
> index 55d5df89237..5a7d2f6132b 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -61,13 +61,14 @@ static bool cpu_index_auto_assigned;
>  static int cpu_get_free_index(void)
>  {
>      CPUState *some_cpu;
> -    int cpu_index =3D 0;
> +    int max_cpu_index =3D 0;
>=20=20
>      cpu_index_auto_assigned =3D true;
>      CPU_FOREACH(some_cpu) {
> -        cpu_index++;
> +        max_cpu_index =3D MAX(some_cpu->cpu_index, max_cpu_index);
>      }
> -    return cpu_index;
> +    max_cpu_index++;
> +    return max_cpu_index;
>  }

OK some ending up with cpu_index =3D 1 threw off devices that would do
qemu_get_cpu(0) so I've tweaked the algorithm to:

  static int cpu_get_free_index(void)
  {
      CPUState *some_cpu;
      int max_cpu_index =3D 0;

      cpu_index_auto_assigned =3D true;
      CPU_FOREACH(some_cpu) {
          if (some_cpu->cpu_index >=3D max_cpu_index) {
              max_cpu_index =3D some_cpu->cpu_index + 1;
          }
      }
      return max_cpu_index;
  }

>=20=20
>  void cpu_list_add(CPUState *cpu)
> @@ -90,8 +91,6 @@ void cpu_list_remove(CPUState *cpu)
>          return;
>      }
>=20=20
> -    assert(!(cpu_index_auto_assigned && cpu !=3D QTAILQ_LAST(&cpus)));
> -
>      QTAILQ_REMOVE_RCU(&cpus, cpu, node);
>      cpu->cpu_index =3D UNASSIGNED_CPU_INDEX;
>  }


--=20
Alex Benn=C3=A9e

