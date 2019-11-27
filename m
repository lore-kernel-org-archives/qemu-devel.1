Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61602C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28EC2204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUdufGvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EC2204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia2q0-0001yL-Tx
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 14:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ia2lC-0007L8-6z
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ia2lB-00027y-9N
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:13:58 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:41890)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ia2lB-00026k-3w
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:13:57 -0500
Received: by mail-pl1-x634.google.com with SMTP id t8so10151880plr.8
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 11:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cVi4SDW3zgmcQiv99H3YNyDW1Bmnvv1njWuQ2UJDy44=;
 b=uUdufGvSpPRYi8hYYFG0xnpKbYP9PxwASXEfXHHZ0FdkxWFJcLqlsSopfruksP4XwG
 G/V/uUBVRXTuCEgUYp1u6tlQ5/bFGKfIQNsEayFDVwCbmyhv/iLwViREcaIZf56rrNXH
 AYBl/sV2KPZclNryehaBsdmC3/wfW9Te/w0AgeqmvuHw9TOHUj8uI+CV46o9hEZ+/yaP
 JVfdtMZFcf5H5nwff2FjzE0aqptt9rNOGcK4zuYAv8QDNCMSQOoV6AUtxuBKaXYNe1eJ
 5U8BEZiUHNUKUx/+Gr51xkbt/gOKVwrAGXMo7IIWAVjXMNO+lMPHyo/QB2zH0Hy+XW5Z
 6vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cVi4SDW3zgmcQiv99H3YNyDW1Bmnvv1njWuQ2UJDy44=;
 b=A6LXfIBMOMuQK3+xQbq5Y3/HjzuT+hNEpwD5Z6GozKRirYohESsJSzqiP7fWVRxIy+
 UW4/bkaYKfiFENG8eyD3vRKYhvMczpXdUVwTLc16OJKabFuLaQSMxLas5ewAFw5bUDKP
 G2T/18xDqoU3we2iIYzoNXPnOuq50nEJIsGVyjv/1sncrY7+c3dd/9m+/FvOG10kCsAm
 nHmeO/bKiXWgg7qyZWsPGonW8D4+NEDT/gLfnrTmlGK9gNozX4B34N+7Xj7B4MOZgLbL
 p7Mw/F1ALF6xbYa88M+MBeuT3GcF5j9b7g4Enfzl03waHLR+I+MT3pa/fCqaSDlwJ1WE
 /2vA==
X-Gm-Message-State: APjAAAUsp6AkdgweO/cRbSJUrR+9Sy19uIRxJe7KIqqYjlG0kmY597wc
 CRKAZktKQxCMSBlnJ6quICdz7YWiwbwcqEND2M0=
X-Google-Smtp-Source: APXvYqxbAjy8braW6EKN+yOhCcMts2bGPjFjYO6ibBp6ef6LdmmaSn3gVaE6c3SMSRryKh8UWu8jV7KCP0Fsi9JZNn0=
X-Received: by 2002:a17:90a:bf81:: with SMTP id
 d1mr7881709pjs.125.1574882036060; 
 Wed, 27 Nov 2019 11:13:56 -0800 (PST)
MIME-Version: 1.0
References: <20191126222607.25653-1-jcmvbkbc@gmail.com>
 <87tv6pf8bn.fsf@linaro.org>
In-Reply-To: <87tv6pf8bn.fsf@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 27 Nov 2019 11:13:44 -0800
Message-ID: <CAMo8Bf+ck39JZu=ZjfkT5XqTzUQK7QywMZVb09_8qiNuZZSB+w@mail.gmail.com>
Subject: Re: [RFC] exec: flush CPU TB cache when breakpoint address
 translation fails
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::634
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 27, 2019 at 11:06 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> Max Filippov <jcmvbkbc@gmail.com> writes:
>
> > When a breakpoint is inserted at location for which there's currently n=
o
> > virtual to physical translation no action is taken on CPU TB cache. If =
a
> > TB for that virtual address already exists but is not visible ATM the
> > breakpoint won't be hit next time an instruction at that address will b=
e
> > executed.
>
> So the userspace has run once but is currently paged out?

Yes, but not necessarily paged out, just not in the CPU TLB.
Or it has run to completion and when you start it next time
it gets loaded to the same physical pages.

--=20
Thanks.
-- Max

