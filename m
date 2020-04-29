Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9961C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7AA821973
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGoQza7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7AA821973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jToIt-0000fA-Su
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 11:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jToGn-0006u6-59
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:05:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jToGl-0001vw-0t
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:05:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23285
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jToGk-0001uy-Hz
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588172700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=te1wmwpDJxNRa3PRsKVImLYJ1M4Iq/bm+X6u0M444X8=;
 b=MGoQza7JfdsvBsnvpQxblxMQBj27RhV+nzA0hde3nIrrUO9HT3ymGoBPaMVkSWewSWiUNm
 67ATT+P2kjv7IViuw5DJtdJZZ7eD6dLq423WVaX+3JdeVLnLRsvayfGrVQijOTABBbAQtK
 GHci8kL6Q8CRtaWFrd+YwkH5BTH/+CQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-54tW4IrSMmWcN3Y5fwa0jw-1; Wed, 29 Apr 2020 11:04:58 -0400
X-MC-Unique: 54tW4IrSMmWcN3Y5fwa0jw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1175B8015CB;
 Wed, 29 Apr 2020 15:04:57 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7638F5D781;
 Wed, 29 Apr 2020 15:04:55 +0000 (UTC)
Subject: Re: [PATCH 2/2] qemu-img: Add --start-offset and --max-length to map
To: Eyal Moscovici <eyal.moscovici@oracle.com>, qemu-devel@nongnu.org
References: <20200322091117.79443-1-eyal.moscovici@oracle.com>
 <20200322091117.79443-3-eyal.moscovici@oracle.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <30f82564-3807-89d4-e7b1-923868f15705@redhat.com>
Date: Wed, 29 Apr 2020 10:04:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200322091117.79443-3-eyal.moscovici@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, liran.alon@oracle.com,
 Yoav Elnekave <yoav.elnekave@oracle.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/22/20 4:11 AM, Eyal Moscovici wrote:
> The mapping operation of large disks especially ones stored over a
> long chain of QCOW2 files can take a long time to finish.
> Additionally when mapping fails there was no way recover by
> restarting the mapping from the failed location.
> 
> The new options, --start-offset and --max-length allows the user to
> divide these type of map operations into shorter independent tasks.
> 
> Acked-by: Mark Kanda <mark.kanda@oracle.com>
> Co-developed-by: Yoav Elnekave <yoav.elnekave@oracle.com>
> Signed-off-by: Yoav Elnekave <yoav.elnekave@oracle.com>
> Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com>
> ---
>   docs/tools/qemu-img.rst |  2 +-
>   qemu-img-cmds.hx        |  4 ++--
>   qemu-img.c              | 30 +++++++++++++++++++++++++++++-
>   3 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
> index 0080f83a76..924e89f679 100644
> --- a/docs/tools/qemu-img.rst
> +++ b/docs/tools/qemu-img.rst
> @@ -519,7 +519,7 @@ Command description:
>       ``ImageInfoSpecific*`` QAPI object (e.g. ``ImageInfoSpecificQCow2``
>       for qcow2 images).
>   
> -.. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [-U] FILENAME
> +.. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--start-offset=offset] [--max-length=len] [--output=OFMT] [-U] FILENAME

Consistency with the rest of the line says this should be 
[--start-offset=OFFSET] [--max-length=LEN]

>   
>     Dump the metadata of image *FILENAME* and its backing file chain.
>     In particular, this commands dumps the allocation state of every sector
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index c9c54de1df..35f832816f 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -63,9 +63,9 @@ SRST
>   ERST
>   
>   DEF("map", img_map,
> -    "map [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [-U] filename")
> +    "map [--object objectdef] [--image-opts] [-f fmt] [--start-offset=offset] [--max-length=len] [--output=ofmt] [-U] filename")

this one is fine,

>   SRST
> -.. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [-U] FILENAME
> +.. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--start-offset=OFFSET] [--max-length=LEN] [--output=OFMT] [-U] FILENAME

this one has the same problem as the .rst.

> @@ -3005,6 +3009,26 @@ static int img_map(int argc, char **argv)
>           case OPTION_OUTPUT:
>               output = optarg;
>               break;
> +        case 's':
> +            start_offset = cvtnum(optarg);
> +            if (start_offset < 0) {
> +                error_report("Invalid start offset specified! You may use "
> +                             "k, M, G, T, P or E suffixes for ");
> +                error_report("kilobytes, megabytes, gigabytes, terabytes, "
> +                             "petabytes and exabytes.");

Pre-existing elsewhere in the file, but this seems rather verbose - 
shouldn't we have cvtnum() (or another wrapper function) give this extra 
information about what is valid, rather than open-coding it at every 
client of cvtnum()?

> +                return 1;
> +            }
> +            break;
> +        case 'l':
> +            max_length = cvtnum(optarg);
> +            if (max_length < 0) {
> +                error_report("Invalid max length specified! You may use "
> +                             "k, M, G, T, P or E suffixes for ");
> +                error_report("kilobytes, megabytes, gigabytes, terabytes, "
> +                             "petabytes and exabytes.");
> +                return 1;
> +            }
> +            break;
>           case OPTION_OBJECT: {
>               QemuOpts *opts;
>               opts = qemu_opts_parse_noisily(&qemu_object_opts,
> @@ -3050,7 +3074,11 @@ static int img_map(int argc, char **argv)
>           printf("[");
>       }
>   
> +    curr.start = start_offset;
>       length = blk_getlength(blk);
> +    if (max_length != -1) {
> +        length = MIN(start_offset + max_length, length);
> +    }

Pre-existing, but where does this code check for length == -1?  But your 
MIN() doesn't make it any worse (if we fail to get length, we merely 
skip the loop).

>       while (curr.start + curr.length < length) {
>           int64_t offset = curr.start + curr.length;
>           int64_t n;
> 

Overall, the idea makes sense to me.  But I'm not sure which maintainer 
should actually incorporate the patch.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


