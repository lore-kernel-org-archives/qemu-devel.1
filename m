Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CEBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3B52078D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="bDLSvcv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3B52078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8QU8-0006pb-LR
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 11:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1k8QT7-0006K3-7H
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:57:43 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:41374)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1k8QT4-0004sZ-HX
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:57:40 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
 by mail1.hostfission.com (Postfix) with ESMTP id 976174275C;
 Thu, 20 Aug 2020 01:57:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1597852655;
 bh=wMRiT0hpmK1L2pjqonIBrqH+eBeDVadbXxoI2dlDo34=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bDLSvcv98fZGckGsCQZJTiHFumYM6o4WAlofTm2mBL7wdCuM7Cq9faJoVtRPZN1Oy
 JktAnmHYBsBYJ9gfM2r5DcvMsvtdt99tGmybyjO4dh1NmOMZvNwNWRt9ovMSyvxNzk
 +468UODvblLezePMgoWiBLzQ/ds2HwVA+eQpajyo=
Received: from mail.hostfission.com (www1.hostfission.com [127.0.0.1])
 by www1.hostfission.com (Postfix) with ESMTP id 8232089DE3;
 Thu, 20 Aug 2020 01:57:35 +1000 (AEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Aug 2020 01:57:35 +1000
From: Geoffrey McRae <geoff@hostfission.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Subject: Re: [PATCH] audio/jack: fix use after free segfault
In-Reply-To: <2455919.OPqOAOcq0L@silver>
References: <20200818131206.BB75F3A0B9F@moya.office.hostfission.com>
 <1858869.V9CTJjVLrA@silver>
 <1690c001c97df6bf0024519363d089a1@hostfission.com>
 <2455919.OPqOAOcq0L@silver>
Message-ID: <dc6f0fa4785e21fbe0c9a9f82793b5ed@hostfission.com>
X-Sender: geoff@hostfission.com
User-Agent: Roundcube Webmail/1.3.8
Received-SPF: pass client-ip=139.99.139.48; envelope-from=geoff@hostfission.com;
 helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 11:27:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-08-20 01:51, Christian Schoenebeck wrote:
> On Mittwoch, 19. August 2020 14:51:52 CEST Geoffrey McRae wrote:
>> >> > What latencies do you achieve BTW with Windows guests?
>> >>
>> >> Never tested, it's not the reason why I use jack.
>> >
>> > Surpring that you never checked the min. latency there, as you nailed
>> > quite an
>> > ambitous jack driver into QEMU which I just realize now. Must have been
>> > splipped my awareness due to traffic.
>> 
>> Sorry, I should have been clearer. I have tested windows and the 
>> latency
>> is excellent, but I have never performed any empirical measurements.
> 
>     /*
>      * ensure the buffersize is no smaller then 512 samples, some 
> (all?) qemu
>      * virtual devices do not work correctly otherwise
>      */
>     if (c->buffersize < 512) {
>         c->buffersize = 512;
>     }
> 
> So min. latency is 12ms @44.1 kHz.
> 
>> >> I get no stuttering issues like is commonly
>> >> reported for ALSA and PA, and allows for a high degree of
>> >> reconfigurability. The guest VM overall performs far better also as
>> >> windows is never waiting on the audio device due to the decoupling
>> >> provided by the ring buffer in my implementation.
>> >
>> > Yeah, looks good indeed!
> 
> The ringbuffer implementation looks a bit wild:
> 
> /* read PCM interleaved */
> static int qjack_buffer_read(QJackBuffer *buffer, float *dest, int 
> size)
> {
>     assert(buffer->data);
>     const int samples = size / sizeof(float);
>     int frames        = samples / buffer->channels;
>     const int avail   = atomic_load_acquire(&buffer->used);
> 
>     if (frames > avail) {
>         frames = avail;
>     }
> 
>     int copy = frames;
>     int rptr = buffer->rptr;
> 
>     while (copy) {
> 
>         for (int c = 0; c < buffer->channels; ++c) {
>             *dest++ = buffer->data[c][rptr];
>         }
> 
>         if (++rptr == buffer->frames) {
>             rptr = 0;
>         }
> 
>         --copy;
>     }
> 
>     buffer->rptr = rptr;
> 
>     atomic_sub(&buffer->used, frames);
>     return frames * buffer->channels * sizeof(float);
> }
> 
> On both sides there is no check whether one side is over/underrunning 
> the
> other side (rptr vs. wptr). I would really recommend using an existing
> ringbuffer implementation instead of writing one by yourself.

`buffer->used` ensures there is no overwrite unless I have missed 
something?

> 
> And question:
> 
> static size_t qjack_write(HWVoiceOut *hw, void *buf, size_t len)
> {
>     QJackOut *jo = (QJackOut *)hw;
>     ++jo->c.packets;
> 
>     if (jo->c.state != QJACK_STATE_RUNNING) {
>         qjack_client_recover(&jo->c);
>         return len;
>     }
> 
>     qjack_client_connect_ports(&jo->c);
>     return qjack_buffer_write(&jo->c.fifo, buf, len);
> }
> 
> So you are ensuring to reconnect the JACK ports in every cycle. Isn't 
> that a
> bit often?

No, please see the implementation of qjack_client_connect_ports.

> 
> Best regards,
> Christian Schoenebeck

