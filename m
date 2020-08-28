Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1294C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6979C2071B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDuzfS/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6979C2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBaT3-0001FM-NL
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBaSL-0008W1-B8; Fri, 28 Aug 2020 05:13:57 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:42945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBaSJ-0002rr-M6; Fri, 28 Aug 2020 05:13:57 -0400
Received: by mail-lj1-x241.google.com with SMTP id t6so491742ljk.9;
 Fri, 28 Aug 2020 02:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=kgqbKT1VKqMP3sZLLHswJyAnI9w+WI95Xd4LvcEi2K4=;
 b=QDuzfS/2/nfgRQIyCkdhWNhfCDC8ktLSZRUyFKdQZJIrJ6vIxBwPtqEaRwhlUBG9vf
 ZIA06jtIlfnemqkJkQA5zyyHTMcg6rwG63etQMjh2EIJgAg0O/aMpW11byahv9BhPAjZ
 nwemY1kaE9BmS8TdbEB5LnP/BlwiTydj3kpUKUuGvmieIs3z4LhL+nyCRuW4TU6wicwU
 K4EHsczqCJ827YmiDY4wj5Hd/xD3kqGEr/Hj5URc0KrXSO2AdVVRP9jdQ2WwqIle3vXV
 Oz2sPdwDFmP4HH9A99HK170R0uSwxacLPh31xOICwdBOc5iiAxeKJMbAsFqzX3UHkasQ
 QDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=kgqbKT1VKqMP3sZLLHswJyAnI9w+WI95Xd4LvcEi2K4=;
 b=LVZh2iTTBwOd1RErhcm387KB8iCpMO37DsroqKtXRgxeOhKWsqK95XDhMQ2O9PyvtZ
 fzKl9VoNeH7xGF3QP6pC3b0/wwx6sfuMvSfva3uhbD3q0T32nufl9QU//gUBj57dGyhO
 Y5HMduUfeXyROnSQLdF3K2pqknU5AhUJLTx3LES7QDplwVZ683nogRxO9JNZdc6/1LhQ
 lKBjJmbxSWxhyK6s/MkXVSnBF3QvYwLFGVjrUzGjXeedQTExfurctKRwh7u/3uPwtC/v
 gfH8vOfFZ1N2xci4+jnTTeji0NQs1/cnkxuIPSiLmVANbFshN3hAZCjpoFYmW2SMyuem
 CFOg==
X-Gm-Message-State: AOAM531Yl1zVLX5R6lA6q8r8yIFkfLe7DIf7pQh9DX+CSDsPxkfS0ode
 jdvRYmcg/2Nv3w8qoPx4uKs=
X-Google-Smtp-Source: ABdhPJzHV8WBcTbOyY60iSCqR1SiMBjY6quykQsVLInThrmjNQmHFC1VQnMuN8UTh6ApNIHRuI0cNw==
X-Received: by 2002:a05:651c:1122:: with SMTP id
 e2mr433345ljo.36.1598606032579; 
 Fri, 28 Aug 2020 02:13:52 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id e14sm75034ljj.120.2020.08.28.02.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:13:51 -0700 (PDT)
Date: Fri, 28 Aug 2020 11:13:51 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 2/2] util/hexdump: Reorder qemu_hexdump() arguments
Message-ID: <20200828091351.GT2954729@toto>
References: <20200822180950.1343963-1-f4bug@amsat.org>
 <20200822180950.1343963-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200822180950.1343963-3-f4bug@amsat.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 18
X-Spam_score: 1.8
X-Spam_bar: +
X-Spam_report: (1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.899, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-devel@nongnu.org, Zhang Chen <chen.zhang@intel.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 22, 2020 at 08:09:50PM +0200, Philippe Mathieu-Daudé wrote:
> qemu_hexdump()'s pointer to the buffer and length of the
> buffer are closely related arguments but are widely separated
> in the argument list order (also, the format of <stdio.h>
> function prototypes is usually to have the FILE* argument
> coming first).
> 
> Reorder the arguments as "fp, prefix, buf, size" which is
> more logical.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> ---
>  include/qemu-common.h    |  4 ++--
>  hw/dma/xlnx_dpdma.c      |  2 +-
>  hw/net/fsl_etsec/etsec.c |  2 +-
>  hw/net/fsl_etsec/rings.c |  2 +-
>  hw/sd/sd.c               |  2 +-
>  hw/usb/redirect.c        |  2 +-
>  net/colo-compare.c       | 24 ++++++++++++------------
>  net/net.c                |  2 +-
>  util/hexdump.c           |  4 ++--
>  util/iov.c               |  2 +-
>  10 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index 6834883822f..9cfd62669bf 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -138,8 +138,8 @@ int os_parse_cmd_args(int index, const char *optarg);
>   * Hexdump a buffer to a file. An optional string prefix is added to every line
>   */
>  
> -void qemu_hexdump(const void *bufptr, FILE *fp,
> -                  const char *prefix, size_t size);
> +void qemu_hexdump(FILE *fp, const char *prefix,
> +                  const void *bufptr, size_t size);
>  
>  /*
>   * helper to parse debug environment variables
> diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
> index d75a8069426..967548abd31 100644
> --- a/hw/dma/xlnx_dpdma.c
> +++ b/hw/dma/xlnx_dpdma.c
> @@ -388,7 +388,7 @@ static void xlnx_dpdma_dump_descriptor(DPDMADescriptor *desc)
>  {
>      if (DEBUG_DPDMA) {
>          qemu_log("DUMP DESCRIPTOR:\n");
> -        qemu_hexdump(desc, stdout, "", sizeof(DPDMADescriptor));
> +        qemu_hexdump(stdout, "", desc, sizeof(DPDMADescriptor));
>      }
>  }
>  
> diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
> index c817a28decd..c5edb25dc9f 100644
> --- a/hw/net/fsl_etsec/etsec.c
> +++ b/hw/net/fsl_etsec/etsec.c
> @@ -357,7 +357,7 @@ static ssize_t etsec_receive(NetClientState *nc,
>  
>  #if defined(HEX_DUMP)
>      fprintf(stderr, "%s receive size:%zd\n", nc->name, size);
> -    qemu_hexdump(buf, stderr, "", size);
> +    qemu_hexdump(stderr, "", buf, size);
>  #endif
>      /* Flush is unnecessary as are already in receiving path */
>      etsec->need_flush = false;
> diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
> index 337a55fc957..628648a9c37 100644
> --- a/hw/net/fsl_etsec/rings.c
> +++ b/hw/net/fsl_etsec/rings.c
> @@ -269,7 +269,7 @@ static void process_tx_bd(eTSEC         *etsec,
>  
>  #if defined(HEX_DUMP)
>              qemu_log("eTSEC Send packet size:%d\n", etsec->tx_buffer_len);
> -            qemu_hexdump(etsec->tx_buffer, stderr, "", etsec->tx_buffer_len);
> +            qemu_hexdump(stderr, "", etsec->tx_buffer, etsec->tx_buffer_len);
>  #endif  /* ETSEC_RING_DEBUG */
>  
>              if (etsec->first_bd.flags & BD_TX_TOEUN) {
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 190e4cf1232..6508939b1f4 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1781,7 +1781,7 @@ send_response:
>      }
>  
>  #ifdef DEBUG_SD
> -    qemu_hexdump(response, stderr, "Response", rsplen);
> +    qemu_hexdump(stderr, "Response", response, rsplen);
>  #endif
>  
>      return rsplen;
> diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> index 09edb0d81c0..48f38d33912 100644
> --- a/hw/usb/redirect.c
> +++ b/hw/usb/redirect.c
> @@ -240,7 +240,7 @@ static void usbredir_log_data(USBRedirDevice *dev, const char *desc,
>      if (dev->debug < usbredirparser_debug_data) {
>          return;
>      }
> -    qemu_hexdump(data, stderr, desc, len);
> +    qemu_hexdump(stderr, desc, data, len);
>  }
>  
>  /*
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 550272b3baa..4a5ed642e9a 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -494,10 +494,10 @@ sec:
>          g_queue_push_head(&conn->secondary_list, spkt);
>  
>          if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
> -            qemu_hexdump(ppkt->data, stderr,
> -                        "colo-compare ppkt", ppkt->size);
> -            qemu_hexdump(spkt->data, stderr,
> -                        "colo-compare spkt", spkt->size);
> +            qemu_hexdump(stderr, "colo-compare ppkt",
> +                         ppkt->data, ppkt->size);
> +            qemu_hexdump(stderr, "colo-compare spkt",
> +                         spkt->data, spkt->size);
>          }
>  
>          colo_compare_inconsistency_notify(s);
> @@ -535,10 +535,10 @@ static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
>          trace_colo_compare_udp_miscompare("primary pkt size", ppkt->size);
>          trace_colo_compare_udp_miscompare("Secondary pkt size", spkt->size);
>          if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
> -            qemu_hexdump(ppkt->data, stderr, "colo-compare pri pkt",
> -                         ppkt->size);
> -            qemu_hexdump(spkt->data, stderr, "colo-compare sec pkt",
> -                         spkt->size);
> +            qemu_hexdump(stderr, "colo-compare pri pkt",
> +                         ppkt->data, ppkt->size);
> +            qemu_hexdump(stderr, "colo-compare sec pkt",
> +                         spkt->data, spkt->size);
>          }
>          return -1;
>      } else {
> @@ -578,10 +578,10 @@ static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
>          trace_colo_compare_icmp_miscompare("Secondary pkt size",
>                                             spkt->size);
>          if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
> -            qemu_hexdump(ppkt->data, stderr, "colo-compare pri pkt",
> -                         ppkt->size);
> -            qemu_hexdump(spkt->data, stderr, "colo-compare sec pkt",
> -                         spkt->size);
> +            qemu_hexdump(stderr, "colo-compare pri pkt",
> +                         ppkt->data, ppkt->size);
> +            qemu_hexdump(stderr, "colo-compare sec pkt",
> +                         spkt->data, spkt->size);
>          }
>          return -1;
>      } else {
> diff --git a/net/net.c b/net/net.c
> index f3e5d533fd7..7a2a0fb5ac6 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -636,7 +636,7 @@ static ssize_t qemu_send_packet_async_with_flags(NetClientState *sender,
>  
>  #ifdef DEBUG_NET
>      printf("qemu_send_packet_async:\n");
> -    qemu_hexdump(buf, stdout, "net", size);
> +    qemu_hexdump(stdout, "net", buf, size);
>  #endif
>  
>      if (sender->link_down || !sender->peer) {
> diff --git a/util/hexdump.c b/util/hexdump.c
> index 053f05d4160..0b4662e701d 100644
> --- a/util/hexdump.c
> +++ b/util/hexdump.c
> @@ -16,8 +16,8 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  
> -void qemu_hexdump(const void *bufptr, FILE *fp,
> -                  const char *prefix, size_t size)
> +void qemu_hexdump(FILE *fp, const char *prefix,
> +                  const void *bufptr, size_t size)
>  {
>      const char *buf = bufptr;
>      unsigned int b, len, i, c;
> diff --git a/util/iov.c b/util/iov.c
> index 45ef3043eec..ae61d696aae 100644
> --- a/util/iov.c
> +++ b/util/iov.c
> @@ -237,7 +237,7 @@ void iov_hexdump(const struct iovec *iov, const unsigned int iov_cnt,
>      size = size > limit ? limit : size;
>      buf = g_malloc(size);
>      iov_to_buf(iov, iov_cnt, 0, buf, size);
> -    qemu_hexdump(buf, fp, prefix, size);
> +    qemu_hexdump(fp, prefix, buf, size);
>      g_free(buf);
>  }
>  
> -- 
> 2.26.2
> 

