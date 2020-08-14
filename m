Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D084C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 07:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02E2720708
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 07:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVXQHGan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E2720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6URF-0004RJ-8N
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 03:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6UQP-0003hw-C1
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 03:46:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49293
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6UQN-0008Bv-3H
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 03:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597391209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5lxcBegXP3ssA5MonkZr90Z1+9G+YoRtlcoqlk0B1xQ=;
 b=MVXQHGanTpFXl502lkGlavlzQBdNOe9DxxnmjvkcTkwFm/guYpvBMxy3Dv/Q+Eb9Ox6k/F
 yjTX7RHdO0pZIThgRH+l4DaAEhrYrEmcoApEPRMJ19ULSYzO5lT+bS2HcGHJm6cpGY9GtD
 ZjaiSY1OpGS/6g1gGbSOE/WLQM/ZtCo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-oq5h17CQOr6f1NngL-4wGg-1; Fri, 14 Aug 2020 03:46:48 -0400
X-MC-Unique: oq5h17CQOr6f1NngL-4wGg-1
Received: by mail-wr1-f72.google.com with SMTP id o10so3058438wrs.21
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 00:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=5lxcBegXP3ssA5MonkZr90Z1+9G+YoRtlcoqlk0B1xQ=;
 b=JAWuQnqo4FH1kL5+J5maY4HnFY2TBIyaIJS6Y+ZQwOTVLey3VcvG/e4NGK5RTvaFGb
 FsYCCIBcrxYEZq9dhPUDp5bt6U3elUHrQd6XZqSWl8y7UB7HmV4TN45IFwZ7m5HbAKbt
 Trc3m2rYUE25BIEmm2yK0iRoRfTz5WUOyC7q9/CbetGxObGXdV7SM4XlO29R6jbzk/BN
 qg+MOo6Y0n6+12XDrmVsROznT9RVHlKiBR/84JoIp8jq6IOJZzIh7kEBmL6oqG33KyEh
 UulSrWIctKvMSCctRvKofKSS88YiPdSLcAm1bSpyLZu2KdRq4VDImhgWsX0IQP5xKPZb
 t3RQ==
X-Gm-Message-State: AOAM532pxq6T0hcpnXhPoKLglfsvblg44OUMPWa5JxJx2mBHU3hZZdRu
 fXKDrVqW2jeAw4PYodv+RuPuq+hZMz5eyN3t3YJWEz3LJKcXIzK8ik0e9luTnMqbmSmvszhnLEW
 AsphkhpqaUcIDXtY=
X-Received: by 2002:a5d:5052:: with SMTP id h18mr1620051wrt.156.1597391206773; 
 Fri, 14 Aug 2020 00:46:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCYUMnzQILAreCUqpA6IlpZtjEsz666s3vjeDUqf5nSlSzwtvTCnHMOSUXFtP0FoT+Y29l8Q==
X-Received: by 2002:a5d:5052:: with SMTP id h18mr1620025wrt.156.1597391206507; 
 Fri, 14 Aug 2020 00:46:46 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id j2sm14939288wrp.46.2020.08.14.00.46.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 00:46:45 -0700 (PDT)
Subject: Re: [PATCH] configure: Require pixman for vhost-user-gpu.
To: Thomas Huth <thuth@redhat.com>, Rafael Kitover <rkitover@gmail.com>,
 qemu-devel@nongnu.org
References: <20200801224406.315875-1-rkitover@gmail.com>
 <f09f5172-a22c-d51a-7db7-a6fd880d386c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <279ec524-0cf3-bacf-b97f-86a876d980c3@redhat.com>
Date: Fri, 14 Aug 2020 09:46:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f09f5172-a22c-d51a-7db7-a6fd880d386c@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 01:57:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/3/20 8:09 AM, Thomas Huth wrote:
> On 02/08/2020 00.44, Rafael Kitover wrote:
>> Use the test from Makefile to check if vhost-user-gpu is being built,
>> and if so require pixman.
> 
> Fixes: 9b52b17ba5 ("configure: Allow to build tools without pixman")
> 
> ... sorry, I missed that there is indeed a tool that requires pixman.
> 
>> Signed-off-by: Rafael Kitover <rkitover@gmail.com>
>> ---
>>  configure | 28 ++++++++++++++--------------
>>  1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/configure b/configure
>> index 2acc4d1465..181b465861 100755
>> --- a/configure
>> +++ b/configure
>> @@ -4062,20 +4062,6 @@ if test "$modules" = yes; then
>>      fi
>>  fi
>>  
>> -##########################################
>> -# pixman support probe
>> -
>> -if test "$softmmu" = "no"; then
>> -  pixman_cflags=
>> -  pixman_libs=
>> -elif $pkg_config --atleast-version=0.21.8 pixman-1 > /dev/null 2>&1; then
>> -  pixman_cflags=$($pkg_config --cflags pixman-1)
>> -  pixman_libs=$($pkg_config --libs pixman-1)
>> -else
>> -  error_exit "pixman >= 0.21.8 not present." \
>> -      "Please install the pixman devel package."
>> -fi
>> -
>>  ##########################################
>>  # libmpathpersist probe
>>  
>> @@ -4491,6 +4477,20 @@ if test "$opengl" = "yes" && test "$have_x11" = "yes"; then
>>    done
>>  fi
>>  
>> +##########################################
>> +# pixman support probe
>> +
>> +if test "$softmmu" = "no" && ! ( test "${linux} ${virglrenderer} ${gbm} ${want_tools}" = "yes yes yes yes" );  then
> 
> Do you need the round brackets here?
> 
>> +  pixman_cflags=
>> +  pixman_libs=
>> +elif $pkg_config --atleast-version=0.21.8 pixman-1 > /dev/null 2>&1; then
>> +  pixman_cflags=$($pkg_config --cflags pixman-1)
>> +  pixman_libs=$($pkg_config --libs pixman-1)
>> +else
>> +  error_exit "pixman >= 0.21.8 not present." \
>> +      "Please install the pixman devel package."
>> +fi
>> +
>>  ##########################################
>>  # libxml2 probe
>>  if test "$libxml2" != "no" ; then
>>
> 
> With the round brackets removed:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 

Hmm this doesn't work for me:

$ ../configure --disable-system --disable-user --enable-tools
QEMU_CFLAGS         -Werror  -pthread -I/usr/include/glib-2.0
-I/usr/lib64/glib-2.0/include  -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE
-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
-Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes
-fno-strict-aliasing -fno-common -fwrapv -std=gnu99
-Wold-style-declaration -Wold-style-definition -Wtype-limits
-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
-Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined
-Wno-missing-include-dirs -Wno-shift-negative-value -Wno-psabi
-fstack-protector-strong   -I/usr/include/p11-kit-1
-DSTRUCT_IOVEC_DEFINED  -I/usr/include/libpng16  -I/usr/include/libdrm
-I/usr/include/spice-1 -I/usr/include/spice-server -I/usr/include/cacard
-I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include
-I/usr/include/nss3 -I/usr/include/nspr4 -pthread
-I/usr/include/libmount -I/usr/include/blkid -I/usr/include/uuid
-I/usr/include/pixman-1  -I/usr/include/capstone
QEMU_LDFLAGS       -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64
-fstack-protector-strong
target list
static build      no
virgl support     yes (0.7.0)
TCG support       no
build guest agent yes

$ make vhost-user-gpu
...
  LINK    vhost-user-gpu
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.o: in function
`vg_resource_create_2d':
contrib/vhost-user-gpu/vhost-user-gpu.c:322: undefined reference to
`pixman_image_create_bits'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.o: in function
`vg_resource_destroy':
contrib/vhost-user-gpu/vhost-user-gpu.c:381: undefined reference to
`pixman_image_unref'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.o: in function
`vg_transfer_to_host_2d':
contrib/vhost-user-gpu/vhost-user-gpu.c:538: undefined reference to
`pixman_image_get_format'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:540: undefined
reference to `pixman_image_get_stride'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:543: undefined
reference to `pixman_image_get_width'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:544: undefined
reference to `pixman_image_get_data'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:556: undefined
reference to `pixman_image_get_stride'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:557: undefined
reference to `pixman_image_get_height'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:555: undefined
reference to `pixman_image_get_data'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.o: in function
`vg_resource_flush':
contrib/vhost-user-gpu/vhost-user-gpu.c:693: undefined reference to
`pixman_region_init_rect'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:705: undefined
reference to `pixman_region_init'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:706: undefined
reference to `pixman_region_init_rect'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:709: undefined
reference to `pixman_region_intersect'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:711: undefined
reference to `pixman_region_extents'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:731: undefined
reference to `pixman_image_get_format'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:731: undefined
reference to `pixman_image_get_format'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:747: undefined
reference to `pixman_image_get_format'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:747: undefined
reference to `pixman_image_create_bits'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:753: undefined
reference to `pixman_image_composite'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:758: undefined
reference to `pixman_image_unref'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:762: undefined
reference to `pixman_region_fini'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:763: undefined
reference to `pixman_region_fini'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:765: undefined
reference to `pixman_region_fini'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.o: in function
`update_cursor_data_simple':
contrib/vhost-user-gpu/vhost-user-gpu.c:863: undefined reference to
`pixman_image_get_width'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:864: undefined
reference to `pixman_image_get_height'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:865: undefined
reference to `pixman_image_get_format'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:865: undefined
reference to `pixman_image_get_format'
/usr/bin/ld: contrib/vhost-user-gpu/vhost-user-gpu.c:868: undefined
reference to `pixman_image_get_data'
collect2: error: ld returned 1 exit status
make: *** [Makefile:730: vhost-user-gpu] Error 1

$ lsb_release -d
Description:    Fedora release 30 (Thirty)

$ pkg-config --atleast-version=0.21.8 pixman-1; echo $?
0

$ pkg-config --cflags pixman-1
-I/usr/include/pixman-1
# found in QEMU_CFLAGS

$ pkg-config --libs pixman-1
-lpixman-1
# NOT found in QEMU_LDFLAGS

Thanks,

Phil.


