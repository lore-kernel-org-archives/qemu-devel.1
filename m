Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48A4C38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE4A20732
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJe2fRqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE4A20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MYm-0001c9-Tb
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j6MY1-0001BI-4L
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:49:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j6MXz-0003nN-4P
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:49:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60836
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j6MXy-0003n6-R6
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582584593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TRYxEuoo8u7BtaPj6RR5zfBK2O+Be3yz0yaj1IvBzYg=;
 b=OJe2fRqVRKOvUO9Exbr8hqhVOG1+my+cJSRtjr8NoOTqo9RfkLc38MntOx+bGp4l45V0jU
 6NpA1CsdWFTod4KG2YM7m1VHiY/MkdrQyRCSaCaOA2k6HLxcEWbrYZNfK6lGH6kZEw/kAJ
 ouZXWRi0wZUzEinq1E91BBrDOlrrACc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-dN1aawDkMC-1QJKeYlSxMw-1; Mon, 24 Feb 2020 17:49:52 -0500
X-MC-Unique: dN1aawDkMC-1QJKeYlSxMw-1
Received: by mail-qv1-f70.google.com with SMTP id k2so10612398qvu.22
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:49:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EnIff+OtNnZyJaBOH7ChxRMmjs6e4U3MkG1z1EZ6FY4=;
 b=CeQwZq5cN6ofKcs4qcurOtf4h8v2IGs1YQrejoiL4zu7dEFKKSx3qkXjUjjDFH8w+v
 lpIexEYHeqCuGaTlreTN1HMx5ZGpRbfJjeRseegwEKEf3eAfAIAm9WidlsDoeQJPz330
 eFcPEY69Vod87UZcDHoqrKpoy7k2ZxsxuQw5K2+TQ8aX5a1/4Zksr17U3PJOcpKBTnqO
 QnuYw64RTxMz9VeIRQrh3x6lEZbEV0fkypHSoIltGg7yvFqFNvwzcC/6untW0MnK/t7c
 q2iN2n6q6fwQWLpkggNNQBItHd4Kd73F0pK7NDUWN1osbbviGpkvbM03ch0mStAVAcv1
 MsgQ==
X-Gm-Message-State: APjAAAVdVPBWb6OmOfIgHEqebvpd7u6j3BU7fZazFcGhN9ybzpqBxpSv
 196P0/rwjueii30jg3wmJXtNgky0su63NM3f81vNkvqlyAiZkbGznToAWuZSyYF5gK+D3ZF4lET
 IoMaWPjALxJH8LTo=
X-Received: by 2002:a37:9a88:: with SMTP id c130mr5960367qke.416.1582584591552; 
 Mon, 24 Feb 2020 14:49:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqyEykccOJEKD2w7KKOtvqNtco6MdRErsVy4/AMsgpasmUSlGhI4TV0iUvIipu4vq5JzAVAcHg==
X-Received: by 2002:a37:9a88:: with SMTP id c130mr5960353qke.416.1582584591305; 
 Mon, 24 Feb 2020 14:49:51 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id t23sm6677376qto.88.2020.02.24.14.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:49:50 -0800 (PST)
Date: Mon, 24 Feb 2020 17:49:49 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 13/13] migration/ram: Tolerate partially changed
 mappings in postcopy code
Message-ID: <20200224224949.GE113102@xz-x1>
References: <20200221164204.105570-1-david@redhat.com>
 <20200221164204.105570-14-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200221164204.105570-14-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 21, 2020 at 05:42:04PM +0100, David Hildenbrand wrote:
> When we partially change mappings (esp., mmap over parts of an existing
> mmap like qemu_ram_remap() does) where we have a userfaultfd handler
> registered, the handler will implicitly be unregistered from the parts th=
at
> changed.
>=20
> Trying to place pages onto mappings where there is no longer a handler
> registered will fail. Let's make sure that any waiter is woken up - we
> have to do that manually.
>=20
> Let's also document how UFFDIO_UNREGISTER will handle this scenario.
>=20
> This is mainly a preparation for RAM blocks with resizable allcoations,
> where the mapping of the invalid RAM range will change. The source will
> keep sending pages that are outside of the new (shrunk) RAM size. We have
> to treat these pages like they would have been migrated, but can
> essentially simply drop the content (ignore the placement error).
>=20
> Keep printing a warning on EINVAL, to avoid hiding other (programming)
> issues. ENOENT is unique.
>=20
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  migration/postcopy-ram.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>=20
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index c68caf4e42..f023830b9a 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -506,6 +506,12 @@ static int cleanup_range(RAMBlock *rb, void *opaque)
>      range_struct.start =3D (uintptr_t)host_addr;
>      range_struct.len =3D length;
> =20
> +    /*
> +     * In case the mapping was partially changed since we enabled userfa=
ult
> +     * (e.g., via qemu_ram_remap()), the userfaultfd handler was already=
 removed
> +     * for the mappings that changed. Unregistering will, however, still=
 work
> +     * and ignore mappings without a registered handler.
> +     */

Ideally we should still only unregister what we have registered.
After all we do have this information because we know what we
registered, we know what has unmapped (in your new resize() hook, when
postcopy_state=3D=3DRUNNING).

An extreme example is when we register with pages in range [A, B),
then shrink it to [A, C), then we mapped something else within [C, B)
(note, with virtio-mem logically B can be very big and C can be very
small, it means [B, C) can cover quite some address space). Then if:

  - [C, B) memory type is not compatible with uffd, or

  - [C, B) could be registered with uffd again due to some other
    reason (so far QEMU should not have such a reason)

Then the unregister could fail or misbehave, IMHO.  Another benefit is
that...

>      if (ioctl(mis->userfault_fd, UFFDIO_UNREGISTER, &range_struct)) {
>          error_report("%s: userfault unregister %s", __func__, strerror(e=
rrno));
> =20
> @@ -1180,6 +1186,17 @@ int postcopy_ram_incoming_setup(MigrationIncomingS=
tate *mis)
>      return 0;
>  }
> =20
> +static int qemu_ufd_wake_ioctl(int userfault_fd, void *host_addr,
> +                               uint64_t pagesize)
> +{
> +    struct uffdio_range range =3D {
> +        .start =3D (uint64_t)(uintptr_t)host_addr,
> +        .len =3D pagesize,
> +    };
> +
> +    return ioctl(userfault_fd, UFFDIO_WAKE, &range);
> +}
> +
>  static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
>                                 void *from_addr, uint64_t pagesize, RAMBl=
ock *rb)
>  {
> @@ -1198,6 +1215,26 @@ static int qemu_ufd_copy_ioctl(int userfault_fd, v=
oid *host_addr,
>          zero_struct.mode =3D 0;
>          ret =3D ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
>      }
> +
> +    /*
> +     * When the mapping gets partially changed (e.g., qemu_ram_remap()) =
before
> +     * we try to place a page, the userfaultfd handler will be removed f=
or the
> +     * changed mappings and placing pages will fail. We can safely ignor=
e this,
> +     * because mappings that changed on the destination don't need data =
from the
> +     * source (e.g., qemu_ram_remap()). Wake up any waiter waiting for t=
hat page
> +     * (unlikely but possible). Waking up waiters is always possible, ev=
en
> +     * without a registered userfaultfd handler.
> +     *
> +     * Old kernels report EINVAL, new kernels report ENOENT in case ther=
e is
> +     * no longer a userfaultfd handler for a mapping.
> +     */
> +    if (ret && (errno =3D=3D ENOENT || errno =3D=3D EINVAL)) {
> +        if (errno =3D=3D EINVAL) {
> +            warn_report("%s: Failed to place page %p. Waking up any wait=
ers.",
> +                         __func__, host_addr);
> +        }
> +        ret =3D qemu_ufd_wake_ioctl(userfault_fd, host_addr, pagesize);

... if with above information (takes notes on where we registered
uffd), I think we don't need to capture error, but we can simply skip
those outliers.

Thanks,

> +    }
>      if (!ret) {
>          ramblock_recv_bitmap_set_range(rb, host_addr,
>                                         pagesize / qemu_target_page_size(=
));
> --=20
> 2.24.1
>=20

--=20
Peter Xu


