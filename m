Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E766C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 08:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E062206DC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 08:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7MFWbsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E062206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZVI6-0007A5-35
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 03:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZVHU-0006Yi-3N
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 03:33:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZVHS-0003YD-Ap
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 03:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604306013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pxSfnjahEFEWAzPFZRHd9Njse7YiuZ/EihSjOOgLrUc=;
 b=L7MFWbsvSevuYDmaGlvnYMoCzh20kUkwz6Uc1R0ATcQx3K4d3EiPpMNuwng7xShSCU4JYm
 gKCJ+WoUTxUcTRDO/Ig8wyrDhQr0FxAV30gu5H4MG6mO4ISlUAfgeSYjqb3wHezXlqc+c2
 sTSxX+MWjuScYpDlU70Gt6B7gjR+A/E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-rr1kSKo1O7GxDnDXOuhdjg-1; Mon, 02 Nov 2020 03:33:31 -0500
X-MC-Unique: rr1kSKo1O7GxDnDXOuhdjg-1
Received: by mail-wr1-f69.google.com with SMTP id m4so6112732wrq.23
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 00:33:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pxSfnjahEFEWAzPFZRHd9Njse7YiuZ/EihSjOOgLrUc=;
 b=IyHY4eTnUhYQr0RG1PWYCRpIzHw9IlDxsLq3FuYc33PjVIeSnWNJiQl6O7n5suSxWt
 90f5aRcTN2FNbaVyUzVEZJXLiYzct0uNx1nW7NibqdgMjzi7Hh52Ux7XcYWLB4He0dYG
 9y+2POFs3kEQNtrhgtvu/1ZQjJaSNZONyvqF6gjOMEuZptS6d8ZK3BNjDuNibVO0Fndn
 h8LykLZX5uIOoY0R8G4Lw//XDpIqZV/hXyA2Gpb/MNZ5JJBZDX8dpbxziPUdKkHFmQEr
 bZOxFo+wcY/NF6DG9eggCShkPGYwADNSXNTJ9AvwuMVBnBLqFs5vo/knU2iRK8eHl7AK
 7PXQ==
X-Gm-Message-State: AOAM531tWxXlFa3WtYC1hbgS1dPOoqoeSLeJh3h7XX4j+e7UZk3EM71W
 CcdqrvSnudieiGVTUIZyHJJNV5XOoYFywk0WXI8SLpOYfKs120i7eAbRxVnlKbSbanr1n13EmbQ
 K41uFJNqbhjApce4=
X-Received: by 2002:adf:8362:: with SMTP id 89mr19289819wrd.280.1604306010472; 
 Mon, 02 Nov 2020 00:33:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy92MykdNQPELLV5wxLx/Hzg8dkuwoTG2D8dOaTYSnS09DeIV8+JQwdOOf2pxwKhXKDcsZLMg==
X-Received: by 2002:adf:8362:: with SMTP id 89mr19289800wrd.280.1604306010278; 
 Mon, 02 Nov 2020 00:33:30 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id m14sm21239840wro.43.2020.11.02.00.33.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 00:33:29 -0800 (PST)
Subject: Re: [PATCH v2 0/2] Assorted fixes to tests that were broken by recent
 scsi changes
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20201101161532.259609-1-mlevitsk@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5f8ea310-1c8a-93bf-8b5f-987eae45da8b@redhat.com>
Date: Mon, 2 Nov 2020 09:33:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201101161532.259609-1-mlevitsk@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/11/20 17:15, Maxim Levitsky wrote:
> While most of the patches in V1 of this series are already merged upstream,
> the patch that fixes iotest 240 was broken on s390 and was not accepted.
> 
> This is	an updated version of this patch, based on Paulo's suggestion,
> that hopefully makes this iotest work on both x86 and s390.
> 
> Best regards,
> 	Maxim Levitsky
> 
> Maxim Levitsky (2):
>   iotests: add filter_qmp_virtio_scsi function
>   iotests: rewrite iotest 240 in python
> 
>  tests/qemu-iotests/240        | 228 +++++++++++++++-------------------
>  tests/qemu-iotests/240.out    |  76 +++++++-----
>  tests/qemu-iotests/iotests.py |  10 ++
>  3 files changed, 153 insertions(+), 161 deletions(-)
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


