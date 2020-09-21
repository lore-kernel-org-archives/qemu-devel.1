Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E77DC43468
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:10:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9672F2084C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blP2fuud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9672F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKMW7-0005sV-Gm
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKMUq-0004sh-M3
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21244)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKMUo-0000IT-TE
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600697326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bBoOP2bsrpqSrWBv6BZ9m/qCfNs24g68o6hYRVMSxjA=;
 b=blP2fuudX9A4NFjAd92GaDkd5OJRY4UQLd/v91sSXbY0sWcHbXesywl+JCprk/i6N1I5L+
 wWDh7k3uWeLH4Qr7Vqyu7nILGk7n2tfCiC2AwKJI0Onu6GMnWRJt1e+n9HoSJVnQjG6ZRV
 yt2Flq/ojLV7Y2Xi/0rXzYPgfb7bEXY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-3QQONmwhMxm2YKsJ5j_iSQ-1; Mon, 21 Sep 2020 10:08:29 -0400
X-MC-Unique: 3QQONmwhMxm2YKsJ5j_iSQ-1
Received: by mail-wr1-f71.google.com with SMTP id x15so5874039wrm.7
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 07:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bBoOP2bsrpqSrWBv6BZ9m/qCfNs24g68o6hYRVMSxjA=;
 b=VJ2IEsigy4Xhe2V0yCoTaB+he0pVzIzzlfPjqSga76s34t2tB1pk+UYJ3RxtFsk9hK
 C7MQkBalOxC46yPXOM8x7R3LXlYbfrd8ZNkkT1ntCmYBRnxog68wLbYeNqF4Cerb8CsS
 7P2Vor0prRZRzXgjU7AdIIqMqTToQTE9EKcyOX70tdWVJl3erHLGy8dINB6wG1Qd2CqQ
 m0jCXMTlFX4IKJzumwEgwWxVGyCPyXftLhOQJxnUTE8yHh3W3zN0wUlczQaeLOenioW2
 2oMr/8c7G0eswcPK9qGEaFwTrSt1vaKktixjf1Ybupy5f3TR3jDbV1vtXeZTYr9NTW1t
 NCTg==
X-Gm-Message-State: AOAM530ruYCXOBxCAA1nD5Fj53THj5FerqmcVDLGCh+H8bJcVFW+vUYF
 RPnf74acZ+/X8XN5rH4NdXmyMu5zLJ0pkjaqEBzV5y+WIXqZlz/lR2hfFpBTB+2gmqc3T8xOqz5
 omWi1YKDw+FppBB0=
X-Received: by 2002:adf:f5ce:: with SMTP id k14mr51166930wrp.286.1600697308213; 
 Mon, 21 Sep 2020 07:08:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6RSO3fnt1scH0UU+eS+RfKA2zc58ScuQU0k4q/jgIDNiqMVqv6oDwH9yVF+EH4GCwp8dXYw==
X-Received: by 2002:adf:f5ce:: with SMTP id k14mr51166919wrp.286.1600697308030; 
 Mon, 21 Sep 2020 07:08:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d153:8d0f:94cf:5114?
 ([2001:b07:6468:f312:d153:8d0f:94cf:5114])
 by smtp.gmail.com with ESMTPSA id k4sm21545961wrx.51.2020.09.21.07.08.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 07:08:26 -0700 (PDT)
Subject: Re: Issue 25514 in oss-fuzz: qemu: Coverage build failure
To: Alexander Bulekov <alxndr@bu.edu>
References: <0=0a88cf92d34dc9db91727cc9bd0dc58b=d9ca53ad17e3d19752f355e6c3ba1ecc=oss-fuzz@monorail-prod.appspotmail.com>
 <0000000000003aa8d805afd00f24@google.com>
 <995b1aa7-8efc-57d2-a85e-5520fab0755b@redhat.com>
 <20200921133840.sby75zn7unds2q3a@mozz.bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <437d5c39-0a27-b261-102b-0da64734966a@redhat.com>
Date: Mon, 21 Sep 2020 16:08:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921133840.sby75zn7unds2q3a@mozz.bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/09/20 15:38, Alexander Bulekov wrote:
> Hi Paolo,
> These are the builds with clang coverage enabled.
> The normal fuzzing builds are succeeding now (log from this morning:
> https://oss-fuzz-build-logs.storage.googleapis.com/log-a426424c-cae4-407a-ae7b-205a9ae59286.txt
> )
> 
> I already send a patch that seems to fix the coverage build failure, but
> I can't explain why it does the trick. 
> Message-Id: <20200909220516.614222-1-alxndr@bu.edu>
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg03639.html

The reason for the bug is the -Wl,-lm in QEMU_LDFLAGS.  Putting the
tricky flags first actually makes sense, so I'll queue it.

Paolo


