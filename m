Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC0CC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A73DB206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+FRgdte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73DB206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdDb-0000r0-HM
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 10:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kNdBn-0007NU-WE
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:34:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kNdBm-0002OQ-0e
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:34:39 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601476477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOHyZ7XKnUFrHAVC9lsBOvS+Vb868ybU8a4kYz5OeAs=;
 b=b+FRgdteQLSEOrwpkQnaLkeqiIQR+p3DkFgzloS5YSbKEL0Rl678KvAcuCRhOhc1mwt4DL
 XhAdKbMddC+A9odz4cBIm+L5yABUgfWDi/quZdUSdf8vXaEQhwMCmCuxP++uhGVvXbX7Fq
 lYiu/SYQgI/Ig/NMwIjlTc5F2NAT5tA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-afOe40_8PW2kDNermKh5iA-1; Wed, 30 Sep 2020 10:34:35 -0400
X-MC-Unique: afOe40_8PW2kDNermKh5iA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 687F7800683
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 14:34:34 +0000 (UTC)
Received: from starship (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAA7A78839;
 Wed, 30 Sep 2020 14:34:29 +0000 (UTC)
Message-ID: <2397a36ca6c9fadad07091d5fcada60b4ff15f58.camel@redhat.com>
Subject: Re: [PATCH 10/10] scsi/scsi_bus: fix races in REPORT LUNS
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Date: Wed, 30 Sep 2020 17:34:28 +0300
In-Reply-To: <20200925172604.2142227-11-pbonzini@redhat.com>
References: <20200925172604.2142227-1-pbonzini@redhat.com>
 <20200925172604.2142227-11-pbonzini@redhat.com>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2020-09-25 at 13:26 -0400, Paolo Bonzini wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> Currently scsi_target_emulate_report_luns iterates over the child device list
> twice, and there is no guarantee that this list is the same in both iterations.
> 
> The reason for iterating twice is that the first iteration calculates
> how much memory to allocate.  However if we use a dynamic array we can
> avoid iterating twice, and therefore we avoid this race.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1866707
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-Id: <20200913160259.32145-10-mlevitsk@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/scsi-bus.c | 68 ++++++++++++++++++++++------------------------
>  1 file changed, 33 insertions(+), 35 deletions(-)
> 
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index eda8cb7e70..b901e701f0 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -438,19 +438,23 @@ struct SCSITargetReq {
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
> +    GByteArray *buf;
>  
>      if (r->req.cmd.xfer < 16) {
>          return false;
> @@ -458,46 +462,40 @@ static bool scsi_target_emulate_report_luns(SCSITargetReq *r)
>      if (r->req.cmd.buf[2] > 2) {
>          return false;
>      }
> +
> +    /* reserve space for 63 LUNs*/
> +    buf = g_byte_array_sized_new(512);
> +
>      channel = r->req.dev->channel;
>      id = r->req.dev->id;
> -    found_lun0 = false;
> -    n = 0;
>  
> -    RCU_READ_LOCK_GUARD();
> +    /* add size (will be updated later to correct value */
My mistake here - I forgot closing ')' - as I said, there will
be significantly less issues like that in my patches soon.
> +    g_byte_array_append(buf, tmp, 8);
> +    len += 8;
>  
> -    QTAILQ_FOREACH_RCU(kid, &r->req.bus->qbus.children, sibling) {
> -        DeviceState *qdev = kid->child;
> -        SCSIDevice *dev = SCSI_DEVICE(qdev);
> +    /* add LUN0 */
> +    g_byte_array_append(buf, tmp, 8);
> +    len += 8;
>  
> -        if (dev->channel == channel && dev->id == id) {
> -            if (dev->lun == 0) {
> -                found_lun0 = true;
> +    WITH_RCU_READ_LOCK_GUARD() {
> +        QTAILQ_FOREACH_RCU(kid, &r->req.bus->qbus.children, sibling) {
> +            DeviceState *qdev = kid->child;
> +            SCSIDevice *dev = SCSI_DEVICE(qdev);
> +
> +            if (dev->channel == channel && dev->id == id && dev->lun != 0) {
> +                store_lun(tmp, dev->lun);
> +                g_byte_array_append(buf, tmp, 8);
> +                len += 8;
>              }
> -            n += 8;
>          }
>      }
> -    if (!found_lun0) {
> -        n += 8;
> -    }
> -
> -    scsi_target_alloc_buf(&r->req, n + 8);
> -
> -    len = MIN(n + 8, r->req.cmd.xfer & ~7);
> -    memset(r->buf, 0, len);
> -    stl_be_p(&r->buf[0], n);
> -    i = found_lun0 ? 8 : 16;
> -    QTAILQ_FOREACH_RCU(kid, &r->req.bus->qbus.children, sibling) {
> -        DeviceState *qdev = kid->child;
> -        SCSIDevice *dev = SCSI_DEVICE(qdev);
>  
> -        if (dev->channel == channel && dev->id == id) {
> -            store_lun(&r->buf[i], dev->lun);
> -            i += 8;
> -        }
> -    }
> +    r->buf_len = len;
> +    r->buf = g_byte_array_free(buf, FALSE);
> +    r->len = MIN(len, r->req.cmd.xfer & ~7);
>  
> -    assert(i == n + 8);
> -    r->len = len;
> +    /* store the LUN list length */
> +    stl_be_p(&r->buf[0], len - 8);
>      return true;
>  }
>  
No doubt that I will RCU_READ_LOCK_GUARD more from now on.

Best regards,
	Maxim Levitsky


