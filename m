Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2252C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 18:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2ADF2225F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 18:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jrx71iKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2ADF2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUZY8-00067v-Sl
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 14:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUZWU-0005GI-OG
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 14:04:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUZWQ-0001MN-3z
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 14:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603130675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKnQbZFlvdnKhuSCBVR9TrhnENL2ib7MhXy+jCDg1O0=;
 b=Jrx71iKo25puv+WwTjRrlCBWoF2Ng1vpGZ/kV1P0IyIyqwBRTUPGidkCLR95/iFIktYQNs
 J5oLd6cPRfg+ZrXoE0Deg5shOwUgfOn3m2CsCIqYKp707oYlaxq05k4wASyw/Qop3kfke0
 IgbXIYRWkPZoCJ2pp1rQfRdxGXBvFN8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-oz3a_HRcPiacY6eiaC5erQ-1; Mon, 19 Oct 2020 14:04:33 -0400
X-MC-Unique: oz3a_HRcPiacY6eiaC5erQ-1
Received: by mail-wm1-f71.google.com with SMTP id o15so110809wmh.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 11:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hKnQbZFlvdnKhuSCBVR9TrhnENL2ib7MhXy+jCDg1O0=;
 b=LA1XPVdrv+HN1XuFdtvlGLXRSGCylJKSEJ6L9og2NafpXNCY1CaS30aQJ+mW54KI4e
 N7tijKuy2/8r8Fn3iaonJDuZ8aPQ46hr6WwDkNjxAS/pLwtGntEIKVE7zkkI5LpKasym
 ew3SqWsXk6OnWsP+cJYG83sEQmG98O4MqbrZRrN5TAa16aknM0XExbVgmn+2bU0Tkubn
 aTyyF0G5KFIAyPTdN004PQARkinGilwhzSbYMV9paaBHmSLHt57uTQKI/RNwcraZOPpT
 GJ+iCsh2fbCp1oE0FYJgX/b4JCwutU3xMd880h1ArL+44iyecJf64Z3NfAWTt+RJS6qa
 4I3A==
X-Gm-Message-State: AOAM533bORGTBHomEbkiNnBy9qGB/fyg7/diuKgbttYcP7HJhP0f570o
 GVjw5b9mXvBV4f8DTW9NACul8Uzy5t6g+J1m/bi7SqoBSo5kzmWqQlPvtDPkpkXzXqpkFYkHfqw
 HvK6V8jze3dUzK3Y=
X-Received: by 2002:a5d:4ed2:: with SMTP id s18mr530042wrv.36.1603130672179;
 Mon, 19 Oct 2020 11:04:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx21ze4ezlZDsTG7S3mwkLOWpddBSO+XVmaEjBXdDm8qlruCrfS5Zj7BsUlzPMM0QjCsSu/nw==
X-Received: by 2002:a5d:4ed2:: with SMTP id s18mr530026wrv.36.1603130671923;
 Mon, 19 Oct 2020 11:04:31 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id s19sm397584wmc.41.2020.10.19.11.04.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 11:04:31 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] qapi: Restrict machine (and migration) specific
 commands
To: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20201012121536.3381997-1-philmd@redhat.com>
 <20201015182824.GG5733@habkost.net> <87ft6a1wgn.fsf@dusky.pond.sub.org>
 <20201019123014.GI5733@habkost.net> <87mu0i2mc7.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f57b2080-50ac-ee44-be8d-2dd4d6431d57@redhat.com>
Date: Mon, 19 Oct 2020 20:04:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87mu0i2mc7.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 6:48 PM, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
>> On Mon, Oct 19, 2020 at 09:55:20AM +0200, Markus Armbruster wrote:
>>> Eduardo Habkost <ehabkost@redhat.com> writes:
>>>
>>>> On Mon, Oct 12, 2020 at 02:15:31PM +0200, Philippe Mathieu-Daudé wrote:
>>>>> Reduce the machine code pulled into qemu-storage-daemon.
>>>>>
>>>>> The series is fully Acked, but Markus wants it reviewed
>>>>> by the Machine core maintainers.
>>>>
>>>> I've confirmed that all patches move QAPI schema code without
>>>> introducing any additional changes.
>>>>
>>>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>>
>>> I take this as "I agree the things moved to machine.json belong there".
>>> Holler if I'm mistaken.
>>
>> I agree machine.json is better than misc.json for them, yes.
>>
>> I miss short descriptions of the purpose of each file, though.
>> It would help us decide what's appropriate in the future.
> 
> The QAPI modules are commonly aligned with sub-systems defined in
> MAINTAINERS.
> 
> Regardless, file comments would be nice.

I don't understand what you mean/expect by "file comments".
Example?

W.r.t. MAINTAINERS, I can move Xen code to qapi/migration-xen.json;

'query-kvm' is used when no KVM built it, so I'll let it in
machine.json; the others seem to belong in machine.json too,
with no particular justification.


