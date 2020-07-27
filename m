Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB52C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B172075D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AeKjl7JT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B172075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzzsZ-0004Z7-AI
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 05:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jzzrp-00048W-IQ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 05:56:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52601
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jzzrn-0007My-LK
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 05:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595843779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fks4z6NjXJqjVl3e9ql7cdlIT5mGbV6nHfiI+PfmdcU=;
 b=AeKjl7JTAPC51monw0cSmAZCuYeDV60BUp3/prExrEU+sZvONAC54QZTK3HKwpY7l74jt7
 tt7L94vXq2CceZ24hCzEv7QizLLGg3hx6ePOYaTkAR96Uwybh3s6ylYB7yDz+e9p4HZN+u
 65X2pR5T5a/QWWStIj7Nq9U0znpBfY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-GWlGeONiPo2mQf8AttY72A-1; Mon, 27 Jul 2020 05:56:17 -0400
X-MC-Unique: GWlGeONiPo2mQf8AttY72A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8962E80047E;
 Mon, 27 Jul 2020 09:56:15 +0000 (UTC)
Received: from gondolin (ovpn-112-210.ams2.redhat.com [10.36.112.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A19EE8FF89;
 Mon, 27 Jul 2020 09:56:04 +0000 (UTC)
Date: Mon, 27 Jul 2020 11:56:01 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFCv3 7/9] s390x: prepare device memory address space
Message-ID: <20200727115601.3f666636.cohuck@redhat.com>
In-Reply-To: <20200724143750.59836-8-david@redhat.com>
References: <20200724143750.59836-1-david@redhat.com>
 <20200724143750.59836-8-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jul 2020 16:37:48 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's allocate the device memory information and setup the device
> memory address space. The RAM size returned via SCLP is not modified. Guest
> OSs which support memory devices (like virtio-mem) are expected to
> consult diag500(4).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c         | 37 ++++++++++++++++++++++++++++++
>  hw/s390x/sclp.c                    |  6 ++++-
>  include/hw/s390x/s390-virtio-ccw.h |  3 +++
>  3 files changed, 45 insertions(+), 1 deletion(-)
> 

(...)

> @@ -783,8 +817,11 @@ static void ccw_machine_5_0_instance_options(MachineState *machine)
>  
>  static void ccw_machine_5_0_class_options(MachineClass *mc)
>  {
> +    S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
> +
>      ccw_machine_5_1_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
> +    s390mc->memory_devices_allowed = false;

I guess that needs to go one version up. (I plan to send the 5.2
machines patch in the next days.)

>  }
>  DEFINE_CCW_MACHINE(5_0, "5.0", false);

(...)


