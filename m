Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472A6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 00:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B49622281
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 00:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zxi23Rpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B49622281
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWU8k-0006mT-3v
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 20:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWU7v-0006Mh-TY
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 20:43:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWU7t-0004yf-Se
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 20:43:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id j7so7937951wrt.9
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 17:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ub6+r3eYozZ2zdeYFatf5QRRPhjw1OsTWPpYt52YjSk=;
 b=Zxi23RpfOPtF/eukU3kORawIQxnfKywjhKTS8c0t02RM8MFOVj2it7LhhQTiMs+p4l
 cN9YhoYU0gaXReQG++Ro02zQCQ48p25hGM5I+Exzi6vdu4f13cBzw/TVEDvWSCpQdJ8d
 N+wdVzzSBEmbL/BOkH6YgNJ+8NfnAOiyP/NQRVXGEnLL6JjaE1Q6Wv2WeXgDvfGP++c5
 xPuWg1GV6tjCtTciuUqqLEPgqe1P91qLYTRa//tOod75Tz7USvYKPY0Mc4wLS7mi6c+k
 n8NIb4Ts4Gn4kr2gJHDju/xliwkpNgyEKNEY5xq0i6iB3qnaTzZZAV3edAXwBsT5rIQG
 Z7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ub6+r3eYozZ2zdeYFatf5QRRPhjw1OsTWPpYt52YjSk=;
 b=SfqqwsBCFMa2iWLUIgfSyDDDAudKcv5yQyOCxOdotbP2Ib4Cg75Jx4uVKmTd4H27Fm
 5aO4kSTecmfN+CDqIV1s8wP45bzpGHW7978WrJUnn0RD09i2hgF/d/olOYz2k5bPq5B1
 JspZkefmWC6Edk/gwtqJhrwGH/Lw2kqICAqVjzKpxMHhcXkl5KRjYM1fc3rzBJPaQA5/
 hMlLwM2pJQpCoUuY2/Fhe9kpQcuB0tZS0c/BY65T39CNE/gJCbNU+b6c5J3pmsEKCBsY
 6rsrrIWyuLyyj/J9LHvIPPkzce7IQcO/8pJqakbjxKpKFBXc8t5VVwgNwD/ZHQLWYatV
 iL2w==
X-Gm-Message-State: AOAM533jbLmzOW1Z0LV38bM146hcGHq3wFR2pNcUK+TejI5JvlT39mWV
 /B4c01aZlJ1KiL827j6XIdQ=
X-Google-Smtp-Source: ABdhPJzO8yeBAML6tB7w4bJ0CqVNb0gG6JDB5SAithRH0ktfA8XF/A4vuiJJyvGtjaVVVBZ85f79Rw==
X-Received: by 2002:adf:f1cd:: with SMTP id z13mr10139832wro.197.1603586592247; 
 Sat, 24 Oct 2020 17:43:12 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id q7sm13871011wrr.39.2020.10.24.17.43.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 17:43:11 -0700 (PDT)
Subject: Re: [PATCH 01/20] loader.c: Add support Motrola S-record format.
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
 <20200827123859.81793-2-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8a44e734-ef9c-f883-337b-9693f1de94a4@amsat.org>
Date: Sun, 25 Oct 2020 02:43:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200827123859.81793-2-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Alistair Francis <alistair@alistair23.me>,
 Su Hang <suhang16@mails.ucas.ac.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Alistair and Su Hang.

On 8/27/20 2:38 PM, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>   include/hw/loader.h |  14 +++
>   hw/core/loader.c    | 208 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 222 insertions(+)
> 
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index a9eeea3952..6f1fb62ded 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -55,6 +55,20 @@ int load_image_targphys_as(const char *filename,
>    */
>   int load_targphys_hex_as(const char *filename, hwaddr *entry, AddressSpace *as);
>   
> +/*
> + * load_targphys_srec_as:
> + * @filename: Path to the .hex file
> + * @entry: Store the entry point given by the .hex file
> + * @as: The AddressSpace to load the .hex file to. The value of
> + *      address_space_memory is used if nothing is supplied here.
> + *
> + * Load a fixed .srec file into memory.
> + *
> + * Returns the size of the loaded .hex file on success, -1 otherwise.
> + */
> +int load_targphys_srec_as(const char *filename,
> +                          hwaddr *entry, AddressSpace *as);
> +
>   /** load_image_targphys:
>    * Same as load_image_targphys_as(), but doesn't allow the caller to specify
>    * an AddressSpace.
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 8bbb1797a4..6964b04ec7 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -1618,3 +1618,211 @@ int load_targphys_hex_as(const char *filename, hwaddr *entry, AddressSpace *as)
>       g_free(hex_blob);
>       return total_size;
>   }
> +
> +typedef enum {
> +    SREC_SOH,
> +    SREC_TYPE,
> +    SREC_LEN,
> +    SREC_ADDR,
> +    SREC_DATA,
> +    SREC_SKIP,
> +    SREC_SUM,
> +} srec_state;
> +
> +typedef struct {
> +    srec_state state;
> +    int nibble;
> +    int total_size;
> +    uint32_t address;
> +    uint32_t topaddr;
> +    uint32_t bufremain;
> +    int length;
> +    int addr_len;
> +    int record_type;
> +    uint8_t byte;
> +    uint8_t data[DATA_FIELD_MAX_LEN];
> +    uint8_t *datap;
> +    uint8_t *bufptr;
> +    uint8_t sum;
> +} SrecLine;
> +
> +static bool parse_srec_line(SrecLine *line, char c)
> +{
> +    if (!g_ascii_isxdigit(c)) {
> +        return false;
> +    }
> +    line->byte <<= 4;
> +    line->byte |= g_ascii_xdigit_value(c);
> +    line->nibble++;
> +    if (line->nibble == 2) {
> +        line->nibble = 0;
> +        line->length--;
> +        line->sum += line->byte;
> +        switch (line->state) {
> +        case SREC_SOH:
> +        case SREC_TYPE:
> +            /* first 2chars ignore parse */
> +            break;
> +        case SREC_LEN:
> +            line->sum = line->length = line->byte;
> +            if (line->addr_len > 0) {
> +                line->state = SREC_ADDR;
> +                line->address = 0;
> +            } else {
> +                line->state = SREC_SKIP;
> +            }
> +            break;
> +        case SREC_ADDR:
> +            line->address <<= 8;
> +            line->address |= line->byte;
> +            if (--line->addr_len == 0) {
> +                if (line->length > 1) {
> +                    if (line->record_type != 0) {
> +                        line->state = SREC_DATA;
> +                    } else {
> +                        line->state = SREC_SKIP;
> +                    }
> +                    line->datap = line->data;
> +                } else {
> +                    line->state = SREC_SUM;
> +                }
> +            }
> +            break;
> +        case SREC_DATA:
> +            *line->datap++ = line->byte;
> +            /* fail through */
> +        case SREC_SKIP:
> +            if (line->length == 1) {
> +                line->state = SREC_SUM;
> +            }
> +            break;
> +        case SREC_SUM:
> +            if ((line->sum & 0xff) != 0xff) {
> +                return false;
> +            }
> +        }
> +    }
> +    return true;
> +}
> +
> +#define SRECBUFSIZE 0x40000
> +
> +/* return size or -1 if error */
> +static int parse_srec_blob(const char *filename, hwaddr *addr,
> +                           uint8_t *hex_blob, size_t hex_blob_size,
> +                           AddressSpace *as)
> +{
> +    SrecLine line;
> +    size_t len;
> +    int total_len = 0;
> +    uint8_t *end = hex_blob + hex_blob_size;
> +    rom_transaction_begin();
> +    line.state = SREC_SOH;
> +    line.bufptr = g_malloc(SRECBUFSIZE);
> +    line.bufremain = SRECBUFSIZE;
> +    line.topaddr = UINT32_MAX;
> +    for (; hex_blob < end; ++hex_blob) {
> +        switch (*hex_blob) {
> +        case '\r':
> +        case '\n':
> +            if (line.state == SREC_SUM) {
> +                switch (line.record_type) {
> +                case 1:
> +                case 2:
> +                case 3:
> +                    len = line.datap - line.data;
> +                    if (line.topaddr == UINT32_MAX) {
> +                        line.topaddr = line.address;
> +                    }
> +                    if (line.bufremain < len || line.address < line.topaddr) {
> +                        rom_add_blob_fixed_as(filename, line.bufptr,
> +                                              SRECBUFSIZE - line.bufremain,
> +                                              line.topaddr, as);
> +                        line.topaddr = line.address;
> +                        line.bufremain = SRECBUFSIZE;
> +                    }
> +                    memcpy(line.bufptr + (line.address  - line.topaddr),
> +                           line.data, len);
> +                    line.bufremain -= len;
> +                    total_len += len;
> +                    break;
> +                case 7:
> +                case 8:
> +                case 9:
> +                    *addr = line.address;
> +                    break;
> +                }
> +                line.state = SREC_SOH;
> +            }
> +            break;
> +        /* start of a new record. */
> +        case 'S':
> +            if (line.state != SREC_SOH) {
> +                total_len = -1;
> +                goto out;
> +            }
> +            line.state = SREC_TYPE;
> +            break;
> +        /* decoding lines */
> +        default:
> +            if (line.state == SREC_TYPE) {
> +                if (g_ascii_isdigit(*hex_blob)) {
> +                    line.record_type = g_ascii_digit_value(*hex_blob);
> +                    switch (line.record_type) {
> +                    case 1:
> +                    case 2:
> +                    case 3:
> +                        line.addr_len = 1 + line.record_type;
> +                        break;
> +                    case 0:
> +                    case 5:
> +                        line.addr_len = 2;
> +                        break;
> +                    case 7:
> +                    case 8:
> +                    case 9:
> +                        line.addr_len = 11 - line.record_type;
> +                        break;
> +                    default:
> +                        line.addr_len = 0;
> +                    }
> +                }
> +                line.state = SREC_LEN;
> +                line.nibble = 0;
> +            } else {
> +                if (!parse_srec_line(&line, *hex_blob)) {
> +                    total_len = -1;
> +                    goto out;
> +                }
> +            }
> +            break;
> +        }
> +    }
> +    if (line.bufremain < SRECBUFSIZE) {
> +        rom_add_blob_fixed_as(filename, line.bufptr,
> +                              SRECBUFSIZE - line.bufremain,
> +                              line.topaddr, as);
> +    }
> +out:
> +    rom_transaction_end(total_len != -1);
> +    g_free(line.bufptr);
> +    return total_len;
> +}
> +
> +/* return size or -1 if error */
> +int load_targphys_srec_as(const char *filename, hwaddr *entry, AddressSpace *as)
> +{
> +    gsize hex_blob_size;
> +    gchar *hex_blob;
> +    int total_size = 0;
> +
> +    if (!g_file_get_contents(filename, &hex_blob, &hex_blob_size, NULL)) {
> +        return -1;
> +    }
> +
> +    total_size = parse_srec_blob(filename, entry, (uint8_t *)hex_blob,
> +                                 hex_blob_size, as);
> +
> +    g_free(hex_blob);
> +    return total_size;
> +}
> 


