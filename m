Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F6CC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91920206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSjZuWha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91920206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTopJ-0000Zx-Mb
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 11:40:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jToo4-0007f0-PF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jToo4-0006vr-3S
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:39:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38093
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jToo3-0006vi-M7
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588174765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bdNU1HSe6gmZze/vGMsSwBb3ja6kDM7tqgXxzbXisBQ=;
 b=DSjZuWhazxGz8Cb9GFOGFdaLql/HoNLDjcALLOsryxZWmfDBsoSK3Qov6JzlQeDxKQzFo7
 XaxSuTgeecG6ofyV+Y6a6VhH1W5jhIN1tUuB8okxmhq4/lLEQ214UsZMDLKKLyJp10kwLg
 DBZ3DBrH+A+suIqN1PYn/oWcgvYjigQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-wki47MXhMgumLoIWM_vAUQ-1; Wed, 29 Apr 2020 11:39:23 -0400
X-MC-Unique: wki47MXhMgumLoIWM_vAUQ-1
Received: by mail-wm1-f70.google.com with SMTP id h22so1393408wml.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 08:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bdNU1HSe6gmZze/vGMsSwBb3ja6kDM7tqgXxzbXisBQ=;
 b=OR9pBHEDLotAk1hmOvYueHNBQ6k24lKj311QYsCNtZMFmo3BvrDdUXd2vJaFGtM2Rh
 tPde6Gagz1m/CKObFcHUrNrSiZ/zJlYahedyyKGiNWGwYSHrOcoJ+BCzotoaLdrxm7Bq
 yWw7hX5K1sxyACmk4bLLXrcMebjvW49g+tsC3WWr4j4hMrim2/jmtPldJwspq/Ne5TZ8
 vvZ8uymJUgY8FwA0viuKvA/7N84+HSsqKoxzjuDqcMfIH64B/BBPeBLC4th1vm0OITha
 sq4irWwM/Oifo/PfDng0MjCB6bNIQTqO73pnAcfrYDl3pmp8qK8MqEDdTjYuTJf0VHcY
 nOTA==
X-Gm-Message-State: AGi0PuYRB3Za0h4bN8ZTOWJM1xl9kwtcuUJeFzPhb0jb7jayctbFQFcv
 IxzuM+s5/NKSlR/117aQf7v/ElblajD/LrjCz83oyYCikMI7ZGTgOMlZ4zRPHC9h5fSXMzYlwIq
 a9iqSMSN7dlW90xQ=
X-Received: by 2002:adf:b1c9:: with SMTP id r9mr43065866wra.271.1588174762231; 
 Wed, 29 Apr 2020 08:39:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypICrdunLv4iR8G7Pkh4MdBV0pU63tPG7vORXjU5gW90zRMrbzvU0HgpOG8keHObsKLq3LcHMg==
X-Received: by 2002:adf:b1c9:: with SMTP id r9mr43065833wra.271.1588174761836; 
 Wed, 29 Apr 2020 08:39:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac19:d1fb:3f5f:d54f?
 ([2001:b07:6468:f312:ac19:d1fb:3f5f:d54f])
 by smtp.gmail.com with ESMTPSA id g15sm31523930wrp.96.2020.04.29.08.39.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 08:39:21 -0700 (PDT)
Subject: Re: Failing property setters + hardwired devices + -global = a bad day
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87mu6uia5i.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1915d102-9528-9c31-8a8c-a84f7842fbe9@redhat.com>
Date: Wed, 29 Apr 2020 17:39:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87mu6uia5i.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/04/20 17:28, Markus Armbruster wrote:
> When an object gets created, its memory is zeroed, and then any class
> properties with an ->init() are initialized with
> 
>     obj->init(obj, prop);
> 
> We have just one ->init():
> 
>     void object_property_init_defval(Object *obj, ObjectProperty *prop)
> 
> It initializes from ->defval using ->set().
> 
> Aside: feels overengineered, but let's move on.
> 
> For TYPE_DEVICE objects, "static" properties get initialized the same.
> 
> Aside: if I know what "static" means, I'll be hanged.

Originally these were the only properties that were part of the class
rather than the object (so, not dynamic --> static).

> I'd love to deprecate -global wholesale, but we can't as long as we
> don't have better means to configure onboard devices.  Can we deprecate
> its use with backend properties at least?

I wouldn't mind deprecating -global wholesale, leaving the global/compat
props code only for internal usage.

Paolo


