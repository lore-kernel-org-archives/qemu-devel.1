Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C17C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F6F822284
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGptKg6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6F822284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQrQt-0004vy-1r
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 08:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQrJB-0006At-DJ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQrJ6-0007aG-G6
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602245731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r7E5y+i6aSdPV9Ebl9Tj1JPur9fHE6wx00dwnNvBozY=;
 b=XGptKg6Av2H0wAXC0rv3dbyt2wbz+J5lmIGOaQhCBzsjCPr/1g+vc0I+VPSkvRX5/Te9L3
 uFhuD+YfuzeKJZI5cupWp993NkDxWJ4vJpHkA6Xb0Zq2sL4FoYsFpGs1CystWfJ35nDDCn
 UmL3PJldn05jDmkpdegNlFVu9AVVGuE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-jPURbRmsMoSZF5zCxgPoLQ-1; Fri, 09 Oct 2020 08:15:30 -0400
X-MC-Unique: jPURbRmsMoSZF5zCxgPoLQ-1
Received: by mail-wm1-f69.google.com with SMTP id v14so4150600wmj.6
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 05:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r7E5y+i6aSdPV9Ebl9Tj1JPur9fHE6wx00dwnNvBozY=;
 b=UmakH2d20VVDfg7ZoiltboRyU16hyLJB/16ivtuU+ppWHbxmwy68ErbxMFFhKyoWPQ
 MXDaKOsxRH9ZXZYvemFRe9ueW6mZNGQaZkzZpUpxK0bgVKFIE1XV3l+Uoqz2/LZbjJjJ
 9fivSe6mkvC+WU3pOuXvkM6HlKU1KAbZ9BEVEokXowNdVO5v2NWLiQodqnXIY0SZE4dh
 5emACtxIGAoWPwG6b7EmE/ntzCkrTiYBuUx56CAIGg8in91/BGYPglWURB3/QZnsBA22
 B4Nq9CoDmR4quYfLytVWgScbULct15n9gRwX1qm8OwjlaVJXZjATRFVDhZSPbfQPwZsZ
 j24w==
X-Gm-Message-State: AOAM533f0N5HRhe7tFgu78FyiYGQewkWHRMi1Ok5YLJbzWfzSA+eYrHI
 00RtNAWeyfqBBQ5+S2Aneg4UhT5tuF8jlQYPY9uIJCHpWf/Mmdyf+jxnwG2x1ubwG/TIm5Y6Y9Q
 eHzqe0LthMCSi4qI=
X-Received: by 2002:a1c:1bd8:: with SMTP id
 b207mr14148199wmb.139.1602245728888; 
 Fri, 09 Oct 2020 05:15:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxitIz7TzDQOfOJdtgXmNHvN1zBVpVJRe2axPbpoBz2FMUdt9KU/Lj597lxIhM4kVuJ1LpYMw==
X-Received: by 2002:a1c:1bd8:: with SMTP id
 b207mr14148166wmb.139.1602245728533; 
 Fri, 09 Oct 2020 05:15:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cee1:4797:6958:7698?
 ([2001:b07:6468:f312:cee1:4797:6958:7698])
 by smtp.gmail.com with ESMTPSA id w7sm11344704wmc.43.2020.10.09.05.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 05:15:27 -0700 (PDT)
Subject: Re: [PATCH v8 07/17] qemu-iotests, qtest: rewrite test 067 as a qtest
To: Kevin Wolf <kwolf@redhat.com>
References: <20201007115700.707938-1-pbonzini@redhat.com>
 <20201007115700.707938-8-pbonzini@redhat.com>
 <20201009094846.GB5109@linux.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <143f7eee-b77a-65a5-d215-a3b0bdbe4026@redhat.com>
Date: Fri, 9 Oct 2020 14:15:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201009094846.GB5109@linux.fritz.box>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/20 11:48, Kevin Wolf wrote:
> Am 07.10.2020 um 13:56 hat Paolo Bonzini geschrieben:
>> Test 067 from qemu-iotests is executing QMP commands to hotplug
>> and hot-unplug disks, devices and blockdevs.  Because the power
>> of the text-based test harness is limited, it is actually limiting
>> the checks that it does, for example by skipping DEVICE_DELETED
>> events.
>>
>> tests/qtest already has a similar test, drive_del-test.c.
>> We can merge them, and even reuse some of the existing code in
>> drive_del-test.c, and improve the quality of the test by
>> covering DEVICE_DELETED events.  The only difference is that
>> the new test will always use null-co:// for the medium
>> rather than qcow2 or raw, but this should be irrelevant
>> for what the test is covering.  For example there are
>> no "qemu-img check" runs in 067 that would check that
>> the file is properly closed.
>>
>> The new tests requires PCI hot-plug support, so drive_del-test
>> is moved from qemu-system-ppc to qemu-system-ppc64.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> As discussed on IRC, I'm not a big fan of moving QMP tests that don't
> make use of the qtest protocol at all to C unit tests (nothing in
> drive_del_test makes use of the qtest protocol, neither before nor after
> this patch). It's generally harder to write this kind of tests in C than
> in Python, and assertion based tests are harder to debug than reference
> output based ones.
> 
> There is one argument why this should be a qtest, which is that qtests
> are run for multitple guest architectures while iotests run only for the
> first architecture we found. I'm not sure if it's a good argument, but I
> can't completely dismiss it.
> 
> The commit message should mention this argument, though.

Agreed.

> In the future, I think iotests should be extended to provide the
> necessary infrastructure to run tests on several architectures, and then
> this should be converted to a Python iotest.
> 
>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>> index 9e4f7c0153..0d31fda111 100644
>> --- a/tests/qemu-iotests/group
>> +++ b/tests/qemu-iotests/group
>> @@ -88,7 +88,6 @@
>>  064 rw quick
>>  065 rw quick
>>  066 rw auto quick
>> -067 rw quick
>>  068 rw quick
>>  069 rw auto quick
>>  070 rw quick
> 
> Please keep a comment that 067 shouldn't be reused, like we do for some
> other cases. (It only causes merge conflicts for downstreams.)

Ok, I will.

>> +static void test_empty_device_del(void)
>> +{
>> +    QTestState *qts;
>> +
>> +    /* device_del with no drive plugged.  */
>> +    qts = qtest_initf("-device virtio-scsi-%s -device scsi-cd,id=dev0",
>> +                      qvirtio_get_dev_type());
>> +
>> +    device_del(qts, false);
>> +    qtest_quit(qts);
>> +}
> 
> 067 tested reset and query-block after this. Is the removal intentional?

query-block doesn't really test anything here because there's no drive
at all.  Reset also doesn't do much that is interesting for scsi-cd but
I can add it back.

Paolo

> Other than these, the conversion looks correct. I'm not convinced that
> doing it is a step in the right direction, but with these two things
> fixed, you can add:
> 
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> 


