Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DAEC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F99A208A9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hl4Crn7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F99A208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLsA0-0002v9-N2
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 14:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kLs8k-00021l-VE
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 14:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kLs8f-0003wP-3q
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 14:08:14 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601057288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UlHpfJ1zW666T8MfVmb8qayjrocv2DybSEOaxGXJvVA=;
 b=Hl4Crn7Z8qaesrY6Z2hnSHTFQ2TLdlBRosPwcPzdfUyToEc2n07HPUL3GlqNr0/S1pyJNd
 fLGmnjOvjQSTdQTsbqLz0nCWTBw2YvWM0rWEyj27IIlOq3JKrv4zFZxEzyZSwXbbFhfs90
 vRyphrNN61Cf+0DteoWvbKpmhCSbcOw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30--iPCeERIMqG3g3YrA6-9lA-1; Fri, 25 Sep 2020 14:07:59 -0400
X-MC-Unique: -iPCeERIMqG3g3YrA6-9lA-1
Received: by mail-wr1-f69.google.com with SMTP id h4so1385979wrb.4
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 11:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=UlHpfJ1zW666T8MfVmb8qayjrocv2DybSEOaxGXJvVA=;
 b=jpwLLR4clN98BRLPDBzZAF71bsOdaU1DnJV0v+1s6xNCXWYJfh4IRptuBdTZ7rooDE
 PEahMM0tMFnXvW/4apGmaFlE5AI4+2ZeeoQcwdWRIMZcSTFoB3xMKkm2RR39k+IRPuMf
 cktE4PhrqVXjYw4EQolyKK3+xvHDBR2DniYx3WoOFWk0pnQF/b8TmlnDif3bXp6RH9Aj
 Ram/9NalbtRE+8QjQTdbUL0duQEMTS4MPGAn/WpDVdFah6/hDnSaM7q352uh9V7dkzwG
 1uLPdJHPogy0rpRSxx8qo0VHoTUOlBB2UY+He1pr/IrLaJEuryjjpFTRk8mH5ZclO6he
 x60w==
X-Gm-Message-State: AOAM53051GxVDaJEsVWZ4P0E9JFoNHHYMRcSfOd9EOy2ml6fsA3LbYeI
 IXaQOn/C9LtcY2IOOrw2lLctlPMQc/s+Ie9WQjeOCORKAyOX62gFLAk9uG2SMCdb2RBmjGXyYIt
 gXVanNIo7bf4f31A=
X-Received: by 2002:a1c:4b13:: with SMTP id y19mr4307666wma.75.1601057278333; 
 Fri, 25 Sep 2020 11:07:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrO1HrG2NsepqcumYp5IS1u4kF3wwJLSXZts3vNyg9+tSwObjDsF8HFp8SyjV/xQL0Guw5bg==
X-Received: by 2002:a1c:4b13:: with SMTP id y19mr4307646wma.75.1601057278139; 
 Fri, 25 Sep 2020 11:07:58 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id u126sm4680521wmu.9.2020.09.25.11.07.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 11:07:57 -0700 (PDT)
Subject: Re: [PATCH v5] hw/i386/pc: add max combined fw size as machine
 configuration option
To: "McMillan, Erich" <erich.mcmillan@hp.com>,
 Laszlo Ersek <lersek@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20200925033623.3968-1-erich.mcmillan@hp.com>
 <8818a3ae-cab6-5de4-adbd-19198d26b6e7@redhat.com>
 <CS1PR8401MB0327982D7F9414360E440656F3360@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
 <CS1PR8401MB0327484EBEB2FAC967846886F3360@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
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
Message-ID: <c0e98e05-45ad-fd0e-92cb-dbe882f8beb6@redhat.com>
Date: Fri, 25 Sep 2020 20:07:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CS1PR8401MB0327484EBEB2FAC967846886F3360@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: "imammedo@redhat.com" <imammedo@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 7:17 PM, McMillan, Erich wrote:
> Additionally HPi is not a mistake, corporate requires that we refer to
> ourselves as Hewlett Packard Inc since the split in 2015. I will perhaps
> update this to be the full name for clarity.

Maybe worth be explicit, else it is confusing (since your
email is hp.com and not hpi.com).

> 
>  
> 
>  
> 
> *From:*McMillan, Erich
> *Sent:* Friday, September 25, 2020 12:15 PM
> *To:* Laszlo Ersek <lersek@redhat.com>; qemu-devel@nongnu.org
> *Cc:* dgilbert@redhat.com; mst@redhat.com; marcel.apfelbaum@gmail.com;
> imammedo@redhat.com; kraxel@redhat.com
> *Subject:* RE: [PATCH v5] hw/i386/pc: add max combined fw size as
> machine configuration option
> 
>  
> 
> Hi Laszlo,
> 
>  
> 
> Thank you for the feedback, apologies that I missed the exact line
> references I was moving too fast.
> 
> I appreciate you taking the time to explain the nuances.
> 
>  
> 
> On an unrelated note, it seems that my patches are no longer appearing
> in https://lists.nongnu.org/archive/html/qemu-devel/2020-09/index.html
> is this because I need to cc qemu-devel@nongnu.org
> <mailto:qemu-devel@nongnu.org> rather than –to?

It is:
https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg09212.html

The archive is updated twice an hour I guess.

> 
>  
> 
> -Erich


