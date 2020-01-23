Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D59CC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E9524125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fkUaQvva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E9524125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuagW-0006U6-6k
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 06:30:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iuafR-0005U1-PI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iuafQ-0006U1-IX
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:28:57 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iuafQ-0006TQ-AZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:28:56 -0500
Received: by mail-wm1-x341.google.com with SMTP id a5so2185901wmb.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 03:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=JT0vRtzsfSszG2BZGI3MYVv47jIAKzN+WgSV9JREyRA=;
 b=fkUaQvvaAY7oZ7SDFpItQ+JmgHO24HO4HBwcdI5Glm4OJVYc1lx3FdmA8xuscw95x5
 qg9LAAPHJkQ+5NMBjqcfR76VSxrWtaQTlOywepbOAVo0eqfA3COopXR7u50YDDsrotvW
 wcxUEQEaoTcNiQYaqPBPfH9oEEENPMQLHbKDDEkaGjQDJqGC5Yhgaski3Q91ZhH1tLtO
 4qs0m2xxq/Byj2G0fFPONxTG6BlAIW4kr0eN34a8UcP0+tlH+0Se4NKP88/PXYYbLI3x
 J3gI05xZGUmpdPVy527hwqs1q84UhNX+ouFcrJkwPYI9FEoD0NnDnZMek3EW7OV7r9mB
 Ksfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=JT0vRtzsfSszG2BZGI3MYVv47jIAKzN+WgSV9JREyRA=;
 b=liwEpmAFAGqmIFP+uyXZPKKED9Ddl2/HZJ3afDLkVtHRs0cAU5rGY7NFo7VK9M5n3E
 dpEmzr3appRKLsdl0/Hr0Ie1u965kpKLGy04ve1VK4sjLFAgKR5WEvfk7hg5qGNyCGoQ
 0g9AeNuLbgmA2lFwzquUjnTJLqyHkdSauVzB0SY2wFi/q7bh3DpaP9XBrm72su4EVWU0
 yQLzlpxN1pdfUUEU+fa6zvyhMm+sTm5yD5W/KHo4j4AcKEw62QCe9tYOfW9GYhM2ljVM
 Q9d/HzHbCF9sU5BQoM3+6GkackJpCA4vVTcwvucpGF4/iCPjAOOoMxshTMAdAlDYW3cL
 yLiQ==
X-Gm-Message-State: APjAAAXI/rLoWxHbxcalHBFvyxhRsYHqkDd0GkMKiHVuLOc9wyrdfins
 XwEdw14KqVuyqZ+udf3VHQucJg==
X-Google-Smtp-Source: APXvYqzBfyOaCavQLsNNPp3o3Yeh1KcX20P8tpeJ/t856wf8osmzxGnXuf8g7YzU3mJgXDjTwcRqrA==
X-Received: by 2002:a1c:7e0b:: with SMTP id z11mr3780971wmc.88.1579778935127; 
 Thu, 23 Jan 2020 03:28:55 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i10sm2661243wru.16.2020.01.23.03.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 03:28:53 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E8EAF1FF87;
 Thu, 23 Jan 2020 11:28:52 +0000 (GMT)
References: <20191217173252.4672-1-philmd@redhat.com>
 <6a8266c6-7c6d-3139-249f-2dd46c98e02f@redhat.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 0/6] Fix more GCC9 -O3 warnings
In-reply-to: <6a8266c6-7c6d-3139-249f-2dd46c98e02f@redhat.com>
Date: Thu, 23 Jan 2020 11:28:52 +0000
Message-ID: <87blquza17.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Hannes Reinecke <hare@suse.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@aj.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Chubb <peter.chubb@nicta.com.au>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-arm@nongnu.org,
 =?utf-8?B?S8WR?= =?utf-8?B?dsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 12/17/19 6:32 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Fix some trivial warnings when building with -O3.
>> Philippe Mathieu-Daud=C3=A9 (6):
>>    audio/audio: Add missing fall through comment
>>    hw/display/tcx: Add missing fall through comments
>>    hw/net/imx_fec: Rewrite fall through comments
>>    hw/timer/aspeed_timer: Add a fall through comment
>>    hw/scsi/megasas: Silent GCC9 duplicated-cond warning
>>    qemu-io-cmds: Silent GCC9 format-overflow warning
>
> Sorry, this series failed because I used this tag in the first patch:
>
> Cc: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>
>
> Then git-send-email was happy with --dry-run, but then failed:
> (body) Adding cc: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.=
com> from line
> 'Cc: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>'
> 5.1.1 <K  v  g  >: Recipient address rejected: User unknown in local
> recipient table
>
> Note to self, enclose utf-8 names, as:
> Cc: "K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com>

I never have to with my tags:

Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Is it possible to be more even utf-8? Sounds like a bug in the git tools
to me.

--=20
Alex Benn=C3=A9e

