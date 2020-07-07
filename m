Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB23C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C032065F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7G0ehgt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C032065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsiXm-0001f6-Ji
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 04:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsiWz-000175-2i
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:00:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42364
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsiWx-0003qs-6A
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594108842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tbuZgWR5mWUnIin9z9FYTirMQWtvWWTFW/DoFWi+mzk=;
 b=S7G0ehgtxMWxw+pZwYUglu5zi5oHNyHsxzySmdRcv9/B3x9+u7sVtr+UItaTH3/Ko9JkPi
 iKWIRRjE+4crGcdrhvJEI1lsu/HgOSv6i0VUW2EQ+LEBOS867jHl782RzVaxkrdc1MmZU1
 1Qb+YKtA8hi73scYlmlm/iO3rPMnXws=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-rBIbzjaIPkaNTTCJ6HvF7Q-1; Tue, 07 Jul 2020 04:00:38 -0400
X-MC-Unique: rBIbzjaIPkaNTTCJ6HvF7Q-1
Received: by mail-wm1-f71.google.com with SMTP id b13so49778004wme.9
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 01:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tbuZgWR5mWUnIin9z9FYTirMQWtvWWTFW/DoFWi+mzk=;
 b=DE/RZRBSO2uY7dyDUZx66EYfG+dnRLuJ7p5FuKSlqo1vjzlW1QtBvsyz5FIxnPmy+3
 lcZvlOaf/BAI17afFoG1KXCt74lIi0FOZdJMLum1O6VsVaGxxfheOCCla3cV5gxwvQII
 L9Qo2GvPhA6sDIK+TNkPeVGb/siZ9FcoAMwcFnvLgwqnb7Mf3t+f/ku/TfCoqfK7pOqj
 qW8Nsths44PGdlxPqMvqrlauJbm9/M1zO7r5FdJ/3tl5Ci8v5qYevjNByU53yZrbldt5
 wX0A8q/28XGf9rM8FiNQEtiMH2jBXtcfi1rIdBh1cw+ieJhF0qdoiJ6oNWifXJN3UJw7
 Ijkw==
X-Gm-Message-State: AOAM533u+DYK7U8Pl4BZBH5jkvXajvC0vUNCaSLHlznIQK69cg2Fyp3n
 Texz8VWQp6EDvjz+XTOpffvBW6ZFS/Io89iU1jXm5PpfJhdrEfGfU7A5A1YIGfI1zX/vMYJ59x0
 jvz6KZwl8wqiDP+A=
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr2760436wme.46.1594108837351; 
 Tue, 07 Jul 2020 01:00:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLbmlNSBCph0xoRyvXfp5598HMHzSO0GqMI35BG8HRJpG+RXoM/NmTF1l/qqs7M6uPbAXs7Q==
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr2760412wme.46.1594108837090; 
 Tue, 07 Jul 2020 01:00:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e95f:9718:ec18:4c46?
 ([2001:b07:6468:f312:e95f:9718:ec18:4c46])
 by smtp.gmail.com with ESMTPSA id p29sm2306107wmi.43.2020.07.07.01.00.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 01:00:36 -0700 (PDT)
Subject: Re: Slow down with: 'Make "info qom-tree" show children sorted'
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200527084754.7531-1-armbru@redhat.com>
 <20200527084754.7531-3-armbru@redhat.com>
 <49bea110-0a3d-5a40-6647-67b116fb41b5@redhat.com>
 <5e967e5f-8ae5-01cc-0dfe-f22e0f03b6b3@redhat.com>
 <87y2nvanya.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <794f6901-5fe3-f7a1-45e7-f277f687cb6b@redhat.com>
Date: Tue, 7 Jul 2020 10:00:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87y2nvanya.fsf@dusky.pond.sub.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:20:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, ehabkost@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <dgibson@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/07/20 07:33, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 7/7/20 6:45 AM, Thomas Huth wrote:
>>> On 27/05/2020 10.47, Markus Armbruster wrote:
>>>> "info qom-tree" prints children in unstable order.  This is a pain
>>>> when diffing output for different versions to find change.  Print it
>>>> sorted.
>>>>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>  qom/qom-hmp-cmds.c | 24 ++++++++++++++++--------
>>>>  1 file changed, 16 insertions(+), 8 deletions(-)
>>>
>>>  Hi Markus,
>>>
>>> this patch causes a slow down of the qtests which becomes quite massive
>>> when e.g. using the ppc64 and thourough testing. When I'm running
>>>
>>> QTEST_QEMU_BINARY="ppc64-softmmu/qemu-system-ppc64" time \
>>> ./tests/qtest/device-introspect-test -m slow | tail -n 10
>>>
>>> the test runs for ca. 6m40s here before the patch got applied, and for
>>> mor than 20 minutes after the patch got applied!
> 
> That's surprising.

It's a bit surprising indeed, but on the other hand using
g_queue_insert_sorted results in a quadratic loop.  It should probably
be fixed by using g_queue_sort, or switching to g_list_prepend+g_list_sort.

Paolo

>> Argh, yesterday I reviewed again all the range except this patch... not
>> sure why as looking at it now it is obvious.
>>
>>> This causes our gitlab CI to constantly fail since the patch got merged,
>>> since the testing time now exceeds the 1h time limit:
>>>
>>>  https://gitlab.com/qemu-project/qemu/-/pipelines/156767175
>>>
>>> Sure, we can work around that problem in the CI (Alex has already a
>>> patch queued), but still, is there something you could do about this
>>> massive slowdown?
>>
>> Suggestion: add a '-u' option for unsorted mode, to use in qtests.
>>
>> Humans want the new behavior (default: sorted).
> 
> Last resort.  
> 
> I'll look into speeding up the sort first.
> 
> Work-around: drop -m slow until we get this sorted (pardon the pun).
> 


