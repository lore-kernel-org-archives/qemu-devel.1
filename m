Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3465C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 12:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 848532075C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 12:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jePwOBRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848532075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i81iS-0005xa-Og
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 08:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.weiyang@gmail.com>) id 1i81hc-0005Do-LT
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1i81hb-0004Y3-EM
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:26:28 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:41137)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1i81hb-0004XU-5G
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:26:27 -0400
Received: by mail-ed1-x544.google.com with SMTP id z9so20430740edq.8
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 05:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=sWYoxs0ktVG+leUq7hUboB1D57GIggqsqp6OORoL8V4=;
 b=jePwOBRJLrmgy533mtGve1eEAn+Xj5HatTBDu52Nf26TxqYuFtfcXfEBe1ik4KNgR6
 zMK321sb3qWNAGSW/ZJADoq8Djm6wvrU1fiiPki9k4dB/1m+8QDAuqZ4nHcItc/1or6j
 fCsch1/1kxc/YS0UINgyYCl9uoduqrecEPoCoVWVNnydiv55rnsnf1/bi3Cs+CxPVtEh
 CsW/fCVJIoLTTCb1UAU4Xuy0YXMCx2oL1zf5t7ifv26a4Yvtr9gIfNCjSBKmTxlRMAbO
 H1UPZltPOMmu5AloFv9lsnScipUgt3J/pS5jXU8v2k+LibzDuJuCavb/a4MNmoOLTiDp
 mjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=sWYoxs0ktVG+leUq7hUboB1D57GIggqsqp6OORoL8V4=;
 b=MbKNrnMdAhsILB0BIgEIQ6UO5yELdVVTSnx5t+2OxrqlLMrJ/eNKaDb3qi4gPsE1eB
 MsKNDNmhP+ddqvYXX53L0fwslq6vhCLx27rNQ7sjGFAY86u/GmJNahQd2WTgv0bZ8lqd
 WI1TFMMYYiOLenseBf7b6untfeHcvNOV/7C1t7yXUYO3lp+NnhXviL2GIehsfhWzZbOx
 OQRIozSiT8sGqXC8rV4sKIQQXCjInYZ1fB0XYwjdKJCcVPjKHG4fkbGmGZwVAX6dcOpA
 r7lXpUwLkVDPhPXNbG8F3hTplM104BRgAaqT77xDr+xe+1Mud24/EJ2Wc/Gkjug7kBJf
 +J+A==
X-Gm-Message-State: APjAAAX1qFd8iSyHAfuQNfEMrb6VLGcV8a1bKQcr3WQCWoc/IeIAE+tY
 ssSPDv8Hp/RAz1ZJFRZDHpw=
X-Google-Smtp-Source: APXvYqyrMldfppm8ccm3jDGeIJqnWQpbYwfmNyKjZ96W+nLh6w43tv1luICm4Y0RPpjmTscNh3ppKA==
X-Received: by 2002:a17:907:1048:: with SMTP id
 oy8mr29406748ejb.17.1568204785469; 
 Wed, 11 Sep 2019 05:26:25 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id q14sm2411460ejx.60.2019.09.11.05.26.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 11 Sep 2019 05:26:24 -0700 (PDT)
Date: Wed, 11 Sep 2019 12:26:23 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190911122623.la6iixhype6ubchy@master>
References: <20190731144225.3784-1-richardw.yang@linux.intel.com>
 <20190731144225.3784-3-richardw.yang@linux.intel.com>
 <20190823110609.GF2784@work-vm>
 <20190824161509.xtm65qu6k6amrjk6@master>
 <20190903184324.GA2744@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903184324.GA2744@work-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH 2/2] migration/qemu-file: fix potential buf
 waste for extra buf_index adjustment
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, berrange@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>, Wei Yang <richard.weiyang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 03, 2019 at 07:43:24PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richard.weiyang@gmail.com) wrote:
>> On Fri, Aug 23, 2019 at 12:06:09PM +0100, Dr. David Alan Gilbert wrote:
>> >(Copying Dan in)
>> >
>> >* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> >> In add_to_iovec(), qemu_fflush() will be called if iovec is full. If
>> >> this happens, buf_index is reset. Currently, this is not checked and
>> >> buf_index would always been adjust with buf size.
>> >> 
>> >> This is not harmful, but will waste some space in file buffer.
>> >
>> >That's a nice find.
>> >
>> >> This patch make add_to_iovec() return 1 when it has flushed the file.
>> >> Then the caller could check the return value to see whether it is
>> >> necessary to adjust the buf_index any more.
>> >> 
>> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >
>> >Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> >
>> >(I wonder if there's a way to wrap that little add_to_iovec, check, add
>> >to index, flush in a little wrapper).
>> >
>> >Dave
>> >
>> >> ---
>> >>  migration/qemu-file.c | 42 ++++++++++++++++++++++++++++--------------
>> >>  1 file changed, 28 insertions(+), 14 deletions(-)
>> >> 
>> >> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> >> index 35c22605dd..05d9f42ddb 100644
>> >> --- a/migration/qemu-file.c
>> >> +++ b/migration/qemu-file.c
>> >> @@ -343,8 +343,16 @@ int qemu_fclose(QEMUFile *f)
>> >>      return ret;
>> >>  }
>> >>  
>> >> -static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
>> >> -                         bool may_free)
>> >> +/*
>> >> + * Add buf to iovec. Do flush if iovec is full.
>> >> + *
>> >> + * Return values:
>> >> + * 1 iovec is full and flushed
>> >> + * 0 iovec is not flushed
>> >> + *
>> >> + */
>> >> +static int add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
>> >> +                        bool may_free)
>> >>  {
>> >>      /* check for adjacent buffer and coalesce them */
>> >>      if (f->iovcnt > 0 && buf == f->iov[f->iovcnt - 1].iov_base +
>> >> @@ -362,7 +370,10 @@ static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
>> >>  
>> >>      if (f->iovcnt >= MAX_IOV_SIZE) {
>> >>          qemu_fflush(f);
>> >> +        return 1;
>> >>      }
>> >> +
>> >> +    return 0;
>> >>  }
>> >>  
>> >>  void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
>> >> @@ -391,10 +402,11 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
>> >>          }
>> >>          memcpy(f->buf + f->buf_index, buf, l);
>> >>          f->bytes_xfer += l;
>> >> -        add_to_iovec(f, f->buf + f->buf_index, l, false);
>> >> -        f->buf_index += l;
>> >> -        if (f->buf_index == IO_BUF_SIZE) {
>> >> -            qemu_fflush(f);
>> >> +        if (!add_to_iovec(f, f->buf + f->buf_index, l, false)) {
>> >> +            f->buf_index += l;
>> >> +            if (f->buf_index == IO_BUF_SIZE) {
>> >> +                qemu_fflush(f);
>> >> +            }
>> 
>> You mean put these four lines into a wrapper?
>> 
>> Name it as add_buf_to_iovec?
>
>Yes.

Sure, Let me prepare v2 with this.


-- 
Wei Yang
Help you, Help me

