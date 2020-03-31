Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858BAC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3362078B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="uML5YSRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3362078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIkA-0003FI-FF
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ilg@livius.net>) id 1jJIjT-0002VM-Eo
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ilg@livius.net>) id 1jJIjS-000073-Jg
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:23:15 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:38352)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ilg@livius.net>) id 1jJIjS-00006Q-AH
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:23:14 -0400
Received: by mail-wm1-x32c.google.com with SMTP id f6so3187787wmj.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 08:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=In4+5TgHzuIxOMk/RY1ZrlDE7/evK4rFWabNgkoJfiQ=;
 b=uML5YSRFPwU8xwuDrlOQuejM9U9517IoinYXH91OF5I0g3ujcvjpFd8g2E92hjNfcK
 X4dgwHaj6keWCzYXw02s4JEqdlYYQX/A0bOgipJpuy77D90lfCCkib1AeLlqSa1ONr/p
 wjosKeIji9KyO5GuiOatdT5CoeJf6irUOxYYiz7/dFGEGibhB2cGk3r16y9BJSZ+ay8W
 eRv9mG+7PHX3yiHVJ76mv8hvRgwbIgy33kDNvBxXxy/UsI8Klg2ZNpP6OQSgK6j0w2SC
 SfHT/Us1WzMzfE9ZlVMR4GjoVcZWgPQO3lnwm/fMEENbyXzoRGreqiv89fXu+hGZF6sE
 vgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=In4+5TgHzuIxOMk/RY1ZrlDE7/evK4rFWabNgkoJfiQ=;
 b=Mly+khJvBz+eQJgWhblQ7Je/C+uhgtSsQF8wSmDXsvqmiMyeUegFKvxhbPn0e5nubb
 eVtggOzlcgD0S08BUAj5fKt9NCpbDex/3TraC3LjPkBgU4pMTP+jBZfwPen80kjGsHaO
 +tgkinif4hQhVPPW7wa+VAvjSAZ2QBVo00WqwF4j/6Wx7nMmz0uT/kDe5XZlSTP90A0+
 P+srpR9MAQ8ULlipkzsQ1XzNc4CdsHLyni95hUp5zj9lujKPnKNuXiPZfPZpafb/2d3m
 lnkl1RKN3/88Zb1wHsDQVSutJAlIKEtl0SeqjwPm86jV0Qh9+e4iUOLfo47zeq4nykUc
 tTZg==
X-Gm-Message-State: ANhLgQ1JW47LVZcmec8lPKS/NZAphhf9cit+UwSvopBIYMPLyJlMQfIW
 YgjCcLMa3ezIR6+He7JvHugyVQ==
X-Google-Smtp-Source: ADFU+vswlsA2CgWke+PJ8nAzFE0MwrCqd+C3bzkz1MOMfGnzuTVj0IM8GX9hpT9K4ig206EWdAmVwA==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr3801375wmk.125.1585668192709; 
 Tue, 31 Mar 2020 08:23:12 -0700 (PDT)
Received: from wks.local (5-12-53-142.residential.rdsnet.ro. [5.12.53.142])
 by smtp.gmail.com with ESMTPSA id f12sm23630124wrm.94.2020.03.31.08.23.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 08:23:12 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: deprecation of in-tree builds
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <20200331120718.GB7030@linux.fritz.box>
Date: Tue, 31 Mar 2020 18:23:10 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <48369478-CFF5-43DD-805D-5BABA4C2BE91@livius.net>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <20200330134212.GO236854@redhat.com> <20200330143759.GD6139@linux.fritz.box>
 <c0a1dc94-c3f2-696e-743f-aa15ef995094@redhat.com>
 <2D490715-F32F-4A34-A31F-5709B28FB6CA@livius.net>
 <CAFEAcA-KKd0bjE17MPPFv45=S+x3jUj9uA6_UQmb7ts-yu5Ong@mail.gmail.com>
 <C0360478-EBDE-419B-9917-2EFAC580BEF3@livius.net>
 <20200331120718.GB7030@linux.fritz.box>
To: Kevin Wolf <kwolf@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 31 Mar 2020, at 15:07, Kevin Wolf <kwolf@redhat.com> wrote:
>=20
> Thanks for declaring my workflow irrelevant, I guess...

Sorry if this happened, it was not intended.

The intention was to point out that there are also other use cases of =
running the QEMU builds, different from those specific to building Linux =
distribution packages.

Given the large number of libraries and tools that the xPack Build Box =
workflow supports, it is no surprise that it accepts both out of tree =
and in tree builds.

Just that for a large project like QEMU, since I usually run a =
multi-platform build at once, having multiple copies of QEMU in each =
platform build folder would be less space efficient than having a single =
copy in the folder with common sources.


Apart from this, I actually don't mind, you can choose whatever solution =
you want, I guess I can accommodate it somehow.


Regards,

Liviu


