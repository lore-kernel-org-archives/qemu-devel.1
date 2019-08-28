Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFCAC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 15:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A372A2189D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 15:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZV7/EDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A372A2189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2zXW-0002WV-RN
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 11:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2zWj-0001zB-5S
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2zWh-0005bA-Si
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:06:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42540)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2zWh-0005aT-Kz
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:06:23 -0400
Received: by mail-wr1-x442.google.com with SMTP id b16so131525wrq.9
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1PpMI/PbM7eeewfaY0l1amEvlaDIuVczZfjTF24+jP0=;
 b=ZZV7/EDNLZgJGebTbnfGkIjsTp0SHoRVgg7yPr6BAG3xkKkSFvv+lXURcjHCza/fiy
 /L4cQJrboAbtToqnfJ08oal7BJRzbkJ0/IICSmYFpe1EkzbKfd5M8LqxenlSEa6aSftA
 l4Xrq9ZTGLIZG14cXcidSOzCc9EheyGNidhqUXIHwxjWwHGP2+h+pbGeddu3mAJvUE9D
 /PQALn04vYCaZlk6WTYJVH341wAO3STAA0l3+raxArA5LQZ4tLv1hzSNZUgxyGYnpHki
 8TK/fB/aFzZwJeOJgW6DYOXJTLHqaSicGJ2SeIWPKeM/Wcjs6JCSXrpktnjzSq867sTc
 dnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=1PpMI/PbM7eeewfaY0l1amEvlaDIuVczZfjTF24+jP0=;
 b=ZeHuXTcsSY5GYI/ihqUxZ18dBPKFd47HBhRazVTCqLrrBIjWwIbv/jN+q1SKuO0eje
 dNh2ey8X3kzlhHrumWH/AYrGlH04q/nl7dyDsZtbPkOMyxXlIbYbQeIUVGaE15VJRKBQ
 aZ5eTdNxF0YPuAetVcw1694h0LgzJYEwe556F0KNwpbzjFktqlkmWahtVYfE81WvMS47
 Ub4KVJ/d+KyLYYr63zu8wmdsK9UWaDpbKxfVfXS4rH5cSJh/515WpjLkv89Sg/yD2NhU
 HQjpO0zTjNaaPLLaGLev4sKGqV8FtHMJVHGEOaPj9hfC+1E6x5E8VxKvQss0HPDiEFfj
 uPUQ==
X-Gm-Message-State: APjAAAWMco3ChkH6DZK7iiuWd7HmvrCcSj8YdEJMZv9pVcwveKYOmIob
 EK4y/WyvbIpHkbnbecdtSTCKu1hrpfc=
X-Google-Smtp-Source: APXvYqzWfbdd2zC5SHHgIlhrL+APOiZ8pFxV26gwlUx6rb1yEH4KbFB89Zbt/rZejBLBt7cV3RIciQ==
X-Received: by 2002:a5d:4b8c:: with SMTP id b12mr5644598wrt.26.1567004782038; 
 Wed, 28 Aug 2019 08:06:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a26sm3638844wmg.45.2019.08.28.08.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 08:06:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 848F01FF87;
 Wed, 28 Aug 2019 16:06:20 +0100 (BST)
References: <20190823163931.7442-1-berrange@redhat.com>
 <20190823163931.7442-3-berrange@redhat.com>
 <3345a7e9-c0de-78d8-4656-0255fa1e34fd@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Eric Blake <eblake@redhat.com>
In-reply-to: <3345a7e9-c0de-78d8-4656-0255fa1e34fd@redhat.com>
Date: Wed, 28 Aug 2019 16:06:20 +0100
Message-ID: <87a7bt5nyr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 2/4] docs: merge HACKING.md contents into
 CODING_STYLE.md
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
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Eric Blake <eblake@redhat.com> writes:

> On 8/23/19 11:39 AM, Daniel P. Berrang=C3=A9 wrote:
>> The split of information between the two docs is rather arbitary and
>> unclear. It is simpler for contributors if all the information is in
>> one file.
>>
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>>  CODING_STYLE.md | 262 +++++++++++++++++++++++++++++++++++++++++++++++
>>  HACKING.md      | 263 ------------------------------------------------
>>  README          |   2 +-
>>  3 files changed, 263 insertions(+), 264 deletions(-)
>>  delete mode 100644 HACKING.md
>
> Is it worth trying to group related sections as part of the combination?
>  (Your solution of just concatenating at the end is obviously the
> fastest, but may result in odd ordering where similar things are
> mentioned twice but in different parts of the file).

It is a bit all over the place, but just moving trace-events and
automatic memory de-allocation we could group it like this:

Formatting and style:

  * [Whitespace](#whitespace)
    + [Multiline Indent](#multiline-indent)
  * [Line width](#line-width)
  * [Naming](#naming)
  * [Block structure](#block-structure)
  * [Declarations](#declarations)
  * [Conditional statements](#conditional-statements)
  * [Comment style](#comment-style)

Language usage:

  * [Preprocessor](#preprocessor)
    + [Variadic macros](#variadic-macros)
    + [Include directives](#include-directives)
  * [C types](#c-types)
    + [Scalars](#scalars)
    + [Pointers](#pointers)
    + [Typedefs](#typedefs)
    + [Reserved namespaces in C and POSIX](#reserved-namespaces-in-c-and-po=
six)
  * [Low level memory management](#low-level-memory-management)
  * [String manipulation](#string-manipulation)
  * [Printf-style functions](#printf-style-functions)
  * [C standard, implementation defined and undefined
    behaviors](#c-standard--implementation-defined-and-undefined-behaviors)
  * [Automatic memory deallocation](#automatic-memory-deallocation)

QEMU Specific Idioms

  * [trace-events style](#trace-events-style)
    + [0x prefix](#0x-prefix)
    + ['#' printf flag](#----printf-flag)
  * [Error handling and reporting](#error-handling-and-reporting)
    + [Reporting errors to the human user](#reporting-errors-to-the-human-u=
ser)
    + [Propagating errors](#propagating-errors)
    + [Handling errors](#handling-errors)


--
Alex Benn=C3=A9e

