Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E05AC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:37:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 579762184D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKs1SJ/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579762184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQQUQ-0000h0-2K
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 03:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQQTC-0000EI-3d
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:36:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQQT7-0007Gq-LR
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602142564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xfH/qIeA8gMnjmoUSeEVI2T6T2fRZtZ4WhVmu4FaVTk=;
 b=bKs1SJ/QMetHb3/LGN6HU66oFIe13YhQkSkFF8Qw58m0q+kqv/DNV/YCTSMk50YWakpJfh
 oiYEJVcfog/iboDK6C2qETR1G0pWTyS1LSuq2kwk23RKGKqyOupaw7ue/APTYu54A+lsbe
 0FljHzjm4NAV+SLPLiRuRvl4RzXLe4c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-hhIwEP3rOB-JTt6PH085qA-1; Thu, 08 Oct 2020 03:36:02 -0400
X-MC-Unique: hhIwEP3rOB-JTt6PH085qA-1
Received: by mail-wr1-f69.google.com with SMTP id i10so3538621wrq.5
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 00:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xfH/qIeA8gMnjmoUSeEVI2T6T2fRZtZ4WhVmu4FaVTk=;
 b=hNfpxSbrZUY8SDRZmN8ukOeZASuTUGQ3e9LPYcLeLpKMvuhmUZNMSirSg4cbxLMk7G
 MBl3/7AUCgU0CWOiVsX1Gvw35tr5sVoqvmre/ILEemhUoJ0KCoFykhl6BxDNM97flNX3
 Ba6/gFbJfWCM+qmNGBZX9U5YPNTyRYYQXzAeUnhjDn0KE+PmykVsCW+lgmFtS93rHXMm
 8crdX2ZYonKjUxATJ2Ew48AW0FBOI+PG4R1sBbSKE8zWiDvasM4QJNADYT69e4ljzspH
 mrwwfD5F879nsd1TcjS+BoE781KEyVhZZtjr4VBbMxFiBgFYjk5ihdHG54uQhOxLfPyc
 NvGg==
X-Gm-Message-State: AOAM531gJUaG8WlxUiOl3O51HMTUPGHSpm5XJoCs7Kv+WQdvhIagB8R2
 /i7qh8UceML/Gr1RlxARcvj17kOMrDL7B2uobx+rKOnyCuTrr5j1y1folDigvVm4NE43x3WAggL
 Fb6lrKUCTdm4+Px8=
X-Received: by 2002:adf:d18c:: with SMTP id v12mr7577115wrc.131.1602142561579; 
 Thu, 08 Oct 2020 00:36:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6vl+QNMBjK9ENL9vyUnOH+Qyhx1DoP92rCAICKWPfcVQOKSaqE39Lvz76S7RjAsubNV1svg==
X-Received: by 2002:adf:d18c:: with SMTP id v12mr7577097wrc.131.1602142561339; 
 Thu, 08 Oct 2020 00:36:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bb8c:429c:6de1:f4ec?
 ([2001:b07:6468:f312:bb8c:429c:6de1:f4ec])
 by smtp.gmail.com with ESMTPSA id e15sm5522342wro.13.2020.10.08.00.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 00:36:00 -0700 (PDT)
Subject: Re: [PATCH v3 11/16] scripts/oss-fuzz: Add general-fuzzer build script
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200921022506.873303-1-alxndr@bu.edu>
 <20200921022506.873303-12-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cfe27655-7f00-9b5f-96b7-a8dcbf12d05e@redhat.com>
Date: Thu, 8 Oct 2020 09:35:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921022506.873303-12-alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: darren.kenny@oracle.com, bsd@redhat.com, philmd@redhat.com,
 Thomas Huth <thuth@redhat.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/09/20 04:25, Alexander Bulekov wrote:
> This parses a yaml file containing general-fuzzer configs and builds a
> separate oss-fuzz wrapper binary for each one, changing some
> preprocessor macros for each configuration. To avoid dealing with
> escaping and stringifying, convert each string into a byte-array
> representation
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  scripts/oss-fuzz/build_general_fuzzers.py | 69 +++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100755 scripts/oss-fuzz/build_general_fuzzers.py
> 
> diff --git a/scripts/oss-fuzz/build_general_fuzzers.py b/scripts/oss-fuzz/build_general_fuzzers.py
> new file mode 100755
> index 0000000000..918f1143a5
> --- /dev/null
> +++ b/scripts/oss-fuzz/build_general_fuzzers.py
> @@ -0,0 +1,69 @@
> +#!/usr/bin/env python3
> +# -*- coding: utf-8 -*-
> +
> +"""
> +This script creates wrapper binaries that invoke the general-device-fuzzer with
> +configurations specified in a yaml config file.
> +"""
> +import sys
> +import os
> +import yaml
> +import tempfile
> +
> +CC = ""
> +TEMPLATE_FILENAME = "target_template.c"
> +TEMPLATE_PATH = ""
> +
> +
> +def usage():
> +    print("Usage: CC=COMPILER {} CONFIG_PATH \
> +OUTPUT_PATH_PREFIX".format(sys.argv[0]))
> +    sys.exit(0)
> +
> +
> +def str_to_c_byte_array(s):
> +    """
> +    Convert strings to byte-arrays so we don't worry about formatting
> +    strings to play nicely with cc -DQEMU_FUZZARGS etc
> +    """
> +    return ','.join('0x{:02x}'.format(ord(x)) for x in s)
> +
> +
> +def compile_wrapper(cfg, path):
> +    os.system('$CC -DQEMU_FUZZ_ARGS="{fuzz_args}" \
> +               -DQEMU_FUZZ_OBJECTS="{fuzz_objs}" \
> +               {wrapper_template} -o {output_bin}'.format(
> +                   fuzz_args=str_to_c_byte_array(cfg["args"].replace("\n", " ")),
> +                   fuzz_objs=str_to_c_byte_array(cfg["objects"].replace("\n", " ")),
> +                   wrapper_template=TEMPLATE_PATH,
> +                   output_bin=path))
> +
> +
> +def main():
> +    global CC
> +    global TEMPLATE_PATH
> +    global OUTPUT_BIN_NAME
> +
> +    if len(sys.argv) != 3:
> +        usage()
> +
> +    cfg_path = sys.argv[1]
> +    out_path = sys.argv[2]
> +
> +    CC = os.getenv("CC", default="cc")
> +    TEMPLATE_PATH = os.path.join(os.path.dirname(__file__), TEMPLATE_FILENAME)
> +    if not os.path.exists(TEMPLATE_PATH):
> +        print("Error {} doesn't exist".format(TEMPLATE_PATH))
> +        sys.exit(1)
> +
> +    with open(cfg_path, "r") as f:
> +        configs = yaml.load(f)["configs"]
> +    for cfg in configs:
> +        assert "name" in cfg
> +        assert "args" in cfg
> +        assert "objects" in cfg
> +        compile_wrapper(cfg, out_path + cfg["name"])
> +
> +
> +if __name__ == '__main__':
> +    main()
> 

Can you instead write an array of

struct {
    const char *name, *args, *objects;
}

and use it in the normal argv0-based selection?  The advantage would be
that you can do the whole build within tests/qtest/fuzz/meson.build
instead of having yet another undocumented shell script (cue all the
mess I made when trying to modify scripts/oss-fuzz/build.sh).

Paolo


