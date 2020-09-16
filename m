Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FA7C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5EB62080C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtpafIN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5EB62080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISZi-00046x-Os
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kISXE-0001AK-1X
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:11:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29047
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kISXB-0003mE-Sy
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600243877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2MZt1oRMbzND04IMZbEV94iiCDiVvv0V8h4FYBZJG6c=;
 b=OtpafIN9v4laVzp1vz/OvvFWc6a0ISxPvDG8tdGy+KvZQRTxq7mKVQn+2fBo1uoR/v17b1
 eunFtgXDiUTsHvGZ1/0+CreG+ABpWzklsZCtpBRe7H6NFbR2s4nJR+861NBQ+dk7kvzLBH
 G9hmR5Mo/N/40Jvf0z8Af8yOUWPpk/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-ZjT6cBUHMhSSSeUQ3eSKLQ-1; Wed, 16 Sep 2020 04:11:13 -0400
X-MC-Unique: ZjT6cBUHMhSSSeUQ3eSKLQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BFEA186DD2B;
 Wed, 16 Sep 2020 08:11:12 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6A8B75137;
 Wed, 16 Sep 2020 08:11:02 +0000 (UTC)
Subject: Re: [PATCH v6 8/8] s390: guest support for diagnose 0x318
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, david@redhat.com
References: <20200915194416.107460-1-walling@linux.ibm.com>
 <20200915194416.107460-9-walling@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <30a23907-7ed7-0361-7943-5b938a8f6c68@redhat.com>
Date: Wed, 16 Sep 2020 10:11:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200915194416.107460-9-walling@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:41:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: frankja@linux.ibm.com, mst@redhat.com, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, pbonzini@redhat.com,
 sumanthk@linux.ibm.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/09/2020 21.44, Collin Walling wrote:
> DIAGNOSE 0x318 (diag318) is an s390 instruction that allows the storage
> of diagnostic information that is collected by the firmware in the case
> of hardware/firmware service events.
> 
> QEMU handles the instruction by storing the info in the CPU state. A
> subsequent register sync will communicate the data to the hypervisor.
> 
> QEMU handles the migration via a VM State Description.
> 
> This feature depends on the Extended-Length SCCB (els) feature. If
> els is not present, then a warning will be printed and the SCLP bit
> that allows the Linux kernel to execute the instruction will not be
> set.
> 
> Availability of this instruction is determined by byte 134 (aka fac134)
> bit 0 of the SCLP Read Info block. This coincidentally expands into the
> space used for CPU entries, which means VMs running with the diag318
> capability may not be able to read information regarding all CPUs
> unless the guest kernel supports an extended-length SCCB.
> 
> This feature is not supported in protected virtualization mode.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Acked-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  hw/s390x/sclp.c                     |  5 ++++
>  include/hw/s390x/sclp.h             |  8 ++++++
>  target/s390x/cpu.h                  |  2 ++
>  target/s390x/cpu_features.h         |  1 +
>  target/s390x/cpu_features_def.h.inc |  3 +++
>  target/s390x/cpu_models.c           |  1 +
>  target/s390x/gen-features.c         |  1 +
>  target/s390x/kvm.c                  | 39 +++++++++++++++++++++++++++++
>  target/s390x/machine.c              | 17 +++++++++++++
>  9 files changed, 77 insertions(+)

Acked-by: Thomas Huth <thuth@redhat.com>

(I hope David could still comment on the CPU model stuff ... it looks ok
to me here, but I got that wrong a couple of times in the past already...)


