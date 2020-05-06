Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A029C38A24
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1913F206D5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNnD6LMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1913F206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWJOd-00067F-As
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jWJNd-0004fS-O0; Wed, 06 May 2020 08:42:29 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:42559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jWJNc-0008Ui-Fs; Wed, 06 May 2020 08:42:29 -0400
Received: by mail-lj1-x242.google.com with SMTP id a21so2160593ljb.9;
 Wed, 06 May 2020 05:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=nOQSLGpGO3TwX+eyRCdr9lG1bDd+uzfPjZvAcBu5KYU=;
 b=CNnD6LMKxH/UHRdV/AtJzu7v6vhha/ireUVs6C9lbk6Uv1YCVk6Ed+wt5nw9PZ0MSB
 mfKvpczQnxyj8saG0EYxa4ah4bHqiMcLO5FUO6ZVESdpnaD43of7bxZmRpd9C1dB3VNO
 SdxNOHRIo9Rro+uRMjXyyeRozB6SBfap75Vksj82YCv0uvti6C54v+xLQqA4crGlwNYL
 zI5byQ1tjxR8xnhHfLx4Ag92++TlmOCB5sZQD84YpnAiOqwD7BayNuTFW6DKLRktevNJ
 Ty59TWDceKPMsnopVQXRafPKlierpdI4UzxtXhycGSYxHOELtWljAV6D1B7pF0/xUwSX
 Fjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=nOQSLGpGO3TwX+eyRCdr9lG1bDd+uzfPjZvAcBu5KYU=;
 b=SNBms1hVFbIdAiDSb4bIGJgqq/TrS5EeHZ48ljZH7y7hjaGmvguIT5rQA1Ylo4E6iH
 +8urVQq+VlQS0wCz4x0f+J/owbaSDq/jNZXtwnkC4KS0HYn5+WSfuSZXIArfNRo43p5S
 AyNevfh2HV3VdjXPqlQZZDQQ6l8kzQvq7kioKsXGHREYIuEWWtCpV/obTigOaSmESTk1
 M4gz+fKR9/yOFpk3Sb67x9JfR/R8OLbkEbbVVgvbxhaLraoBhkNcXDZOIpqhTPYWHaPu
 5mGptuVvCH3wrEl7+Z4iUepT3AYxFHuxn/eMWPy7VYVzym3unr+U6OP42ipUwmb5NzKH
 /TTA==
X-Gm-Message-State: AGi0PuZGkkixL1I16UIiszQtivJGZi+/2G9LY7wIIiFRyvxY4plbPBAi
 NCfWA6549gBPIbeYb/gq2AQ=
X-Google-Smtp-Source: APiQypL201vwMzSr2Cde+ZQPfPCKd2wn+pxD60z5YpPmVIeNiZDRI7yhTUTM+JU5C0tUIW4uazKO3A==
X-Received: by 2002:a2e:740f:: with SMTP id p15mr4910495ljc.151.1588768946065; 
 Wed, 06 May 2020 05:42:26 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id s11sm1605438lfo.86.2020.05.06.05.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 05:42:25 -0700 (PDT)
Date: Wed, 6 May 2020 14:42:09 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 5/9] hw/core: stream: Add an end-of-packet flag
Message-ID: <20200506124209.GK5519@toto>
References: <20200506082513.18751-1-edgar.iglesias@gmail.com>
 <20200506082513.18751-6-edgar.iglesias@gmail.com>
 <c7f6947d-7815-8df3-6835-3fe933ad4dbc@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7f6947d-7815-8df3-6835-3fe933ad4dbc@amsat.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: damien.hedde@greensocs.com, peter.maydell@linaro.org,
 sstabellini@kernel.org, edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, jasowang@redhat.com, alistair@alistair23.me,
 qemu-devel@nongnu.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 figlesia@xilinx.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 06, 2020 at 01:53:33PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Edgar,

Hi Philippe,



> 
> On 5/6/20 10:25 AM, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> > 
> > Some stream clients stream an endless stream of data while
> > other clients stream data in packets. Stream interfaces
> > usually have a way to signal the end of a packet or the
> > last beat of a transfer.
> > 
> > This adds an end-of-packet flag to the push interface.
> > 
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > ---
> >   include/hw/stream.h     |  5 +++--
> >   hw/core/stream.c        |  4 ++--
> >   hw/dma/xilinx_axidma.c  | 10 ++++++----
> >   hw/net/xilinx_axienet.c | 14 ++++++++++----
> >   hw/ssi/xilinx_spips.c   |  2 +-
> >   5 files changed, 22 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/hw/stream.h b/include/hw/stream.h
> > index d02f62ca89..ed09e83683 100644
> > --- a/include/hw/stream.h
> > +++ b/include/hw/stream.h
> > @@ -39,12 +39,13 @@ typedef struct StreamSlaveClass {
> >        * @obj: Stream slave to push to
> >        * @buf: Data to write
> >        * @len: Maximum number of bytes to write
> > +     * @eop: End of packet flag
> >        */
> > -    size_t (*push)(StreamSlave *obj, unsigned char *buf, size_t len);
> > +    size_t (*push)(StreamSlave *obj, unsigned char *buf, size_t len, bool eop);
> 
> I'd split this patch, first add EOP in the push handler, keeping current
> code working, then the following patches (implementing the feature in the
> backend handlers), then ...
> 
> >   } StreamSlaveClass;
> >   size_t
> > -stream_push(StreamSlave *sink, uint8_t *buf, size_t len);
> > +stream_push(StreamSlave *sink, uint8_t *buf, size_t len, bool eop);
> 
> ... this final patch, enable the feature and let the frontends use it.
> 
> >   bool
> >   stream_can_push(StreamSlave *sink, StreamCanPushNotifyFn notify,
> > diff --git a/hw/core/stream.c b/hw/core/stream.c
> > index 39b1e595cd..a65ad1208d 100644
> > --- a/hw/core/stream.c
> > +++ b/hw/core/stream.c
> > @@ -3,11 +3,11 @@
> >   #include "qemu/module.h"
> >   size_t
> > -stream_push(StreamSlave *sink, uint8_t *buf, size_t len)
> > +stream_push(StreamSlave *sink, uint8_t *buf, size_t len, bool eop)
> >   {
> >       StreamSlaveClass *k =  STREAM_SLAVE_GET_CLASS(sink);
> > -    return k->push(sink, buf, len);
> > +    return k->push(sink, buf, len, eop);
> 
> So in this first part patch I'd use 'false' here, and update by 'eop' in the
> other part (last patch in series). Does it make sense?

Current code implicitly assumes eop = true, so this patch keeps things
working as before. It just makes the assumption explicit and guarding
backends with asserts. The support for eop = false is then added
(where relevant) in future patches, roughly the way you describe it.

I can add something to the commit message to clarify that.

Best regards,
Edgar

