Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207F5C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2E220786
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cM5jDukN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2E220786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGhav-0005c3-24
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 07:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jGhZt-00042G-N7
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jGhZs-0007jX-Ii
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:18:37 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35087)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jGhZs-0007j5-C4
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:18:36 -0400
Received: by mail-wm1-x343.google.com with SMTP id m3so3011123wmi.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 04:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=o5s5EIyLrX037d55YoY+iX0/oTthgCsh557JjKQoBqs=;
 b=cM5jDukNBqWIpVYXQ2xqvhWaUH/ZajJk58gqLxvgrjjTZyr6V/IP4JKwGi0cYmSJWS
 SuAPEokgr/9xm1m5VpbLYpsHdt08rjvhpxXKUdhe8uReWelNa1yGpdi+2LJ7Clqa3Bu1
 jzBNisEGPclzyNrFooGNDlM0PV2A18E0I6c1z21mERvosI4lLqWpZZFCAQpO6uJsN7RX
 MTzyX6lgz8uHcw5MIieTGItVWO9H8W8UxkqLNKsh6JyUY5QwbPN/uF0Xni6ic88hd3X3
 UEz42/8VKgMiQS+QqHrQ1etrqotFMxlgP49lD3LS2RtZZCijQXbOrm+Rg3dzStTbfqLH
 PTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=o5s5EIyLrX037d55YoY+iX0/oTthgCsh557JjKQoBqs=;
 b=K+pwp3g9Dp8VzY9XDyfShZyENFN5qFfzZGl7H3p32Esta/SEvUg7nHdlRTeIxm5lNR
 K8oKPWpmvUrx/ht0ve7/7MHg4CYOuNxOINTAUSBwRbJEgN2jHlkusfZgk8klbwInSOCA
 WoJbt6T0AIPVlK10en61yeMxEa3huG9lKAECGbB+PFzUSHgBAthXfP0RibcNNym8ex3L
 WNtnrdlagD1Pnzds7YPadX2orIDmeQMs/9qte7OVgb/xfo2epw0seopa394YRcExoM35
 as4eqChz98emDjwXBRg5P3RN4csseN1ynCWCR27Hd/aBTDvnHWUv9p6QQLKQNPb3mLQG
 /rrg==
X-Gm-Message-State: ANhLgQ2LLMYBq5fmrdaLdbv5Soj6zWQBouE6vuD4C17XNHD4jmQ/zkNi
 DtclK1tsUiZow7wpbCHmA8acnCAk
X-Google-Smtp-Source: ADFU+vtBpSnESMjJZbtdyAD8b1cQnNaoimc9U/qqCEGU0Tz88b7hpQf9ZSY58m8Yu8Th5qlCEvL8Fw==
X-Received: by 2002:a1c:51:: with SMTP id 78mr4850841wma.157.1585048714218;
 Tue, 24 Mar 2020 04:18:34 -0700 (PDT)
Received: from [192.168.86.37] ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id y200sm3987176wmc.20.2020.03.24.04.18.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 04:18:33 -0700 (PDT)
Subject: Re: [PATCH] hw/rdma: Lock before destroy
To: Peter Maydell <peter.maydell@linaro.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>
References: <20200324105356.7998-1-yuval.shaia.ml@gmail.com>
 <CAFEAcA_D3ykX2mJwtJhvdQg3psCX9NdcG0xq4qmP3CkqHtnY8Q@mail.gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <72691a5a-8992-ec54-f2de-6209cafcc426@gmail.com>
Date: Tue, 24 Mar 2020 13:20:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_D3ykX2mJwtJhvdQg3psCX9NdcG0xq4qmP3CkqHtnY8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,Yuval

On 3/24/20 1:05 PM, Peter Maydell wrote:
> On Tue, 24 Mar 2020 at 10:54, Yuval Shaia <yuval.shaia.ml@gmail.com> wrote:
>> To protect from the case that users of the protected_qlist are still
>> using the qlist let's lock before detsroying it.
>>
>> Reported-by: Coverity (CID 1421951)
>> Signed-off-by: Yuval Shaia <yuval.shaia.ml@gmail.com>
>> ---
>>   hw/rdma/rdma_utils.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/rdma/rdma_utils.c b/hw/rdma/rdma_utils.c
>> index 73f279104c..55779cbef6 100644
>> --- a/hw/rdma/rdma_utils.c
>> +++ b/hw/rdma/rdma_utils.c
>> @@ -63,6 +63,7 @@ void rdma_protected_qlist_init(RdmaProtectedQList *list)
>>   void rdma_protected_qlist_destroy(RdmaProtectedQList *list)
>>   {
>>       if (list->list) {
>> +        qemu_mutex_lock(&list->lock);
>>           qlist_destroy_obj(QOBJECT(list->list));
>>           qemu_mutex_destroy(&list->lock);
>>           list->list = NULL;
> Looking at the code a bit more closely, I don't think that taking
> the lock here helps. If there really could be another thread
> that might be calling eg rdma_protected_qlist_append_int64()
> at the same time that we're calling rdma_protected_qlist_destroy()
> then it's just as likely that the code calling destroy could
> finish just before the append starts: in that case the append
> will crash because the list has been freed and the mutex destroyed.
>
> So I think we require that the user of a protected-qlist
> ensures that there are no more users of it before it is
> destroyed (which is fairly normal semantics), and the code
> as it stands is correct (ie coverity false-positive).

I agree is a false positive for our case.
"rdma_protected_qlist_destroy" is called by "mad_fini" which in turn is 
called by "rdma_backend_fini"
*after* the VM shutdown, at this point there is no active lock user.

Thanks,
Marcel

> thanks
> -- PMM


