Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA16DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75FA6206F6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J23XY9UN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FA6206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnDt-0002T8-OE
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbnD2-0001Wo-Fj
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:34:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55261
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbnD0-00077S-JG
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590075249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VIe7T/c0n/LRb4ytd8geZ+MtSpnjSSIIvewJnJ8yqT0=;
 b=J23XY9UNXbWRZT3wPfLueWqsRkIxTdDLuSA42C7VAFLWf72Q9qjpULgAFW2tTRRfRBLBIa
 hXHPiCG4PMbpZCFrNxT9meMBpFnt/NqorAcEYEOszMgjquwRl4NPtQle88yV8AjC8twThy
 9hhSdgen/xVJ4rd4VevKCQAG9/fqKiw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-VQmjbP13PNmK47n7linTvQ-1; Thu, 21 May 2020 11:34:04 -0400
X-MC-Unique: VQmjbP13PNmK47n7linTvQ-1
Received: by mail-wr1-f69.google.com with SMTP id p8so3072918wrj.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 08:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VIe7T/c0n/LRb4ytd8geZ+MtSpnjSSIIvewJnJ8yqT0=;
 b=H3GWo+6r/OMW23tNdGSgZnh6S/OM0Yll7w5lc/tmkmpENX/tXMnc/mD8qbllRSRyZ4
 2GQOtFqx4+xMEIVAhDZgO0JTau2vhkErNOnsROtFk5L85/NyT7YkBY1sTOOwnXhCHcqj
 zTAYNm1/T/BeiKzdYbpRA4jP6EDjErhPbhEhjuxV0L5p99Qad6T6uyOAVKUgAj5h4TYT
 cTefoZQEPP7ov+Z/W3XoIsHr+hz29uoAJyICTtcpFh9UGTmmG4mEfgcndl5e8yQDM94Q
 +ME1TsaqKQE/qwRwh9uQAhUCgQJSii6l6YdhiEem3ojVQLtUlGsgnoDaG4jPbKCdSQt4
 sEhA==
X-Gm-Message-State: AOAM531CFoMp/Lvr4CPUwiHi8UGDS1YGXKrMeqdWfBWyQ2Mi6quiWfNT
 bAtSs2aadQQXGB6x0ANdWf1StiChztZdF07nGwqqyCkHWM62OmuicCX0QLzri9b4f4Ld1xJptRG
 ZP4xGSEjSDxZTLNc=
X-Received: by 2002:a1c:b604:: with SMTP id g4mr9232084wmf.103.1590075243612; 
 Thu, 21 May 2020 08:34:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgd3Yd+fIwblUaSja05UH77+yuV0lLVmIq5K14JZ6EHhv0B267cOpq0sNO/7iyRzK+teB4pg==
X-Received: by 2002:a1c:b604:: with SMTP id g4mr9232065wmf.103.1590075243382; 
 Thu, 21 May 2020 08:34:03 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.160.154])
 by smtp.gmail.com with ESMTPSA id g69sm2051475wmg.15.2020.05.21.08.34.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 08:34:02 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] megasas: avoid NULL pointer dereference
To: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
References: <20200513192540.1583887-1-ppandit@redhat.com>
 <20200513192540.1583887-3-ppandit@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <defefce8-72f2-65c2-04cf-918f3697532a@redhat.com>
Date: Thu, 21 May 2020 17:34:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200513192540.1583887-3-ppandit@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Prasad J Pandit <pjp@fedoraproject.org>,
 Alexander Bulekov <alxndr@bu.edu>, Ding Ren <rding@gatech.edu>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/05/20 21:25, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While in megasas_handle_frame(), megasas_enqueue_frame() may
> set a NULL frame into MegasasCmd object for a given 'frame_addr'
> address. Add check to avoid a NULL pointer dereference issue.
> 
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1878259
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/scsi/megasas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index 6ce598cd69..b531d88a9b 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -504,7 +504,7 @@ static MegasasCmd *megasas_enqueue_frame(MegasasState *s,
>      cmd->pa = frame;
>      /* Map all possible frames */
>      cmd->frame = pci_dma_map(pcid, frame, &frame_size_p, 0);
> -    if (frame_size_p != frame_size) {
> +    if (!cmd->frame || frame_size_p != frame_size) {
>          trace_megasas_qf_map_failed(cmd->index, (unsigned long)frame);
>          if (cmd->frame) {
>              megasas_unmap_frame(s, cmd);
> -- 2.25.4
> 

I think the code here was expecting frame_size_p to be 0 if cmd->frame
is NULL.  Can you check why this is not the case, or whether it ever was
the case?

Thanks,

Paolo


