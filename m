Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D4AC433ED
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C862072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="beHnoIYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C862072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02Wr-0006D9-HE
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k02V7-0004rt-Ad
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:45:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25852
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k02V5-0000nN-Lz
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595853903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54hJJjuzume9o0f4GKMQ08xt2NNQS6Qm1dtaJetAJf0=;
 b=beHnoIYIeORk+kQOVrW5/PydBcahdqNl+HJwPr7hkQbLrl9n9+wXg5eluKSJAj/OvBeFeQ
 I13lqwYMhoGSA2tjSFFlgRPtsCk0xK2YfIxrOiOKZ9sUQ8g0/GMHoz03GOM7ctQfsXc0ms
 k39jhHD7P47zhyWqNAutIQuaACWE2BI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-Vre9UYK4NBGsVeoVTszj1Q-1; Mon, 27 Jul 2020 08:45:01 -0400
X-MC-Unique: Vre9UYK4NBGsVeoVTszj1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65695E923
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 12:45:00 +0000 (UTC)
Received: from [10.72.12.71] (ovpn-12-71.pek2.redhat.com [10.72.12.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A18C726B8;
 Mon, 27 Jul 2020 12:44:50 +0000 (UTC)
Subject: Re: [PATCH] virtio-net: check the existence of peer before accesing
 its config
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200727074328.2279-1-jasowang@redhat.com>
 <20200727053954-mutt-send-email-mst@kernel.org>
 <20200727115322.4e7fe1aa.cohuck@redhat.com>
 <20200727061112-mutt-send-email-mst@kernel.org>
 <0cad868a-7f64-47e0-f4bf-014a5fc1bcf6@redhat.com>
 <20200727073943-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4ba92946-7b7f-e3af-3352-b8f780f952f4@redhat.com>
Date: Mon, 27 Jul 2020 20:44:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727073943-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/27 下午7:41, Michael S. Tsirkin wrote:
> On Mon, Jul 27, 2020 at 06:26:37PM +0800, Jason Wang wrote:
>> On 2020/7/27 下午6:13, Michael S. Tsirkin wrote:
>>> On Mon, Jul 27, 2020 at 11:53:22AM +0200, Cornelia Huck wrote:
>>>> On Mon, 27 Jul 2020 05:41:17 -0400
>>>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>>>
>>>>> On Mon, Jul 27, 2020 at 03:43:28PM +0800, Jason Wang wrote:
>>>>>> We try to get config from peer unconditionally which may lead NULL
>>>>>> pointer dereference. Add a check before trying to access the config.
>>>>>>
>>>>>> Fixes: 108a64818e69b ("vhost-vdpa: introduce vhost-vdpa backend")
>>>>>> Cc: Cindy Lu <lulu@redhat.com>
>>>>>> Tested-by: Cornelia Huck <cohuck@redhat.com>
>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>> I am a bit lost here. Isn't this invoked
>>>>> when guest attempts to read the config?
>>>>> With no peer, what do we return to guest?
>>>> Same as with a non-vdpa peer? It's the dereference that needs to be
>>>> guarded.
>>> So vdpa has a GET_CONFIG ioctl which to me hints that a peer needs to be
>>> notified on get config calls.
>>> If we return config from qemu memory here, then I guess we
>>> need to call GET_CONFIG on connect and validate it -
>>> does this make sense?
>>>
>>> Cindy, Jason?
>>
>> For "connect" you meant connecting virtio-net to its peer (vDPA)? AFAIK, if
>> we start with no peer, there's no way to set a peer afterwards.
>>
>> Thanks
>
> That would be a good sentence to add in a code comment:
>
> /*
>   * Is this VDPA? No peer means not VDPA: there's no way to
>   * disconnect/reconnect a VDPA peer.
>   */


Sure.

Thanks


>
>>>>> A code comment might be helpful here.
>>>>>
>>>>>> ---
>>>>>>    hw/net/virtio-net.c | 22 +++++++++++-----------
>>>>>>    1 file changed, 11 insertions(+), 11 deletions(-)


