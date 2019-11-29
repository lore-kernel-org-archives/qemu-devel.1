Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C64C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 17:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDBD8216F4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 17:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBD8216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maskray.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iajsb-0007XP-Ru
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 12:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <emacsray@gmail.com>) id 1iajp1-000711-Tl
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 12:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <emacsray@gmail.com>) id 1iajoz-0003zK-UB
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 12:12:47 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34790)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <emacsray@gmail.com>) id 1iajoz-0003ob-JD
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 12:12:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id n13so14873690pff.1
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 09:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=TM/d60k9a3O7qFVSgOboxkwTZv4uOmk6CcsiWnP3rl8=;
 b=tFEqQ3mQKs1nuAkDujsol8f02uOYHuyt14q9V5oHGjkIDbJ4lbIyVajDzghLCsyhtB
 tx0tLjMn5Lpze6MvhEeWKU+16D7Z0irIOoT8R6K2yqPNYJ7JE0g0W5mylSq10xuhETdw
 9+/97uBM7OwQFzZVdO7IPSnT9bkSOyXI/GSz8gPenKvmIyN6Pzqr7FMhBIa+xFQ76Oi4
 mmVoLF80MukhUuvf4LU1ZqMkzipnmSNqzkyVkiJmi43MsgWBBEVt6jxB3mNOBQAMqUNd
 lsntKMl5IlEKkGfdJq/k6qCfe+BZJmDC+wnTXSBdXvPlXBPVOJySGF4QfQ8AGofKum+Y
 7YFw==
X-Gm-Message-State: APjAAAWPj0QGXpZ//Z71ELToagQNWxfEZP3fSGr8+0OubBy/xhc8BNM9
 iP4Ti4KMUGz2ZEWWBV74Oik=
X-Google-Smtp-Source: APXvYqw13EZkVMrC+hgtdectxb/Y1/i/W68cqhvWDnkjKyVxaN7y+kloyRzTwXHs74rESmo8wyQc+Q==
X-Received: by 2002:aa7:8207:: with SMTP id k7mr60450994pfi.130.1575047562584; 
 Fri, 29 Nov 2019 09:12:42 -0800 (PST)
Received: from localhost (c-71-204-169-238.hsd1.ca.comcast.net.
 [71.204.169.238])
 by smtp.gmail.com with ESMTPSA id i10sm24705920pgd.73.2019.11.29.09.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2019 09:12:41 -0800 (PST)
Date: Fri, 29 Nov 2019 09:12:40 -0800
From: Fangrui Song <i@maskray.me>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2] configure: Use lld --image-base for --disable-pie user
 mode binaries
Message-ID: <20191129171240.logglzt4emzw46cd@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="suelptnay3holjim"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.194
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--suelptnay3holjim
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


On 2019-11-27, Alex Bennée wrote:
>
>Fangrui Song <i@maskray.me> writes:
>
>> For lld, --image-base is the preferred way to set the base address.
>> lld does not actually implement -Ttext-segment, but treats it as an alias for
>> -Ttext. -Ttext-segment=0x60000000 combined with --no-rosegment can
>> create a 1.6GB executable.
>>
>> Fix the problem by using --image-base for lld. GNU ld and gold will
>> still get -Ttext-segment. Also delete the ld --verbose fallback introduced
>> in 2013, which is no longer relevant or correct (the default linker
>> script has changed).
>>
>> Signed-off-by: Fangrui Song <i@maskray.me>
>
>This patch no longer applies cleanly to configure so I couldn't test it.

configure was touched twice last week, but git still works.
Anyway, I am uploading a new patch without In-Reply-To.

>> ---
>>   configure | 33 ++++++++++++---------------------
>>   1 file changed, 12 insertions(+), 21 deletions(-)
>>
>> diff --git a/configure b/configure
>> index 6099be1d84..2d45af0d09 100755
>> --- a/configure
>> +++ b/configure
>> @@ -6336,43 +6336,34 @@ fi
>>
>>   # Probe for the need for relocating the user-only binary.
>>   if ( [ "$linux_user" = yes ] || [ "$bsd_user" = yes ] ) && [ "$pie" = no ]; then
>> -  textseg_addr=
>> +  image_base=
>>     case "$cpu" in
>>       arm | i386 | ppc* | s390* | sparc* | x86_64 | x32)
>> -      # ??? Rationale for choosing this address
>> -      textseg_addr=0x60000000
>> +      # An arbitrary address that makes it unlikely to collide with user
>> +      # programs.
>> +      image_base=0x60000000
>
>The comment probably belongs up above when we define the empty variable
>unless it really is specifically about these targets.

Moved the comment.

>Renaming textseg_addr seems like unnecessary churn for this patch.

Renaming is necessary. "Text segment" is no more an appropriate term
even with GNU ld due to the prevalence of -z separate-code
(--enable-separate-code is the default on Linux x86-64 in recent
binutils releases). There is a PF_R PT_LOAD before PF_R|PF_X PT_LOAD
(text segment). One may argue that we can name the two PT_LOAD
collectively as "text segment but I don't think that is appropriate.

>
>>         ;;
>>       mips)
>>         # A 256M aligned address, high in the address space, with enough
>>         # room for the code_gen_buffer above it before the stack.
>> -      textseg_addr=0x60000000
>> +      image_base=0x60000000
>>         ;;
>>     esac
>> -  if [ -n "$textseg_addr" ]; then
>> +  if [ -n "$image_base" ]; then
>>       cat > $TMPC <<EOF
>>       int main(void) { return 0; }
>>   EOF
>> -    textseg_ldflags="-Wl,-Ttext-segment=$textseg_addr"
>> -    if ! compile_prog "" "$textseg_ldflags"; then
>> -      # In case ld does not support -Ttext-segment, edit the default linker
>> -      # script via sed to set the .text start addr.  This is needed on FreeBSD
>> -      # at least.
>> -      if ! $ld --verbose >/dev/null 2>&1; then
>> +    image_base_ldflags="-Wl,--image-base=$image_base"
>> +    if ! compile_prog "" "$image_base_ldflags"; then
>> +      image_base_ldflags="-Wl,-Ttext-segment=$image_base"
>> +      if ! compile_prog "" "$image_base_ldflags"; then
>>           error_exit \
>>               "We need to link the QEMU user mode binaries at a" \
>>               "specific text address. Unfortunately your linker" \
>> -            "doesn't support either the -Ttext-segment option or" \
>> -            "printing the default linker script with --verbose." \
>> +            "supports neither --image-base nor -Ttext-segment. " \
>>               "If you don't want the user mode binaries, pass the" \
>>               "--disable-user option to configure."
>>         fi
>> -
>> -      $ld --verbose | sed \
>> -        -e '1,/==================================================/d' \
>> -        -e '/==================================================/,$d' \
>> -        -e "s/[.] = [0-9a-fx]* [+] SIZEOF_HEADERS/. = $textseg_addr + SIZEOF_HEADERS/" \
>> -        -e "s/__executable_start = [0-9a-fx]*/__executable_start = $textseg_addr/" > config-host.ld
>> -      textseg_ldflags="-Wl,-T../config-host.ld"
>>       fi
>>     fi
>>   fi
>> @@ -7945,7 +7936,7 @@ if test "$gprof" = "yes" ; then
>>   fi
>>
>>   if test "$target_linux_user" = "yes" || test "$target_bsd_user" = "yes" ; then
>> -  ldflags="$ldflags $textseg_ldflags"
>> +  ldflags="$ldflags $image_base_ldflags"
>>   fi
>>
>>   # Newer kernels on s390 check for an S390_PGSTE program header and

(I'm not subscribed to the list, so please CC me.
I made this reply by downloading
https://lists.gnu.org/archive/mbox/qemu-devel/2019-11)

--suelptnay3holjim
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="qemu-image-base.patch"

From fea2e6a09234d13402dd6e6dce9300bc6d08efe1 Mon Sep 17 00:00:00 2001
From: Fangrui Song <i@maskray.me>
Date: Fri, 15 Nov 2019 20:42:40 -0800
Subject: [PATCH] configure: Use lld --image-base for --disable-pie user mode
 binaries
To: qemu-devel@nongnu.org

For lld, --image-base is the preferred way to set the base address.
lld does not actually implement -Ttext-segment, but treats it as an alias for
-Ttext. -Ttext-segment=0x60000000 combined with --no-rosegment can
create a 1.6GB executable.

Fix the problem by using --image-base for lld. GNU ld and gold will
still get -Ttext-segment. Also delete the ld --verbose fallback introduced
in 2013, which is no longer relevant or correct (the default linker
script has changed).
---
 configure | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/configure b/configure
index 6099be1d84..33e5344194 100755
--- a/configure
+++ b/configure
@@ -6336,43 +6336,34 @@ fi
 
 # Probe for the need for relocating the user-only binary.
 if ( [ "$linux_user" = yes ] || [ "$bsd_user" = yes ] ) && [ "$pie" = no ]; then
-  textseg_addr=
+  # An arbitrary address that makes it unlikely to collide with user
+  # programs.
+  image_base=
   case "$cpu" in
     arm | i386 | ppc* | s390* | sparc* | x86_64 | x32)
-      # ??? Rationale for choosing this address
-      textseg_addr=0x60000000
+      image_base=0x60000000
       ;;
     mips)
       # A 256M aligned address, high in the address space, with enough
       # room for the code_gen_buffer above it before the stack.
-      textseg_addr=0x60000000
+      image_base=0x60000000
       ;;
   esac
-  if [ -n "$textseg_addr" ]; then
+  if [ -n "$image_base" ]; then
     cat > $TMPC <<EOF
     int main(void) { return 0; }
 EOF
-    textseg_ldflags="-Wl,-Ttext-segment=$textseg_addr"
-    if ! compile_prog "" "$textseg_ldflags"; then
-      # In case ld does not support -Ttext-segment, edit the default linker
-      # script via sed to set the .text start addr.  This is needed on FreeBSD
-      # at least.
-      if ! $ld --verbose >/dev/null 2>&1; then
+    image_base_ldflags="-Wl,--image-base=$image_base"
+    if ! compile_prog "" "$image_base_ldflags"; then
+      image_base_ldflags="-Wl,-Ttext-segment=$image_base"
+      if ! compile_prog "" "$image_base_ldflags"; then
         error_exit \
             "We need to link the QEMU user mode binaries at a" \
             "specific text address. Unfortunately your linker" \
-            "doesn't support either the -Ttext-segment option or" \
-            "printing the default linker script with --verbose." \
+            "supports neither --image-base nor -Ttext-segment. " \
             "If you don't want the user mode binaries, pass the" \
             "--disable-user option to configure."
       fi
-
-      $ld --verbose | sed \
-        -e '1,/==================================================/d' \
-        -e '/==================================================/,$d' \
-        -e "s/[.] = [0-9a-fx]* [+] SIZEOF_HEADERS/. = $textseg_addr + SIZEOF_HEADERS/" \
-        -e "s/__executable_start = [0-9a-fx]*/__executable_start = $textseg_addr/" > config-host.ld
-      textseg_ldflags="-Wl,-T../config-host.ld"
     fi
   fi
 fi
@@ -7945,7 +7936,7 @@ if test "$gprof" = "yes" ; then
 fi
 
 if test "$target_linux_user" = "yes" || test "$target_bsd_user" = "yes" ; then
-  ldflags="$ldflags $textseg_ldflags"
+  ldflags="$ldflags $image_base_ldflags"
 fi
 
 # Newer kernels on s390 check for an S390_PGSTE program header and
-- 
2.24.0


--suelptnay3holjim--

