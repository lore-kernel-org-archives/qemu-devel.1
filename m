Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D636CC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A380120673
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="g8goBfLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A380120673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57516 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hafyA-0007lg-TZ
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 08:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38233)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <fam@euphon.net>) id 1haft5-0004vs-81
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 08:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fam@euphon.net>) id 1haft0-0007o0-Gc
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 08:28:24 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17741
 helo=sender1.zoho.com.cn)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fam@euphon.net>)
 id 1hafsu-0007cR-6d; Tue, 11 Jun 2019 08:28:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560256008; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=FgD0qvrILtgqF0B5x8VI6KS9eCVLKC0YxTmOIV+G8WtEmZZNZvQbwEWucOERtRSzrXSi85QU6CZDyRpW4RpGZUfkmfj9Y5x2MAWVLgpTIk1qKgrOjjV3UuvaxPbMI/uREcr9TSP7mRHpZIENmav5s0e08rpC0Loelvjhgy7k2X8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1560256008;
 h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results;
 bh=8VhaJwhOiMcjOQljdRVfqwZxlkdg5keKqXWXCmW9TsQ=; 
 b=MB1zbl81rOah5p6owb5wKUulDC+iFpYgDZ/U+XQy8/wrnh6bOTGWSj87v2s6Ad66O79x38Y4fZJzhiXfkSTi7c7DnugSwl/aPRNit/IXlDR8D7dhEnBrvifC+m5SZMz0s1wo3kgE148/ikymEFe13eufJy/H7z1o14Iy6/Hvhcc=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=euphon.net;
 spf=pass  smtp.mailfrom=fam@euphon.net;
 dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1560256008; 
 s=zoho; d=euphon.net; i=fam@euphon.net;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
 l=2458; bh=8VhaJwhOiMcjOQljdRVfqwZxlkdg5keKqXWXCmW9TsQ=;
 b=g8goBfLn4G92u/fd22CC/nOB2mmHDYD6l+zOb6Eb+fPYnwcQqexgnRflKMHsfMBJ
 yGqN1RDHCmLNtaqSeNRMfKQgd8vmo/s5Knb7MJccwDmmdSgtPIA9m9VMX8qPXTb5W7C
 wRli6yD02EyqaMe3WBCO73OIgoG87uoUT+j6WpAQ=
Received: from localhost (120.52.147.48 [120.52.147.48]) by mx.zoho.com.cn
 with SMTPS id 1560256004256957.2655690367757;
 Tue, 11 Jun 2019 20:26:44 +0800 (CST)
Date: Tue, 11 Jun 2019 20:26:40 +0800
From: Fam Zheng <fam@euphon.net>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190611122640.kiwwq3jyadcakqdy@debian>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-12-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610134905.22294-12-mehta.aaru20@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ZohoCNMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 163.53.93.243
Subject: Re: [Qemu-devel] [PATCH v5 11/12] qemu-io: adds support for io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 06/10 19:19, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  qemu-io.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/qemu-io.c b/qemu-io.c
> index 8d5d5911cb..54b82151c4 100644
> --- a/qemu-io.c
> +++ b/qemu-io.c
> @@ -129,6 +129,7 @@ static void open_help(void)
>  " -n, -- disable host cache, short for -t none\n"
>  " -U, -- force shared permissions\n"
>  " -k, -- use kernel AIO implementation (on Linux only)\n"
> +" -i  -- use kernel io_uring (Linux 5.1+)\n"
>  " -t, -- use the given cache mode for the image\n"
>  " -d, -- use the given discard mode for the image\n"
>  " -o, -- options to be given to the block driver"
> @@ -188,6 +189,11 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
>          case 'k':
>              flags |= BDRV_O_NATIVE_AIO;
>              break;
> +#ifdef CONFIG_LINUX_IO_URING
> +        case 'i':

Maybe printing an error message saying the feature is not compiled in is
slightly better than just saying the argument is unknown?

Fam

> +            flags |= BDRV_O_IO_URING;
> +            break;
> +#endif
>          case 't':
>              if (bdrv_parse_cache_mode(optarg, &flags, &writethrough) < 0) {
>                  error_report("Invalid cache option: %s", optarg);
> @@ -290,6 +296,7 @@ static void usage(const char *name)
>  "  -C, --copy-on-read   enable copy-on-read\n"
>  "  -m, --misalign       misalign allocations for O_DIRECT\n"
>  "  -k, --native-aio     use kernel AIO implementation (on Linux only)\n"
> +"  -i  --io_uring       use kernel io_uring (Linux 5.1+)\n"
>  "  -t, --cache=MODE     use the given cache mode for the image\n"
>  "  -d, --discard=MODE   use the given discard mode for the image\n"
>  "  -T, --trace [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
> @@ -499,6 +506,7 @@ int main(int argc, char **argv)
>          { "copy-on-read", no_argument, NULL, 'C' },
>          { "misalign", no_argument, NULL, 'm' },
>          { "native-aio", no_argument, NULL, 'k' },
> +        { "io_uring", no_argument, NULL, 'i' },
>          { "discard", required_argument, NULL, 'd' },
>          { "cache", required_argument, NULL, 't' },
>          { "trace", required_argument, NULL, 'T' },
> @@ -566,6 +574,11 @@ int main(int argc, char **argv)
>          case 'k':
>              flags |= BDRV_O_NATIVE_AIO;
>              break;
> +#ifdef CONFIG_LINUX_IO_URING
> +        case 'i':
> +            flags |= BDRV_O_IO_URING;
> +            break;
> +#endif
>          case 't':
>              if (bdrv_parse_cache_mode(optarg, &flags, &writethrough) < 0) {
>                  error_report("Invalid cache option: %s", optarg);
> -- 
> 2.17.1
> 


