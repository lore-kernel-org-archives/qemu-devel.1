Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF3DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 06:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7758F20792
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 06:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHXSJBgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7758F20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxleD-00027Q-Py
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 02:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jxldZ-0001cp-TE
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 02:20:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34350
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jxldX-0002PY-Nh
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 02:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595312422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Q5wnw+A6AkT9T1WqqYqoeFrPLXXUYV7t1gN+K1te5w=;
 b=HHXSJBggEphCWH0/ZQWxmhMApRq6vYxImxzW8D95DWRkXHoqtFeVT+Wto7QV/GOcf8tGTm
 WihuSSU7yDL4ZmN2XtqK374IU+Lbj5LCaKrHIPftsk20r4OUs+/aI9V4WRz0AVxdEj6lsg
 uMnMmGuEZuwgxVzKiL8uvHtKqTuIVFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-AhysxfcHOtKAAvpv8ykUUg-1; Tue, 21 Jul 2020 02:20:20 -0400
X-MC-Unique: AhysxfcHOtKAAvpv8ykUUg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 266C358;
 Tue, 21 Jul 2020 06:20:19 +0000 (UTC)
Received: from [10.72.12.202] (ovpn-12-202.pek2.redhat.com [10.72.12.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6988E8731A;
 Tue, 21 Jul 2020 06:20:04 +0000 (UTC)
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
To: Peter Xu <peterx@redhat.com>
References: <20200708141657.GA199122@xz-x1>
 <14b1ca26-448d-0feb-7529-6546809aaa59@redhat.com>
 <20200709141037.GF199122@xz-x1>
 <fb2f8d35-3f04-55ac-e0c0-7eeedbaf2429@redhat.com>
 <20200710133005.GL199122@xz-x1>
 <05bb512c-ca0a-e80e-1eed-446e918ad729@redhat.com>
 <20200716010005.GA535743@xz-x1>
 <b0319440-6e53-f274-59ba-6dbc67de69be@redhat.com>
 <20200717141806.GE535743@xz-x1>
 <d772c597-e6a2-ab88-43c5-b35b77d6c84e@redhat.com>
 <20200720130346.GM535743@xz-x1>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <31f7ee27-e649-b547-9cf8-35a88a1aa491@redhat.com>
Date: Tue, 21 Jul 2020 14:20:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720130346.GM535743@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:26:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 Juan Quintela <quintela@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/20 下午9:03, Peter Xu wrote:
> On Mon, Jul 20, 2020 at 12:02:06PM +0800, Jason Wang wrote:
>> Right, so there's no need to deal with unmap in vtd's replay implementation
>> (as what generic one did).
> We don't even for now; see vtd_page_walk_info.notify_unmap.  Thanks,


Right, but I meant the vtd_address_space_unmap() in vtd_iomm_replay(). 
It looks to me it will trigger UNMAP notifiers.

Thanks



