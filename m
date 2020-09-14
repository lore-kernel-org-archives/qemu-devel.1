Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3967EC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 06:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFCC2078D
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 06:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMp684M4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFCC2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHi3g-00039p-EF
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 02:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHi35-0002gt-0I
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 02:33:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60882
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHi32-0005NY-Ec
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 02:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600065187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nil+6YG+W1mjfKCfY42i6jndXWuYJu5ocfcJaGt+jVY=;
 b=UMp684M4KQNORcD2xwex3Phv9SSPFvlvMLKTsWNMDqQBYmy5P7krBbFNRXpVartfNotERV
 u0ScA0ZqL93uJQLtzGx7MiNU2gAHw+al95jV3QfryODxs8Kvd9DA6tEhRlTzPOmVsO4NqD
 /BRe9LXZtQU+vrVaKFgE3wYMY8y1Pj4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-ZyMu7kCPOa6Jg2Hr9_EECw-1; Mon, 14 Sep 2020 02:33:00 -0400
X-MC-Unique: ZyMu7kCPOa6Jg2Hr9_EECw-1
Received: by mail-wr1-f71.google.com with SMTP id j7so6506577wro.14
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 23:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=nil+6YG+W1mjfKCfY42i6jndXWuYJu5ocfcJaGt+jVY=;
 b=oTJBVkNWEvsqdJjXkP5kYmWwhRcezrp8c7ZGjANPKRc1GiN8vpqS1UA4lVb60cxw1f
 rH7of5pL7cpgecHMpJ/6s7YcFb9WY02tMnN724YCnJqAMSXMO/9BtscBu3aKMTpXeK6Y
 94xxcVaiBb3G3oRvwQvonGxWqJ8f6ah+n4QtA/pnxJfjsPVK2x6zW/wb0swhTGacBEDK
 jdhQqBDHz7YaaTJ3flBZ+k+6O6cfnmb/+qLfHHG/m9+oz2+oaf+IyGDKCxlYSi/ZYqxx
 8rwz0KVBZ/eeEl9xXk2Sus9XPPVf10cQYxfAUSTOcq5MmtPPr2Et7Iu+R9BfdwGc8t6/
 JGEA==
X-Gm-Message-State: AOAM5311eT1wJbUe/R2lC9u4aWzdoY8zcf6NIIOBxBPBSuWeymtfvaLU
 3cAZxr/yP1CBUFPa/oyHf4voL2ueZEyJCfYEAZlJDG9vxKpNyrG0eExLMsbpJFrMdVzsYev3iG3
 CFS9UOayHGHv/Y/Y=
X-Received: by 2002:adf:dccd:: with SMTP id x13mr15189686wrm.403.1600065179384; 
 Sun, 13 Sep 2020 23:32:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRDJulQFpmlAVeHBaq0PDhL2U/4j0f6E9fw0sH+IS2JR7DzW/EYV7Spm7lgc12D+eU/32RLw==
X-Received: by 2002:adf:dccd:: with SMTP id x13mr15189656wrm.403.1600065179133; 
 Sun, 13 Sep 2020 23:32:59 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id l10sm17920990wmh.27.2020.09.13.23.32.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 23:32:58 -0700 (PDT)
Subject: Re: [PATCH] hw/scsi/vmw_pvscsi.c: Fix wrong usage of gboolean types
 in PVSCSIState
To: Amey Narkhede <ameynarkhede03@gmail.com>, qemu-devel@nongnu.org
References: <20200913234451.170022-1-ameynarkhede03@gmail.com>
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
Message-ID: <bee146be-e867-6c6f-4007-b61751be1e6c@redhat.com>
Date: Mon, 14 Sep 2020 08:32:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200913234451.170022-1-ameynarkhede03@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:33:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: fam@euphon.net, pbonzini@redhat.com, dmitry.fleytman@gmail.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Amey,

On 9/14/20 1:44 AM, Amey Narkhede wrote:
> rings_info_valid, msg_ring_info_valid and use_msg fields of struct
> PVSCSIState are using gboolean TRUE/FALSE values with the type uint8_t.
> Change their type to bool along with the usage of initialization macro
> VMSTATE_BOOL during initialization of vmstate_pvscsi and
> pvscsi_properties.
> 
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  hw/scsi/vmw_pvscsi.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> index c071e0c7aa..86f00e3d7e 100644
> --- a/hw/scsi/vmw_pvscsi.c
> +++ b/hw/scsi/vmw_pvscsi.c
> @@ -123,9 +123,9 @@ typedef struct {
>      /* Collector for current command data */
>      uint32_t curr_cmd_data[PVSCSI_MAX_CMD_DATA_WORDS];
> 
> -    uint8_t rings_info_valid;            /* Whether data rings initialized   */
> -    uint8_t msg_ring_info_valid;         /* Whether message ring initialized */
> -    uint8_t use_msg;                     /* Whether to use message ring      */
> +    bool rings_info_valid;            /* Whether data rings initialized   */
> +    bool msg_ring_info_valid;         /* Whether message ring initialized */
> +    bool use_msg;                     /* Whether to use message ring      */
> 
>      uint8_t msi_used;                    /* For migration compatibility      */
>      PVSCSIRingInfo rings;                /* Data transfer rings manager      */
> @@ -349,8 +349,8 @@ pvscsi_reset_state(PVSCSIState *s)
>      s->reg_command_status = PVSCSI_COMMAND_PROCESSING_SUCCEEDED;
>      s->reg_interrupt_status = 0;
>      pvscsi_ring_cleanup(&s->rings);
> -    s->rings_info_valid = FALSE;
> -    s->msg_ring_info_valid = FALSE;
> +    s->rings_info_valid = false;
> +    s->msg_ring_info_valid = false;
>      QTAILQ_INIT(&s->pending_queue);
>      QTAILQ_INIT(&s->completion_queue);
>  }
> @@ -792,7 +792,7 @@ pvscsi_on_cmd_setup_rings(PVSCSIState *s)
>      pvscsi_dbg_dump_tx_rings_config(rc);
>      pvscsi_ring_init_data(&s->rings, rc);
> 
> -    s->rings_info_valid = TRUE;
> +    s->rings_info_valid = true;
>      return PVSCSI_COMMAND_PROCESSING_SUCCEEDED;
>  }
> 
> @@ -874,7 +874,7 @@ pvscsi_on_cmd_setup_msg_ring(PVSCSIState *s)
>          if (pvscsi_ring_init_msg(&s->rings, rc) < 0) {
>              return PVSCSI_COMMAND_PROCESSING_FAILED;
>          }
> -        s->msg_ring_info_valid = TRUE;
> +        s->msg_ring_info_valid = true;
>      }
>      return sizeof(PVSCSICmdDescSetupMsgRing) / sizeof(uint32_t);
>  }
> @@ -1232,9 +1232,9 @@ static const VMStateDescription vmstate_pvscsi = {
>          VMSTATE_UINT32(curr_cmd_data_cntr, PVSCSIState),
>          VMSTATE_UINT32_ARRAY(curr_cmd_data, PVSCSIState,
>                               ARRAY_SIZE(((PVSCSIState *)NULL)->curr_cmd_data)),
> -        VMSTATE_UINT8(rings_info_valid, PVSCSIState),
> -        VMSTATE_UINT8(msg_ring_info_valid, PVSCSIState),
> -        VMSTATE_UINT8(use_msg, PVSCSIState),
> +        VMSTATE_BOOL(rings_info_valid, PVSCSIState),
> +        VMSTATE_BOOL(msg_ring_info_valid, PVSCSIState),
> +        VMSTATE_BOOL(use_msg, PVSCSIState),

I believe this change the migration data structure. This
area is described in "Changing migration data structures"
in docs/devel/migration.rst.

If this structure were not affected, your change would be
a good cleanup. However changing migration can become a
nightmare, so ... cleaning this is hard.

Cc'ing Dave (a migration maintainer) as I'm not sure there
already is a document describing easily this problem.

> 
>          VMSTATE_UINT64(rings.rs_pa, PVSCSIState),
>          VMSTATE_UINT32(rings.txr_len_mask, PVSCSIState),
> @@ -1255,7 +1255,7 @@ static const VMStateDescription vmstate_pvscsi = {
>  };
> 
>  static Property pvscsi_properties[] = {
> -    DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
> +    DEFINE_PROP_BOOL("use_msg", PVSCSIState, use_msg, true),
>      DEFINE_PROP_BIT("x-old-pci-configuration", PVSCSIState, compat_flags,
>                      PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT, false),
>      DEFINE_PROP_BIT("x-disable-pcie", PVSCSIState, compat_flags,
> --
> 2.28.0
> 
> This is my first qemu patch. Let know if there are any mistakes
> 


