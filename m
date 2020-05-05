Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9C7C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13FF4206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAB++veQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FF4206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW0Q1-0001cQ-7W
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 12:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jW0PP-00018k-MA
 for qemu-devel@nongnu.org; Tue, 05 May 2020 12:27:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51531
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jW0PO-0005eF-HB
 for qemu-devel@nongnu.org; Tue, 05 May 2020 12:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588696021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdCRtmWpAAiz2dOC4pnI9Vd1pLrZMJBwW5XehUahrj0=;
 b=DAB++veQBfRHNN/8M4ISjT5IEzgQELcy45HBNej0hRAgnkL621qwVzGj1WUbwTt/1ZvM3R
 PVNuQLhwLa8stzZrpdHuKRxhopywA5NgYl+JbIAXYMZprOuiLpbDz7cwbEP/3SrNCjGlx7
 oLdY158LOSLXVgeNNJU9IZivaADMtJE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-GwyG0PrWMySvDtB-tiMTDg-1; Tue, 05 May 2020 12:27:00 -0400
X-MC-Unique: GwyG0PrWMySvDtB-tiMTDg-1
Received: by mail-wr1-f70.google.com with SMTP id p8so1476340wrj.5
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 09:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gdCRtmWpAAiz2dOC4pnI9Vd1pLrZMJBwW5XehUahrj0=;
 b=aI8ErHyaCvznmjjvVpqPrvJnUQuqK0hU610ydUbMDVhwsalcgppENYJZo8KVFyqoGn
 HWfn32eABeuy2+ZvKkse6nAku5kKkpQtXLVo3k0mqD+gJvtM1BmSk8Kh518E3nsQf4+3
 p6Q0JRf4mmm/y4QHAKV3QpIAnIdpF85Fn7p3fHJvHwkbE/JTZxn8TMvY4o6uvr81VdeY
 z6QQH7sGIHPi5NZXeAh5LyefUxfIG1ODgQHXxqJdugDZ+nac0tNLAzmjzIwRsgXY4tcV
 cjtQc0V85SYtSODJHweL6lYonW4xt7MttWdd65TW7UAlWzlSg67B30L4lHHOQEiTXBDr
 3HIg==
X-Gm-Message-State: AGi0Pub/yF51xPqO9Mr/JoYdPgRXX2WDluLamB1BqbsbISwCOVt3rcbf
 ZA+zFXoUnwb4LG+CbcZICb3nb1CilegvvaX916fPh7FQOKkLcqPEUMM6y9pRHNdBel8YIxaWY8u
 ERUR7f3uINnKWljU=
X-Received: by 2002:a1c:790e:: with SMTP id l14mr4246188wme.174.1588696019228; 
 Tue, 05 May 2020 09:26:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypJbmWGQOH8XxwS3L8Y3QE0MV/xtoCqz+Xdk6dU+uxDtqm6XMp7lBNjV8AOai5vp2GT+xKFd8w==
X-Received: by 2002:a1c:790e:: with SMTP id l14mr4246178wme.174.1588696019037; 
 Tue, 05 May 2020 09:26:59 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
 by smtp.gmail.com with ESMTPSA id x13sm4822726wmc.5.2020.05.05.09.26.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 09:26:58 -0700 (PDT)
Subject: Re: Infinite loop in bus_unparent(), qdev bug or qdev misuse?
To: Markus Armbruster <armbru@redhat.com>
References: <87tv0vzrwj.fsf@dusky.pond.sub.org>
 <6fc8633a-6d91-b83a-e6cd-5f714ccaf9ea@redhat.com>
 <875zda8j3m.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a4df3ba3-4759-56ac-68f8-f75eea93e27e@redhat.com>
Date: Tue, 5 May 2020 18:26:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <875zda8j3m.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/05/20 18:03, Markus Armbruster wrote:
>> That's a good one, and especially a safe one, since it matches
>> qdev_device_add.  It has the disadvantage of having to touch all
>> qdev_create() calls.
> 
> Also, it moves onboard devices from /machine/unattached/ to
> /machine/peripheral-anon/.

Uh indeed.  No that's too ugly.

>> Even better however would be to move the bus argument (and thus
>> qdev_set_parent_bus) to qdev_init, and likewise in qdev_device_add move
>> qdev_set_id after qemu_opt_foreach.  I looked at the property setters
>> and couldn't find anything suspicious (somewhat to my surprise), but I
>> haven't honestly tried.
> 
> Thus, we satisfy bus_unparent()'s precondition "bus children have a QOM
> parent"[*] by moving "add to parent bus" next to the place where we
> ensure "has QOM parent" by putting orphans under /machine/unattached/.
> Makes sense.
> 
> If we add to the bus first, the precondition ceases to hold until we
> realize.  Ugly, but harmless unless we manage to actually call the
> function then.

Shouldn't be a big deal, since users should call either qdev_set_id or
object_property_add_child before device_set_realized.

> I suspect we can't realize first, because the realize method may want to
> use the parent bus.

Right.

Moving the bus to qdev_init would be quite large but hopefully scriptable.

Paolo


