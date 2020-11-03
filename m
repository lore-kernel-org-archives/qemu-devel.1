Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CE1C4742C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B8C22243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhkJ4Jz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B8C22243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvVU-0008DH-JQ
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kZvUd-00078k-My
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:32:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kZvUb-00046E-TP
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604406772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c76MPZi6sjJvKDyzwME3lBwJUIaYgU0RcfzRDMNxCCE=;
 b=HhkJ4Jz/Svc2A0luCDxlaBUDyP037/+W2SrMKAmGkiK8R4VMHPEoSXF6qGp90PoBh06o6s
 +hc4WCI10frLSbdIezNSwMZu3T242kIOzzoBKmP9OM/LbFKdNXXoaYxucpoJY3RZi6LqYs
 E8yJjwsZZT6zizSobG8NfQjg7Wy6Dqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-YgRzCZToMA6nY-qKsvnGPw-1; Tue, 03 Nov 2020 07:32:51 -0500
X-MC-Unique: YgRzCZToMA6nY-qKsvnGPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFC261074668;
 Tue,  3 Nov 2020 12:32:49 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-233.ams2.redhat.com [10.36.112.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EC0D55763;
 Tue,  3 Nov 2020 12:32:48 +0000 (UTC)
Subject: Re: [PATCH] s390-bios: Skip writing iplb location to low core for ccw
 ipl
To: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20201030122823.347140-1-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8e5e3e03-f25b-4d69-a2bd-42c46a675c04@redhat.com>
Date: Tue, 3 Nov 2020 13:32:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201030122823.347140-1-borntraeger@de.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/10/2020 13.28, Christian Borntraeger wrote:
> From: "Jason J. Herne" <jjherne@linux.ibm.com>
> 
> The architecture states that the iplb location is only written to low
> core for list directed ipl and not for traditional ccw ipl. If we don't
> skip this then operating systems that load by reading into low core
> memory may fail to start.

Just double-checking: But doing write_subsystem_identification()
unconditionally is ok, right?

> We should also not write the iplb pointer for network boot as it might
> overwrite content that we got via network.

FWIW, write_iplb_location() is already just a dummy function in netmain.c,
so this should not have been an issue in the network bootloader, I hope.

> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Fixes: 9bfc04f9ef68 ("pc-bios: s390x: Save iplb location in lowcore")
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  pc-bios/s390-ccw/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 43c792cf9509..fc4bfaa45529 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -43,7 +43,9 @@ void write_subsystem_identification(void)
>  
>  void write_iplb_location(void)
>  {
> -    lowcore->ptr_iplb = ptr2u32(&iplb);
> +    if (cutype == CU_TYPE_VIRTIO && virtio_get_device_type() != VIRTIO_ID_NET) {
> +        lowcore->ptr_iplb = ptr2u32(&iplb);
> +    }
>  }

Acked-by: Thomas Huth <thuth@redhat.com>

Christian, Cornelia, could you please pick up the patch? I'm not sure
whether I can do another PR this week for the RC...


