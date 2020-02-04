Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0BFC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA58F2082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrH0zAVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA58F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyxSj-0003el-W2
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 07:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iyxS1-0003Du-BD
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:37:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iyxRz-0008TW-8a
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:37:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22281
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iyxRz-0008Ps-3B
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580819826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v0IVNVijPEAGVo676KSbJRLq87b3zRTX9Lpy3WdWpng=;
 b=MrH0zAVxX1SeoUVv9qUFMI1zBLkrYwvl6YWO4rpndfhE1pidOzSpbDmg5W+8zk+3D995tS
 pYw4dUciHxAiXnVM3ptWVczzoTmPKYEVosNytwLXL7z8A+ss4+0vCJESsECMRdcafu5TtW
 fQyRvJHI/QukotJPCJOhwfC/CMe2DPQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-s--FqP2mOcaYVhjMoqodsw-1; Tue, 04 Feb 2020 07:37:04 -0500
Received: by mail-wr1-f72.google.com with SMTP id p8so3252170wrw.5
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 04:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v0IVNVijPEAGVo676KSbJRLq87b3zRTX9Lpy3WdWpng=;
 b=FYWrfDmwuTsGyHfno3yhyZ4PdMpO64xwDl6sKhjSg0ET4qZ299rSRAB0MNo67BHZlM
 ebJNl7VP0q3uT7eExulwgQSg87INCxOZBZz3MsFfzjgjYJqjcv7t7eB3UWmodRrDKiLN
 G3Izk1ac8b9urmk+BB4m3wPDXTARX9c5nGPmgyYr1A+PBDugFeukxENR/8etrlwf/0dN
 8YSlV4gyPlJnqvAlLAcWqSK3dccSEL2S8MvOEVzR7runlhlQ84KkV2KlaQ/DLTJLXZwT
 tVkfwqH+pfwYlwuFfB+IGSPFW2QSDIlI2OdiqB4JD8ERbg/djLxJZA5qxNmS4h0LYGsT
 cLhw==
X-Gm-Message-State: APjAAAUPzTc0XaOt7f2SZDghe/m7rFPnjMM3Dp2yvo56OS5Kf/n3NRai
 mB7YpHRfdOZebCU2TTgLMmkWPpRVbELzIQAZtKuGYbXT6Il4FA5gkgZ/D9xQwhQzIg2ShG3MLWy
 2bDacnLrhOhy+SQw=
X-Received: by 2002:adf:face:: with SMTP id a14mr21559199wrs.284.1580819823687; 
 Tue, 04 Feb 2020 04:37:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwrDuGKhcVRaqf0Fcf8kPxNIdNJh2+2aFfiPvQEckVZX+d+CngIbZZ8qpoiuIGRT1Uo8ESiHg==
X-Received: by 2002:adf:face:: with SMTP id a14mr21559180wrs.284.1580819823435; 
 Tue, 04 Feb 2020 04:37:03 -0800 (PST)
Received: from [192.168.178.40] ([151.20.243.54])
 by smtp.gmail.com with ESMTPSA id y12sm3579679wmj.6.2020.02.04.04.37.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 04:37:02 -0800 (PST)
Subject: Re: [PATCH 1/2] configure: Allow user to specify sphinx-build binary
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200203132533.21850-1-peter.maydell@linaro.org>
 <20200203132533.21850-2-peter.maydell@linaro.org>
 <87d0au8wlh.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2ff980d6-bfa1-0db4-62cc-c10a3e0865e6@redhat.com>
Date: Tue, 4 Feb 2020 13:37:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87d0au8wlh.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: s--FqP2mOcaYVhjMoqodsw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/02/20 11:39, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> Currently we insist on using 'sphinx-build' from the $PATH;
>> allow the user to specify the binary to use. This will be
>> more useful as we become pickier about the capabilities
>> we require (eg needing a Python 3 sphinx-build).
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> I went with the most common convention for specifying "here's
>> an executable", like --make=, --install=, --python=....
>>
>> The only odd one out for our current configure options seems to be
>> that we want --with-git=GIT, not --git=GIT. You could argue that
>> that's a better convention,
> 
> It's the one Autoconf uses.
> 
>>                             but it makes more sense to me to
>> stick with the convention we currently mostly have. (Perhaps
>> we should even change --with-git= to --git= ?)
> 
> Paolo, any implications on the Meson conversion?

Nope, there will still be a handwritten configure script (and in the
beginning it will be pretty much the same as now; in due time, it will
handle command line parsing only).

Paolo


