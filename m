Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A41AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 03:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F02206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 03:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N521Xa8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F02206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1LoS-0002EN-Dx
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 23:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k1Lns-0001o2-Ki
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 23:33:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35360
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k1Lnq-0002zr-8A
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 23:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596166428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/9ua6Rm2RK8h2W3ABTYLWZnU/mmGLn2TKWuvv9ktXzQ=;
 b=N521Xa8pwd7GrVe/LvHFKVRn7tGA6U5j2SbSuK+btR9XgDve+D9tbLqN5Uhr6ogvbwbHWN
 YKv8+4Yh1oOzFgFjy7im1sDl7jSqme+dbYVvFunq/OsSNCjn6o04fRDLJcP5qxRWPsXCHs
 5mHmA5jem21lLE94joiCRoEJcplrKOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-0qtElWasMxGXAbEHhALf4Q-1; Thu, 30 Jul 2020 23:33:47 -0400
X-MC-Unique: 0qtElWasMxGXAbEHhALf4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF33D19253C3;
 Fri, 31 Jul 2020 03:33:45 +0000 (UTC)
Received: from [10.72.13.197] (ovpn-13-197.pek2.redhat.com [10.72.13.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EC3260BE2;
 Fri, 31 Jul 2020 03:33:43 +0000 (UTC)
Subject: Re: [PATCH 1/2] hw/net/net_tx_pkt: add function to check
 pkt->max_raw_frags
To: Mauro Matteo Cascella <mcascell@redhat.com>
References: <20200727170838.1101775-1-mcascell@redhat.com>
 <20200727170838.1101775-2-mcascell@redhat.com>
 <adb52967-d2b2-cb55-87a2-38fda18a2a0a@redhat.com>
 <CAA8xKjXagrLU+DVcO3uVw6D0sJHXQ_rOd0nqEHHNcaMwG6oXRA@mail.gmail.com>
 <3672bcc5-329f-0cc6-a505-e5b21a316a20@redhat.com>
 <CAA8xKjWoyTPEbW=xdKqtTHHn2krKssif9t6nEeWGDQLt7KmCvg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4f6c065e-de0c-4fe3-f4aa-8e98a48d2650@redhat.com>
Date: Fri, 31 Jul 2020 11:33:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAA8xKjWoyTPEbW=xdKqtTHHn2krKssif9t6nEeWGDQLt7KmCvg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 23:33:48
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, ziming zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/31 上午1:05, Mauro Matteo Cascella wrote:
> On Thu, Jul 30, 2020 at 7:28 AM Jason Wang<jasowang@redhat.com>  wrote:
>> On 2020/7/29 上午12:26, Mauro Matteo Cascella wrote:
>>> On Tue, Jul 28, 2020 at 6:06 AM Jason Wang<jasowang@redhat.com>  wrote:
>>>> On 2020/7/28 上午1:08, Mauro Matteo Cascella wrote:
>>>>> This patch introduces a new function in hw/net/net_tx_pkt.{c,h} to check the
>>>>> current data fragment against the maximum number of data fragments.
>>>> I wonder whether it's better to do the check in
>>>> net_tx_pkt_add_raw_fragment() and fail there.
>>> Given the assertion, I assumed the caller is responsible for the
>>> check, but moving the check in net_tx_pkt_add_raw_fragment() totally
>>> makes sense to me.
>> Want to send a new version for this?
> Sure, I'll send a new version. Thank you.
>
>>>> Btw, I find net_tx_pkt_add_raw_fragment() does not unmap dma when
>>>> returning to true, is this a bug?
>>> Isn't it unmapped in net_tx_pkt_reset()?
>> Probably but see how it was used in e1000e, the net_tx_pkt_reset() is
>> only called when eop is set. Is this a bug?
> Yeah it all depends on E1000_TXD_CMD_EOP. Besides, if not set,
> e1000e_tx_pkt_send() would never be called. Honestly, I don't know if
> this is a reasonable scenario or not.


It's probably fine since anyway e1000e_core_reset() will call 
net_tx_pkt_reset().

Thanks


>
>> Thanks
>>


