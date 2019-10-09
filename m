Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8621ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B401F21848
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="LtYA24SB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B401F21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIGrq-0002Yq-8a
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrfsh@yandex-team.ru>) id 1iIBDy-0006Z6-Ce
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 08:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrfsh@yandex-team.ru>) id 1iIBDx-0004dU-4P
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 08:37:50 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:34768)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrfsh@yandex-team.ru>)
 id 1iIBDq-0004X1-K4; Wed, 09 Oct 2019 08:37:43 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id E26342E1580;
 Wed,  9 Oct 2019 15:37:37 +0300 (MSK)
Received: from iva8-b53eb3f76dc7.qloud-c.yandex.net
 (iva8-b53eb3f76dc7.qloud-c.yandex.net [2a02:6b8:c0c:2ca1:0:640:b53e:b3f7])
 by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 XcTfV1KpbP-badiLtx5; Wed, 09 Oct 2019 15:37:37 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1570624657; bh=x+izVrG0MHq7INz905kQuzRRPgcouZesc8IdmfEahrM=;
 h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
 b=LtYA24SB7cGaUwzsnAgkNHOkGnOipHYvOnTpaTi2RmWuFPAI5xMXsc2oktcJ0G0hR
 hhyU6DHqxIVlREVUvmlJ5vCoo8YJHiUxm5i4FSbPqP5QyzqOTqIuSKUOBSSohgHX34
 E3Cy1zAayC6pC/YkOgQGt8m4FsT4YKuRnwAZl5GQ=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:40c:f68c:50ff:fee9:44bd])
 by iva8-b53eb3f76dc7.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 6wDe77okZS-baHepNOo; Wed, 09 Oct 2019 15:37:36 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Subject: Re: [RFC PATCH] virtio-blk: advertise F_WCE (F_FLUSH) if F_CONFIG_WCE
 is also advertised
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <1568980590-806043-1-git-send-email-wrfsh@yandex-team.ru>
 <20191008132416.GA28104@stefanha-x1.localdomain>
From: Evgeny Yakovlev <wrfsh@yandex-team.ru>
Message-ID: <f7d2c01d-1676-f02c-e538-f924282eb6a5@yandex-team.ru>
Date: Wed, 9 Oct 2019 15:37:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008132416.GA28104@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru, qemu-block@nongnu.org,
 stefanha@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 08.10.2019 16:24, Stefan Hajnoczi wrote:
> On Fri, Sep 20, 2019 at 02:56:30PM +0300, Evgeny Yakovlev wrote:
>> Virtio spec 1.1 (and earlier), 5.2.5.1 Driver Requirements: Device
>> Initialization:
>>
>> "Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it if
>> they offer VIRTIO_BLK_F_CONFIG_WCE.
>>
>> It looks like currently F_CONFIG_WCE and F_WCE are not connected to each
>> other. qemu will advertise F_CONFIG_WCE if config-wce argument is
>> set for virtio-blk device. While F_WCE is advertised if underlying block
>> backend actually has it's caching enabled.
>> Those two things are not related to each other.
>>
>> Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>
>> ---
>>   hw/block/virtio-blk.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>> index 1885160..b45dc0c 100644
>> --- a/hw/block/virtio-blk.c
>> +++ b/hw/block/virtio-blk.c
>> @@ -990,7 +990,8 @@ static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features,
>>           virtio_add_feature(&features, VIRTIO_BLK_F_SCSI);
>>       }
>>   
>> -    if (blk_enable_write_cache(s->blk)) {
>> +    if (blk_enable_write_cache(s->blk) ||
>> +        virtio_has_feature(features, VIRTIO_BLK_F_CONFIG_WCE)) {
>>           virtio_add_feature(&features, VIRTIO_BLK_F_WCE);
>>       }
>>       if (blk_is_read_only(s->blk)) {
>> -- 
>> 2.7.4
> Sorry for the very late response.  I have been ill and am still
> recovering.


Feel better!


>
> The motivation for this change looks correct but this patch may cause
> host_features to change across live migration to a newer QEMU version.
> If the guest accesses VIRTIO_PCI_HOST_FEATURES before and after live
> migration it may see different values, which is unexpected.
>
> The safe way of introducing guest-visible changes like this is to make
> the change conditional on the machine type version so that old guests
> see old behavior and new guests see new behavior.
>
> Live migration compatibility can be guaranteed by adding a new property
> to virtio_blk_properties[]:
>
>    DEFINE_PROP_BOOL("enable-wce-if-config-wce", VirtIOBlock,
>                     conf.enable_wce_if_config_wce, true),
>
> Then tweak the patch:
>
>    if (blk_enable_write_cache(s->blk) ||
>        (s->conf.enable_wce_if_config_wce &&
>         virtio_has_feature(features, VIRTIO_BLK_F_CONFIG_WCE))) {
>
> And finally disable enable_wce_if_config_wce for older machine types to
> retain compatibility:
>
>    GlobalProperty hw_compat_4_2[] = {
>        { "virtio-blk-device", "enable-wce-if-config-wce", "off" },
>    };
>
> (I have omitted some steps like defining
> VirtIOBlkConf.enable_wce_if_config_wce field and hooking up
> hw_compat_4_2[], but you can figure that out from the existing code.)


Why don't we just migrate host_features? That will ensure they are the 
same. And messing up device config on destination is bad anyway.


>
> Stefan




