Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09913C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAE3E20737
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxLwiFxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE3E20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyYa5-0004sk-4q
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 06:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyYZ4-0004IG-Ra
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:35:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20042
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyYZ2-0005St-Oh
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595500499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QHE97Jg3WIhbz1952jh74gL3+dHspJ0JlKmxXe5n0fc=;
 b=SxLwiFxWJ7JoXgmmWTprUxqxYYAvF+3VdYHrECX1H5koYA8+mZgQXOOd5XTKwhLUs0Cvco
 AxinXiGDAQz7rst3E7AiJ+NM56avzUMpBYZFF02+PCGOQi2I6dHhvIyH+RdFHO3YdaivLx
 7MfBeSkrfwidcb3B9QNl4miVx3EoOhQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-1xl-0E69PTa_1LlHVGxUnw-1; Thu, 23 Jul 2020 06:34:58 -0400
X-MC-Unique: 1xl-0E69PTa_1LlHVGxUnw-1
Received: by mail-wm1-f71.google.com with SMTP id s12so2205636wmc.5
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 03:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=QHE97Jg3WIhbz1952jh74gL3+dHspJ0JlKmxXe5n0fc=;
 b=aRdurUUvRU/OETppbVCUv0nC/Yk+anj33uwR74M9keSQ6s41zGLQEWuU7wspgt2RZw
 46S99/uwREDnW1mbR5JJdh1sfn/WGXKkCaFrqzZVINlq1WPrnrMwPXVBxiAjCssmJANJ
 UThan8HsizI9Wgv8imLuwq5aIkloHy1E+Fdkz56s7qRt9m4OrHlSQLnaDGCdzqtZCNMO
 qKVx22sAlmoSdEznbI4LVjT1b9jrQaAemn1NSsPXNVbBZDQYL02pnilOkbe3P4iyC/GO
 QZ1KyIZucu71UKM6E+DlPx6VjVkoRwiET4IPbKX/O8AUgQbqcVYW/0CshzSJzuaLG40Q
 dB9w==
X-Gm-Message-State: AOAM532yeHwsn4C8EY5H1mQaU421XdUE6PRqPoDGE3wNiFpxvt1KjqIs
 jAz4+Pjh/WF3Ru19psWIBwpck/9rvEXWi8RAKnVsmIkvQABVSX8KYsB9dN42zwq/GzxXhB8pf9g
 FJYykMyXJiLbhRc8=
X-Received: by 2002:a1c:790c:: with SMTP id l12mr3545634wme.50.1595500497300; 
 Thu, 23 Jul 2020 03:34:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3F8HLTX/ofFdNIe0HirwFMRs9skVVm0KjcaeXDJ7wxQUXG4AEheH8VfYSMykKtiuQXiE1Xw==
X-Received: by 2002:a1c:790c:: with SMTP id l12mr3545621wme.50.1595500497052; 
 Thu, 23 Jul 2020 03:34:57 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id w14sm3258474wrt.55.2020.07.23.03.34.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 03:34:56 -0700 (PDT)
Subject: Re: [RFC PATCH-for-5.1 2/2] tpm: List the available TPM backends
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200722112333.29966-1-philmd@redhat.com>
 <20200722112333.29966-3-philmd@redhat.com>
 <25d572a7-d899-fb61-f39e-547e36c8f920@linux.ibm.com>
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
Message-ID: <d64b2965-310d-cf81-ce76-103c117d65b7@redhat.com>
Date: Thu, 23 Jul 2020 12:34:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <25d572a7-d899-fb61-f39e-547e36c8f920@linux.ibm.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 11:44 PM, Stefan Berger wrote:
> On 7/22/20 7:23 AM, Philippe Mathieu-Daudé wrote:
>> When an incorrect backend is selected, tpm_display_backend_drivers()
>> is supposed to list the available backends. However the error is
>> directly propagated, and we never display the list. The user only
>> gets "Parameter 'type' expects a TPM backend type" error.
>>
>> Convert the fprintf(stderr,) calls to error hints propagated with
>> the error.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> RFC because this is now odd in tpm_config_parse():
> 
> because it's not using the fprintf anymore ?
> 
> 

Because when using &error_fatal you don't return:

    if (!strcmp(optarg, "help")) {
        tpm_list_backend_drivers_hint(&error_fatal);
        /* not reached */
        return -1;
    }

I should probably use that instead:

    if (!strcmp(optarg, "help")) {
        tpm_list_backend_drivers_hint(&error_fatal);
        g_assert_not_reached();
    }


