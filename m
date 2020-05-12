Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCB0C54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24159206D3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGCgt1gK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24159206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYLg6-0004Wt-99
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 23:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jYLfP-0003oR-3p
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:33:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34499
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jYLfO-0000s8-4j
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589254392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KWmev34QIa4MWciuTXTvFJdKfdnyJ8lv9QcY8R2HrvY=;
 b=dGCgt1gKUovyoFaBVHjr6rYZHQLgru4BMvsVvEurKR3WVxXO3yOI5Kdx1qB7dXdOQPoBp2
 EJ0zdlGF0TBZjYJyIuowpiINecYPkZk/Dar3yEujomBfEXNZnJBu/pbSqufwhkaoJcKAYi
 HNOiWEQ2OquLONoFjtAkG5UyZ2j5Wfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-kG1th5crM9Wsz0V9TDN7sQ-1; Mon, 11 May 2020 23:33:07 -0400
X-MC-Unique: kG1th5crM9Wsz0V9TDN7sQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E9AA107ACCA;
 Tue, 12 May 2020 03:33:05 +0000 (UTC)
Received: from [10.72.13.96] (ovpn-13-96.pek2.redhat.com [10.72.13.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B0505D9DC;
 Tue, 12 May 2020 03:32:51 +0000 (UTC)
Subject: Re: [PATCH v2 5/5] vhost: add device started check in migration set
 log
To: Dima Stepanov <dimastep@yandex-team.ru>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <d25241eb1fe7a55fc7dbe63ecedb4f1adf407837.1588252862.git.dimastep@yandex-team.ru>
 <ed805147-d87d-5ac2-3196-367981b0679c@redhat.com>
 <20200511092541.GA27558@dimastep-nix>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fd260f1f-75f3-46ac-8ca5-bbb7e41e712f@redhat.com>
Date: Tue, 12 May 2020 11:32:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511092541.GA27558@dimastep-nix>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 23:09:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, stefanha@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, arei.gonglei@huawei.com, fengli@smartx.com,
 yc-core@yandex-team.ru, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 raphael.norwitz@nutanix.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/11 下午5:25, Dima Stepanov wrote:
> On Mon, May 11, 2020 at 11:15:53AM +0800, Jason Wang wrote:
>> On 2020/4/30 下午9:36, Dima Stepanov wrote:
>>> If vhost-user daemon is used as a backend for the vhost device, then we
>>> should consider a possibility of disconnect at any moment. If such
>>> disconnect happened in the vhost_migration_log() routine the vhost
>>> device structure will be clean up.
>>> At the start of the vhost_migration_log() function there is a check:
>>>    if (!dev->started) {
>>>        dev->log_enabled = enable;
>>>        return 0;
>>>    }
>>> To be consistent with this check add the same check after calling the
>>> vhost_dev_set_log() routine. This in general help not to break a
>>> migration due the assert() message. But it looks like that this code
>>> should be revised to handle these errors more carefully.
>>>
>>> In case of vhost-user device backend the fail paths should consider the
>>> state of the device. In this case we should skip some function calls
>>> during rollback on the error paths, so not to get the NULL dereference
>>> errors.
>>>
>>> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
>>> ---
>>>   hw/virtio/vhost.c | 39 +++++++++++++++++++++++++++++++++++----
>>>   1 file changed, 35 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>> index 3ee50c4..d5ab96d 100644
>>> --- a/hw/virtio/vhost.c
>>> +++ b/hw/virtio/vhost.c
>>> @@ -787,6 +787,17 @@ static int vhost_dev_set_features(struct vhost_dev *dev,
>>>   static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
>>>   {
>>>       int r, i, idx;
>>> +
>>> +    if (!dev->started) {
>>> +        /*
>>> +         * If vhost-user daemon is used as a backend for the
>>> +         * device and the connection is broken, then the vhost_dev
>>> +         * structure will be reset all its values to 0.
>>> +         * Add additional check for the device state.
>>> +         */
>>> +        return -1;
>>> +    }
>>> +
>>>       r = vhost_dev_set_features(dev, enable_log);
>>>       if (r < 0) {
>>>           goto err_features;
>>> @@ -801,12 +812,19 @@ static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
>>>       }
>>>       return 0;
>>>   err_vq:
>>> -    for (; i >= 0; --i) {
>>> +    /*
>>> +     * Disconnect with the vhost-user daemon can lead to the
>>> +     * vhost_dev_cleanup() call which will clean up vhost_dev
>>> +     * structure.
>>> +     */
>>> +    for (; dev->started && (i >= 0); --i) {
>>>           idx = dev->vhost_ops->vhost_get_vq_index(
>>
>> Why need the check of dev->started here, can started be modified outside
>> mainloop? If yes, I don't get the check of !dev->started in the beginning of
>> this function.
>>
> No dev->started can't change outside the mainloop. The main problem is
> only for the vhost_user_blk daemon. Consider the case when we
> successfully pass the dev->started check at the beginning of the
> function, but after it we hit the disconnect on the next call on the
> second or third iteration:
>       r = vhost_virtqueue_set_addr(dev, dev->vqs + i, idx, enable_log);
> The unix socket backend device will call the disconnect routine for this
> device and reset the structure. So the structure will be reset (and
> dev->started set to false) inside this set_addr() call.


I still don't get here. I think the disconnect can not happen in the 
middle of vhost_dev_set_log() since both of them were running in 
mainloop. And even if it can, we probably need other synchronization 
mechanism other than simple check here.


>   So
> we shouldn't call the clean up calls because this virtqueues were clean
> up in the disconnect call. But we should protect these calls somehow, so
> it will not hit SIGSEGV and we will be able to pass migration.
>
> Just to summarize it:
> For the vhost-user-blk devices we ca hit clean up calls twice in case of
> vhost disconnect:
> 1. The first time during the disconnect process. The clean up is called
> inside it.
> 2. The second time during roll back clean up.
> So if it is the case we should skip p2.
>
>>> dev, dev->vq_index + i);
>>>           vhost_virtqueue_set_addr(dev, dev->vqs + i, idx,
>>>                                    dev->log_enabled);
>>>       }
>>> -    vhost_dev_set_features(dev, dev->log_enabled);
>>> +    if (dev->started) {
>>> +        vhost_dev_set_features(dev, dev->log_enabled);
>>> +    }
>>>   err_features:
>>>       return r;
>>>   }
>>> @@ -832,7 +850,15 @@ static int vhost_migration_log(MemoryListener *listener, int enable)
>>>       } else {
>>>           vhost_dev_log_resize(dev, vhost_get_log_size(dev));
>>>           r = vhost_dev_set_log(dev, true);
>>> -        if (r < 0) {
>>> +        /*
>>> +         * The dev log resize can fail, because of disconnect
>>> +         * with the vhost-user-blk daemon. Check the device
>>> +         * state before calling the vhost_dev_set_log()
>>> +         * function.
>>> +         * Don't return error if device isn't started to be
>>> +         * consistent with the check above.
>>> +         */
>>> +        if (dev->started && r < 0) {
>>>               return r;
>>>           }
>>>       }
>>> @@ -1739,7 +1765,12 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
>>>   fail_log:
>>>       vhost_log_put(hdev, false);
>>>   fail_vq:
>>> -    while (--i >= 0) {
>>> +    /*
>>> +     * Disconnect with the vhost-user daemon can lead to the
>>> +     * vhost_dev_cleanup() call which will clean up vhost_dev
>>> +     * structure.
>>> +     */
>>> +    while ((--i >= 0) && (hdev->started)) {
>>>           vhost_virtqueue_stop(hdev,
>>>                                vdev,
>>>                                hdev->vqs + i,
>>
>> This should be a separate patch.
> Do you mean i should split this patch to two patches?


Yes.

Thanks


>
> Thanks.
>
>> Thanks
>>


