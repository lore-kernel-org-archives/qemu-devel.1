Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F69C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1DCF22CAE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Slu/8rhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DCF22CAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3xvk-0007ke-P3
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 04:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3xuw-0007LF-SO
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:39:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47097
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3xut-0005DI-LO
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596789594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eX3IF8HeAjYDqvIILRx2mqssuDX7EAUPWuZrJDK3UqA=;
 b=Slu/8rhrKrAhEunZ9v1pLd66H/8UAED/33l99GegYh3Diw0ctyNvGMXgvTn8+nfZDeGZgF
 nfftVMkOPzpb1i+t/9A1wL1Zr94zzrFXoiwnoAAMMGleUlndkWjDuciTuS3rhfmGyPwCzX
 5es6z0+R8py4Dzprdg6LpATJFis4EkQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-9anlFJTzMcyHRqGnPAaIAw-1; Fri, 07 Aug 2020 04:39:50 -0400
X-MC-Unique: 9anlFJTzMcyHRqGnPAaIAw-1
Received: by mail-wr1-f70.google.com with SMTP id w7so462029wre.11
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 01:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eX3IF8HeAjYDqvIILRx2mqssuDX7EAUPWuZrJDK3UqA=;
 b=AtUlNHQRLhjDvJRgR+AGSokxsCaLzaFRnj5JZFfOBlCMQGpAXhfE+vJti/JUT9I/PG
 iOvRoj/EDHuYiW8Ed07WShQBUhjwNUy+So38WkCXOrlxoauJ8j8W48n10uWRnpw/gTTQ
 BoHaJqm4vEjthtbqdphv0Oo/2Mpf11fMc8APH9+DZHSxWWydc9jDNZ4KZltruFaAOtu4
 N4uU+2QulIAzP9g0N4QHP/ZoNBkWW/QMx2N5lOVEWYHUnOED8Ohz6QPVzq/bZU4cGk90
 yE8PsRArV9XUTUw0e23v18gyJFdFf9b7zQwuaY5oETAGTP0FJSysTeF9D9/A3zk484Do
 xLBQ==
X-Gm-Message-State: AOAM530UpX1Hwv8a0Nzl48UrgX/+y8D1zdNY8KxN5eODzkd3gIfsJtPy
 bC8+ON7HtPfMXcjp3ubdHM6Z89BbNMVQ2ndUz8H7mHvjslPIiS5EvPzpcbiqWkDazmJtYC+P+BS
 /BAmFyfsV7hvOBXY=
X-Received: by 2002:adf:f08a:: with SMTP id n10mr11819291wro.351.1596789589262; 
 Fri, 07 Aug 2020 01:39:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwmipV0dji1WkedNr/3P7hQD0QsS51ato/iZmVwbf2KfNY3XtX0fChHg55vH6bWph+cKsRrw==
X-Received: by 2002:adf:f08a:: with SMTP id n10mr11819259wro.351.1596789588920; 
 Fri, 07 Aug 2020 01:39:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id u6sm8961937wrn.95.2020.08.07.01.39.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 01:39:48 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Markus Armbruster <armbru@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <87364y28jp.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d7b7f59-ec3e-1f74-d1d4-359e3388f0f8@redhat.com>
Date: Fri, 7 Aug 2020 10:39:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87364y28jp.fsf@dusky.pond.sub.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:00:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, stefanha@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 09:56, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> This the more or less final version of the Meson conversion.  Due to
>> the sheer size of the series you have been CCed only on the cover
>> letter.
> 
> Perfect timing: right before I drop off for two weeks of vacation.  I'm
> excused!  *Maniacal laughter*
> 
> Have you run it through our CI?

Of course not. O:-)

> without even more weeks of intense rebasing.

FWIW there were only three hard rebases from 5.0 to 5.2:
qemu-storage-daemon (by far the hardest), linux-user's syscall_nr.h
generation, and fuzzing (easiest except it required conversion of qtest).  S

I would like to merge this on August 21st.  I hope to post a
"definitive" verion on August 14th, and hope to work with Peter the next
week on getting it to pass his tests.  Perhaps that's optimistic though.

Depending on when it's ready, I can pick up the series that gets rid of
Texinfo, if Peter and yourself don't want to learn Meson just for that.

Anyway, I think this is the no-return point: if people say no, I'm not
going to push it any further.  If people say yes, we'd better merge it
quickly and be done with it.

I do understand resistance.  It's a new tool replacing a 40-year-old
standard; build systems are not fancy; and there is a substantial sunken
cost.  All I can answer is that the line between sunken cost and
Stockholm syndrome is a fine one.  I cannot say this stuff has been
*fun*, but at least the debugging was refreshing compared to Makefiles.
 Again not a very high bar, but it's something.

>> It should be more or less bisectable.  I have not tried building
>> _all_ steps, but I have tried both before and after each major one.
>>
>> Build system rebuild rules seem to work reliably.
> 
> Is it faster in common build scenarios?

Some oldish numbers:

                                 before    after
----------------------------------------------------
../configure                     18s       43s
../configure && make -j18        169s      172s
make -j18 (do nothing)           4s        4s
make -j4 (do nothing)            6.5s      4s
touch ../configure && make -j18  52s       62s (does nothing in make)
touch ../configure && make -j4   71s       62s (does nothing in make)
make clean                       19s       2s
make -j18 clean                  3.5s      2s
----------------------------------------------------
ninja -j18 (do nothing)                    1s
ninja -t clean                             2s
ninja -j18                                 96s (43s+96s=139s)

../configure becomes slower because minikconf.py moved from Make to
configure time, and because it has to generate the massive Makefile
which it didn't do before.  In fact it generates the build rules twice:
Meson first generates build.ninja, and then ninjatool turns it into
Makefile.ninja.

Most of the time is recouped during Make though, and a do nothing "make"
become faster, especially at lower -j.  This is expected because the
massive Makefile (while producing essentially the same rules as before)
is parsed directly by Make, without having to execute complex Make
macros.  It is more visible at lower -j because parsing the
non-recursive Makefile is serial, while the current build system uses
recursive Makefiles for which the work can be parallelized.

ninja is quite a bit faster than Make.  It also stores a binary
representation of build.ninja, so its do-nothing times are better.  We
can think of switching to it for the main build, once all tests are
converted to Meson.  Advantage: it lets us kill large swaths of
ninjatool; disadvantage: it introduces an extra dependency.  Even before
that, developers will be free to alternate between make and ninja.  I
haven't bothered so far, but then my machine does -j18 and not everyone
has that luxury.

tl;dr: for now, not much, but it can only improve.  This is consistent
with this series reaching the "worst mergeable state".  My objective was
only maintainability and not performance (without regressing on that front)

Another useful feature, that can be used more in the future, is
integration with external tools such as sparse (now) and clang's static
analyzer (later).  This is because ninja (and ninjatool) are able to
produce a compile_commands.json file that summarizes how to produce the
object files for the whole build.

> Not a particularly high bar to cross: our Makefiles are full of the kind
> of black magic that keeps simple things simple (which is quite an
> achievement; kudos!), and makes not-so-simple things really hard.

Looking back at the goals:

- "it should remain trivial to do things that used to be trivial":
achieved though the syntax is more complicated.

- it should be "easy to do things that are a matter of cut-and-paste
from something that already exist": that would be for example adding a
new target, or new tools to contrib.  I added AVR and RX for this rebase
and it was the least of the problems, so I'd say achieved.

- "it should be possible to modify meson.build without knowing [details
of the QEMU build system such as ninjatool]": achieved.

- it should be "possible to do everything else".  Of course some parts
of meson.build (QAPI, tracetool, modules and the building the emulator
binaries) are complex.  The only part that is worse than before is the
forwarding "trace.h" headers (patch 4).  I have actually thought of a
way to fix that, but I am not 100% sure it works so I don't plan on
doing it before the merge.

- "drop Makefile magic in favor of build rule generators written in
high-level languages": achieved

>> 3) the idea behind using Makefile generators is to have stable
>> code written in a high-level language instead of Makefile magic
>> that tends to grow by accretion.  So even though ninjatool is
>> large at 1000 lines of Python, it can already be considered mature
>> or even "done".  It had only ~15 lines changed since the last post,
>> and whenever debugging meson.build issues looking at build.ninja has
>> always (literally!) been enough.
> 
> The major drawback with generating code is usually having to debug the
> generated code.  Your experience of not having to do that is
> encouraging.

Yes, that's my point expressed in a succinct way.

Paolo


