Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75685C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4078A206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yw7fuwvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4078A206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdc9b-0006u1-FW
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdc5F-0008Hh-9C
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:05:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49098
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdc5D-0005Uc-Mv
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590509138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=II0CiAiyKHy17Th8wD8CNWsfDIl0rk7kxVMmnix+tvc=;
 b=Yw7fuwvzrQ2WhOO3tQTLUG9hT61t4aidCjZbVgG4HYftSK15UcEPDyxNV1ZK4sK62Qw/RS
 ZVpPo9FLuGhdASzQhMTI7BV/p57IphTxZiupZWiOqtrAr/60aYt8r+Ww7trJxIT2in3Utl
 ySfvE+jy4sT9fA3LoU3/yPljjeDo0ts=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-wDXbC5fdOZmrWxBCZQa42w-1; Tue, 26 May 2020 12:05:37 -0400
X-MC-Unique: wDXbC5fdOZmrWxBCZQa42w-1
Received: by mail-ed1-f72.google.com with SMTP id c10so9109389edw.17
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 09:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=II0CiAiyKHy17Th8wD8CNWsfDIl0rk7kxVMmnix+tvc=;
 b=lixKkMfP7CxhsZ4grxp39bLo0+7Qo4AXoxvBWHKYZI/z/BHZNGXULjwVPDVlqe3BEt
 kRv/DtrfCxiKaKwgQADY/NqXlTb4qCVuUNJCSqFPjPUiuMK5iyb0ktUbSOm+xDHR5aoy
 KyWJWNfEiBq65e6tPrOL2gscE3oL1bNq/EVxJK4bbwNfoat1cnhnbzJRxzzEGRBVYKFR
 EPS+4PbfpflmT+wD3g1LJ9GhOioES3XEb1haAkom9yWFLKny4d94KWOVqhbmz6RjtT9m
 NTfohRpJVLxs2aIH6rKi1nCEyNC5ih8e/hTpY8wqSdsSmcP+esL3H14qteGrzqOLDfR8
 xU5Q==
X-Gm-Message-State: AOAM531Wo7XKYE3+TYOXqwfqzaRsO6XlB2TmacEMULQ79KrswbatGpoF
 zHi853wWWeTn1c64Bk2TvohzV5oZ+csXUBSjOJWF1OBJEnc30hqrhtS3QFo347HLqegOEjbiV0S
 AqFhMt40t8RE3IJ8=
X-Received: by 2002:a17:906:5e08:: with SMTP id
 n8mr1765395eju.132.1590509136206; 
 Tue, 26 May 2020 09:05:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymAa1z0j+jcSwACAlg2JQCl88l9MR5F141iBmNU0dSJNPgy0K2d69vKh6ayhmAhUz3+X0h1g==
X-Received: by 2002:a17:906:5e08:: with SMTP id
 n8mr1765374eju.132.1590509136007; 
 Tue, 26 May 2020 09:05:36 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id da17sm274640edb.11.2020.05.26.09.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 09:05:35 -0700 (PDT)
Subject: Re: [PATCH RFC 20/32] python//qmp.py: assert sockfile is not None
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-21-jsnow@redhat.com>
 <ef47033e-94f3-7d5e-c7cf-36a628d7b2ba@redhat.com>
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
Message-ID: <1db45bbd-5f0d-7da7-7040-4505dfdf74ff@redhat.com>
Date: Tue, 26 May 2020 18:05:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ef47033e-94f3-7d5e-c7cf-36a628d7b2ba@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 10:22:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/26/20 6:03 PM, Philippe Mathieu-Daudé wrote:
> On 5/14/20 7:53 AM, John Snow wrote:
>> In truth, if you don't do this, you'll just get a TypeError
>> exception. Now, you'll get an AssertionError.
>>
>> Is this tangibly better? No.
>> Does mypy complain less? Yes.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  python/qemu/lib/qmp.py | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/python/qemu/lib/qmp.py b/python/qemu/lib/qmp.py
>> index 5fb16f4b42..1aefc00c93 100644
>> --- a/python/qemu/lib/qmp.py
>> +++ b/python/qemu/lib/qmp.py
>> @@ -132,6 +132,7 @@ def __negotiate_capabilities(self):
>>          raise QMPCapabilitiesError
>>  
>>      def __json_read(self, only_event=False):
>> +        assert self.__sockfile is not None
>>          while True:
>>              data = self.__sockfile.readline()
>>              if not data:
>>
> 
> Acked-by: Philippe Mathieu-Daudé <philmd@redhat.com>

I meant:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


