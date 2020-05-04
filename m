Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58E1C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A5C20721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoqQWaIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A5C20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdTy-0000JS-Q6
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jVdTG-0007zx-CP
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:57:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56473
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jVdTF-0005HG-7f
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588607847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d1OJbH4UpV1OJFyLIFWajC85ubtEmf1EXcRqvU/IOCg=;
 b=WoqQWaIJHJxdZh/iBb4cqQedfOKRQEfyBnOb4iGaxCu78tgPh5fPgcClCre50aIbVu3Ssc
 IDyQNT5+BZkRSMq8cW5NfWA4q5tYNE8hbNv7K5NMCN8QhkwAhDn7erCXSF6Bl1+Bxz2bg7
 YD5zI/ASOEtDV+jn3I1CXvnHuvKQ5no=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-Jhyfy6QyPQ2J9L8cEHR3Wg-1; Mon, 04 May 2020 11:57:24 -0400
X-MC-Unique: Jhyfy6QyPQ2J9L8cEHR3Wg-1
Received: by mail-wm1-f71.google.com with SMTP id 71so1505wmb.8
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 08:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d1OJbH4UpV1OJFyLIFWajC85ubtEmf1EXcRqvU/IOCg=;
 b=EeYi7GvMHYfyi/VsBO6xcbcw3G17AGFiZg0yjWer1cdjW8hn/Obk2gjMM2SDFbiOMR
 P5eQSReJHkPg31sxXahZft6ER01ZD1rzu/Eg0vrb1vXSoopgITc61EDpPrUyS3AwP+JX
 wxvXKdATNFlP70/XAH8gHZnnwmEfvzDVpgvFEd/Zt+Bhqec8bHPnXPHNXWNBCacpWCHs
 fHxA0HHRaUlgEayr1JMCtFq2a//p9+AIIaowAuwX1qWclcjRW8f5qRmySs6sGdPYAfgs
 pH63ICYG8dNqm2cVbtHY5rF+0UWMdKn6mmPn8q+Pd0pJfoCqCJ0br0neO9rB20tSqBQm
 TAow==
X-Gm-Message-State: AGi0PuYw3D5aB/aym/3ZA6G8vdi0OFOpmnJUf+EPblGOcFd7p5/A8VQY
 p5478ocj3zZLACpqkBzQf4olno3yj+63yI9B2K8c3FWFJQPR9BmMw1iqToMLEM9OqUUPUJs3B27
 UOYrzF1gt0ZPXdyU=
X-Received: by 2002:adf:f784:: with SMTP id q4mr19815023wrp.102.1588607842726; 
 Mon, 04 May 2020 08:57:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypJlFbydeyvgRQVtIl4L/FXYswtFGIgcSeRelCajS4lenTr0cx5p9WcMHwgksOrILCaBQhi+8Q==
X-Received: by 2002:adf:f784:: with SMTP id q4mr19815004wrp.102.1588607842562; 
 Mon, 04 May 2020 08:57:22 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
 by smtp.gmail.com with ESMTPSA id k9sm20120247wrd.17.2020.05.04.08.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 08:57:21 -0700 (PDT)
Subject: Re: [PATCH 00/17] qom: Spring cleaning
To: Markus Armbruster <armbru@redhat.com>
References: <20200428163419.4483-1-armbru@redhat.com>
 <80ff76e3-3e59-df8f-d943-9429d4cc1d57@redhat.com>
 <87h7wvzpm0.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <265637b7-25c8-1af1-46b9-046d153df30a@redhat.com>
Date: Mon, 4 May 2020 17:57:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87h7wvzpm0.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/05/20 17:28, Markus Armbruster wrote:
>> I reviewed everything except patch 8 and it looks good.  Thanks very much!
> May I add Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>?
> 

For those 16 yes.

Paolo


