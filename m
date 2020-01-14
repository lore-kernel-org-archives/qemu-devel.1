Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23111C33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 01:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B7720CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 01:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBP5+WN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B7720CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irBTj-0000se-1W
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 20:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1irBT1-0008NX-SO
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 20:58:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1irBT0-00076c-N1
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 20:58:03 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:37785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1irBT0-00073v-Cv; Mon, 13 Jan 2020 20:58:02 -0500
Received: by mail-lf1-x142.google.com with SMTP id b15so8473535lfc.4;
 Mon, 13 Jan 2020 17:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+BvT8R5z7QIhrFmhGPb8TBCNGrSfs2ldB6iaTKYVjHc=;
 b=EBP5+WN8/2VsJ10DZxxFxknAhWyLbx3HEMx49tfS6QX8qty8R7NI/Yj5q6He498vMn
 T2ttZiy10+007RwIm16xxI5Xn67nx2VvyTExubCbPG0fQ0lSZPO4bLJW+EGY6QIvtSxG
 aUevSfGOsvm4wqI/QcARFnNkzJzDXJSFsisWoC2JmLj1yJGpdnonOVusuqG7u/JxUIFu
 UV2xdml55hlUAjG5ZUybQvVKGpnczZEj55+nwgTSJpUqlUu0q76sasimU7IW1cnt8qX3
 im+x0PIrhhzeIi3mgvaWmsoJc8pRu6JSJiUADU9LO7HCVpYCEHE5otRSrr487EdHJ91l
 xoyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+BvT8R5z7QIhrFmhGPb8TBCNGrSfs2ldB6iaTKYVjHc=;
 b=iHCaMdoA8tge8Kf0CFiOxE/bEhn3jW/swvLfKtPsX4Wu+o7YBQgGIz1i6PUv4FE7FR
 FUs6En+q/AyKG7kONslOiZQlRZotXb2Ty+ICc5fw98ZUBGweA7TdLa1CBUqQf77HEBq+
 H2SymM4OMiozwsIpbZCGGPHWevBxG6ZTvjeNrnkruALYZSpIFTkcuICNvpAxMVzUFKY6
 zRVSakAyWpGqY5sgKJ+Fr5edbzAWjeJpIEfOC3yQZh8wZKosoBou5T07Irz98KTvVynx
 ysldLOBRGx/dSGuZe2vChVfUoRV0xjIFnOUQc7BMNv03ai/F2BgZk11wtaBUrfoLXfsa
 qYFg==
X-Gm-Message-State: APjAAAUgwU6JNKxgCmbOosu0iPNfp5YKuLMBjRURBkxfRBpTvYxPnEF+
 sxvYcJ0C3YNPWx82z+TtLztNe7Mgcs9ONGRhWbU=
X-Google-Smtp-Source: APXvYqyJ3IXJ369ksZZpQW9lyHreYL8LIgayTmgwMEpTltOXClRRkES7MpVvmtp9/V1X4hTi3i3/BpeYaVFWohKROtQ=
X-Received: by 2002:a19:4ac2:: with SMTP id x185mr210632lfa.131.1578967080317; 
 Mon, 13 Jan 2020 17:58:00 -0800 (PST)
MIME-Version: 1.0
References: <20200109152133.23649-1-philmd@redhat.com>
 <20200109152133.23649-12-philmd@redhat.com>
In-Reply-To: <20200109152133.23649-12-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 Jan 2020 11:57:33 +1000
Message-ID: <CAKmqyKO8mKt=ZDVNO6bEfGi5QTCeLbYZum_-6V4yPpmf-XH1DA@mail.gmail.com>
Subject: Re: [PATCH 11/15] exec: Replace current_machine by qdev_get_machine()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "open list:Overall" <kvm@vger.kernel.org>, Juan Quintela <quintela@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 10, 2020 at 1:37 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> As we want to remove the global current_machine,
> replace 'current_machine' by MACHINE(qdev_get_machine()).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  exec.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/exec.c b/exec.c
> index d4b769d0d4..98f5b049ca 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1984,11 +1984,11 @@ static unsigned long last_ram_page(void)
>
>  static void qemu_ram_setup_dump(void *addr, ram_addr_t size)
>  {
> -    int ret;
> +    MachineState *ms =3D MACHINE(qdev_get_machine());
>
>      /* Use MADV_DONTDUMP, if user doesn't want the guest memory in the c=
ore */
> -    if (!machine_dump_guest_core(current_machine)) {
> -        ret =3D qemu_madvise(addr, size, QEMU_MADV_DONTDUMP);
> +    if (!machine_dump_guest_core(ms)) {
> +        int ret =3D qemu_madvise(addr, size, QEMU_MADV_DONTDUMP);
>          if (ret) {
>              perror("qemu_madvise");
>              fprintf(stderr, "madvise doesn't support MADV_DONTDUMP, "
> @@ -2108,7 +2108,9 @@ size_t qemu_ram_pagesize_largest(void)
>
>  static int memory_try_enable_merging(void *addr, size_t len)
>  {
> -    if (!machine_mem_merge(current_machine)) {
> +    MachineState *ms =3D MACHINE(qdev_get_machine());
> +
> +    if (!machine_mem_merge(ms)) {
>          /* disabled by the user */
>          return 0;
>      }
> --
> 2.21.1
>
>

