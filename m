Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44C4C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 06:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0232522248
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 06:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D08F7fqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0232522248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXfDM-0007JH-TM
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 02:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXfCH-0006Ov-IK
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 02:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXfCC-00013h-QS
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 02:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603867469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IVkJb7Oay/XJ2GE/Aqdl6sPBB/98m+bgcTnhVeUTEKg=;
 b=D08F7fqoDLW8DJOTn3MShi89HfjpbQmgdYTD6M840zymJXzQn/Mn4NFv2TcLF4Kvsb5R2e
 9NhXwo+qLR2tg9SjELZLPYLGeWx/y7nLu6BV3jhcrUZC772SYx6pxBTWeHCI8A1l5/3QVC
 4E2FtL0xDsZjnh9eBttfHGH/62pUNAA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-LhEGqQ8COLu_iwXQA8EwXQ-1; Wed, 28 Oct 2020 02:44:27 -0400
X-MC-Unique: LhEGqQ8COLu_iwXQA8EwXQ-1
Received: by mail-ej1-f69.google.com with SMTP id z9so1794323ejg.10
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 23:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IVkJb7Oay/XJ2GE/Aqdl6sPBB/98m+bgcTnhVeUTEKg=;
 b=FNtAxQjJblIk2DHWYARNelkaGSfOSjkk7vCwypKrHCOfUHJM7PQrLZZFmf9Y/FQRv+
 lorO/e0Lrj+e94pY/gqPl9q8fiGJdrWpE86ZG1ZRuhXZ7ssdzmkcRx6CWdtKbJWe56BL
 7kQNmtBXiY3meJFrs/fvWoa9kR0JVPoY2Haae0cyF9IXV1Jf7ueGD7huHd8XkBrvgctM
 CJfyfgSyZhCcpg+R49ZPA0XXZUbfaMTio8jQckZJidD3OpN1VU3JR+B9OeWXpe0PFemZ
 EsJs3keN4zJfcMafhi/OIpg2mLZjojAabEwjbRGos2tg/OI3kRWiv042m4aQLwtWW8u3
 sCJw==
X-Gm-Message-State: AOAM531Kwz6ideAKMgbdLPNXbZmP1EoI6Crq8X+Ic/jt2g9G8CAk8Y36
 JSRNHIliRLKQzoG8KoG9dCSB5ROpN/7Pxevqp2zns3yygUoZGkMx90GGs0k20we6D7Ovbga+gnE
 dWevVVXh7HUdNB6A=
X-Received: by 2002:a17:906:c315:: with SMTP id
 s21mr2602970ejz.285.1603867465724; 
 Tue, 27 Oct 2020 23:44:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+9NOkpJVRBfKpnoh1sUDaum0hro+aefFU21dWIdsrAdxbmh9qZugQMxiKC+cfCwJFfuVslg==
X-Received: by 2002:a17:906:c315:: with SMTP id
 s21mr2602962ejz.285.1603867465527; 
 Tue, 27 Oct 2020 23:44:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id e17sm2311158ejh.64.2020.10.27.23.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 23:44:24 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] configure: add option to enable LTO
To: Daniele Buono <dbuono@linux.vnet.ibm.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <20201023200645.1055-4-dbuono@linux.vnet.ibm.com>
 <7aa00aba-ff8c-252a-899a-45ef4db7cc6e@redhat.com>
 <20201026155006.GE496050@redhat.com>
 <756e6060-394f-fe4a-47f2-2601b6e54a45@linux.vnet.ibm.com>
 <20201027151744.GF529052@redhat.com>
 <606b3283-25e5-329a-7d02-4d3d39383c73@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0b7e524f-59f5-a7b3-7e4f-608042f0bd4f@redhat.com>
Date: Wed, 28 Oct 2020 07:44:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <606b3283-25e5-329a-7d02-4d3d39383c73@linux.vnet.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Alexander Bulekov <alxndr@bu.edu>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/10/20 21:42, Daniele Buono wrote:
> Ok, no problem. I can definitely disable the check on GCC.
> 
> Paolo, would you like me to disable checks on AR/linker for lto too?
> If so, should I add some of this information on a document, perhaps
> docs/devel/lto.rst, so it is written somewhere for future uses?

I am not sure of the effects.  Does it simply effectively disable LTO or
is it something worse?

I'll look into the SCSI issue.

Paolo


