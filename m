Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055EDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 01:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DAE20772
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 01:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lwu2xY29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DAE20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtKxU-0000GN-UL
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 21:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtKwH-0007DA-0L
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 21:01:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56079
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtKwF-0003sX-3M
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 21:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594256482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SP7p10zQCTFQ0IeMD+wPAl0MwWTRVAjofBdESwNrtUI=;
 b=Lwu2xY29OzjAo8p8K4GlLBnouf4rLKdAwQoFzb61SvTdrURioqEYQlmLNFGJo196x63lkw
 awbebXJOctXzI/21tQWwhQqstpMPniIJpewqUYM42ByxdtXKyYA9nZiY3c+amJLMV9QKf3
 ljxxzRxPc+XE9ZN773A6SavCGtQ64JM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-ajxZ1pdyOcWz8BSR-3X1BQ-1; Wed, 08 Jul 2020 04:57:34 -0400
X-MC-Unique: ajxZ1pdyOcWz8BSR-3X1BQ-1
Received: by mail-wm1-f69.google.com with SMTP id b13so2220086wme.9
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 01:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=SP7p10zQCTFQ0IeMD+wPAl0MwWTRVAjofBdESwNrtUI=;
 b=OfmuLxS5iuB7gvUnKUiG3ZVFkdPQbqugPuez+T5jahMhAMmJv4GkMF+Gd6HTcD7UPa
 fgiDm6uAWz/m8BNKKlwh+kAo9Aln1vquiAyOKvqdQ3QWztTUnxfQNFP6vnpD/PrCm6Vi
 np46sR7rBKmjj0cUzfP8cF03pQqDd+h5a02RAJ0sR03z4rL8KiHetk/2wdOyjAORJ72x
 +IXnyboG9+lCY6xoPDrLpLP7KChaClSuXK/j2RtYLQlVnLHeVWc3dviOP9tutcdvTj2g
 rKDSyyrn0iUXkcBrtWFBCLe2yyg4Ql2Q4Wj5Of8upbiUQxj2hhBikgqNnwCa1MJKFlVY
 DoXw==
X-Gm-Message-State: AOAM5305IvPBB1FKJ8pA5sdrokpi1vPXeeitIxg87AZ1ZA8/bJjSCOAN
 QKSM+jzt2DFdZKO7jZjSOXJTPQ7yG0UwWors0Xw1f/d/bJgbvzXd/EqPPrbB0cl1+wyAVMOCX+Z
 cNA3tA8rNyxp49mE=
X-Received: by 2002:a1c:dd86:: with SMTP id u128mr8251370wmg.123.1594198653529; 
 Wed, 08 Jul 2020 01:57:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9Us5m2JT1t8/6MrVDBKMynH7y2zThyqANYVV5x0fIpjL4/Bfibc4V1x+Kip3wPDCvcbzoPQ==
X-Received: by 2002:a1c:dd86:: with SMTP id u128mr8251353wmg.123.1594198653291; 
 Wed, 08 Jul 2020 01:57:33 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id q1sm4679275wro.82.2020.07.08.01.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 01:57:32 -0700 (PDT)
Subject: Re: [PATCH v2] MAINTAINERS: Cover the firmware JSON schema
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200703183450.32398-1-philmd@redhat.com>
 <20200708024434-mutt-send-email-mst@kernel.org>
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
Message-ID: <3dafd514-f66c-96c5-3217-86ef990dda1b@redhat.com>
Date: Wed, 8 Jul 2020 10:57:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200708024434-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+qemu-trivial

On 7/8/20 8:45 AM, Michael S. Tsirkin wrote:
> On Fri, Jul 03, 2020 at 08:34:50PM +0200, Philippe Mathieu-DaudÃƒÂ© wrote:
>> Add an entry to cover firmware.json (see commit 3a0adfc9bf:
>> schema that describes the different uses and properties of
>> virtual machine firmware).
>>
>> Cc: Laszlo Ersek <lersek@redhat.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Kashyap Chamarthy <kchamart@redhat.com>
>> Cc: Daniel P. Berrange <berrange@redhat.com>
>> Suggested-by: Laszlo Ersek <lersek@redhat.com>
>> Signed-off-by: Philippe Mathieu-DaudÃƒÂ© <philmd@redhat.com>
> 
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Thanks Michael. If you plan to do a pull request, can you
include this patch please? (modulo the weird UTF8 mojibakes)

Else it can simply go via the trivial tree.

> 
>> ---
>> Since RFC v1:
>> - Added Daniel & Kashyap as reviewer
>> - Added myself as co-maintainer with Laszlo
>>
>> Based on a comment from Laszlo:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg604925.html
>> Background info from Kashyap:
>> https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg01978.html
>> ---
>>  MAINTAINERS | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index dec252f38b..64bcea658d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2601,6 +2601,14 @@ F: include/hw/i2c/smbus_master.h
>>  F: include/hw/i2c/smbus_slave.h
>>  F: include/hw/i2c/smbus_eeprom.h
>>  
>> +Firmware schema specifications
>> +M: Laszlo Ersek <lersek@redhat.com>
>> +M: Philippe Mathieu-DaudÃƒÂ© <philmd@redhat.com>
>> +R: Daniel P. Berrange <berrange@redhat.com>
>> +R: Kashyap Chamarthy <kchamart@redhat.com>
>> +S: Maintained
>> +F: docs/interop/firmware.json
>> +
>>  EDK2 Firmware
>>  M: Laszlo Ersek <lersek@redhat.com>
>>  M: Philippe Mathieu-DaudÃƒÂ© <philmd@redhat.com>
>> -- 
>> 2.21.3
> 


