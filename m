Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B60C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40D520656
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6SvVNup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40D520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic8C0-0004SU-0l
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 08:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ic7tX-0000Uu-Ei
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:07:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ic7tV-0006I1-86
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:07:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60290
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ic7tT-0006En-4e
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575378425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Q20x6mlBEmPE5iP+/ASB20o2DZAW07uX2nBrLPOrOA=;
 b=U6SvVNup6BaYr6pe+zGX7ZkYVh2cLh5n8OGJlQed6utIKYO2RXz/QgEc1JJ3z0t3obZ9fi
 8euGDnhhD62fRzJcATnhy+pV/RrMztHXHbHY9G2ieAMCpi74uxOJS92TDh1HnMflPzxqpx
 szKsqGpAn8xN8yPa3FIOaUD81DLfu6U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-1-RTGznxPGyDd2Wxv2WlrA-1; Tue, 03 Dec 2019 08:07:04 -0500
Received: by mail-wm1-f70.google.com with SMTP id y133so890407wmd.8
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 05:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0Q20x6mlBEmPE5iP+/ASB20o2DZAW07uX2nBrLPOrOA=;
 b=hFfH9qVJn20w4lHmy13YofHsEjQXJJwnJpFJZPlZwvsEuy1nm4tdu/UpTXlxRTeJNn
 YVzE1MCqpKg9rGU2ulb10xcrLjzJgWCzQBAm3Q3Kyit+IP5r4q0NKvTFHKKF/OWYfqMd
 HegW7Sa87jVXYhCYvyhBOH2WU3Ouag8qspKKV+OQ194ZvteTjzk3iqfNWsI4NEP/dVcV
 VXRsf4mVDipvyJv3ju3VJN7aE+Ijbfjv98eCVopbYBRvrrIbx5RTIC9gl54N85QSTNwh
 41DL1smphZ57gAY0+BP2sMLeYUEQqZ6mg4FU3b1zvPOUQnOLUX0dmxs4Gk47kbgj+l7i
 PkWw==
X-Gm-Message-State: APjAAAVF81qL3n8Clsej8Y8jFIc8XtzeMhV4kfNpAqxR4d4nZZOiOBmL
 862ZR97QjYnACgUdrSRxhaKmO+ZjcwoulUSbVSo4Iw88bqsAl5hT+OCiQhGLJ8THQ1TSsFhzu6a
 rHYdEwmbkukyM1ys=
X-Received: by 2002:adf:fd84:: with SMTP id d4mr5091932wrr.211.1575378423576; 
 Tue, 03 Dec 2019 05:07:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqxXdmpB1FW97B4yyQv9N5Sm4cJZsodaZoahtMwKJBlLN60/yULiOr7wgqIIxchgMJ74FCBoZw==
X-Received: by 2002:adf:fd84:: with SMTP id d4mr5091900wrr.211.1575378423362; 
 Tue, 03 Dec 2019 05:07:03 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a?
 ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
 by smtp.gmail.com with ESMTPSA id n8sm3507347wrx.42.2019.12.03.05.07.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 05:07:02 -0800 (PST)
Subject: Re: virtiofsd: Where should it live?
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20191125185021.GB3767@work-vm>
 <20191126102600.GG556568@redhat.com> <20191126121416.GE2928@work-vm>
 <db27af39-62a8-46e5-fccd-f09ed497b7bd@redhat.com>
 <20191203130250.GD3078@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dce5bc69-b7df-1ff8-39fc-81bb8486c1c5@redhat.com>
Date: Tue, 3 Dec 2019 14:07:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191203130250.GD3078@work-vm>
Content-Language: en-US
X-MC-Unique: 1-RTGznxPGyDd2Wxv2WlrA-1
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
Cc: mszeredi@redhat.com,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/12/19 14:02, Dr. David Alan Gilbert wrote:
>> It could be in fsdev/virtiofsd,
> fsdev is currently all 9p stuff, so that would seem very confusing.

Move it to fsdev/9p?

>> but I agree with Daniel that at this
>> point the QEMU build system introduces baggage that you may not want for
>> virtiofsd.
>
> I've already got it wired up in contrib with qemu's build system
> so that doesn't seem to be an issue.   The question is purely a 'where'.

Oh I agree it's not an insurmountable problem.  For a new project I may
not want to deal with the complicated rules.mak stuff; however, if
virtiofsd doesn't have to do anything complicated then it's your choice.

Paolo


