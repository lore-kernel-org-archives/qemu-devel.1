Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40477ECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B8220820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSKuQwRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B8220820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9p0-0001H1-30
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1iL9nA-0008E0-PC
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 13:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1iL9n9-0003MM-MO
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 13:42:28 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:47017)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1iL9n9-0003MG-HQ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 13:42:27 -0400
Received: by mail-qk1-x742.google.com with SMTP id e66so2628570qkf.13
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 10:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=iS3jBKlKNmJcUQrVHSpndb/mI7IBZoOqYkVGxAz9lYw=;
 b=GSKuQwRbTe1OmxzIcESB8RA5gpEr7lw8j+ZyVSdxFWR3swp32c0yvBoVnAXTqi0/3x
 hn9DGhnrWbX0lHKN2CiRRkwI8c3wJzakmUMLOGi1oRHNjSVqTW9ldEXIpV5HLSzcIp/D
 OXBfAM6yQ2DWb69NdGCDYG4BBW4LzT4ZafHW6jta8hSfzJAM/H9ikdfwxBI65Q86N8yz
 vjwmwBPaBaH+YS1klL87KK4mWOrIvwFH/VmKdl8qZ6S2QNIvzry7uFFGEpz+lwjT2rFb
 a4tefjeCe8duIhp1YN+J4wM9F4mHkzc1gc1K/TQm9GbymLvy6B/Hp11kup7f5G7Br0vX
 7xzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=iS3jBKlKNmJcUQrVHSpndb/mI7IBZoOqYkVGxAz9lYw=;
 b=sA2H1tYdqBZy3sQ2ZyNod3VntG9yfqg/+BzAHWj72NVfaCQN5I/3wH5NtbnsX7XbLZ
 DqcefrZhuU/ZygWoNAMvlrXEGA6WQfUGj7inqFJbMz8qGPOstnJNxgBeqFvCsIDZ4VY5
 rtI+eL/vNVvyn7Tuz9rEG/KIFBJxlot6Gdh9LMCDDbjpyNQ0yZRBy2i1uq/kzLTNbAOG
 ULYRye5dZM6Rk9rXiOk26bQ3Em64wwBRdVpU15ws2zjrJLVFqn8v5Qe13H5svgciuad3
 C9CjlllKzL7EDS8Xa0vCr5miUDNErs2RJoOxEmPvlZi4smT3zS6hLnsbchtK8seAWjIu
 AkYQ==
X-Gm-Message-State: APjAAAV0hxFzPUPsvkm2vkzpQk5qQB2o92FJgTuVNUWMy0B9y9S/sUb3
 yzmspDOfWrXOFnoykCGLKv8=
X-Google-Smtp-Source: APXvYqymeSiH5J31BykyxYP3IzriVwvLe/d0AQ6xISNM6IfoxZCCD0ViG/RMk9AWulr5OiO9hQH6Yg==
X-Received: by 2002:a37:4e81:: with SMTP id c123mr4271755qkb.468.1571334146667; 
 Thu, 17 Oct 2019 10:42:26 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c7:d25e:a983:2b3:2523:a41?
 ([2804:431:c7c7:d25e:a983:2b3:2523:a41])
 by smtp.gmail.com with ESMTPSA id d55sm1736383qta.41.2019.10.17.10.42.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 10:42:26 -0700 (PDT)
Subject: Re: [PATCH v7 0/4] delete created files when
 block_crypto_co_create_opts_luks fails
To: qemu-devel@nongnu.org
References: <20190903135708.21624-1-danielhb413@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <78ca8ffb-79d2-2747-7463-541514d728a9@gmail.com>
Date: Thu, 17 Oct 2019 14:42:23 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190903135708.21624-1-danielhb413@gmail.com>
Content-Type: multipart/alternative;
 boundary="------------5428001F4F0EDF247F777096"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: kwolf@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------5428001F4F0EDF247F777096
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Ping

On 9/3/19 10:57 AM, Daniel Henrique Barboza wrote:
> Changes from previous version 6 [1]:
>
> - bdrv_delete_file() now uses BlockDriverState as a parameter rather
> than a filename string.
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg00139.html
>
> Daniel Henrique Barboza (4):
>    block: introducing 'bdrv_co_delete_file' interface
>    block.c: adding bdrv_delete_file
>    crypto.c: cleanup created file when block_crypto_co_create_opts_luks
>      fails
>    qemu-iotests: adding LUKS cleanup for non-UTF8 secret error
>
>   block.c                    | 73 ++++++++++++++++++++++++++++++++++++++
>   block/crypto.c             | 22 ++++++++++++
>   block/file-posix.c         | 28 +++++++++++++++
>   include/block/block.h      |  1 +
>   include/block/block_int.h  |  6 ++++
>   tests/qemu-iotests/259     | 67 ++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/259.out | 11 ++++++
>   tests/qemu-iotests/group   |  1 +
>   8 files changed, 209 insertions(+)
>   create mode 100755 tests/qemu-iotests/259
>   create mode 100644 tests/qemu-iotests/259.out
>


--------------5428001F4F0EDF247F777096
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <font size="+1">Ping</font><br>
    <br>
    <div class="moz-cite-prefix">On 9/3/19 10:57 AM, Daniel Henrique
      Barboza wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20190903135708.21624-1-danielhb413@gmail.com">
      <pre class="moz-quote-pre" wrap="">Changes from previous version 6 [1]:

- bdrv_delete_file() now uses BlockDriverState as a parameter rather
than a filename string.

[1] <a class="moz-txt-link-freetext" href="https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg00139.html">https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg00139.html</a>

Daniel Henrique Barboza (4):
  block: introducing 'bdrv_co_delete_file' interface
  block.c: adding bdrv_delete_file
  crypto.c: cleanup created file when block_crypto_co_create_opts_luks
    fails
  qemu-iotests: adding LUKS cleanup for non-UTF8 secret error

 block.c                    | 73 ++++++++++++++++++++++++++++++++++++++
 block/crypto.c             | 22 ++++++++++++
 block/file-posix.c         | 28 +++++++++++++++
 include/block/block.h      |  1 +
 include/block/block_int.h  |  6 ++++
 tests/qemu-iotests/259     | 67 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/259.out | 11 ++++++
 tests/qemu-iotests/group   |  1 +
 8 files changed, 209 insertions(+)
 create mode 100755 tests/qemu-iotests/259
 create mode 100644 tests/qemu-iotests/259.out

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------5428001F4F0EDF247F777096--

