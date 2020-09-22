Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F8CC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92BC0221EB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hshuBIG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BC0221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKgMy-0003zZ-Fh
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 07:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKgMC-00033Y-QV
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 07:21:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKgMA-0007KA-PK
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 07:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600773669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16KnjrhcqDYhI8MttMKkFeWxSp0zC6Ei+qY5VATvj1I=;
 b=hshuBIG6URtbz8pBmGHoDA7OgPe/isYjiBVuFUO3eaeVGfttpitonq6YfL1hFffa2UdGKA
 dgT/JUqGzmcAZtVjdTenMxCBTVtRkjSBgKnNa+GOwZQ3XQwIJBa6K/SuOBA2n6RA2lUh7d
 ZYj3pc1tUcnof+1ibqvl0oEzYGLH9eY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-qGQ7fjS6MX2zMsVfspAoMg-1; Tue, 22 Sep 2020 07:21:07 -0400
X-MC-Unique: qGQ7fjS6MX2zMsVfspAoMg-1
Received: by mail-wr1-f69.google.com with SMTP id h4so7310026wrb.4
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 04:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=16KnjrhcqDYhI8MttMKkFeWxSp0zC6Ei+qY5VATvj1I=;
 b=kk5eliiJUF3+eJuCYEzdwOK092kk4Wxx0LU9MOUYuW9dawhGLxtl/gZ40F/2nLdN/d
 n1VisCUEwZEA6Bbc8EupqpfAt57u+SHBghJVdoB+9B5cBWWvAO5XMLXrb9SzLrdc6ZSq
 3OqYIXcZ4MowgmISmlyk4XgOzd0Ktwz/r8hf4F9vWsaY7oUMS5vD7mopiYT7Kie8521l
 r/2vwkH4et4cagwErYbF6ztMXfNVWhgjLgqMFgcmoFH1iaqQ5m2wMMDiHPJoKjPzUYT7
 GSEVQyUUz0pdinR2eeYiWQkhZCPLL9pw/oa47M5ZzTDxZR2ybh5JjHRVzVsiiE1rOnbR
 c7/Q==
X-Gm-Message-State: AOAM531bhtwSXERXIYqkSlgWlofdJpRUp6dJnpiPu2BzGup47+niL5XF
 8Wz+rlIoApgKVfsxeF84QhKW9uZxj7K6bEhacEBLsvg2UxR/CRTLVLiYV1pDx8JZrFb93H+LDqd
 uaac8qy1oDHaVMSQ=
X-Received: by 2002:a7b:c103:: with SMTP id w3mr504079wmi.24.1600773666376;
 Tue, 22 Sep 2020 04:21:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPIr/W/vjvrjrHG1SjfeCilysusHzfuTaYZbRWIDJXxHYo10IfyJCv5MdgZUb7zFzWUJZ39g==
X-Received: by 2002:a7b:c103:: with SMTP id w3mr504062wmi.24.1600773666118;
 Tue, 22 Sep 2020 04:21:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec2c:90a9:1236:ebc6?
 ([2001:b07:6468:f312:ec2c:90a9:1236:ebc6])
 by smtp.gmail.com with ESMTPSA id h2sm26953690wrp.69.2020.09.22.04.21.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 04:21:05 -0700 (PDT)
Subject: Re: [PATCH v2 01/20] configure: Detect libfuse
To: Thomas Huth <thuth@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20200922104932.46384-1-mreitz@redhat.com>
 <20200922104932.46384-2-mreitz@redhat.com>
 <0360f62c-9074-594d-8e12-b00166380513@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3b842fb9-5d8d-8b06-c364-d583ea69e53e@redhat.com>
Date: Tue, 22 Sep 2020 13:21:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0360f62c-9074-594d-8e12-b00166380513@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/20 13:14, Thomas Huth wrote:
> On 22/09/2020 12.49, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  configure   | 34 ++++++++++++++++++++++++++++++++++
>>  meson.build |  6 ++++++
>>  2 files changed, 40 insertions(+)
>>
>> diff --git a/configure b/configure
>> index ce27eafb0a..21c31e4694 100755
>> --- a/configure
>> +++ b/configure
>> @@ -538,6 +538,7 @@ meson=""
>>  ninja=""
>>  skip_meson=no
>>  gettext=""
>> +fuse=""
>>  
>>  bogus_os="no"
>>  malloc_trim=""
>> @@ -1621,6 +1622,10 @@ for opt do
>>    ;;
>>    --disable-libdaxctl) libdaxctl=no
>>    ;;
>> +  --enable-fuse) fuse=yes
>> +  ;;
>> +  --disable-fuse) fuse=no
>> +  ;;
>>    *)
>>        echo "ERROR: unknown option $opt"
>>        echo "Try '$0 --help' for more information"
>> @@ -1945,6 +1950,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>>    xkbcommon       xkbcommon support
>>    rng-none        dummy RNG, avoid using /dev/(u)random and getrandom()
>>    libdaxctl       libdaxctl support
>> +  fuse            fuse block device export
>>  
>>  NOTE: The object files are built at the place where configure is launched
>>  EOF
>> @@ -6206,6 +6212,28 @@ but not implemented on your system"
>>      fi
>>  fi
>>  
>> +##########################################
>> +# FUSE support
>> +
>> +if test "$fuse" != "no"; then
>> +  cat > $TMPC <<EOF
>> +#define FUSE_USE_VERSION 31
>> +#include <fuse.h>
>> +#include <fuse_lowlevel.h>
>> +int main(void) { return 0; }
>> +EOF
>> +  fuse_cflags=$(pkg-config --cflags fuse3)
>> +  fuse_libs=$(pkg-config --libs fuse3)
>> +  if compile_prog "$fuse_cflags" "$fuse_libs"; then
>> +    fuse=yes
>> +  else
>> +    if test "$fuse" = "yes"; then
>> +      feature_not_found "fuse"
>> +    fi
>> +    fuse=no
>> +  fi
>> +fi
> 
> Could you turn this immediately into a meson test instead? See e.g.
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg07112.html as
> an example for how to do this.

For pkg-config in fact it's even simpler and documented in
docs/devel/build-system.rst.

Paolo


