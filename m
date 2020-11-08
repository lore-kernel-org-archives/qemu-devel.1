Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33ECC388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 17:10:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30796206D4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 17:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/arm1AF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30796206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kboCj-0008KG-Ck
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 12:10:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kboBl-0007eB-Vp
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 12:09:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kboBj-00020t-2D
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 12:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604855349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gNQE3wirPN0dx6XpKBUjTiRoIvDDd7OROJyQgDN0Uhk=;
 b=R/arm1AFWJSQlegF+Fxt7Zn9LlZzrkRALkNc+ZhTQ9nGLud/s1/IAzhxlYvIbgj5SY1V8/
 yWPlDCHZDBGAC9SDv9TVZHl2lzMqOefp5blGupwuvr2JC/9t8dY1ak5aes5O6dQ2UU6z1s
 F8mbNy8hfqHJXGYZMDxbZHa+PWPZjHw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-M-PywCs9PYeJhVOfjYugbQ-1; Sun, 08 Nov 2020 12:09:07 -0500
X-MC-Unique: M-PywCs9PYeJhVOfjYugbQ-1
Received: by mail-wr1-f70.google.com with SMTP id j15so3174658wrd.16
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 09:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gNQE3wirPN0dx6XpKBUjTiRoIvDDd7OROJyQgDN0Uhk=;
 b=OkzVtUF/kifbqtrYslvlkUeoWZZWTf90By6M/rdCnrDEfTsMK0AyoOxi5dhRtzOJaw
 JU980vW17Dl3bkPlmhc8IvPtmU6lg4dXFkWYS2ddj45DiwdKhj31nH/1LiA3kQwXHHAK
 hFl/GXN2B3CzK6QpKm7tdhYsZ+V3zyfiFdGUnNl0ElTlvBFWIr4RVguwah1Ws+Diwe2Z
 qr3BdHR8y864JBVj4bx0gBpt6Rxm6WemDVkDCNktjTn3OlDFGuTY3qFpocPh4W+MFH2n
 ROuW5+I37WM+yWXl+5Lircu1xbrP+T2isIgaQI/s1wog1T7V9XqHY16u/LAOqW8MvkbT
 vPBQ==
X-Gm-Message-State: AOAM532vWiZ7lPopA40+tbEN92OVyqISjmMMrVbmVWLI7/5sxFSEHDx/
 yvrr9F6TA+vqSlTj+8+MTmJN0F7+bJxPhSCa5bn8WxqKBYTfOoP1V4nMI4UDyrlEQyg6IWmIkLs
 hJhLtYda8Ki/3QiA=
X-Received: by 2002:a5d:5701:: with SMTP id a1mr13534735wrv.414.1604855345142; 
 Sun, 08 Nov 2020 09:09:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeysOyuzArcbWUSc+yoajADk7ek6WpeE/8NBqcS+kDjamCTjW1eZVJfMoCzY7M6AhvhzqrWA==
X-Received: by 2002:a5d:5701:: with SMTP id a1mr13534723wrv.414.1604855345025; 
 Sun, 08 Nov 2020 09:09:05 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t11sm9998623wmf.35.2020.11.08.09.09.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2020 09:09:04 -0800 (PST)
Subject: Re: [PATCH for-5.2] qga: fix missing closedir() in
 qmp_guest_get_disks()
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
References: <20201108161112.187945-1-michael.roth@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b8ef4b32-ef30-a1ac-5ea1-525402821eae@redhat.com>
Date: Sun, 8 Nov 2020 18:09:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201108161112.187945-1-michael.roth@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 09:02:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/8/20 5:11 PM, Michael Roth wrote:
> We opendir("/sys/block") at the beginning of the function, but we never
> close it prior to returning.
> 
> Fixes: Coverity CID 1436130
> Fixes: fed3956429d5 ("qga: add implementation of guest-get-disks for Linux")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Tomáš Golembiovský <tgolembi@redhat.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  qga/commands-posix.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


