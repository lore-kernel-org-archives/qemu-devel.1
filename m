Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2879DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7CE82067C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqTN1xMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CE82067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Fud-0004Oi-6m
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 05:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3Fu0-0003sQ-Nc
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 05:40:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26923
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3Fty-0006Tn-Jg
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 05:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596620401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=1TMU2QWWRl0/M//JWvz5lze8cAODpRahtKoJJZYVOoQ=;
 b=TqTN1xMGVKB47Qa7dL8V06v1F4VT0fgmHthFznsoMj8PBXgAO1nCui15poMMlXT9AiS/5b
 8ZCJjbKEqw+QH//GHSrO9hy7cT2e1GKfI3Ola0BOoLvKSajCVKKY4OLqEQY2wtS/ZGsdtQ
 Fv5irrkBFOLfHYQhWQTORX38wycnr/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-FTUNp7KxN0WsLBwfuX_-Zw-1; Wed, 05 Aug 2020 05:39:59 -0400
X-MC-Unique: FTUNp7KxN0WsLBwfuX_-Zw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 809151005504;
 Wed,  5 Aug 2020 09:39:58 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-142.ams2.redhat.com [10.36.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41AD48AC08;
 Wed,  5 Aug 2020 09:39:56 +0000 (UTC)
Subject: Re: [PATCH for-5.2 5/6] pc-bios/s390-ccw: Scan through all boot
 devices if none has been specified
To: Cornelia Huck <cohuck@redhat.com>
References: <20200728183734.7838-1-thuth@redhat.com>
 <20200728183734.7838-6-thuth@redhat.com>
 <20200805113633.2822d28d.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <706af164-8e74-cba0-df37-55fb9baedb27@redhat.com>
Date: Wed, 5 Aug 2020 11:39:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200805113633.2822d28d.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 01:46:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/08/2020 11.36, Cornelia Huck wrote:
> On Tue, 28 Jul 2020 20:37:33 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> If no boot device has been specified (via "bootindex=..."), the s390-ccw
>> bios scans through all devices to find a bootable device. But so far, it
>> stops at the very first block device (including virtio-scsi controllers
>> without attached devices) that it finds, no matter whether it is bootable
>> or not. That leads to some weird situatation where it is e.g. possible
>> to boot via:
>>
>>  qemu-system-s390x -hda /path/to/disk.qcow2
>>
>> but not if there is e.g. a virtio-scsi controller specified before:
>>
>>  qemu-system-s390x -device virtio-scsi -hda /path/to/disk.qcow2
>>
>> While using "bootindex=..." is clearly the preferred way of booting
>> on s390x, we still can make the life for the users at least a little
>> bit easier if we look at all available devices to find a bootable one.
>>
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1846975
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  pc-bios/s390-ccw/main.c | 46 +++++++++++++++++++++++++++--------------
>>  1 file changed, 31 insertions(+), 15 deletions(-)
> 
> (...)
> 
>>  int main(void)
>>  {
>>      sclp_setup();
>>      css_setup();
>>      boot_setup();
>> -    find_boot_device();
>> -    enable_subchannel(blk_schid);
>> -    ipl_boot_device();
>> +    if (have_iplb) {
>> +        find_boot_device();
>> +        enable_subchannel(blk_schid);
>> +        ipl_boot_device();
>> +    } else {
>> +        probe_boot_device();
>> +    }
> 
> The one thing that's a bit surprising with the code is that
> enable_subchannel() sticking out now. The code looking for a boot
> device does that for all subchannels it looks at... but I think
> find_boot_device() did that for specified devices already as well, so
> it seems redundant?
> 
> Anyway, that's something that can be looked at later.

Yes, I noticed that, too ... but yes, one clean-up step at a time. I've
put it on my todo-list for later.

>>  
>>      panic("Failed to load OS from hard disk\n");
>>      return 0; /* make compiler happy */
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thanks!

 Thomas



