Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2F8C4CEC9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B17207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+8npP86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B17207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBJmN-00047a-CE
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 10:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iBJl3-0002mm-Ba
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iBJl1-0007ur-Kb
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:19:36 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46574)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iBJl1-0007uG-DN
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:19:35 -0400
Received: by mail-oi1-x244.google.com with SMTP id k25so1854121oiw.13
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 07:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=H8Lf3cUrmDx5FlUUH+IBWW18Vqv5/1olFq80IuJniCU=;
 b=t+8npP86dDDaM0R9eII9ufyNcahdUqRuRSDIc2pKj60goDG2y8DyveWR4X2TAmFW+C
 7kD6PM5SQcyz55moqqmp7iauRwECQOx7HmijQhUhxKJ4wz8NIQjkRKA/vpgVbUf1LqKy
 viZ77/YI+RT8KAbh51zZelB21v68gnWG2TzthRGLiEVGnCao3B7wHKVC7MQI84ct6b7J
 VyBEeEek5gKz/8Tx9lhbJnnZaoNnCib6JF6YaWx0DsIi42zy27kpEB9joCNlK9+KyOyE
 OK1VUC84Y7gueUpgVrYdrphHqkdJVyjqr/Scgh/sLL0Czp2NBj9s0fYPS5v1uatVnjuI
 58lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=H8Lf3cUrmDx5FlUUH+IBWW18Vqv5/1olFq80IuJniCU=;
 b=NKzaN2UjdM2oRK6EAjK7bq4TlNNLAdU3XPXw6X+sXG9XPAkn5t2wzucJFcOddLaA8J
 Jb7u3DYWR/F3UqL5fLjdNd8hc6hFop8q2bbfXHM6t6Yr/IXiSq0AvRcp5nkn1MVeZWP+
 yE2kgySEd5MlcgcL48TKNRGLPrKblFNEy7B0cdKrEcX89HF3BF1joEmjd7mwXU+bvXf2
 3hMc7lCbc4M2kAnEZxHm7nXTdmeWBrqTjo4OTAW9nY2MeWwbN7DvqS31X5tBiJ2ocTcO
 rhKmq8YN8arvWYbXMnb2DdpsK3LRWW0CX1n2KsHd34uoHgpYY5STa2tVTiGlJILbqPyu
 Po+Q==
X-Gm-Message-State: APjAAAXFIBFKUFfGLLMkRz5aDG2Zexad4lCtyDzaFFYSsp8t0I64JOlk
 tC9o0dcUXVT4RDbuJlAzkBe1zUn/Xvaa1h5CuMX1rw==
X-Google-Smtp-Source: APXvYqzat/pqJIrTEKTFeXtrCE9KohDuz5HwP2Ew9lyWk7mjwfzMXe4/uJjahGypUMoSFFz/T19+WnbbfSaa1AR9HMg=
X-Received: by 2002:aca:53d4:: with SMTP id h203mr2994207oib.146.1568989173884; 
 Fri, 20 Sep 2019 07:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190920141248.12887-1-philmd@redhat.com>
In-Reply-To: <20190920141248.12887-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Sep 2019 15:19:22 +0100
Message-ID: <CAFEAcA981SOP7UqgXYcTt1s29TfiUwxWc9GoJd+m+BO4WHrz_g@mail.gmail.com>
Subject: Re: [PATCH] memory: Replace DEBUG_UNASSIGNED printf calls by trace
 events
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Sep 2019 at 15:12, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Now that the unassigned_access CPU hooks have been removed,
> the unassigned_mem_read/write functions are only used for
> debugging purpose.
> Simplify by converting them to in-place trace events.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Based-on: <20190920125008.13604-1-peter.maydell@linaro.org>
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04668.html
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03705.html
>
> I first wrote:
>
>   These functions are declared using the CPUReadMemoryFunc/
>   CPUWriteMemoryFunc prototypes. Since it is confusing to
>   have such prototype only use for debugging, convert them
>   to in-place trace events.
>
> But it doesn't provide helpful information and is rather confusing.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> @@ -1437,7 +1418,8 @@ MemTxResult memory_region_dispatch_read(MemoryRegio=
n *mr,
>      MemTxResult r;
>
>      if (!memory_region_access_valid(mr, addr, size, false, attrs)) {
> -        *pval =3D unassigned_mem_read(mr, addr, size);
> +        trace_memory_region_invalid_read(size, addr);
> +        *pval =3D 0; /* FIXME now this value shouldn't be accessed in gu=
est */

This FIXME comment is not entirely correct.

Unassigned memory will RAZ/WI and the 0 will be seen by:
 * guest CPUs which don't implement a do_transaction_failed hook
   (or which have a hook that doesn't always raise an exception)
 * other transaction masters, such as DMA controllers, if they
   choose to ignore the MemTxResult (or use an API that doesn't
   expose the MemTxResult)

> diff --git a/trace-events b/trace-events
> index 823a4ae64e..83dbeb4b46 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -62,6 +62,8 @@ memory_region_tb_read(int cpu_index, uint64_t addr, uin=
t64_t value, unsigned siz
>  memory_region_tb_write(int cpu_index, uint64_t addr, uint64_t value, uns=
igned size) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
>  memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, ui=
nt64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx6=
4" size %u"
>  memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, u=
int64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx=
64" size %u"
> +memory_region_invalid_read(unsigned size, uint64_t addr) "invalid read s=
ize %u addr 0x%"PRIx64
> +memory_region_invalid_write(unsigned size, uint64_t addr, int fmt_width,=
 uint64_t value) "invalid write size %u addr 0x%"PRIx64" value 0x%0*"PRIx64

Do all our trace backends support format strings which use the
"dynamic format width specified via '*'" syntax ?

thanks
-- PMM

