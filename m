Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAB2C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 863D02087D
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RinG3r9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863D02087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD0BD-0006VS-Mp
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 02:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kD0Ah-00066I-HX
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 02:53:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kD0Ae-0004iI-V4
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 02:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598943211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VO6WD2okG4vgcpHtzIlAs7RCj9hgC/FAm6u6dJYIVk8=;
 b=RinG3r9VRZ5TQ2+OHmEWTseiLusMk/+/I7E7hrFrj9ZGbsF9D3M30cOvcnNq2QHdSlE4kP
 RR4aCvmUqc5MLr0zV+ftXKXuvkoHQFBIUkbnWehvTKjc5IOA8GjpG/5HFgIhvF7h1fK0LL
 2HiIzaNhURq1kUCaGme5oprUlaFrIEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-d7lCF0vXMSaB010CXbClfA-1; Tue, 01 Sep 2020 02:53:29 -0400
X-MC-Unique: d7lCF0vXMSaB010CXbClfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 161BB1007460
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2020 06:53:28 +0000 (UTC)
Received: from [10.72.13.164] (ovpn-13-164.pek2.redhat.com [10.72.13.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 24E015C1A3;
 Tue,  1 Sep 2020 06:53:16 +0000 (UTC)
Subject: Re: [PATCH 9/9] vhost-vdpa: allow pre-opend file descriptor
To: Cindy Lu <lulu@redhat.com>
References: <20200831082737.10983-1-jasowang@redhat.com>
 <20200831082737.10983-10-jasowang@redhat.com>
 <CACLfguWu6fu3_PkfcTLZriTk=BqWk4a+=myfH+cFpQuHLu0koQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <38fa0f43-e628-d824-cb76-0a91fd9817b7@redhat.com>
Date: Tue, 1 Sep 2020 14:53:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACLfguWu6fu3_PkfcTLZriTk=BqWk4a+=myfH+cFpQuHLu0koQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 01:27:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Michael Tsirkin <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/8/31 下午7:16, Cindy Lu wrote:
> On Mon, 31 Aug 2020 at 16:30, Jason Wang <jasowang@redhat.com> wrote:
>> This patch allows to initialize vhost-vdpa network backend with pre
>> opened vhost-vdpa file descriptor. This is useful for running
>> unprivileged qemu through libvirt.
>>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   net/vhost-vdpa.c | 24 +++++++++++++++++++-----
>>   qapi/net.json    |  5 ++++-
>>   2 files changed, 23 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 9a6f0b63d3..f6385cd264 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -206,20 +206,34 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
>>                             (char *)name, errp)) {
>>           return -1;
>>       }
>> -    if (!opts->has_vhostdev) {
>> -        error_setg(errp, "vhost-vdpa requires vhostdev to be set");
>> +    if (!(opts->has_vhostdev ^ opts->has_fd)) {
>> +        error_setg(errp, "Vhost-vdpa requires either vhostdev or fd to be set");
>>           return -1;
>>       }
>>
>>       assert(name);
>>
>>       nc = qemu_new_net_client(&net_vhost_vdpa_info, peer, TYPE_VHOST_VDPA, name);
>> -    snprintf(nc->info_str, sizeof(nc->info_str), "vhostdev=%s", opts->vhostdev);
>> +    if (opts->has_vhostdev) {
>> +        snprintf(nc->info_str, sizeof(nc->info_str),
>> +                 "vhostdev=%s", opts->vhostdev);
>> +        vdpa_device_fd = qemu_open(opts->vhostdev, O_RDWR);
>> +        if (vdpa_device_fd == -1) {
>> +            error_setg(errp, "Fail to open vhost-vdpa device %s",
>> +                       opts->vhostdev);
>> +            return -errno;
>> +        }
>> +    } else {
>> +        snprintf(nc->info_str, sizeof(nc->info_str), "fd=%s", opts->fd);
>> +        vdpa_device_fd = monitor_fd_param(cur_mon, opts->fd, errp);
>> +        if (vdpa_device_fd == -1) {
>> +            return -1;
>> +        }
>> +    }
>>
>>       s = DO_UPCAST(VhostVDPAState, nc, nc);
>> -    vdpa_device_fd = qemu_open(opts->vhostdev, O_RDWR);
>>       if (vdpa_device_fd == -1) {
>> -        error_setg(errp, "Fail to open vhost-vdpa device %s", opts->vhostdev);
>> +
>>           return -errno;
>>       }
>>       s->vhost_vdpa.device_fd = vdpa_device_fd;
>> diff --git a/qapi/net.json b/qapi/net.json
>> index a2a94fad3e..5ad60c3045 100644
>> --- a/qapi/net.json
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


Right, I forgot the fdset tricks.


Thanks



> Thanks
> Cindy
>
>


