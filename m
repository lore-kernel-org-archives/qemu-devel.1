Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165F1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A2425586
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKF4Q+Zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A2425586
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpwLl-0002My-Rx
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 12:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jpwJZ-00088D-9Q
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:07:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41523
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jpwJW-0001F2-V6
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593446842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1RUjCRhevL2zAXTNHhXMVe/TEVDzo4LmxrUJ3FGbQE=;
 b=JKF4Q+Zc84PQbiDGYhk8PgPiUzjkbxL0/V1/L4ZHaT31pch3zy821pzg5RBl92WUF2GH4N
 Eb6k3tGtjrAYRr4li4deHKVYMKLwhFgEfv39nvQFpoAieptupB2Ooojkij6l1qyQMhAh2C
 xFk8bg/Wq3B0EbfkMQoOwvWt2XmUFGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-aMeOycNjPli-qJDzElQsqA-1; Mon, 29 Jun 2020 12:07:19 -0400
X-MC-Unique: aMeOycNjPli-qJDzElQsqA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAE9718FE868;
 Mon, 29 Jun 2020 16:07:18 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3AA25C1B2;
 Mon, 29 Jun 2020 16:07:11 +0000 (UTC)
Subject: Re: [PULL 05/14] qapi: add unplug primary event
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20191029225932.14585-1-mst@redhat.com>
 <20191029225932.14585-6-mst@redhat.com>
 <d3ad5752-47b9-a991-83cb-e6e1780e9d6a@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <72f0fd95-4367-1b60-6681-f74259008d14@redhat.com>
Date: Mon, 29 Jun 2020 11:07:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <d3ad5752-47b9-a991-83cb-e6e1780e9d6a@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:37:37
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jens Freimann <jfreimann@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 11:05 AM, Eric Blake wrote:
> On 10/29/19 6:00 PM, Michael S. Tsirkin wrote:
>> From: Jens Freimann <jfreimann@redhat.com>
>>
>> This event is emitted when we sent a request to unplug a
>> failover primary device from the Guest OS and it includes the
>> device id of the primary device.
>>
>> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>> Message-Id: <20191029114905.6856-6-jfreimann@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qapi/migration.json | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
> 
>> +##
>> +# @UNPLUG_PRIMARY:
>> +#
>> +# Emitted from source side of a migration when migration state is
>> +# WAIT_UNPLUG. Device was unplugged by guest operating system.
>> +# Device resources in QEMU are kept on standby to be able to re-plug 
>> it in case
>> +# of migration failure.
>> +#
>> +# @device-id: QEMU device id of the unplugged device
>> +#
>> +# Since: 4.2
> 
> s/4.2/5.1/
> 
> I'm not sure if the pull request will be respun for other reasons; if 
> not, fixing this in a followup patch may be the way to go.

Sorry, my bad for not checking the dates.  The thread moved to the top 
of my queue due to the belated report of a Coverity incident; but I now 
see that this really was included in the tree during 4.2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


