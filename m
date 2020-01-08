Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D551BC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A131D20673
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="A9HKLxy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A131D20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip8fO-000317-Rs
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 05:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pizhenwei@bytedance.com>) id 1ip8ea-00020s-J7
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:33:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pizhenwei@bytedance.com>) id 1ip8eW-0005qp-M8
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:33:30 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pizhenwei@bytedance.com>)
 id 1ip8eV-0005pQ-NV
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:33:28 -0500
Received: by mail-pf1-x444.google.com with SMTP id 2so1394677pfg.12
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 02:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=cdSJSGbLnDpOdD7bx3wS9/M9UvrVrKVp1PIjFgljr+I=;
 b=A9HKLxy/pITkNc/Pyc0HocIQ6oGOkJP+pINYqDMLvie0g/ZYw6B/J7dbuBIHnd/ky+
 ivZdLq1hLu1Id5rY6nrgKqsYImO8pK0O7gG3WvUIn9PQFWZOCr2mxjAeDuAGi4F/Q9tl
 XoiROmAZT17416Ni8nYdT7Ar1xNsEuqFaU5X4ZFb+AKBNg43/R2GBYDPsBxnf6BmhXr1
 AYAABqHtFKpGT2euF8hyJIlXRXHWR9OscfKoFZJI5HbSFnb2JAAk2RVsJzwk/kLMPyTq
 oiN2G7K7QsKEK7ymTBMlj5e1E4S/u0umKzrm8h4JPf37hJen/IUGfMZIj3ozBxe+UT1q
 BFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=cdSJSGbLnDpOdD7bx3wS9/M9UvrVrKVp1PIjFgljr+I=;
 b=W2o3uWw1qBpDwq+oKsPl477pIS7PFtaK4Kc03nSRzBBxw8WJZ0WAXZtgPBWjyACtOK
 2CyG5Q0SR4sB0Wg+DOdW9H3PAc1UI02SA9V3fe67U5hgUhbScoHhMDc8Bv1SyARroHfr
 mJy9xegeCCfee3daUJY9SDQxznrn/94RNSgsGtgWIdPixcLNURTBwLoM0gOHVKCpL1sn
 wSJkrMnm+HXzke5MWgpjxWbzkeRGJTu3nchQo/FSaG42M43Mdho16mD8ozt+aki+FG06
 ISkguCAEDUeUzO663vjXySqfx3m9VqzelZ/YrkwoUQivb33gBkEbVcxjpKa6yuxPp7ad
 IgIQ==
X-Gm-Message-State: APjAAAXKcfj50bbDDgbfGUo4R97gH4YkfNLTP4G0+k52bq5+CmjBYqYb
 m828Rg25VVRQdsB+3ZxC5x6A8A==
X-Google-Smtp-Source: APXvYqwFxmMXXUqQHzBTYHfpXThNmvhnf4cnivJhcX8gkg7ff8/oulZN4lviTZyjHpcZs3n+SwU7ag==
X-Received: by 2002:a63:4850:: with SMTP id x16mr4636101pgk.334.1578479605771; 
 Wed, 08 Jan 2020 02:33:25 -0800 (PST)
Received: from [10.2.24.220] ([61.120.150.77])
 by smtp.gmail.com with ESMTPSA id a18sm2702537pjq.30.2020.01.08.02.33.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 02:33:25 -0800 (PST)
Subject: Re: [External] Re: discuss about pvpanic
To: Paolo Bonzini <pbonzini@redhat.com>, Michal Privoznik <mprivozn@redhat.com>
References: <2feff896-21fe-2bbe-6f68-9edfb476a110@bytedance.com>
 <dd8e46c4-eac4-046a-82ec-7ae17df75035@redhat.com>
 <d0c57f84-a25c-9984-560b-2419807444e1@redhat.com>
 <05c5fcc0-24bd-ae6e-6bb8-23970ab0b56c@redhat.com>
From: zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <d915c9e6-1ad7-4f8f-a66a-c418d43e977f@bytedance.com>
Date: Wed, 8 Jan 2020 18:33:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <05c5fcc0-24bd-ae6e-6bb8-23970ab0b56c@redhat.com>
Content-Type: multipart/alternative;
 boundary="------------D2987981BEE815CE9644A151"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: "libvir-list@redhat.com" <libvir-list@redhat.com>,
 Greg KH <gregkh@linuxfoundation.org>, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, "yelu@bytedance.com" <yelu@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------D2987981BEE815CE9644A151
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/8/20 6:05 PM, Paolo Bonzini wrote:

> On 08/01/20 10:58, Michal Privoznik wrote:
>>> the kernel-side patch certainly makes sense.  I assume that you want the
>>> event to propagate up from QEMU to Libvirt and so on?  The QEMU patch
>>> would need to declare a new event (qapi/misc.json) and send it in
>>> handle_event (hw/misc/pvpanic.c).  For Libvirt I'm not familiar, so I'm
>>> adding the respective list.
>> Adding an event is fairly easy, if everything you want libvirt to do is
>> report the event to upper layers. I volunteer to do it. Question is, how
>> qemu is going to report this, whether some attributes to GUEST_PANICKED
>> event or some new event.
> I think it should be a new event, using GUEST_PANICKED could cause upper
> layers to react by shutting down or rebooting the guest.
>
> Thanks,
>
> Paolo
>
>
In previous patch(https://lkml.org/lkml/2019/12/14/265), I defined a new bit (bit 1)
PVPANIC_CRASH_LOADED for guest crash loaded event. And suggested by KH Greg, I moved
the bit definition to an uapi header file.
Then QEMU could include the header file from linux header and handle the new event.

-- 
Thanks and Best Regards,
zhenwei pi


--------------D2987981BEE815CE9644A151
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <pre>On 1/8/20 6:05 PM, Paolo Bonzini wrote:</pre>
    <blockquote type="cite"
      cite="mid:05c5fcc0-24bd-ae6e-6bb8-23970ab0b56c@redhat.com">
      <pre class="moz-quote-pre" wrap="">On 08/01/20 10:58, Michal Privoznik wrote:
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">the kernel-side patch certainly makes sense.  I assume that you want the
event to propagate up from QEMU to Libvirt and so on?  The QEMU patch
would need to declare a new event (qapi/misc.json) and send it in
handle_event (hw/misc/pvpanic.c).  For Libvirt I'm not familiar, so I'm
adding the respective list.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Adding an event is fairly easy, if everything you want libvirt to do is
report the event to upper layers. I volunteer to do it. Question is, how
qemu is going to report this, whether some attributes to GUEST_PANICKED
event or some new event.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think it should be a new event, using GUEST_PANICKED could cause upper
layers to react by shutting down or rebooting the guest.

Thanks,

Paolo

</pre>
      <pre>

</pre>
    </blockquote>
    <pre>In previous patch(<a class="moz-txt-link-freetext" href="https://lkml.org/lkml/2019/12/14/265">https://lkml.org/lkml/2019/12/14/265</a>), I defined a new bit (bit 1)
PVPANIC_CRASH_LOADED for guest crash loaded event. And suggested by KH Greg, I moved
the bit definition to an uapi header file.
Then QEMU could include the header file from linux header and handle the new event.
</pre>
    <pre class="moz-signature" cols="72">-- 
Thanks and Best Regards,
zhenwei pi</pre>
  </body>
</html>

--------------D2987981BEE815CE9644A151--

