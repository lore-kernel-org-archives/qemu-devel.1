Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F818C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A6D820855
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Akt6Ke1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6D820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ydN-0008WO-AV
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3ycj-00082g-GR
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:25:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22524
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3ych-0002Ap-Rg
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596792311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G7CshzxG2ntO38XjUfJlHb+H03hqz/6G0Q9m1v4rL6M=;
 b=Akt6Ke1TNBrihHUdhRPl5pwJPrhnbdJ9oGai610ooHr8xjlhgjOc312a5NctckjqTqSMe0
 IG6mkc4JAPuiuLCh5SR+XDnUdV48dYKegr33nYwc3LfjLAmhBtHe8LMtXn/t2HCLhskGsp
 Kh0zdrvQRNrrffVVLYZhwoz3stLUinc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-OpTfcZVxOXW-FaQujw5bng-1; Fri, 07 Aug 2020 05:25:09 -0400
X-MC-Unique: OpTfcZVxOXW-FaQujw5bng-1
Received: by mail-wr1-f72.google.com with SMTP id t12so519465wrp.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 02:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G7CshzxG2ntO38XjUfJlHb+H03hqz/6G0Q9m1v4rL6M=;
 b=FDKmsSk07Nl2zB3m6kPlaCddorGWiZ6a2aZS25L56v0WxyQna+pVhRm858N5NWEXh3
 h8sDyqYdyID34pVRmFTBCrfXKOpjLici/LUheDMW0GTnHW41x2S7L9HBTXQ8gw3kYzVU
 bKUXhXc9rVq3c4ZpjbpT+1jvWKPiqBU1xppZlasAJcR1/IcBLo7j2xEtiOXkP4/fcBrX
 3gh6pboMHyB35qqffkcgj6qe+mp0xpXFaIUpEMM/lNOMwu0Rfe9OkeQ6HqvotI3CkWad
 M+GSHTJDvx0EtEXoLCceVr9Ew7iqeG3JXBZFcM3TGtuN0WTUd/vJKBF3P474bA9fnpim
 0oMA==
X-Gm-Message-State: AOAM533daozGjMth2N6AsyxD0JhBdtX/vuFPJtTpYQfftTFOZ7UfewK/
 7unMaTn7DEd5LIKei060YbWCymlzI6O3A2ucTR7jAa9vtFoFZeDjh6y/jiVv3/ten6WIsLJLkga
 sLdKQ/tgtotTXRi4=
X-Received: by 2002:adf:cf10:: with SMTP id o16mr10427057wrj.380.1596792308189; 
 Fri, 07 Aug 2020 02:25:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzo3B4pIrFvt3KMN7YwGnlMD6Qsuy1LbwAOcLyR4wiDivwEGaw6RsBnErIOBSVlS4b96yqgDw==
X-Received: by 2002:adf:cf10:: with SMTP id o16mr10427032wrj.380.1596792307902; 
 Fri, 07 Aug 2020 02:25:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id r16sm10232830wrr.13.2020.08.07.02.25.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 02:25:07 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <87364y28jp.fsf@dusky.pond.sub.org> <20200807082206.GC120942@redhat.com>
 <CAFEAcA8U=Wxx8Z7E2gcwYEhyV_EiCBX3o+FxdxTa9-bvS7rM-Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <920caf31-0eee-a09e-3433-c20a1390a516@redhat.com>
Date: Fri, 7 Aug 2020 11:25:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8U=Wxx8Z7E2gcwYEhyV_EiCBX3o+FxdxTa9-bvS7rM-Q@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:53:14
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 11:20, Peter Maydell wrote:
>> In terms of testing I'd suggest the minimium bar is likely the GitLab CI
>> and Peter's merge scripts.
> I tried running it through a build test. Fails to build, all hosts:
> 
> make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/alldbg'
> config-host.mak is out-of-date, running configure
> 
> ERROR: Meson not found. Use --meson=/path/to/meson|git|internal
> 
> make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/alldbg'
> make: *** No rule to make target 'config-host.mak', needed by
> 'meson-private/coredata.dat'. Stop.
> 
> 
> Can we make this Just Work ?

Yes, looks like configure is not doing "git submodule update" the right
way.  I'll debug it.

Paolo


