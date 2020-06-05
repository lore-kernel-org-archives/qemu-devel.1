Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E96C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63EC42074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOFyqatr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63EC42074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGas-0003Un-Lx
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jhGZq-0002jm-6g
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:56:22 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jhGZn-0007oC-M2
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:56:21 -0400
Received: by mail-wm1-x341.google.com with SMTP id r9so9210124wmh.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hA2bb/ztpfia+e4bKF7OYX05131KiAfowRYEFh4yCqU=;
 b=YOFyqatrpl7ZgZB9vWDny5EmISvmyghZ+Unniuu+sc2KgvM+o82MwIMXmSjkCAMBVK
 AqC+QfKOK0sET6AES3pt4GpqIIIwN+g8VI1FBNRF6qj8tHd9NdlevcgSQslsMWJvRrN6
 dOMEF0949LT2QCa+1GzJn97A/CMN06NOiuHubWKmj8yDCFio55HZw9klw3KDSpm2g17n
 NgV1zqJtg0Wn2gL1VLQNeWLwu8E1XJKQRoVMKlbDAg90wyt/+UEmgsu8thp8T3+uniI3
 S37z6fQ8w8jHlE4oThkmJu+I81BN4LRQG6TF4vt3KK/kbGGwcWslwx+q+NcdxmjlRzw2
 6MLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hA2bb/ztpfia+e4bKF7OYX05131KiAfowRYEFh4yCqU=;
 b=hYdJPNorBdM0ouk5QAGYGlDE6QMOJD3T53NzgQaoRFozdll3ayeNwEbP/T1QXH7I7S
 k66VkEj622MOhILrfb4lQtpEr74j/AYVzmKQP1Zr/VzrozGFw0Ze9Su6yRJbr+ouRs3A
 luGcJUCIGdO/JewTRaYtpB6O9cVWQyditXC4vecAjWEq3dHwBoCol10JOZme+Grl4oIE
 fC7C3Ntu3fUo+h0bSWpX39ryX1aNFot1c68mgsslhh9e5n9BijNOZVQYpdHhZK8JfuiA
 FZ3supnF2UMdp5yqX44CqK5XQfbTSde7vk56Im+YwF6P5F7PCbIICzfB6ArAgeG7xIef
 XlWw==
X-Gm-Message-State: AOAM532oZhB0YvL3O62C4uSdd2DtuilU5rHf2A5iH+rYhWAnO01TODuX
 3IkWblhxayc48RBNfFOkdYQ=
X-Google-Smtp-Source: ABdhPJzjSjiHhGYXK6SViTELfp4YlYyoRkG3aCzsvekDNLhY9rxZKPKgpQUKPbT250Bu6REy88/OOw==
X-Received: by 2002:a1c:a943:: with SMTP id s64mr3765714wme.103.1591379777374; 
 Fri, 05 Jun 2020 10:56:17 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q1sm11692848wmc.15.2020.06.05.10.56.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 10:56:16 -0700 (PDT)
Subject: Re: [PATCH] fuzz: add oss-fuzz build.sh script
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200605174036.4527-1-alxndr@bu.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <83f59cb5-2282-aeba-5116-a3e18be101a7@amsat.org>
Date: Fri, 5 Jun 2020 19:56:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200605174036.4527-1-alxndr@bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 7:40 PM, Alexander Bulekov wrote:
> It is neater to keep this in the QEMU repo, since any change that
> requires an update to the oss-fuzz build configuration, can make the
> necessary changes in the same series.
> 
> Suggested-by: Philippe Mathieu-Daude <f4bug@amsat.org>

'Philippe Mathieu-Daudé' ;)

> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  scripts/oss-fuzz/build.sh | 47 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100755 scripts/oss-fuzz/build.sh
> 
> diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
> new file mode 100755
> index 0000000000..7be6dcce4c
> --- /dev/null
> +++ b/scripts/oss-fuzz/build.sh
> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +#
> +# Update syscall_nr.h files from linux headers asm-generic/unistd.h

Hmmm?

> +#
> +# This code is licensed under the GPL version 2 or later.  See
> +# the COPYING file in the top-level directory.
> +#
> +
> +# build project

Please mention this file use consumed by
https://github.com/google/oss-fuzz/.../projects/qemu/Dockerfile

> +# e.g.
> +# ./autogen.sh
> +# ./configure
> +# make -j$(nproc) all
> +
> +# build fuzzers
> +# e.g.
> +# $CXX $CXXFLAGS -std=c++11 -Iinclude \
> +#     /path/to/name_of_fuzzer.cc -o $OUT/name_of_fuzzer \
> +#     $LIB_FUZZING_ENGINE /path/to/library.a
> +
> +mkdir -p $OUT/lib/              # Shared libraries

Maybe rename OUT -> DEST_DIR?

> +
> +# Build once to get the list of dynamic lib paths, and copy them over
> +./configure --datadir="./data/" --disable-werror --cc="$CC" --cxx="$CXX" \
> +    --extra-cflags="$CFLAGS -U __OPTIMIZE__ "

So we use an in-tree build.

Still we could set some SRCDIR=./

> +make CONFIG_FUZZ=y CFLAGS="$LIB_FUZZING_ENGINE" -j$(nproc) i386-softmmu/fuzz
> +
> +for i in $(ldd ./i386-softmmu/qemu-fuzz-i386  | cut -f3 -d' '); do 
> +    cp $i $OUT/lib/
> +done
> +rm ./i386-softmmu/qemu-fuzz-i386
> +
> +# Build a second time to build the final binary with correct rpath
> +./configure --datadir="./data/" --disable-werror --cc="$CC" --cxx="$CXX" \
> +    --extra-cflags="$CFLAGS -U __OPTIMIZE__" \
> +    --extra-ldflags="-Wl,-rpath,'\$\$ORIGIN/lib'"
> +make CONFIG_FUZZ=y CFLAGS="$LIB_FUZZING_ENGINE" -j$(nproc) i386-softmmu/fuzz
> +
> +# Copy over the datadir
> +cp  -r ./pc-bios/ $OUT/pc-bios

"make install-datadir"?

> +
> +# Copy over the qemu-fuzz-i386, naming it according to each available fuzz
> +# target (See 05509c8e6d fuzz: select fuzz target using executable name)
> +for target in $(./i386-softmmu/qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
> +do
> +    cp ./i386-softmmu/qemu-fuzz-i386 $OUT/qemu-fuzz-i386-target-$target

There seems to be an extra 'target'.

> +done
> 

Or "make install", not sure.

