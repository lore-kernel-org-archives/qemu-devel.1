Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F67BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 12:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A8820866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 12:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVnxFnDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A8820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k41sd-0000zk-7a
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 08:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k41rw-0000V8-H0
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 08:53:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32099
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k41ru-00028k-43
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 08:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596804785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BQqzbYgNuxyPZxD47ySRpjTEBLEY/2vg0dEB482llMA=;
 b=LVnxFnDV/zs7ULJ9Bn0dzl1a+iWwqQNMJloSoXX88srdI5LtSGOIEvGbUexC15a+TqbnW0
 6RPtF8uFYXH9BzVGM/g7WnQxHg6bqyazhNBhMemvvtAEovt6SjxsrZNV5EGDrIcYHbWIFr
 3gAXb44SCuxJULvqirGGrXd1C/giQlw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-DGWTj6C4NU2GgoeHveBdMw-1; Fri, 07 Aug 2020 08:53:02 -0400
X-MC-Unique: DGWTj6C4NU2GgoeHveBdMw-1
Received: by mail-wm1-f72.google.com with SMTP id a207so638304wme.9
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 05:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BQqzbYgNuxyPZxD47ySRpjTEBLEY/2vg0dEB482llMA=;
 b=Bi8xwE/noIJLtZMRb1SXPoDsqejgnb0RYOzRxujLgFjpl8uWWd+smPVZtmRwTqdZ6o
 S8XbPUVG5fv+GYJx7iY1U3tkGDBo6urEnbiz64yb6a2lQIP4l1FxynMo4Z9bTojK2GXS
 b7D3X77/fYcDBykYfvAOvCcLOESPkxC3Gw2+mt7DfQmj55k/2qBsJdWs/N7TeProRWXP
 vBnWRS2jzlnyER3+SRSj1Aj/qIDJokXTe+61+a2LQ1Y3JYeWW/jif8Ev/NVEASfPtf4o
 iurOR4pGasu8DkJENzc9rqoAPZrD3VHuDTgQ6li+0sSFplW6tS0oL9w0son5da0Swmol
 yO8g==
X-Gm-Message-State: AOAM532ITQMto5P4DpT7B2Xy/439Ac8gfEd63URSGq3lFv/Yo0CQNg+C
 b8a05J5bEuxhD2CIcM9xHu6Fu0tFXlwLyCnRbqojqvBqpQLM55lECSxsnYCE6OJ8UwhF7QUFQu6
 EBvfuOOv6slZx2cs=
X-Received: by 2002:a05:600c:2302:: with SMTP id
 2mr13055329wmo.151.1596804780704; 
 Fri, 07 Aug 2020 05:53:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxH7N6BY5On9tPULsj72doga6llCXjK4lBTgTfHXZK9P0ifzEyViRRVNUN40dSkV4RJjaX7pw==
X-Received: by 2002:a05:600c:2302:: with SMTP id
 2mr13055311wmo.151.1596804780509; 
 Fri, 07 Aug 2020 05:53:00 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.136.3])
 by smtp.gmail.com with ESMTPSA id t25sm9754555wmj.18.2020.08.07.05.52.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 05:52:59 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <761b4058-7a2b-d992-2cc2-6efe654ee62e@redhat.com>
 <9c894412-b156-607e-1ea9-9e9ba14cbf1a@redhat.com>
 <6f6e9c9b-fdf6-951e-9112-3913fe44c455@redhat.com>
 <ac18da61-6f54-b9d4-7591-e1296f9d3a32@redhat.com>
 <353ff6f7-c67f-7665-b631-967512417fa2@redhat.com>
 <fa3570e7-1f2a-c44c-91f2-411c1f51e6ef@redhat.com>
 <d9cc3875-1780-5fcc-5c2a-5408e6aba2e5@redhat.com>
 <cd17b073-57bb-e121-f55e-c89f6e005801@redhat.com>
 <b20db8c2-3201-0172-b6e9-ca1f2c0ef05b@redhat.com>
 <80039400-81e7-9c14-60c5-839b0ea5aef4@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b1d4eea3-77ac-ff5f-2906-da6d0c36d4f9@redhat.com>
Date: Fri, 7 Aug 2020 14:52:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <80039400-81e7-9c14-60c5-839b0ea5aef4@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, philmd@redhat.com,
 armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 14:20, Thomas Huth wrote:
> On 07/08/2020 13.04, Paolo Bonzini wrote:
>> On 07/08/20 12:52, Thomas Huth wrote:
>>> Thanks! Now, both, macOS and FreeBSD builds stop with:
>>>
>>>  ../tests/qtest/meson.build:204:0: ERROR: Unknown variable "dbus_vmstate1".
>>>  https://cirrus-ci.com/task/6220295902068736?command=main#L210
>> Easy peasy lemon squeezy! :)
> Nice, we're getting there, now macOS starts compiling, but then fails here:
> 
>  ../contrib/libvhost-user/libvhost-user.c:27:10: fatal error:
> 'sys/eventfd.h' file not found
> ../contrib/libvhost-user/libvhost-user.h:21:10: fatal error:
> 'linux/vhost.h' file not found
>  https://cirrus-ci.com/task/5170197348745216?command=main#L810
> 
> (and FWIW, there are some weird "file: ... has no symbols" earlier in
> the log when running AR on the capstone files)

This one is interesting, the vhost-user samples have never been built by
default so they have always been broken on macOS.  So that will be a bugfix.

Paolo


