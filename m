Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8782DC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:33:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E75020661
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XytNKc7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E75020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyyKa-0003LL-Fu
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 08:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iyyJ6-0002SG-Bm
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:32:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iyyJ5-0001zm-5H
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:32:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33292
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iyyJ5-0001x9-0R
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580823118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5UY51IfsVeieO+t1ylYvZ3qXL1UrSAws1s/pdF5iGk8=;
 b=XytNKc7TNKlxS1rapNTXYYa7pAsd9NhsRciaNAMvEK7caslChK4nM7B4SHe1TTlPOQPQ/S
 DiZAtsYaoCj9mgyKWCsUhnsSak7VRx5YNj1SaIng0i4oqykXZdfWGY0zy+nWuK8PRiGutL
 VL0400VFjpbwUZGRbIOc3oNfsnWC9HA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-C5tO_kMfOXG1Muq4wMfWGw-1; Tue, 04 Feb 2020 08:31:54 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3FF1107B116;
 Tue,  4 Feb 2020 13:31:53 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7659787B1D;
 Tue,  4 Feb 2020 13:31:53 +0000 (UTC)
Subject: Re: [PATCH v3 1/1] qemu-img: Add --target-is-zero to convert
To: David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org
References: <20200204095246.1974117-1-david.edmondson@oracle.com>
 <20200204095246.1974117-2-david.edmondson@oracle.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <90f3f74b-6154-d7ce-4e0e-ba4422f7da11@redhat.com>
Date: Tue, 4 Feb 2020 07:31:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204095246.1974117-2-david.edmondson@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: C5tO_kMfOXG1Muq4wMfWGw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 3:52 AM, David Edmondson wrote:
> In many cases the target of a convert operation is a newly provisioned
> target that the user knows is blank (filled with zeroes). In this

'filled with zeroes' is accurate for a preallocated image, but reads 
awkwardly for a sparse image; it might be better to state 'reads as zero'.

> situation there is no requirement for qemu-img to wastefully zero out
> the entire device.
> 
> Add a new option, --target-is-zero, allowing the user to indicate that
> an existing target device is already zero filled.
> 
> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> ---
>   docs/interop/qemu-img.rst |  8 +++++++-
>   qemu-img-cmds.hx          |  4 ++--
>   qemu-img.c                | 25 ++++++++++++++++++++++---
>   3 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/interop/qemu-img.rst b/docs/interop/qemu-img.rst
> index fa27e5c7b453..99bdbe4740ee 100644
> --- a/docs/interop/qemu-img.rst
> +++ b/docs/interop/qemu-img.rst
> @@ -214,6 +214,12 @@ Parameters to convert subcommand:
>     will still be printed.  Areas that cannot be read from the source will be
>     treated as containing only zeroes.
>   
> +.. option:: --target-is-zero
> +
> +  Assume that the destination is filled with zeros. This parameter is

Spelled 'zeroes' just three lines earlier.

> +  mutually exclusive with the use of a backing file. It is required to
> +  also use the ``-n`` parameter to skip image creation.

I understand that it is safer to have restrictions now and lift them 
later, than to allow use of the option at any time and leave room for 
the user to shoot themselves in the foot with no way to add safety 
later.  The argument against no backing file is somewhat understandable 
(technically, as long as the backing file also reads as all zeroes, then 
the overall image reads as all zeroes - but why have a backing file that 
has no content?); the argument requiring -n is a bit weaker (if I'm 
creating an image, I _know_ it reads as all zeroes, so the 
--target-is-zero argument is redundant, but it shouldn't hurt to allow it).

> +++ b/qemu-img.c

> @@ -2247,6 +2256,11 @@ static int img_convert(int argc, char **argv)
>           warn_report("This will become an error in future QEMU versions.");
>       }
>   
> +    if (s.has_zero_init && !skip_create) {
> +        error_report("--target-is-zero requires use of -n flag");
> +        goto fail_getopt;
> +    }

So I think we could drop this hunk with no change in behavior.

> +
>       s.src_num = argc - optind - 1;
>       out_filename = s.src_num >= 1 ? argv[argc - 1] : NULL;
>   
> @@ -2380,6 +2394,11 @@ static int img_convert(int argc, char **argv)
>       }
>       s.target_has_backing = (bool) out_baseimg;
>   
> +    if (s.has_zero_init && s.target_has_backing) {
> +        error_report("Cannot use --target-is-zero with a backing file");
> +        goto out;
> +    }
> +

while keeping this one makes sense.  At any rate, typo fixes are minor, 
and whether or not we drop the hunk I claim is a needless restriction 
against redundancy,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


