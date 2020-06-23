Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B883C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 01:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2378F2075A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 01:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="NlTnRwmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2378F2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnY9c-0003wa-Dc
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 21:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jnY8t-0003WM-Om
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 21:54:31 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:35646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jnY8s-0003pq-5T
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 21:54:31 -0400
Received: by mail-qt1-x841.google.com with SMTP id z1so14277982qtn.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 18:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=i0XCfPltp5PdCxbQeJbO6Ugx3Ph8wB7BucsPgoPeYqg=;
 b=NlTnRwmmUEvJDcbefOns7i/zVy4WeChkMwrzb6SjYHLOUl2fSO4uDKdWNTglTDUi2w
 LuWHZPyK5tqNPArHdTd5zRdx38kr8ZHqtVX73w9KmaCWhDLj7wSqd1fpgVwS4AiQswqe
 84bFX9GFljEUGnz9251VRgFj/zJcYxHLd0rFf8hRNrof85fArnzr4yG6reM5BVBEPv6d
 8M45u7shCObc7f4DwFSxuS0DSFXB6fNbwcbTZW3QZ6HRVvJo0lb9T1afX3K4vsHbWX91
 T9tt3FspvZMZ308gfxnFIy/8nJTaJqBfD/U0RmKlELrj//iq6slKVk8Np8jWHqgkkfEZ
 Rqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=i0XCfPltp5PdCxbQeJbO6Ugx3Ph8wB7BucsPgoPeYqg=;
 b=dBkiQacniYBIjG/oPIXOudKrRGalKZTtqOQbeZPSC4AUhWnBkYM7O1u9RAOtwxf+Va
 rTYw0N3C7fZi+0WyI19t+m2++BJ3fUHVjzWCfw7mukUqHHnQ0BuF1LMqhcguZ8peeXJn
 j4kXxVDX0rp4D2++Fp1dZvPfGkzVPEJrwV3HKNAZUVzsGk8H6f7GoAclhKp0QzEPf3tP
 A1TJV3+5nLe/UIdc5+ZELlItkzBCGmoeprSj7PmR9/IWE44J8isM4/8nci9RZJaojxE3
 1QuIzm5eF4ge9y1dgJjqEfRaoaAwslEQh72pqdW4yfHn+GH5aXMMvqdPTbXyu86C+Ap/
 Qf9A==
X-Gm-Message-State: AOAM532iZ6ema/r+J1JsxkWIdfDMdf9ugryO+QgWovcsrxjDR6u4e+Ws
 SSBGGUMRL3IZ3xy1X3EGXv7Wwg==
X-Google-Smtp-Source: ABdhPJx02ioMgN10caWDQCcgkO7GLFxDp6/JaODUdlpsqWWos/lvi4CQB2Yp39KwQLhoBzg4HuUF/A==
X-Received: by 2002:ac8:a45:: with SMTP id f5mr20231382qti.116.1592877268301; 
 Mon, 22 Jun 2020 18:54:28 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id b185sm15177444qkg.86.2020.06.22.18.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 18:54:27 -0700 (PDT)
Date: Mon, 22 Jun 2020 21:54:26 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 3/6] cputlb: ensure we save the IOTLB data in case of
 reset
Message-ID: <20200623015426.GA280811@sff>
References: <20200610155509.12850-1-alex.bennee@linaro.org>
 <20200610155509.12850-4-alex.bennee@linaro.org>
 <20200621203307.GA168836@sff> <87imfja2x1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87imfja2x1.fsf@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::841;
 envelope-from=cota@braap.org; helo=mail-qt1-x841.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, Paolo Bonzini <pbonzini@redhat.com>,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 10:02:50 +0100, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
> > On Wed, Jun 10, 2020 at 16:55:06 +0100, Alex Bennée wrote:
(snip)
> >> +#ifdef CONFIG_PLUGIN
> >> +
> >> +typedef struct SavedIOTLB {
> >> +    struct rcu_head rcu;
> >> +    struct SavedIOTLB **save_loc;
> >> +    MemoryRegionSection *section;
> >> +    hwaddr mr_offset;
> >> +} SavedIOTLB;
> >> +
> >> +static void clean_saved_entry(SavedIOTLB *s)
> >> +{
> >> +    atomic_rcu_set(s->save_loc, NULL);
> >
> > This will race with the CPU thread that sets saved_for_plugin in
> > save_iotlb_data().
> 
> Surely that only happens outside the critical section?

I am not sure which critical section you're referring to.

With call_rcu() we defer the execution of the function to the RCU
thread at a later time, where "later time" is defined as any time
after the pre-existing RCU read critical sections have elapsed.

So we could have the RCU thread clearing the variable while the
CPU thread, which is in a _later_ RCU read critical section, is
setting said variable. This is the race I was referring to.

Thanks,
	
		Emilio

