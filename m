Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7053AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 18:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B87B207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 18:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLcP6ukw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B87B207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnnZ1-0008H0-FT
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 14:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jnnYG-00070Y-HJ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 14:21:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21120
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jnnYE-0001nb-CU
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 14:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592936498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfgnWErQiBEj++RtmHqXcckhk4i5tvf7X2LMrPEWeE0=;
 b=bLcP6ukwF73padj73AJCH9EQf/FfY7uyhQnbxUUpOguVpdLOMyfLqLeMaFaCD96dQolnp9
 QwJ6oHjfE3Gffyni9F6y/ijXVLa3Bi7a5IX5t8L0zp76ROCXjvsqQvbC/8u0j/HHg0YB5f
 DSMGlzfgnjMlBIgJsXtqNwin7qf8Ogo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-YyAWeFcENliNDTnTrkDP9w-1; Tue, 23 Jun 2020 14:21:23 -0400
X-MC-Unique: YyAWeFcENliNDTnTrkDP9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D4DD18A0761;
 Tue, 23 Jun 2020 18:21:22 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A97853C6B;
 Tue, 23 Jun 2020 18:21:21 +0000 (UTC)
Subject: Re: [PATCH 1/2] vvfat: Check that updated filenames are valid
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200623175534.38286-1-kwolf@redhat.com>
 <20200623175534.38286-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <33941063-cfcc-002b-5fe8-d37050d8e532@redhat.com>
Date: Tue, 23 Jun 2020 13:21:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623175534.38286-2-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: nhuck15@gmail.com, qemu-devel@nongnu.org, ppandit@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 12:55 PM, Kevin Wolf wrote:
> FAT allows only a restricted set of characters in file names, and for
> some of the illegal characters, it's actually important that we catch
> them: If filenames can contain '/', the guest can construct filenames
> containing "../" and escape from the assigned vvfat directory. The same
> problem could arise if ".." was ever accepted as a literal filename.
> 
> Fix this by adding a check that all filenames are valid in
> check_directory_consistency().
> 
> Reported-by: Nathan Huckleberry <nhuck15@gmail.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/vvfat.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index c65a98e3ee..2fab371258 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -520,6 +520,25 @@ static void set_begin_of_direntry(direntry_t* direntry, uint32_t begin)
>       direntry->begin_hi = cpu_to_le16((begin >> 16) & 0xffff);
>   }
>   
> +static bool valid_filename(const unsigned char *name)
> +{
> +    unsigned char c;
> +    if (!strcmp((const char*)name, ".") || !strcmp((const char*)name, "..")) {
> +        return false;
> +    }
> +    for (; (c = *name); name++) {
> +        if (!((c >= '0' && c <= '9') ||
> +              (c >= 'A' && c <= 'Z') ||
> +              (c >= 'a' && c <= 'z') ||
> +              c > 127 ||
> +              strchr("$%'-_@~`!(){}^#&.+,;=[]", c) != 0))

s/0/NULL/

Hmm - would it be any more efficient to use a single comparison of 
strcspn() vs. strlen(), where you merely spell out the bytes that are 
rejected?  Out of 256 byte values, NUL is implicitly rejected (since 
these are C strings), the 128 high-bit bytes are all valid, and you have 
permitted 62 alnum and 23 other characters; that leaves merely 42 byte 
values to explicitly list in a reject string.  Of course, writing the 
string literal containing those 42 invalid bytes is itself a bit of an 
exercise in reading the ASCII table:

"\x01\x02\x03\x04\x05\x06\x07"
"\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f"
"\x10\x11\x12\x13\x14\x15\x16\x17"
"\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
" \"*/:<>?\\|\x7f"

> +        {
> +            return false;
> +        }
> +    }
> +    return true;
> +}
> +
>   static uint8_t to_valid_short_char(gunichar c)
>   {
>       c = g_unichar_toupper(c);
> @@ -2098,6 +2117,10 @@ DLOG(fprintf(stderr, "check direntry %d:\n", i); print_direntry(direntries + i))
>               }
>               lfn.checksum = 0x100; /* cannot use long name twice */
>   
> +            if (!valid_filename(lfn.name)) {
> +                fprintf(stderr, "Invalid file name\n");

Wow, the fact that we are still using fprintf is annoying, but pre-existing.

> +                goto fail;
> +            }
>               if (path_len + 1 + lfn.len >= PATH_MAX) {
>                   fprintf(stderr, "Name too long: %s/%s\n", path, lfn.name);
>                   goto fail;
> 

At any rate, the idea makes sense. If you don't like my strcspn() idea, 
then:
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


