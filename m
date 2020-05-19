Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68B3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F6BC20578
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgS5hO2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6BC20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb4m3-0005Tm-S9
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 12:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jb4ku-0004EQ-JU
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:06:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46607
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jb4ks-0003yp-4i
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589904368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ft1k8/+vu4KGhG0o6dVIMdOUyQRkdME+4P+QzrN5Apc=;
 b=TgS5hO2jzzFTgSjM2nIC0Kl2XM3YmGehc0p/o8LAmtvYjQRhbPyO7Ljh/ZcUWM53xBxcGy
 E6+rfKzTeL96/mY33awUi2HEdOn7FsiVzkp78Nji3wBGT9KfoGSjQH0noShDvpKk7U70NQ
 3LHcCBIX2PVM+XqwH71UIj4mpx5M2+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-uGdQ0E5DMUK48tNpd1MBeA-1; Tue, 19 May 2020 12:06:06 -0400
X-MC-Unique: uGdQ0E5DMUK48tNpd1MBeA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEB3B18FE860;
 Tue, 19 May 2020 16:06:04 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F6F56F430;
 Tue, 19 May 2020 16:06:01 +0000 (UTC)
Subject: Re: [RFC PATCH 0/3] block: Synchronous bdrv_*() from coroutine in
 different AioContext
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>
References: <20200512144318.181049-1-kwolf@redhat.com>
 <6d78bc78-0c44-d703-6f9f-e048ea34fdd9@proxmox.com>
 <20200514142606.GH5518@linux.fritz.box>
 <285ba39f-9ee6-e089-13f7-a98ea0a84866@virtuozzo.com>
 <548700ea-78db-fabc-d1eb-6d89af39ece3@virtuozzo.com>
 <20200519141858.GN7652@linux.fritz.box>
 <dfed81f7-9806-9aaf-459f-13f786b67e0a@virtuozzo.com>
 <20200519152959.GP7652@linux.fritz.box>
 <b10dddf4-8889-c9e2-74db-d620e4fa5ca7@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8f454324-2edc-076f-c413-04c74ffaf6b9@redhat.com>
Date: Tue, 19 May 2020 11:06:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b10dddf4-8889-c9e2-74db-d620e4fa5ca7@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 09:19:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-block@nongnu.org, armbru@redhat.com, s.reiter@proxmox.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 10:48 AM, Vladimir Sementsov-Ogievskiy wrote:

>> The other options is doing what you suggested. There is nothing in the
>> qcow2 on-disk format that would prevent this, but we would have to
>> extend the qcow2 driver to allow I/O to inactive L1 tables. This sounds
>> like a non-trivial amount of code changes, though it would potentially
>> enable more use cases we never implemented ((read-only) access to
>> internal snapshots as block nodes, so you could e.g. use block jobs to
>> export a snapshot).
> 
> Or export a snapshot through NBD.
> 
> Still, I have one more idea, probably we already discussed it?
> Honestly, I don't like the fact that we store vmstate into guest-data 
> space. After EOF, invisible, but still..
> 
> Maybe, it would be good to make a qcow2 extension for storing vmstate 
> separately?

The existing location of internal snapshots IS already stored separately 
from guest-data space, precisely because it is beyond EOF.

> So snapshot metadata will include two more fields: 
> vmstate_offset and vmstate_length (hmm, actually we already have the 
> second one), which will be allocated as normal qcow2 metadata?

How will adding redundant fields help?  Both fields are already present 
in the snapshot table of v3 images (even if indirectly) by virtue of:

         32 - 35:    Size of the VM state in bytes. 0 if no VM state is 
saved.
                     If there is VM state, it starts at the first cluster
                     described by first L1 table entry that doesn't 
describe a
                     regular guest cluster (i.e. VM state is stored like 
guest
                     disk content, except that it is stored at offsets 
that are
                     larger than the virtual disk presented to the guest)

                     Byte 40 - 47:   Size of the VM state in bytes. 0 if 
no VM
                                     state is saved. If this field is 
present,
                                     the 32-bit value in bytes 32-35 is 
ignored.

                     Byte 48 - 55:   Virtual disk size of the snapshot 
in bytes

which gives you both the 64-bit size (in order to compute the last 
cluster accessible to the guest, and thus the next cluster available to 
the vmstate beyond EOF) and the 64-bit length of that vmstate.

> Or we can 
> add one-two levels of layered allocation if needed, but keep it separate 
> from L1/L2 tables for guest clusters.
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


