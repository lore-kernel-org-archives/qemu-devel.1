Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFADC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 22:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067D420828
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 22:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1szqQxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067D420828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgyz1-0007eM-1a
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 18:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36375)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgyvY-0006g9-8O
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 18:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgyvK-000592-VP
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 18:00:57 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:35990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgyvK-00055l-KO
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 18:00:50 -0400
Received: by mail-lf1-x141.google.com with SMTP id q26so4928935lfc.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 15:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OlcnY1jD6ac68szMCNXTf0urzhYA2i6BaHQ8M22Fx7E=;
 b=L1szqQxClHTF0urvAUvb4ldQqX7836jlByET3eJqZ89zFVMXqWHnAgDlJPTmmXhSQt
 lZU15+9eNGd0ILFfYOKxf6NdbIzIIUnlC3Tjik8T5NZ8omBkbcFw0ysa3Nsjg9R9mp/W
 b0xenc82aPpxYXDfO2SN97GrEWDFJyezP2ePEO8AJ5LR49xq1z9eTUc/YvdrwuY3uVVt
 f3e1wSwQjIbG7CUAr1NX9W2JMoqJDtPmGIpe4GsCy0++h0nbkQdIPjJAIRaWW4+sUVS0
 vqIUTyOvl6q0qwGZphS0kDzVgJJHcU+J4vB/Xc5c32sgVLgOoU0lKpEXqXuHA1ca+yMT
 gm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OlcnY1jD6ac68szMCNXTf0urzhYA2i6BaHQ8M22Fx7E=;
 b=gNgXf8yOetWpZy8+1gudqXHAo+DhOzUV9NzkWssEClsRhtbiPNj7dxjmzke/DkyWnA
 LMO4LyS0+FwG/LMUAvHe1IJk4fmminvMge25H8VLxLqgdFM+gZfygQmJA4ybwpwIJ/aq
 yWIXQYJwTSf4NyGWjf5tFgKrgmOENCq4khStTuXNUI7VdcEJ/dZwcGjTXXyN3RR7Xch1
 ZObss+7GJ/jg3Ig8+xXd7+IkE7Im1BAOR/oeYqlHgobxxLim7wx7SiO6ArkiLMDZIWbN
 DKpI08hymxKuSXZfaxBEhujJqrb0JbemxP65tLJKNhmXBQc+5r42gbD4KcV7ZETDTw75
 K7WA==
X-Gm-Message-State: APjAAAVezDI+bFsWP01mDJRR5pUkg3MEkXFOacKYgB+LZekq62USchIt
 AywlTbKXbFNYPByBJ4cl9TjcghQZb5l9NXBk9go=
X-Google-Smtp-Source: APXvYqznc++bKooziE4Y+WbgBL9UpVAD/zDxLQBGoE7Urmdxjtbh2K2fVnqyyDn/RUGsnqUWs/gvVl9431A01TLSK2o=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr5993671lfu.141.1561759246759; 
 Fri, 28 Jun 2019 15:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <97104495f5c945d25315aff1bd618e1a7bacf34c.1561589072.git.alistair.francis@wdc.com>
 <1bd3ffcd-3f91-ecb9-2315-da7125f1dcdd@redhat.com>
In-Reply-To: <1bd3ffcd-3f91-ecb9-2315-da7125f1dcdd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 14:57:46 -0700
Message-ID: <CAKmqyKPeo4XXVy3onoM4W14N5Nj7CFWX=JpDT-JQQRUPw5CQ3Q@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH v1 1/1] hw/scsi: Report errors and sense to
 guests through scsi-block
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
Cc: fam@euphon.net, shinichiro.kawasaki@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 2:01 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 27/06/19 00:46, Alistair Francis wrote:
> > From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> >
> > When host block devices are bridged to a guest system through
> > virtio-scsi-pci and scsi-block driver, scsi_handle_rw_error() in
> > hw/scsi/scsi-disk.c checks the error number to judge which error to
> > report to the guests. EIO and EINVAL are not reported and ignored. Once
> > EIO or EINVAL happen, eternal wait of guest system happens. This problem
> > was observed with zoned block devices on the host system attached to the
> > guest via virtio-scsi-pci. To avoid the eternal wait, add EIO and EINVAL
> > to the list of error numbers to report to the guest.
>
> This is certainly correct for EINVAL, I am not sure about EIO.  Did you
> run the VM with "-drive ...,rerror=report,werror=report"?

This is from Shin'ichiro Kawasaki:

I tried to run my VM with option "-drive
...,rerror=report,werror=report" as he noted, but the eternal loop
symptom still happens when host block-scsi device returns EIO. Then I
believe EIO should be added to the report target error list.

>
> The update_sense part is okay too.

Cool!

Alistair

>
> Paolo
>
> > On top of this, it is required to report SCSI sense data to the guest
> > so that the guest can handle the error correctly. However,
> > scsi_handle_rw_error() does not passthrough sense data that host
> > scsi-block device reported. Instead, it newly generates fixed sense
> > data only for certain error numbers. This is inflexible to support new
> > error codes to report to guest. To avoid this inflexiblity, pass the SCSI
> > sense data that the host scsi-block device reported as is. To be more
> > precise, set valid sense_len in the SCSIDiskReq referring sb_len_wr that
> > host SCSI device SG_IO ioctl reported. Add update_sense callback to
> > SCSIDiskClass to refer the SG_IO ioctl result only when scsi-block device
> > is targeted.
> >
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/scsi/scsi-disk.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> > index ed7295bfd7..6801e3a0d0 100644
> > --- a/hw/scsi/scsi-disk.c
> > +++ b/hw/scsi/scsi-disk.c
> > @@ -62,6 +62,7 @@ typedef struct SCSIDiskClass {
> >      DMAIOFunc       *dma_readv;
> >      DMAIOFunc       *dma_writev;
> >      bool            (*need_fua_emulation)(SCSICommand *cmd);
> > +    void            (*update_sense)(SCSIRequest *r);
> >  } SCSIDiskClass;
> >
> >  typedef struct SCSIDiskReq {
> > @@ -438,6 +439,7 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
> >  {
> >      bool is_read = (r->req.cmd.mode == SCSI_XFER_FROM_DEV);
> >      SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> > +    SCSIDiskClass *sdc = (SCSIDiskClass *) object_get_class(OBJECT(s));
> >      BlockErrorAction action = blk_get_error_action(s->qdev.conf.blk,
> >                                                     is_read, error);
> >
> > @@ -452,9 +454,12 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
> >               * pause the host.
> >               */
> >              assert(r->status && *r->status);
> > +            if (sdc->update_sense) {
> > +                sdc->update_sense(&r->req);
> > +            }
> >              error = scsi_sense_buf_to_errno(r->req.sense, sizeof(r->req.sense));
> >              if (error == ECANCELED || error == EAGAIN || error == ENOTCONN ||
> > -                error == 0)  {
> > +                error == EIO || error == EINVAL || error == 0)  {
> >                  /* These errors are handled by guest. */
> >                  scsi_req_complete(&r->req, *r->status);
> >                  return true;
> > @@ -2894,6 +2899,13 @@ static int scsi_block_parse_cdb(SCSIDevice *d, SCSICommand *cmd,
> >      }
> >  }
> >
> > +static void scsi_block_update_sense(SCSIRequest *req)
> > +{
> > +    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
> > +    SCSIBlockReq *br = DO_UPCAST(SCSIBlockReq, req, r);
> > +    r->req.sense_len = MIN(br->io_header.sb_len_wr, sizeof(r->req.sense));
> > +}
> > +
> >  #endif
> >
> >  static
> > @@ -3059,6 +3071,7 @@ static void scsi_block_class_initfn(ObjectClass *klass, void *data)
> >      sc->parse_cdb    = scsi_block_parse_cdb;
> >      sdc->dma_readv   = scsi_block_dma_readv;
> >      sdc->dma_writev  = scsi_block_dma_writev;
> > +    sdc->update_sense = scsi_block_update_sense;
> >      sdc->need_fua_emulation = scsi_block_no_fua;
> >      dc->desc = "SCSI block device passthrough";
> >      dc->props = scsi_block_properties;
> >
>

