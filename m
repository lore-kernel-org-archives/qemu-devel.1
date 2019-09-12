Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96113C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C4EC20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Co7m5bIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4EC20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8M14-0006hn-8s
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 06:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8M0P-0006Il-4b
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:07:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8M0N-0003IR-Qr
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:07:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:52810)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8M0N-0003HO-KL
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:07:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id x2so1448995wmj.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 03:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=MAEg9pYivqRhWtnNRO9eYnVPIAOQ2NqKFaa3XOCQUeo=;
 b=Co7m5bIK+eGPcHfzb93cfSVhI4RXmVqAqpMUojGpa8P2zBK0CjisW9Fv5FLg5mpDcL
 1drZFB46frfER4Ygtaa4FQm8NSX4NNxoyJQtHVTdHDM7Hc/nNmiyuf5ML+JS6+AjWp3V
 BIavn8BgbD56HcWAa+QSjxTzUqWkSds7cfmx2bTxtlztPZ1rSs8B9RqwphT8bx6F15UM
 BXs697ftOK1fueADAAn1UYmatVkUgxZONNEhf/+ARutFsY5E3KcBEsaAonTj/iOkKgw8
 rVqAFJiYxdBjiI9SkGtPW+yu/1MmorDPHcFmZ874jLXZ3abl4C68K7yctvr+Tuix4eWD
 pS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=MAEg9pYivqRhWtnNRO9eYnVPIAOQ2NqKFaa3XOCQUeo=;
 b=UBjveaTcC0b/GAjeOC5nZ60+iCtV/2dAzMvSDVA7KJShdX+UWcEPpjuc6pQXe0pb8e
 UjdBPatwwxnrvNOev/1O5IxhUaWKm2JwZ05ahWMwF5DMF/aYk/85juHT4MqSh0Zr0F7I
 j7vct/AECj2TJ2r4rxVDxqZ8pkZOv8UXQRMB4ST7TGssi5Ecz7KfvF0KO9FSlDtdMlc8
 B/YuKP7Q7VElDC1lEMvo3zYGt7/zR2kfMOU+5dUcwGFAo6K2aQMqS+LiE+4UeBT9ioQX
 z8q4FdxY3w5BcUo1Z0sunFzFCneZaU/bbfigYi/I3V/2FtcaN+LBDvMuN2+TgaLoP56/
 7kEg==
X-Gm-Message-State: APjAAAUwIJHK+E8ty0DHmvcgn3yMxRpmUKY/W0pv6EgIMMi3XCWimEcM
 aTvn48fmBGueXaqIbZRvO4t/qA==
X-Google-Smtp-Source: APXvYqxbo2N8vLSQ5G7U8Ijg3bNl0NEc8nUD8AJR5jifi34xmZhtc7d2WFp9f79R0IXW9E7vKK1Q8g==
X-Received: by 2002:a1c:2144:: with SMTP id h65mr7909963wmh.114.1568282829329; 
 Thu, 12 Sep 2019 03:07:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r2sm4271735wrm.3.2019.09.12.03.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 03:07:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E79C51FF87;
 Thu, 12 Sep 2019 11:07:07 +0100 (BST)
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <87a7cty0tv.fsf@dusky.pond.sub.org> <875zm5yzgq.fsf@linaro.org>
 <87d0g6dnbc.fsf_-_@dusky.pond.sub.org> <87y2ytzy17.fsf@linaro.org>
 <CAFEAcA9Db2ENw7e_1-XOTbHeV=sp_zFxqoq4se+63OK+mQaeew@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA9Db2ENw7e_1-XOTbHeV=sp_zFxqoq4se+63OK+mQaeew@mail.gmail.com>
Date: Thu, 12 Sep 2019 11:07:07 +0100
Message-ID: <87v9txzv3o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: Re: [Qemu-devel] TCG plugins and the GPL (was: [PATCH v4 00/54]
 plugins for TCG)
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
Cc: Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pranith Kumar <bobby.prani@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 12 Sep 2019 at 10:03, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Well the first thing will be we are not intending to offer a guaranteed
>> ABI. While we don't want to be changing it at a whim there shouldn't be
>> an expectation that the plugin interface will maintain backwards
>> compatibility (unlike the command line interface ;-). There should be an
>> expectation that plugins will likely need to be rebuilt against the
>> current source tree from time to time.
>
> Wait, what? From my perspective the whole point of the plugin
> interface is that it should be stable, in that at least there's
> a good chance that a plugin you built will work against multiple
> versions of QEMU, and if it doesn't then it should fail with
> a reasonable error message telling you to update. I'm not
> sure we should be landing the plugins infrastructure if we
> don't have that much stability.

There is a big fat blurry line between "set in stone" and "not requiring
you to re-engineer the plugin every QEMU release". I'm saying we should
reserve the right to extend and change the plugin API as required but
the expectation would be the plugins will continue to work the same way
but maybe with tweaks to the API hooks to support additional features.

It's also a pretty young interface so I would expect some evolution once
it is released into the field.

One problem with the anti-license circumvention measures being suggested
is it will mean having to recompile plugins for any given release. This
isn't a problem for plugins we write but it does add an extra step for
out of tree plugins. Maybe being forced to re-compile (but not change
the source) is a hurdle we are willing to accept?

--
Alex Benn=C3=A9e

