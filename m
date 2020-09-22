Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0493EC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 06:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A72523A1E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 06:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLL6mPoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A72523A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKcFu-0003ud-4c
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 02:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKcDu-0002fX-CT
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 02:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKcDp-0003w5-Mp
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 02:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600757773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fdmGL0X3kZ623XBvGj6grePr2oGnneoqjceqFQ7hFKo=;
 b=BLL6mPoHhwG+NZEGA3eMiMf2V15xS8emNXEN1jHwRuHwoQCJUuiWeNTZKGn/AznxuUANZA
 V9BMSfg0zH95gZP1cgqKjLFD0SPzF0zuIILiJJNutQhU7SE73Otp+D4LugeLVLC2nNMMuu
 blhb3jNtX4sM/y7l453043UBbmV31JI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-5MjuBhREN0mkFF2Bi8wLTg-1; Tue, 22 Sep 2020 02:56:10 -0400
X-MC-Unique: 5MjuBhREN0mkFF2Bi8wLTg-1
Received: by mail-wr1-f71.google.com with SMTP id l9so6972594wrq.20
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 23:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fdmGL0X3kZ623XBvGj6grePr2oGnneoqjceqFQ7hFKo=;
 b=LqZo5ge10lAvC8wdvLmCoxNw6vu9X1240yO2mjfpvhrtJe5pXUo3k1xt41qiqwA0yN
 hxjRbMx4B9WyohrIL3Gf9bSVw6rzS0RjVL35aDeTE0924O32yZ3w6mSwBpQNNmWQxvYV
 xQXim4gvwYp9icVgsBcBtFGXueDvUP3RwXYuGounOllEM38CNVZp/qbA1IYkPfokBJin
 4Q6rRH4A1AlxR6ksvbojJ4XPqujkCGRUZQUq8U3/HLwjR4bA46CZAu7DJdvqNxTo7pLn
 reV5UKngQrs7KPnv4vBds4VZGG7M7uQdszz94HKdN0ZkimD9khmdbvifJwHjcshTzQiR
 zjmw==
X-Gm-Message-State: AOAM532X02mpAw7x9tGUe1e/twSxYMRGA4oHUyss1wwdAex2UT1GKjhh
 W+zRarcX9JiAEEZ5sVbTXxUKODOsdQlYidZa2eQUqxWVdWcDINwhNhGEM1CWs0EL7kjAD3SpmmM
 e7Yufm6Z8aBRn4y4=
X-Received: by 2002:adf:8187:: with SMTP id 7mr3658825wra.266.1600757769269;
 Mon, 21 Sep 2020 23:56:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKFFt/QRb04H8kSIfdQ5jqG5B6jsQvAnc25MIGryjLgYDuFqTx9G3VVN2PDZNnPRD+beCn4A==
X-Received: by 2002:adf:8187:: with SMTP id 7mr3658757wra.266.1600757769000;
 Mon, 21 Sep 2020 23:56:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d153:8d0f:94cf:5114?
 ([2001:b07:6468:f312:d153:8d0f:94cf:5114])
 by smtp.gmail.com with ESMTPSA id g131sm3054048wmf.25.2020.09.21.23.56.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 23:56:08 -0700 (PDT)
Subject: Re: [PATCH] qemu/atomic.h: prefix qemu_ to solve <stdatomic.h>
 collisions
To: David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200921162346.188997-1-stefanha@redhat.com>
 <c8892b73-6cee-9fd3-54b0-289149926041@redhat.com>
 <52b8a46e-ab9e-1645-163d-497122ece907@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8610ca0e-0b3f-6d95-43b9-e2e49571e311@redhat.com>
Date: Tue, 22 Sep 2020 08:56:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <52b8a46e-ab9e-1645-163d-497122ece907@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 sheepdog@lists.wpkg.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Juan Quintela <quintela@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
 Paul Durrant <paul@xen.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Liu Yuan <namei.unix@gmail.com>, qemu-riscv@nongnu.org,
 Sunil Muthuswamy <sunilmut@microsoft.com>, John Snow <jsnow@redhat.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 xen-devel@lists.xenproject.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/20 08:45, David Hildenbrand wrote:
>> It's certainly a good idea but it's quite verbose.
>>
>> What about using atomic__* as the prefix?  It is not very common in QEMU
>> but there are some cases (and I cannot think of anything better).
>
> aqomic_*, lol :)

Actually qatomic_ would be a good one, wouldn't it?

Paolo


