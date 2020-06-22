Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F94C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE6420706
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipCxiDNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE6420706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnMvb-0004Nv-It
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 09:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnMui-0003Jw-5j
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:55:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31448
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnMuf-0007Ps-GR
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592834103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0Y/UjlCR04JoMldTPpuydet5WGEvzXbNb016hE/wtXQ=;
 b=ipCxiDNmgRrOkny1vFBnGRFVYzL5sG0dBUCsc32VUzdPhJzYqw1Yicf3bQF0qHdkedBxeS
 9+A/vTk621G7nDgflGOwIoRc3zqKO3CXPMH4/P1apPXzplEy3QSdklnq4CNqawsGeKJ0LQ
 /1iCv8vFmtq7IfA1WUvExFL5GozlyaA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-ISDU_bx0Og2CD6wQQIJz0g-1; Mon, 22 Jun 2020 09:55:02 -0400
X-MC-Unique: ISDU_bx0Og2CD6wQQIJz0g-1
Received: by mail-wr1-f69.google.com with SMTP id o1so10806494wrm.17
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 06:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=0Y/UjlCR04JoMldTPpuydet5WGEvzXbNb016hE/wtXQ=;
 b=RN4X5br4kPKhhwc4IA4+0OIRASnFMfsZysl7ZQGXH2eEXReT/0udkWizdu3dgOyrOg
 luz2MGM6qLld6+r9AWkenfw4ddI4C9macjdpbdCR5F/BUYJ6vZLqSRtRMIUhc+XJyf+H
 WrxeQdSedMaRBEuAQQUdXcMYrq0lQj74wy3vFINBVjn252YpmNJJZUVU+NpIpd4pMdQ6
 qPDWDf3lHnyrwqypJ/x94tbJmNYV7b4I8nobQEzmYEY6pBJNZZznr4TZs0ZsCi0XKWhv
 GfASxZvJ78ZD5oitDfUj+CBQnBsLDRXy10F9/1wfRGNdnFofxHeu8hQ07lkE+CX0glGQ
 1WmA==
X-Gm-Message-State: AOAM533Oc5F6eIJOwJrF3wfuS6TKGgIfpkVvvC6Hx5RZ17DJWONultR1
 Don9+Fwe3ezfKCAV7k4w4p797r2GH1LOEciWT77FUw+s2dHAHPxU3X9bY7p128++yIFKiniQ3Nd
 /1V3ZmXJAor9gSxg=
X-Received: by 2002:a1c:4e1a:: with SMTP id g26mr18104332wmh.148.1592834100360; 
 Mon, 22 Jun 2020 06:55:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6AhQ25oJ5PcD1H2oFRRxhLeiJOwsIMLBoiMbsIHpD2brpBl1LuRjx3BKvYyKzMHXSd20NFg==
X-Received: by 2002:a1c:4e1a:: with SMTP id g26mr18104308wmh.148.1592834100110; 
 Mon, 22 Jun 2020 06:55:00 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w2sm6806665wrs.77.2020.06.22.06.54.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 06:54:59 -0700 (PDT)
Subject: Re: [PATCH v9 1/5] hw/nvram/fw_cfg: Add the FW_CFG_DATA_GENERATOR
 interface
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200615103457.25282-1-philmd@redhat.com>
 <20200615103457.25282-2-philmd@redhat.com>
 <20200616153122.GN550360@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <f7c32845-3125-d7c4-0cb8-90ec45f6c135@redhat.com>
Date: Mon, 22 Jun 2020 15:54:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200616153122.GN550360@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 5:31 PM, Daniel P. Berrangé wrote:
> On Mon, Jun 15, 2020 at 12:34:53PM +0200, Philippe Mathieu-Daudé wrote:
>> The FW_CFG_DATA_GENERATOR allows any object to produce
>> blob of data consumable by the fw_cfg device.
>>
>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  docs/specs/fw_cfg.txt     |  9 ++++++-
>>  include/hw/nvram/fw_cfg.h | 52 +++++++++++++++++++++++++++++++++++++++
>>  hw/nvram/fw_cfg.c         | 36 +++++++++++++++++++++++++++
>>  3 files changed, 96 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/specs/fw_cfg.txt b/docs/specs/fw_cfg.txt
>> index 8f1ebc66fa..bc16daa38a 100644
>> --- a/docs/specs/fw_cfg.txt
>> +++ b/docs/specs/fw_cfg.txt
>> @@ -219,7 +219,7 @@ To check the result, read the "control" field:
>>  
>>  = Externally Provided Items =
>>  
>> -As of v2.4, "file" fw_cfg items (i.e., items with selector keys above
>> +Since v2.4, "file" fw_cfg items (i.e., items with selector keys above
>>  FW_CFG_FILE_FIRST, and with a corresponding entry in the fw_cfg file
>>  directory structure) may be inserted via the QEMU command line, using
>>  the following syntax:
>> @@ -230,6 +230,13 @@ Or
>>  
>>      -fw_cfg [name=]<item_name>,string=<string>
>>  
>> +Since v5.1, QEMU allows some objects to generate fw_cfg-specific content,
>> +the content is then associated with a "file" item using the 'gen_id' option
>> +in the command line, using the following syntax:
>> +
>> +    -object <generator-type>,id=<generated_id>,[generator-specific-options] \
>> +    -fw_cfg [name=]<item_name>,gen_id=<generated_id>
>> +
>>  See QEMU man page for more documentation.
>>  
>>  Using item_name with plain ASCII characters only is recommended.
>> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
>> index 25d9307018..ca69666847 100644
>> --- a/include/hw/nvram/fw_cfg.h
>> +++ b/include/hw/nvram/fw_cfg.h
>> @@ -9,11 +9,43 @@
>>  #define TYPE_FW_CFG     "fw_cfg"
>>  #define TYPE_FW_CFG_IO  "fw_cfg_io"
>>  #define TYPE_FW_CFG_MEM "fw_cfg_mem"
>> +#define TYPE_FW_CFG_DATA_GENERATOR_INTERFACE "fw_cfg-data-generator"
>>  
>>  #define FW_CFG(obj)     OBJECT_CHECK(FWCfgState,    (obj), TYPE_FW_CFG)
>>  #define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG_IO)
>>  #define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG_MEM)
>>  
>> +#define FW_CFG_DATA_GENERATOR_CLASS(class) \
>> +    OBJECT_CLASS_CHECK(FWCfgDataGeneratorClass, (class), \
>> +                       TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)
>> +#define FW_CFG_DATA_GENERATOR_GET_CLASS(obj) \
>> +    OBJECT_GET_CLASS(FWCfgDataGeneratorClass, (obj), \
>> +                     TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)
>> +
>> +typedef struct FWCfgDataGeneratorClass {
>> +    /*< private >*/
>> +    InterfaceClass parent_class;
>> +    /*< public >*/
>> +
>> +    /**
>> +     * get_data:
>> +     * @obj: the object implementing this interface
>> +     *
>> +     * Returns: pointer to start of the generated item data
>> +     *
>> +     * The returned pointer is a QObject weak reference, @obj owns
>> +     * the reference and may free it at any time in the future.
> 
> This description is a bit odd. We're just returning a plain byte
> array pointer, not a QObject, nor a reference, not will it be
> free'd at any time.
> 
>> +     */
>> +    const void *(*get_data)(Object *obj);
>> +    /**
>> +     * get_length:
>> +     * @obj: the object implementing this interface
>> +     *
>> +     * Returns: the size of the generated item data in bytes
>> +     */
>> +    size_t (*get_length)(Object *obj);
> 
> I'd be inclined to have a single method that returns a GByteArray,
> instead of separate methods for data & length.
> 
> That gives you a sized byte array, with a well define lifetime,
> which is what the caller really wants here. ie
> 
>     /**
>       * get_data:
>       * @obj: the object implementing this interface
>       *
>       * Returns: reference to a byte array containing the data.
>       * The caller should release the reference when no longer
>       * required.
>       */
>      GByteArray *(*get_data)(Object *obj);
> 
>> +} FWCfgDataGeneratorClass;
>> +
> 
> ....
> 
> 
>> +size_t fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
>> +                                 const char *gen_id, Error **errp)
>> +{
>> +    FWCfgDataGeneratorClass *klass;
>> +    Object *obj;
>> +    size_t size;
>> +
>> +    obj = object_resolve_path_component(object_get_objects_root(), gen_id);
>> +    if (!obj) {
>> +        error_setg(errp, "Cannot find object ID '%s'", gen_id);
>> +        return 0;
>> +    }
>> +    if (!object_dynamic_cast(obj, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)) {
>> +        error_setg(errp, "Object ID '%s' is not a '%s' subclass",
>> +                   gen_id, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE);
>> +        return 0;
>> +    }
>> +    klass = FW_CFG_DATA_GENERATOR_GET_CLASS(obj);
> 
> ...then the following:
> 
>> +    size = klass->get_length(obj);
>> +    if (size == 0) {
>> +        error_setg(errp, "Object ID '%s' failed to generate fw_cfg data",
>> +                   gen_id);
>> +        return 0;
>> +    }
>> +    fw_cfg_add_file(s, filename, g_memdup(klass->get_data(obj), (guint)size),
>> +                    size);
> 
> Can be replaced with:
> 
>    g_autoptr(GByteArray) data = klass->get_data(obj);
> 
>    fw_cfg_add_file(s, filename, g_byte_array_steal(data, NULL),
>                    (guint)g_byte_array_get_size(data));

g_byte_array_steal() has been added in GLib 2.64,
QEMU supports up to 2.48.

I guess I have to use g_byte_array_free_to_bytes()
and g_memdup(g_bytes_get_data()) to achieve something
similar. I'll try.

> 
> 
> If there's a real possibility of failure, then an 'Error **errp' should
> be added  to the 'get_data' method, so this code doesn't have to invent
> a error message with no useful info on the real failure.
> 
>> +
>> +    return size;
>> +}
>> +
> 
> Regards,
> Daniel
> 


