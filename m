Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EB7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B55206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PykGUhv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B55206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIKP-0002Wz-5n
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jtHoq-0003Sq-1V
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:41:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24956
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jtHoo-0003qq-Ad
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOv6tU5DTnmCc08vAr+FFI7nvp7MvkxbN0TJYxFA4Es=;
 b=PykGUhv6RMMPQ4pJH7gxUZUO8V6a2Qtmg9tA3QMS5IdcV2BDU/bmZyqoGSjx43einVFLK2
 0nlXTPKdg1DjRuHcffvSxRKmqkxC/D8ZaWCQOv4D2hz1ARE13l5kqpV7bNJJR9lC0zBqvq
 UrkMWMHfjff+G5A6FQLiWV4GN1wppT0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-EpnuRc5vPZGGSPEvCf6XoA-1; Wed, 08 Jul 2020 10:40:07 -0400
X-MC-Unique: EpnuRc5vPZGGSPEvCf6XoA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E97711015EA2;
 Wed,  8 Jul 2020 14:40:06 +0000 (UTC)
Received: from [10.36.113.241] (ovpn-113-241.ams2.redhat.com [10.36.113.241])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56B877847B;
 Wed,  8 Jul 2020 14:40:06 +0000 (UTC)
Subject: Re: [PULL 05/34] virtio-iommu: Implement RESV_MEM probe request
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
 <20200703165405.17672-6-peter.maydell@linaro.org>
 <CAFEAcA9+RE_Fk3XrnqCD5b3HMK8L+RDVyz+BkUd0bGRJQXB-1A@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <4c31aaf5-7d48-790b-efc2-cf0b5af88ff9@redhat.com>
Date: Wed, 8 Jul 2020 16:40:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9+RE_Fk3XrnqCD5b3HMK8L+RDVyz+BkUd0bGRJQXB-1A@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:11
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 7/5/20 8:21 PM, Peter Maydell wrote:
> On Fri, 3 Jul 2020 at 17:54, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> From: Eric Auger <eric.auger@redhat.com>
>>
>> This patch implements the PROBE request. At the moment,
>> only THE RESV_MEM property is handled. The first goal is
>> to report iommu wide reserved regions such as the MSI regions
>> set by the machine code. On x86 this will be the IOAPIC MSI
>> region, [0xFEE00000 - 0xFEEFFFFF], on ARM this may be the ITS
>> doorbell.
> 
>> @@ -452,6 +524,17 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>>          case VIRTIO_IOMMU_T_UNMAP:
>>              tail.status = virtio_iommu_handle_unmap(s, iov, iov_cnt);
>>              break;
>> +        case VIRTIO_IOMMU_T_PROBE:
>> +        {
>> +            struct virtio_iommu_req_tail *ptail;
>> +
>> +            output_size = s->config.probe_size + sizeof(tail);
>> +            buf = g_malloc0(output_size);
>> +
>> +            ptail = (struct virtio_iommu_req_tail *)
>> +                        (buf + s->config.probe_size);
>> +            ptail->status = virtio_iommu_handle_probe(s, iov, iov_cnt, buf);
>> +        }
>>          default:
>>              tail.status = VIRTIO_IOMMU_S_UNSUPP;
>>          }
> 
> Hi Eric -- Coverity points out (CID 1430180) that this new case
> has neither a 'break' nor a /* fallthrough */ comment. Which is correct?
Thank you for reporting. Sure I will send a fix. This is harmless from a
functional pov.

Best Regards

Eric
> 
> thanks
> -- PMM
> 


