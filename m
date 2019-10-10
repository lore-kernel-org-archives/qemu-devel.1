Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73EFC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F7820659
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="qwSWSFuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F7820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXfg-0000JI-G8
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrfsh@yandex-team.ru>) id 1iIWzj-0000Pc-8D
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrfsh@yandex-team.ru>) id 1iIWzi-0002uV-1j
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:52:35 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:39930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrfsh@yandex-team.ru>)
 id 1iIWzc-0002tM-8K; Thu, 10 Oct 2019 07:52:28 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 707B62E1578;
 Thu, 10 Oct 2019 14:52:25 +0300 (MSK)
Received: from vla5-2bf13a090f43.qloud-c.yandex.net
 (vla5-2bf13a090f43.qloud-c.yandex.net [2a02:6b8:c18:3411:0:640:2bf1:3a09])
 by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 HqxQxhIpyw-qNNas7UG; Thu, 10 Oct 2019 14:52:25 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1570708345; bh=n8d1EfRwLJRLompx3SGj1zAW2Zon4sDNFkSfnJ/XMx4=;
 h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
 b=qwSWSFuyfEbXt0ZEKl/u3ZOb/1ZSdleIhzMpbLmLPAH/6isEonhYmjHaZhD9gZqNY
 y8zC+iVJDpyaGZUhjrHgTiT+HDlxzaM4vj1rylxypQbTDx5kYnTXPM+OSDFqirxtGl
 /moQhbNOHu53SEGPgE/1JoxeHTZd+ZV1MK3pEzpE=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:40c:f68c:50ff:fee9:44bd])
 by vla5-2bf13a090f43.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 I9ZlwBsChN-qNHWM4Ac; Thu, 10 Oct 2019 14:52:23 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Subject: Re: [RFC PATCH] virtio-blk: advertise F_WCE (F_FLUSH) if F_CONFIG_WCE
 is also advertised
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
References: <1568980590-806043-1-git-send-email-wrfsh@yandex-team.ru>
 <20191008132416.GA28104@stefanha-x1.localdomain>
 <20191009151337-mutt-send-email-mst@kernel.org>
From: Evgeny Yakovlev <wrfsh@yandex-team.ru>
Message-ID: <acfd6a7e-1a8a-b8c2-400b-a6af8e38ca0e@yandex-team.ru>
Date: Thu, 10 Oct 2019 14:52:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009151337-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 77.88.29.217
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yc-core@yandex-team.ru, qemu-block@nongnu.org, stefanha@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09.10.2019 22:14, Michael S. Tsirkin wrote:
> On Tue, Oct 08, 2019 at 02:24:16PM +0100, Stefan Hajnoczi wrote:
>> On Fri, Sep 20, 2019 at 02:56:30PM +0300, Evgeny Yakovlev wrote:
>>> Virtio spec 1.1 (and earlier), 5.2.5.1 Driver Requirements: Device
>>> Initialization:
>>>
>>> "Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it if
>>> they offer VIRTIO_BLK_F_CONFIG_WCE.
>>>
>>> It looks like currently F_CONFIG_WCE and F_WCE are not connected to each
>>> other. qemu will advertise F_CONFIG_WCE if config-wce argument is
>>> set for virtio-blk device. While F_WCE is advertised if underlying block
>>> backend actually has it's caching enabled.
>>> Those two things are not related to each other.
>>>
>>> Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>
>>> ---
>>>   hw/block/virtio-blk.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>>> index 1885160..b45dc0c 100644
>>> --- a/hw/block/virtio-blk.c
>>> +++ b/hw/block/virtio-blk.c
>>> @@ -990,7 +990,8 @@ static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features,
>>>           virtio_add_feature(&features, VIRTIO_BLK_F_SCSI);
>>>       }
>>>   
>>> -    if (blk_enable_write_cache(s->blk)) {
>>> +    if (blk_enable_write_cache(s->blk) ||
>>> +        virtio_has_feature(features, VIRTIO_BLK_F_CONFIG_WCE)) {
>>>           virtio_add_feature(&features, VIRTIO_BLK_F_WCE);
>>>       }
>>>       if (blk_is_read_only(s->blk)) {
>>> -- 
>>> 2.7.4
>> Sorry for the very late response.  I have been ill and am still
>> recovering.
>>
>> The motivation for this change looks correct but this patch may cause
>> host_features to change across live migration to a newer QEMU version.
>> If the guest accesses VIRTIO_PCI_HOST_FEATURES before and after live
>> migration it may see different values, which is unexpected.
>>
>> The safe way of introducing guest-visible changes like this is to make
>> the change conditional on the machine type version so that old guests
>> see old behavior and new guests see new behavior.
>>
>> Live migration compatibility can be guaranteed by adding a new property
>> to virtio_blk_properties[]:
>>
>>    DEFINE_PROP_BOOL("enable-wce-if-config-wce", VirtIOBlock,
>>                     conf.enable_wce_if_config_wce, true),
>
> is this a useful thing for users to control?
> If not we don't need to make this property part of
> the stable API - blacklist it by prefixing x- to the name:
> x-enable-wce-if-config-wce
>
>> Then tweak the patch:
>>
>>    if (blk_enable_write_cache(s->blk) ||
>>        (s->conf.enable_wce_if_config_wce &&
>>         virtio_has_feature(features, VIRTIO_BLK_F_CONFIG_WCE))) {
>>
>> And finally disable enable_wce_if_config_wce for older machine types to
>> retain compatibility:
>>
>>    GlobalProperty hw_compat_4_2[] = {
>>        { "virtio-blk-device", "enable-wce-if-config-wce", "off" },
>>    };
>>
>> (I have omitted some steps like defining
>> VirtIOBlkConf.enable_wce_if_config_wce field and hooking up
>> hw_compat_4_2[], but you can figure that out from the existing code.)
>>
>> Stefan
>
Thanks, will do as you guys both suggested.



