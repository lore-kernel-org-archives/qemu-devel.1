Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E26C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 06:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F9C2237B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 06:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awoEVQsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F9C2237B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUlSO-0000Sr-Mh
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 02:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUlRI-00087P-4r
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 02:48:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUlRF-00057j-9p
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 02:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603176483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LWLCVTdCZyi5yN6osaeoydriTjPfetkYsvgZHOBfmLM=;
 b=awoEVQsTvk+LDpXopJP3LSIgL3M0K9PyRX1fhl/tMjMgBUXyf1MtIfyeMIB9BCVB1QLWus
 5MzERMLEgGYzvpwKrsm7YfmPfeojDoriVGviDprqJnuinzQ0/dX9PpnNc8dNTn1j3a0Whg
 JXGG6gHF4CeCIuhRF8vkpy4SiI5ep9M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-Ywp66rWIOda-Sa5Y2asuBQ-1; Tue, 20 Oct 2020 02:48:02 -0400
X-MC-Unique: Ywp66rWIOda-Sa5Y2asuBQ-1
Received: by mail-wr1-f70.google.com with SMTP id 2so393007wrd.14
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 23:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LWLCVTdCZyi5yN6osaeoydriTjPfetkYsvgZHOBfmLM=;
 b=Nbu9sS3Ve+209VVf5i6SudPfaemy5whABtrKd8LxmlZ4SCDjMh8bWBacp3wlkqD6wI
 T3oAMDOI24t6JGsUFLpMydzQM0o7OyR5oPL4I02uTY2fIQdqihgTqoeNAz0BST8CKe2D
 WOzTJS/D66gfZ/nXp3Rvw3xNsZhpOleQTok6vumsw7hpkdASt0xfOtbMm1EFtN3umJjF
 2F4c+M9XNZdiEF4PVRb1guUkkSHrf6EC3KUpINFn7sdgQv+8im1klgTjntoGAO+SckVN
 9Fia1EJ+BlhNTHbMSSOOqD5gyfOMbMLO66Jrqzgp3HxcSjNeJ7mIdk7J8nBJw/fA7Vv7
 srxg==
X-Gm-Message-State: AOAM533dS7MbFyGxttyPwdAJjjwBRA+hRVLaDK4QqI/i29DlRV91nTUK
 DdRt5qtB+wBHw80t1VcQbTcbae3qsTau2E8ZjY+yUlkTBhYNA4xRU+jV+mi3m6ZwuRUCc2BDNMG
 6irW0FkkpsMbVvXQ=
X-Received: by 2002:a5d:4088:: with SMTP id o8mr1735813wrp.2.1603176481089;
 Mon, 19 Oct 2020 23:48:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwU0vfChRY++x9/E9BjbEBOJEUMS5arQ6uE+F/hAtLGodyy8xYzxp/YhmKLCFZuZ42ctmVHnQ==
X-Received: by 2002:a5d:4088:: with SMTP id o8mr1735785wrp.2.1603176480839;
 Mon, 19 Oct 2020 23:48:00 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id p9sm1182138wmm.4.2020.10.19.23.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 23:48:00 -0700 (PDT)
Subject: Re: [PATCH v2 5/8] migration: Add braces {} for if statement
To: Bihong Yu <yubihong@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <1602508140-11372-1-git-send-email-yubihong@huawei.com>
 <1602508140-11372-6-git-send-email-yubihong@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dc644324-0291-842f-e389-0328ecdfae3f@redhat.com>
Date: Tue, 20 Oct 2020 08:47:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1602508140-11372-6-git-send-email-yubihong@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: zhengchuan@huawei.com, alex.chen@huawei.com, wanghao232@huawei.com,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 3:08 PM, Bihong Yu wrote:
> Signed-off-by: Bihong Yu <yubihong@huawei.com>
> Reviewed-by: Chuan Zheng <zhengchuan@huawei.com>
> ---
>   migration/ram.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


