Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4E7C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26ECA2080A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdyEpqsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26ECA2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPlRq-0000vy-7Q
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPlEl-0001Vi-GV
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:34:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPlEd-00084p-I3
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601984062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ws4y57LYTQhJujk70GhLINLpG+W6hU1+yPj3Bb2JciI=;
 b=GdyEpqsZ9OvJHfcobN50XfpRAuinWbgZYYphfRsqIFc6M/n1UdM+jz0YbchgrSngpTfF6E
 5AB+5FbWhAlm8ySAEt249s8jbzH/OkvD8L6s9HcA8oyhfU7ak6QISRfB0A5mzJ9qH92f4f
 HGLL6hyr9RAx989npPzy7orU9q1+OVg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-AjBMyp63MKW5Q8q5AMLP5A-1; Tue, 06 Oct 2020 07:34:20 -0400
X-MC-Unique: AjBMyp63MKW5Q8q5AMLP5A-1
Received: by mail-wr1-f72.google.com with SMTP id u15so5265708wrn.4
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ws4y57LYTQhJujk70GhLINLpG+W6hU1+yPj3Bb2JciI=;
 b=IdacpqVpamGewz4uuNRIcrODuUbTj1nUbJcG6M1YuMz6AvcvWnOOmnh/T6l6DU32ws
 kmj+c5/CveakNI2KMW3+9vLlXVj2QCh23IP5a6SeTQT7sdl8estGg+qY8SACSql4ryRU
 mfOLKhmUH1M9TAv82sd4y03QbRBzYb5W0sBOIexpb5qhoCicfBSaBLeBEOyY0NOTOIdj
 v6Frl3kw2t1P3nyItIFKjptNUO7q4Ve4SvKmW4Fmfc4yX3chlQ4liezztR9Mrum1XVe/
 WSYU+7K/jdlIIlTyZ3Y42Ejyo2Pq/pImo71dboi4Gy1rsMXFtf6ogOQPByBTTl9aLQOU
 sooQ==
X-Gm-Message-State: AOAM530arz7QERLDLEYja7CWwQhheJ0dDu/Oj6W3Xjfr2HYiGrTxtyJk
 kURhOW4vkmB9aqca8D9Ix0H9HMXvK181+BXCd4fNJrDWwJiNNo3xe9zFZ76sIxf+gdoyHPdPOzr
 lGYAbDIsCrrxiyto=
X-Received: by 2002:a1c:c28a:: with SMTP id s132mr4238440wmf.67.1601984059780; 
 Tue, 06 Oct 2020 04:34:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLbB6lM50a26/Wd4U38bz4sN3pSlxKzqkvDauk0hl0/uaDyrIQ62sj6YIYwXeoen0aGDR/Rw==
X-Received: by 2002:a1c:c28a:: with SMTP id s132mr4238421wmf.67.1601984059614; 
 Tue, 06 Oct 2020 04:34:19 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id g2sm3619315wmg.38.2020.10.06.04.34.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 04:34:19 -0700 (PDT)
Subject: Re: [PATCH v5 06/36] qapi: Remove wildcard includes
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-7-jsnow@redhat.com>
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
Message-ID: <5de0c658-abd8-e0b4-f9a5-c368150addba@redhat.com>
Date: Tue, 6 Oct 2020 13:34:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005195158.2348217-7-jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 9:51 PM, John Snow wrote:
> Wildcard includes become hard to manage when refactoring and dealing
> with circular dependencies with strictly typed mypy.
> 
> flake8 also flags each one as a warning, as it is not smart enough to
> know which names exist in the imported file.
> 
> Remove them and include things explicitly by name instead.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> ---
>  scripts/qapi/commands.py   |  2 +-
>  scripts/qapi/events.py     |  7 ++++++-
>  scripts/qapi/gen.py        | 12 +++++++++---
>  scripts/qapi/introspect.py |  7 ++++++-
>  scripts/qapi/types.py      |  8 +++++++-
>  scripts/qapi/visit.py      | 10 +++++++++-
>  6 files changed, 38 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


