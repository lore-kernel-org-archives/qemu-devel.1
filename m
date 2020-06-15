Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C8BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D3A2078E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcRWv7Zj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D3A2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkprH-0006nK-QN
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 10:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jkpqa-0006Kn-CS
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:12:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23213
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jkpqY-0003N4-N0
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592230341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q899REfQJ78B/4DYWo+GP9jBVCWPL0Lx3ZKNGj0pl1c=;
 b=bcRWv7ZjM0Ai+oCSZt0hHRS68DaGGsryfa9XB9PNtQ+pGM4Brre6J6MFivQgjPljd8NUN7
 NBbRW7Z6BOmoU4JrXp/Lub46CDRxI6OD1P9CecO11AorED1ViOHoce3h1a3d/by/LhtBLi
 LItUOJF1modYA+ZKWeFvfv3Hx52Ky7Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-2QoLsZYHO-afxS4h-2mU9A-1; Mon, 15 Jun 2020 10:12:12 -0400
X-MC-Unique: 2QoLsZYHO-afxS4h-2mU9A-1
Received: by mail-wr1-f69.google.com with SMTP id z10so7147920wrs.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 07:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q899REfQJ78B/4DYWo+GP9jBVCWPL0Lx3ZKNGj0pl1c=;
 b=AuwlgwCX0oL+LtKDq8gGkR3BSXI2ZhtTcIxg22WMBMh8XoCxSlcqOn2XrIFWau4HRE
 vCb30djZzM/btDftvrXv2FP/eNwQRJzoTwb2TwMECFR+lJkj6Jr7or6c06P3Ml2UbF/8
 bEjDQXmh21OYXt2Ms3pSFyoYWEombcpw7zSy1WAI63e4lsX/Wd6+xjX9VejTn4IWFgvG
 ha91zS0HU+lAcA6kYm0/xVQLt6TUPx+zf7hpirEX4t85x272F3ZFAVzVba6ks8xdfTeY
 TXTdumH9Aj/nu73E+3XUY0pF2xm7Mk7xORq+amKN1jLildRCjzeHkmYzf3D6A1tLcJcJ
 LmOw==
X-Gm-Message-State: AOAM532B24CKKPALb2zsgMu1OrPAxI5BgRrMAcobZ/BEjGco4ZhE2rac
 cfe30SrZUTetCF4oQUbqSoC6WHHlpUGIDS/jjRYnr/w2je0kPZQNRkVH2R1Jmdzz9GNkWmfcykE
 UakpNZSIQVlPEV14=
X-Received: by 2002:adf:f44b:: with SMTP id f11mr28693708wrp.165.1592230331418; 
 Mon, 15 Jun 2020 07:12:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4fanbqWjYU8XzWYN/KIZ1MU6MRhN2il9TM598ejVEpsI4AttYLYWIki5o/7663zozbfJuEQ==
X-Received: by 2002:adf:f44b:: with SMTP id f11mr28693684wrp.165.1592230331032; 
 Mon, 15 Jun 2020 07:12:11 -0700 (PDT)
Received: from [192.168.178.58] ([151.48.99.33])
 by smtp.gmail.com with ESMTPSA id z9sm21980582wmi.41.2020.06.15.07.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 07:12:10 -0700 (PDT)
Subject: Re: [PATCH] hw/scsi/megasas: Fix possible out-of-bounds array access
 in tracepoints
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Hannes Reinecke <hare@suse.com>
References: <20200615072629.32321-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f7cd0d83-d45e-86c3-7545-9649188243a8@redhat.com>
Date: Mon, 15 Jun 2020 16:12:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200615072629.32321-1-thuth@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:43:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/06/20 09:26, Thomas Huth wrote:
> Some tracepoints in megasas.c use a guest-controlled value as an index
> into the mfi_frame_desc[] array. Thus a malicious guest could cause an
> out-of-bounds error here. Fortunately, the impact is very low since this
> can only happen when the corresponding tracepoints have been enabled
> before, but the problem should be fixed anyway with a proper check.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1882065
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/scsi/megasas.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index af18c88b65..aa930226f8 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -54,10 +54,6 @@
>  #define MEGASAS_FLAG_USE_QUEUE64   1
>  #define MEGASAS_MASK_USE_QUEUE64   (1 << MEGASAS_FLAG_USE_QUEUE64)
>  
> -static const char *mfi_frame_desc[] = {
> -    "MFI init", "LD Read", "LD Write", "LD SCSI", "PD SCSI",
> -    "MFI Doorbell", "MFI Abort", "MFI SMP", "MFI Stop"};
> -
>  typedef struct MegasasCmd {
>      uint32_t index;
>      uint16_t flags;
> @@ -183,6 +179,20 @@ static void megasas_frame_set_scsi_status(MegasasState *s,
>      stb_pci_dma(pci, frame + offsetof(struct mfi_frame_header, scsi_status), v);
>  }
>  
> +static inline const char *mfi_frame_desc(unsigned int cmd)
> +{
> +    static const char *mfi_frame_descs[] = {
> +        "MFI init", "LD Read", "LD Write", "LD SCSI", "PD SCSI",
> +        "MFI Doorbell", "MFI Abort", "MFI SMP", "MFI Stop"
> +    };
> +
> +    if (cmd < ARRAY_SIZE(mfi_frame_descs)) {
> +        return mfi_frame_descs[cmd];
> +    }
> +
> +    return "Unknown";
> +}
> +
>  /*
>   * Context is considered opaque, but the HBA firmware is running
>   * in little endian mode. So convert it to little endian, too.
> @@ -1670,25 +1680,25 @@ static int megasas_handle_scsi(MegasasState *s, MegasasCmd *cmd,
>      if (is_logical) {
>          if (target_id >= MFI_MAX_LD || lun_id != 0) {
>              trace_megasas_scsi_target_not_present(
> -                mfi_frame_desc[frame_cmd], is_logical, target_id, lun_id);
> +                mfi_frame_desc(frame_cmd), is_logical, target_id, lun_id);
>              return MFI_STAT_DEVICE_NOT_FOUND;
>          }
>      }
>      sdev = scsi_device_find(&s->bus, 0, target_id, lun_id);
>  
>      cmd->iov_size = le32_to_cpu(cmd->frame->header.data_len);
> -    trace_megasas_handle_scsi(mfi_frame_desc[frame_cmd], is_logical,
> +    trace_megasas_handle_scsi(mfi_frame_desc(frame_cmd), is_logical,
>                                target_id, lun_id, sdev, cmd->iov_size);
>  
>      if (!sdev || (megasas_is_jbod(s) && is_logical)) {
>          trace_megasas_scsi_target_not_present(
> -            mfi_frame_desc[frame_cmd], is_logical, target_id, lun_id);
> +            mfi_frame_desc(frame_cmd), is_logical, target_id, lun_id);
>          return MFI_STAT_DEVICE_NOT_FOUND;
>      }
>  
>      if (cdb_len > 16) {
>          trace_megasas_scsi_invalid_cdb_len(
> -                mfi_frame_desc[frame_cmd], is_logical,
> +                mfi_frame_desc(frame_cmd), is_logical,
>                  target_id, lun_id, cdb_len);
>          megasas_write_sense(cmd, SENSE_CODE(INVALID_OPCODE));
>          cmd->frame->header.scsi_status = CHECK_CONDITION;
> @@ -1706,7 +1716,7 @@ static int megasas_handle_scsi(MegasasState *s, MegasasCmd *cmd,
>      cmd->req = scsi_req_new(sdev, cmd->index, lun_id, cdb, cmd);
>      if (!cmd->req) {
>          trace_megasas_scsi_req_alloc_failed(
> -                mfi_frame_desc[frame_cmd], target_id, lun_id);
> +                mfi_frame_desc(frame_cmd), target_id, lun_id);
>          megasas_write_sense(cmd, SENSE_CODE(NO_SENSE));
>          cmd->frame->header.scsi_status = BUSY;
>          s->event_count++;
> @@ -1751,17 +1761,17 @@ static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd, int frame_cmd)
>      }
>  
>      trace_megasas_handle_io(cmd->index,
> -                            mfi_frame_desc[frame_cmd], target_id, lun_id,
> +                            mfi_frame_desc(frame_cmd), target_id, lun_id,
>                              (unsigned long)lba_start, (unsigned long)lba_count);
>      if (!sdev) {
>          trace_megasas_io_target_not_present(cmd->index,
> -            mfi_frame_desc[frame_cmd], target_id, lun_id);
> +            mfi_frame_desc(frame_cmd), target_id, lun_id);
>          return MFI_STAT_DEVICE_NOT_FOUND;
>      }
>  
>      if (cdb_len > 16) {
>          trace_megasas_scsi_invalid_cdb_len(
> -            mfi_frame_desc[frame_cmd], 1, target_id, lun_id, cdb_len);
> +            mfi_frame_desc(frame_cmd), 1, target_id, lun_id, cdb_len);
>          megasas_write_sense(cmd, SENSE_CODE(INVALID_OPCODE));
>          cmd->frame->header.scsi_status = CHECK_CONDITION;
>          s->event_count++;
> @@ -1781,7 +1791,7 @@ static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd, int frame_cmd)
>                              lun_id, cdb, cmd);
>      if (!cmd->req) {
>          trace_megasas_scsi_req_alloc_failed(
> -            mfi_frame_desc[frame_cmd], target_id, lun_id);
> +            mfi_frame_desc(frame_cmd), target_id, lun_id);
>          megasas_write_sense(cmd, SENSE_CODE(NO_SENSE));
>          cmd->frame->header.scsi_status = BUSY;
>          s->event_count++;
> 

Queued, thanks.

Paolo


