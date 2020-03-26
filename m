Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C648AC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 18:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9521120722
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 18:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dI+cIHCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9521120722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHXNd-00043F-Pe
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 14:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jHXMy-0003HV-4L
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 14:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jHXMw-0007C2-Lj
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 14:36:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jHXMw-0007AS-GW
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 14:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585247801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pMLLbJTqbB6p96Y80HKysj5X0PAjsUXlDV/67qsA8Sg=;
 b=dI+cIHCiNVD7NLrF/31KLEkaWjC2oi1qLMneR3jIAyT1+En07+P6EyXvdSXRENghIQqmBj
 mBso5R1YpJ4vxJkLShT2CWp4wyWOjSfzMbeAkT3+qWVetbxJsJQafbYknbHXGZ5cokAegp
 7wk5GrNkxLesiufqZfIiHYuUYW9kq6k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-YTENKwI_PAmAAGps4lQGLQ-1; Thu, 26 Mar 2020 14:36:39 -0400
X-MC-Unique: YTENKwI_PAmAAGps4lQGLQ-1
Received: by mail-ed1-f72.google.com with SMTP id bm26so5856107edb.4
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 11:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dQyl+oUsa+TVpgdWd62dANfOOHC5KvCAvhKACVABjvc=;
 b=mL8ZN6cUw/TCagJp7p4VqnW/VDS0IOgMtVPWErUTLO9ZavMMEXftpf1ea3dHIfqVlb
 gUXgmxuRAaJtgTS3AnvRMOWrsYnhxxY0pEhI77GCgHlqljy0T355RhHbp0/48ppc2aon
 78aaijHNmbargC1l8ypXdOJo4KTdYhSefueGjIq6jgfDJLajNZuQA7f2ZiV/4g+a3fbk
 4zZQmR69OZnJTZencKBhQWGQSmorxC1UMN1P5Sbij8V/rT/7x01UYDOc4z5hhTDVlCSD
 fnv37l9gWccnSovY16md7hmdbOEJ3T6cFA+a5vRcdhdJYidbuaSLIJlcLZ0AtmBZcUrg
 Q7VA==
X-Gm-Message-State: ANhLgQ1tj0th159jbLc4X+BLugNmZ8J8bDYyJIIhzxzo8vyae2z6Zex1
 IhLtE77wVwT1AuHiunXpRqkU7zhEVtzS4IZxgXJ+6yCiyTgBFOAjhKdJRHY0vEwx4EChog9Scuz
 uORQYcEKZtV6dRes=
X-Received: by 2002:a17:906:858c:: with SMTP id
 v12mr9317658ejx.126.1585247798463; 
 Thu, 26 Mar 2020 11:36:38 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vso45c7hkxTcbUirE61vnizKLBZRaTIglt5dUthNMS+OXfzaG6njdtXwQzY5nYwRVsLVuspdQ==
X-Received: by 2002:a17:906:858c:: with SMTP id
 v12mr9317631ejx.126.1585247798190; 
 Thu, 26 Mar 2020 11:36:38 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id e4sm462889edu.87.2020.03.26.11.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2020 11:36:37 -0700 (PDT)
Subject: Re: [PATCH] qcow2: Remove unused fields from BDRVQcow2State
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200326170757.12344-1-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8fb8edff-ad13-1709-f1f9-62e59fc684c2@redhat.com>
Date: Thu, 26 Mar 2020 19:36:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200326170757.12344-1-kwolf@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/26/20 6:07 PM, Kevin Wolf wrote:
> These fields were already removed in commit c3c10f72, but then commit
> b58deb34 revived them probably due to bad merge conflict resolution.
> They are still unused, so remove them again.
>=20
> Fixes: b58deb344ddff3b9d8b265bf73a65274767ee5f4
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/qcow2.h | 3 ---
>   1 file changed, 3 deletions(-)
>=20
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 0942126232..f4de0a27d5 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -301,9 +301,6 @@ typedef struct BDRVQcow2State {
>       QEMUTimer *cache_clean_timer;
>       unsigned cache_clean_interval;
>  =20
> -    uint8_t *cluster_cache;
> -    uint8_t *cluster_data;
> -    uint64_t cluster_cache_offset;
>       QLIST_HEAD(, QCowL2Meta) cluster_allocs;
>  =20
>       uint64_t *refcount_table;
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


