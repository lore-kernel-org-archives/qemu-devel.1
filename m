Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAF2C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8EB22146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+N7Q+/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EB22146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDAAe-00038H-RG
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 12:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDA9Y-0002M3-0d
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDA9W-0006Yc-Ks
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:28:31 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50684)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDA9W-0006YC-6j
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:28:30 -0400
Received: by mail-wm1-x343.google.com with SMTP id 5so6483642wmg.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=QbkBndi4a33RxJa1mi/HPVB9F2em/BF7u7lciAKU/6M=;
 b=g+N7Q+/7hVQSSUqfrn/H2AGknlHMIAapBynItmL9W/1XyjKAuYwb6AR2EkRS/AWn8F
 xHoby8T1DjpA0D3wLDdfmYlSAnpKHs18DROiq7o60VyKSE+Txqn3Z38jzpOCTH8MIGn+
 ZFLD7NsNXht28f6Mb8p7glc+SRn0tE8jCidPuX11i5wyKXy2KYYZKufHsy34UTFa3p7D
 OJaW+kpE5v9NbdkchrqPKj9N8IUeKQnpiFdYuWKwRKdqu7FxLPfNH9nKpOascs5ROjfU
 iWZPQDMlFnLSridwe6CTdOS85culq7ypVE3AXOLv9BuVkM/qWVHLf6FXQbOxH4PcheuJ
 aV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=QbkBndi4a33RxJa1mi/HPVB9F2em/BF7u7lciAKU/6M=;
 b=q+1icHM9WSsKCZCR4Gev4blmxQfLOw6rwaLuwj2DU0eqVx50W1KrrilSlg6GM0gxBu
 A/wu+S/hM9VlF3MkkAnPDlDukI2EM+4wnS1QKykPs2mCZyk1n718q8akr3VlcjMdLrAE
 Il3NFKRKQMx2xVn22MIMeZCGR5nmJr6SUFtIAnX3yE6Cvns+h/M6+/FBB/IgU1NYVJeH
 49hm0NCXP6wI4ez6RoCf4ijyA3zAPutkd3v9+cxKuchmDfGRFBjQQrGvJjNNHvb9z7Or
 wIqupLeWSG7F/IRn5pfUSpkm7CSIr9ck8sl/rEIOUnQ4FA9z0Be21E7eU2+FTjfl0dhG
 ai4Q==
X-Gm-Message-State: APjAAAVKWw0zTdRq1ajX0lA1kirT8KJZDO4h6N8Z6q9EaEz+hnsgIEbI
 pIk/ysWfRehVCErvlu8PyuEyqg==
X-Google-Smtp-Source: APXvYqwTh1PNTNr5xS2kbru2SoKby61rysbMZJq5s2mqlHDtS3b8sTp+mLXd0g4nBHSCoOpsb0zVfg==
X-Received: by 2002:a7b:c152:: with SMTP id z18mr8492231wmi.70.1569428908583; 
 Wed, 25 Sep 2019 09:28:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h63sm5642956wmf.15.2019.09.25.09.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 09:28:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 34D8F1FF87;
 Wed, 25 Sep 2019 17:28:27 +0100 (BST)
References: <20190923230004.9231-1-richard.henderson@linaro.org>
 <20190923230004.9231-16-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 15/16] cputlb: Pass retaddr to
 tb_invalidate_phys_page_fast
In-reply-to: <20190923230004.9231-16-richard.henderson@linaro.org>
Date: Wed, 25 Sep 2019 17:28:27 +0100
Message-ID: <87k19w9w7o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Rather than rely on cpu->mem_io_pc, pass retaddr down directly.
>
> Within tb_invalidate_phys_page_range__locked, the is_cpu_write_access
> parameter is non-zero exactly when retaddr would be non-zero, so that
> is a simple replacement.
>
> Recognize that current_tb_not_found is true only when mem_io_pc
> (and now retaddr) are also non-zero, so remove a redundant test.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/translate-all.h |  3 ++-
>  accel/tcg/cputlb.c        |  6 +-----
>  accel/tcg/translate-all.c | 39 +++++++++++++++++++--------------------
>  3 files changed, 22 insertions(+), 26 deletions(-)
>
> diff --git a/accel/tcg/translate-all.h b/accel/tcg/translate-all.h
> index 31f2117188..135c1ea96a 100644
> --- a/accel/tcg/translate-all.h
> +++ b/accel/tcg/translate-all.h
> @@ -27,7 +27,8 @@ struct page_collection *page_collection_lock(tb_page_ad=
dr_t start,
>                                               tb_page_addr_t end);
>  void page_collection_unlock(struct page_collection *set);
>  void tb_invalidate_phys_page_fast(struct page_collection *pages,
> -                                  tb_page_addr_t start, int len);
> +                                  tb_page_addr_t start, int len,
> +                                  uintptr_t retaddr);
>  void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t =
end);
>  void tb_check_watchpoint(CPUState *cpu);
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 0ca6ee60b3..ea5d12c59d 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1093,11 +1093,7 @@ static void notdirty_write(CPUState *cpu, vaddr me=
m_vaddr, unsigned size,
>      if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)=
) {
>          struct page_collection *pages
>              =3D page_collection_lock(ram_addr, ram_addr + size);
> -
> -        /* We require mem_io_pc in tb_invalidate_phys_page_range.  */
> -        cpu->mem_io_pc =3D retaddr;
> -
> -        tb_invalidate_phys_page_fast(pages, ram_addr, size);
> +        tb_invalidate_phys_page_fast(pages, ram_addr, size, retaddr);
>          page_collection_unlock(pages);
>      }
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index de4b697163..db77fb221b 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1889,7 +1889,7 @@ static void
>  tb_invalidate_phys_page_range__locked(struct page_collection *pages,
>                                        PageDesc *p, tb_page_addr_t start,
>                                        tb_page_addr_t end,
> -                                      int is_cpu_write_access)
> +                                      uintptr_t retaddr)
>  {
>      TranslationBlock *tb;
>      tb_page_addr_t tb_start, tb_end;
> @@ -1897,9 +1897,9 @@ tb_invalidate_phys_page_range__locked(struct page_c=
ollection *pages,
>  #ifdef TARGET_HAS_PRECISE_SMC
>      CPUState *cpu =3D current_cpu;
>      CPUArchState *env =3D NULL;
> -    int current_tb_not_found =3D is_cpu_write_access;
> +    bool current_tb_not_found =3D retaddr !=3D 0;
> +    bool current_tb_modified =3D false;
>      TranslationBlock *current_tb =3D NULL;
> -    int current_tb_modified =3D 0;
>      target_ulong current_pc =3D 0;
>      target_ulong current_cs_base =3D 0;
>      uint32_t current_flags =3D 0;
> @@ -1931,24 +1931,21 @@ tb_invalidate_phys_page_range__locked(struct page=
_collection *pages,
>          if (!(tb_end <=3D start || tb_start >=3D end)) {
>  #ifdef TARGET_HAS_PRECISE_SMC
>              if (current_tb_not_found) {
> -                current_tb_not_found =3D 0;
> -                current_tb =3D NULL;
> -                if (cpu->mem_io_pc) {
> -                    /* now we have a real cpu fault */
> -                    current_tb =3D tcg_tb_lookup(cpu->mem_io_pc);
> -                }
> +                current_tb_not_found =3D false;
> +                /* now we have a real cpu fault */
> +                current_tb =3D tcg_tb_lookup(retaddr);
>              }
>              if (current_tb =3D=3D tb &&
>                  (tb_cflags(current_tb) & CF_COUNT_MASK) !=3D 1) {
> -                /* If we are modifying the current TB, we must stop
> -                its execution. We could be more precise by checking
> -                that the modification is after the current PC, but it
> -                would require a specialized function to partially
> -                restore the CPU state */
> -
> -                current_tb_modified =3D 1;
> -                cpu_restore_state_from_tb(cpu, current_tb,
> -                                          cpu->mem_io_pc, true);
> +                /*
> +                 * If we are modifying the current TB, we must stop
> +                 * its execution. We could be more precise by checking
> +                 * that the modification is after the current PC, but it
> +                 * would require a specialized function to partially
> +                 * restore the CPU state.
> +                 */
> +                current_tb_modified =3D true;
> +                cpu_restore_state_from_tb(cpu, current_tb, retaddr, true=
);
>                  cpu_get_tb_cpu_state(env, &current_pc, &current_cs_base,
>                                       &current_flags);
>              }
> @@ -2042,7 +2039,8 @@ void tb_invalidate_phys_range(target_ulong start, t=
arget_ulong end)
>   * Call with all @pages in the range [@start, @start + len[ locked.
>   */
>  void tb_invalidate_phys_page_fast(struct page_collection *pages,
> -                                  tb_page_addr_t start, int len)
> +                                  tb_page_addr_t start, int len,
> +                                  uintptr_t retaddr)
>  {
>      PageDesc *p;
>
> @@ -2069,7 +2067,8 @@ void tb_invalidate_phys_page_fast(struct page_colle=
ction *pages,
>          }
>      } else {
>      do_invalidate:
> -        tb_invalidate_phys_page_range__locked(pages, p, start, start + l=
en, 1);
> +        tb_invalidate_phys_page_range__locked(pages, p, start, start + l=
en,
> +                                              retaddr);
>      }
>  }
>  #else


--
Alex Benn=C3=A9e

