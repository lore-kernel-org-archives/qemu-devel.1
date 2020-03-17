Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D71C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046F120663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAf51rom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046F120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9b0-0006ba-12
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jE9Rt-0001TX-DU
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jE9Rs-0001Z4-Cj
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:27:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55217)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jE9Rs-0001Si-7n
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584440867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Es5YNMuYHbD/0Pj7xxHy+DX/ynr1OuFYkFxd50kqhS0=;
 b=dAf51romkAXcuS7cLzABNz7EFc+gyAQxtdT89v6RvxY9+bhBT1eGFAnVQ1gd2fKG22+dmy
 swUt2LrH40Z9UeS65olUxyQ4lODKX6r+6ZttV0AG6ryr7r2M0e9ss4Is5xlrxLTfGxkH8h
 Z0y6DS3wnCxnY+TPVCjobZqwrJ+NzjA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-03kzja2nNYeL4Igv-H18Xw-1; Tue, 17 Mar 2020 06:27:43 -0400
X-MC-Unique: 03kzja2nNYeL4Igv-H18Xw-1
Received: by mail-wm1-f71.google.com with SMTP id a23so6951167wmm.8
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 03:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b4ue4HBlk0wlprqmw7rP19D9WyYBfZS5Z5GORIUm+VY=;
 b=KR4QmyLV9m1iywwMPCEreYtdaGmCPRZdIXZEEJVjHtTqHDsZV8RiKkauOJMYZnb4AP
 X3wW5KIeM3vCq3K+stFj4wYaEBmNPdCnh+aZHdLf5NmG6seHjtzAtRnq3bVJWiRkfMjY
 xxWMMxJDO949bPEAZnJi4S+7RLNg2AiyKbHMPtkcqAqPE3kr4JfR0zZOLnTDz62tB5DZ
 HbWCxYwHsjsh0Y18DvfnF5FfMCN1jzvqx6LWSzm5GKuY3ZJECFvxt9y4OoCd2MwJFAY4
 15cRfERKr01jer07IWKFsJgu07obZ4PhS7LKcIpzrvXmDtw6VHtOd5bZn2wvae5PsRod
 p/pA==
X-Gm-Message-State: ANhLgQ2LkZuQPLKHWVzSFwP7nXrZo5RcwQEXB2fhx8AZRro/ZfVN7QES
 xmELl25h2kyI6ZfnHJtone0FXbF49yJuRlcQ8wIWvfLENCvYmCFmdVLy/hpXoTc/FGsb6mDKZYf
 yf05QS9f+QKnw0j8=
X-Received: by 2002:a5d:44c1:: with SMTP id z1mr5129193wrr.315.1584440862701; 
 Tue, 17 Mar 2020 03:27:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvif/Qj3ow192LmueaosfhLd4VY5SCXjrAi4CUKAdHNUIU93WQZPO4824p1dOOY3XXcUTocfQ==
X-Received: by 2002:a5d:44c1:: with SMTP id z1mr5129178wrr.315.1584440862475; 
 Tue, 17 Mar 2020 03:27:42 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.227])
 by smtp.gmail.com with ESMTPSA id i21sm3449926wmb.23.2020.03.17.03.27.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 03:27:41 -0700 (PDT)
Subject: Re: [PULL 09/61] MAINTAINERS: Add entry for Guest X86 HAXM CPUs
To: Colin.Xu@intel.com, qemu-devel@nongnu.org
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
 <1584394048-44994-10-git-send-email-pbonzini@redhat.com>
 <d9e9e44f-ba54-c2e7-01c8-72337d3f5993@intel.com>
 <bc354cda-b731-183f-3860-43c3a0af434c@redhat.com>
 <41756673-bbd4-593f-ade8-3232db8b512e@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1eead546-c06f-2ec0-e3b7-fdc5bb426620@redhat.com>
Date: Tue, 17 Mar 2020 11:27:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <41756673-bbd4-593f-ade8-3232db8b512e@intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Wenchao Wang <wenchao.wang@intel.com>, Hang Yuan <hang.yuan@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/03/20 09:55, Colin Xu wrote:
>=20
> On 2020-03-17 16:26, Paolo Bonzini wrote:
>> On 17/03/20 08:46, Colin Xu wrote:
>>> Hi Paolo,
>>>
>>> For future HAX patch, once it's "Reviewed-by" haxm maintainers and othe=
r
>>> reviewers, do we need "SubmitAPullRequest" separately or you will do it
>>> together with other patches?
>> As you prefer.=C2=A0 I wouldn't mind having to send fewer pull requests.=
 :)
>>
>> Paolo
>=20
> Would you mind continue help HAX send pull request? It feels like easier
> to track the changes when stay together with other accelerator patches.
> We'll regularly check the reviewed patches and do necessary tests, and
> send you a list of patches that can be queued for next pull.
>=20
> What do you think?

Sure, that's okay.  The number of patches is low enough.

Paolo


