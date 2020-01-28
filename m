Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40205C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1C321739
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMbFYMY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1C321739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwOpG-00030u-1x
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 06:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwOoQ-0002LZ-1P
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:13:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwOoO-0004C7-ID
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:13:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46120
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwOoO-0004Bf-F4
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580210019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5KTRF1G5NHP+wL2HdIa7m0WVCdKa5AGli4KujKYxDZ8=;
 b=gMbFYMY89jVyHqGn/yhpKBAFLgGKOPKsTs4ZrojtuEqNJCh8iLsWqrtHXfTIqRCRpxMTE9
 Vyy3yCrmgikpCM0hbQPVoYUyEc60+ZHws7JqwAc9023M8Uh6bhF8vjXWbxxTIQbDMBok/D
 4pYKC6MlRjehYP4qfKcpKoHhfKdpAfE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-OYwC7QUqOcGCHCTyQIuKmA-1; Tue, 28 Jan 2020 06:13:37 -0500
Received: by mail-wr1-f72.google.com with SMTP id v17so7799406wrm.17
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 03:13:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v1DFQTUiMRN7FzFOeDEuoFNFmHHb8bVFGxFX3jwzuQI=;
 b=IM3KifDO67OJJi/VkCnFi7eUH7Pa8FeZ1karpG2rMa0D5i88XN73UNbI0MKsDqaVAL
 8nAE0UCUf/E7+6zE/eqU6yyxYxvO2JM03lWTCb+N1r9g4sUHpH7MmWGotSAYnhwULqMa
 /90iZcCz6Kp9N19Ypcm7pog7Ib91OfmvBh8XIkJC58ct/ptW1ds0DaekLMixvIL/0YOC
 s4XbsIbg5/J0wYAzaFl6QZDrIiAACLcxsFXD/p3foQV3dmwnryrfXfI002SLBmA4W60S
 4LRaNImExqnD7XQPJZIs9GHec57y7do7me+lZ8K16FZRW0kUMbevEqkRitgrVvGWeywa
 Xmig==
X-Gm-Message-State: APjAAAXKeQxdi/IvInKSrdV1ULTnwng8zuDJ1dVuJ982SC+UZ6FZTpV3
 m42r5xBQwBuP3PEtwyroKgr9IGX3HCX1LnWRiTPDr+4YUXk1c0B57lECMQiECPnroZgHdHWuRr/
 DeSiC083ZejjpVJ8=
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr29389305wrn.124.1580210016247; 
 Tue, 28 Jan 2020 03:13:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqz14EolL9sPVagTlXxNDTNM8Ooe+RHWTJJMI+I5m2uYWx4CKFLLQ6UxlcELO+OZfLw9ulPDog==
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr29389283wrn.124.1580210016026; 
 Tue, 28 Jan 2020 03:13:36 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id u7sm2593098wmj.3.2020.01.28.03.13.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2020 03:13:35 -0800 (PST)
Subject: Re: [PATCH v3 09/14] dp8393x: Use long-word-aligned RRA pointers in
 32-bit mode
To: Finn Thain <fthain@telegraphics.com.au>, Jason Wang
 <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <cover.1579474761.git.fthain@telegraphics.com.au>
 <b971aa27c59c56f5c7c6bfaf26080fd97bb5cb9f.1579474761.git.fthain@telegraphics.com.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ec30b6a0-a99e-9cae-fe25-a6e77d7be2f1@redhat.com>
Date: Tue, 28 Jan 2020 12:13:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b971aa27c59c56f5c7c6bfaf26080fd97bb5cb9f.1579474761.git.fthain@telegraphics.com.au>
Content-Language: en-US
X-MC-Unique: OYwC7QUqOcGCHCTyQIuKmA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/19/20 11:59 PM, Finn Thain wrote:
> Section 3.4.1 of the datasheet says,
>=20
>      The alignment of the RRA is confined to either word or long word
>      boundaries, depending upon the data width mode. In 16-bit mode,
>      the RRA must be aligned to a word boundary (A0 is always zero)
>      and in 32-bit mode, the RRA is aligned to a long word boundary
>      (A0 and A1 are always zero).
>=20
> This constraint has been implemented for 16-bit mode; implement it
> for 32-bit mode too.
>=20
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Tested-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/net/dp8393x.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index 947ceef37c..b052e2c854 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -663,12 +663,16 @@ static void dp8393x_write(void *opaque, hwaddr addr=
, uint64_t data,
>                   qemu_flush_queued_packets(qemu_get_queue(s->nic));
>               }
>               break;
> -        /* Ignore least significant bit */
> +        /* The guest is required to store aligned pointers here */
>           case SONIC_RSA:
>           case SONIC_REA:
>           case SONIC_RRP:
>           case SONIC_RWP:
> -            s->regs[reg] =3D val & 0xfffe;
> +            if (s->regs[SONIC_DCR] & SONIC_DCR_DW) {
> +                s->regs[reg] =3D val & 0xfffc;
> +            } else {
> +                s->regs[reg] =3D val & 0xfffe;
> +            }
>               break;
>           /* Invert written value for some registers */
>           case SONIC_CRCT:
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


