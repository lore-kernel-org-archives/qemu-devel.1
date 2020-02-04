Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E198C3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 04:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA3420732
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 04:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORkld7zy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA3420732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iypWm-0004Mh-2V
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 23:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iypW3-0003V3-90
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 23:08:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iypW1-00008T-R5
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 23:08:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34786
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iypW1-0008Vy-M2
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 23:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580789324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dGseqyyT5I3Ml1CbFhH/fpXJe1RzR93/pP6FMGd9cv0=;
 b=ORkld7zyYu98JhOJLCrlogONLYRWwXejY0jrennhBX7W5KF4BG7c70mUY0OJYbvahdUSyU
 OqWP1WWLAhlwzrhoF8mkNdty2fXhlUA7xIXJ6oCLNNy+poDBsEYPUauRlsxRDP+NPrxvQG
 w8+9+Bn5qzh1qaSlGyxbeRnr+sgqlqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-0NbvHT4PPXmzRt01FhfTHw-1; Mon, 03 Feb 2020 23:08:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93E921084420;
 Tue,  4 Feb 2020 04:08:41 +0000 (UTC)
Received: from [10.72.12.170] (ovpn-12-170.pek2.redhat.com [10.72.12.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F09FB8EA0C;
 Tue,  4 Feb 2020 04:08:39 +0000 (UTC)
Subject: Re: [PATCH] e1000e: Avoid hw_error if legacy mode used
To: Yuri Benditovich <yuri.benditovich@daynix.com>,
 dmitry.fleytman@gmail.com, qemu-devel@nongnu.org
References: <20200127160312.31367-1-yuri.benditovich@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <03f0e2bd-87bd-21a9-1583-2881862808c8@redhat.com>
Date: Tue, 4 Feb 2020 12:08:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200127160312.31367-1-yuri.benditovich@daynix.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 0NbvHT4PPXmzRt01FhfTHw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/1/28 =E4=B8=8A=E5=8D=8812:03, Yuri Benditovich wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1787142
> The emulation issues hw_error if PSRCTL register
> is written, for example, with zero value.
> Such configuration does not present any problem when
> DTYP bits of RCTL register define legacy format of
> transfer descriptors. Current commit discards check
> for BSIZE0 and BSIZE1 when legacy mode used.
>
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>   hw/net/e1000e_core.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 5b05c8ea8a..94ea34dca5 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -2813,12 +2813,15 @@ e1000e_set_eitr(E1000ECore *core, int index, uint=
32_t val)
>   static void
>   e1000e_set_psrctl(E1000ECore *core, int index, uint32_t val)
>   {
> -    if ((val & E1000_PSRCTL_BSIZE0_MASK) =3D=3D 0) {
> -        hw_error("e1000e: PSRCTL.BSIZE0 cannot be zero");
> -    }
> +    if (core->mac[RCTL] & E1000_RCTL_DTYP_MASK) {
> +
> +        if ((val & E1000_PSRCTL_BSIZE0_MASK) =3D=3D 0) {
> +            hw_error("e1000e: PSRCTL.BSIZE0 cannot be zero");
> +        }
>  =20
> -    if ((val & E1000_PSRCTL_BSIZE1_MASK) =3D=3D 0) {
> -        hw_error("e1000e: PSRCTL.BSIZE1 cannot be zero");
> +        if ((val & E1000_PSRCTL_BSIZE1_MASK) =3D=3D 0) {
> +            hw_error("e1000e: PSRCTL.BSIZE1 cannot be zero");
> +        }
>       }
>  =20
>       core->mac[PSRCTL] =3D val;


Applied.

Thanks


