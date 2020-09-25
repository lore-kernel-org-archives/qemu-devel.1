Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEC6C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2707235FD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDXtfHLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2707235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqKw-0002K7-SZ
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kLq2d-0007RM-Rj
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kLq2a-0001Od-Ns
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:53:47 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601049222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l3yBKQeQJqiG97QgfxJaOgdMpk+Ofs6lr0suBJktfUo=;
 b=TDXtfHLDxK+TbSH674SwKEFmjS1TZ3a65DktZaWZYJQ+nwck2ynO+hu/17QKqGfC7JIP8W
 2rs5xdq1Oo9v2xd5Q9VsI8KVMMemRpshsfxN3JOjgYZDS9LZ57aCpOtuxOdCex/+XI2DVS
 e7Isvb63XM0/62MlSYGarv/S4MDhcSo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-erweG6DWOKyjRsq6abyIcQ-1; Fri, 25 Sep 2020 11:53:40 -0400
X-MC-Unique: erweG6DWOKyjRsq6abyIcQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8235281F02F;
 Fri, 25 Sep 2020 15:53:39 +0000 (UTC)
Received: from [10.36.113.81] (ovpn-113-81.ams2.redhat.com [10.36.113.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A72335577D;
 Fri, 25 Sep 2020 15:53:22 +0000 (UTC)
Subject: Re: [RFC 1/3] util/vfio-helpers: Collect IOVA reserved regions
To: Fam Zheng <fam@euphon.net>
References: <20200925134845.21053-1-eric.auger@redhat.com>
 <20200925134845.21053-2-eric.auger@redhat.com> <20200925144307.GA3809989@dev>
 <c2a4750a-dd33-2170-d450-3879e98210b5@redhat.com>
 <6ed38e381e57237c1dc84cc07d54f48895ccd517.camel@euphon.net>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <effd18e4-b8c2-c6d8-8108-a6e311ad33b8@redhat.com>
Date: Fri, 25 Sep 2020 17:53:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6ed38e381e57237c1dc84cc07d54f48895ccd517.camel@euphon.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: lvivier@redhat.com, kwolf@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, stefanha@redhat.com, philmd@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Fam,

On 9/25/20 5:44 PM, Fam Zheng wrote:
> On Fri, 2020-09-25 at 17:23 +0200, Auger Eric wrote:
>>>> @@ -365,8 +430,12 @@ static int qemu_vfio_init_pci(QEMUVFIOState
>>>> *s, const char *device,
>>>>      if (ret) {
>>>>          goto fail;
>>>>      }
>>>> +    g_free(iommu_info);
>>>>      return 0;
>>>>  fail:
>>>> +    g_free(s->usable_iova_ranges);
>>>
>>> Set s->usable_iova_ranges to NULL to avoid double free?
>>
>> I think I did at the beginning of qemu_vfio_init_pci()
> 
> Yes, but I mean clearing the pointer will make calling
> qemu_vfio_close() safe, there is also a g_free() on this one.
Oh yes, got it.

Thank you for the review.

Best Regards

Eric
> 
> Fam
> 
>>
>> Thanks
>>
>> Eric
>>>
>>>> +    s->nb_iova_ranges = 0;
>>>> +    g_free(iommu_info);
>>>>      close(s->group);
>>>>  fail_container:
>>>>      close(s->container);
>>>> @@ -716,6 +785,8 @@ void qemu_vfio_close(QEMUVFIOState *s)
>>>>          qemu_vfio_undo_mapping(s, &s->mappings[i], NULL);
>>>>      }
>>>>      ram_block_notifier_remove(&s->ram_notifier);
>>>> +    g_free(s->usable_iova_ranges);
>>>> +    s->nb_iova_ranges = 0;
>>>>      qemu_vfio_reset(s);
>>>>      close(s->device);
>>>>      close(s->group);
>>>> -- 
>>>> 2.21.3
>>>>
>>>>
>>>
>>> Fam
>>>
>>
>>
> 


