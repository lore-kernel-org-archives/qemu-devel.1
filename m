Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFEBC4727E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 050912395C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKGnID25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050912395C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKhnH-0001cY-U7
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 08:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKhmO-00013I-5w
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:52:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48427)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKhmK-0003Bu-HD
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600779135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OwvlI+/U6D7XyrGXJxIkltAXxadlQoV4ETO/4zEg2uk=;
 b=UKGnID25w+JmhXDZ39UWosSFkVIwC4tgm4cbLSOW9pnj66kTAbCvkAXJ7v7zwTU8d5pXPN
 3PqshfrYR04VFqFXzkKpSNJRnpxeOLB35ZzgfkFxNc9cU3+BKDbnZ7I80IqMJS9pxnehCL
 qaOVbUPNPi7vhwpQ0gNUy4aP/fwx4KM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198--f6gboMTO8epZQ8w6PSXQg-1; Tue, 22 Sep 2020 08:52:13 -0400
X-MC-Unique: -f6gboMTO8epZQ8w6PSXQg-1
Received: by mail-wm1-f72.google.com with SMTP id a7so881399wmc.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 05:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=OwvlI+/U6D7XyrGXJxIkltAXxadlQoV4ETO/4zEg2uk=;
 b=O2kwaz1r5hHnWOQLthtNalTE9IRC8PZEMlAUx5jBrjsb/tlAvL+rhKVGA2kLOle69E
 bz3HPxyxtmV2Fu4W0Vn6rywoUXqGlS3STx1Z0yA8DOWZAaG5OWCBcWeUeIzcbsVKLmGe
 HBS4PlFWyyIak9tRTwcOJwUzLC5pHxleeLB45oDEHCvRoxVMKe07Ad+7qmUCaqU7Ag8M
 e8Bt/+ZJYJ3cRV9dQBEQpYQmqXZc8UJpy42vYNG38FC6lcRj4FBx/b1gFcYTfrNdnjtr
 9LhOYxnuTG4HIDxocP3jJSM5z1jhsk27xUvnMlfdekLPEmalsF/abaIj85+2pNm1eN1x
 6B9A==
X-Gm-Message-State: AOAM530/bPLJvqJCafhqeggjdGPlWrTsVmoABMVn/hX0kPKFNPmkfqqx
 G1eiTw6qG7aH47Z1LJoVEXMxaWfnXmxN+J5MR1WGex20ah6dF/NuvhLAIgE0fej2cX8Cczg0pQn
 U/yE/8SKH7n7HZHY=
X-Received: by 2002:a7b:cbd4:: with SMTP id n20mr906056wmi.105.1600779132362; 
 Tue, 22 Sep 2020 05:52:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEFmle5emU7TWWhbNkbUGbSRkJaun+GFuphZ5Q2/Zrz002jev8X5cBDO9J8RBxBMd4C562NQ==
X-Received: by 2002:a7b:cbd4:: with SMTP id n20mr906026wmi.105.1600779132108; 
 Tue, 22 Sep 2020 05:52:12 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id q13sm29088909wra.93.2020.09.22.05.52.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 05:52:11 -0700 (PDT)
Subject: Re: [PATCH v5 15/15] tests/acceptance: add reverse debugging test
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org
References: <160077693745.10249.9707329107813662236.stgit@pasha-ThinkPad-X280>
 <160077702443.10249.3081355403088312591.stgit@pasha-ThinkPad-X280>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <a0af94f1-9d72-3f86-e2a8-5758dd44d403@redhat.com>
Date: Tue, 22 Sep 2020 14:52:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <160077702443.10249.3081355403088312591.stgit@pasha-ThinkPad-X280>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 mtosatti@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org,
 zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 2:17 PM, Pavel Dovgalyuk wrote:
> From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
> 
> This is a test for GDB reverse debugging commands: reverse step and reverse continue.
> Every test in this suite consists of two phases: record and replay.
> Recording saves the execution of some instructions and makes an initial
> VM snapshot to allow reverse execution.
> Replay saves the order of the first instructions and then checks that they
> are executed backwards in the correct order.
> After that the execution is replayed to the end, and reverse continue
> command is checked by setting several breakpoints, and asserting
> that the execution is stopped at the last of them.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> 
> --
> 
> v5:
>  - disabled (as some other tests) when running on gitlab
>    due to the unidentified timeout problem
> ---
>  MAINTAINERS                           |    1 
>  tests/acceptance/reverse_debugging.py |  208 +++++++++++++++++++++++++++++++++
>  2 files changed, 209 insertions(+)
>  create mode 100644 tests/acceptance/reverse_debugging.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


