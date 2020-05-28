Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6ADFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 14:55:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A36D9206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 14:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmPur9LP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36D9206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeJwM-0006wb-Rb
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 10:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeJvh-0006Rh-Vk
 for qemu-devel@nongnu.org; Thu, 28 May 2020 10:54:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29673
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeJvg-0001os-D2
 for qemu-devel@nongnu.org; Thu, 28 May 2020 10:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590677683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wopF0DZXkjJ8VJnBied5iht62DgoHp4S8JEhYy2aPdU=;
 b=KmPur9LPNhUmPvjcvQDg+IbepTMfeQAfFBTvZhjzlOQ7o1guCPg+/+zv1pMPtQrpUYYkKp
 eynurC/8qZC9oXVi7kahfToL2/BiIhw8Zj64VgWnckxNanUKKXt2PMW2+pP/zBXBAy34a0
 lhEXFJctaDNPeAI4zTg/DaXZJSPp+FQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-BZZU1l_jPzG2Cr7c7g2plA-1; Thu, 28 May 2020 10:54:41 -0400
X-MC-Unique: BZZU1l_jPzG2Cr7c7g2plA-1
Received: by mail-wr1-f71.google.com with SMTP id 3so5707095wrs.10
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 07:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=wopF0DZXkjJ8VJnBied5iht62DgoHp4S8JEhYy2aPdU=;
 b=tbCzJA1IKmjVDhaduplkS2Tfm4iOaTmlw33zKQe4pbMh51TBcrZQvfBuNzXXfFjQUF
 MHIICMqApTzk076UZ2ucUJgpwB9VzmA9XvvyMHWXzPc6+THjOAm3iRcrBPq8XLJX/hwz
 r/N4REa1QonT1p04/m4E58Oeh8kABRAFLKWJ6GHQLOkZ/hmo9WrJf9rUGi5HSJx69XjE
 URCyq3lJE1YhsNIA9yB9c9KnIWnSvGXh8ZbECV2ISGozCrI+Z4hY1PCNOclDUXKKBsy1
 eA36n/YtJ4wxhSEfpPIvDFzOi2zOyF4qx5M1suuKl3N5yUlHw7WbCSURlAFMIs6ud6Q8
 u1+g==
X-Gm-Message-State: AOAM530bdlwMv5sWKqTDHnxU833MYjDPZajuV+1DzXwydSp+X7YkohTx
 zQbcvq6Dq5ICKCYzWfr/5Nk7OvLj7Qxhs+QbrEowSnJJIHRi+P8jfBAASyUKzpEMaEFiWQ2UJmb
 lzSoHXfd3xy8ampE=
X-Received: by 2002:a1c:7c0e:: with SMTP id x14mr3633422wmc.1.1590677680337;
 Thu, 28 May 2020 07:54:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0Imi7I9hsl/aoolkHdf2cW/cUJElrOlUYgLw7hWzqTvQOjlOGFuP0IKsrmlMzrUTFgumrTg==
X-Received: by 2002:a1c:7c0e:: with SMTP id x14mr3633392wmc.1.1590677679944;
 Thu, 28 May 2020 07:54:39 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id o20sm6305087wra.29.2020.05.28.07.54.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2020 07:54:39 -0700 (PDT)
Subject: Re: [PATCH v6 1/5] hw/nvram/fw_cfg: Add the FW_CFG_DATA_GENERATOR
 interface
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
References: <20200519182024.14638-1-philmd@redhat.com>
 <20200519182024.14638-2-philmd@redhat.com>
 <845b9e8e-0925-da57-a484-3a96d554432d@redhat.com>
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
Message-ID: <259b82d5-3f17-1a2a-bd06-421df0673792@redhat.com>
Date: Thu, 28 May 2020 16:54:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <845b9e8e-0925-da57-a484-3a96d554432d@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 12:01 AM, Laszlo Ersek wrote:
> On 05/19/20 20:20, Philippe Mathieu-Daudé wrote:
>> The FW_CFG_DATA_GENERATOR allow any object to product
> 
> (1) I suggest:
> 
> s/allow/allows/
> s/product/produce/
> 
>> blob of data consumable by the fw_cfg device.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  include/hw/nvram/fw_cfg.h | 49 +++++++++++++++++++++++++++++++++++++++
>>  hw/nvram/fw_cfg.c         | 30 ++++++++++++++++++++++++
>>  2 files changed, 79 insertions(+)
>>
>> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
>> index 25d9307018..74b4790fae 100644
>> --- a/include/hw/nvram/fw_cfg.h
>> +++ b/include/hw/nvram/fw_cfg.h
>> @@ -9,11 +9,40 @@
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
>> +     */
>> +    const void *(*get_data)(Object *obj);
> 
> I'm not familiar with QOM, so please excuse any dumb questions.
> 
> "const" suggests the blob returned remains owned by "obj";

Yes, it is owned by the generator object.

fw_cfg_add_from_generator() does a memdup().

> that answers
> the question whether the caller should attempt to free the blob. (The
> answer is "no".)
> 
> (2) However, will this perhaps expose other functions, currently taking
> non-const-qualified pointers, to which we'd like to pass the blob
> returned by the above member function?
> 
> Because, then we'd have to cast away "const",

It is illegal to cast away "const". This is why I choose to use it here,
if the consumer want to modify it, it is forced to make its own copy.

> and I find that much
> uglier than removing the "const" from *here*, and adding a more verbose
> comment as replacement.
> 
> Yes, this is clearly speculation -- IOW just a question. If all the
> functions we're going to pass the return value to are fine with
> pointer-to-const, then this interface should be OK.

The only user so far uses memdup().

> 
> (Obviously when I say "cast away const", I think of functions that do
> not actually modify the object pointed-to by the non-const-qualified
> pointer.)
> 
>> +    /**
>> +     * get_length:
>> +     * @obj: the object implementing this interface
>> +     *
>> +     * Returns: the size of the generated item data in bytes
>> +     */
>> +    size_t (*get_length)(Object *obj);
>> +} FWCfgDataGeneratorClass;
>> +
>>  typedef struct fw_cfg_file FWCfgFile;
>>  
>>  #define FW_CFG_ORDER_OVERRIDE_VGA    70
>> @@ -263,6 +292,26 @@ void fw_cfg_add_file_callback(FWCfgState *s, const char *filename,
>>  void *fw_cfg_modify_file(FWCfgState *s, const char *filename, void *data,
>>                           size_t len);
>>  
>> +/**
>> + * fw_cfg_add_from_generator:
>> + * @s: fw_cfg device being modified
>> + * @filename: name of new fw_cfg file item
>> + * @generator_id: name of object implementing FW_CFG_DATA_GENERATOR interface
>> + * @errp: pointer to a NULL initialized error object
>> + *
>> + * Add a new NAMED fw_cfg item with the content generated from the
>> + * @generator_id object. The data referenced by the starting pointer is copied
> 
> (3) s/referenced by the starting pointer/generated by the @generator_id
> object/
> 
>> + * into the data structure of the fw_cfg device.
>> + * The next available (unused) selector key starting at FW_CFG_FILE_FIRST
>> + * will be used; also, a new entry will be added to the file directory
>> + * structure residing at key value FW_CFG_FILE_DIR, containing the item name,
>> + * data size, and assigned selector key value.
>> + *
>> + * Returns: the size of the generated item data on success, -1 otherwise.
> 
> (4) I don't like ssize_t for a return value like this.
> 
> First, get_length() returns size_t, which may not be representable in an
> ssize_t.
> 
> (Actually, it's worse than that; POSIX says, "the type ssize_t shall be
> capable of storing values at least in the range [-1, {SSIZE_MAX}]" --
> and if I run "getconf SSIZE_MAX", I get 32767. Indeed, _POSIX_SSIZE_MAX,
> which is the minimum for any implementation's SSIZE_MAX, is 32767.)
> 
> Second, is a zero-sized blob useful in fw_cfg (from a generator)?

Not for now. We can add it later anyway.

> 
> If it is not useful, then this function should return size_t, and use
> retval=0 for signaling an error.

OK.

> 
> If a zero-sized blob is useful, then the function should return a bool
> (in addition to producing "errp"), and output the blob size as a
> separate parameter.
> 
>> + */
>> +ssize_t fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
>> +                                  const char *generator_id, Error **errp);
>> +
>>  FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>>                                  AddressSpace *dma_as);
>>  FWCfgState *fw_cfg_init_io(uint32_t iobase);
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index 8dd50c2c72..e18cb074df 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -1032,6 +1032,30 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
>>      return NULL;
>>  }
>>  
>> +ssize_t fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
>> +                                  const char *generator_id, Error **errp)
>> +{
>> +    FWCfgDataGeneratorClass *k;
>> +    Object *o;
> 
> (5) Not sure about QEMU coding standards, but the above single-char
> variable names (especially "o") terrify me. Please use "klass" and "obj".
> 
> Do ignore my request if these variable names are just fine in QEMU.

I don't want to terrify you :P

> 
>> +    size_t sz;
>> +
>> +    o = object_resolve_path_component(object_get_objects_root(), generator_id);
>> +    if (!o) {
>> +        error_setg(errp, "Cannot find object ID %s", generator_id);
>> +        return -1;
>> +    }
>> +    if (!object_dynamic_cast(o, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)) {
>> +        error_setg(errp, "Object '%s' is not a fw_cfg-data-generator subclass",
>> +                         generator_id);
> 
> (6) We should probably not open code
> TYPE_FW_CFG_DATA_GENERATOR_INTERFACE as "fw_cfg-data-generator" even in
> the error message.
> 
> (7) If this branch is taken, would that arguably merit an assertion
> failure? I mean, can the dynamic cast fail without QEMU having a related
> bug somewhere? (Maybe this is going to be answered in the rest of the
> series.) Because I see those OBJECT_CHECK macros near the top of
> "fw_cfg.h", and those boil down to object_dynamic_cast_assert().
> 
>> +        return -1;
>> +    }
>> +    k = FW_CFG_DATA_GENERATOR_GET_CLASS(o);
>> +    sz = k->get_length(o);
>> +    fw_cfg_add_file(s, filename, g_memdup(k->get_data(o), sz), sz);
> 
> (g_memdup() takes a "guint" for "byte_size". Whether that matches
> "size_t" is anyone's guess. I guess it can't be helped.)

Similarly it returns a gpointer...

> 
>> +
>> +    return sz;
> 
> Right, this is the size_t --> ssize_t conversion that makes me
> uncomfortable.
> 
> I'm OK if you ignore all of my comments, these are simply the thoughts
> that crossed my mind.

Thanks for them!

Regards,

Phil.

> 
> Thanks
> Laszlo
> 
>> +}
>> +
>>  static void fw_cfg_machine_reset(void *opaque)
>>  {
>>      MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
>> @@ -1333,12 +1357,18 @@ static const TypeInfo fw_cfg_mem_info = {
>>      .class_init    = fw_cfg_mem_class_init,
>>  };
>>  
>> +static const TypeInfo fw_cfg_data_generator_interface_info = {
>> +    .name = TYPE_FW_CFG_DATA_GENERATOR_INTERFACE,
>> +    .parent = TYPE_INTERFACE,
>> +    .class_size = sizeof(FWCfgDataGeneratorClass),
>> +};
>>  
>>  static void fw_cfg_register_types(void)
>>  {
>>      type_register_static(&fw_cfg_info);
>>      type_register_static(&fw_cfg_io_info);
>>      type_register_static(&fw_cfg_mem_info);
>> +    type_register_static(&fw_cfg_data_generator_interface_info);
>>  }
>>  
>>  type_init(fw_cfg_register_types)
>>
> 


