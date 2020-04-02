Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21025C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2C520719
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vlwPU1Ib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2C520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJvsz-0000i2-3p
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 05:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jJvsC-0008FO-3r
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jJvsA-0001w6-MW
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:10:51 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jJvsA-0001sO-EE
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:10:50 -0400
Received: by mail-wm1-x342.google.com with SMTP id d77so2558632wmd.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 02:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=371UWfolmoOtqo8bKcitp4sKuC/qCFfS8Thb/1BNKXc=;
 b=vlwPU1IbIZeGX9CKdu5WibHoGZ6DIyt7qO4nSrr9ntNxfHllCfzkD1PPhSDwYJo6ps
 OvnyqCS7mbbYhs9NUmV73hOI+OjIL9uzCHDrvZFvOlenQ6OuqN/ZTGRiqtk26aJLQ3MW
 hz5cjQLPyCWOfz/9qrGnfzAruG3Dfa4BPftg5az3CF8Ne2sUKnyokK+C0g8Mp3EbKspq
 sAsITHlxM0o2vbnjPPHnUBFNTdr+/7pR7YY2mWqM0t1kzE8/EycdLXBKeJ+xspjb1RaU
 HHFalJg+jaxo/C7C3QvG7kRlyxRqZNBXrWYKrwoNclFN6CgiODISynAcvqBYrIyLDoC8
 zXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=371UWfolmoOtqo8bKcitp4sKuC/qCFfS8Thb/1BNKXc=;
 b=cNZ0laUKvmwM2luvCFlIsozaI78j7FC1iv5VHs6hFg6PvwL9uhNHrlyv4azyF5T5Wp
 A5iy38/ZpYy8FgNVsACaLqmF/ZsfouvSZr/vRigjTJtxXBmqiIBDl3UUwhcJc65r5BfY
 7Ms7mdNfyo4fQ84VPsuxzQ2CGfjYHFM+6/fl2Z5/lqsUvvsgUvKbRPReS6ew/zJ84QvZ
 xkw+AsXmd5HBKoHO5r0NolMH/8ovb5rTBuXk2aiKaPQmKsRw2EGsVrQ75X6vUUVHe43q
 3vboxS1O76TXI7iur6IRv3655QlK4t8BP/EvOMM4AlG6KKAzlOtn6mtExQHcILmiumrk
 1Rsg==
X-Gm-Message-State: AGi0PuaPk489OIyS/uwaSQaa4EpDhd/jWRqfDcXOJom54biJ3OQ69Xvw
 5FjHaLC/Jiz/TOcw4ORo9kSnaA==
X-Google-Smtp-Source: APiQypJzQI6amYBtLPN20/r1OanhRp0SJZxX/aXKSwnfMNwGOKJ2hV/McOr4/4HoohdeXYKCHbBd5g==
X-Received: by 2002:a1c:2842:: with SMTP id o63mr2435735wmo.73.1585818648487; 
 Thu, 02 Apr 2020 02:10:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d6sm6808843wrw.10.2020.04.02.02.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 02:10:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7980C1FF7E;
 Thu,  2 Apr 2020 10:10:46 +0100 (BST)
References: <20200401094759.5835-1-alex.bennee@linaro.org>
 <20200401094759.5835-11-alex.bennee@linaro.org>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 10/10] linux-user: completely re-write init_guest_space
In-reply-to: <20200401094759.5835-11-alex.bennee@linaro.org>
Date: Thu, 02 Apr 2020 10:10:46 +0100
Message-ID: <87pncqdzhl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> This tries to simplify the init_guest_space code to be a little less
> convoluted and remove the brute force mapping algorithm that gets
> tripped up so badly by the sanitizers.
>
> We first try to do what is requested by the host. Failing that we try
> and satisfy the guest requested base address. If all those options
> fail we fall back to finding a space in the memory map using our
> recently written read_self_maps() helper.
>
> Less mind-binding gotos and hopefully clearer logic although perhaps
> more sloppy casting than I'm totally happy with.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  linux-user/elfload.c | 279 +++++++++++++++++++------------------------
>  1 file changed, 125 insertions(+), 154 deletions(-)

Richard,

I think I overthought the magic alignment code as we can deal with it
all in advance and not have to add extra pages which might get in the
way:

1 file changed, 5 insertions(+), 7 deletions(-)
linux-user/elfload.c | 12 +++++-------

modified   linux-user/elfload.c
@@ -2169,17 +2169,15 @@ unsigned long init_guest_space(unsigned long host_s=
tart,
      * that will accept the initial mapping as well as being able to
      * map the (ARM32 specific) commpage later.
      *
-     * We need to ensure the address is properly aligned. But this
-     * does mean that there is a padding of < 1 page both before and
-     * after the aligned range; the "after" could could cause problems
-     * for aforementioned ARM32 emulation.
+     * We need to ensure the address is properly aligned but we can
+     * take that into account when looking for the gap.
      */
     {
 #if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
         uint64_t required_size =3D
             (0xffff0f00 & qemu_host_page_mask) + qemu_host_page_size;
 #else
-        uint64_t required_size =3D host_size + align;
+        uint64_t required_size =3D host_size;
 #endif
         GSList *map_info =3D read_self_maps();
         GSList *last, *next;
@@ -2211,10 +2209,10 @@ unsigned long init_guest_space(unsigned long host_s=
tart,
      * From this point on it should be a formality but lets go through
      * the steps anyway.
      */
-    if (mmap(map_addr, host_size + align , PROT_NONE,
+    if (mmap(map_addr, host_size, PROT_NONE,
              flags | MAP_FIXED, -1, 0) =3D=3D map_addr) {
         unsigned long addr =3D (unsigned long) map_addr;
-        if (!check_commpage(addr, host_size + align)) {
+        if (!check_commpage(addr, host_size)) {
             error_report("%s: commpage won't fit in guest_memory @ %p",
                          __func__, map_addr);
             abort();


--=20
Alex Benn=C3=A9e

