Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562C2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1777D20866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VY7BCx3m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1777D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zyZ-0004L8-9t
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3zwq-0003AO-SL
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:50:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44741
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3zwn-0003si-ME
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596797399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uML6es9KcRXevCyPXAPgO8hcudoJqGQK+/SmWxH09MA=;
 b=VY7BCx3mGzITmKZ3fMT1ib1V1JggI4zVys3GwZChOesGJZkJSDiKoEmVM2jkDfrASK3h9M
 UsfCyohO6l0MCiH8ZCLT6eWjluMytmPSJLiFFzIbfQwVQ34zBgP0aTX/XrMIM03p/okrM7
 +rJY6jAjBouHm76lHsC4rjATXa25L54=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-Xf2WOTkrO1yOkvKLCynlcg-1; Fri, 07 Aug 2020 06:49:58 -0400
X-MC-Unique: Xf2WOTkrO1yOkvKLCynlcg-1
Received: by mail-wm1-f72.google.com with SMTP id h7so629659wmm.7
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 03:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uML6es9KcRXevCyPXAPgO8hcudoJqGQK+/SmWxH09MA=;
 b=J8Rgai37jzFdPP7HHcN/z6FY5WUY1KG1kj52SgqoDUrsWIkkT+DJrkDSQp25cvNvfe
 q5g115HqGATwKKOpBR3POXfkKMkLWpEmAJTrw2kkqC+QHaHoTn7fF5oCFs8D2q3/xhje
 qgaKmEsLXTrgQj9iT+cu0x35f2irk0Gm+h2erx4HJK+n7fiuZ/+sjStvNtrdSSrIzO84
 PEtu0VgkkXYNvQEeVtcEISuo/sI0x/kLUhwh52jhXfJPRIYHTcU2k0H5vCcGCbaPnKef
 DCL2m0Msz+POccSknaqHWU2h5xH+fS4Y5JQQKO35NpprgZ7Nn60vmS91uk5iBN5fg+Nq
 svtQ==
X-Gm-Message-State: AOAM5304SI7dctR1d7JvNv7s1SW9bnlOqu3Lml/D/D7Q7FWZjeqnrAw2
 KxaTd/pvcArFy+4Ym+w31W9LlUJOJRPEQMz6xZRWXf9vT7gyS7hIuwKnckfyrCramYFr+HFZyg0
 tBWtZJlgalcrBdig=
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr11980887wmj.5.1596797396816;
 Fri, 07 Aug 2020 03:49:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPFAf04iydLfHs4Ja5lmSGfZHhaqbnaqQ+5+TILly5yuAnkg7wOOhLcJXs7JjqJ/75tYXIFA==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr11980866wmj.5.1596797396566;
 Fri, 07 Aug 2020 03:49:56 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.136.3])
 by smtp.gmail.com with ESMTPSA id b137sm10736450wmb.9.2020.08.07.03.49.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 03:49:56 -0700 (PDT)
Subject: Re: [PATCH 020/143] meson: add testsuite Makefile generator
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-21-git-send-email-pbonzini@redhat.com>
 <87sgcyk9zv.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <543f3674-b984-680e-4e85-0f507f6571ba@redhat.com>
Date: Fri, 7 Aug 2020 12:49:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87sgcyk9zv.fsf@linaro.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 12:48, Alex Bennée wrote:
>> Rules to execute tests are generated by a simple Python program
>> that integrates into the existing "make check" mechanism.  This
>> provides familiarity for developers, and also allows piecewise
>> conversion of the testsuite Makefiles to meson.
> Hmm not sure why check-tcg has broken then:
> 
>   11:44:37 [alex.bennee@hackbox2:~/l/q/b/all] review/meson-for-5.2|✔ + make check-tcg
>   make[1]: Entering directory '/home/alex.bennee/lsrc/qemu.git/slirp'
>   make[1]: Nothing to be done for 'all'.
>   make[1]: Leaving directory '/home/alex.bennee/lsrc/qemu.git/slirp'
>   make: *** No rule to make target 'run-tcg-tests-aarch64-softmmu', needed by 'check-tcg'.  Stop.
> 
> 

Probably unrelated unless you bisected it to this patch.  I'll check.

Paolo


