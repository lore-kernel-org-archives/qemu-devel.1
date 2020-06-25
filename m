Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9DCC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 05:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AAC320709
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 05:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eA+irAK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AAC320709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joKoR-0000As-GN
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 01:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joKne-0007Gn-1i
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 01:51:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20925
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joKnZ-0005mC-8M
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 01:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593064304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UbuHHAPAMR4xlyB7J3QyXIJlrJTtGqpzW/1S2hywvUk=;
 b=eA+irAK7OrXcA1XoLt/yu+VwWtwep/naKEYwIkcEOUASJpT4rUgVtzwr89m6GCHw3WwPLT
 rrI/bi9ydUqyOchId0+6xfEOspRpLYqWjMiO2gZA4siK1nejhhls7U5B9hfb0tX/ROXsUA
 vQqy5eEfszJ8MxFpMAfypLMi1/zDfoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-HHs6AaqiND63-F-Wh_Efrw-1; Thu, 25 Jun 2020 01:51:42 -0400
X-MC-Unique: HHs6AaqiND63-F-Wh_Efrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C091464;
 Thu, 25 Jun 2020 05:51:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 736515BAC7;
 Thu, 25 Jun 2020 05:51:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 87C7B11384D4; Thu, 25 Jun 2020 07:51:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v25 17/17] qapi: Add VFIO devices migration stats in
 Migration stats
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
 <1592684486-18511-18-git-send-email-kwankhede@nvidia.com>
 <87zh8ucknj.fsf@dusky.pond.sub.org>
 <fa9c879c-f062-7589-231c-b34fb0a107a7@nvidia.com>
Date: Thu, 25 Jun 2020 07:51:30 +0200
In-Reply-To: <fa9c879c-f062-7589-231c-b34fb0a107a7@nvidia.com> (Kirti
 Wankhede's message of "Wed, 24 Jun 2020 02:46:39 +0530")
Message-ID: <87eeq34rrx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
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
Cc: cohuck@redhat.com, cjia@nvidia.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 dgilbert@redhat.com, alex.williamson@redhat.com, changpeng.liu@intel.com,
 eskultet@redhat.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kirti Wankhede <kwankhede@nvidia.com> writes:

> On 6/23/2020 12:51 PM, Markus Armbruster wrote:
>> QAPI review only.
>>
>> The only changes since I reviewed v23 is the rename of VfioStats member
>> @bytes to @transferred, and the move of MigrationInfo member @vfio next
>> to @ram and @disk.  Good.  I'm copying my other questions in the hope of
>> getting answers :)
>>
>> Kirti Wankhede <kwankhede@nvidia.com> writes:
>>
>>> Added amount of bytes transferred to the target VM by all VFIO devices
>>>
>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> [...]
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index d5000558c6c9..952864b05455 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -146,6 +146,18 @@
>>>               'active', 'postcopy-active', 'postcopy-paused',
>>>               'postcopy-recover', 'completed', 'failed', 'colo',
>>>               'pre-switchover', 'device', 'wait-unplug' ] }
>>> +##
>>> +# @VfioStats:
>>> +#
>>> +# Detailed VFIO devices migration statistics
>>> +#
>>> +# @transferred: amount of bytes transferred to the target VM by VFIO devices
>>> +#
>>> +# Since: 5.1
>>> +#
>>> +##
>>> +{ 'struct': 'VfioStats',
>>> +  'data': {'transferred': 'int' } }
>>
>> Pardon my ignorance...  What exactly do VFIO devices transfer to the
>> target VM? How is that related to MigrationInfo member @ram? 
>>
>
> Sorry I missed to reply your question on earlier version.

Happens :)

> VFIO device transfer vfio device's state, data from VFIO device and
> guest memory pages pinned for dma operation.
> For example in case of GPU, vfio device state is GPUs current state to
> be saved that will be restored during resume and device data is data
> from onboard framebuffer. Pinned memory is marked dirty and
> transferred to target VM as part of global dirty page tracking for
> RAM.
> VFIO device can add significant amount of data in migration stream
> (depending on FB size in GB), transferred byte count is important
> parameter to be monitored.

Can we work this into documentation somehow?

Have you considered adding something on VFIO migration to docs/?  Then a
link with a short description could suffice here.

>> MigrationStats has much more information, and some of it is pretty
>> useful to track how migration is doing, in particular whether it
>> converges, and how fast.  Absent in VfioStats due to "not implemented",
>> or due to "can't be done"?
>>
>
> Vfio device migration interface is same as RAM's migration interface
> (using SaveVMHandlers). Converge part is already take care by
> .save_live_pending hook where *res_precopy_only is set to vfio devices
> pending_bytes, migration->pending_bytes
>
> How fast - I'm not sure how this can be calculated.

My concern is providing management applications the means they need to
monitor migration.  Have you solicited input from management application
developers on what's needed?

"Same as RAM's migration" makes me suspect the same stats are needed.
This may well be a subset of the stats provided for RAM.

Missing stats we need can be added on top, as long as it's done in a
timely manner.  But we better know how to compute them, or how to do
without.

> Thanks,
> Kirti
>
>> Byte counts should use QAPI type 'size'.  Many existing ones don't.
>> Since MigrationStats uses 'int', I'll let the migration maintainers
>> decide whether they want 'int' or 'size' here.
>>
>>>   ##
>>>   # @MigrationInfo:
>>> @@ -207,11 +219,16 @@
>>>   #
>>>   # @socket-address: Only used for tcp, to know what the real port is (Since 4.0)
>>>   #
>>> +# @vfio: @VfioStats containing detailed VFIO devices migration statistics,
>>> +#        only returned if VFIO device is present, migration is supported by all
>>> +#         VFIO devices and status is 'active' or 'completed' (since 5.1)
>>> +#
>>>   # Since: 0.14.0
>>>   ##
>>>   { 'struct': 'MigrationInfo',
>>>     'data': {'*status': 'MigrationStatus', '*ram': 'MigrationStats',
>>>              '*disk': 'MigrationStats',
>>> +           '*vfio': 'VfioStats',
>>>              '*xbzrle-cache': 'XBZRLECacheStats',
>>>              '*total-time': 'int',
>>>              '*expected-downtime': 'int',
>>


