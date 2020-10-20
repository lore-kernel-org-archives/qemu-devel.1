Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09295C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 06:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3706E21789
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 06:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8ZfXJln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3706E21789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUlVW-0002r4-8L
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 02:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUlTm-0001pM-SL
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 02:50:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56514)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUlTl-00064J-Ax
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 02:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603176640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kebR4L1qhoE6f0CRqhCiqc9zsqxXEcNi7ESHYi6RmUQ=;
 b=a8ZfXJln0ez1rbZbR+DZO/79NkSU5abmp9sDD5kLfHQ84HZlaZZC7nk+3r/LgnGYj7uBaa
 L/5sreAMrOpL3DwULtjl/fcEhAnsHL+Fwj1pW7L17ahAibwZqxuFhsOSxCYJvAxM342ZOR
 /jRsvj8/wgpgDGCfiz4iMDEukyQhZzM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-DLm1_nYrOTq_YJ276vv2QA-1; Tue, 20 Oct 2020 02:50:38 -0400
X-MC-Unique: DLm1_nYrOTq_YJ276vv2QA-1
Received: by mail-wr1-f71.google.com with SMTP id q15so399380wrw.8
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 23:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kebR4L1qhoE6f0CRqhCiqc9zsqxXEcNi7ESHYi6RmUQ=;
 b=VJ+ZnaG5LJnzS3ASZdZR4YsJp8GYJIfbF/HytzDyyjnu3cpgUkAnObNGYfQk9gzguC
 LiOzdqdZA0y6I9ewELRRUsS1tuFTIDCBTcWjvktRZwx9T56aDI9hTRjUBRKy19MKajS7
 +2A5L1mZFogs/0cLB5H9u8TfzxelUKddTyBQxCIerRD1TF7PO2g7mXzFJ41AqfDVcHcU
 P8Z1lEVc///+vRLYdEvCGTwinuiJ9EfFH88ROx2zpnXCaXQCXwEXksI+l/pe3qaAwUNl
 D4tsz0D0/0GIOBBMwYb8e6yE+Db2sdx0foMO7mOfi1VtRlnl4B3Q+Mm49P1PBBbrRqvE
 dH9Q==
X-Gm-Message-State: AOAM53251EagTvr8SxpFG1ced8mh0S0X6IppWYLcwzVxRXxK6U3zLWRb
 LO3hI7TLcpa9VPZxQ2M+OxGUocMzDjqgpheKFSBVZRapX910h0/avede+/jSr24W+LaiqV76QN7
 Mum4efidu6CRwzKA=
X-Received: by 2002:a1c:6a0a:: with SMTP id f10mr1284340wmc.86.1603176637372; 
 Mon, 19 Oct 2020 23:50:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1s1k/xTbhCFDqlfqmkR6fJOUPhHSJjeBE5HZKfVN3B8Ukg9ofqNOHO1cAu5SBX3wwiDGWRA==
X-Received: by 2002:a1c:6a0a:: with SMTP id f10mr1284331wmc.86.1603176637244; 
 Mon, 19 Oct 2020 23:50:37 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id d4sm1357956wrp.47.2020.10.19.23.50.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 23:50:36 -0700 (PDT)
Subject: Re: [PATCH v2 8/8] migration: Delete redundant spaces
To: Bihong Yu <yubihong@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <1602508140-11372-1-git-send-email-yubihong@huawei.com>
 <1602508140-11372-9-git-send-email-yubihong@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0f830c28-82e4-c49d-5068-149a194607a4@redhat.com>
Date: Tue, 20 Oct 2020 08:50:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1602508140-11372-9-git-send-email-yubihong@huawei.com>
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

On 10/12/20 3:09 PM, Bihong Yu wrote:
> Signed-off-by: Bihong Yu <yubihong@huawei.com>
> Reviewed-by: Chuan Zheng <zhengchuan@huawei.com>
> ---
>   migration/rdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


