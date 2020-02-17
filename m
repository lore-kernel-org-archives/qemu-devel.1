Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71EDC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:07:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92DBE206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TZXfJiiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92DBE206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3h35-00020q-Nt
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 09:06:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3h2W-0001cM-7a
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:06:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3h2U-0006vj-Ui
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:06:23 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35503)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3h2U-0006vL-PO
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:06:22 -0500
Received: by mail-ot1-x343.google.com with SMTP id r16so16189285otd.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 06:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sT5rS5mtTwfxrsIKdBlCBMDl+7FxgN9TwTiJWRvvo6M=;
 b=TZXfJiiqsl0D4ZlRtvj8vEppbXweEKohoOm2XvcsQxX5HR8m9flHHGsoimv7z3Ye1Q
 6A7T7KjqnLJjLpkT2ny1iHb+VCMO+2zYnEfECgh6Ood/0z5MUpTs9UGyO4HMxWZslfuS
 cZn2S6upnY/vHhI3W8eAcTq3nMabEZHZ4VE2MUATM6v0MeI7ppLphhXPrr1GnkucJJOT
 HeBXKJ0mra/C7aU0MoNB/IRc+LWciFD8RABlWhZnqaQXyelNS8SHvfdRMCbyH0JD9ZTi
 tBF69P9gvHojnOSGvuaCGYgCU5GxqbeHts206VTZE5jBnvLt2kGNyOhlPcDHGgj2Oxkp
 vnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sT5rS5mtTwfxrsIKdBlCBMDl+7FxgN9TwTiJWRvvo6M=;
 b=HdjXipZ3apUuQWICtxhs3Nr1zg2Ztdgbbf44ndWiZ+jeGpbwQzCi8F0E6MLtm2MNWN
 c5ohd30FCcodIf4/K4oJDD+6hLoF/mOsXk+WIzSLn6oZToCMbfrHQB1yG92S5kk2/6jb
 y1xcVX4fEcu4Y6xbg5HSMYRQ7b2LH6vSAOFjGghkjwFqqzyTXvs0a993c5eEi4GueV39
 7TTnJZ51oq7YMNl/bAMN15mUTkbYgYNH7kZ/rLQz5QfYCwGsvu96TMe7VRCcdbIxsXN9
 gZaT+M/8d89OpEgnEJnJUKkp4ZqToWA660+FCtP8CjVXd5MWCW/moicdp8KdK9lLGVnn
 F4HQ==
X-Gm-Message-State: APjAAAVtna03kjSXnbEd8QhzVBnOqSpMAi24IPvvRHTN1v1q26m7e19R
 4YwoEW0v9qWaFLKWA6ikgVwnQklpzoYgGImqaxDYtg==
X-Google-Smtp-Source: APXvYqz7ep63oXIRlEObFbOQ/AJnvNLbju56n/gMVL7gD1/5w71jzhlcm7LP4SEuipkJJp69TAByRM0eb70Btf+x/tw=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr12369694otd.91.1581948381793; 
 Mon, 17 Feb 2020 06:06:21 -0800 (PST)
MIME-Version: 1.0
References: <20200215154706.19837-1-philmd@redhat.com>
 <20200215154706.19837-2-philmd@redhat.com>
 <CAFEAcA9cZHWziyk6VzfaxrqjCNNOmnmSkB=uuGJMp0TL521mAQ@mail.gmail.com>
 <8c4570e1-cd9b-9d33-2756-5c223df282ee@redhat.com>
In-Reply-To: <8c4570e1-cd9b-9d33-2756-5c223df282ee@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 14:06:10 +0000
Message-ID: <CAFEAcA-hyEVPeT1wakaft6m3_WD9XG3eYFAwJJgoHRAZ1nntag@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/ipmi/bmc: Delay timer_new_ns() from init to
 realize to avoid memleaks
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 at 13:48, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 2/17/20 2:25 PM, Peter Maydell wrote:

> > So we now call timer_new in realize, and timer_del in unrealize,
> > but timer_free in finalize. This seems unbalanced -- why not
> > call timer_free in unrealize too, if we're moving things?
> >
> > Also, this is a case of code that's actually doing things right:
> > we free the memory that we allocated in init in finalize. So
> > we're not fixing any leak here, we're just moving code around
> > (which is reasonable if we're trying to standardize on "call
> > timer_new in realize, not init", but should be noted in the
> > commit message).
>
> While I understand your point, I am confused because the documentation
> on unrealize() and finalize() is rather scarce (and not obvious for
> non-native english speaker). I think I'm not understanding QOM instance
> lifetime well (in particular hotplug devices) so I will let this series g=
o.

Yes, the documentation is really not good at all. The
basic structure as I understand it is that we have two-part
creation and two-part destruction:
 * instance_init is creation part 1
 * realize is creation part 2
 * unrealize is destruction part 1 and is the opposite of realize
 * instance_finalize is destruction part 2 and is the
   opposite of instance_init

(Base QOM objects only have instance_init/instance_finalize;
realize/unrealize exists only for DeviceState objects
and their children.)

ASCII-art state diagram:

  [start] --instance_init-> [inited] --realize-> [realized]
     ^                       |   ^                     |
     \---instance_finalize---/   \-----unrealize-------/

In practice the only sequences we really care about are:
 instance_init; realize; unrealize; instance_finalize
   (a full object creation-use-destruction cycle;
    even if realize fails, unrealize will be called)
 instance_init; realize
   (a subset of the above: for non-hot-pluggable devices
    we will never try to unrealize them, so this is
    as far as it goes for most devices unless they
    returned an error from their realize function)
 instance_init; instance_finalize
   (the monitor does this for introspection of an object
    without actually wanting to create and use it; it's
    also the basic lifecycle for non-DeviceState objects)

The difference between hot-pluggable and not is just
whether it's valid to try to unrealize the device.

We should definitely be clearer about what belongs in
instance_init vs what belongs in realize. But where we
have both a "do thing" and a "clean up that thing" task,
we should put the cleanup code in the operation that is
the pair of the operation we put the "do thing" code in
(i.e. do thing in instance_init, clean it up in finalize;
or do thing in realize, clean it up in unrealize).

thanks
-- PMM

