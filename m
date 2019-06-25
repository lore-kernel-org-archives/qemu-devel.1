Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A553C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E966A20663
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDHk8lMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E966A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58634 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfirb-0008Ki-6b
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40188)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfiqL-0007fg-Bq
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfiqK-00045g-58
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:38:29 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34857)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfiqJ-00044U-SS
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:38:28 -0400
Received: by mail-wr1-x444.google.com with SMTP id f15so7388235wrp.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 03:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=wQHM1tHEPfkXUB5qC1biphg6ywSWvk2w1yZQSAtaEhE=;
 b=QDHk8lMpjpU6BbDO8/Fjg7UdOmrTfvL7IFnHFlPVcp1jDcj0dEPlqzOo1hr5Qdw+Ci
 IyXvPK4bTyelchMiBHLAxX0X/CWVBG2zvRaK5zvkyMBmaei7XnFxHFxrlpLEPFoEYDXT
 E3QsVI30Em9Xuir4kYnpd3JhyZ3+g5NNp4cXawxL3MgeByO/IVEMCejoql2C6bRuicGL
 FLw5ok3tNj8UEEMGzaBVmOlXwtLp3ALqdvQnew/eH9xi+KO4FnEEWQ0orIXDbCQRoNGI
 IVOPTM2eoX1z2F0yoD8L+iSXkt9gxr4AwmyURcGgmqGtStPuvWT0XpsgcepJT3r1zNRQ
 UMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=wQHM1tHEPfkXUB5qC1biphg6ywSWvk2w1yZQSAtaEhE=;
 b=az+ofmknd+LUbRQcV7VWkJDXkmzYt7eKj5PQFh0Qmo/XaYIxlJ1/tt+V3Pqs63lDbY
 jK29MEUJV0O8h6gMnm8QdEXpdr7Q6k2EuW1kwZ1B/Sj62a1vlfu6Mx2I+eH1biE2lqgF
 o8+B5JBuHcPEygOzqhXS4uIptzA8QuXtLhxSa7RRQqgO1G7NVBiiqQOdsJU6ssfo1Oj/
 LFDnacN8ubUtFYx+hKhgEX4x252wjQ0XqQ6+wlNPO4adYYUvKTxDU0XjkNA4LDdYSnW4
 XyxE74UNmYKagS7Wwucs/fUAzTmvWbHaTmqyqRSy6Rz6YksrVKQn/DPUqWH2KF9fig6E
 3zPA==
X-Gm-Message-State: APjAAAVnFdOzqC3bX1oqUjmZctZ2273+V3YS6tOWkBjHtk+QQiXVkY3T
 y7jTpTzlQO1+FJQhzUIQMcPrs/aZrDs=
X-Google-Smtp-Source: APXvYqzvkFSiulLduqRn81rnliiOWRePu36gzfQReM4KHRvIRKmbiKYBVahkWekxtJq1/U1wtvYFfQ==
X-Received: by 2002:adf:fa4c:: with SMTP id y12mr99462235wrr.282.1561459106672; 
 Tue, 25 Jun 2019 03:38:26 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id h8sm2005057wmf.12.2019.06.25.03.38.25
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 03:38:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 80C5D1FF87;
 Tue, 25 Jun 2019 11:38:25 +0100 (BST)
References: <20190624055442.2973-1-vandersonmr2@gmail.com>
 <20190624055442.2973-4-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190624055442.2973-4-vandersonmr2@gmail.com>
Date: Tue, 25 Jun 2019 11:38:25 +0100
Message-ID: <87imsu0x26.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2 3/4] Introduce dump of hot TBs
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, vandersonmr <vandersonmr2@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> Adding a function to dump the Nth hottest TBs.
> The block PC, execution count and ops is dump to the log.
>
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> ---
>  accel/tcg/translate-all.c | 45 +++++++++++++++++++++++++++++++++++++++
>  include/exec/exec-all.h   |  2 ++
>  2 files changed, 47 insertions(+)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index f7e99f90e0..c3d9ecb2c4 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1240,6 +1240,27 @@ static gboolean tb_host_size_iter(gpointer key, gp=
ointer value, gpointer data)
>      return false;
>  }
>
> +static void tb_dump_statistics(TBStatistics *tbs)
> +{
> +    uint32_t cflags =3D curr_cflags() | CF_NOCACHE;
> +    int old_log_flags =3D qemu_loglevel;
> +
> +    qemu_set_log(CPU_LOG_TB_OP_OPT);

I think you need to split your approach here. Once you are dealing with
interactive exploration you'll want to dump a given block with whatever
flags you want (in_asm,op,op_opt,out_asm are all relevant). So maybe
something like:

 (qemu) info tb 0xffff07ff7ee in_asm,out_asm


> +
> +    qemu_log("\n------------------------------\n");
> +    qemu_log("Translation Block PC: \t0x"TARGET_FMT_lx "\n", tbs->pc);
> +    qemu_log("Execution Count: \t%lu\n\n", (uint64_t)
> (tbs->exec_count + tbs->exec_count_overflows*0xFFFFFFFF));

For the monitor qemu_printf() would be the right output. Given they are
the same prototype you can pass a function pointer to the lowest level
function depending on if you are coming from the logging path or the
HMP. However redirecting the qemu_log output is the tricky bit.

> +
> +    mmap_lock();
> +    TranslationBlock *tb =3D tb_gen_code(current_cpu, tbs->pc, tbs->cs_b=
ase, tbs->flags, cflags);
> +    tb_phys_invalidate(tb, -1);
> +    mmap_unlock();
> +
> +    qemu_set_log(old_log_flags);

As we are manipulating the flags we'll want to make sure the rest of the
system isn't doing anything at this point. Currently that is the case on
exit() from a linux-user program but again for interactive use we'll
need to ensure we are running as safe_work (like tb_flush does).

> +
> +    tcg_tb_remove(tb);
> +}
> +
>  /* flush all the translation blocks */
>  static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
>  {
> @@ -1276,6 +1297,30 @@ done:
>      mmap_unlock();
>  }
>
> +static gint inverse_sort_tbs(gconstpointer p1, gconstpointer p2)
> +{
> +    const TBStatistics *tbs1 =3D (TBStatistics *) p1;
> +    const TBStatistics *tbs2 =3D (TBStatistics *) p2;
> +    uint64_t p1_count =3D (uint64_t) (tbs1->exec_count + tbs1->exec_coun=
t_overflows*0xFFFFFFFF);
> +    uint64_t p2_count =3D (uint64_t) (tbs2->exec_count + tbs2->exec_coun=
t_overflows*0xFFFFFFFF);
> +
> +    return p1_count < p2_count ? 1 : p1_count =3D=3D p2_count ? 0 : -1;
> +}
> +
> +void tb_dump_exec_freq(uint32_t max_tbs_to_print)
> +{
> +    tb_ctx.tb_statistics =3D g_list_sort(tb_ctx.tb_statistics, inverse_s=
ort_tbs);
> +
> +    uint32_t tbs_printed =3D 0;
> +    for (GList *i =3D tb_ctx.tb_statistics; i !=3D NULL; i =3D i->next) {
> +        tbs_printed++;
> +	    tb_dump_statistics((TBStatistics *) i->data);
> +        if (max_tbs_to_print !=3D 0 && tbs_printed >=3D max_tbs_to_print=
) {
> +            break;
> +        }
> +    }
> +}
> +
>  void tb_flush(CPUState *cpu)
>  {
>      if (tcg_enabled()) {
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 359100ef3b..0547db0271 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -533,4 +533,6 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
>  /* vl.c */
>  extern int singlestep;
>
> +void tb_dump_exec_freq(uint32_t);
> +
>  #endif


--
Alex Benn=C3=A9e

