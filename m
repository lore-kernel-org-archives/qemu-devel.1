Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDD9C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 10:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 040ED20848
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 10:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JktZE7Ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040ED20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNvkT-0007ab-6d
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 06:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNvjB-0006ll-Tl
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 06:22:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNvj8-0000Bx-Pb
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 06:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601547737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=04WCg1kJ7NYBTu0MogV133WIoa+AyFeKIay2LeMdEJ0=;
 b=JktZE7Ldu/7frKGsZ8PSPyNWLxTWBo+fkNlc2y4rVTE0e9F+ubi1tWof3ONme7z0T8+Apn
 +OKV6xZPIyFXBl90NHDxwo1GAolcmhjKRwG8zdPpzSDh1RFEkE8f4YeIw+yJ31pZlu7L64
 Y0WCR+DcGlq3s9c9YbhSjzIQp+BLn7I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-kEP4id6mMpech8cXVaZwFA-1; Thu, 01 Oct 2020 06:22:16 -0400
X-MC-Unique: kEP4id6mMpech8cXVaZwFA-1
Received: by mail-wr1-f70.google.com with SMTP id v12so1858087wrm.9
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 03:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=04WCg1kJ7NYBTu0MogV133WIoa+AyFeKIay2LeMdEJ0=;
 b=HqBmaQI5gzPhteR5qNRoBDtZ3KI8BA2DVzKoCcEiJPb0zw3sIKGn4/lAgecQT23Gtu
 tJq8ELPNaE9xr/jbn+pfd8u9Gm6YeaXIXxaAxKJBV6QAl9tpZDOpUMYiA4XFKuS46/10
 9brp2XBJoDS36oOd2j4x7H7D0Fu0YS6HAW2APomu6/+f9PIWXEu8WXK4jf1nrKVdaLCf
 6kSBu2kaWKzG8hFYP241KOfPa1PLfHq6c//tLMTeiE+4SY4ithEDJs2NuUMJoSwvjMs0
 vOooFuRHXSJpoXpfnmdNY0b3YkyZKYT+bjFJoNyoxYsjviigI6x3NRj6aCRVJjPe83PH
 jQQw==
X-Gm-Message-State: AOAM530VOuAMWUSq7y1QnbDZU8QBVFINi9hAOe0nZT8+jVlY8eGvSygX
 DsO6IzUvWKIP2nzQYuBTRZMv0jNj8bMs4+xAzIqtwLXNrNTUa8jQbA6YrYpO7MKgyLLONKQPCHR
 9P/IqIx5WonbDMIo=
X-Received: by 2002:a5d:444e:: with SMTP id x14mr7735174wrr.235.1601547734877; 
 Thu, 01 Oct 2020 03:22:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyU9PE1Mivs0p9NiDh0723gaHPIiNXHhbZ42yMOdo9SMumsfaPv4QwjKxIAIyZvRZo3GvajXQ==
X-Received: by 2002:a5d:444e:: with SMTP id x14mr7735154wrr.235.1601547734710; 
 Thu, 01 Oct 2020 03:22:14 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id m10sm7835517wmi.9.2020.10.01.03.22.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 03:22:13 -0700 (PDT)
Subject: Re: [PATCH v3 01/11] qapi: Restrict query-uuid command to block code
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20200930164949.1425294-1-philmd@redhat.com>
 <20200930164949.1425294-2-philmd@redhat.com>
 <87r1qi4jvj.fsf@dusky.pond.sub.org>
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
Message-ID: <38e2b34b-7bb8-9e4b-680c-22e1fd21c3ef@redhat.com>
Date: Thu, 1 Oct 2020 12:22:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87r1qi4jvj.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Igor

On 10/1/20 7:04 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> In commit f68c01470b we restricted the query-uuid command to
>> machine code, but it is incorrect, as it is also used by the
>> tools.  Therefore move this command again, but to block.json,
>> which is shared by machine code and tools.
>>
>> Fixes: f68c01470b ("qapi: Restrict query-uuid command to machine code")
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> UUIDs are not really a block-specific thing.

This is the discussion we had in v1 with Igor...

UuidInfo is a iSCSI-specific "thing", the original commit
is f9dadc9855 ("iSCSI: add configuration variables for iSCSI")
then Paolo introduced 'UuidInfo' in commit 5accc8408f
("scsi: prefer UUID to VM name for the initiator name") but
is misnamed?

> 
> QMP query-uuid and HMP info uuid are about the VM, like query-name.
> That's why they used to be next to query-name in misc.json.

This is GuidInfo, not UuidInfo...

GuidInfo is correctly in machine.json.

> 
> There's one additional use in block/iscsi.c's get_initiator_name().  I
> figure that's what pulls it into tools via qemu-img.

Yes.

> 
> Which other QAPI modules are shared by all the executables that use it?

None?

> 
> What about reverting the commit?  How bad would that be for user mode?
> 

The problem is not user-mode, is linking tools.


