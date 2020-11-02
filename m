Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BEEC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87C412231B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMFk+2CN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C412231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZaJd-00048V-KW
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 08:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZaIk-0003H6-Lf
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:55:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZaIi-0004Bg-KU
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604325311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2wo+iauf944io0k5WoWvoN0xCKEdsUieTGO4MpguynU=;
 b=JMFk+2CNnpKnMRbro5oYvZ+Zt6V/vJ/ck7kQFas3qfsz5krFuIBKfoJmB1mH2mdBUOb2Z7
 7tC2yUMDxnOjjIrmosjPR1jp0/TuxXuCFv8pbxPg/D8mOEc72bMXmxdin5guEANPiAGmGq
 B4YHLV6fRWoWpj8AkZLHjKgreIoYIYo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-v9XTRid8NGiZsuoh7GHElg-1; Mon, 02 Nov 2020 08:55:07 -0500
X-MC-Unique: v9XTRid8NGiZsuoh7GHElg-1
Received: by mail-wr1-f70.google.com with SMTP id w1so6455684wrr.5
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 05:55:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2wo+iauf944io0k5WoWvoN0xCKEdsUieTGO4MpguynU=;
 b=Nq8PTvifPBh4iDXKEp2zZQeVuH7D1pcw6+86mT+VBNEhhoAjinHF8gpMcbaFwnKr7E
 MAVvgmkkSGSU7l4f7AQKlWXO1cN1bnhy40xYwrvfs8iJW1pJpxiJJeW5qYDKp32eUeCA
 lrGefzWP/cBl4OwsvWP5f6cB2Y3UJDsrOQe9+Xb/cC0tqT5TsrCFs0lSaRUKHSCnUjZ5
 UhnSxJdYTf+C9E7uB5Sib58wSaz8X4G7IVZZWpt0szHI6K35fYQoQJ7IpWO0INvRvgu4
 FaERE91Flu+7lELRWRUVeJ/5dQPtvuCXuZ0XTJXzzYD3PAbFWckRyjIAT2eWjak2Llgy
 ZvUA==
X-Gm-Message-State: AOAM533VFW8uWYwF+3gzpvPxB+ft+ydaDh8G0aQoDLsrKCWde7D9eohh
 KrhuRnSCHV1rZG/N6bM0e8WBFf1O1+4M2jgJSPbmhE0it83KCNjW1pfoDzt/qyhIdZXC3grwuat
 L+43x4WkDQnXlUZY=
X-Received: by 2002:a5d:518e:: with SMTP id k14mr20763380wrv.60.1604325306255; 
 Mon, 02 Nov 2020 05:55:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5+eumSHDSBSVLzyPdNPJn+B8ui/8KF//yoQAk630yS2CDBJT1T4Xwle8hS+Vt4DrYOrLvsw==
X-Received: by 2002:a5d:518e:: with SMTP id k14mr20763354wrv.60.1604325306093; 
 Mon, 02 Nov 2020 05:55:06 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t19sm17034372wmi.26.2020.11.02.05.55.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 05:55:05 -0800 (PST)
Subject: Re: recent flakiness (intermittent hangs) of migration-test
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
References: <CAFEAcA-EsEZWDbUSy6_AXym5e-wP_B4buZYG0swF946ue41WKg@mail.gmail.com>
 <20201029174124.GD3335@work-vm>
 <CAFEAcA9ex69Ov=hfb4LUQak=_bnwQc8mjUx4MgEwgSciD8Ut+A@mail.gmail.com>
 <20201029193433.GE3335@work-vm> <20201029202810.GD455015@xz-x1>
 <CAFEAcA_ZEHHdKO+82G_e16uZkSbtH-Rjn701Nc0e7pOfk3OUoA@mail.gmail.com>
 <20201030135350.GA588069@xz-x1>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f3a379ca-5c7b-0c19-b0ea-6354c460eff3@redhat.com>
Date: Mon, 2 Nov 2020 14:55:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201030135350.GA588069@xz-x1>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 2:53 PM, Peter Xu wrote:
> On Fri, Oct 30, 2020 at 11:48:28AM +0000, Peter Maydell wrote:
>>> Peter, is it possible that you enable QTEST_LOG=1 in your future migration-test
>>> testcase and try to capture the stderr?  With the help of commit a47295014d
>>> ("migration-test: Only hide error if !QTEST_LOG", 2020-10-26), the test should
>>> be able to dump quite some helpful information to further identify the issue.
>>
>> Here's the result of running just the migration test with
>> QTEST_LOG=1:
>> https://people.linaro.org/~peter.maydell/migration.log
>> It's 300MB because when the test hangs one of the processes
>> is apparently in a polling state and continues to send status
>> queries.
>>
>> My impression is that the test is OK on an unloaded machine but
>> more likely to fail if the box is doing other things at the
>> same time. Alternatively it might be a 'parallel make check' bug.
> 
> Thanks for collecting that, Peter.
> 
> I'm copy-pasting the important information out here (with some moves and
> indents to make things even clearer):
> 
> ...
> {"execute": "migrate-recover", "arguments": {"uri": "unix:/tmp/migration-test-nGzu4q/migsocket-recover"}, "id": "recover-cmd"}
> {"timestamp": {"seconds": 1604056292, "microseconds": 177955}, "event": "MIGRATION", "data": {"status": "setup"}}
> {"return": {}, "id": "recover-cmd"}
> {"execute": "query-migrate"}
> ...
> {"execute": "migrate", "arguments": {"resume": true, "uri": "unix:/tmp/migration-test-nGzu4q/migsocket-recover"}}
> qemu-system-x86_64: ram_save_queue_pages no previous block
> qemu-system-x86_64: Detected IO failure for postcopy. Migration paused.
> {"return": {}}
> {"execute": "migrate-set-parameters", "arguments": {"max-postcopy-bandwidth": 0}}
> ...
> 
> The problem is probably an misuse on last_rb on destination node.  When looking
> at it, I also found a race.  So I guess I should fix both...
> 
> Peter, would it be easy to try apply the two patches I attached to see whether
> the test hang would be resolved?  Dave, feel free to give early comments too on
> the two fixes before I post them on the list.

Per this comment:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg756235.html
You could add:
Tested-by: Christian Schoenebeck <qemu_oss@crudebyte.com>


