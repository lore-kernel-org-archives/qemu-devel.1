Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19588C3815B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 10:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8F8621D95
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 10:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUrTrI3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F8621D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPO9Y-0003cQ-1N
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 06:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jPO8f-00033q-Sn
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jPO8Y-000562-HG
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:22:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39781
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jPO8Y-00054o-7x
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587118937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SwA35t28rSdYFXv6x6A3k1+oUrvz++jywNbs+bF7FdQ=;
 b=LUrTrI3ObF4/O1V9fS3HNqv1mmcEX43msn35JLwg3Mjl/j6rpiPGg1OQ2nRnbdKfJQBeRZ
 lnBA7b7B78yAHo6KWSC22vG8PBA1uZGnMKXXsBDYuuSk3nV6fKXQSAO3zwruJMOfe6WSVF
 VJWVRpjgLVu58itU6+EUeME3W4symp0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-pi4wwIIMO0SSXuhVbexsWg-1; Fri, 17 Apr 2020 06:22:15 -0400
X-MC-Unique: pi4wwIIMO0SSXuhVbexsWg-1
Received: by mail-ej1-f69.google.com with SMTP id c22so848883ejm.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 03:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gKdgUXwlBsg+JkeM4WP0bKzZHx5wC9zl81ATwb4eEtI=;
 b=kNObqJ1bXUjP8dX7RIsNZMRCinSguWMNiYBiNTcAADkssMM8/Kb05xjVOhpebsOFGD
 +GRAPXy+/Xiyay8vM69UzMeYoOJcNOsfFKr6Wxe24l3FXS1w2TJKau4PFB385wj4X8DZ
 s9n9pORykCUSFk1ajwKUh/pBW2vxOyl96Cx2eMcNsjIyrQtKofYDffKx2rSd/HaEmZuz
 jaqmQwW/rQHuvCWRwok+BIjMtw9eUT6mIEcnDkF1jUXg7H+dKMtWPuFAsZjpoGqMdJsZ
 tWVmSd89yIBiZgRcL+ZY6dYISoNk+Ve5JcscuoNpPoJwMWc1gMjg+/Egq4eqnD2kLliu
 vAnQ==
X-Gm-Message-State: AGi0PubCgYn/BqYcrJjeGcPSqZ3Crtd1MI8jorGlU0WWXjQZOT5/qz9s
 lpbj12D+yOvsCxsz+97Uddjbgo6Z+dJxV9xYcSiZ2VsbBP+oWdawWirHAvoZUuwqpqiuo/An7v2
 gDwuhAi9IysiXz44=
X-Received: by 2002:a50:9f85:: with SMTP id c5mr2218119edf.278.1587118934199; 
 Fri, 17 Apr 2020 03:22:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypKQxUpmz1+8ItnRaBgxw4i+3SWH/8QOYIMHkvhZeGcQjkPa04QIM5bdcdNlHMtNJmbfaqHgMQ==
X-Received: by 2002:a50:9f85:: with SMTP id c5mr2218098edf.278.1587118934001; 
 Fri, 17 Apr 2020 03:22:14 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id k18sm3396618ejq.84.2020.04.17.03.22.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2020 03:22:13 -0700 (PDT)
Subject: Re: [PATCH v4 01/15] util: vfio-helpers: Fix qemu_vfio_close()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200305142945.216465-1-david@redhat.com>
 <20200305142945.216465-2-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b650088d-33e4-0bba-0ce3-81aa9d41826b@redhat.com>
Date: Fri, 17 Apr 2020 12:22:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305142945.216465-2-david@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/5/20 3:29 PM, David Hildenbrand wrote:
> qemu_vfio_undo_mapping() will decrement the number of mappings and
> reshuffle the array elements to fit into the reduced size.
>=20
> Iterating over all elements like this does not work as expected, let's ma=
ke
> sure to remove all mappings properly.
>=20
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   util/vfio-helpers.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 9ec01bfe26..f31aa77ffe 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -695,13 +695,11 @@ static void qemu_vfio_reset(QEMUVFIOState *s)
>   /* Close and free the VFIO resources. */
>   void qemu_vfio_close(QEMUVFIOState *s)
>   {
> -    int i;
> -
>       if (!s) {
>           return;
>       }
> -    for (i =3D 0; i < s->nr_mappings; ++i) {
> -        qemu_vfio_undo_mapping(s, &s->mappings[i], NULL);
> +    while (s->nr_mappings) {
> +        qemu_vfio_undo_mapping(s, &s->mappings[s->nr_mappings - 1], NULL=
);
>       }
>       ram_block_notifier_remove(&s->ram_notifier);
>       qemu_vfio_reset(s);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


