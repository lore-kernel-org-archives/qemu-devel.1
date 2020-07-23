Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1D2C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 02:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4785120714
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 02:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ftda+2X9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4785120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyQwY-00008O-Hd
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 22:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jyQvh-00088T-GK
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 22:25:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46792
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jyQvf-0001V3-VL
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 22:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595471151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MqRG2yEe3VMNLKbkwyCQuqaYOx5cOXDRhH0IxUhGyr0=;
 b=Ftda+2X9/RBvEK5hUsnDYVUnm7p8vYc+KTvkqCcunGTHAzdXztRbcVVdMkPdrog702tC66
 6cNL6VrobkfpP1bSMThTPQ3qhs+9h5TBINllIoxDMA/qfrQLeEMWlxrd07emB4OzF+ZZhK
 P2JheM/82FAapbtNt/PLODzcA0UCSeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-wXJErEZZPRGenDLAUpAHpQ-1; Wed, 22 Jul 2020 22:25:47 -0400
X-MC-Unique: wXJErEZZPRGenDLAUpAHpQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74FFB800C64;
 Thu, 23 Jul 2020 02:25:46 +0000 (UTC)
Received: from [10.72.13.141] (ovpn-13-141.pek2.redhat.com [10.72.13.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B252F71D1D;
 Thu, 23 Jul 2020 02:25:36 +0000 (UTC)
Subject: Re: [PATCH 2/2] e1000e: make TX reentrant
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20200722085747.6514-1-jasowang@redhat.com>
 <20200722085747.6514-2-jasowang@redhat.com>
 <4022bb82-9c7a-cf74-8caf-03ef0989f5f8@msgid.tls.msk.ru>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7dc09488-c73c-c016-735e-8316273c3322@redhat.com>
Date: Thu, 23 Jul 2020 10:25:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4022bb82-9c7a-cf74-8caf-03ef0989f5f8@msgid.tls.msk.ru>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:14:11
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
Cc: dmitry.fleytman@gmail.com, mst@redhat.com, liq3ea@163.com, liq3ea@gmail.com,
 alxndr@bu.edu, stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/22 下午8:53, Michael Tokarev wrote:
> FWIW, this is not "making TX reentrant", it is about forbidding
> reentrancy instead :)
>
> /mjt


Indeed, I will rename the title.

Thanks


>


