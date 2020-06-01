Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C102C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 07:28:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187FE206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 07:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0gFE9op"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187FE206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfes1-0002br-6g
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 03:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfeqT-0001hW-8Q
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 03:26:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21503
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfeqQ-0005a8-MM
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 03:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590996409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MBu3GWe0UsNJpnn3bYCJQ01WfzBsaUconwFFtwbovTw=;
 b=V0gFE9opKB4/SNgdcNwgPbWkzOzvQx/qSLleytJS6gzXOqUVMq/9KkZraThCN9wrAI7sqt
 uozC4Qk7OTc6pm9LlGEKflgq8r96maCpPT1cWvD62sQJDoEvKapwpGigy03m7DnG0kjmdN
 CTM60UnQRGQOtUkGIxSWazmoRQNTwIk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-vUdaMnDjNV60l1KBfmeluQ-1; Mon, 01 Jun 2020 03:26:47 -0400
X-MC-Unique: vUdaMnDjNV60l1KBfmeluQ-1
Received: by mail-wr1-f72.google.com with SMTP id h92so4511623wrh.23
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 00:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=MBu3GWe0UsNJpnn3bYCJQ01WfzBsaUconwFFtwbovTw=;
 b=drazg6qzx6hNb+kUivmGz5Uzd3XNyN0U06Q1KdfNbVKZBuXGJGYfcrNjoyqWek/TMn
 FAxQDcwlaqkZBN2KUqjFZasS2ZZDEVnw45zQ/wEM+RXH8HZAADxHa2iOxPoC/7kgYg/x
 oovq+VMJIQ0kbN0IfkiVNTkhBe4342EZIe1ZsdwxKro/3QxbauTxdoHn+Kx8DH+b1uAq
 ckZ/f8jIhDxTQLjWkkc1Z6xwdklIZZO4RMDuCe8BRBiPIonOok/IiilyTsnHGTU5G4tU
 y3bHCKvyJC2qmGNqQw457nl/bUE/LtDiiZ5pwC6uorJMj7/ZZ6JfXCEbZxW9rlORRqqG
 0LMQ==
X-Gm-Message-State: AOAM532edlywEQRrdgMZp3NKlxCcBmfd+KArdU9cSBLBO4bn7NXWUt7I
 73Vt3O9LEPocMFlW2qK12RK4IBX+0V9Ec7j6swUCB1/P1xpPUFvsOfpI3An0tsnWIUX+2qs3qkx
 mLi6DzMaq8MF9TXw=
X-Received: by 2002:adf:eec2:: with SMTP id a2mr19769160wrp.136.1590996406687; 
 Mon, 01 Jun 2020 00:26:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzu1AXCOdV7vtAjX9+H7t3DzmfyD1/0WDsQ042JpJsDGR08Uh2B2Fea9rcB5OHdSUQoDjJLOA==
X-Received: by 2002:adf:eec2:: with SMTP id a2mr19769146wrp.136.1590996406512; 
 Mon, 01 Jun 2020 00:26:46 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id 1sm10930982wms.25.2020.06.01.00.26.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 00:26:45 -0700 (PDT)
Subject: Re: [PATCH v4 05/11] rules.mak: Add base-arch() rule
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200522163759.11480-1-philmd@redhat.com>
 <20200522163759.11480-6-philmd@redhat.com>
 <9e83f0de-871b-9fc7-6489-d4a94ff0066c@linaro.org>
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
Message-ID: <8ed29bf2-4687-9ee7-c209-fd03faac555e@redhat.com>
Date: Mon, 1 Jun 2020 09:26:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9e83f0de-871b-9fc7-6489-d4a94ff0066c@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 02:05:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/1/20 4:13 AM, Richard Henderson wrote:
> On 5/22/20 9:37 AM, Philippe Mathieu-Daudé wrote:
>> +		      $(if $(call startwith,risc,$1),risc,\
> 
> Should be "riscv" not "risc".  Especially the substitution.

Indeed.

> 
>> +		        $(if $(call startwith,aarch64,$1),arm,\
>> +		          $(if $(call startwith,x86_64,$1),i386,\
> 
> We don't have an exact equality function?

There is this one which returns y/n:

  # String testing functions: inputs to these can be any string;
  # the output is always either "y" or "n". Leading and trailing whitespace
  # is ignored when comparing strings.
  # String equality
  eq = $(if $(subst $2,,$1)$(subst $1,,$2),n,y)

I'll add a simpler strequal().


