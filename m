Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B102EC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE7F2068F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XE++y2yf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE7F2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvDw-0006jw-Nd
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juvD7-0005bU-5P
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:57:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49306
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juvD4-0002St-Ba
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594634236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ciG9rvZmAUZakGJrqn8t+e1dc5wQAOnTk9VpBH2Np5g=;
 b=XE++y2yf5ibGD2oCiIUBUgeopfPGaMMlNXWazLe4XGK+IbBBmNxmtX/J/s/+MrkfbsL/M8
 vV3r7v8b8cifIplhjSekaBAnLuwXIGgmtI27GLKYEIRWlZjLQUGQg7DQUtA6fElUksOOrH
 9lGDXd411GLyAjcfGGt2Hf+zw7bjGMg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-GV3mXqQXOHWxuK3cWssoOQ-1; Mon, 13 Jul 2020 05:57:13 -0400
X-MC-Unique: GV3mXqQXOHWxuK3cWssoOQ-1
Received: by mail-wm1-f70.google.com with SMTP id w25so15894677wmc.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 02:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ciG9rvZmAUZakGJrqn8t+e1dc5wQAOnTk9VpBH2Np5g=;
 b=MSyqOCJEfMtIFRKkuDJ9myI/FWvkTxzV/O15HFht2Mn6F9S/lKLPuBWIQDryyBDjTg
 8ZBc9BdMEZOrYpOqxa2HcWMZSu0EQQH7+NO0DL/VmXlt84gVxlugRo12jlcrGM+FcMHt
 hkhQyUkK/yRQ4QMVnEBt73dbaCx/uewiqxUsmOIS1UuSJHNFnTUjZuR8Yk2MAvAwLB2i
 77mUkUXgKrTK8RxfSJL1DrjUTeWQEH2KMQZ57PDSWqJYb6/ZvPAhZov//yObwnFtOGP1
 5aC7WgEV3/l265Jx3CgWk7E8M4pMYHdsjPHZCnY6+SFxQYMi/rbmAivHfKnRai+9SLn1
 kdVg==
X-Gm-Message-State: AOAM5339kdQNeiNzqcKpkzgxSmsSSconDt/DKgWubGmC70jjhS+Rw8pc
 CBpUu1uRfuQoGM05Ah/admVtbhxqM8i0SIEB+vZPJcGYJSsRRXXYqPvZk1clWiKf4LTcHi2k7Bo
 Iwy19CuvhK4VJHrU=
X-Received: by 2002:a1c:7c16:: with SMTP id x22mr17395212wmc.76.1594634232076; 
 Mon, 13 Jul 2020 02:57:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztBfY6IlF1k+nNCT+PdYqOkPD6rJVr1lI3kglQkjEl7S917xq93utaKctV9u8aBkMLborS1g==
X-Received: by 2002:a1c:7c16:: with SMTP id x22mr17395199wmc.76.1594634231879; 
 Mon, 13 Jul 2020 02:57:11 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id y20sm21282505wmi.8.2020.07.13.02.57.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 02:57:11 -0700 (PDT)
Subject: Re: [PATCH v5 08/12] tests/acceptance: wait() instead of shutdown()
 where appropriate
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200710050649.32434-1-jsnow@redhat.com>
 <20200710050649.32434-9-jsnow@redhat.com>
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
Message-ID: <38b7f3b3-e29a-1694-bfa4-b164363d7b72@redhat.com>
Date: Mon, 13 Jul 2020 11:57:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200710050649.32434-9-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cleber Rosa <crosa@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 7:06 AM, John Snow wrote:
> When issuing 'reboot' to a VM with the no-reboot option, that VM will
> exit. When then issuing a shutdown command, the cleanup may race.
> 
> Add calls to vm.wait() which will gracefully mark the VM as having
> exited. Subsequent vm.shutdown() calls in generic tearDown code will not
> race when called after completion of the call.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py   | 10 ++++++++++
>  tests/acceptance/linux_ssh_mips_malta.py |  2 ++
>  2 files changed, 12 insertions(+)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


