Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2218C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 20:11:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11632072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 20:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEqE0Sbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11632072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9ZrC-0007zP-1o
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 16:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9Zqf-0007Yx-8F
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 16:10:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56470
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9ZqZ-0003US-0L
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 16:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598127037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8rHiObt/7gndhMUFhQ0g5OXJLj+htCn/tSky2KVbbsA=;
 b=CEqE0Sbu61gsfLNOi6rgCCi9CXbjcAE7RhZhp9CNpLR48uY8IogAppkkZpob4USKIqUiFq
 lcBAFWn57mlx7IUi1MUl1ybHLk44YctpZWk228oCHEmN7T3URuJKLxWuRN9MPbyxgIb/Rm
 vwAYwTfWslNKw45LfDIGBqK8lndahW8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-6Q3wI5TmPzu3TpLsFJOqyA-1; Sat, 22 Aug 2020 16:10:33 -0400
X-MC-Unique: 6Q3wI5TmPzu3TpLsFJOqyA-1
Received: by mail-wr1-f69.google.com with SMTP id w2so1744230wrr.19
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 13:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=8rHiObt/7gndhMUFhQ0g5OXJLj+htCn/tSky2KVbbsA=;
 b=bgotpu1zqjOwW8tYCryUDycjcxzth41r3FAy51GPqkUGsxzvdo4TWN9pcuHk5kcNmm
 Vp9T3nerv4UP6g1fmhT8QUP9e7B7P652+xA/1vDPID65/x1sz7xbwV4FGWhHYv+bGrQ4
 gwBTU38mOtnuwSRpSQMyu7Kp14MhQ3N2uCrI6DoIDNMl/u52V0Td7nNWHimbOE1a3M1r
 Ol4J6SkmI3pWGz7LbZ/rphRqkw+fQRlxT61V+skm0bBhCkEP7zABhLWqrR3XoBJICdaB
 o4THROchoVukZ5p7vNcxNxgbWL291tg0u5bP0TbKl4QeyQPyXEm7G/T6mN+C7vJJSWfQ
 MbSQ==
X-Gm-Message-State: AOAM532guJUSDbF0+SP8WJyDYO6hpnZ10DYpFGKwqcNEw4phduHUMIU2
 ny0jyk02fZchLZjIGVzYWJKCEEiSxAqSCPn2N1yVEZxaorAfQTo1tpZAopkGPnkojPdCGjZqVfs
 IH1gCiIE9Imps4ck=
X-Received: by 2002:a7b:c14e:: with SMTP id z14mr9625221wmi.34.1598127032443; 
 Sat, 22 Aug 2020 13:10:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykjhIy2o+WEevQFL2U1+HyhOUASMgtz4/dRDba6WuAxbjXfV6x0K5LvGWULG0F+P2ffmRrcQ==
X-Received: by 2002:a7b:c14e:: with SMTP id z14mr9625199wmi.34.1598127032240; 
 Sat, 22 Aug 2020 13:10:32 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id n124sm14392307wmn.29.2020.08.22.13.10.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Aug 2020 13:10:31 -0700 (PDT)
Subject: Re: [PATCH-for-5.2] hw/i386/q35: Remove unreachable Xen code on Q35
 machine
To: Anthony PERARD <anthony.perard@citrix.com>
References: <20200722082517.18708-1-philmd@redhat.com>
 <20200811105522.GB2024@perard.uk.xensource.com>
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
Message-ID: <95a88c5a-910a-35b7-af58-d038adda1744@redhat.com>
Date: Sat, 22 Aug 2020 22:10:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200811105522.GB2024@perard.uk.xensource.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 15:57:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Anthony,

On 8/11/20 12:55 PM, Anthony PERARD wrote:
> On Wed, Jul 22, 2020 at 10:25:17AM +0200, Philippe Mathieu-DaudÃƒÂ© wrote:
>> Xen accelerator requires specific changes to a machine to be able
>> to use it. See for example the 'Xen PC' machine configure its PCI
>> bus calling pc_xen_hvm_init_pci(). There is no 'Xen Q35' machine
>> declared. This code was probably added while introducing the Q35
>> machine, based on the existing PC machine (see commit df2d8b3ed4
>> "Introduce q35 pc based chipset emulator"). Remove the unreachable
>> code to simplify this file.
> 
> This is almost correct, we can't start a xen guest with the q35 machine
> due to missing setup. But we wouldn't need to declare a new xen specific
> machine as setting "accel=xen" is enough.

I'm not sure you are asking me to reword the patch description,
but since you gave your A-b, I suppose this is enough as it.

> 
> Anyway, that patch can be reverted whenever someone takes care of
> bringing q35 to xen.
> 
>> Signed-off-by: Philippe Mathieu-DaudÃƒÂ© <philmd@redhat.com>
> 
> Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Michael, can this go via your tree?

Thanks,

Phil.


