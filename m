Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FAEC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:07:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FE720782
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3eR7UzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FE720782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYCKY-0002JM-Sc
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 14:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYCJi-0001hG-B9
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:06:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48154)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYCJg-0001tQ-Km
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603994787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9LJrr3M7VAGBUcrTXSCeZnIvU4lQPGh4U6f7W0NUluo=;
 b=O3eR7UzYt409ns8DdZK8vYBuIvMXr99Jbm8Nb9zfTVLc9m/rlAOXsBtGuxAWw6yMZRLNUN
 j0cdXZEcAg998jrOame2/z6Jn1CQRglkHu9lCQiTkM6VO4G5fSBFc+JYR4n5uc1JaxmMqB
 dkQGCrdZJUXzuRnVcZpsCJjBoyRKY8A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-ytj1B8p_Oj6S4S6abLQ9xw-1; Thu, 29 Oct 2020 14:06:26 -0400
X-MC-Unique: ytj1B8p_Oj6S4S6abLQ9xw-1
Received: by mail-wr1-f71.google.com with SMTP id m4so1585001wrq.23
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 11:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9LJrr3M7VAGBUcrTXSCeZnIvU4lQPGh4U6f7W0NUluo=;
 b=Vn66UBlUnBkHoqgRwymSPB6NZbdtEQLxI2B31PAALjNhlysySMHqBncIJeF7QGDztj
 LusLilde2Rkm41RLRze0067JH1IVKyGH0ihj0FLYCN6z0fkp3xJz/nZFYU6Q3j97Olt0
 qlA+4uuEd2K7tKFZdfsBTrRaeK61uGPI1eukyurqFfEkZh8AFsAW4dPMbs+u5yRdebk6
 tTh3/BujID9MoiHCo0OrrLjKMrRaiuZ/PcCX8fZ748l6FQDI3Cv32BpRqzEudGuhsKT2
 a2y5SxiNKuA3uziD6PscIT//IjKFTWnLb/tGPj7N5IR6shkkMfyVGIIfys2HkiQGJGJf
 4g0Q==
X-Gm-Message-State: AOAM533xIq6VKIP+TpjkH9PmixiwFMkbKLpFexe0Pp1DU0QC7io2NeuC
 2kBQvCNAQNZAuvTCrO2FUem7UJvXsd70ygqDK08eMpORRVzdjx2pe3fzhY5iu2RCoSFlIKd/KgH
 qQMtjfollIovZx20=
X-Received: by 2002:a1c:7dc5:: with SMTP id y188mr363017wmc.37.1603994781777; 
 Thu, 29 Oct 2020 11:06:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwG1tUL53cznBT25V6Hci1HBpo72G1+ER6iXQFPyNoGQPMu21hPCd0R3IN/u6p8HOJRRPKxXA==
X-Received: by 2002:a1c:7dc5:: with SMTP id y188mr362996wmc.37.1603994781587; 
 Thu, 29 Oct 2020 11:06:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id t5sm7351363wrb.21.2020.10.29.11.06.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 11:06:20 -0700 (PDT)
Subject: Re: [PATCH 00/11] sockets: Attempt to drain the abstract socket swamp
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201029133833.3450220-1-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <07eb80c1-6d56-2bd4-c8be-90a34167ae91@redhat.com>
Date: Thu, 29 Oct 2020 19:06:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029133833.3450220-1-armbru@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: kwolf@redhat.com, berrange@redhat.com, zxq_yx_007@163.com,
 kraxel@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/10/20 14:38, Markus Armbruster wrote:
> In my opinion, the Linux-specific abstract UNIX domain socket feature
> introduced in 5.1 should have been rejected.  The feature is niche,
> the interface clumsy, the implementation buggy and incomplete, and the
> test coverage insufficient.  Review fail.
> 
> Fixing the parts we can still fix now is regrettably expensive.  If I
> had the power to decide, I'd unceremoniously revert the feature,
> compatibility to 5.1 be damned.  But I don't, so here we go.
> 
> I'm not sure this set of fixes is complete.  However, I already spent
> too much time on this, so out it goes.  Lightly tested.
> 
> Regardless, I *will* make time for ripping the feature out if we
> decide to do that.  Quick & easy way to avoid reviewing this series
> *hint* *hint*.

Apart from the nits pointed out in patch 7 (commit message) and 8 (code),

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks, and don't forget to fix the hole that your head has left in the
wall.

Paolo


