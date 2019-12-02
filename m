Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF48C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 02:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374F920881
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 02:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ewlo5Km8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374F920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibbkB-0006aa-Ew
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 21:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1ibbio-00050f-Ho
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1ibbin-00023E-Gw
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:45:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33113
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ibbin-00022o-DL
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575254756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A5SS3ilN57be+dKCEWLuoWs9cfIT9f/3tFpS4mzNsu0=;
 b=Ewlo5Km8l2KemrhI66Oqo5lcLxzuOMeSPUW4qx+886XRk9f9SJNMYbUN1hsOI0/ptM66PX
 vmiXATzbG9nvcsBwR3kvAgKQjUpsVNsCaKbZ9g9ox7nJlB2iu0I8I+6tju0HxYXV7zqoTH
 aVI9QXJsNAjf2bnW7IrjqLB145w/ofM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-M13GqMyeMo-aN-w95nrSwQ-1; Sun, 01 Dec 2019 21:45:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1950E107ACC4;
 Mon,  2 Dec 2019 02:45:49 +0000 (UTC)
Received: from [10.72.12.226] (ovpn-12-226.pek2.redhat.com [10.72.12.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CFB260BFB;
 Mon,  2 Dec 2019 02:45:41 +0000 (UTC)
Subject: Re: [RFC net-next 08/18] tun: run offloaded XDP program in Tx path
To: David Ahern <dsahern@gmail.com>,
 Prashant Bhole <prashantbhole.linux@gmail.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
 <20191126100744.5083-9-prashantbhole.linux@gmail.com>
 <f39536e4-1492-04e6-1293-302cc75e81bf@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <af0ce325-15ea-e3fd-9c20-fd4296266e63@redhat.com>
Date: Mon, 2 Dec 2019 10:45:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f39536e4-1492-04e6-1293-302cc75e81bf@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: M13GqMyeMo-aN-w95nrSwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Song Liu <songliubraving@fb.com>,
 Jakub Kicinski <jakub.kicinski@netronome.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andriin@fb.com>, Martin KaFai Lau <kafai@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/12/2 =E4=B8=8A=E5=8D=8812:39, David Ahern wrote:
> On 11/26/19 4:07 AM, Prashant Bhole wrote:
>> run offloaded XDP program as soon as packet is removed from the ptr
>> ring. Since this is XDP in Tx path, the traditional handling of
>> XDP actions XDP_TX/REDIRECT isn't valid. For this reason we call
>> do_xdp_generic_core instead of do_xdp_generic. do_xdp_generic_core
>> just runs the program and leaves the action handling to us.
> What happens if an offloaded program returns XDP_REDIRECT?
>
> Below you just drop the packet which is going to be a bad user
> experience. A better user experience is to detect XDP return codes a
> program uses, catch those that are not supported for this use case and
> fail the install of the program.


Yes, this could be done in the guest.

Thanks


