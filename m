Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D066C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E542071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhcuUCr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E542071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgy5-0004LZ-8L
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1kAgxE-0002W7-CO
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:58:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23983)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1kAgxB-0000YQ-Ji
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598392684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X9qEEMjQk+TM7XgbVKWryx3YB2XMwDW8oj4udKG4l5g=;
 b=JhcuUCr06lh3tep+ldijF1urL0mN38WugNYaY8z/HPi3Tqq3rR9f6jz5CtO9r6foEMHQxA
 BVi0L/Y0bGQpeqC6c8Ukse9n2esttnQOP6gYrMNhONNnIEMATdb/ciAZ/nz5Yvm50ppACl
 9wjS9V6R/uNd1QoWHpNtIU10Rb9+N/w=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-LrsC6VixPxCPZ5bjq5Q_Tw-1; Tue, 25 Aug 2020 17:58:01 -0400
X-MC-Unique: LrsC6VixPxCPZ5bjq5Q_Tw-1
Received: by mail-qk1-f198.google.com with SMTP id t10so301334qke.11
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X9qEEMjQk+TM7XgbVKWryx3YB2XMwDW8oj4udKG4l5g=;
 b=UhqdXhz+vQtKpvjDl+ZGkrmlUPyySg7Yfp4zGvv5DgIVU/E1tQ2Wl/dCZeccJ0SXQl
 yVOagqQAddmBw0jMts5t4yOoJdQVmemFFzF7P+73BIBQAaZiGVzDuFYwOkbrY5P7REfD
 Zo/qt4KYZ5Joe5COaD04DinNymovH7ChRyX8EQjyr/JeKCla0Yl+LSq2ZpaKhAFJ0oYE
 qnjlPTgI0z073q1dYnoPgT/WV7jV7kpjTXGchFSVYvRXrso6EAE5ZYuc+yJ+HnmIuAQ/
 Bqob4p7ZTyxfTZbLpoCGHtteF2FP5DhNRJ/EBgoYi28U0UyWQoK+Imsb8rlXGcOY4l5U
 Tzow==
X-Gm-Message-State: AOAM5325RjuQB1TvgL0z9yN4c14rlwi8cNf/a4Rj1VTWsPKG5k8ordeF
 BLbDokXvyhLeoPQOLSzH1dD/x/X5v2kdsXD/QaQANuzCbdJC5JaxSlSpskjPEJNgLfsZEMe7TC0
 /l2iR48LvoPI85Qk=
X-Received: by 2002:a05:620a:22a1:: with SMTP id
 p1mr4787993qkh.14.1598392680324; 
 Tue, 25 Aug 2020 14:58:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZwkFbHQEM1KP/jkcTAGd7bTS5JL8PD6Kl+ieLhqcWBvbk7EDULCTtKFS0EezlhhLgisHn4w==
X-Received: by 2002:a05:620a:22a1:: with SMTP id
 p1mr4787986qkh.14.1598392680097; 
 Tue, 25 Aug 2020 14:58:00 -0700 (PDT)
Received: from [192.168.0.172] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
 by smtp.gmail.com with ESMTPSA id
 s33sm237236qts.48.2020.08.25.14.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 14:57:59 -0700 (PDT)
Subject: Re: [PATCH v3] block: Raise an error when backing file parameter is
 an empty string
From: Connor Kuehl <ckuehl@redhat.com>
To: kwolf@redhat.com, mreitz@redhat.com
References: <20200813134722.802180-1-ckuehl@redhat.com>
Message-ID: <0977d901-c2fd-40b9-f694-914e1b895653@redhat.com>
Date: Tue, 25 Aug 2020 16:57:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813134722.802180-1-ckuehl@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ckuehl@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ckuehl@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 17:42:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 8:47 AM, Connor Kuehl wrote:
> Providing an empty string for the backing file parameter like so:
> 
> 	qemu-img create -f qcow2 -b '' /tmp/foo
> 
> allows the flow of control to reach and subsequently fail an assert
> statement because passing an empty string to
> 
> 	bdrv_get_full_backing_filename_from_filename()
> 
> simply results in NULL being returned without an error being raised.
> 
> To fix this, let's check for an empty string when getting the value from
> the opts list.
> 
> Reported-by: Attila Fazekas <afazekas@redhat.com>
> Fixes: https://bugzilla.redhat.com/1809553
> Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
> ---
> v3:
>    - Moved test case into 049 instead of taking up
>      298.
> 
> v2:
>    - Removed 4 spaces to resolve pylint warning
>    - Updated format to be 'iotests.imgfmt' instead
>      of hardcoding 'qcow2'
>    - Use temporary file instead of '/tmp/foo'
>    - Give a size parameter to qemu-img
>    - Run test for qcow2, qcow, qed and *not* raw

Ping


