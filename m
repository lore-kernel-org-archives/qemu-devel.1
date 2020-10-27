Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63138C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 08:50:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A457E207DE
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 08:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7g3R5YJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A457E207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXKgT-0005yO-HG
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 04:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXKfG-0005Ou-An
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 04:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXKfA-0000HW-Fo
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 04:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603788543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OEf1jTz9Jx7zrA8Xd2B2sUqwz65muqhWCsFNGB1oXVs=;
 b=J7g3R5YJ3nhpAzqHLLKlytN0M7LE1/szEtIDsI23fJqNDdkv1I+OXwrOohbCsL/UWhGQa4
 SftamPzMAVKkWm6gCdoJVSE7lzG7Q1FZB4gIe2BuYAfh3CNYlnTrFgPHBo5djuqrmeL0gU
 aF/7rj1xeke5YwArK8c4poN/2eei3P0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-FMW88_ILObirob-f668yUA-1; Tue, 27 Oct 2020 04:49:02 -0400
X-MC-Unique: FMW88_ILObirob-f668yUA-1
Received: by mail-ed1-f72.google.com with SMTP id m1so393227edr.8
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 01:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OEf1jTz9Jx7zrA8Xd2B2sUqwz65muqhWCsFNGB1oXVs=;
 b=qgE9SPmaGFUoSMeEKAEtzUaQtkEodDgfhtHem1QwlU8f2vK02k0e4kQ5LM6HAIu4fg
 TlkDP+xz6IOiYxvq0zO3nw9e1k/mBF/RJ8aX4QtjxZKjFjkB28WXiPbSSkRVmtx0fOlR
 WBSnK2wHGLVhsfROOgUqxLgeHUjEW6xLIM8TqVSwF8oVH0+9g0Ov3KxzxuhssgVM6lER
 DaJtZtrYbjvBJIoF0lqdTVopMO5nXx4oe5ZImnoNkvbK/ZLKziYEs8NEjOsPZO3U96aI
 XbGzRUTk80YDTuTiLLXg4Cv3Q3I/eHq0D0esCUmgUYsmlv3HC2AL9DzMdGDeHXIvRc1S
 Dtpg==
X-Gm-Message-State: AOAM531Vwe4xkhSwY8e9U/UsW9cj6+mPBx+tyiHz2kQinJSxC+IHovwo
 jDXy9nLfBWew+vy/7LzDfvPljTu9/GTh/LSU+2uBlpUy2U8C6NP/7mYEXX7BJ4evXSExMeebiE2
 UmQbC3InQ/C1UrpM=
X-Received: by 2002:a05:6402:156:: with SMTP id
 s22mr1120093edu.178.1603788540602; 
 Tue, 27 Oct 2020 01:49:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg+Xe20+yX13tV/WX25Fj4xy4x1muIWiIA3s6Yc12c9/J861PUfjZJ1acwM3uVTDMbtiuh8w==
X-Received: by 2002:a05:6402:156:: with SMTP id
 s22mr1120074edu.178.1603788540328; 
 Tue, 27 Oct 2020 01:49:00 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id v1sm490423eds.47.2020.10.27.01.48.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 01:48:59 -0700 (PDT)
Subject: Re: [PATCH 4/4] spapr: Improve spapr_reallocate_hpt() error reporting
To: Greg Kurz <groug@kaod.org>
References: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
 <160371605460.305923.5890143959901241157.stgit@bahia.lan>
 <b67330f6-797c-f088-b6fa-7e81075e2245@redhat.com>
 <20201026154722.3b573be7@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8c4f6d8a-46d7-f600-11ac-c11014db7769@redhat.com>
Date: Tue, 27 Oct 2020 09:48:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026154722.3b573be7@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 3:47 PM, Greg Kurz wrote:
> On Mon, 26 Oct 2020 14:49:34 +0100
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
>> On 10/26/20 1:40 PM, Greg Kurz wrote:
>>> spapr_reallocate_hpt() has three users, two of which pass &error_fatal
>>> and the third one, htab_load(), passes &local_err, uses it to detect
>>> failures and simply propagates -EINVAL up to vmstate_load(), which will
>>> cause QEMU to exit. It is thus confusing that spapr_reallocate_hpt()
>>> doesn't return right away when an error is detected in some cases. Also,
>>> the comment suggesting that the caller is welcome to try to carry on
>>> seems like a remnant in this respect.
>>>
>>> This can be improved:
>>> - change spapr_reallocate_hpt() to always report a negative errno on
>>>    failure, either as reported by KVM or -ENOSPC if the HPT is smaller
>>>    than what was asked,
>>> - use that to detect failures in htab_load() which is preferred over
>>>    checking &local_err,
>>> - propagate this negative errno to vmstate_load() because it is more
>>>    accurate than propagating -EINVAL for all possible errors.
>>>
>>> Signed-off-by: Greg Kurz <groug@kaod.org>
...

>>>       if (rc < 0) {
>>> @@ -1504,8 +1503,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
>>>           error_setg_errno(errp, errno, "Failed to allocate KVM HPT of order %d",
>>>                            shift);
>>>           error_append_hint(errp, "Try smaller maxmem?\n");
>>> -        /* This is almost certainly fatal, but if the caller really
>>> -         * wants to carry on with shift == 0, it's welcome to try */
>>> +        return -errno;
>>
>> Maybe returning here should be in a previous patch.
>> Otherwise patch looks good.
>>
> 
> It could have been indeed...
> 
>>>       } else if (rc > 0) {
>>>           /* kernel-side HPT allocated */
>>>           if (rc != shift) {
>>> @@ -1513,6 +1511,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
>>>                          "Requested order %d HPT, but kernel allocated order %ld",
>>>                          shift, rc);
>>>               error_append_hint(errp, "Try smaller maxmem?\n");
>>> +            return -ENOSPC;
> 
> ... along with this one.
> 
> I didn't go this way because it doesn't really affect the final behavior since
> QEMU exits in all cases. It's mostly about propagating an appropriate errno up
> to VMState in the case of htab_load(). But if you find it clearer and I need
> to post a v2, I can certainly do that.

As a reviewer I prefer dumb obvious patches I can quickly understand.
If I stop, spend too long, am not sure, I spend time to ask, and usually
stop reviewing the series. Then you spend time to answer, eventually
respin. In doubt, KISS.

Patch is queued so no need for v2.


