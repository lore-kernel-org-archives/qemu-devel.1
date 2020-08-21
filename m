Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EC0C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6748C207BB
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjGP1HRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6748C207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k96sF-0003UB-Ib
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 09:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k96rZ-0002ZV-Lt
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:13:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59219
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k96rW-0006K8-QH
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598015621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6W1h2NkKYVv4bXWHO+6htrj5E0MHReHK5bMHaYLlR2M=;
 b=DjGP1HRq+Gq+uqCQgMQdL8jJiDYSJF6jiHnuRIoLhxyLwexji2TR0IzHV2xKFSOcFCyfax
 amP3I6Uhl5rOigpacfJ4G/Dk9mQ9jo8s7ha/4/ZSfd15mLifFCpvuD5S6ogBENwZlyxjQP
 9nvc63Hr9hJFBAMb2GeY+Cj6WSd0X3M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-sADImiSRMT-UWdo4hOcolQ-1; Fri, 21 Aug 2020 09:13:38 -0400
X-MC-Unique: sADImiSRMT-UWdo4hOcolQ-1
Received: by mail-wr1-f71.google.com with SMTP id w1so546448wro.4
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 06:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6W1h2NkKYVv4bXWHO+6htrj5E0MHReHK5bMHaYLlR2M=;
 b=mYKZiUIBAYK397hfQuwwiUwAzTsTrVqIhYIaXM1tAP76qxCWkl41AKkb0gpD0wYmfy
 vrm17eff1EB2XRxRbwgPHkmpnnjt3T2vT2JM/fGb0sI5KSO+doWc7LCsBeLR5dvqGPbF
 XN9GMpVsBpocEPG2zayAu43KM1BfgmKsqI1fSOTIhiYoZthoQRqvzurVzEcDpTgCbaHI
 K3AwGcgzzE63G59Cq9feWo5MH3nMNhhp6By8Inmlzhx40HkE6kT8VdrHLDb8FuViB+uE
 jwgIuvP/859uz+SvCgwPi3bKuOROgUnCB0fp6KLVmMuCv09fqfY3nZQvNccDniJer5+I
 WnWQ==
X-Gm-Message-State: AOAM532tGRgu/awIBlzGb+iBFXvpB/7RxDiOpcowv+AFvl07NQKBqI+a
 2bNkme0lHZjrqEZYw3pU50AMqhhA/nxCJwtQix2krvL+igR557swjZlFMiB66lmHIjv/BcFi3Nh
 mjDoAMUdsQH+H/B8=
X-Received: by 2002:adf:f045:: with SMTP id t5mr2843821wro.288.1598015617174; 
 Fri, 21 Aug 2020 06:13:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSkopHGbAdrpaE9HbCx1jyBACxG+MmpNVR+I3ldRHHtVMQNmhBa58NmXgp59Zth1LwcqbyCw==
X-Received: by 2002:adf:f045:: with SMTP id t5mr2843802wro.288.1598015616922; 
 Fri, 21 Aug 2020 06:13:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id p6sm4945804wmg.0.2020.08.21.06.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 06:13:36 -0700 (PDT)
Subject: Re: [PATCH v5 1/1] audio/jack: fix use after free segfault
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <20200819062940.52774-1-geoff@hostfission.com>
 <3140676.b1PlGooJ8z@silver> <c84d95de-c71d-3272-6b41-95753634482a@redhat.com>
 <2337495.aVM56tU1U7@silver>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <592c10e0-8800-a847-89cc-b877ddf286c8@redhat.com>
Date: Fri, 21 Aug 2020 15:13:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2337495.aVM56tU1U7@silver>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Geoffrey McRae <geoff@hostfission.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/08/20 14:00, Christian Schoenebeck wrote:
> One way would be a recursive type and logging a warning, which you obviously 
> don't like; another option would be an assertion fault instead to make 
> developers immediately aware about the double lock on early testing. Because 
> on a large scale project like this, it is almost impossible for all developers 
> to be aware about all implied locks. Don't you think so?
> 
> At least IMO the worst case would be a double unlock on a non-recursive main 
> thread mutex and running silently into undefined behaviour.

Yes, more assertions are always fine.

We were using errorcheck mutexes until a few years ago, unfortunately we
couldn't because they are broken with respect to fork (commit 24fa90499,
"qemu-thread: do not use PTHREAD_MUTEX_ERRORCHECK", 2015-03-05).

> That main thread lock came up here because I noticed this API comment on 
> qemu_bh_cancel():
> 
>   "While cancellation itself is also wait-free and thread-safe, it can of         
>    course race with the loop that executes bottom halves unless you are 
>    holding the iothread mutex.  This makes it mostly useless if you are not 
>    holding the mutex."
> 
> So this lock was not about driver internal data protection, but rather about 
> dealing with the BH API correctly.

Yes, on the other hand that is not a problem if the BH is idempotent.
For example something like this is okay:

bh_body_locked()
{
	free(foo);
	foo = NULL;
}

bh_body()
{
	qemu_mutex_lock(&foo_lock);
	bh_body_locked();
	qemu_mutex_unlock(&foo_lock);
}

...

	qemu_mutex_lock(&foo_lock);
	qemu_bh_delete(foo_bh);		// also calls qemu_bh_cancel
	bh_body_locked();
	qemu_mutex_unlock(&foo_lock);

Paolo


