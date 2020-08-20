Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7212AC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD20207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cd3szfT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD20207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8oZA-0004pE-IW
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8oXU-0002Sn-Jy
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:39:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54929
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8oXS-00035F-Gg
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597945184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0KSEqzh/vTCc1WZ2n/rDAhHgvzCGwia6nBIaN84GTQ=;
 b=Cd3szfT3eM4I0V1AdGaJUzbLpfr0nOx6od5irQeJ5Txqv0Dudx+CydbNrijl4gO3ioIgXA
 /PynZJpmfZkh7FSworcU4CPUfzrrb9bAVnGKJ1q+lmHOAoTitVSjB8u/TpzyaPqFfi8SjJ
 H9DQjRznLOAcj2GamW1whV4QTXWaUlM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-Ro02MakhOtSZNiY-WtIS1g-1; Thu, 20 Aug 2020 13:39:42 -0400
X-MC-Unique: Ro02MakhOtSZNiY-WtIS1g-1
Received: by mail-wr1-f69.google.com with SMTP id l14so888330wrp.9
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 10:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y0KSEqzh/vTCc1WZ2n/rDAhHgvzCGwia6nBIaN84GTQ=;
 b=naeDv6wSIqBTzWtn2y1Wi40A2G88YZplcvRZCLKoS59UQ1xLGaz/GdakfbqEKhH7TG
 KpKOEH5EsGj56a+rwWf0Gw3QXae7/D6jCxnEC2uEzxFvQlkv3rqQ72HBzp2zHYe5vF2Q
 C1A1bsNzYA74BpjBsf1lhj145HHgQfJN2UwALkN8HzeLdSh5xVq0MtkRReAXjyL/wfFr
 rcrQ+Fcu9T64EUb4VLWsOo1tHo0Tu2Amm1CGu451Pv1QSTuSCU0yJKK+viRTecmnxJ6b
 y9m1l0gL44XQgelozz3Pnfv3xFq/dA5ST5iwM2D7EjLVnHLoptgWTNdtnEIEMjZolEWz
 z9FQ==
X-Gm-Message-State: AOAM53240qC1v9yLjXaa3wTEgodkCnv0pTM0t9Vk0xh8yyyAgM0lSBBW
 pwJzo65vNaZ97oq5o+vfix3RTH4xAdaXlZTTGu6/mmhIviuxPNR94avtvDYW4fN7qRtdwgoIGBj
 YfTFqEQAt6ZwqCoc=
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr4701275wmd.72.1597945181360; 
 Thu, 20 Aug 2020 10:39:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdLrnGVyPwKkORmKu/rVLc52FtR138BoiWy9+pqG2IrZY3Mxb16KXLbUJyrCu0kxlGaff0+A==
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr4701250wmd.72.1597945181019; 
 Thu, 20 Aug 2020 10:39:41 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id z207sm5608917wmc.2.2020.08.20.10.39.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 10:39:40 -0700 (PDT)
Subject: Re: deprecation of in-tree builds
To: Kevin Wolf <kwolf@redhat.com>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <alpine.BSF.2.22.395.2003212338020.36211@zero.eik.bme.hu>
 <20200323133244.GK261260@stefanha-x1.localdomain>
 <CAFEAcA9VPgQ1MPYhcda4tdxMuhMC5R9fd6D=OVOZKRLMO8n_xw@mail.gmail.com>
 <20200820105401.GA99531@linux.fritz.box>
 <9bdbb3b9-01df-2a6b-0c82-b58ef6e0edf9@redhat.com>
 <20200820133023.GD99531@linux.fritz.box>
 <80348ec7-4897-a2ab-54a6-2997ee47b598@redhat.com>
 <20200820161456.GG99531@linux.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8199df6a-67b4-6dd7-3384-f4e993a42fe7@redhat.com>
Date: Thu, 20 Aug 2020 19:39:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200820161456.GG99531@linux.fritz.box>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/08/20 18:14, Kevin Wolf wrote:
> I just don't understand why 99.9% of it were okay to do, but the final
> bit that would make the switch a lot more seamless to people is asking
> too much. You're familiar with the state after your patches, I'm not. I
> assume you're also the one who sends the pull request, and anything
> developed after that pull request will mean that people will already
> be impacted.

Because that 99.9% was done according to a plan of avoiding half-baked
solutions, and only make decisions during the initial conversion that
are maintainable in the long term.  All the design and the work came
from that one principle.

Since total parity just cannot be attained (because Meson just hollers
and exits if you try to do an in-tree build, or because Meson just
places binaries mirroring the layout of source tree), anything that
tries to mimic of the previous buildsystem in unsupported ways is
half-baked by definition.

Some half-baked solutions are easy, and can be accomodated.  For example
take "Meson produces qemu-system-arm and tutorials says the binary is
arm-softmmu/qemu-system-arm", which Peter requested.  I would have
gladly done without it if it was just for Peter's muscle memory, :) but
the issue with tutorials is a fair one.  It's literally 3 lines of code
and I can add them easily.

Dropping in-tree builds is also an issue with respect to tutorials.
However, dropping support for in-tree builds simply requires a
good-enough warning and it can be done just before the release because
people using tutorials rarely build from git master.

If it's a matter of "I don't want my workflow to change too much", I'm
not familiar with everybody's setups and requirements and it's not a
precise-enough requirement for me to write the code (and block the
inclusion of the pull request).

What you're asking is not the final 0.1%; it's a completely different
thing, because it _must_ be by definition half-baked.  For example here
are all the tradeoffs that come to mind:

- given the argument about tutorials, should the in-tree "./configure &&
make" support extend to linking binaries back from the build tree?  All
binaries or only binaries that existed at the time of the conversion?
Should the linked binaries be placed in arm-softmmu/qemu-system-arm or
should it be in ./qemu-system-arm?  Any of this choices introduces
potential confusion to whoever follows a tutorial so, arguably, a
warning would be better than a half-baked solution inasmuch as tutorials
are concerned.

- if binaries are linked back, should they be kept in .gitignore?

- should distclean also be kept in GNUMakefile? (probably, since
distclean is _especially_ useful for in-tree builds)

- who is responsible to fix it if the support bitrots? (it will,
especially since with Meson things like adding a binary only require
touching one place: nobody will remember to add the binary to GNUMakefile)

- should I also add a CI job that tests it?

I'm rather happier to spend my time explaining details of the conversion
if they have to hack on the build system in the near future, than to
gather a detailed answer to these questions and any other that didn't
come to mind.

> If you ask me to do pause my work, instead familiarise myself with your
> work and do that final bit so that you can then include it in your pull
> request, I'm sure your employer will pay for more time being spent
> rather than less.

You don't need to familiarize with my work, you only need to familiarize
yourself with out-of-tree builds which almost everyone else is using[1].
 With out-of-tree builds, there is arguably no change whatsoever for
day-to-day development (as long as you don't touch the build system of
course).

Thanks,

Paolo

[1] For example, among the people in this thread who were using in-tree
builds, Stefan is using meson for his new project so presumably has
switched to out-of-tree builds, and Eric has already switched to
out-of-tree builds.


