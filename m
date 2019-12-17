Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47C8C2D0BF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A260F2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A04OqL0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A260F2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihHgE-0000nw-PK
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 13:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihHdP-0006Ah-1T
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:31:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihHdL-0005HF-Hf
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:31:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22543
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihHdK-0005B3-VE
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576607506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLcnevH6fqooRYs1fUE0KF4aRe4zKRPDbH20yjfoEtc=;
 b=A04OqL0J3Nwy7XvGRmWJ5DVbBBzma9MhkdeLu2UQPn5kZtUZJJBnMDCc4hq2/hyStbLvOD
 COOvjLZ3P+Vzd4dexAwiVC00yEPuzKOj2VTkKL7isSHb9kuUcWfVhGEj1QPTjNkB7iEMWV
 dLu9nJxzXM6W345Hx20ABtyNN3uHThY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-_ec42PkhNkGZMDAM7cB5CQ-1; Tue, 17 Dec 2019 13:31:43 -0500
Received: by mail-wr1-f69.google.com with SMTP id 90so5675655wrq.6
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 10:31:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HLcnevH6fqooRYs1fUE0KF4aRe4zKRPDbH20yjfoEtc=;
 b=p079apfTEVxGPw17YbixIFXGh5QlWBpuGc4FLUm4sXTROhlkOKbSlzzgbhuhu5h5/z
 p4aS/HClgZDX4pwZDhJOK10onEGsE2Oh6gRoyFPQ1XYkbVI46EZ+oS3hciynZlY0NfLM
 9iWi8I/eUFKoLlYQ2Tgoqxg+Y1akZ+RAdF7okBMsS1LZGiP6kJ1iMi8VAiXE1BKjpCwz
 xKc2dQbkyW9yR9ruJ6dJr3wrOrpd/i9BJle+7xLyNO4WNT5rUScGjozppwj3vPfiSctd
 6mUGxR2ICn5PsHL91ykihGLSRhkYmqGit+/w8Hk0kLRu2Hb4Q9pncwYEyQ2ZV0pZ6ezZ
 RoyA==
X-Gm-Message-State: APjAAAUz1QEM9cjQWHAYNuM19NqvdOqaTrzTnD5EME9/5IpBQVt2Wnp5
 RBijaSU6+TRdbkxfEmRN/HmnXQeTDBh3krgcVfNSRcr9TsS8Bc6FddBcfZYKGAhunEG2fOjSinf
 I1CMOcXZ0V4ILAMM=
X-Received: by 2002:a05:600c:2c2:: with SMTP id
 2mr7099621wmn.155.1576607501644; 
 Tue, 17 Dec 2019 10:31:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqwzAHQHILDA7Jeaj1lJzIp2iCUh7hrAAlyfc0XuoFEhDLhIprC8CtNw5hdkgZACjGNlICnnAw==
X-Received: by 2002:a05:600c:2c2:: with SMTP id
 2mr7099599wmn.155.1576607501425; 
 Tue, 17 Dec 2019 10:31:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:503f:4ffc:fc4a:f29a?
 ([2001:b07:6468:f312:503f:4ffc:fc4a:f29a])
 by smtp.gmail.com with ESMTPSA id x132sm3840641wmg.0.2019.12.17.10.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 10:31:40 -0800 (PST)
Subject: Re: [PATCH] memory: Do not allow subregion out of the parent region
 range
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20191214160223.20012-1-philmd@redhat.com>
 <da81a3e7-62a8-f46e-c12f-4dead2a9091f@redhat.com>
 <92bb8e12-3ece-9811-438b-8fa64d2bde66@redhat.com>
 <4a07cc6f-8762-145e-2b54-c61b0e287f19@redhat.com>
 <127AF076-D309-4952-B572-52587A93F46A@redhat.com>
 <c5c27111-efc5-0a05-bdbd-415533e5bc30@linaro.org>
 <CAFEAcA955AwoDiuYxm0mJKV1qzyBorAz06dqi0tg2kMBT9GMTA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ab832e97-f583-c347-0b4d-0d2e11f6b2b3@redhat.com>
Date: Tue, 17 Dec 2019 19:31:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA955AwoDiuYxm0mJKV1qzyBorAz06dqi0tg2kMBT9GMTA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: _ec42PkhNkGZMDAM7cB5CQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/12/19 19:17, Peter Maydell wrote:
> On Tue, 17 Dec 2019 at 16:57, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 12/17/19 1:58 AM, Christophe de Dinechin wrote:
>>>
>>>
>>>> On 17 Dec 2019, at 11:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>> Yes, the idea is that you could have for one version of the device
>>>>
>>>>   parent 0x000-0x7ff
>>>>     stuff 0x000-0x3ff
>>>>     morestuff 0x400-0x7ff
>>>>
>>>> and for another
>>>>
>>>>   parent 0x000-0x3ff
>>>>     stuff 0x000-0x3ff
>>>>     morestuff 0x400-0x7ff
>>>>
>>>> where parent is the BAR, and you can share the code to generate the tree
>>>> underneath parent.
>>>
>>> I can see why you would have code reuse reasons to do that,
>>> but frankly it looks buggy and confusing. In the rare cases
>>> where this is indented, maybe add a flag making it explicit?
>>
>> The guest OS is programming the BAR, producing a configuration that, while it
>> doesn't make sense, is also legal per PCI.  QEMU cannot abort for this
>> configuration.
> 
> Does guest programming of the PCI BAR size actually change the size
> of the 'parent' region, or does it just result in the creation
> of an appropriately sized alias into 'parent' ?

Resizable BARs are not handled by the PCI host bridge but rather from
the device itself, so the device is free to handle them either way.

Paolo


