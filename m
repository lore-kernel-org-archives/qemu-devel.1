Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5AFC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF87420731
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ElbJ0tW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF87420731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYOej-0005DC-Ln
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 03:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYOdm-0004cK-8l
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57583)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYOdg-0007Fu-Uy
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604042153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zHdZqpI/x0YVahRssjC/uGsFV5joxjTo8m4CIuV6YD8=;
 b=ElbJ0tW8E2YDJux1uZQnPNniD6JwAKdC+PdzZ5ZouLn92eZir0jcD8LAd0PhpBNMeEgr8G
 lYd+EttpBR1qSUbejOqXWkO4feOwRdogq036owZT4KZ1KVTgXLbyLc+eAdKpXqVc7BA26l
 1TspCp/lQBGXGjvzoevJZuyeO4QMwzU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-sGAdQjrwMJOvak6_0aQz1Q-1; Fri, 30 Oct 2020 03:15:50 -0400
X-MC-Unique: sGAdQjrwMJOvak6_0aQz1Q-1
Received: by mail-wm1-f69.google.com with SMTP id u207so898435wmu.4
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 00:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zHdZqpI/x0YVahRssjC/uGsFV5joxjTo8m4CIuV6YD8=;
 b=hAMAPFh3d8WK+Ngoy3kyojXK69qNcGVj3DJ7apCT0FtbSeiVHrcFrwmeR/x1nfZpXO
 NUdPUYM72bRrVyeN3VuStaIWjlwvQyaX3k5h0/AX6TqElGXw1nHyynb9BFm7EP7ASW5g
 ypSGCZL3LUS+6c0bzX7igfANEZay7/R+ix/mZQF2qcEalGuYJ1LrO5elxK/KhcBl5HDV
 QI8tC0eqXOJ6nKkOBGdmnqNl3x15ENgEV+E4qRjgLpiRtGJjT9iGxkqVfQaaHnLh5y9l
 8Q5RO7SOTKaOSdRwVjFkjhFgmzjc/LNPGONbRt91OJhfbQOUUdBUu62kSHRvwW82R70S
 V6XA==
X-Gm-Message-State: AOAM5328F2V6AmBm2KCz/k9vUzaY+hDqgfpNLpGN3WiaJn6RL0GdKj/U
 4R0B2//t6/jehKNE5q34QOW3P43kXUGZdciDbV+R+9TTbg1A4NkQF502av2D/AFtgNQl7TCOvw1
 V0AJMJmsGx19qZow=
X-Received: by 2002:a7b:c1c8:: with SMTP id a8mr988701wmj.17.1604042148791;
 Fri, 30 Oct 2020 00:15:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVzxWzdd7nQojdmBe1oRVJmT+EOuWd4iMBpdldqCQ3rr6YZQ7nH0tSbr9FvHcR6aIxj2EMBQ==
X-Received: by 2002:a7b:c1c8:: with SMTP id a8mr988648wmj.17.1604042148391;
 Fri, 30 Oct 2020 00:15:48 -0700 (PDT)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id l26sm3556600wmi.39.2020.10.30.00.15.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 00:15:47 -0700 (PDT)
Subject: Re: [PATCH v8 07/11] hw/block/nvme: Support Zoned Namespace Command
 Set
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>, Keith Busch
 <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Fam Zheng <fam@euphon.net>
References: <20201030023242.5204-1-dmitry.fomichev@wdc.com>
 <20201030023242.5204-8-dmitry.fomichev@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bcdfd825-980d-ea3d-30a5-b85c0dccd01d@redhat.com>
Date: Fri, 30 Oct 2020 08:15:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201030023242.5204-8-dmitry.fomichev@wdc.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Dmitry,

On 10/30/20 3:32 AM, Dmitry Fomichev wrote:
> The emulation code has been changed to advertise NVM Command Set when
> "zoned" device property is not set (default) and Zoned Namespace
> Command Set otherwise.
> 
> Define values and structures that are needed to support Zoned
> Namespace Command Set (NVMe TP 4053) in PCI NVMe controller emulator.
> Define trace events where needed in newly introduced code.
> 
> In order to improve scalability, all open, closed and full zones
> are organized in separate linked lists. Consequently, almost all
> zone operations don't require scanning of the entire zone array
> (which potentially can be quite large) - it is only necessary to
> enumerate one or more zone lists.
> 
> Handlers for three new NVMe commands introduced in Zoned Namespace
> Command Set specification are added, namely for Zone Management
> Receive, Zone Management Send and Zone Append.
> 
> Device initialization code has been extended to create a proper
> configuration for zoned operation using device properties.
> 
> Read/Write command handler is modified to only allow writes at the
> write pointer if the namespace is zoned. For Zone Append command,
> writes implicitly happen at the write pointer and the starting write
> pointer value is returned as the result of the command. Write Zeroes
> handler is modified to add zoned checks that are identical to those
> done as a part of Write flow.
> 
> Subsequent commits in this series add ZDE support and checks for
> active and open zone limits.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Matias Bjorling <matias.bjorling@wdc.com>
> Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Reviewed-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> ---
>  block/nvme.c          |   2 +-
>  hw/block/nvme-ns.c    | 173 ++++++++
>  hw/block/nvme-ns.h    |  54 +++
>  hw/block/nvme.c       | 977 +++++++++++++++++++++++++++++++++++++++++-
>  hw/block/nvme.h       |   8 +
>  hw/block/trace-events |  18 +-
>  include/block/nvme.h  | 113 ++++-

When you start modifying include/ files, it is recommended
to start using scripts/git.orderfile as this makes review
easier (no need to scroll back / up constantly).

As "block/nvme.h" is shared by 2 subsystems, keeping its
changes in a separate patch is preferred.

>  7 files changed, 1322 insertions(+), 23 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 05485fdd11..7a513c9a17 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -333,7 +333,7 @@ static inline int nvme_translate_error(const NvmeCqe *c)
>  {
>      uint16_t status = (le16_to_cpu(c->status) >> 1) & 0xFF;
>      if (status) {
> -        trace_nvme_error(le32_to_cpu(c->result),
> +        trace_nvme_error(le32_to_cpu(c->result32),
>                           le16_to_cpu(c->sq_head),
>                           le16_to_cpu(c->sq_id),
>                           le16_to_cpu(c->cid),
...

> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 3653b4aefc..ba8a45edf5 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -489,6 +489,9 @@ enum NvmeIoCommands {
>      NVME_CMD_COMPARE            = 0x05,
>      NVME_CMD_WRITE_ZEROES       = 0x08,
>      NVME_CMD_DSM                = 0x09,
> +    NVME_CMD_ZONE_MGMT_SEND     = 0x79,
> +    NVME_CMD_ZONE_MGMT_RECV     = 0x7a,
> +    NVME_CMD_ZONE_APPEND        = 0x7d,
>  };
>  
>  typedef struct QEMU_PACKED NvmeDeleteQ {
> @@ -649,8 +652,10 @@ typedef struct QEMU_PACKED NvmeAerResult {
>  } NvmeAerResult;
>  
>  typedef struct QEMU_PACKED NvmeCqe {
> -    uint32_t    result;
> -    uint32_t    rsvd;
> +    union {
> +        uint64_t     result64;
> +        uint32_t     result32;
> +    };

When using packed structure you want to define all fields to
avoid alignment confusion (and I'm surprised the compiler doesn't
complain...). So this would be:

       union {
           uint64_t     result64;
           struct {
               uint32_t    result32;
               uint32_t    rsvd32;
           };
       };

But since the ZNS is still a technical proposal and not in the spec,
this doesn't look correct (the spec list this field as 32-bit).

What do you think about adding NvmeCqeZNS?

Maybe:

  typedef struct QEMU_PACKED NvmeCqeZNS {
      uint64_t    result;
      uint16_t    sq_head;
      uint16_t    sq_id;
      uint16_t    cid;
      uint16_t    status;
  } NvmeCqeZNS;

Or clever:

  typedef union QEMU_PACKED NvmeCqeZNS {
      union {
          struct {
              uint64_t result;
              uint32_t dw2;
              uint32_t dw3;
          };
          NvmeCqe      cqe;
      };
  } NvmeCqeZNS;

I wonder what part could go in hw/block/nvme-ns.h or "block/nvme-zns.h".

>      uint16_t    sq_head;
>      uint16_t    sq_id;
>      uint16_t    cid;
> @@ -678,6 +683,7 @@ enum NvmeStatusCodes {
>      NVME_SGL_DESCR_TYPE_INVALID = 0x0011,
>      NVME_INVALID_USE_OF_CMB     = 0x0012,
>      NVME_CMD_SET_CMB_REJECTED   = 0x002b,
> +    NVME_INVALID_CMD_SET        = 0x002c,
>      NVME_LBA_RANGE              = 0x0080,
>      NVME_CAP_EXCEEDED           = 0x0081,
>      NVME_NS_NOT_READY           = 0x0082,
> @@ -702,6 +708,14 @@ enum NvmeStatusCodes {
>      NVME_CONFLICTING_ATTRS      = 0x0180,
>      NVME_INVALID_PROT_INFO      = 0x0181,
>      NVME_WRITE_TO_RO            = 0x0182,
> +    NVME_ZONE_BOUNDARY_ERROR    = 0x01b8,
> +    NVME_ZONE_FULL              = 0x01b9,
> +    NVME_ZONE_READ_ONLY         = 0x01ba,
> +    NVME_ZONE_OFFLINE           = 0x01bb,
> +    NVME_ZONE_INVALID_WRITE     = 0x01bc,
> +    NVME_ZONE_TOO_MANY_ACTIVE   = 0x01bd,
> +    NVME_ZONE_TOO_MANY_OPEN     = 0x01be,
> +    NVME_ZONE_INVAL_TRANSITION  = 0x01bf,
>      NVME_WRITE_FAULT            = 0x0280,
>      NVME_UNRECOVERED_READ       = 0x0281,
>      NVME_E2E_GUARD_ERROR        = 0x0282,
> @@ -886,6 +900,11 @@ typedef struct QEMU_PACKED NvmeIdCtrl {
>      uint8_t     vs[1024];
>  } NvmeIdCtrl;
>  
> +typedef struct NvmeIdCtrlZoned {
> +    uint8_t     zasl;
> +    uint8_t     rsvd1[4095];
> +} NvmeIdCtrlZoned;
...


