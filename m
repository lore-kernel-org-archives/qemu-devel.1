Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0BFC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 08:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE2B02087D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 08:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcHcbLrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2B02087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQnys-0007lh-Pz
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 04:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQnxW-0006lY-0g
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 04:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQnxT-0006c1-AG
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 04:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602232858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EpsR0X6963uFHsS0pKbHGsm8+yQq5i8a+/uLirSlE+A=;
 b=AcHcbLrgrXa7V4WdfKsSoMv3EM0vTQxKVZKfoNNVrZbfrQp2rMzByc8UHpsUuNJgOBAF0z
 OGCksnVDPSGw1UYRuLUJm7PTGben9OLCi1dpN6LdZOhw6KAS04u4hc31B+sWlWRPpLVQ6B
 m7unoKFt7FrEWsVxkqfs++L8NXpO2fU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-3_sVrvknPIOh1n6T48ZIaA-1; Fri, 09 Oct 2020 04:40:56 -0400
X-MC-Unique: 3_sVrvknPIOh1n6T48ZIaA-1
Received: by mail-wm1-f69.google.com with SMTP id z7so3957275wmi.3
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 01:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EpsR0X6963uFHsS0pKbHGsm8+yQq5i8a+/uLirSlE+A=;
 b=rkqky9IYVfNKVSzIIkYa/zVVtdC54ZZaaTqwwa8QxuZdI9W9YwknipHCMZPYuS29dZ
 W36/oo1gUHwxPXV58t8xnUhNrO5gFeqSjYXJVeGzDSkTpmYxajvCxWB1fk40HP+dFRks
 M2EyqGsgISkbY1752nYeaNCiaZA9iT6+rTvna3GUQ7pqCGu7SQvAs+cezadd/j6lVIvy
 sJRzSMSX+kTs6GtkYBRHZIkbSxpEgVf4Wg1KRNbOY5wesBmee4fW8lYlz2hFt4W/17ba
 S4iPZOFpCSA81GuXupQL6izW/NPNYwV0k7HoSrN8qimvZd+NZ/VVW/CZbF6XDk7wM3Cg
 gpNA==
X-Gm-Message-State: AOAM533G1rlNzwXW4sAtiUqiNKvXl9yQIYGu+xs0fKUiJIQa8v0jxLAZ
 uxUVNzv09IRys3ge4mLLNkIMbu6HnpmVc1iLxwqOR0p580Ryh5g775s2JXtM+HB1muOU3hE/yqg
 9YuqBjSFMvzKPVNk=
X-Received: by 2002:adf:ba4f:: with SMTP id t15mr13240562wrg.335.1602232854824; 
 Fri, 09 Oct 2020 01:40:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+b4hqaCnPG+8B2vZ+KBTUOf3Klj+mdslaX1NfCNzdIjpp2xohGi84U+EW3Z1MiNAhBusI5w==
X-Received: by 2002:adf:ba4f:: with SMTP id t15mr13240548wrg.335.1602232854543; 
 Fri, 09 Oct 2020 01:40:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cee1:4797:6958:7698?
 ([2001:b07:6468:f312:cee1:4797:6958:7698])
 by smtp.gmail.com with ESMTPSA id h16sm11591423wre.87.2020.10.09.01.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 01:40:53 -0700 (PDT)
Subject: Re: more findable locations for compiled/generated files in the build
 tree?
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA-wP4NDc30WXVbWRZv3WDSNNjoxaeAA-rjATN_W2n5rQw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <36032642-9bea-8625-65a6-bd4afc7e459d@redhat.com>
Date: Fri, 9 Oct 2020 10:40:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-wP4NDc30WXVbWRZv3WDSNNjoxaeAA-rjATN_W2n5rQw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/10/20 23:33, Peter Maydell wrote:
> Is it possible to get Meson to put the files that are
> generated/compiled as part of the build process in more
> sensibly findable locations?

Short answer: no.  You won't be surprised I guess.

> I would generally expect
> that a file foo.c should generate into foo.o, and
> foo/bar.c should generate into foo/bar.o, and if we
> generate a .c file from foo/bar.decode then it ought
> to end up in foo/bar.c or something similar.
> The old build system got all this generally right.

Except for recursive make.  So for example foo/bar.decode did not go in 
foo/bar.c, it went to ARCH-softmmu/foo/bar.c (more precisely into 
target/arm/decode-bar.inc.c).  Not that Meson removed this special
case, but the directory structure generated by Meson is still a fairly
regular one, and there's generally a mapping from old to new:

  *.o from FOO-obj-y    -> libFOO.fa.p/DIR_*.c.o
  ARCH-softmmu/*.o      -> libqemu-system-ARCH.fa.p/DIR_*.c.o
  ARCH-softmmu/*.inc.c  -> libqemu-system-ARCH.fa.p/*.c.inc (no directory here)
  other generated files -> unchanged

with the caveat is that / becomes _ in the directory (I suppose it's
to avoid making the hundreds of empty subdirectories that we had too).

The rationale for putting each target's object files in a separate directory
actually matters a lot QEMU: it makes it trivial to build a file multiple
times with different flags and/or include paths.  If you think about it, it
is on the contrary quite hard to achieve that with Make, and it was the whole
reason why QEMU had recursive Makefile.target and the binaries ended up in
subdirectories like x86_64-softmmu/qemu-system-x86_64.

Anyway, here are some examples:

  old                                      new
  --------------------------------------   --------------------------------------------
  common-obj-y += dma-helpers.c            libcommon.fa.p/dma-helpers.c.o
  arm-softmmu/target/arm/translate.o       libqemu-arm-softmmu.fa.p/target_arm_translate.c.o
  arm-linux-user/linux-user/arm/cpu_loop.o libqemu-arm-linux-user.fa.p/linus-user_arm_cpu_loop.c.o
  arm-linux-user/target/arm/decode-t32.c   libqemu-arm-linux-user.fa.p/decode-t32.c.inc
  qapi/qapi-events-net.c                   unchanged

Out of curiosity, what do you use the placement of the output files for?
I generally just use touch on the source (rather than rm on the target)
if I want to force-rebuild something.  For the case where I need to
objdump a .o file or look at the generator output, I cut-and-paste
from the Make output; for example:

  Compiling C object libcommon.fa.p/dma-helpers.c.o
  Compiling C object libqemu-arm-softmmu.fa.p/target_arm_translate.c.o
  Generating 'libqemu-aarch64-softmmu.fa.p/decode-t32.c.inc'.

Paolo


