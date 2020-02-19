Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0B2C5ACC4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 22:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4786A20656
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 22:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVJZOBm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4786A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Y7x-0008UV-FM
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 17:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4Y6r-00082E-S0
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 17:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4Y6p-0007qY-J2
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 17:46:24 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58141
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4Y6p-0007nl-8a
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 17:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582152382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pEso4mTHMcDwieys0dG8/MXEj/+DIKukBlt1h0130dU=;
 b=hVJZOBm76gjBycpG/FMjpzLCuEX7/2qWk/1mk4b25GZAWmw4/8KcDDBI71zcap7AV+laKF
 x0gBZDyyXXqEAOoMr9cFnRqUWKG/MjcMw6L6CDksc+np8XYCflnapvlu6Vwx8FaDYFZbh9
 WaLQhI13HjzgOIMIQdeByfboQwc3aV0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-58rHfUxZNp65Ym1iG6Sf6g-1; Wed, 19 Feb 2020 17:46:20 -0500
Received: by mail-qv1-f70.google.com with SMTP id g9so1271097qvy.20
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 14:46:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yJhSB8FbOHFBu2i/WPXquroSmjSJzwSJ9Twvj4FR4RA=;
 b=ClQp6lD7kISSMhiLf3hDVh+D5S0m+LldK4gr7f3LUFzTqEbePBjNR1G2MIOzoifiWh
 i9MehbV6OTS0Uz19LKOQ+GVwRq7R+Kam0h7Nj+FHF3giL8/7g7JQZ/DyLdgSlZKK74Qy
 fYNEAU5ITggl5sPBG3ZIwEVRaIw++pReLbOd16a1fM3Zz4J97nlLE9bz+2JcCBEx3Kks
 QoKXAcS/VDIUqB5AQI8ehS/Sc4ANpMgiUxBtZZYnfuv5hFC1tSUTo1na8pNc1wQ3p9NS
 ja8Efby/75D7RgjEeTXGPK42zj5qY5oLRaLoflOWv1lxgnsGMXfsFIxi4GXj0MJqkL2i
 wuMQ==
X-Gm-Message-State: APjAAAVlpaLHhJ25eW7DxI4ClcIzm+QlNHrlwTyK9NeOUfAgZGtaMDvZ
 I1njx2OHkYQtvbvMh/T0vuqJt+ibsa3+42ajRWi75ZeINfGRdi+j0AJIoUGqytz8x39VxbcQF/m
 3n7f5UZ9Lat5GN24=
X-Received: by 2002:a0c:fa43:: with SMTP id k3mr22592401qvo.229.1582152379725; 
 Wed, 19 Feb 2020 14:46:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqzPeJbY7+7MwbhUdplNJvhgzYiFMCf0UiaPLdsHwshLkpIAalJi86XWcMeRl2M6L2B9euJaAQ==
X-Received: by 2002:a0c:fa43:: with SMTP id k3mr22592381qvo.229.1582152379409; 
 Wed, 19 Feb 2020 14:46:19 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id n191sm628766qkn.6.2020.02.19.14.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 14:46:18 -0800 (PST)
Date: Wed, 19 Feb 2020 17:46:16 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 fixed 08/16] util/mmap-alloc: Factor out calculation
 of pagesize to mmap_pagesize()
Message-ID: <20200219224616.GA42076@xz-x1>
References: <20200212134254.11073-1-david@redhat.com>
 <20200212134254.11073-9-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200212134254.11073-9-david@redhat.com>
X-MC-Unique: 58rHfUxZNp65Ym1iG6Sf6g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 02:42:46PM +0100, David Hildenbrand wrote:
> Factor it out and add a comment.
>=20
> Reviewed-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
> Acked-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  util/mmap-alloc.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>=20
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index 27dcccd8ec..82f02a2cec 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -82,17 +82,27 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
>      return qemu_real_host_page_size;
>  }
> =20
> +static inline size_t mmap_pagesize(int fd)
> +{
> +#if defined(__powerpc64__) && defined(__linux__)
> +    /* Mappings in the same segment must share the same page size */
> +    return qemu_fd_getpagesize(fd);
> +#else
> +    return qemu_real_host_page_size;
> +#endif
> +}

Pure question: This will return 4K even for huge pages on x86, is this
what we want?

This is of course not related to this specific patch which still
follows the old code, but I'm thinking whether it was intended or not
even in the old code (or is there anything to do with the
MAP_NORESERVE fix for ppc64 huge pages?).  Do you know the answer?

Thanks,

> +
>  void *qemu_ram_mmap(int fd,
>                      size_t size,
>                      size_t align,
>                      bool shared,
>                      bool is_pmem)
>  {
> +    const size_t pagesize =3D mmap_pagesize(fd);
>      int flags;
>      int map_sync_flags =3D 0;
>      int guardfd;
>      size_t offset;
> -    size_t pagesize;
>      size_t total;
>      void *guardptr;
>      void *ptr;
> @@ -113,7 +123,6 @@ void *qemu_ram_mmap(int fd,
>       * anonymous memory is OK.
>       */
>      flags =3D MAP_PRIVATE;
> -    pagesize =3D qemu_fd_getpagesize(fd);
>      if (fd =3D=3D -1 || pagesize =3D=3D qemu_real_host_page_size) {
>          guardfd =3D -1;
>          flags |=3D MAP_ANONYMOUS;
> @@ -123,7 +132,6 @@ void *qemu_ram_mmap(int fd,
>      }
>  #else
>      guardfd =3D -1;
> -    pagesize =3D qemu_real_host_page_size;
>      flags =3D MAP_PRIVATE | MAP_ANONYMOUS;
>  #endif
> =20
> @@ -198,15 +206,10 @@ void *qemu_ram_mmap(int fd,
> =20
>  void qemu_ram_munmap(int fd, void *ptr, size_t size)
>  {
> -    size_t pagesize;
> +    const size_t pagesize =3D mmap_pagesize(fd);
> =20
>      if (ptr) {
>          /* Unmap both the RAM block and the guard page */
> -#if defined(__powerpc64__) && defined(__linux__)
> -        pagesize =3D qemu_fd_getpagesize(fd);
> -#else
> -        pagesize =3D qemu_real_host_page_size;
> -#endif
>          munmap(ptr, size + pagesize);
>      }
>  }
> --=20
> 2.24.1
>=20
>=20

--=20
Peter Xu


