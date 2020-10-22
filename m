Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20609C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 15:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504CF223BF
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 15:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqRjquiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504CF223BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVca0-0002Lu-6D
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 11:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVcXN-0008Cy-LX
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 11:29:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVcXL-0004vD-Vc
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 11:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603380594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jkiSTsiwDrNQ72v/SazVSSbk21cua5TJ5JZP+u5sNmw=;
 b=HqRjquizpOVUn7+mXB4/tyLdIYHIBDskP/q1ZmK77+Oz71eGJi8kdzCVKfE8ldvEQoStV9
 S/8wh+p7yl6DfeoKAaSsYX5RaD3X7tyrgYZomCAnf6TdKwrtTJmpbi6XUg7jY2pFKTAll/
 3YE97xe6WmHb9WfiT6H97poMeIFL/2g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-Od1z4Fz-PYCq1G5Rd6rcEw-1; Thu, 22 Oct 2020 11:29:52 -0400
X-MC-Unique: Od1z4Fz-PYCq1G5Rd6rcEw-1
Received: by mail-wm1-f70.google.com with SMTP id o15so725631wmh.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 08:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jkiSTsiwDrNQ72v/SazVSSbk21cua5TJ5JZP+u5sNmw=;
 b=hBgv4VZ+fbB7fOMByp2N2DNKGarfy4zeIFgNdBnj+vPFy+smI/MDaXI2p4VIutqg4c
 xgGILjb9Dt0SO4B1k1gEzsW8VVby0isT2ZrvdnwCXRMtPjp+Q1kYXv48ZRJz8iMHrYRT
 URxL2s6EKZaFyrY5GFM9c/0eQXW/HVWmt/+26Hlg3FASWua6RJzbrS693w/Py7pmklBw
 6yWMYyNndf5naX8ec+CgnugRD3b3rtqWsd56bsTnhtNO8dDVC3JCociMgPe8pcTnkB6j
 qGG6TzSxXcC5lPlZz9A9aLpY0c4FchndjR++ZVxmJq/kkMbIiUE3fk5xk5BhZk/xXkT+
 HpJQ==
X-Gm-Message-State: AOAM532H5gtbokpBnjndIIIaSRkM+3vsMhNh1Blc/8M7QpSt9ccHlOsT
 SqMO5phaMxE22BXAAeMYc0mI6vsp7ymvhlIOFgdpXpyxVTPJBRZq9dV6Y4TetnM9Doj+aLlyFeJ
 OdEj9DakxBLlppbs=
X-Received: by 2002:a1c:7ec7:: with SMTP id z190mr3064253wmc.8.1603380591398; 
 Thu, 22 Oct 2020 08:29:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGX5JjI76ENng2y9LttGQf7DnpCKaOVKsBzUv2Ybaho8Ek92Wpmo5+190HqXDZuCF8ZiFmCQ==
X-Received: by 2002:a1c:7ec7:: with SMTP id z190mr3064228wmc.8.1603380591192; 
 Thu, 22 Oct 2020 08:29:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id h7sm4766264wrt.45.2020.10.22.08.29.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2020 08:29:50 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Add Xen CpusAccel
To: Jason Andryuk <jandryuk@gmail.com>
References: <20201013140511.5681-1-jandryuk@gmail.com>
 <ddb5c9c2-c206-28d6-2d9d-7954e7022c23@redhat.com>
 <CAKf6xpvpuG1jVdf3+heXzHFd_kc5kVHYdJgC+8iazFLciqOMZw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d9f23eee-c0af-d2dd-9b9d-f0255fc8e3d1@redhat.com>
Date: Thu, 22 Oct 2020 17:29:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAKf6xpvpuG1jVdf3+heXzHFd_kc5kVHYdJgC+8iazFLciqOMZw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:09:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 QEMU <qemu-devel@nongnu.org>, Claudio Fontana <cfontana@suse.de>,
 Anthony Perard <anthony.perard@citrix.com>,
 xen-devel <xen-devel@lists.xenproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/10/20 17:17, Jason Andryuk wrote:
> On Tue, Oct 13, 2020 at 1:16 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 13/10/20 16:05, Jason Andryuk wrote:
>>> Xen was left behind when CpusAccel became mandatory and fails the assert
>>> in qemu_init_vcpu().  It relied on the same dummy cpu threads as qtest.
>>> Move the qtest cpu functions to a common location and reuse them for
>>> Xen.
>>>
>>> v2:
>>>   New patch "accel: Remove _WIN32 ifdef from qtest-cpus.c"
>>>   Use accel/dummy-cpus.c for filename
>>>   Put prototype in include/sysemu/cpus.h
>>>
>>> Jason Andryuk (3):
>>>   accel: Remove _WIN32 ifdef from qtest-cpus.c
>>>   accel: move qtest CpusAccel functions to a common location
>>>   accel: Add xen CpusAccel using dummy-cpus
>>>
>>>  accel/{qtest/qtest-cpus.c => dummy-cpus.c} | 27 ++++------------------
>>>  accel/meson.build                          |  8 +++++++
>>>  accel/qtest/meson.build                    |  1 -
>>>  accel/qtest/qtest-cpus.h                   | 17 --------------
>>>  accel/qtest/qtest.c                        |  5 +++-
>>>  accel/xen/xen-all.c                        |  8 +++++++
>>>  include/sysemu/cpus.h                      |  3 +++
>>>  7 files changed, 27 insertions(+), 42 deletions(-)
>>>  rename accel/{qtest/qtest-cpus.c => dummy-cpus.c} (71%)
>>>  delete mode 100644 accel/qtest/qtest-cpus.h
>>>
>>
>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Thank you, Paolo.  Also Anthony Acked and Claudio Reviewed patch 3.
> How can we get this into the tree?

I think Anthony should send a pull request?

Paolo


