Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882AFC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B9821D42
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gz4N+qhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B9821D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXUlP-0001Ij-Ek
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 15:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXUjx-0000Qa-WD
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXUjt-0005c8-Ko
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603827273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DuWSL/hsCWyWedJExKwbsSl3EG4pyOquzL5/1F7MyUM=;
 b=gz4N+qhiCpFpkQ+1vn38wH0Ry0itZdHi2Wl0+DfqobgGIpw8dKLy7sFFze2shvSfryZorq
 wOt5iARopKP4slJ/MHr+8cK7470aAHdU9iSUp+sWhT7BJYyNAmfGKMR1sxQYKhH1tG4MZB
 d98ZGRJKClMy13dJB81WQePTz/jqWeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-KgKPX77zPWeRJh23XH85jw-1; Tue, 27 Oct 2020 15:34:29 -0400
X-MC-Unique: KgKPX77zPWeRJh23XH85jw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1038F107ACF5
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 19:34:29 +0000 (UTC)
Received: from [10.3.112.145] (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54AEC60C15;
 Tue, 27 Oct 2020 19:34:22 +0000 (UTC)
Subject: Re: [PULL 31/38] device-core: use RCU for list of children of a bus
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201012203343.1105018-1-pbonzini@redhat.com>
 <20201012203343.1105018-32-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c55d660e-e650-6470-f14c-acba6a085e74@redhat.com>
Date: Tue, 27 Oct 2020 14:34:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201012203343.1105018-32-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 3:33 PM, Paolo Bonzini wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> This fixes the race between device emulation code that tries to find
> a child device to dispatch the request to (e.g a scsi disk),
> and hotplug of a new device to that bus.
> 
> Note that this doesn't convert all the readers of the list
> but only these that might go over that list without BQL held.
> 
> This is a very small first step to make this code thread safe.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-Id: <20200913160259.32145-5-mlevitsk@redhat.com>
> [Use RCU_READ_LOCK_GUARD in more places, adjust testcase now that
>  the delay in DEVICE_DELETED due to RCU is more consistent. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20201006123904.610658-9-mlevitsk@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Git bisect lands on this commit as the reason that iotest 240 is failing:

--- /home/eblake/qemu-tmp2/tests/qemu-iotests/240.out	2020-10-23
10:47:02.268392745 -0500
+++ /home/eblake/qemu-tmp2/build/tests/qemu-iotests/240.out.bad
2020-10-27 14:27:38.417188285 -0500
@@ -10,10 +10,10 @@
 {"return": {}}
 {"return": {}}
 {"return": {}}
+{"error": {"class": "GenericError", "desc": "Duplicate ID 'scsi-hd0'
for device"}}
+{"error": {"class": "DeviceNotFound", "desc": "Device 'scsi-hd0' not
found"}}
 {"return": {}}
-{"return": {}}
-{"return": {}}
-{"return": {}}
+{"error": {"class": "GenericError", "desc": "Node hd0 is in use"}}
 {"return": {}}

 === Attach two SCSI disks using the same block device and the same
iothread ===
@@ -29,7 +29,7 @@
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"return": {}}
+{"error": {"class": "GenericError", "desc": "Node hd0 is in use"}}
 {"return": {}}

 === Attach two SCSI disks using the same block device but different
iothreads ===
@@ -45,8 +45,8 @@
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Cannot change iothread of
active block backend"}}
 {"return": {}}
-{"return": {}}
-{"return": {}}
+{"error": {"class": "GenericError", "desc": "Cannot change iothread of
active block backend"}}
+{"error": {"class": "DeviceNotFound", "desc": "Device 'scsi-hd1' not
found"}}
 {"return": {}}
 {"return": {}}
 {"return": {}}
Failures: 240
Failed 1 of 1 iotests


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


