Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CC2CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B88082084D
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRAHqd/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88082084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36393 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRhLe-0003i7-IC
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 13:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iRhIq-0002YH-JI
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iRhIn-0003re-Tz
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:42:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21577
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iRhIn-0003pp-K9
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572892928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+XTN4c1rUrdPA/+Naiy5XT9t3tp34960UhvEQ/LzOtQ=;
 b=cRAHqd/NFGja5qXBZ+S7X0QKvuLJ8C03KDp5za5KsvydUG6cAe6Gik4Lv3xF137mXGlTGt
 YleS1b0JKJHczOWbuoQFEuPte3gassF1gD1k2SoBWCAbM5RBLCc9hYxD6EYvdC8j51g8wv
 jzIcCOC5j2w8kUJPvdV2MCuPw12uyL4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-8Yf3_6zhMF2BDBUZ7NATPg-1; Mon, 04 Nov 2019 13:42:06 -0500
Received: by mail-wr1-f72.google.com with SMTP id v6so1508539wrm.18
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 10:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+XTN4c1rUrdPA/+Naiy5XT9t3tp34960UhvEQ/LzOtQ=;
 b=MkDeugtfVizFu78XoS5z1nkpmcBpWbdAnm2KpQ0CI6jk0UnKxvo2QoJMRMnMaOuH06
 IRc9OX0NQfdLFhhX4xfB9PRBk1Z8zSvxASwQz3qXMNHTo+nB9d0kZDa5Pw1kwAhaproK
 2fHjsC8puLnu6Y4XcoixP8Wyl+PNr2FSAinPHx6q7l+pALEhFO6al9WWn/6L0JPsjZUk
 gjpKsUrLBMcLz6BfRFFvFjkUBKnfSgvrGAnjyJNyiDdR15oOPN/+eq7wNKuLq+HM27nQ
 7LqJktkeDRVtz39s+vabEMR3bGMNa6x7vg6q5kLw9S8IgDonWR7W6PpSxbtZGQcVB0jM
 kIhw==
X-Gm-Message-State: APjAAAUrBuX/FpQvgLkaae9E52Ajph9qMPI/vUapVGhfCtZbw+xm1vz9
 MvWPxVB2ataWp0nJfH+2jaeI+1zez49Wrip8ouL8CbNk4RTphKJWVE+Jm8IuKP8bLf/nhTXO57M
 IX0MJo31cgd4O7a0=
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr24546990wrw.167.1572892925362; 
 Mon, 04 Nov 2019 10:42:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqz8iPZUqisSInI1+YImmePsvTnCdKYPIppStrnG4OiUHuo27SAAN6T/K0976rttvNjUQfw4dw==
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr24546977wrw.167.1572892925187; 
 Mon, 04 Nov 2019 10:42:05 -0800 (PST)
Received: from [192.168.1.24] (lfbn-1-7864-228.w92-167.abo.wanadoo.fr.
 [92.167.33.228])
 by smtp.gmail.com with ESMTPSA id p4sm9732340wrx.71.2019.11.04.10.42.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2019 10:42:04 -0800 (PST)
Subject: Re: [PATCH v26 00/21] Add RX archtecture support
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
References: <20191014115757.51866-1-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c8d635bb-cbc3-c34a-5ae1-79ae0630d89b@redhat.com>
Date: Mon, 4 Nov 2019 19:42:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191014115757.51866-1-ysato@users.sourceforge.jp>
Content-Language: en-US
X-MC-Unique: 8Yf3_6zhMF2BDBUZ7NATPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

Hi Yoshinori,

On 10/14/19 1:57 PM, Yoshinori Sato wrote:
> Hello.
> This patch series is added Renesas RX target emulation.

Your series is (very) ready to get merged.
IIUC it won't be merged for the next release (4.2) but will be
merged first thing once 5.0 opens.
You don't need to do anything (except eventually send a ping
in 3 weeks).
Sorry it took so long, but introducing a new target is not an
easy task.

Regards,

Phil.


