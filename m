Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BE8C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 17:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867E0224D2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 17:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkI9dnOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867E0224D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEznA-0007oe-Kp
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 13:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iEzmF-0007EE-NM
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 13:48:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iEzmB-00007B-28
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 13:48:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36263
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iEzmA-00006N-If
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 13:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569865677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=LZpBpbstK087ys3iSNUT8rGp2mTURYj8tTyVNzCXJAA=;
 b=YkI9dnOzzptdNkdrNkyCFRJmYdu8vK+uD5zFmdTfdiETsCdcMSCK1dwNV9AJRujNu6Y/Lf
 U1f94lA91AGPmZATf8YlK2mRZXTSUkSOxAxMIeSdAie7sK7k3e8LuICFuul15KJcfeyQ+D
 orllE9hW02jhjkzjWvGRESBsZmw2xBU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-wXJKpZ8IP6Ow6objDBZPnQ-1; Mon, 30 Sep 2019 13:47:54 -0400
Received: by mail-wm1-f71.google.com with SMTP id o8so161267wmc.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 10:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L8urXj/jwmKCEqV9oasIhHVJvAMNxVYfqxp5r6AXgVA=;
 b=Huuj7/yTkRgM1NMyKhnCaTJ6/vp7NYjNHKU9nB/vd9lsUyYHLVQQxzfvCxRe1B81Qm
 yiv04iXk+SXKbOciAmm4jv3pjG6hiMcm4uf/y9fuiors+Dhw+TuRAMhM841sFBzWX7V5
 t7Pn1XrfTPf+cBHzfecENFhQ3hkERfektSgCdsd64B3pYEUkg/p6q4puaBiKmUnEYyUY
 rgMAUPi0ogFMYLatGDDdDCv6pVLudZCJnJ38Df3WwAGQBhf4BkYjGuGEBcP8523iVKgy
 vVbjTyhl4gXOFp3sGR5Q4frJzb50WI7iKAtTI5R7Hvtcusa3Y0g4V7ISOLzzh1SwDkID
 0y1Q==
X-Gm-Message-State: APjAAAXUulTmbCDFJWKOn33w3zL7R5dFKSuvouE1W7R8F/uEKmMAB3Wr
 ZtUZFfHDQmlw9S4zbGyLbJyFvV+YaKgipCuqjbzn8gS86Z6IoZkWY9wNNncsnpMuYpOzB0HIBH3
 1r9reHzrk40nR1Ko=
X-Received: by 2002:a7b:c949:: with SMTP id i9mr289472wml.136.1569865673749;
 Mon, 30 Sep 2019 10:47:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxrK9FHrSGuw59OK6tQOq2lx/AxPv3r0CwWtLogN27UIVjSwlrlChbNmDTWzBlUEgA2FTpeSw==
X-Received: by 2002:a7b:c949:: with SMTP id i9mr289455wml.136.1569865673425;
 Mon, 30 Sep 2019 10:47:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id x6sm155761wmf.35.2019.09.30.10.47.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2019 10:47:52 -0700 (PDT)
Subject: Re: Lockup with --accel tcg,thread=single
To: Peter Maydell <peter.maydell@linaro.org>, Doug Gale <doug16k@gmail.com>
References: <CAEfK_44VEF17nRgzNvVe+MPmAfS34kiJ_ozubWFkVYV0rm71sw@mail.gmail.com>
 <CAFEAcA9nz9S4R+O9fwa0k38dB3r1smguG4bQRzwm1s0zJCvfDA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <96703fc4-cbeb-5487-89b2-78c37b40237a@redhat.com>
Date: Mon, 30 Sep 2019 19:47:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9nz9S4R+O9fwa0k38dB3r1smguG4bQRzwm1s0zJCvfDA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: wXJKpZ8IP6Ow6objDBZPnQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/19 17:37, Peter Maydell wrote:
> Not sure currently what the best fix is here.

Since thread=3Dsingle uses just one queued work list, could it be as simple=
 as

diff --git a/cpus.c b/cpus.c
index d2c61ff..314f9aa 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1539,7 +1539,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             cpu =3D first_cpu;
         }
=20
-        while (cpu && !cpu->queued_work_first && !cpu->exit_request) {
+        while (cpu && !first_cpu->queued_work_first && !cpu->exit_request)=
 {
=20
             atomic_mb_set(&tcg_current_rr_cpu, cpu);
             current_cpu =3D cpu;

or something like that?

> Side note -- this use of run_on_cpu() means that we now drop
> the iothread lock within memory_region_snapshot_and_clear_dirty(),
> which we didn't before. This means that a vCPU thread can now
> get in and execute an access to the device registers of
> hw/display/vga.c, updating its state in a way I suspect that the
> device model code is not expecting... So maybe the right answer
> here should be to come up with a fix for the race that 9458a9a1
> addresses that doesn't require us to drop the iothread lock in
> memory_region_snapshot_and_clear_dirty() ? Alternatively we need
> to audit the callers and flag in the documentation that this
> function has the unexpected side effect of briefly dropping the
> iothread lock.

Yes, this is intended.  There shouldn't be side effects other than
possibly a one-frame flash for all callers.

Paolo


