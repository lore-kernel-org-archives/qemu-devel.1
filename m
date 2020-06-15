Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2726FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D83512078E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2EfpmSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83512078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkpMn-0004Wc-3w
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 09:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jkpM2-00045U-Ve
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 09:40:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52418
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jkpM0-0006bq-GV
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 09:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592228446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/GVvwGULYgll3pU0emIqKeqRhbfYQ8pDcmBoQQB5d/s=;
 b=Q2EfpmSpwYg9MdWLa+iaOsjQZ2BF1OLSvw2t3PoeBDR/JnNrW/oXqlAUz4GFa2WLq8Fh1x
 4c3gqOKZI1g8dZoULh280EVeLM+G1otbhKzPCbpCMfEeIV0AHUP7OEFwU+n8TLcWlslJuF
 vNiJjE4+p/d/J0kUP31EEpd//6Lnwkg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-GGNAo-lCPkGIS9sQeQvZJg-1; Mon, 15 Jun 2020 09:40:44 -0400
X-MC-Unique: GGNAo-lCPkGIS9sQeQvZJg-1
Received: by mail-wr1-f70.google.com with SMTP id n6so7080285wrv.6
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 06:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/GVvwGULYgll3pU0emIqKeqRhbfYQ8pDcmBoQQB5d/s=;
 b=tFNGvERG3dtAzgS6WQgWE1KYXmb8rM8IIXZpsKG4w3WTTCQgrN6wtsL05CUKUcHG1H
 rUa+1Q3kHTD/Bzww4MOtIElg/50SR2kXz46d/8vOc9+gbfpXccg+mWuoFX7B36/h1frW
 qHS9c6iwTq5QZB/mV+/P0NL1haNBvmoIB5e7yy+RDh7iXATCtXd+Kvj4cRWBZlpx6zpa
 1QtJ8Qt4Csgd3KTqaP1FXey/x81/StuPNDloySfS84mZLrWOWUwz+XCoWiEtNU/rWOmA
 dGbRbflSNx1tX/Mnpb6CqlvU16WokFbTFYgJ6ua/Dgk2OJ7Aum9Kansu5MT9wLJYeTSl
 Nkhg==
X-Gm-Message-State: AOAM532GVN9yzLqdjP25T7JeEOcatM8ImtDDcD9bxXMA+Hv1DDFjVCnF
 T2kNU2RD9kLgsOlTma++LBoWa16JX4slxWkdLaFEPewgsJnWmn6pCytMHmi+WBzgFh4KUhGOdZF
 kM3rc6S4T9vIvC4U=
X-Received: by 2002:adf:ef47:: with SMTP id c7mr31098044wrp.57.1592228443411; 
 Mon, 15 Jun 2020 06:40:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9E6LMLo2h5cpP9uGgO/7wQnfaegreeH29w/zLfc6cB3B45geo/n8kyAvD+kgWZdRiAV3EtQ==
X-Received: by 2002:adf:ef47:: with SMTP id c7mr31098025wrp.57.1592228443229; 
 Mon, 15 Jun 2020 06:40:43 -0700 (PDT)
Received: from [192.168.178.58] ([151.48.99.33])
 by smtp.gmail.com with ESMTPSA id r2sm25243341wrg.68.2020.06.15.06.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 06:40:42 -0700 (PDT)
Subject: Re: [PATCH] replay: notify the main loop when there are no
 instructions
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <159013007895.28110.2020104406699709721.stgit@pasha-ThinkPad-X280>
 <c0867841-ae6c-5190-ab43-80b4c8e0fe43@ispras.ru>
 <d0f6ee58-39fd-e8a0-11a4-b7692183dcbb@redhat.com>
 <44b8f06f-aa8f-33ac-175a-f3af5f9e87e5@ispras.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a5f10cf3-e4e9-69e3-c7a6-96ddea9c68b0@redhat.com>
Date: Mon, 15 Jun 2020 15:40:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <44b8f06f-aa8f-33ac-175a-f3af5f9e87e5@ispras.ru>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:43:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: alex.bennee@linaro.org, pavel.dovgaluk@ispras.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/06/20 07:39, Pavel Dovgalyuk wrote:
>>
> 
> Thanks, but this patch and "replay: synchronize on every virtual timer
> callback" were not included.
> 
> Replay tests are succeeded only with these patches.

Added back both.  I'll be faster this time, promised.

Paolo


