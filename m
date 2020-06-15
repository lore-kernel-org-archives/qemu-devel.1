Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B2EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C1E206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B33YCTXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C1E206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkqdm-0006dE-4N
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 11:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkqcz-00069B-V8
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:02:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43656
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkqcx-0004zP-BH
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592233341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=G5V3cIBg/HoQbRwYOdfT+XHVvtOd3fhu/VBCzZHpP7M=;
 b=B33YCTXrb0VEOc9tOCn/QnEp3dZN3YvId/ocae9mAoUQcj7pH64IT2itEovg6Ob9bVaYJa
 SHVlML8io5jwc6KYA7I1ckbb0q3wv0agH9zVT7dAAtkV1Avp6pDeYafRXQQLLpguDOVfpv
 l5+p7wE2I+VEPVQ6uW04y96ZlHMSzTI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-umGkHlgAP7SNKzPU8_kEzQ-1; Mon, 15 Jun 2020 11:02:17 -0400
X-MC-Unique: umGkHlgAP7SNKzPU8_kEzQ-1
Received: by mail-ej1-f71.google.com with SMTP id op14so7950379ejb.15
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 08:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=G5V3cIBg/HoQbRwYOdfT+XHVvtOd3fhu/VBCzZHpP7M=;
 b=lkgN2VGvvSJYEDzAErrx2mJUqCCGGeKdTi7zYlYTXwZxnQtCGLJWVy5rJBVqAZtcy2
 wbkwVONn+cOXz2xVrtpF3w3O5Prjs6aY4/fmc1mxmWpob0lQwLNu5F/FJGBK4KSkK86D
 02XNihYYqFH3Edoxo2fc7JNWVhXCJxZltD28B5RxssDf8FEed12H7b802gnjhGaFpAwj
 DNkGdBtz0maLnCBXpFPOeZ1Z+vp9X2K6kDKgzovvAxK9uuxks7GzA3N4sMY34J/faylD
 FYkhn0RGnbEG89/6/tHGtc9YG5jojxPLEzhOXkf3pXV+/xDegd2uPI56qc4W2jecCg75
 FoJA==
X-Gm-Message-State: AOAM530sYAW8akD001TL6FxSHbJLCt9ffPwSgp2LlvrNBq6dJKSrvtQG
 /FTT3InnSd32SSYJ4+7Z/ufBxjsaGUvAsqtp0rFD54X6ZvCfr2hooKozDZI1su2qirHMJBm+w9u
 CwPlaI/7zY2nK4KM=
X-Received: by 2002:a50:f044:: with SMTP id u4mr24462060edl.226.1592233335975; 
 Mon, 15 Jun 2020 08:02:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPX0uBJ43DH6mpNM9Hj6f2e/6Npr5Gv6m+nDkLfr5x1fGTmwG/r3kaLysElQ9m5ePnNHc9PQ==
X-Received: by 2002:a50:f044:: with SMTP id u4mr24462022edl.226.1592233335696; 
 Mon, 15 Jun 2020 08:02:15 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id p13sm8575173edx.69.2020.06.15.08.02.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 08:02:15 -0700 (PDT)
Subject: Re: [PATCH v7 2/5] softmmu/vl: Let -fw_cfg option take a 'gen_id'
 argument
To: Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>
References: <20200528173141.17495-1-philmd@redhat.com>
 <20200528173141.17495-3-philmd@redhat.com>
 <f3f6154e-bbc1-98bd-0f44-77b28c74915f@redhat.com>
 <20200609155050.GT2880@minyard.net>
 <6e4b9540-7d5b-0951-2870-bada03e29d83@redhat.com>
 <20200615144527.w2637fq5jzpk7jtt@sirius.home.kraxel.org>
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
Message-ID: <dbb5766d-ffd6-df64-09f6-0a78efe6e46c@redhat.com>
Date: Mon, 15 Jun 2020 17:02:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200615144527.w2637fq5jzpk7jtt@sirius.home.kraxel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 11:02:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, minyard@acm.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 4:45 PM, Gerd Hoffmann wrote:
>   Hi,
> 
>>> I can explain the rationale for that change, but I'm not sure of the
>>> answer to your question.  That changes makes sure that the fw_cfg data
>>> remains exactly the same even on newer versions of qemu if the machine
>>> is set the same.  This way you can do migrations to newer qemu versions
>>> and anything using fw_cfg won't get confused because the data changes.
>>>
>>> The reason that change was so complex was preserving the order for
>>> migrating from older versions.
>>>
>>> This is only about migration.  I'm not sure what gen_id is, but if it's
>>> migrated, it better be future proof.
>>
>> Whenever introducing a new fw_cfg file (*any* new named file), how do we
>> decide whether we need fw_cfg_set_order_override()?
> 
> The whole point of the sorting is to make sure the fw_cfg directory
> listing entry (FW_CFG_FILE_DIR) is stable and doesn't change underneath
> the guest when it gets live-migrated.
> 
> That sorting was added in qemu 2.6, to make sure things don't chance by
> accident in case the initialization order changes.  Now you've got a
> problem when you migrate from qemu 2.5 (+older) to qemu 2.6 (+newer),
> because 2.5 has the entries in initialization order and 2.6 has the
> entries in alphabetical order.  To deal with that machine types for 2.5
> & older keep the old sort order.  This is the reason why
> legacy_fw_cfg_order exists.
> 
> For new features and files you can completely ignore the whole legacy
> sorting mess.  cross-version live migration works only for features
> supported by both qemu versions, therefore the legacy sorting is only
> relevant for features & files already supported by qemu 2.5.

Thanks you Gerd for the whole explanation. I added an entry to
my TODO list to document this, based on your comment (and Corey's).

I'll address it later, as you confirmed it doesn't impact this
series.

Regards,

Phil.


