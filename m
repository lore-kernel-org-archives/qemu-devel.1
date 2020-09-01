Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA915C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD272067C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7ZK2nQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD272067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2hR-0003lV-HB
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kD2O7-0002n6-HV
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:15:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kD2O4-0007K8-V9
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598951732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BE+kTmtcIzrkbJr1dr9G72JcyfzOtXA7/2Xc8Q2CcbQ=;
 b=L7ZK2nQSDgWxtkZa82Ee3pn9mbCGfYbkn9DfcLOCKDsSPFIvXE+5vXh/4lTUprWkoX3BJF
 NrNA+LictId5Ex0KYf7BikQXvxM28b3wD0s2MwI1XPdqhvCwvFM7zmYnhRA2KbChmj9Ji9
 De0Xtfbg3vxe5fn6zP1/TO41kwNYyvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-TjbWHyAMM9SnOhxuSBr0yA-1; Tue, 01 Sep 2020 05:15:30 -0400
X-MC-Unique: TjbWHyAMM9SnOhxuSBr0yA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 394A2800C60;
 Tue,  1 Sep 2020 09:15:29 +0000 (UTC)
Received: from starship (unknown [10.35.206.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DE3F5D9CD;
 Tue,  1 Sep 2020 09:15:19 +0000 (UTC)
Message-ID: <aa3c42a6d304b6f8f07b3293cc5f470116e230aa.camel@redhat.com>
Subject: Re: [PATCH v4 9/9] scsi/scsi_bus: fix races in REPORT LUNS
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 01 Sep 2020 12:15:10 +0300
In-Reply-To: <20200831150124.206267-10-mlevitsk@redhat.com>
References: <20200831150124.206267-1-mlevitsk@redhat.com>
 <20200831150124.206267-10-mlevitsk@redhat.com>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 01:27:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel
 P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-08-31 at 18:01 +0300, Maxim Levitsky wrote:
> Currently scsi_target_emulate_report_luns iterates
> over child devices list twice, and there is guarantee, that
> it will not be changed meanwhile.
> 
> This reason for two loops is that it needs to know how much memory
> to allocate.
> 
> Avoid this by iterating once, and allocating the memory for the output
> dynamically with reserving enought memory so that in practice it won't
> be reallocated often.
Just too many spelling/grammar mistakes in the commit message. Sorry about that.

It should be something like that:

Currently scsi_target_emulate_report_luns iterates over the child device list
twice, and there is no guarantee that this list is the same in both iterations.

The reason for iterating twise is that the first iteration calculates 
how much memory to allocate.

However if we use a dynamic array we can avoid iterating twice, and therefore
we avoid this race.

Best regards,
	Maxim Levitsky


> 
> Bugzilla for reference: https://bugzilla.redhat.com/show_bug.cgi?id=1866707
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/scsi/scsi-bus.c | 62 ++++++++++++++++++++++------------------------
>  1 file changed, 29 insertions(+), 33 deletions(-)
> 
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index feab20b76d..150dee2e6a 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -438,19 +438,25 @@ struct SCSITargetReq {
>  static void store_lun(uint8_t *outbuf, int lun)
>  {
>      if (lun < 256) {
> +        /* Simple logical unit addressing method*/
> +        outbuf[0] = 0;
>          outbuf[1] = lun;
> -        return;
> +    } else {
> +        /* Flat space addressing method */
> +        outbuf[0] = 0x40 | (lun >> 8);
> +        outbuf[1] = (lun & 255);
>      }
> -    outbuf[1] = (lun & 255);
> -    outbuf[0] = (lun >> 8) | 0x40;
>  }
>  
>  static bool scsi_target_emulate_report_luns(SCSITargetReq *r)
>  {
>      BusChild *kid;
> -    int i, len, n;
>      int channel, id;
> -    bool found_lun0;
> +    uint8_t tmp[8] = {0};
> +    int len = 0;
> +
> +    /* reserve space for 63 LUNs*/
> +    GByteArray *buf = g_byte_array_sized_new(512);
>  
>      if (r->req.cmd.xfer < 16) {
>          return false;
> @@ -460,46 +466,36 @@ static bool scsi_target_emulate_report_luns(SCSITargetReq *r)
>      }
>      channel = r->req.dev->channel;
>      id = r->req.dev->id;
> -    found_lun0 = false;
> -    n = 0;
>  
> -    rcu_read_lock();
>  
> -    QTAILQ_FOREACH_RCU(kid, &r->req.bus->qbus.children, sibling) {
> -        DeviceState *qdev = kid->child;
> -        SCSIDevice *dev = SCSI_DEVICE(qdev);
> +    /* add size (will be updated later to correct value */
> +    g_byte_array_append(buf, tmp, 8);
> +    len += 8;
>  
> -        if (dev->channel == channel && dev->id == id) {
> -            if (dev->lun == 0) {
> -                found_lun0 = true;
> -            }
> -            n += 8;
> -        }
> -    }
> -    if (!found_lun0) {
> -        n += 8;
> -    }
> -
> -    scsi_target_alloc_buf(&r->req, n + 8);
> +    /* add LUN0 */
> +    g_byte_array_append(buf, tmp, 8);
> +    len += 8;
>  
> -    len = MIN(n + 8, r->req.cmd.xfer & ~7);
> -    memset(r->buf, 0, len);
> -    stl_be_p(&r->buf[0], n);
> -    i = found_lun0 ? 8 : 16;
> +    rcu_read_lock();
>      QTAILQ_FOREACH_RCU(kid, &r->req.bus->qbus.children, sibling) {
>          DeviceState *qdev = kid->child;
>          SCSIDevice *dev = SCSI_DEVICE(qdev);
>  
> -        if (dev->channel == channel && dev->id == id) {
> -            store_lun(&r->buf[i], dev->lun);
> -            i += 8;
> +        if (dev->channel == channel && dev->id == id && dev->lun != 0) {
> +            store_lun(tmp, dev->lun);
> +            g_byte_array_append(buf, tmp, 8);
> +            len += 8;
>          }
>      }
> -
>      rcu_read_unlock();
>  
> -    assert(i == n + 8);
> -    r->len = len;
> +    r->buf_len = len;
> +    r->buf = g_byte_array_free(buf, FALSE);
> +    r->len = MIN(len, r->req.cmd.xfer & ~7);
> +
> +    /* store the LUN list length */
> +    stl_be_p(&r->buf[0], len - 8);
> +
>      return true;
>  }
>  



