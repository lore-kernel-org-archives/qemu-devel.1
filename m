Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E58C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544B5224D4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlJ6Xluu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544B5224D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIZzF-0005iQ-Bm
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kIZvN-0002Te-6i
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:04:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kIZvF-0005Tb-H3
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600272279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLa5bw1GcCI7RE2LQpwcOYLfofLwOTikWmuG3Qk2KAI=;
 b=XlJ6Xluu+yVzgPGLEi8lXFPcLCa2aW2GSgZShFw4CvmjkhbHT51YlMWhL6ybT4zgTXgvly
 GGGzY4pj1SaoS0Z/fBYGPDRF6BZiaUqke6YFgN5SJa3HTbjaz9vUBJoX4GzP4YEPRfYPY9
 y2lPAfiXFZNQl3noycgIYZyspOl6+7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-8ebWZnfkOb-1I2Y_YOFGQg-1; Wed, 16 Sep 2020 12:04:36 -0400
X-MC-Unique: 8ebWZnfkOb-1I2Y_YOFGQg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A28FAD6B7
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 16:04:18 +0000 (UTC)
Received: from [10.3.113.91] (ovpn-113-91.phx2.redhat.com [10.3.113.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1821B75141;
 Wed, 16 Sep 2020 16:04:18 +0000 (UTC)
Subject: Re: [PATCH 9/9] vhost-vdpa: allow pre-opend file descriptor
To: Cindy Lu <lulu@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20200831082737.10983-1-jasowang@redhat.com>
 <20200831082737.10983-10-jasowang@redhat.com>
 <CACLfguWu6fu3_PkfcTLZriTk=BqWk4a+=myfH+cFpQuHLu0koQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <29454777-87fa-c42c-122b-bef4fd708464@redhat.com>
Date: Wed, 16 Sep 2020 11:04:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CACLfguWu6fu3_PkfcTLZriTk=BqWk4a+=myfH+cFpQuHLu0koQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/31/20 6:16 AM, Cindy Lu wrote:
> On Mon, 31 Aug 2020 at 16:30, Jason Wang <jasowang@redhat.com> wrote:
>>
>> This patch allows to initialize vhost-vdpa network backend with pre
>> opened vhost-vdpa file descriptor. This is useful for running
>> unprivileged qemu through libvirt.
>>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---

>> +++ b/qapi/net.json
>> @@ -442,12 +442,15 @@
>>   # @queues: number of queues to be created for multiqueue vhost-vdpa
>>   #          (default: 1)
>>   #
>> +# @fd: file descriptor of an already opened vhost-vdpa (since 5.2)
>> +#
>>   # Since: 5.1
>>   ##
>>   { 'struct': 'NetdevVhostVDPAOptions',
>>     'data': {
>>       '*vhostdev':     'str',
>> -    '*queues':       'int' } }
>> +    '*queues':       'int',
>> +    '*fd':           'str' } }
>>
>>   ##
>>   # @NetClientDriver:
>> --
>> 2.20.1
>>
> I think the latest  code supported this part.
> you can pass a pre open file descriptor to it via the add-fd QMP
> command to /dev/fdset/NNN, and then pass the string
> "/dev/fdset/NNN" as vhostdev.  so we don't need a special fd parameter here.

Correct - the 'vhostdev' parameter + magic filename is all the more that 
is needed to access a pre-opened fd, so no 'fd' parameter should be added.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


