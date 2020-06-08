Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25081C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 06:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43A72074B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 06:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sih3E9S2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43A72074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiB4K-0007MX-4n
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 02:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiB3b-0006ji-0r
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 02:14:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56588
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiB3Z-0004T2-Gr
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 02:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591596888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HJgKDDYRL13rg8hQX8rj19lSPcZKgjzQWZ9isODjcns=;
 b=Sih3E9S2XfTvOsG0q9X3voHE66zrF2SU9iCEJHNFW78TgGs3gEp4eVgBiKQTofGZBVflRc
 5eCUAxBXZMFa8mukch9uBMplLoad5iRs6dL8rCDd8/nsxNfcziQW7jk/XpZb4nzwV8iUkV
 cxtA70lpdB5Zqy2fe++lpSytN7Q+S8k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-f8Bfc5EqPmGonvfyOeI7Rw-1; Mon, 08 Jun 2020 02:14:47 -0400
X-MC-Unique: f8Bfc5EqPmGonvfyOeI7Rw-1
Received: by mail-wr1-f72.google.com with SMTP id w4so6737290wrl.13
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 23:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=HJgKDDYRL13rg8hQX8rj19lSPcZKgjzQWZ9isODjcns=;
 b=is+ip2SzjVQ3lAbMeLUjpOn0azXka21xGlzpUZ29NxlVrwMGRIUN0i0pP/7CvYlvOL
 2/nQF9g7CnVj5pODFQ/YpsIBxmXb4wRm5XoEW9voDROhElP3IBdi9nVRovuyLiE4PEYe
 2opKhror0VknG5tLsslazLnIUeBXluMmrVrGXAKJKiqRUzqIBCQH/0H/B90e4ZBmou40
 tNvUfactOqUVcPeCdoZChEjoy972zllVmiA1xPFKxOAyffUT6Po5WonpSPllZNXSZeiC
 SokvBPb8FnXycS3JcSbGgFzAWwFS+jX6EIXqtRA278guyE9Vn5vzwlePEVfy5RGCJo3Y
 WCWQ==
X-Gm-Message-State: AOAM530x1BqTe/CIxmgx6ghwJEjycEoy9l2WICJGd5r84WO21vr0v/mv
 DA7hPLhlaOCcF9q/U+lin6LmUyrrxfUelUicR7SguT78BYVEqVlrJygVE+TfeQFmV9Zw1rFKy4u
 l9yqZOLrWaSzYgTw=
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr15135150wmc.180.1591596886267; 
 Sun, 07 Jun 2020 23:14:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVG+EpxDsMo6AoLO3HBkWnKR5VLkOk0Ay9N9yTy3o9p1bbSeEBVT5YTwRC1T4znTznwaUojQ==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr15135131wmc.180.1591596886056; 
 Sun, 07 Jun 2020 23:14:46 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id z206sm22047066wmg.30.2020.06.07.23.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jun 2020 23:14:45 -0700 (PDT)
Subject: Re: [PATCH] block: Remove trailing newline in format used by
 error_report API
To: Markus Armbruster <armbru@redhat.com>
References: <20200228123637.15160-1-philmd@redhat.com>
 <8736auipnb.fsf@dusky.pond.sub.org>
 <fd516cf1-72bc-63db-84f0-d2f2c5cbad7a@redhat.com>
 <874krmyxlt.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <b4251bb2-bd76-01f0-26e2-563ab4ec7631@redhat.com>
Date: Mon, 8 Jun 2020 08:14:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <874krmyxlt.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 00:45:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/8/20 6:45 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 2/28/20 6:32 PM, Markus Armbruster wrote:
[...]
>>> warn_reportf_err() is a convenience function to error_prepend(),
>>> warn_report() and free @local_err.
> [...]
>> Why warn_reportf_err() doesn't take a 'Error **err' instead, to set err
>> to NULL after freeing *err?
> 
> Why doesn't free() take a void ** argument, to set the pointer to null
> after freeing what it points to?  Why doesn't close() take an int *
> argument?

=)

Usually I see the code checking an Error* hasn't been set by a callee.
If it has, the caller usually returns.

You explained me warn_reportf_err() consume Error* and free() it.

So regarding the rest of our Error* use, a function calling
warn_reportf_err has to do extra care to set Error* to NULL.

Genuinely looks confuse or dangerous to me...

Note however I was not asking for a change, just asking 'why'
to better understand if there were not a design problem, or
o invalid use of different APIs.

> 
> [...]
> 


