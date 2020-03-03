Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2070C3F2D7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 23:30:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ACDF20716
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 23:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Med6eRSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACDF20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9H06-0000gD-Ej
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 18:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuanzi@google.com>) id 1j9Gz1-0008Si-2U
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 18:29:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuanzi@google.com>) id 1j9Gyz-0003y8-Ur
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 18:29:50 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuanzi@google.com>) id 1j9Gyz-0003ww-8w
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 18:29:49 -0500
Received: by mail-ot1-x341.google.com with SMTP id v19so179058ote.8
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 15:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/bW8efiApVzydyaH8AhwyVKf0CkNBkcbqVJgT1JC9+M=;
 b=Med6eRSU9oGg0ZlErErF8Y6yGXe00JBzMy6G/Wsaj0KIIl9BCwtnFdYn9YOsmy7tqu
 yeIyE0mNljA5HZwerLQlDZ7iyx9cd41vGCm7R+FmDBQf7c2u4Px9TBcWfUsVpX/OGeBm
 GDJHTu2YMyFkgbPPwsT1fPiagDMaiL49zqarYLqHyDqLWSBDsy10Ah6juzPapu3Lan8H
 9gQr52zZVC4CJQ3L9zLHL3bOa7tVTBld5pjJl1hPWEA33rC7m1jWoOyiC5Q2pvEvf9rA
 ybc6jF+dgTE44v1PrVSMmC8QOHBy06FgO1CaFAW375E615F+Qpp4F3BmF9CMh5LtoF2u
 y+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/bW8efiApVzydyaH8AhwyVKf0CkNBkcbqVJgT1JC9+M=;
 b=UFhPbXszciIsgG83eWFEsnMyFlhiIn6XOS/vLjaU1yD+omfPnCcPe/ycLABHtEEsny
 G6Ns1Td7Qi5TmaXzE07z7k5zQ6OFdl0ZIYbxWo0uqTatLKLX+ZuNrObDlRYzRzWo2KVB
 PPz6nhTmc8YLAxaDg7/9cpfjdW+ERpB9xVI7VHuryjj8n0GKQQEXF/vLy/kul5sz5ACB
 ZmvIbVY/zUR1W9zQtuYpaYP3SyRR5QuMWeTGT2uGG68WyZAhIAzv5g0ybPwiVotgNlB0
 aEuxB5nI5IHbAjRXi1AQ1O3nSq3B4w8QNUe2XwAiBiYL6HID70mUVkc1r99uuATo0lY4
 SgLA==
X-Gm-Message-State: ANhLgQ1oDOVBgFcGQdCsfXG1Ls11cIxMNDnZuRRGLJlizlcnQS54HoKh
 YsZi5GWEQ4t+QDiujAUWrLXN6MHRFqLdSdP1xjavHw==
X-Google-Smtp-Source: ADFU+vuserjoSos3+qe9IqyBew2nBlEPIVLyyRJXC3JRcMAzrau6VzTraLn2xXEuXzLlM5bER7Fi77397JqwipL/b6A=
X-Received: by 2002:a9d:7842:: with SMTP id c2mr233345otm.252.1583278187261;
 Tue, 03 Mar 2020 15:29:47 -0800 (PST)
MIME-Version: 1.0
References: <20200302193153.66415-1-yuanzi@google.com>
 <d9dc23a7-61a8-c28a-47e0-4a4d9590be04@vivier.eu>
In-Reply-To: <d9dc23a7-61a8-c28a-47e0-4a4d9590be04@vivier.eu>
From: Lirong Yuan <yuanzi@google.com>
Date: Tue, 3 Mar 2020 15:29:36 -0800
Message-ID: <CADjx4C+8304e=AjjgkxSwH7nVhkH_04+aFz-EvJUAeEWJuZYVg@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user: Add AT_EXECFN auxval
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Shu-Chun Weng <scw@google.com>, Josh Kunz <jkz@google.com>,
 Riku Voipio <riku.voipio@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 3, 2020 at 1:40 AM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 02/03/2020 =C3=A0 20:31, Lirong Yuan a =C3=A9crit :
> > This change adds the support for AT_EXECFN auxval.
> >
> > Signed-off-by: Lirong Yuan <yuanzi@google.com>
> > ---
> > Changelog since v1:
> > - remove implementation for AT_EXECFD auxval.
> >
> >  linux-user/elfload.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> > index db748c5877..8198be0446 100644
> > --- a/linux-user/elfload.c
> > +++ b/linux-user/elfload.c
> > @@ -1573,7 +1573,7 @@ struct exec
> >                                   ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZE=
-1))
> >  #define TARGET_ELF_PAGEOFFSET(_v) ((_v) & (TARGET_ELF_EXEC_PAGESIZE-1)=
)
> >
> > -#define DLINFO_ITEMS 15
> > +#define DLINFO_ITEMS 16
> >
> >  static inline void memcpy_fromfs(void * to, const void * from, unsigne=
d long n)
> >  {
> > @@ -2037,6 +2037,7 @@ static abi_ulong create_elf_tables(abi_ulong p, i=
nt argc, int envc,
> >      NEW_AUX_ENT(AT_CLKTCK, (abi_ulong) sysconf(_SC_CLK_TCK));
> >      NEW_AUX_ENT(AT_RANDOM, (abi_ulong) u_rand_bytes);
> >      NEW_AUX_ENT(AT_SECURE, (abi_ulong) qemu_getauxval(AT_SECURE));
> > +    NEW_AUX_ENT(AT_EXECFN, info->file_string);
> >
> >  #ifdef ELF_HWCAP2
> >      NEW_AUX_ENT(AT_HWCAP2, (abi_ulong) ELF_HWCAP2);
> >
>
> Applied to my linux-user branch.
>
> Thanks,
> Laurent

Awesome, thanks for the review! :)

Regards,
Lirong

