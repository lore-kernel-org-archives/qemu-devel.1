Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C783C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 10:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AFE621707
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 10:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbWqiG89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFE621707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNvrU-0002p3-Lo
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 06:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNvq2-0002BM-Mo
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 06:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNvq0-00018R-R2
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 06:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601548164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=enE+ttmUiE5pbKCj0JtbNNpuFVgy2IyJbr8ChC3Mt9Q=;
 b=PbWqiG89mh/517a6CawyofYn5BuX0eovtcY7wEESJCqpdGi0fKpr0/7sry8dpRf6plA2EF
 o5K01qhfgSZGMCelg1YEEE07/hXU1UwvkSmaHqvbs2Rd2X5im5xHU8eOoCNgrpXFRflREa
 Pg7G300epNalyJqT8X2wOXGSfG70I+c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-nU9gOLqVOz-sgkjiNevqpw-1; Thu, 01 Oct 2020 06:29:22 -0400
X-MC-Unique: nU9gOLqVOz-sgkjiNevqpw-1
Received: by mail-wm1-f71.google.com with SMTP id r83so1029876wma.8
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 03:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=9ZgEdRVj6E1JiUd4EdkT29CqCYAzu9/z0HicTQSz4Zk=;
 b=D1n1g/xFZ5VG/eU6CWUbCLZYM8BuMXl9YZh5yfjBPovtV12eyEIqHmhF71ztasi+Rs
 AjCbmffziSgWHRL2f45EQSyAjka5slTg7UXYq+NOPzkT1LMCBtvBfccaLNOz9qA3YwHu
 fPCpqBSjKrSf73ANmSz7s80ga/iw3VOw6vbsA9f1TChsyKJcqCkEcz3eAQohWfQ8xvB3
 Amq7y9130xtoILZ3RNE5JeKNWLs+3/7zxrUM4zSloKHmawrJzdkr+Xo95CS4Uu/rvrOx
 jwYPYeikNKUqLTXqCPbStxpL1wk3/I4L78F/XXoeJKh8sEUyRpMPdOgf0TkjrsujUCEN
 AHkQ==
X-Gm-Message-State: AOAM531kZxKc8j1VFdy9cwnQIng22bdbFHxFuQrc2djv5erq+zMi+utz
 GPEyj8hV4iWy/JCqWWij6QNgU96nALBQ5pR69+9BcHjwuLlaIcsdvGb3NwiM+FmzYfn99sc8yaq
 dK2C0JeXDzwkdGgI=
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr7909573wrm.422.1601548161049; 
 Thu, 01 Oct 2020 03:29:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXS0MBduD30zXvUC8dEk7UFsB8ylyYZZHGg3Nlb+GFjiduDsi2OmqbMKm2JBVwmyOQXh+/rw==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr7909553wrm.422.1601548160857; 
 Thu, 01 Oct 2020 03:29:20 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id h8sm8045809wrw.68.2020.10.01.03.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 03:29:20 -0700 (PDT)
Subject: Re: [PATCH] block/nvme: Add driver statistics for access alignment
 and hw errors
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200930133617.1320941-1-philmd@redhat.com>
 <20201001095903.GA343239@stefanha-x1.localdomain>
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
Message-ID: <42fc436d-bb93-d784-a0f5-6b2dccb6419c@redhat.com>
Date: Thu, 1 Oct 2020 12:29:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201001095903.GA343239@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/20 11:59 AM, Stefan Hajnoczi wrote:
> On Wed, Sep 30, 2020 at 03:36:17PM +0200, Philippe Mathieu-Daudé wrote:
>>     "return": [
>>         {
>>             "device": "",
>>             "node-name": "drive0",
>>             "stats": {
>>                 "flush_total_time_ns": 6026948,
>>                 "wr_highest_offset": 3383991230464,
>>                 "wr_total_time_ns": 807450995,
>>                 "failed_wr_operations": 0,
>>                 "failed_rd_operations": 0,
>>                 "wr_merged": 3,
>>                 "wr_bytes": 50133504,
>>                 "failed_unmap_operations": 0,
>>                 "failed_flush_operations": 0,
>>                 "account_invalid": false,
>>                 "rd_total_time_ns": 1846979900,
>>                 "flush_operations": 130,
>>                 "wr_operations": 659,
>>                 "rd_merged": 1192,
>>                 "rd_bytes": 218244096,
>>                 "account_failed": false,
>>                 "idle_time_ns": 2678641497,
>>                 "rd_operations": 7406,
>>             },
>>             "driver-specific": {
>>                 "driver": "nvme",
>>                 "completion-errors": 0,
>>                 "unaligned-access-nb": 2959,
>>                 "aligned-access-nb": 4477
> 
> "nb" is number?

Yes:

 # @aligned-access-nb: The number of aligned accesses performed by
 #                     the driver.
 #
 # @unaligned-access-nb: The number of unaligned accesses performed by
 #                       the driver.

Copied from:

qapi/block-core.json:928:# @discard-nb-ok: The number of successful
discard operations performed by
qapi/block-core.json:931:# @discard-nb-failed: The number of failed
discard operations performed by
qapi/block-core.json:940:      'discard-nb-ok': 'uint64',
qapi/block-core.json:941:      'discard-nb-failed': 'uint64',

> 
> Using plural ("unaligned-accesses" and "aligned-accesses") makes it
> clear that the value is a count. It's also consistent with the existing
> "wr_operations" and "failed_operations" stats.

OK, I'll update.

Thanks for the review,

Phil.



