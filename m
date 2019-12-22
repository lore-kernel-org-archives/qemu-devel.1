Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252DAC2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 12:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40F62067C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 12:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJdwjdNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40F62067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ij0R0-0007gf-To
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 07:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ij0QK-0007Fo-Fz
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 07:33:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ij0QH-0002RX-UM
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 07:33:28 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43566)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ij0QG-0002Q6-8x
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 07:33:24 -0500
Received: by mail-wr1-x441.google.com with SMTP id d16so13780322wre.10
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2019 04:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PKCFxoG9lQRAMqj7N2c/DB0LiRJDNu+D/Cpr80n1gSM=;
 b=VJdwjdNJB/DAXwntNGAQ5B5TA1JPLk7jelnGP3IGrD//CWZwdjSdw6iCWKQOQEQ5Vh
 7p/YfnSXDFMlmisKHV0gkMaAGiLjkvdu7dEzSclS/QlQ7ztsnnY1DBhkRlTcQmLKIMTc
 DuBAN7/xryLfuLmLIWIGKUvbBdcHfjuBI6nlCXAL+LNrckUE9AMhJiqyZZVBzxhphQMk
 tOaSHdEDg+H7fyxIEd1cQXjFy9twjxBadBgsueo4G7I4tepby3kDKjYy6RXQNNkAj6g4
 6NVlBlOaIIHIuA9qjYdQdp0onD55AkYZtmmiPWby2A/pWIbg4P79BBCFSZ0Mkpm8/sHI
 NJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=PKCFxoG9lQRAMqj7N2c/DB0LiRJDNu+D/Cpr80n1gSM=;
 b=Eu8xtp9b6ODwxEUzGejps2X7O2CE7hzNCb3gTaizICI9xgz8Ry7GK5xiSMBXdI2Sl4
 cjxgp+qo6O/F8Q07zM+X9/ImPnCOvgCYg0Hi9kbroBJx1dFJ+YKjIymC8r6RVmK1DTS7
 BGAip/zjzroyCAQ6b1W4wGqbEJUeO2TiwzLMsAt5YjDWINe0Kdc90yNI/YOsR4vYss30
 ZXUtUCrl1B/gLU4DMvgsDqywfYfCChwzHnc1lUiaRnVxmz8UIuTnPh4pJjfXWJbW7KsF
 H9tYAjk0KvFnQVH48abk1G4+/6+wrieM4sCDFcfLqV5bBh7O7TYfXNz8XpQ8gB6mgIU+
 iZnQ==
X-Gm-Message-State: APjAAAWSdK0UBYTEaJ1Of8LgMtYlo/V3x1hr+zpk7tyLz/BP5Akdf+Y2
 8EzUdfQfNcdM+FJypLKiZ72ITXlp1xE=
X-Google-Smtp-Source: APXvYqy5IXZgQ10Bkt4Eq+zzRz3vvHsmBKsVyy8w0cNrutswQMvd/p9SnAesFfIGNqSCNxgZo3t2qA==
X-Received: by 2002:adf:fe07:: with SMTP id n7mr25657346wrr.286.1577018002675; 
 Sun, 22 Dec 2019 04:33:22 -0800 (PST)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id d10sm17275265wrw.64.2019.12.22.04.33.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Dec 2019 04:33:21 -0800 (PST)
Subject: Re: [PATCH v5 6/6] seabios-hppa: update to latest version
To: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
References: <20191220211512.3289-1-svens@stackframe.org>
 <20191220211512.3289-7-svens@stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <98326127-52d1-d03a-3523-6dc902d7a324@amsat.org>
Date: Sun, 22 Dec 2019 13:33:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220211512.3289-7-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/20/19 10:15 PM, Sven Schnelle wrote:
> Helge Deller (13):
>       Add PDC_MEM_MAP and ENTRY_INIT_SRCH_FRST for OSF/MkLinux
>       Return non-existant BTLB for PDC_BLOCK_TLB
>       Add serial, parallel and LAN port support of  LASI chip
>       Implement ENTRY_IO_BBLOCK_IN IODC function
>       Do not print \r on parisc SeaBIOS
>       Fix serial ports and add PDC_MODEL functions for special instructions enablement
>       Implement SeaBIOS returning additional addresses. Fixes HP-UX boot.
>       Fix mod_pgs (number of pages) for graphic cards
>       Merge pull request #3 from svenschnelle/sti
>       Merge pull request #4 from svenschnelle/parisc-qemu-4.1.0
>       parisc: Implement PDC rendenzvous
>       parisc: Improve soft power button emulation
>       parisc: Fix line wrapping in STI console code
> 
> Sven Schnelle (7):
>       parisc: fix PDC info for graphics adapter
>       parisc: add missing header guard to hppa.h
>       parisc: add LASI PS/2 emulation.
>       parisc: Add STI support
>       parisc: wire up graphics console
>       parisc: Add support for setting STI screen resolution
>       parisc: support LASI RTC register
> 
> Required for STI and LASI support. Also adds a few Bugfixes.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  pc-bios/hppa-firmware.img | Bin 783724 -> 766136 bytes
>  roms/seabios-hppa         |   2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)

Odd, MTA from work refused to deliver this patch because it "might
contains virus" =)

Since you share url of repository with content, you can send your series
with `git-format-patch --no-binary`.

