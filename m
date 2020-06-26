Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7923FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424F4214DB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WfrJ7/So"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424F4214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jokVk-0000mh-Et
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 05:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jokV3-0000G0-A0
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 05:18:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43494
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jokV0-0006pe-8x
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 05:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593163097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=On0OdNqbjHCv2JKDtV62KBmSKUFRRJPlUtFyDmEDJvQ=;
 b=WfrJ7/SoPjzgigJxla19V7PvU0bAEL9sbJLYoNGoElutY8TI4ansYLfqWZ1LM7AkenrEpX
 ZaAphqb3O1zv4Jbz0Pw5Emf1NiRNUlZMP9jTPTwjNo8TIKS9U8aC5ULH5BMV4VpxPJjC5F
 KKziGhYt0WPqUI1aj58pJbPvbmkD9LU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-7hXlyK0eO9SMdKDf5WL2sA-1; Fri, 26 Jun 2020 05:18:11 -0400
X-MC-Unique: 7hXlyK0eO9SMdKDf5WL2sA-1
Received: by mail-wr1-f69.google.com with SMTP id g14so10137859wrp.8
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 02:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=On0OdNqbjHCv2JKDtV62KBmSKUFRRJPlUtFyDmEDJvQ=;
 b=ffRz3Z+s1laIT3L2IeklVDuKY3ESqpSPa5uWXkgaRACJG9JKUT8tKpQvAvY+Uu9DFe
 Rhd116AmaXV78XjNnlE5XOpuSVrW37v8g7bajg9Ucc0w5RcleDOuDLAjfwWaS8upR3Od
 hJgQrcEA5K5CgQx5tEmqGXfk31SVEuC/z2ThfkReSZU2k/IEpp5L6fCP7B36OMIcS0DX
 tnsnDOPk1ksv1LS/wjNG5DcuBylJUgFhxn4YNCJldfiwIs065ANgjTDQHz3i6SpsD0U3
 1yMc7j9g3BbSdMLJJiTrdUmUkSeWSTVzvctC1kkp1P8nqSyeFMcoMHCPUHdm9igCpKDN
 ce3w==
X-Gm-Message-State: AOAM532NMgmtxQZew1ZPhyMfZ6XXyT3SG+H1ScKFSxJdkbpR8I+h1noX
 TOPKNZBNT3UsvuKIyNEf+iIgpn+NxgLvA4RXsct4GEmM4HhNkpV9I4/WCckPbad0+pK7hzulkfY
 zjinArDL1w2503/g=
X-Received: by 2002:adf:ec42:: with SMTP id w2mr2669422wrn.269.1593163090485; 
 Fri, 26 Jun 2020 02:18:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf1V4nH7pyFtOuPQR1biXbmcCergOMx6BFXtm0j/ksXwVAlGqaNYCxpKOroigV6ik25yDIhA==
X-Received: by 2002:adf:ec42:: with SMTP id w2mr2669396wrn.269.1593163090287; 
 Fri, 26 Jun 2020 02:18:10 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id c66sm17523836wma.20.2020.06.26.02.18.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 02:18:09 -0700 (PDT)
Subject: Re: [PATCH 00/17] block/nvme: Various cleanups required to use
 multiple queues
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <159311322605.25974.4543808913481072992@d1fd068a5071>
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
Message-ID: <aa1a7754-0bbe-7f54-da81-48f9f38aff5b@redhat.com>
Date: Fri, 26 Jun 2020 11:18:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159311322605.25974.4543808913481072992@d1fd068a5071>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 patchew-devel@redhat.com, mlevitsk@redhat.com, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 9:27 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200625184838.28172-1-philmd@redhat.com/
> 
> 
> 
> Hi,
> 
> This series failed the docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> make docker-image-centos7 V=1 NETWORK=1
> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
>   CC      block/write-threshold.o
>   CC      block/backup.o
> /tmp/qemu-test/src/block/nvme.c: In function 'nvme_identify':
> /tmp/qemu-test/src/block/nvme.c:455:5: error: implicit declaration of function 'MAX_CONST' [-Werror=implicit-function-declaration]
>      idsz_max = MAX_CONST(sizeof(NvmeIdCtrl), sizeof(NvmeIdNs));
>      ^

I include in the cover:

Based-on: <20200625162602.700741-1-eblake@redhat.com>

Is patchew confused?

Ah, I get 404 on:
https://patchew.org/QEMU/20200625162602.700741-1-eblake@redhat.com/

So the mail got lost, 'Based-on' tag is ignored and the series still
applied?


