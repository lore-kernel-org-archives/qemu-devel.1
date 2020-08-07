Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DDCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C5AB221E5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIDIpiIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5AB221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3z0v-0001Mc-6f
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3z03-0008R7-KD
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:49:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23421
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3z01-0004vm-Gm
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596793756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jQteGImHgiqIVDxrCyCD3U2AUAQYoYonzb6oG6R9EZE=;
 b=HIDIpiIZsMHQ8tkPF6HhKtmuSGPhxtS5zGKoABTYUACoOgglPkuactPUV+3E/ge2BaYEA8
 znk8Ur9CPMlpvao4tm/cDN0HURXPe2cnbIx1edsKqltfCv/iQ/oB2zAKnoisUj1uKBOlyI
 wtnc6GsSgx9xoxv3JbkPTmhOeSCK/Ns=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-IKqRKR-gNnm4eZA6tLY1BA-1; Fri, 07 Aug 2020 05:49:15 -0400
X-MC-Unique: IKqRKR-gNnm4eZA6tLY1BA-1
Received: by mail-wm1-f71.google.com with SMTP id c184so3753867wme.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 02:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jQteGImHgiqIVDxrCyCD3U2AUAQYoYonzb6oG6R9EZE=;
 b=Vqb5f7r8o0SKIXfbB66eM8h7yNuOLSNErrFZsfyYJQ+tYNOf8G6eAbxI55pUTpf21o
 zMiH+K4Y3jGy0jMggo1VIm8QRd1Kk30FYFV4rQhVuP+kFt4t+csdcD+weHSz0OazR+vE
 YZ7+XdRKiJz9uf/Yy9IuMn0rCK7dzx37tTbdm+c5UxFaSmUpqCqhQU8Wv2fWa7xyZS62
 ClRB83jHcxyzY1RJal+vIDFRU0jgQULIc6jwdGGwn6OpcTb0tkKQxZXj2CKeiY9tcVGK
 eab33BypvdTVjO5cy9CieDJIFHkcbNqJf7j9kjwPb5qYGvNlS3RMA8DbA3V8R8TmV59F
 znXQ==
X-Gm-Message-State: AOAM531GQlCBSQeaG29LPcv0t4crRPbnBm+J5Y/Syx7CeV5fz/BO+vMf
 56Q4taAzmhFdat9Q6Ul5h/gV9JLwVXE0L6G2GHVYjeYikdTsl/6Tm5hEfIVi4c/OOyLvXLAGnSw
 VFOlpI9s6UGqgd+E=
X-Received: by 2002:adf:e550:: with SMTP id z16mr11348171wrm.329.1596793753595; 
 Fri, 07 Aug 2020 02:49:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxszLiZr5fSkbNG+ObW+ZxnfMFmDWv220qCgbw4G624GuyzEraVlR5UcTl8FXeUviApYaKE8g==
X-Received: by 2002:adf:e550:: with SMTP id z16mr11348153wrm.329.1596793753296; 
 Fri, 07 Aug 2020 02:49:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id b129sm9571260wmb.29.2020.08.07.02.49.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 02:49:12 -0700 (PDT)
Subject: Re: [PATCH 005/143] meson: rename .inc.c files to .inc
To: Peter Maydell <peter.maydell@linaro.org>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-6-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_mN3XrgxRbhq5U0B=OxBq6T3DXymb4_U-tzOya=W-AbQ@mail.gmail.com>
 <d676a107-c49d-ab3f-f6e3-f6b594af9c4f@redhat.com>
 <CAFEAcA9JLqTHLLEy1WtGkvRYGSupX0PPUYAmnZ4Q_kGaJ3cSTg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ef5c913e-33ba-e1da-c948-c0d6ca102f3c@redhat.com>
Date: Fri, 7 Aug 2020 11:49:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9JLqTHLLEy1WtGkvRYGSupX0PPUYAmnZ4Q_kGaJ3cSTg@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 11:30, Peter Maydell wrote:
> On Fri, 7 Aug 2020 at 10:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 07/08/20 10:59, Peter Maydell wrote:
>>> On Thu, 6 Aug 2020 at 20:25, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>> ---
>>> What's the rationale for this ? ".inc.c" is the project's
>>> standard naming convention for files which aren't headers
>>> but which are lumps of C code #included into a top level .c
>>> file. The .inc.c deliberately ends '.c' because that way
>>> editors will use the right syntax highlighting for the file.
>>
>> Good point.  It can be changed to .inc.h too, if that's preferrable for you.
> 
> Not really, though I guess it's slightly better than plain .inc.
> They're not header files...

Ok for the lack of a better option I'll switch.

> But we don't really want to build all these files before building
> all C sources. We just want to say "this .c file depends on these
> .inc.c files" and then let the build tool figure it out, surely?

With Makefiles we have two options:

1) build before everything, e.g.

linux-user/x86_64/Makefile.objs
	generated-files-y += linux-user/x86_64/syscall_nr.h

The way it works is that, by building the generated files first, we can
then rely on automated dependency tracking.  It is most useful for files
that are included widely, such as header files.


2) fine-grained dependency, e.g.
	target/arm/translate.o: target/arm/decode-neon-shared.inc.c

This needs no explanation.  It is most useful for files that are
included only once or twice, such as .inc.c files.


With Meson you have only one choice and it is a third option, namely
"build at the beginning of the corresponding target"; the way you
express it is to list the includes in the sources of that target.

The rationale is the same as (1); in terms of what is rebuilt when it is
the same as (2).  It may remove a bit of parallelism: if you edit
helper.c and insns.decode, however, helper.c won't be built until after
decode-insns.inc is created.

>> The problem is that Meson decides if something is a source vs. a
>> generated include by looking at the extension: '.c', '.cc', '.m', '.C'
>> are sources, while everything else is considered an include---including
>> '.inc.c'.
> 
> Is this hardcoded in Meson? That seems pretty suboptimal.

Yes, it is.  It is certainly a different mindset not being able to
control every aspect of the build.  On the other hand surprises are rare.

>> The files are added to the source list with "arm_ss.add(gen)".  [...]
>> they are built before other target-specific files for ARM targets.
> 
> Do you mean that it just adds an extra implicit ordering constraint,
> such that if we need to rebuild both files not in 'gen' and files
> that are in 'gen' the 'gen' ones go first, or that Meson really
> builds all the 'gen' files first? What happens when you edit a
> .decode file? How much stuff gets rebuilt?

Only what's needed.

>> The question then is if Meson could be changed to cope with our naming
>> convention, and unfortunately the answer is no.  The root cause is that
>> Makefiles list .o files (and uses implicit patterns to connect .o files
>> to the corresponding sources), while Meson lists .c files.
> 
> Can Meson handle "this .c file needs to be built from something else?".
> Presumably so, that's a common pattern for flex/yacc type tools.

Yes, of course (we have cases of that, for example with QAPI sources).
Generated sources that are top-level (not includes) also don't hamper
parallelism of the build in any way.

Paolo


