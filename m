Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4A1C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC48220719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N69mF5F4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC48220719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHNLk-00021B-21
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 03:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jHNL8-0001ap-Sz
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jHNL7-00058C-QL
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:54:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:53616)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jHNL7-00057q-N6
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585209249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ewe17eOYdz4EvmwE26373XLT8s4P4W/Qf8XDkOh2IQo=;
 b=N69mF5F4dVL66uvIZ97LHMnGD3TBBcVNdIlIuPPAEvnGEIRe9YCftsyX5hwWaksqIpbZ5f
 0o8Ci496jwiOIW+GW+rCuaLhoRizsDWdfkcXMdDZzNmvXiDzuD+qQOV5IMLKzzQ/IoRq+W
 mi6YHP50SAil1+C2oy2ZCjpWy2e3yrk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-erdCmC8aPnW7QE92lvCb-w-1; Thu, 26 Mar 2020 03:54:07 -0400
X-MC-Unique: erdCmC8aPnW7QE92lvCb-w-1
Received: by mail-wr1-f69.google.com with SMTP id l17so2633547wro.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 00:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=Qql73jNfeDPnZ1XbHZy/14bgCxWzkLKp7JWHPRCQOTQ=;
 b=QPHFSZSaT4OG+ZcEFaDWf8E99ldoeQaNG+yWDP1N4VMTgl4xVIjfy/XtuhYYbdD4t/
 V8bnV60U5mr+ZRQQjcECDKpWpbxdOd3aJNXPlO0x7UMRil4eETAJnQOXxQnlMbLe0Wqt
 4E7DUd0knJDHC0v6PEFlXwxzbpX2ngPxdRZlQ81GYTQeJhdNWmVduXgkEYqZfWQw1jE8
 +0wr3TSQMUIs8Kw4eWhrq+RERXmC0xk3KF9Y3HD9DBdtQHv1BqJx9lxgB2TFHoETY7eM
 JdXn+ZhycyDuxB/FZosA/DvalbXziHyqe/evpjZn7OI7LSs+2xA1eFrn0pFCQgx4m4e/
 dypg==
X-Gm-Message-State: ANhLgQ0UZoV79f1zhmJVoOXAUJ8sK6Jp2Pwe6egmf4pJQD+OpuUnvU5x
 5yuG1B/aCyD/dAsh11NHdrIc1kWRJb54RpNVfTbxfhTj6vYIqAhxrqYPiDpyuis/l3fUoXWGpAK
 04M6jqRFrCFtrtn4=
X-Received: by 2002:a1c:5506:: with SMTP id j6mr1794735wmb.127.1585209246377; 
 Thu, 26 Mar 2020 00:54:06 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsFiiPx40ICgltZ/bol/CKCo9kj2UWVxCUn27QCXL8zjviDH6XzIhY9x6yyTt09drMK3JIEew==
X-Received: by 2002:a1c:5506:: with SMTP id j6mr1794715wmb.127.1585209246127; 
 Thu, 26 Mar 2020 00:54:06 -0700 (PDT)
Received: from [192.168.3.122] (p5B0C669F.dip0.t-ipconnect.de. [91.12.102.159])
 by smtp.gmail.com with ESMTPSA id c189sm2366124wmd.12.2020.03.26.00.54.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2020 00:54:05 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER to
 handle THP spilt issue
Date: Thu, 26 Mar 2020 08:54:04 +0100
Message-Id: <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
References: <20200326031817-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200326031817-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: iPhone Mail (17D50)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: pagupta@redhat.com, Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 mojha@codeaurora.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, namit@vmware.com,
 Hui Zhu <teawaterz@linux.alibaba.com>, akpm@linux-foundation.org,
 jasowang@redhat.com, Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 26.03.2020 um 08:21 schrieb Michael S. Tsirkin <mst@redhat.com>:
>=20
> =EF=BB=BFOn Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hildenbrand wrot=
e:
>>> On 12.03.20 09:47, Michael S. Tsirkin wrote:
>>> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wrote:
>>>> 2. You are essentially stealing THPs in the guest. So the fastest
>>>> mapping (THP in guest and host) is gone. The guest won't be able to ma=
ke
>>>> use of THP where it previously was able to. I can imagine this implies=
 a
>>>> performance degradation for some workloads. This needs a proper
>>>> performance evaluation.
>>>=20
>>> I think the problem is more with the alloc_pages API.
>>> That gives you exactly the given order, and if there's
>>> a larger chunk available, it will split it up.
>>>=20
>>> But for balloon - I suspect lots of other users,
>>> we do not want to stress the system but if a large
>>> chunk is available anyway, then we could handle
>>> that more optimally by getting it all in one go.
>>>=20
>>>=20
>>> So if we want to address this, IMHO this calls for a new API.
>>> Along the lines of
>>>=20
>>>    struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
>>>                    unsigned int max_order, unsigned int *order)
>>>=20
>>> the idea would then be to return at a number of pages in the given
>>> range.
>>>=20
>>> What do you think? Want to try implementing that?
>>=20
>> You can just start with the highest order and decrement the order until
>> your allocation succeeds using alloc_pages(), which would be enough for
>> a first version. At least I don't see the immediate need for a new
>> kernel API.
>=20
> OK I remember now.  The problem is with reclaim. Unless reclaim is
> completely disabled, any of these calls can sleep. After it wakes up,
> we would like to get the larger order that has become available
> meanwhile.
>=20

Yes, but that=E2=80=98s a pure optimization IMHO.

So I think we should do a trivial implementation first and then see what we=
 gain from a new allocator API. Then we might also be able to justify it us=
ing real numbers.

>=20
>> --=20
>> Thanks,
>>=20
>> David / dhildenb
>=20


