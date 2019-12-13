Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920D3C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA4D21655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gtv7zyy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA4D21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifs3Y-0006Uo-Nm
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 16:01:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ifs2L-0005pg-70
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 15:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ifs2H-0007O7-OE
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 15:59:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40197
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ifs2H-0007KT-HS
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 15:59:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576270780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t/gLqqtGE8AR2CYAo6pWp3+fioKxkjQmNsG9cuqgydI=;
 b=Gtv7zyy1Izvmb6xOf93/j6WCzjg6ip6uOnXlIzG+jx/Mp42nHHU+eBPkVD+wZs17Ia1Qf9
 5oi9fueCBPy7cVsWdbU0hk57FXiwD6IvL43EjND/TnCs5erTfYY8dqpBFGqYfHZUH3PPzF
 QRRhEjlD9yE15scNYYhYGOFBjjILauY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-WTZt4EzcMCC1juWTa7nAqw-1; Fri, 13 Dec 2019 15:59:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FE898C4ECD;
 Fri, 13 Dec 2019 20:59:37 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 458B360BF3;
 Fri, 13 Dec 2019 20:59:34 +0000 (UTC)
Subject: Re: [PATCH v5 4/4] blockdev: honor bdrv_try_set_aio_context() context
 requirements
To: Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>
References: <20191128104129.250206-1-slp@redhat.com>
 <20191128104129.250206-5-slp@redhat.com>
 <20191209160601.GB6715@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7ea304ab-0a4b-8c0a-ae9f-2f6501198840@redhat.com>
Date: Fri, 13 Dec 2019 14:59:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191209160601.GB6715@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: WTZt4EzcMCC1juWTa7nAqw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 10:06 AM, Kevin Wolf wrote:
> Am 28.11.2019 um 11:41 hat Sergio Lopez geschrieben:
>> bdrv_try_set_aio_context() requires that the old context is held, and
>> the new context is not held. Fix all the occurrences where it's not
>> done this way.
>>
>> Suggested-by: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---

> Or in fact, I think you need to hold the AioContext of a bs to
> bdrv_unref() it, so maybe 'goto out' is right, but you need to unref
> target_bs while you still hold old_context.

I suspect https://bugzilla.redhat.com/show_bug.cgi?id=1779036 is also a 
symptom of this.  The v5 patch did not fix this simple test case:


$ qemu-img create -f qcow2 f1 100m
$ qemu-img create -f qcow2 f2 100m
$ ./qemu-kvm -nodefaults -nographic -qmp stdio -object iothread,id=io0 \
  -drive driver=qcow2,id=drive1,file=f1,if=none -device 
virtio-scsi-pci,id=scsi0,iothread=io0 -device 
scsi-hd,id=image1,drive=drive1 \
  -drive driver=qcow2,id=drive2,file=f2,if=none -device 
virtio-blk-pci,id=image2,drive=drive2,iothread=io0

{'execute':'qmp_capabilities'}

{'execute':'transaction','arguments':{'actions':[ 
{'type':'blockdev-snapshot-sync','data':{'device':'drive1', 
'snapshot-file':'sn1','mode':'absolute-paths','format':'qcow2'}}, 
{'type':'blockdev-snapshot-sync','data':{'device':'drive2', 
'snapshot-file':'/aa/sn1','mode':'absolute-paths','format':'qcow2'}}]}}

which is an aio context bug somewhere on the error path of 
blockdev-snapshot-sync (the first one has to be rolled back because the 
second part of the transaction fails early on a nonexistent directory)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


