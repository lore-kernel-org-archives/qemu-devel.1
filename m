Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A4AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F8220775
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNCcA4Sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F8220775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jonnx-00038N-6G
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 08:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jonmw-00025l-SN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:49:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53739
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jonmu-0006YL-Lr
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593175739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HnGVbtKSNknhMpMuNNoLfW6DPg7oSCnsUdVihCeC8NI=;
 b=VNCcA4Sf7Jk0OTv2Zdz5gguxiQEyM1KpgqzGvW0/xx7YQ00jA+uprOfgZN/HZGvBwIS8xB
 ZVEDjou0sDd+neRxlKeHIDinl2Ky7DeMwbKZOeBdZTK29KCDp7D+pg+BOBhfA8/YJoemOx
 ueLf3RmpLze5jaEM+TJseHkCfdBfTfo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-__CQe0IdNfinkfy_Qv3vHw-1; Fri, 26 Jun 2020 08:48:58 -0400
X-MC-Unique: __CQe0IdNfinkfy_Qv3vHw-1
Received: by mail-wr1-f69.google.com with SMTP id i14so10614691wru.17
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 05:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=iH6kQAb3vI2zEqS1XT+y8L3uQB60tvUHxBfkK0CBEJ0=;
 b=XgnyaO2e3W7DT3gOKc683pqLFsqKoLHetAxXaz5x1dXMc6Bchjv5xxtM6ivPEAYM1q
 jM0bNzDxEroniDzkdxUd3UnNlw8gOaSuxVthnlhm3yKCjOGnagnuiMZOcu9qei9DiWkR
 GsRYYswUHssozEhYR1jGe2CYtTw3xOhdnDmQSgZeDaFjDuG5iy+ajh8mQIzu0iRrKlQd
 53T23s/1vsb9m2yZ6e/2JyneEX0bfdQqqvZpIAPqf8d6mUzHC6cx3bevsc3TFyTLJvxI
 joN/bNKzRQg4ATYRALkaEFOjACwjmVxvyEhifz1a28ecae+tmpq3La6kVUdUPRbKWiLh
 RdKg==
X-Gm-Message-State: AOAM530w/Ml4NiL99De1nPxclzqw77+wR636Ld7zjtszI1qA460WJxaa
 LYRGAXVUi1mLxZ46dOy7lc1XaoBl92vmh+JglXWOiCLV+GrGf/Akz9hZ+WhB8znxkP30sfDCElc
 a34YLqPKT/xS9UPM=
X-Received: by 2002:a5d:60c7:: with SMTP id x7mr3384831wrt.138.1593175736988; 
 Fri, 26 Jun 2020 05:48:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxCvgfLyuUBDF1bCuqjufvKb33D9Ey74yZ+GadLc4ovCvc5g7JIv8UBcnO0ePiK4r2VU/+9Q==
X-Received: by 2002:a5d:60c7:: with SMTP id x7mr3384816wrt.138.1593175736777; 
 Fri, 26 Jun 2020 05:48:56 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w12sm27881396wrm.79.2020.06.26.05.48.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 05:48:56 -0700 (PDT)
Subject: Re: [PATCH 06/17] block/nvme: Replace qemu_try_blockalign(bs) by
 qemu_try_memalign(pg_sz)
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200625184838.28172-1-philmd@redhat.com>
 <20200625184838.28172-7-philmd@redhat.com>
 <20200626122433.GM281902@stefanha-x1.localdomain>
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
Message-ID: <65f87fc2-876a-6222-59eb-a17dd38986e7@redhat.com>
Date: Fri, 26 Jun 2020 14:48:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200626122433.GM281902@stefanha-x1.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 2:24 PM, Stefan Hajnoczi wrote:
> On Thu, Jun 25, 2020 at 08:48:27PM +0200, Philippe Mathieu-Daudé wrote:
>> qemu_try_blockalign() is a generic API that call back to the
>> block driver to return its page alignment. As we call from
>> within the very same driver, we already know to page alignment
>> stored in our state. Remove indirections and use the value from
>> BDRVNVMeState.
> 
> The higher-level qemu_try_blockalign() API does not require all callers
> to be aware of the memory alignment details. It seems like a
> disadvantage to duplicate that knowledge throughout the code, even if
> it's in the same driver source code.
> 
> Is there an advantage to this patch that I've missed?

This is required to later remove the BlockDriverState argument,
so nvme_init_queue() is per-hardware, not per-block-driver.


