Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6819CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 19:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34EC42082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 19:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiGrD5zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EC42082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixFaG-000634-AW
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 14:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixFZS-0005bk-5K
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 14:33:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixFZP-0007vz-P5
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 14:33:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26489
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixFZP-0007ut-Lg
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 14:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580412822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Ih0Xt/lNc3Sb83+N7/A5K3Je4+BthAhgIf9Y+vsgkc=;
 b=DiGrD5zu1X09S3pn7bU/Mzr9PzDzdR+XxtV6zIG4b/tOyiCwC+PXDIIdINghO35uPh8Zmn
 TxCMQuvm/k9i2mu2HOOXNuHCOuOKSbiN92JEJ4lubGBqDoskhuMCyXL0B62G/xfzZP8yW4
 FwHlwrKQbg3RL/NHyxCA7mWdqPYPtV8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-_T2OMfxqM8GGiM_EqTjRYg-1; Thu, 30 Jan 2020 14:33:39 -0500
Received: by mail-wr1-f69.google.com with SMTP id j4so2175007wrs.13
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 11:33:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iTh3S7B6OIc70IUnfml1D4BS+yZ9oXS4akyRyrJzR4U=;
 b=EssIwXV0gaB9/EwvybqVVFL1gJAf/eDbwW85+3DJvFnfhajDWLdw1IVi1azSB0GQBH
 dgW+OlDowuh0c85qhhG1X1OI/wjbIU/6LIHmqYH46jPP7pgX0wHDJjkrR+WS9E1ubZRm
 /khgovAmkgAEzmW98lfgfevcFzjJkRHDEfXYyIgHTeyungCVR8udBPA3KWw9UOrQGBRY
 ivH0Z4DASezDtgGJZg/j2s/HahsYqEHfdZEMwX9s8fYC/pModo0ANjvz1vvGw1cWOmqs
 0cI0hVHvpkoUWLXoqQH2nTJugMvVdLly3NLS1JRyoK7r/KkguAtZOd3O4I+GiYxjtiT1
 47+A==
X-Gm-Message-State: APjAAAWesj85bwSoaqV1W/dY0lS0xXygdkEN99nMiki7O7bXCDHkUQDg
 tTNnuoKw81/Q0EON/bjuj4ydwKzW+NU8hwSomacpllSKzZ+lmEpEByxyxD1naeax/LZQH4DFlVa
 PxbApBfMIr/AUjQ8=
X-Received: by 2002:a5d:5267:: with SMTP id l7mr7137715wrc.84.1580412817788;
 Thu, 30 Jan 2020 11:33:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqw3pqJnuneyI9vLnB3Ta4tfvtZZfGqqpoxn6BQl/HTprWI8xbT7SU/PUXD+zJHHawszdd08KA==
X-Received: by 2002:a5d:5267:: with SMTP id l7mr7137697wrc.84.1580412817564;
 Thu, 30 Jan 2020 11:33:37 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id z3sm8689296wrs.94.2020.01.30.11.33.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 11:33:37 -0800 (PST)
Subject: Re: [PATCH] machine/memory encryption: Disable mem merge
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com,
 brijesh.singh@amd.com
References: <20200130175046.85850-1-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2596f4f2-fb41-d8a1-a3e8-043f4edd88e0@redhat.com>
Date: Thu, 30 Jan 2020 20:33:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200130175046.85850-1-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: _T2OMfxqM8GGiM_EqTjRYg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: aarcange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/30/20 6:50 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> When a host is running with memory encryption, the memory isn't visible
> to the host kernel; attempts to merge that memory are futile because
> what it's really comparing is encrypted memory, usually encrypted
> with different keys.
>=20
> Automatically turn mem-merge off when memory encryption is specified.
>=20
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1796356
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   hw/core/machine.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>=20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 3e288bfceb..029e1f85b8 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -419,6 +419,14 @@ static void machine_set_memory_encryption(Object *ob=
j, const char *value,
>  =20
>       g_free(ms->memory_encryption);
>       ms->memory_encryption =3D g_strdup(value);
> +
> +    /*
> +     * With memory encryption, the host can't see the real contents of R=
AM,
> +     * so there's no point in it trying to merge areas.
> +     */
> +    if (value) {
> +        machine_set_mem_merge(obj, false, errp);

Using the helper is cleaner than accessing ms->mem_merge.
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +    }
>   }
>  =20
>   static bool machine_get_nvdimm(Object *obj, Error **errp)
>=20


