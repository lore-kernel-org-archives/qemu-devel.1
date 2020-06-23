Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2239DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:42:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E70FB20679
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GeAddJ3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70FB20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnfRq-0002Nl-7u
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jnfNh-0003Xr-Hh
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:38:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30885
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jnfNf-00040D-Au
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592905094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EDVNEO/7e2ojQSQx8Xt92oDqQaSqEwwyiSdNzE8kGtY=;
 b=GeAddJ3Or5gQK4xB6ISTbPcHc0g+GCsranTvMphoEP6gCDICgubWKOhMcSh0nmwCkjrEAT
 GcLYpAucXAvKhnK25i8JijD0suW6KfgGOmHgqgxm5u6dd8hXw0ZJPo4l/Ds9QfA39oTA2M
 eHlSo2y8RggoVivgUAv7XpCfK2Pd2ss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-Pwh_a9bsP7iv-LW2Yq8sVg-1; Tue, 23 Jun 2020 05:38:10 -0400
X-MC-Unique: Pwh_a9bsP7iv-LW2Yq8sVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 210E8464;
 Tue, 23 Jun 2020 09:38:08 +0000 (UTC)
Received: from [10.72.12.144] (ovpn-12-144.pek2.redhat.com [10.72.12.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DBEA78EB3;
 Tue, 23 Jun 2020 09:37:45 +0000 (UTC)
Subject: Re: [PATCH v1 08/10] vhost: implement vhost_dev_start method
To: Cindy Lu <lulu@redhat.com>
References: <20200622153756.19189-1-lulu@redhat.com>
 <20200622153756.19189-9-lulu@redhat.com>
 <3fab12a1-1c44-b18d-cfb8-f069190e0b2c@redhat.com>
 <CACLfguWkntyF0Syrcy=90X8jweCJFASgz7=tN4yS1CpZ+Bo7=g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cb056761-1a02-c8d3-962c-b5ed1b5a525e@redhat.com>
Date: Tue, 23 Jun 2020 17:37:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CACLfguWkntyF0Syrcy=90X8jweCJFASgz7=tN4yS1CpZ+Bo7=g@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Cornelia Huck <cohuck@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org, hanand@xilinx.com,
 Rob Miller <rob.miller@broadcom.com>, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Shahaf Shuler <shahafs@mellanox.com>, kevin.tian@intel.com, parav@mellanox.com,
 Vitaly Mireyno <vmireyno@marvell.com>, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, Ariel Adam <aadam@redhat.com>,
 rdunlap@infradead.org, Maxime Coquelin <maxime.coquelin@redhat.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/6/23 下午5:34, Cindy Lu wrote:
> On Tue, Jun 23, 2020 at 3:21 PM Jason Wang<jasowang@redhat.com>  wrote:
>> On 2020/6/22 下午11:37, Cindy Lu wrote:
>>> use the vhost_dev_start callback to send the status to backend
>> I suggest to squash this into previous patch.
>>
> Sure will do
>>> Signed-off-by: Cindy Lu<lulu@redhat.com>
>>> ---
>>>    hw/virtio/vhost.c         | 17 +++++++++++++++++
>>>    include/hw/virtio/vhost.h |  2 ++
>>>    2 files changed, 19 insertions(+)
>>>
>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>> index 01ebe12f28..bfd7f9ce1f 100644
>>> --- a/hw/virtio/vhost.c
>>> +++ b/hw/virtio/vhost.c
>>> @@ -744,6 +744,7 @@ static void vhost_iommu_region_del(MemoryListener *listener,
>>>        }
>>>    }
>>>
>>> +
>>>    static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
>>>                                        struct vhost_virtqueue *vq,
>>>                                        unsigned idx, bool enable_log)
>>> @@ -1661,6 +1662,11 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
>>>            }
>>>        }
>>>
>>> +    r = vhost_set_start(hdev, true);
>> I think we need a better name for this function.
>>
> Shall we change it to vhost_set_device_start ? Since the
> vhost_dev_start was occupied by other function


Or maybe just open code the vhost_set_start here since there's no other 
users.

Thanks



