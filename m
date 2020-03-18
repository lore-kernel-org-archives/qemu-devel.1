Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ED1C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 13:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BAFE20773
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 13:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFAJFYvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BAFE20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEYor-0000vi-EX
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 09:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jEYnz-0000Gn-PQ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 09:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jEYnw-00030j-37
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 09:32:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:54254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jEYnv-0002tQ-Ty
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 09:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584538335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kw5rI5e+dGrlCMYLdO5PpAk6ICcpw4NLnG7EG6iXwlM=;
 b=DFAJFYvsrFCmCRnO4SLMEZO8jI788Y19mL49NccYErCR/T7KiP7UU5gS1j9Oam4qn7RiK5
 czaY9utfTNZIrfu+TajQo6cn9vab5L9+9LsYxlnWtv+ggBJpkNlmpV0M9RQcrXtbZ7CFGZ
 sQUxpxXIM3ex36i4n8E/5BX3csIWRFU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-FuyJvhkJOKeoYq-l_jibTQ-1; Wed, 18 Mar 2020 09:32:13 -0400
X-MC-Unique: FuyJvhkJOKeoYq-l_jibTQ-1
Received: by mail-wm1-f70.google.com with SMTP id i24so1099989wml.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 06:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Kw5rI5e+dGrlCMYLdO5PpAk6ICcpw4NLnG7EG6iXwlM=;
 b=gIr3RsK8RRAKTXE1Ef8xj9Du1nZSBPt2z9y+o0V5V9WxBvRM/CrCaimVgGf6AHhLwg
 dP8de2b0A+/6NdPQb8OP1VRZXXU3a0Q1DPm7J6kO81lJuMkS+RQ14p1ESWvWpE0JXbh0
 oU9ez41q4LA4t24lz/nLJify1+Dv87ijNz9PA4LE1nFFDPhmsA7uAPDWikEuKlWYgGsK
 TZzUaLJ299tguoncfWu3zDCJvktwARxV3f5tugwYqQrKdXrFNSDyuhSwIBQjjLKVNp9C
 qQY5dhlg26eHyGAATZylSrrq7U5wBJzLqSaseQNsoGVk3W43kTNhFWeSTONvRAnL/C+/
 apjw==
X-Gm-Message-State: ANhLgQ0qtSBvvPkTYrrWF0z215aoe1CnyDE2z925WQUJHk/BzP8F3Mca
 zpo27h6De5anGj3SoIjXwytOGS+5OA0Lm49GeDKjIDQAIbPsb2lia0QZpBhJ9TCRjhwms1ROTZ9
 rjrYrVnj/H6O5mYQ=
X-Received: by 2002:adf:f5c1:: with SMTP id k1mr5698710wrp.91.1584538332234;
 Wed, 18 Mar 2020 06:32:12 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuLxWk9S9kKj/U3fY2B4rSnro0RmspLQ9dwzykLNo110Zr2uBK8lZjcQoVF8CrgKkhSKl2iCw==
X-Received: by 2002:adf:f5c1:: with SMTP id k1mr5698682wrp.91.1584538331976;
 Wed, 18 Mar 2020 06:32:11 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id y12sm3761637wmi.48.2020.03.18.06.32.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 06:32:11 -0700 (PDT)
Subject: Re: [PATCH] hw/scsi/vmw_pvscsi: Remove assertion for kick after reset
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20200315132634.113632-1-liran.alon@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <022d8abd-0bca-1d46-381f-0564a00341a4@redhat.com>
Date: Wed, 18 Mar 2020 14:32:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200315132634.113632-1-liran.alon@oracle.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: fam@euphon.net, elazar@vastdata.com, dmitry.fleytman@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/03/20 14:26, Liran Alon wrote:
> From: Elazar Leibovich <elazar.leibovich@oracle.com>
> 
> When running Ubuntu 3.13.0-65-generic guest, QEMU sometimes crashes
> during guest ACPI reset. It crashes on assert(s->rings_info_valid)
> in pvscsi_process_io().
> 
> Analyzing the crash revealed that it happens when userspace issues
> a sync during a reboot syscall.
> 
> Below are backtraces we gathered from the guests.
> 
> Guest backtrace when issuing PVSCSI_CMD_ADAPTER_RESET:
>     pci_device_shutdown
>     device_shutdown
>     init_pid_ns
>     init_pid_ns
>     kernel_power_off
>     SYSC_reboot
> 
> Guest backtrace when issuing PVSCSI_REG_OFFSET_KICK_RW_IO:
>     scsi_done
>     scsi_dispatch_cmd
>     blk_add_timer
>     scsi_request_fn
>     elv_rb_add
>     __blk_run_queue
>     queue_unplugged
>     blk_flush_plug_list
>     blk_finish_plug
>     ext4_writepages
>     set_next_entity
>     do_writepages
>     __filemap_fdatawrite_range
>     filemap_write_and_wait_range
>     ext4_sync_file
>     ext4_sync_file
>     do_fsync
>     sys_fsync
> 
> Since QEMU pvscsi should imitate VMware pvscsi device emulation,
> we decided to imitate VMware's behavior in this case.
> 
> To check VMware behavior, we wrote a kernel module that issues
> a reset to the pvscsi device and then issues a kick. We ran it on
> VMware ESXi 6.5 and it seems that it simply ignores the kick.
> Hence, we decided to ignore the kick as well.
> 
> Signed-off-by: Elazar Leibovich <elazar.leibovich@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>  hw/scsi/vmw_pvscsi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> index c91352cf46de..b2bb80449bba 100644
> --- a/hw/scsi/vmw_pvscsi.c
> +++ b/hw/scsi/vmw_pvscsi.c
> @@ -719,7 +719,12 @@ pvscsi_process_io(PVSCSIState *s)
>      PVSCSIRingReqDesc descr;
>      hwaddr next_descr_pa;
>  
> -    assert(s->rings_info_valid);
> +    if (!s->rings_info_valid) {
> +        qemu_log("WARNING: PVSCSI: Cannot process I/O when "
> +                 "rings are not valid.\n");
> +        return;
> +    }
> +
>      while ((next_descr_pa = pvscsi_ring_pop_req_descr(&s->rings)) != 0) {
>  
>          /* Only read after production index verification */
> 

Queued, with the qemu_log removed even.

Paolo


