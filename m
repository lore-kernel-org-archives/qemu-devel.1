Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48B0C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E55221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/LMP4NR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E55221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLMdV-0001ql-7G
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 04:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kLMbi-0000FU-Je
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54454)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kLMbg-00076G-Uz
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600936080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GeJu9KMXd2w25b0YsMvMw5QnWIc//ZUzyGTvD/T+HHI=;
 b=G/LMP4NR9aJ2rsGhVCLkWSuDuWy8eQ/kNUfXhSCjhpVKyAhzBMCJB953wI+W0qYAfwtq96
 3OVKEgvxOlgZxQzTPqMXzFSIiPUs6x+dInKDkUPbl/dtzNyKPic6/fiVO4uGhQ80m2F+s3
 IMXIiAAPrrHMJsqvLKnSFD0TEsQdalU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-eY5wDQJxO1iMYHlxQOHBqg-1; Thu, 24 Sep 2020 04:27:58 -0400
X-MC-Unique: eY5wDQJxO1iMYHlxQOHBqg-1
Received: by mail-wr1-f71.google.com with SMTP id l9so923935wrq.20
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 01:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=GeJu9KMXd2w25b0YsMvMw5QnWIc//ZUzyGTvD/T+HHI=;
 b=sQUqgFV2wsXjOspUorxdekrh9njlyCQVBZpnJNV0GsvOXNooNdJunbLUG512G9BB4j
 8a3ji5FXfMnIqdL9cq8TlkGuddGVg3LPZdQM+518uQeC1iUURjfu8JFJAdkeCL7po637
 H/o9QTKvzpH50WVJ96yXG3m68PRI24AnoGgtw94xgAT0io5l9tDZDp2EnJYx6z/9qLjt
 0yDr7K4SqGc052TtgcoN77/UaWEqVdv4ZEEOcXDmgjQ27tn1Y42e8uUJGvFdb2ofaIwm
 VKPxPNOen5/cycR73fJHMuWLyhsee1LjcdlUlvEn8yYCkS536uul2U6nia+q5mO2xxk1
 9Evg==
X-Gm-Message-State: AOAM530hOAQMXYZus4zhv3Yl6blrvFJRw6pXo7vc1c7y+Th9bwwXMJ7V
 wp5ajja6a+4K2lWlsmoS+02f3uFCPyPaEkNiQYwPxW3A05OwAHJz9dmXDt0lRbd4XIpb5yB2BZV
 wt7L5C24NbjRUogo=
X-Received: by 2002:a1c:4b0e:: with SMTP id y14mr3440200wma.156.1600936077455; 
 Thu, 24 Sep 2020 01:27:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXOlhYHsmHTDDcZSQ27wvuAek6824n/LLdmXy6GhMKRis7f0mwX+uaBVcmUcMwB5HKDjsdoQ==
X-Received: by 2002:a1c:4b0e:: with SMTP id y14mr3440189wma.156.1600936077303; 
 Thu, 24 Sep 2020 01:27:57 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id u8sm2399395wmj.45.2020.09.24.01.27.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 01:27:56 -0700 (PDT)
Subject: Re: [PATCH v8 2/7] block/io: refactor coroutine wrappers
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
 <20200915164411.20590-3-vsementsov@virtuozzo.com>
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
Message-ID: <6416a3cf-c8c8-7488-0fe0-39c5286df9a3@redhat.com>
Date: Thu, 24 Sep 2020 10:27:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915164411.20590-3-vsementsov@virtuozzo.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 6:44 PM, Vladimir Sementsov-Ogievskiy wrote:
> Most of our coroutine wrappers already follow this convention:
> 
> We have 'coroutine_fn bdrv_co_<something>(<normal argument list>)' as
> the core function, and a wrapper 'bdrv_<something>(<same argument
> list>)' which does parameters packing and call bdrv_run_co().
> 
> The only outsiders are the bdrv_prwv_co and
> bdrv_common_block_status_above wrappers. Let's refactor them to behave
> as the others, it simplifies further conversion of coroutine wrappers.
> 
> This patch adds indirection layer, but it will be compensated by
> further commit, which will drop bdrv_co_prwv together with is_write
> logic, to keep read and write path separate.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/io.c | 60 +++++++++++++++++++++++++++++-------------------------
>  1 file changed, 32 insertions(+), 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


