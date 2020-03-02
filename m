Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A276C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 639BF21739
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M120COud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639BF21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8kss-00081f-K1
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 08:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8ks2-0006ZM-AI
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:12:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8ks1-0004Bw-7p
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:12:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30777
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8ks1-0004Bi-4M
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583154748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j3j3zgZFp7cgL8l+nTfGohdvgm+p9IYBabAkH89plWY=;
 b=M120COudcLnUd71/sxctVCXmn96E0i12zke2uPqIXH9tbSmHRMVT+fvBparseR0Ljz44Mu
 AxrxVT2P/U450uvLEeDG7nrRHuLCapUWwgpvMyzUT4pKKldT70ErEfNesZnOdEjSyMPzor
 SGllpIa/z16yduABKaj1p3NzrRwDfjU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-B-zC-gDeMz6R2yXhvuvkpA-1; Mon, 02 Mar 2020 08:12:27 -0500
X-MC-Unique: B-zC-gDeMz6R2yXhvuvkpA-1
Received: by mail-wr1-f70.google.com with SMTP id z16so3466208wrm.15
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 05:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QgazTPWuQCk4wQGJGaUMkhja4da8tQl8FlBoocQBnAs=;
 b=VkEmbVPMYIqXTcbh48M0K57Sf5gtislWd9E4Sx3FiJiLm5EmgogpnVjC53oEkU/4Uo
 MDziZDRk8PiWXX4kQNiA8mU6OYVMRVXyfFR4wdTNJqIznlWSJCYz0oVTSTgHNh7+7E3E
 Hy21u1HecWi6wH5eczRg7tRqfmkMYBvi6XidOjViAO0pmSZGtgwVc/3X0Xkgx9zIpwL8
 N34/aJ1gFwAP71FtnOdOfpH+eMSgpjvS65MKrVRhYFPlnXUm0f/8f4jNX70L65ug3zvC
 oOoP6SlMn882VOUyme33iocNPfX7tVI0Njv/36S3Re0mSO8jxzvr5fLKazGbQYRS9a+Q
 742w==
X-Gm-Message-State: ANhLgQ0mDDyZdT86SyyqZ/of2YyosnIhc7RP1llKTqa3RTFGt7vWLW30
 4alZacYMs/M1MVPcfAK3nLrjpfxitS8msZR8870sD/ndGmiIjj6+5Z8sUZtRvfOYlSJGxJXvrpg
 ghidFS3Bq+5XMfOQ=
X-Received: by 2002:a1c:e40b:: with SMTP id b11mr9703766wmh.13.1583154743950; 
 Mon, 02 Mar 2020 05:12:23 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvJ40OoVsmGJL5yD+SlR94Jk7OrMCWq1yfgPaXfHA6vsQghLbikxWbZE+qLDh8q4NadOGn6pQ==
X-Received: by 2002:a1c:e40b:: with SMTP id b11mr9703742wmh.13.1583154743628; 
 Mon, 02 Mar 2020 05:12:23 -0800 (PST)
Received: from ?IPv6:2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0?
 ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id g25sm30131945wmh.3.2020.03.02.05.12.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 05:12:23 -0800 (PST)
Subject: Re: [PATCH v2 1/2] tests/vhost-user-bridge: move to contrib/
To: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20200207095412.794912-1-lvivier@redhat.com>
 <20200301071119-mutt-send-email-mst@kernel.org>
 <c68547be-3131-8069-70d9-f0a1758784d7@redhat.com>
 <20200302055232-mutt-send-email-mst@kernel.org>
 <cf4bf124-9335-291f-4773-37e511eb78fa@redhat.com>
 <36d7a15c-8988-b4df-6320-6dcb29328348@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <30200a37-7c0d-2964-3018-6fb6d3f460af@redhat.com>
Date: Mon, 2 Mar 2020 14:12:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <36d7a15c-8988-b4df-6320-6dcb29328348@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 1:30 PM, Laurent Vivier wrote:
> On 02/03/2020 12:19, Laurent Vivier wrote:
>> On 02/03/2020 11:53, Michael S. Tsirkin wrote:
>>> On Mon, Mar 02, 2020 at 10:50:16AM +0100, Laurent Vivier wrote:
>>>> On 01/03/2020 13:12, Michael S. Tsirkin wrote:
>>>>> On Fri, Feb 07, 2020 at 10:54:11AM +0100, Laurent Vivier wrote:
>>>>>> vhost-user-bridge is not a test. Move it to contrib/ and
>>>>>> add it to the tools list.
>>>>>>
>>>>>> It will be built only if tools (--enable-tools) and
>>>>>> vhost-user (--enable-vhost-user) are enabled (both are set
>>>>>> by default).
>>>>>>
>>>>>> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>>>
>>>>>
>>>>> I had to drop this series from my tree since it cause failures
>>>>> on OSX. Pls use something like travis CI to test when you repost
>>>>> a fixed version. Thanks!
>>>>>
>>>>
>>>> Do you have a link to the error logs?
>>>>
>>>> Thanks,
>>>> Laurent
>>>
>>>
>>> Peter sent me this:
>>>
>>>
>>> Hi; this fails to build on OSX:
>>>
>>>    CC      contrib/libvhost-user/libvhost-user.o
>>> /Users/pm215/src/qemu-for-merges/contrib/libvhost-user/libvhost-user.c:=
27:10:
>>> fatal error: 'sys/eventfd.h' file not found
>>> #include <sys/eventfd.h>
>>>           ^~~~~~~~~~~~~~~
>>> In file included from
>>> /Users/pm215/src/qemu-for-merges/contrib/vhost-user-bridge/main.c:37:
>>> /Users/pm215/src/qemu-for-merges/contrib/libvhost-user/libvhost-user.h:=
21:10:
>>> fatal error: 'linux/vhost.h' file not found
>>> #include <linux/vhost.h>
>>>           ^~~~~~~~~~~~~~~
>>> 1 error generated.
>>>
>>> thanks
>>> -- PMM
>>>
>>> But pls do test on OSX before reposting.
>>>
>>
>> Thank you.
>>
>> I will fix and test the new patch with Travis CI.
>=20
> In fact, travis was enabled when I sent the series but the QEMU
> .travis.yml disables the tools so the vhost-user-bridge was not built.

Can you send a patch to enable them?

>=20
> Thanks,
> Laurent
>=20


