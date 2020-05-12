Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E2EC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975CC206D3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEYeKKrs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975CC206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVBS-0005Ay-RX
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYVAo-0004gI-6j
 for qemu-devel@nongnu.org; Tue, 12 May 2020 09:42:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47714
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYVAn-0001MI-D7
 for qemu-devel@nongnu.org; Tue, 12 May 2020 09:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589290936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jHDZ0dZUDN5xzAOYR2TX3jZY7ONTt7muSwuHPSyJsms=;
 b=JEYeKKrsJAA5Uf6nBxRd9SiHydRmrJSRX1JO3q0BPLXEIgOBBE/Gc6kI/8bqqTsWeUpafu
 /rxdSpq6gp1LxT22QdtIUJyUqopdHEMLgSIhHwWzKD3Zmqy6GO6bafOptaExqkGgNGvjZw
 6IcDttWlr/0ULoGK214N8BLeHy8bvkY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-63rlDJA1PTiuEH7wo6E0cw-1; Tue, 12 May 2020 09:42:14 -0400
X-MC-Unique: 63rlDJA1PTiuEH7wo6E0cw-1
Received: by mail-wr1-f69.google.com with SMTP id p2so5052222wrm.6
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 06:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jHDZ0dZUDN5xzAOYR2TX3jZY7ONTt7muSwuHPSyJsms=;
 b=ra+eqoy5nv/AfXXztnX7UOfV4EguESeyJjznu029GGqfpyQ7acbP1+m+Kc2OVvINSz
 3lH7fiJPMitvRrLC5hdp9AJjSZGbH+nzCQf47n6qgBogo+nfpALV8hcFQfN8kllfDZyu
 BsEogK7rJKpLv7omULdOOFeo5RWN1jl/TcDPZ89f5Y1XmFqDHQNxeQYgpVwPMpUPWfsW
 Gk2qgnf9kII2z7RPPewiDBIiaYJvAGFk3RwuSEGuNm5KV5j2DmIbubW/Hfqid7XAJYEZ
 2YOw0JGmpciTdeA3lYvhmHI4w1VmdfTQRufQk5hsfvCItUy/hKSoMr/xGNUAX7DvW9JM
 /r6w==
X-Gm-Message-State: AGi0PuZcrLXcx/j7gUmI++PlXuovXvbgQ6np/BrfEET5cJkNnBVyyAbL
 dOv1XnnNl8kODo0SfZU3va+iLPPgqKDcwN2eXekK20pQON2eiP31T8gAe+AitL9rEXxU2mpGEmC
 GiT5VrRiOEqtm5Nk=
X-Received: by 2002:a05:6000:1048:: with SMTP id
 c8mr25169614wrx.1.1589290933429; 
 Tue, 12 May 2020 06:42:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypJnYy947JbrXNEqDxc5jmujq/e+Pgo8OsMW48uOCXmiBtgJtr+Lu5Az4Mqew4CpLPwFKobu+g==
X-Received: by 2002:a05:6000:1048:: with SMTP id
 c8mr25169595wrx.1.1589290933189; 
 Tue, 12 May 2020 06:42:13 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a67sm33861249wmc.30.2020.05.12.06.42.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 06:42:12 -0700 (PDT)
Subject: Re: [PATCH 0/2] use unsigned type for MegasasState fields
To: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
References: <20200507105718.1319187-1-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <26201c24-c483-85a7-2f4b-b3cc56d4b8b7@redhat.com>
Date: Tue, 12 May 2020 15:42:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200507105718.1319187-1-ppandit@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Ren Ding <rding@gatech.edu>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Marc-André our signed/unsigned conversion expert (with Paolo).

On 5/7/20 12:57 PM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> Hello,
> 
> * This series fixes an OOB access issue which may occur when a guest user
>    sets 's->reply_queue_head' field to a negative(or large positive) value,
>    via 'struct mfi_init_qinfo' object in megasas_init_firmware().

Do you have a reproducer?

> 
> * Second patch updates other numeric fields of MegasasState to unsigned type.
> 
> Thank you.
> ---
> Prasad J Pandit (2):
>    megasas: use unsigned type for reply_queue_head
>    megasas: use unsigned type for positive numeric fields
> 
>   hw/scsi/megasas.c | 40 ++++++++++++++++++++--------------------
>   1 file changed, 20 insertions(+), 20 deletions(-)
> 


