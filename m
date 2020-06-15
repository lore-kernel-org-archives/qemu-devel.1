Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72838C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF482067B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imkd5Rt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF482067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkjfD-0001L4-Gd
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 03:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkjeb-0000iX-Dv
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 03:35:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26546
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkjeY-0006Fo-QM
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 03:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592206534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GK3XCrAF1t22+tzpwIxV2ZJkKM7PJ/lehVqqEMXjd+s=;
 b=imkd5Rt74ZVC8DILeBkBBXsOC32GUnQvAqAO4W09MEkaSVtv75nzW/vSUzBKY9xNnSdaD7
 IKLLdqLUK7gTTSCw5iPEN717nMIwuHpFiB+W0Dk/DDKW1+WGlKEUB6fdEnXkI8o1gYVddl
 y0BImc4t9Gcstc1OcMqYjgdSjk6oaUo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-HTq5gU0sOMKeojuFPJojMw-1; Mon, 15 Jun 2020 03:35:31 -0400
X-MC-Unique: HTq5gU0sOMKeojuFPJojMw-1
Received: by mail-wm1-f69.google.com with SMTP id u15so4660857wmm.5
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 00:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=GK3XCrAF1t22+tzpwIxV2ZJkKM7PJ/lehVqqEMXjd+s=;
 b=VEtD6bWfRNaiNIFwFL8S5vfBzFtlqxu/TpmiK12vPG/IPvoYmOvTLpYAktc7OqrHIL
 /vv9JCUFQkJmY0+arUUVWxCnY60zrkbjYokijZ2Be8p3nO/fg2r3+zn0/2WLfvFezc41
 t0JdMKXV0oCcw2gkx5ZhBDnPQWgnnBgZ/nmeqIoEoHUVD0SKSKsTOKGS6+S6XUC3PcEq
 vaZaSwxiao+K3eu1wEUisoL24izOGmNqHHZ68J+bBBEjv4tcrdo/PnajpucqtHQlKMbR
 /o/jscPYk0GA9ETuEKS/BSYXs2d6TTqanFNLO2miCK66xXLTu6oIZbYq1G5UW5i3Jj5W
 41MA==
X-Gm-Message-State: AOAM531UG44jB5evkj0xkRJoW2jo30ctWh82uzhJjpO3XlDnrvyi/Xrb
 jBfdTkQ9o/BD6kdm7NnucTdTj1FM0ScQxafPwICHrHOhrGI7TIHHjyx8oONUV5iGEpe5HSRWcm7
 SxXqiOq3jVMvmJOQ=
X-Received: by 2002:adf:e648:: with SMTP id b8mr28216402wrn.386.1592206530709; 
 Mon, 15 Jun 2020 00:35:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyScFD1e69XCs8BpJeSOg9JJDVTXRB5NZgFc2ifWUSwQrr3D1DhCz1AKdweYUq/NhF8JeKHow==
X-Received: by 2002:adf:e648:: with SMTP id b8mr28216384wrn.386.1592206530457; 
 Mon, 15 Jun 2020 00:35:30 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q4sm5651411wmc.1.2020.06.15.00.35.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 00:35:30 -0700 (PDT)
Subject: Re: [PATCH] hw/scsi/megasas: Fix possible out-of-bounds array access
 in tracepoints
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Hannes Reinecke <hare@suse.com>
References: <20200615072629.32321-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <61e995c8-8dd1-3df5-1450-e8061a2e09b7@redhat.com>
Date: Mon, 15 Jun 2020 09:35:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200615072629.32321-1-thuth@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 9:26 AM, Thomas Huth wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


