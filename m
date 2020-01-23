Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767DDC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 21:20:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B70821D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 21:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFVwFl7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B70821D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iujtZ-00027u-BB
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 16:20:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iujsv-0001bf-Db
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 16:19:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iujss-0007oA-L9
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 16:19:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38261
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iujss-0007jW-BW
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 16:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579814364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/VpwTFnXCzhWgYj7zPeM8qLD4NuUF9J8oCdMXRdHylY=;
 b=TFVwFl7eRABtDWp395BSLFYXlHHcQnMn7+AfAvUW9upHUanFVyc7Z7NJWgfcgtzxzX2J6a
 G4D1lZL9Frwoxh1tm/uEBPZkKgeHtPLKl0Hk7Ci+ju/RAK0pZnp/G3OoVZLRD7oLtt0RMb
 k50a8JPMet8ZH5UkZJAo6+1ir/licTQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-mnCDhZkUMICRJ_YvkTq63Q-1; Thu, 23 Jan 2020 16:19:22 -0500
Received: by mail-wr1-f71.google.com with SMTP id c6so23440wrm.18
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:19:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wq6igOSCAPqlc/64M/yAY0yxXUA+WBXmeAzAGxqJ5no=;
 b=cDVNkb6IpzLITq+EMS2s/Kfrh6jw5ixU2qPqUHsbQMOTLhfrJX8jPdkQWRro8vl7rx
 T/dLrxJIWOb4VWnx6yvCKnW3+D6yFzZedUI3cBjyYjdJkrlUgyzGZwJBu16n26L3zVhe
 SgaR67Wd9nHTE0ND0BT3PFaztJRFA7kf+48JRcrtx50DVy/MNqBlO0xe61zgU4a9eslV
 t1mVZvlSe2xodhRfr0uSYtw+9VBZGbtJo8GrVIkDhTY2UTxLNh7VT9Yu5HCWsVDXHdUs
 FMdMFKUx8TxZ2Hh+fUpzwfMupQvkK3JMPun47LA/v0EBqFMA01uTDP4z+CHBOJQdBJHM
 LZrw==
X-Gm-Message-State: APjAAAUxpmnuQ6wyspvYiErXCuo2iWTSWdvD+fW1m4qCK0gT7N8J68Br
 Zxaai68B+qQV2wcRvSjCscbpv4reqEwQC/lc/gEoPBN2FENcZm4Xqdsa98tvRgR2WjzkPKm3Kfb
 1Mc2U/+jbB4nPVhY=
X-Received: by 2002:a5d:5403:: with SMTP id g3mr38883wrv.302.1579814361451;
 Thu, 23 Jan 2020 13:19:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqw7SXdLKqL0oDufzXmvQil5hjtPJ++2ZWRrS+xt/zwwXVqyUNhpfeXCUhjND8m4fzlew3i3aw==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr38859wrv.302.1579814361107;
 Thu, 23 Jan 2020 13:19:21 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id z11sm4228436wmg.30.2020.01.23.13.19.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 13:19:20 -0800 (PST)
Subject: Re: [PATCH] iscsi: Don't access non-existent
 scsi_lba_status_descriptor
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200123170544.30117-1-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5272d2df-8289-7858-370c-2535fa33166e@redhat.com>
Date: Thu, 23 Jan 2020 22:19:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200123170544.30117-1-kwolf@redhat.com>
Content-Language: en-US
X-MC-Unique: mnCDhZkUMICRJ_YvkTq63Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: pl@kamp.de, qemu-devel@nongnu.org, mreitz@redhat.com,
 ronniesahlberg@gmail.com, felipe@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/23/20 6:05 PM, Kevin Wolf wrote:
> In iscsi_co_block_status(), we may have received num_descriptors =3D=3D 0
> from the iscsi server. Therefore, we can't unconditionally access
> lbas->descriptors[0]. Add the missing check.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/iscsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/iscsi.c b/block/iscsi.c
> index cbd57294ab..c8feaa2f0e 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -753,7 +753,7 @@ retry:
>       }
>  =20
>       lbas =3D scsi_datain_unmarshall(iTask.task);
> -    if (lbas =3D=3D NULL) {
> +    if (lbas =3D=3D NULL || lbas->num_descriptors =3D=3D 0) {
>           ret =3D -EIO;
>           goto out_unlock;
>       }
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


