Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48252C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12DDC204FD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XkJrfSX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DDC204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprAN-0006WJ-6f
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 05:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47508)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hprAB-000667-E4
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hprA9-0007Wd-2W
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:32:51 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38452)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hprA8-0007VL-KH
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:32:48 -0400
Received: by mail-ot1-x341.google.com with SMTP id d17so43394656oth.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yRJrSUD0RumOX9wYi7D2ZmU0m14unIw+KBNsXZwmRLA=;
 b=XkJrfSX9dCpHV9j7MyXGIAlUf14+ROYqhjNq3rsnTfPB2Vwa2d3bJultURyPcqMFRE
 nnFoYb1eqZPk4xI7dhHo3L7PqhNQNtcOLN1IIb76R+M/bUbnlWgQQ2lr2bP7SqVSqRB2
 kf5UVMdTjJB8WqrrZHp4MO+43mFdQUxwDUC3txNhFuo1jF9Pkc9gj9kUb5ldgiI+/Dx7
 EAigz5uwx9Ph8NITWBuyd4Af1630zFLdBlwLY8v1wpGYm4hWXF1L1V15pjN3i1Vk00KJ
 5lbGKKtx4zj7S2uSlisSXVjPntsMEU9tb+hoPCwD9qtD/EetoiXenmnroj+bSLl4QcE+
 P5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yRJrSUD0RumOX9wYi7D2ZmU0m14unIw+KBNsXZwmRLA=;
 b=UG6BHyeex+Xhjb5qIM43Bi5r4yI083aUiSoOkDNH2ElXkbtpaSSngYrIo665WUuXf0
 anFLkVZTubPONRRyo3v5YXSUDkPUJfDMxszT9Gg90dyex4Lj08f6qzw1j80fWUvpAM2Q
 ScvO8DqT+gUFB7f46ykXCVyZSyJ0ZmUTxpdaoqQC3rTCwuehTNIY0u25olz8PNlod53m
 IFI4NDnLQk7kIU6jjOp1xnNFqLg/1DErD+t38nDt+uIcMWjNEG9a0u5yBEqoKLLF30Bm
 p6GdThyGTizJWIPHVfatEr3iom8YiRQaJsToKEOY1QWAcmHo4u0BYF6A3SaJ8s9Pvyyy
 y9OQ==
X-Gm-Message-State: APjAAAWpt+Y6kivUPYg45W0cNA3oX5W2IJphx9AeB8MJ1DOtMpiMJpb6
 taFdAGGXUFQFLgOfCqG0N/F4qd8BEdn7BLRCP4PHDg==
X-Google-Smtp-Source: APXvYqybEQcSO5bP4fTH/pqojNjgmXRT0kjU+fgjrcjrhqt2GbixZm7f0NfAyqYfNdpFmIXKwtqfY1B1LaeGsMHrU70=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr52277028otj.97.1563874365145; 
 Tue, 23 Jul 2019 02:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190723090718.14590-1-sgarzare@redhat.com>
 <20190723090718.14590-2-sgarzare@redhat.com>
In-Reply-To: <20190723090718.14590-2-sgarzare@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jul 2019 10:32:34 +0100
Message-ID: <CAFEAcA_KspUxk75hR4YV444tj8-bQKOJ_4eq+aPD-idZ12Lzwg@mail.gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 1/2] elf-ops.h: Map into memory the ELF to
 load
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jul 2019 at 10:08, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> In order to reduce the memory footprint we map into memory
> the ELF to load using g_mapped_file_new_from_fd() instead of
> reading each sections. In this way we can share the ELF pages
> between multiple instances of QEMU.
>
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/hw/elf_ops.h | 59 ++++++++++++++++++++++----------------------
>  1 file changed, 30 insertions(+), 29 deletions(-)
>
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index 690f9238c8..69ce8dea74 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -323,8 +323,9 @@ static int glue(load_elf, SZ)(const char *name, int fd,
>      struct elfhdr ehdr;
>      struct elf_phdr *phdr = NULL, *ph;
>      int size, i, total_size;
> -    elf_word mem_size, file_size;
> +    elf_word mem_size, file_size, data_offset;
>      uint64_t addr, low = (uint64_t)-1, high = 0;
> +    GMappedFile *gmf = NULL;
>      uint8_t *data = NULL;
>      char label[128];
>      int ret = ELF_LOAD_FAILED;
> @@ -409,22 +410,26 @@ static int glue(load_elf, SZ)(const char *name, int fd,
>          }
>      }
>
> +    gmf = g_mapped_file_new_from_fd(fd, false, NULL);

Hmm. Here we pass 'false' for the writable argument,
meaning we promise not to modify the mapped buffer...

> +    if (!gmf) {
> +        goto fail;
> +    }
> +
>      total_size = 0;
>      for(i = 0; i < ehdr.e_phnum; i++) {
>          ph = &phdr[i];
>          if (ph->p_type == PT_LOAD) {
>              mem_size = ph->p_memsz; /* Size of the ROM */
>              file_size = ph->p_filesz; /* Size of the allocated data */
> -            data = g_malloc0(file_size);
> -            if (ph->p_filesz > 0) {
> -                if (lseek(fd, ph->p_offset, SEEK_SET) < 0) {
> -                    goto fail;
> -                }
> -                if (read(fd, data, file_size) != file_size) {
> -                    goto fail;
> -                }
> +            data_offset = ph->p_offset; /* Offset where the data is located */
> +
> +            if (g_mapped_file_get_length(gmf) < file_size + data_offset) {
> +                goto fail;
>              }
>
> +            data = (uint8_t *)g_mapped_file_get_contents(gmf);
> +            data += data_offset;

...but here we set up the 'data' pointer from the mapped contents,
and then in following code we will write to it in some situations --
look at the "if (data_swab)" case or the call to elf_reloc if we
have a translate_fn, for instance.

(We can't get out of this by just passing writable=true, because
we definitely don't want to be writing back to the underlying file.)

thanks
-- PMM

