Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21095C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 08:01:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF06B20772
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 08:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RozonFfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF06B20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJYJK-0007Ls-6f
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 04:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jJYIL-0006Qc-EU
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 04:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jJYIJ-000872-Eg
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 04:00:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41809)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jJYIJ-00083H-6q
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 04:00:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id h9so29328348wrc.8
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 01:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=jvwlc/tvnqFow4+TMZIH3jKKO4FgC11h+zZtn07QCng=;
 b=RozonFfC2wQ1yEDXk5T4ZDxqtJ24hUFYjL+Nv8cXtT2ODj1lKpGYguPjkT9FJW7I8w
 0nX/0/0ziq3iIgWpFq67SPoq+2YyrTQB3K9P6+Sn1RfganPxg457nJiZGeRxbB9zNqgC
 FUSpby2ksRh4xkXBPvw3YrzGXxGCukMLqfg6g1ISC1nyPjnk9yvhk6uNlQIDKV5Ci6az
 jZosZw1wvJ6WuwTNZuEfatGJj0rkwfvzEl9kTPsf9Fe2vq2y6UaR4kgi4sNRYIs3hWh5
 PMlfE0JAOBId1wyIA5GiC+DNaouJ8iDk7KBK/GoeKGO237ifwLVrF1yVGJ/hVS0XwE6k
 8F5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=jvwlc/tvnqFow4+TMZIH3jKKO4FgC11h+zZtn07QCng=;
 b=THBOyUuSudt38WdlMdC8o3fu9nzV3K3mGmaFggoxogIMuVvvwqt1V8WrzCEaxsvdja
 Nkr4pakiErrLJtIxdSHAdnBZnjD//6vupvWsd6sRxkWK5ufMt9OU5wIdVWgdLDDvjA+S
 o7WtAHQsp/bnbKkVDAcTshx6xOt4iJIVGb4sZ8NP7A7/YdAOAfibX64HQ8I/KAND6Cth
 nhxa0vJF9ovAJJLdUJIVPEAY56bV65gQwFhKK4UuKJCYncEkbcA/DaWXrxHhlYZpoIY1
 IT6dkToW+JjkHe/uW8wMZQ1xs6R/4fVeMBS8o+fhTYV8RGsDH6xponakyNjcosfQi8DT
 zvIg==
X-Gm-Message-State: ANhLgQ0yQRfYTBGC1fEHQam0+fpa1PadS8cmEdceqOHMnItdSmWzw+Gt
 i29Yc3sWzD6PVAl2MP35XOdIog==
X-Google-Smtp-Source: ADFU+vvwxYHzl2OWoelMzkF9kVX2aL0GY6VfwCE9PPo4BenqredsjfolK9MiogDqxgidDVTvGGx2qQ==
X-Received: by 2002:a5d:468c:: with SMTP id u12mr26232689wrq.394.1585728013811; 
 Wed, 01 Apr 2020 01:00:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s9sm7173311wmc.2.2020.04.01.01.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 01:00:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 551CF1FF7E;
 Wed,  1 Apr 2020 09:00:11 +0100 (BST)
References: <CAOragkw8XgbEOiaE9n=wKzPAMkzdOcqA5VA5ihN80v-g7V8TRw@mail.gmail.com>
 <20200329111311.272958fe@luklap> <878sjhho0s.fsf@linaro.org>
 <CAOragkwcnAYYdGOjaHWc1F7-hRnB9CHbgoUqEcc40A7muV+06Q@mail.gmail.com>
 <87wo71fxc1.fsf@linaro.org>
 <CAOragkwi-s7PvDEMB-OKF1s-N3D7caASOjWKJsQFmCu2bTvCaA@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Benjamin <benjamin@thatjames.org>
Subject: Re: Qemu TCG Plugins - how to access guest registers?
In-reply-to: <CAOragkwi-s7PvDEMB-OKF1s-N3D7caASOjWKJsQFmCu2bTvCaA@mail.gmail.com>
Date: Wed, 01 Apr 2020 09:00:11 +0100
Message-ID: <871rp7fxf8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Lukas Straub <lukasstraub2@web.de>, "Emilio G . Cota" <cota@braap.org>,
 qemu-devel@nongnu.org, qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Benjamin <benjamin@thatjames.org> writes:

<snip>
>>
>> You don't need the registers at that point because at run time QEMU will
>> have already resolved the address and will pass it via the
>> qemu_plugin_register_vcpu_mem_cb. The hotpages and mem plugin examples
>> demonstrate the use of the API.
>>
>
> The way you explained this, although it might seem simple, really helped =
me
> understand better the level at which the TCG plugins operate.
> I went and changed my code to be more based on the code in hotpages.c, and
> it is much simpler now.
> I'm going to go look at that Dinero Cache Simulator you linked to see if I
> can get any ideas on how to improve my cache code.

Glad it was of help ;-)
>> > All of this being said, if you think my project is too complicated, to
>> > implement a cache emulator with TCG plugins, then I could always try j=
ust
>> > hacking together some custom helper functions.
>>
>> As I said above I don't think you need register values to do cache
>> emulation as you have the addresses. You will need to decode some of the
>> cache management instructions though. Fortunately you can do that at
>> translation time and only instrument the ones you need. See howvec for
>> examples.
>>
>
> I'm not familiar with cache management instructions.  What exactly do you
> mean by that?  It sounds like something that would be dependent on the
> guest architecture.
> Or maybe it's things like pre-fetching hints?  Then the plugin would need
> to take into account cache latencies, something my code doesn't deal with
> right now.

There are architecture dependent instructions that do things like flush
d and icaches. As QEMU doesn't expose those semantics to the plugin
(behaviour is very specific to each guest architecture) then the plugin
would have to deal with it itself. You would do this by checking each
translated instruction and inserting a call back in front of those that
do cache operations to make whatever internal changes you need to do
inside of the plugin.

> I would be glad to share my implementation once it's in a better working
> state.
> Where can I find guidelines on the coding standard expected of QEMU
> software?
> Thanks

CODING_STYLE.rst in the top level of the source tree is the canonical
document. Also "make check-tcg" will include a plugin test for each
plugin in the tree for each test (assuming you have compilers available
for each guest architecture - see docs/devel/testing.rst).

Good luck!

--=20
Alex Benn=C3=A9e

