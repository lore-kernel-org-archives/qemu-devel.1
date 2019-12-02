Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D29EC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 02:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D995420725
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 02:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAeW2t/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D995420725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibbtR-0002em-1F
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 21:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1ibbsm-0002FX-JC
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:56:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1ibbsl-0005sI-5s
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:56:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41182
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ibbsk-0005rg-VF
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575255373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nzz1d6fNBXps/DnIs5UAQiNGoXHliCVcfy6g5+mgQoM=;
 b=dAeW2t/WLQUbR5gaBgZTZN0ABm+RkjdgQP2knBrAhyUVEfqjmPc9ZVpoWv5XbpYQKGZkme
 fSzvwhYRTWzYwux1luOfvISljxo9slO5D8rb1IU3aWQHwpc6DWemEEr2MrUlX7T9sA3ypZ
 HStlkL/tR82qYf38Dz0ic8LsKDF4lto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-zMKLkK5MNLCjozNN_3opZg-1; Sun, 01 Dec 2019 21:56:11 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B525B800D41;
 Mon,  2 Dec 2019 02:56:09 +0000 (UTC)
Received: from [10.72.12.226] (ovpn-12-226.pek2.redhat.com [10.72.12.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F8AF5D6A0;
 Mon,  2 Dec 2019 02:56:01 +0000 (UTC)
Subject: Re: [RFC net-next 08/18] tun: run offloaded XDP program in Tx path
To: David Miller <davem@davemloft.net>, mst@redhat.com
References: <f39536e4-1492-04e6-1293-302cc75e81bf@gmail.com>
 <20191201.125621.1568040486743628333.davem@davemloft.net>
 <20191201163730-mutt-send-email-mst@kernel.org>
 <20191201.135439.2128495024712395126.davem@davemloft.net>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <71cb13b9-fe81-c338-68dc-4d432360a0fb@redhat.com>
Date: Mon, 2 Dec 2019 10:56:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191201.135439.2128495024712395126.davem@davemloft.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: zMKLkK5MNLCjozNN_3opZg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: songliubraving@fb.com, jakub.kicinski@netronome.com, hawk@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, john.fastabend@gmail.com,
 ast@kernel.org, qemu-devel@nongnu.org, prashantbhole.linux@gmail.com,
 kvm@vger.kernel.org, dsahern@gmail.com, yhs@fb.com, andriin@fb.com,
 kafai@fb.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/12/2 =E4=B8=8A=E5=8D=885:54, David Miller wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Date: Sun, 1 Dec 2019 16:40:22 -0500
>
>> Right. But it is helpful to expose the supported functionality
>> to guest in some way, if nothing else then so that
>> guests can be moved between different hosts.
>>
>> Also, we need a way to report this kind of event to guest
>> so it's possible to figure out what went wrong.
> On the contrary, this is why it is of utmost importance that all
> XDP implementations support the full suite of XDP facilities from
> the very beginning.
>
> This is why we keep giving people a hard time when they add support
> only for some of the XDP return values and semantics.  Users will get
> killed by this, and it makes XDP a poor technology to use because
> behavior is not consistent across device types.
>
> That's not acceptable and I'll push back on anything that continues
> this trend.
>
> If you can't HW offload it, kick it to software.


We can try to work out a solution for XDP_REDIRECT.

Thanks


