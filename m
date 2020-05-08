Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80D4C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83FB208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evXKIwnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83FB208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWyYo-0001Cn-TI
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 04:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWyY6-0000Z1-0r
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:40:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27852
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWyY4-0003hU-Hk
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588927199;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=reH0qvTpLHYW8AWLzCTVWmAxiqSUgDgGOqWacJWsPL4=;
 b=evXKIwnnJYt27KzkER+TPMbkCWJTsrWMp3O4sn5J7u43BhYyKeGgMptZ0HCPEkUr+rsNfT
 4UEV6vIUgrvvrUhPCGcjGGwEmkoD48Fla1vQwXwb3VdYIuT9Lpa1c0Q3SuBFkpRIa4mTvD
 0jF9t0OuvYmm7iL0IbLguxoyDPYkZ20=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-CCHTlfdpOAe3q1QEbw62sw-1; Fri, 08 May 2020 04:39:55 -0400
X-MC-Unique: CCHTlfdpOAe3q1QEbw62sw-1
Received: by mail-wr1-f72.google.com with SMTP id 30so540271wrq.15
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 01:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Oums1JEin6yJ+Rlwcse4Oz5sWMkUJewVQwCMYJIC6+w=;
 b=X70Xddci+tCYNsbKdQhQTHXLI9PUMjziJlOrU5Ap1lI1Ka5S0+QY6tbqhXSTfir1gv
 PrKtaSjLnEEVtuVTmenZ3KcqC7jgFbo8bvDqnCWKSUvmyn6aRvnULqQRYRXX6wJPuiFQ
 pNI/Wo4LLNMtwtWu8GMW/1JQV4G1KyRYNbtbGFmB/sqd+NAJ0d9TsHlXWPY/OeqZhY+x
 5RAOuA3BVWTvChF8M18Qqkl7q6Xeh+sXTMPLOTGV7SUIMfrbkLL08E0I4sxAYhD3rg3/
 vTz7xoOPFLwfJ8MpyXaI2Iz4hoCZnxM1HIL9U73E9oN8TqvKyj5trK08IiQfqChDqaFr
 /FvA==
X-Gm-Message-State: AGi0PuaT77DymfwkLTIrVfIbx2Gbw/vJTmXoioN4jZzUfneWSkn6WGF0
 j86HjnTm3SCZCLRE7esBX4xp7H4k9afP3caFlkQhGGJ1SdN2HQAWSxqBwIQiZ1WFK/3FTh3yupW
 TOdVRO5/O8+e5IoA=
X-Received: by 2002:a1c:3985:: with SMTP id
 g127mr15211435wma.102.1588927194307; 
 Fri, 08 May 2020 01:39:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypIGZvQSiAVo/M2tuOGa6PEpWsThKAvLNEB70YMcWK9+Ce3x+uPZMGBN2OqDydYDc6Du++rEkg==
X-Received: by 2002:a1c:3985:: with SMTP id
 g127mr15211401wma.102.1588927194082; 
 Fri, 08 May 2020 01:39:54 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id m6sm1808275wrq.5.2020.05.08.01.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 01:39:52 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 1/2] exec: Check Xen is enabled before calling the Xen
 API
In-Reply-To: <20200508080738.2646-2-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 8 May 2020 10:07:37
 +0200")
References: <20200508080738.2646-1-philmd@redhat.com>
 <20200508080738.2646-2-philmd@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 08 May 2020 10:39:51 +0200
Message-ID: <87wo5mes6g.fsf@secure.mitica>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=quintela@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Reply-To: quintela@redhat.com
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paul Durrant <paul@xen.org>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/exec/ram_addr.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 5e59a3d8d7..dd8713179e 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -330,7 +330,9 @@ static inline void cpu_physical_memory_set_dirty_rang=
e(ram_addr_t start,
>          }
>      }
> =20
> -    xen_hvm_modified_memory(start, length);
> +    if (xen_enabled()) {
> +        xen_hvm_modified_memory(start, length);
> +    }
>  }
> =20
>  #if !defined(_WIN32)
> @@ -388,7 +390,9 @@ static inline void cpu_physical_memory_set_dirty_lebi=
tmap(unsigned long *bitmap,
>              }
>          }
> =20
> -        xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
> +        if (xen_enabled()) {
> +            xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
> +        }
>      } else {
>          uint8_t clients =3D tcg_enabled() ? DIRTY_CLIENTS_ALL : DIRTY_CL=
IENTS_NOCODE;

I don't object moving the xen code to accell.  But I think that this
change is bad.

On the following patch:
- You export xen_allowed
  (ok, it was already exported, but I think it shouldn't)

(master)$ find . -type f | xargs grep xen_allowed
./hw/xen/xen-common.c:    ac->allowed =3D &xen_allowed;
./include/hw/xen/xen.h:extern bool xen_allowed;
./include/hw/xen/xen.h:    return xen_allowed;
./softmmu/vl.c:bool xen_allowed;

This are all the users that I can find.

And xen_havm_modified_memory() is an empty function if xen is not
compiled in.  And in the case that xen is compiled in, the 1st thing
that it checks is:

   if (unlikely(xen_in_migration)) {

That is way more restrictive that xen_enabled().

So, I think that it is better to drop this patch, maintain next one, but
just un-exporting xen_allowed.

What do you think?

Later, Juan.



