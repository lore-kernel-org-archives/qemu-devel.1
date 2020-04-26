Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F15C55185
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 02:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25342071E
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 02:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ON02naEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25342071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSXMy-0006dJ-UW
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 22:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jSXMK-00063N-5X
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 22:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jSXMI-00059M-Bw
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 22:49:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43905
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jSXMH-00054F-O5
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 22:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587869367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wmxglyIa1WwEoM+3ixIDVgbsaok9fb8wSAkvoRkeV/k=;
 b=ON02naEjwU+1RhULFI7spBAsjdrKVkGrEKF/9ff9YV6Nb0GdYByg8QPTRvnkRHbTvasgM/
 NMb6K+fXAvFIh8ZtJ6ljYsXWMRJ3OTBk7Ysosly+9NK9brhXDCFDzNAqmQ8kB9uc02qMED
 MB2NQ+NnS0zcNbNfrs3oow2oyy1DJO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-Ua2Zj3xsOGSFyy58LVqUog-1; Sat, 25 Apr 2020 22:49:20 -0400
X-MC-Unique: Ua2Zj3xsOGSFyy58LVqUog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47B068018A3;
 Sun, 26 Apr 2020 02:49:17 +0000 (UTC)
Received: from [10.72.13.103] (ovpn-13-103.pek2.redhat.com [10.72.13.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CA1360CD3;
 Sun, 26 Apr 2020 02:49:14 +0000 (UTC)
Subject: Re: [RFC PATCH 0/3] hw/net/tulip: Fix LP#1874539
To: Helge Deller <deller@gmx.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>
References: <20200423231644.15786-1-f4bug@amsat.org>
 <20200424152722.GA14573@ls3530.fritz.box>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1f04b513-eece-baa7-5556-4665afe1f637@redhat.com>
Date: Sun, 26 Apr 2020 10:49:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424152722.GA14573@ls3530.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/25 22:49:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/4/24 =E4=B8=8B=E5=8D=8811:27, Helge Deller wrote:
> * Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>:
>> Attempt to fix the launchpad bug filled by Helge:
>>
>>    In a qemu-system-hppa system, qemu release v5.0.0-rc,
>>    the tulip nic driver is broken.  The tulip nic is detected,
>>    even getting DHCP info does work.  But when trying to
>>    download bigger files via network, the tulip driver gets
>>    stuck.
>>
>> Philippe Mathieu-Daud=C3=A9 (3):
>>    hw/net/tulip: Fix 'Descriptor Error' definition
>>    hw/net/tulip: Log descriptor overflows
>>    hw/net/tulip: Set descriptor error bit when lenght is incorrect
>>
>>   hw/net/tulip.h |  2 +-
>>   hw/net/tulip.c | 32 ++++++++++++++++++++++++++++----
>>   2 files changed, 29 insertions(+), 5 deletions(-)
> Philippe, thanks for your efforts. Sadly your patch did not fixed the
> bug itself, but it had some nice cleanups which should be included at
> some point.
>
> Regarding the tulip hang reported by me, the patch below does fix the
> issue.
>
> [PATCH] Fix tulip rx hang
> Cc: Prasad J Pandit <pjp@fedoraproject.org>
> Fixes: 8ffb7265af ("check frame size and r/w data length")
> Buglink: https://bugs.launchpad.net/bugs/1874539
> Signed-off-by: Helge Deller <deller@gmx.de>
>
> Commit 8ffb7265af ("check frame size and r/w data length") introduced
> checks to prevent accesses outside of the rx/tx buffers. But the new
> checks were plain wrong. rx_frame_len does count backwards, and the
> surrounding code ensures that rx_frame_len will not be bigger than
> rx_frame_size. Remove those checks again.
>
> diff --git a/hw/net/tulip.c b/hw/net/tulip.c
> index 1295f51d07..59d21defcc 100644
> --- a/hw/net/tulip.c
> +++ b/hw/net/tulip.c
> @@ -171,9 +171,6 @@ static void tulip_copy_rx_bytes(TULIPState *s, struct=
 tulip_descriptor *desc)
>               len =3D s->rx_frame_len;
>           }
>
> -        if (s->rx_frame_len + len > sizeof(s->rx_frame)) {
> -            return;
> -        }
>           pci_dma_write(&s->dev, desc->buf_addr1, s->rx_frame +
>               (s->rx_frame_size - s->rx_frame_len), len);
>           s->rx_frame_len -=3D len;
> @@ -186,9 +183,6 @@ static void tulip_copy_rx_bytes(TULIPState *s, struct=
 tulip_descriptor *desc)
>               len =3D s->rx_frame_len;
>           }
>
> -        if (s->rx_frame_len + len > sizeof(s->rx_frame)) {
> -            return;
> -        }
>           pci_dma_write(&s->dev, desc->buf_addr2, s->rx_frame +
>               (s->rx_frame_size - s->rx_frame_len), len);
>           s->rx_frame_len -=3D len;
>

Looks good to me.

Would you please send a formal patch and cc Peter.

Consider we are about to release 5.0, it's better for him to apply the=20
patch directly.

Thanks


