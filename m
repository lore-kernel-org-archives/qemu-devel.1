Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEADC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6134521974
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RVNazbaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6134521974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMub6-0007vC-6C
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 10:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kMuZn-0007Hs-QP
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:56:27 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kMuZk-0000EP-MO
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:56:27 -0400
Received: by mail-wm1-x343.google.com with SMTP id x23so1445017wmi.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 07:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Hgo0RKH7kfv/VZXAyKSjnZwmz0wK7Kq2I6jTccm7HsI=;
 b=RVNazbaRa/pZo8NJ4yYb1ufCc7zojO9HqwnMzPUJUpiGfescBV2zi3idKQyvZ8omW2
 0npFjuDjHqpSs1Z6INq2SfpW4g0nFkecNYT21zOEYqakNwLWix/i5z53UYqemwrNInXb
 +tYDKXnxpe1PL11ZPd+eKy4P6CqrVNiF8fatElmlUjOWeKj94lMvYEpDgx/0H6UFosFJ
 y1ffOPi8IrbDYvtPgPzvUh8lyeRfi4GSWg2kd7kGHN4OgiJByiB4iv8mUm3TTKmPEJKa
 tDA0lJf+rQmVJvAV9cfw8OwxUR6zCt6dpHe85d1tJvgJ9ayd2mKu0KDG1bbTfOjqWNTV
 o+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Hgo0RKH7kfv/VZXAyKSjnZwmz0wK7Kq2I6jTccm7HsI=;
 b=OKA11k9Z5XuUvUm1xxii2pt1lkZ4RcXIxfj8AgPGoUUL2udCMTmzD7wNJd+KpglJBP
 1ibh/nRy6bxP7e5JUvjRH+46ljA5WPz+gcJxTzTXdDc8NUtLQHRmNtSaXiUgMizWyPv3
 a2nfS01ln37Swbc21Ln3WesObpSsIvtNv45khF7SPALs8KZO+34mKbRowu2ZzcjdXC24
 /+MogrVM6UEzZDCkYwAB3ZXz5bjmHmGbc/sY1kfgF+YLtVw5JFrmRJFUjuB3P29mq8Cz
 riX0KlQT3INDfNSfg/QtjkwWyOJD6uYQA72ED0g7AnXsH+JEBKkr5otuBo5rMXMnqwsd
 9SIQ==
X-Gm-Message-State: AOAM533xdKWufSzx3DRSIFte4tys2rTmT54lgsiTJLljZ3QFp5ZiS6hV
 GPgdjgURBoRh22F77xEM3Yx7gA==
X-Google-Smtp-Source: ABdhPJwbZ/8+xJ+thp9Tr9tVsaTVTYfpmESj1Rlgm4ma6QsNnTigPc5bhAady8L09l84lgirDPxyIg==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr2157894wml.25.1601304982238; 
 Mon, 28 Sep 2020 07:56:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 88sm1955595wrl.76.2020.09.28.07.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 07:56:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 428B71FF7E;
 Mon, 28 Sep 2020 15:56:19 +0100 (BST)
References: <20200925125147.26943-1-alex.bennee@linaro.org>
 <20200925125147.26943-16-alex.bennee@linaro.org>
 <20200928135201.GA9143@goby>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Joakim Bech <joakim.bech@linaro.org>
Subject: Re: [RFC PATCH  15/19] tools/vhost-user-rpmb: implement
 VIRTIO_RPMB_REQ_DATA_WRITE
In-reply-to: <20200928135201.GA9143@goby>
Date: Mon, 28 Sep 2020 15:56:19 +0100
Message-ID: <875z7yq7ak.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: jean-philippe@linaro.org, maxim.uvarov@linaro.org, bing.zhu@intel.com,
 Matti.Moell@opensynergy.com, virtualization@lists.linuxfoundation.org,
 ilias.apalodimas@linaro.org, qemu-devel@nongnu.org, arnd@linaro.org,
 takahiro.akashi@linaro.org, tomas.winkler@intel.com,
 stratos-dev@op-lists.linaro.org, hmo@opensynergy.com, yang.huang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Joakim Bech <joakim.bech@linaro.org> writes:

> On Fri, Sep 25, 2020 at 01:51:43PM +0100, Alex Benn=C3=A9e wrote:
>> With this command we are finally updating data to the backing store
>> and cycling the write_count and each successful write. We also include
>> the write count in all response frames as the spec is a little unclear
>> but the example test code expected it.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tools/vhost-user-rpmb/main.c | 111 +++++++++++++++++++++++++++++++++--
>>  1 file changed, 105 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/tools/vhost-user-rpmb/main.c b/tools/vhost-user-rpmb/main.c
>> index 88747c50fa44..a17c3b4bcc4e 100644
>> --- a/tools/vhost-user-rpmb/main.c
>> +++ b/tools/vhost-user-rpmb/main.c
>> @@ -62,6 +62,7 @@ enum {
>>  #define KiB     (1UL << 10)
>>  #define MAX_RPMB_SIZE (KiB * 128 * 256)
>>  #define RPMB_KEY_MAC_SIZE 32
>> +#define RPMB_BLOCK_SIZE 256
>>=20=20
>>  /* RPMB Request Types */
>>  #define VIRTIO_RPMB_REQ_PROGRAM_KEY        0x0001
>> @@ -100,7 +101,7 @@ struct virtio_rpmb_config {
>>  struct virtio_rpmb_frame {
>>      uint8_t stuff[196];
>>      uint8_t key_mac[RPMB_KEY_MAC_SIZE];
>> -    uint8_t data[256];
>> +    uint8_t data[RPMB_BLOCK_SIZE];
>>      uint8_t nonce[16];
>>      /* remaining fields are big-endian */
>>      uint32_t write_counter;
>> @@ -124,6 +125,7 @@ typedef struct VuRpmb {
>>      uint8_t  last_nonce[16];
>>      uint16_t last_result;
>>      uint16_t last_reqresp;
>> +    uint16_t last_address;
>>      uint32_t write_count;
>>  } VuRpmb;
>>=20=20
>> @@ -239,17 +241,30 @@ vrpmb_set_config(VuDev *dev, const uint8_t *data,
>>   * which itself uses a 3 clause BSD chunk of code.
>>   */
>>=20=20
>> +static const int rpmb_frame_dlen =3D (sizeof(struct virtio_rpmb_frame) -
>> +                                    offsetof(struct virtio_rpmb_frame, =
data));
>> +
>>  static void vrpmb_update_mac_in_frame(VuRpmb *r, struct virtio_rpmb_fra=
me *frm)
>>  {
>>      hmac_sha256_ctx ctx;
>> -    static const int dlen =3D (sizeof(struct virtio_rpmb_frame) -
>> -                             offsetof(struct virtio_rpmb_frame, data));
>>=20=20
>>      hmac_sha256_init(&ctx, r->key, RPMB_KEY_MAC_SIZE);
>> -    hmac_sha256_update(&ctx, frm->data, dlen);
>> +    hmac_sha256_update(&ctx, frm->data, rpmb_frame_dlen);
>>      hmac_sha256_final(&ctx, &frm->key_mac[0], 32);
>>  }
>>=20=20
>> +static bool vrpmb_verify_mac_in_frame(VuRpmb *r, struct virtio_rpmb_fra=
me *frm)
>> +{
>> +    hmac_sha256_ctx ctx;
>> +    uint8_t calculated_mac[RPMB_KEY_MAC_SIZE];
>> +
>> +    hmac_sha256_init(&ctx, r->key, RPMB_KEY_MAC_SIZE);
>> +    hmac_sha256_update(&ctx, frm->data, rpmb_frame_dlen);
>> +    hmac_sha256_final(&ctx, calculated_mac, RPMB_KEY_MAC_SIZE);
>> +
>> +    return memcmp(calculated_mac, frm->key_mac, RPMB_KEY_MAC_SIZE) =3D=
=3D 0;
>>
> I'd prefer using a constant time comparison function for this one
> instead of memcmp (regardless if it's used for simulation or not) to
> prevent eventual timing attacks.

Could you recommend such a function for this?

>
>> +}
>> +
>>  /*
>>   * Handlers for individual control messages
>>   */
>> @@ -324,6 +339,82 @@ vrpmb_handle_get_write_counter(VuDev *dev, struct v=
irtio_rpmb_frame *frame)
>>      return resp;
>>  }
>>=20=20
>> +/*
>> + * vrpmb_handle_write:
>> + *
>> + * We will report the success/fail on receipt of
>> + * VIRTIO_RPMB_REQ_RESULT_READ. Returns the number of extra frames
>> + * processed in the request.
>> + */
>> +static int vrpmb_handle_write(VuDev *dev, struct virtio_rpmb_frame *fra=
me)
>> +{
>> +    VuRpmb *r =3D container_of(dev, VuRpmb, dev.parent);
>> +    int extra_frames =3D 0;
>> +    uint16_t block_count =3D be16toh(frame->block_count);
>> +    uint32_t write_counter =3D be32toh(frame->write_counter);
>> +    size_t offset;
>> +
>> +    r->last_reqresp =3D VIRTIO_RPMB_RESP_DATA_WRITE;
>> +    r->last_address =3D be16toh(frame->address);
>> +    offset =3D  r->last_address * RPMB_BLOCK_SIZE;
>> +
>> +    /*
>> +     * Run the checks from:
>> +     * 5.12.6.1.3 Device Requirements: Device Operation: Data Write
>> +     */
>> +    if (!r->key) {
>> +        g_warning("no key programmed");
>> +        r->last_result =3D VIRTIO_RPMB_RES_NO_AUTH_KEY;
>> +    } else if (block_count =3D=3D 0 ||
>> +               block_count > r->virtio_config.max_wr_cnt) {
>> +        r->last_result =3D VIRTIO_RPMB_RES_GENERAL_FAILURE;
>> +    } else if (false /* what does an expired write counter mean? */) {
>>
> IIRC, the counter has room for a 32-bit value and the counter will never
> wrap around. So once the counter have reached max for uint32_t, then
> there is an additional bit set (permanently) in the operation result.
> I.e., writes are no longer possible once that has happened. That is
> probably what you're referring to here I suppose.

That would make sense. I'll see if I can make the spec language a bit
clearer as well.

>
>> +        r->last_result =3D VIRTIO_RPMB_RES_WRITE_COUNTER_EXPIRED;
>> +    } else if (offset > (r->virtio_config.capacity * (128 * KiB))) {
>> +        r->last_result =3D VIRTIO_RPMB_RES_ADDR_FAILURE;
>> +    } else if (!vrpmb_verify_mac_in_frame(r, frame)) {
>> +        r->last_result =3D VIRTIO_RPMB_RES_AUTH_FAILURE;
>> +    } else if (write_counter !=3D r->write_count) {
>> +        r->last_result =3D VIRTIO_RPMB_RES_COUNT_FAILURE;
>> +    } else {
>> +        int i;
>> +        /* At this point we have a valid authenticated write request
>> +         * so the counter can incremented and we can attempt to
>> +         * update the backing device.
>> +         */
>> +        r->write_count++;
>> +        for (i =3D 0; i < block_count; i++) {
>> +            void *blk =3D r->flash_map + offset;
>> +            g_debug("%s: writing block %d", __func__, i);
>> +            if (mprotect(blk, RPMB_BLOCK_SIZE, PROT_WRITE) !=3D 0) {
>> +                r->last_result =3D  VIRTIO_RPMB_RES_WRITE_FAILURE;
>> +                break;
>> +            }
>> +            memcpy(blk, frame[i].data, RPMB_BLOCK_SIZE);
>> +            if (msync(blk, RPMB_BLOCK_SIZE, MS_SYNC) !=3D 0) {
>> +                g_warning("%s: failed to sync update", __func__);
>> +                r->last_result =3D VIRTIO_RPMB_RES_WRITE_FAILURE;
>> +                break;
>> +            }
>> +            if (mprotect(blk, RPMB_BLOCK_SIZE, PROT_READ) !=3D 0) {
>> +                g_warning("%s: failed to re-apply read protection", __f=
unc__);
>> +                r->last_result =3D VIRTIO_RPMB_RES_GENERAL_FAILURE;
>> +                break;
>> +            }
>> +            offset +=3D RPMB_BLOCK_SIZE;
>> +        }
>> +        r->last_result =3D VIRTIO_RPMB_RES_OK;
>> +        extra_frames =3D i - 1;
>> +    }
>> +
>> +    g_info("%s: %s (%x, %d extra frames processed), write_count=3D%d", =
__func__,
>> +           r->last_result =3D=3D VIRTIO_RPMB_RES_OK ? "successful":"fai=
led",
>> +           r->last_result, extra_frames, r->write_count);
>> +
>> +    return extra_frames;
>> +}
>> +
>> +
>>  /*
>>   * Return the result of the last message. This is only valid if the
>>   * previous message was VIRTIO_RPMB_REQ_PROGRAM_KEY or
>> @@ -339,10 +430,14 @@ static struct virtio_rpmb_frame * vrpmb_handle_res=
ult_read(VuDev *dev)
>>      g_info("%s: for request:%x result:%x", __func__,
>>             r->last_reqresp, r->last_result);
>>=20=20
>> -    if (r->last_reqresp =3D=3D VIRTIO_RPMB_RESP_PROGRAM_KEY ||
>> -        r->last_reqresp =3D=3D VIRTIO_RPMB_REQ_DATA_WRITE) {
>> +    if (r->last_reqresp =3D=3D VIRTIO_RPMB_RESP_PROGRAM_KEY) {
>>          resp->result =3D htobe16(r->last_result);
>>          resp->req_resp =3D htobe16(r->last_reqresp);
>> +    } else if (r->last_reqresp =3D=3D VIRTIO_RPMB_RESP_DATA_WRITE) {
>> +        resp->result =3D htobe16(r->last_result);
>> +        resp->req_resp =3D htobe16(r->last_reqresp);
>> +        resp->write_counter =3D htobe32(r->write_count);
>> +        resp->address =3D htobe16(r->last_address);
>>      } else {
>>          resp->result =3D htobe16(VIRTIO_RPMB_RES_GENERAL_FAILURE);
>>      }
>> @@ -445,6 +540,10 @@ vrpmb_handle_ctrl(VuDev *dev, int qidx)
>>                                __func__);
>>                  }
>>                  break;
>> +            case VIRTIO_RPMB_REQ_DATA_WRITE:
>> +                /* we can have multiple blocks handled */
>> +                n +=3D vrpmb_handle_write(dev, f);
>> +                break;
>>              default:
>>                  g_debug("un-handled request: %x", f->req_resp);
>>                  break;
>> --=20
>> 2.20.1
>>=20

Thanks!

--=20
Alex Benn=C3=A9e

