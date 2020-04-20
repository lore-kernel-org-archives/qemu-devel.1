Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4B2C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 11:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7D2520857
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 11:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LbETIOvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D2520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQUm9-0008FL-1g
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 07:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40218 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQUlP-0007p0-Lv
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:39:00 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQUlN-0005ZF-Mo
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:38:59 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35891)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQUlN-0005Yh-A4
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:38:57 -0400
Received: by mail-ot1-x342.google.com with SMTP id b13so7753795oti.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 04:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DS+SwsiiAa2IC1Of+N2xMxxQ2Qn8OB6+yF3JDFdmUGw=;
 b=LbETIOvYzs18kn6+m0ic3svL2kvhfMXbxm1qMe2vEGt8OHLOrYNVoOwsPuWgg4CsEE
 A8el+FMXMV/XtEtPGn+tQ1aP0cH4rGdrv630f1UeTl/AkMPBkxD6aPck93ucdsf3wnWi
 9yudlhuklmM+m6OOvDu+phCj/Wf54YUcLAmJzVoCgrmRvxzrI6md1wsdYhfo/wVytYu/
 /l6e+DaDbmIvST2a/+i1wiQtKF3W3h0OTCebZPJMuNVzyqGP+b9kxvau7dxTFV1va5NB
 RxRbYbYxI/Q/Heip8U6dWfx90Q7OyVoJYUg/b6/N33nMFAWgAJgZYYppzcAsVQS9re+/
 lxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DS+SwsiiAa2IC1Of+N2xMxxQ2Qn8OB6+yF3JDFdmUGw=;
 b=nDQ+CRLIIc9wLeNZWmXjyAv5QYy5YBEaAdDrL9srUemS0GPdKNch8nBNjDxUN1cqi4
 EZOzJiJrdSpiqyFDJnghhIftSYlFlG2C66qeVycdG/Vu+iNXj3KrazVyytcFIGvyI6vA
 fCy73I6DNW62T8XByRW4vxfHQ38OriMARkxX5YGaYEabWZ1QBYKH4Tp/Zemcu1d6frfg
 SvqFxDHXNZMCZcKyWkSgJ7ApuPavJV62j3Mlc8WxdCxSmV4Q+Ecy0714crKqOliNuTQu
 RDZQTESyskvYV/5+Nln7UXIhIPtPlR/Ci3KyXlksDk9r0udwarx3sB5/A9qdt1+ElF1f
 plzg==
X-Gm-Message-State: AGi0PuZJpZHri0+nHdbnHfUS1qjh7mEpqSh28rt5RKMrcgAr5rpJMWGK
 BPz8EXUG1cJsC732R5QDXfDzMqp09pnV/Z+20zD0cg==
X-Google-Smtp-Source: APiQypKCWHdZZ2bi+3PbMfM+AZS/gcAmMukvJoqNM4nAXsIul0EznVN8ABNh29yiOVOiUZ8ejQuoJJgLhE64swOJMYs=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr8717028otc.221.1587382735551; 
 Mon, 20 Apr 2020 04:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200331133536.3328-1-linus.walleij@linaro.org>
 <CAFEAcA9Gep1HN+7WJHencp9g2uUBLhagxdgjHf-16AOdP5oOjg@mail.gmail.com>
 <87v9luwgc6.fsf@mid.deneb.enyo.de>
In-Reply-To: <87v9luwgc6.fsf@mid.deneb.enyo.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Apr 2020 12:38:44 +0100
Message-ID: <CAFEAcA-No3Z95+UQJZWTxDesd-z_Y5XnyHs6NMpzDo3RVOHQ4w@mail.gmail.com>
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
To: Florian Weimer <fw@deneb.enyo.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Theodore Ts'o <tytso@mit.edu>, Linux API <linux-api@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Andy Lutomirski <luto@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Apr 2020 at 12:23, Florian Weimer <fw@deneb.enyo.de> wrote:
>
> * Peter Maydell:
>
> > We open fd 3 to read '.'; we issue the new fcntl, which
> > succeeds. Then there's some unrelated stuff operating on
> > stdout. Then we do a getdents64(), but the d_off values
> > we get back are still 64 bits. The guest binary doesn't
> > like those, so it fails. My expectation was that we would
> > get back d_off values here that were in the 32 bit range.
>
> What's your file system?
>
> I think not all of them have 32-bit hashes (some of them probably
> can't, particularly in the network-based file system case).

Whoops, good point. I was testing this via lkvm, so it's
actually using a 9p filesystem... I'll see if I can figure
out how to test with an ext3 fs, which I think is the one
we most care about. It would be nice if the flag was
supported by other fses too, of course.

Appended is the QEMU patch I tested with.

thanks
-- PMM

From 73471e01733dd1d998ff3cd41edebb4c78793193 Mon Sep 17 00:00:00 2001
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Apr 2020 11:54:22 +0100
Subject: [RFC] linux-user: Use new F_SET_FILE_32BIT_FS fcntl for 32-bit guests

If the guest is 32 bit then there is a potential problem if the
host gives us back a 64-bit sized value that we can't fit into
the ABI the guest requires. This is a theoretical issue for many
syscalls, but a real issue for directory reads where the host
is using ext3 or ext4. There the 'offset' values retured via
the getdents syscall are hashes, and on a 64-bit system they
will always fill the full 64 bits.

Use the F_SET_FILE_32BIT_FS fcntl to tell the kernel to stick
to 32-bit sized hashes for fds used by the guest.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
RFC patch because it depends on the kernel patch to provide
F_SET_FILE_32BIT_FS, which is still under discussion. All this
patch does is call the fcntl for every fd the guest opens.

 linux-user/syscall.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 674f70e70a5..8966d4881bd 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -884,6 +884,28 @@ static inline int host_to_target_sock_type(int host_type)
     return target_type;
 }

+/*
+ * If the guest is using a 32 bit ABI then we should try to ask the kernel
+ * to provide 32-bit offsets in getdents syscalls, as otherwise some
+ * filesystems will return 64-bit hash values which we can't fit into
+ * the field sizes the guest ABI mandates.
+ */
+#ifndef F_SET_FILE_32BIT_FS
+#define F_SET_FILE_32BIT_FS (1024 + 15)
+#endif
+
+static inline void request_32bit_fs(int fd)
+{
+#if HOST_LONG_BITS > TARGET_ABI_BITS
+    /*
+     * Ignore errors, which are likely due to the host kernel being too
+     * old to support this fcntl. We'll try anyway, which might or might
+     * not work, depending on the guest code and on the host filesystem.
+     */
+    fcntl(fd, F_SET_FILE_32BIT_FS);
+#endif
+}
+
 static abi_ulong target_brk;
 static abi_ulong target_original_brk;
 static abi_ulong brk_page;
@@ -7704,6 +7726,7 @@ static abi_long do_syscall1(void *cpu_env, int
num, abi_long arg1,
                                   target_to_host_bitmask(arg2,
fcntl_flags_tbl),
                                   arg3));
         fd_trans_unregister(ret);
+        request_32bit_fs(ret);
         unlock_user(p, arg1, 0);
         return ret;
 #endif
@@ -7714,6 +7737,7 @@ static abi_long do_syscall1(void *cpu_env, int
num, abi_long arg1,
                                   target_to_host_bitmask(arg3,
fcntl_flags_tbl),
                                   arg4));
         fd_trans_unregister(ret);
+        request_32bit_fs(ret);
         unlock_user(p, arg2, 0);
         return ret;
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
@@ -7725,6 +7749,7 @@ static abi_long do_syscall1(void *cpu_env, int
num, abi_long arg1,
     case TARGET_NR_open_by_handle_at:
         ret = do_open_by_handle_at(arg1, arg2, arg3);
         fd_trans_unregister(ret);
+        request_32bit_fs(ret);
         return ret;
 #endif
     case TARGET_NR_close:
@@ -7769,6 +7794,7 @@ static abi_long do_syscall1(void *cpu_env, int
num, abi_long arg1,
             return -TARGET_EFAULT;
         ret = get_errno(creat(p, arg2));
         fd_trans_unregister(ret);
+        request_32bit_fs(ret);
         unlock_user(p, arg1, 0);
         return ret;
 #endif
@@ -12393,6 +12419,7 @@ static abi_long do_syscall1(void *cpu_env, int
num, abi_long arg1,
         }
         ret = get_errno(memfd_create(p, arg2));
         fd_trans_unregister(ret);
+        request_32bit_fs(ret);
         unlock_user(p, arg1, 0);
         return ret;
 #endif
-- 
2.20.1

