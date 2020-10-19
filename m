Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20315C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 13:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A19222BA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 13:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTnQAHa2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A19222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUVAw-00072f-4o
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 09:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUVAL-0006SL-15
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 09:25:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58167)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUVAJ-0004oZ-4Y
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 09:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603113930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MQdNMvebQaVlb6rcaL5w3GS+g7inuteecHZ/6EhMi+Q=;
 b=eTnQAHa2MVwfKBBen4204INvFwYxqHLx14xmM2q0s9h4CoaI5JSWocHnGBhwmJPKvx4cQl
 ZNMP79g8epyIPa3hOGBsj7WFz26U5rmpBkPlfFAjiAWkcBHGgT/0dwxt3c/kRCOh4SNo4J
 wEH3Of/Yca2SKyXQJGCW2soWpNyPr1Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-cC3V3Uk3P46i50djjdm2hw-1; Mon, 19 Oct 2020 09:25:27 -0400
X-MC-Unique: cC3V3Uk3P46i50djjdm2hw-1
Received: by mail-wm1-f69.google.com with SMTP id o15so3229456wmh.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 06:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MQdNMvebQaVlb6rcaL5w3GS+g7inuteecHZ/6EhMi+Q=;
 b=c7P8r7eSses7bD87SZlL2XykEsbBAanqWkm2R5ukr1RzLrnNlO9s19CUTsFAP7Nunb
 WRAnkkL6mUFuBC9BBSVdbRP/FXcM+S3NblavEmWxRHN6wNfWJ9/NlIEpVBcpO5H4m8Gx
 QV3Tcx/fi0+Ek5fgb76lZ8hjDAm9kmaWV+HzrQ8gU8/WNML2LVjG4vHDW9ryc6vjkSXw
 0lL7pTM/+0YZHk4i6B4UYQStQKJo4nYI/R7ELaPCLpknH1056KuYOB4XuVLg7ZjEcKYw
 SEyp6pSBJd0NgByPG/XTOrzfFJpblVWlgyPoN4Ye2qYHGaCzlUx6TYW13EJCAMASjrF9
 PwUg==
X-Gm-Message-State: AOAM531wYEOzYfxETydCH/ARAdUHB2bWvT1hHxfBF8faauDZUp0DJbQ7
 bFKmQBMkHJdGZA33U2/YVE1NppWiE6C85ytTyAJsb+2Z3Y4somfEL6aG7gXurWQ4YrsHOb1NfrM
 BbblFxWV0wXag85I=
X-Received: by 2002:a5d:43ca:: with SMTP id v10mr13128545wrr.7.1603113926341; 
 Mon, 19 Oct 2020 06:25:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwKNNjlGIt0D7x7hWYrmTczSFJosNunXOAUoKu5UcnVyl8GlLiZSnTIMP9HTAuWK4jfdGFsw==
X-Received: by 2002:a5d:43ca:: with SMTP id v10mr13128526wrr.7.1603113926151; 
 Mon, 19 Oct 2020 06:25:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id a17sm18478050wra.29.2020.10.19.06.25.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 06:25:25 -0700 (PDT)
Subject: Re: [PATCH v1 0/2] Add timeout mechanism to qmp actions
To: Zhenyu Ye <yezhenyu2@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20200810153811.GF14538@linux.fritz.box>
 <c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com>
 <20200914132738.GL579094@stefanha-x1.localdomain>
 <7ad220bd-7ee5-1f66-b2e5-7dc57d72eb2e@huawei.com>
 <20200917154415.GB839531@stefanha-x1.localdomain>
 <20200917160054.GA2453251@dev>
 <5a5822ec-f3bc-a247-2b5a-f764b941c820@huawei.com>
 <20200918140628.GA2509473@dev>
 <1ba06b0d-3fcf-3676-f9e0-52875851ff19@huawei.com>
 <20200921111435.GA2524022@dev>
 <20201013100033.GB164611@stefanha-x1.localdomain>
 <f70dc6ce-385b-a4f9-04a0-244018f3ddbb@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6fd02e2b-50fa-b667-efc6-47d1765bdd8c@redhat.com>
Date: Mon, 19 Oct 2020 15:25:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <f70dc6ce-385b-a4f9-04a0-244018f3ddbb@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: fam@euphon.net, Kevin Wolf <kwolf@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, armbru@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/10/20 14:40, Zhenyu Ye wrote:
> The kernel backtrace for io_submit in GUEST is:
> 
> 	guest# ./offcputime -K -p `pgrep -nx fio`
> 	    b'finish_task_switch'
> 	    b'__schedule'
> 	    b'schedule'
> 	    b'io_schedule'
> 	    b'blk_mq_get_tag'
> 	    b'blk_mq_get_request'
> 	    b'blk_mq_make_request'
> 	    b'generic_make_request'
> 	    b'submit_bio'
> 	    b'blkdev_direct_IO'
> 	    b'generic_file_read_iter'
> 	    b'aio_read'
> 	    b'io_submit_one'
> 	    b'__x64_sys_io_submit'
> 	    b'do_syscall_64'
> 	    b'entry_SYSCALL_64_after_hwframe'
> 	    -                fio (1464)
> 		40031912
> 
> And Linux io_uring can avoid the latency problem.

What filesystem are you using?

Paolo


