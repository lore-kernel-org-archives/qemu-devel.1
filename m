Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3E4C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:39:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A630F21741
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtDiw7vu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A630F21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrqw-0004Pr-LB
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kUreO-00073H-DV
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:26:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kUreJ-0000Or-1J
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603200357;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=UlDK1olgJUApIwQTgWSVFA6CQ9RzT4SJkpi8TsZ/nWA=;
 b=YtDiw7vuzELZjm9BnrhhT8gXUHhSDkDDvjqLdFx931PsAkAmGs+RkKjs4h14ZSb1FMztTu
 0v7VR85VtpwWowkzA4kDxHiBbQBumheqkIWQqgepxURm/Pf3isxyRR87+8V8WdqzCaQjnY
 7Ovn5nZM3u3uwOh86sA7gEE0sXuQbdY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-gJ9R6k52OY2RyXxBB2FPTg-1; Tue, 20 Oct 2020 09:25:54 -0400
X-MC-Unique: gJ9R6k52OY2RyXxBB2FPTg-1
Received: by mail-wm1-f69.google.com with SMTP id p17so396796wmi.7
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 06:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version;
 bh=UlDK1olgJUApIwQTgWSVFA6CQ9RzT4SJkpi8TsZ/nWA=;
 b=XbSACes6KEp/h+48v4ihf6WvGFWnpjltNrzCz5K7Dvg9SRjx8+q8CzAdW7sR23+yop
 +vo0S2SWTk+0DpHuOHnrgKReydL7J9gW0xk8Bl/45AOhEDjAOQ/q7pxNn4NQqvNhyjAP
 Kzp2PSL5se4n0kZVYurcLgLHvpCgT7d1wjMWsxAt1yttx7qewpuhArhc8wE9sh51RDEg
 nb4LRXfkE8qx8fxIwBkiwWnELm00RBvg13Ay8RhdtByZDAxNGNvpWaDU2R9zd0jZpwbt
 E6xvT4kkBPP6lmOWmmljuZ8BozLdJZKAdo6PLU+sX+tNF9BwI6gb0xh+mFqlb0auwZu+
 6ZjQ==
X-Gm-Message-State: AOAM531GWMBtS3seYg2zugNr7ohp6A8zVv1ArWybshhuv5t/0YVWAVdt
 HULWbqCOj4LRinaDuwTDejKjMZS15GaMN4wW9I8QclFJU53kzaZskGq6nyrmfFz8OEgEnx/BLik
 RjWI51/mK2WgnqyY=
X-Received: by 2002:a1c:2905:: with SMTP id p5mr3023057wmp.187.1603200353153; 
 Tue, 20 Oct 2020 06:25:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEQuuG5670QZuuWsE/1fLsUk6TZfYXbE+bXjgp9UEaso5Fx8r7shZuum7wxvFAiN61bGqAWw==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr3023039wmp.187.1603200352973; 
 Tue, 20 Oct 2020 06:25:52 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id 133sm1856765wmb.2.2020.10.20.06.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 06:25:52 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Bihong Yu <yubihong@huawei.com>
Subject: Re: [PATCH v3 2/8] migration: Don't use '#' flag of printf format
In-Reply-To: <1603163448-27122-3-git-send-email-yubihong@huawei.com> (Bihong
 Yu's message of "Tue, 20 Oct 2020 11:10:42 +0800")
References: <1603163448-27122-1-git-send-email-yubihong@huawei.com>
 <1603163448-27122-3-git-send-email-yubihong@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 20 Oct 2020 15:25:51 +0200
Message-ID: <87sga9c9ls.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: quintela@redhat.com
Cc: zhengchuan@huawei.com, qemu-trivial@nongnu.org, armbru@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, alex.chen@huawei.com,
 wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bihong Yu <yubihong@huawei.com> wrote:
> Signed-off-by: Bihong Yu <yubihong@huawei.com>
> Reviewed-by: Chuan Zheng <zhengchuan@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/block.c | 2 +-
>  migration/ram.c   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Juan Quintela <quintela@redhat.com>


