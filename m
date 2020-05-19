Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39F8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 22:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67144205CB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 22:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOB6gRLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67144205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbAJ7-0001SI-I1
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 18:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jbAIU-000123-V3
 for qemu-devel@nongnu.org; Tue, 19 May 2020 18:01:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39141
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jbAIT-0004kZ-7s
 for qemu-devel@nongnu.org; Tue, 19 May 2020 18:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589925671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dd1yLfUuiO7hD8ou1fpDXvOSTRK6ZEAapj8j6xKUowM=;
 b=FOB6gRLl1BoOTJURqEYbSvmS4l9NMtgaeFHgllS+zur7Msdl6srcB8aIFlJ+NXhteNDuEe
 7wW8KLmWcXXQKasHyx25gh3iGzk8/xpTazKYQXC/yu8Q14GxWeh3pb3GItPkd0De6wYhS6
 6xypFa5aeekHBHqP/hgfp08UGJlLuoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-Gv449etUMsaElnVLtaHUoA-1; Tue, 19 May 2020 18:01:09 -0400
X-MC-Unique: Gv449etUMsaElnVLtaHUoA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B66DA100CD0A
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 22:01:08 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-149.ams2.redhat.com
 [10.36.114.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2807E1001B07;
 Tue, 19 May 2020 22:01:06 +0000 (UTC)
Subject: Re: [PATCH v6 1/5] hw/nvram/fw_cfg: Add the FW_CFG_DATA_GENERATOR
 interface
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200519182024.14638-1-philmd@redhat.com>
 <20200519182024.14638-2-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <845b9e8e-0925-da57-a484-3a96d554432d@redhat.com>
Date: Wed, 20 May 2020 00:01:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200519182024.14638-2-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:56:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
 "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/19/20 20:20, Philippe Mathieu-Daudé wrote:
> The FW_CFG_DATA_GENERATOR allow any object to product

(1) I suggest:

s/allow/allows/
s/product/produce/

> blob of data consumable by the fw_cfg device.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/hw/nvram/fw_cfg.h | 49 +++++++++++++++++++++++++++++++++++++++
>  hw/nvram/fw_cfg.c         | 30 ++++++++++++++++++++++++
>  2 files changed, 79 insertions(+)
> 
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index 25d9307018..74b4790fae 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -9,11 +9,40 @@
>  #define TYPE_FW_CFG     "fw_cfg"
>  #define TYPE_FW_CFG_IO  "fw_cfg_io"
>  #define TYPE_FW_CFG_MEM "fw_cfg_mem"
> +#define TYPE_FW_CFG_DATA_GENERATOR_INTERFACE "fw_cfg-data-generator"
>  
>  #define FW_CFG(obj)     OBJECT_CHECK(FWCfgState,    (obj), TYPE_FW_CFG)
>  #define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG_IO)
>  #define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG_MEM)
>  
> +#define FW_CFG_DATA_GENERATOR_CLASS(class) \
> +    OBJECT_CLASS_CHECK(FWCfgDataGeneratorClass, (class), \
> +                       TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)
> +#define FW_CFG_DATA_GENERATOR_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(FWCfgDataGeneratorClass, (obj), \
> +                     TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)
> +
> +typedef struct FWCfgDataGeneratorClass {
> +    /*< private >*/
> +    InterfaceClass parent_class;
> +    /*< public >*/
> +
> +    /**
> +     * get_data:
> +     * @obj: the object implementing this interface
> +     *
> +     * Returns: pointer to start of the generated item data
> +     */
> +    const void *(*get_data)(Object *obj);

I'm not familiar with QOM, so please excuse any dumb questions.

"const" suggests the blob returned remains owned by "obj"; that answers
the question whether the caller should attempt to free the blob. (The
answer is "no".)

(2) However, will this perhaps expose other functions, currently taking
non-const-qualified pointers, to which we'd like to pass the blob
returned by the above member function?

Because, then we'd have to cast away "const", and I find that much
uglier than removing the "const" from *here*, and adding a more verbose
comment as replacement.

Yes, this is clearly speculation -- IOW just a question. If all the
functions we're going to pass the return value to are fine with
pointer-to-const, then this interface should be OK.

(Obviously when I say "cast away const", I think of functions that do
not actually modify the object pointed-to by the non-const-qualified
pointer.)

> +    /**
> +     * get_length:
> +     * @obj: the object implementing this interface
> +     *
> +     * Returns: the size of the generated item data in bytes
> +     */
> +    size_t (*get_length)(Object *obj);
> +} FWCfgDataGeneratorClass;
> +
>  typedef struct fw_cfg_file FWCfgFile;
>  
>  #define FW_CFG_ORDER_OVERRIDE_VGA    70
> @@ -263,6 +292,26 @@ void fw_cfg_add_file_callback(FWCfgState *s, const char *filename,
>  void *fw_cfg_modify_file(FWCfgState *s, const char *filename, void *data,
>                           size_t len);
>  
> +/**
> + * fw_cfg_add_from_generator:
> + * @s: fw_cfg device being modified
> + * @filename: name of new fw_cfg file item
> + * @generator_id: name of object implementing FW_CFG_DATA_GENERATOR interface
> + * @errp: pointer to a NULL initialized error object
> + *
> + * Add a new NAMED fw_cfg item with the content generated from the
> + * @generator_id object. The data referenced by the starting pointer is copied

(3) s/referenced by the starting pointer/generated by the @generator_id
object/

> + * into the data structure of the fw_cfg device.
> + * The next available (unused) selector key starting at FW_CFG_FILE_FIRST
> + * will be used; also, a new entry will be added to the file directory
> + * structure residing at key value FW_CFG_FILE_DIR, containing the item name,
> + * data size, and assigned selector key value.
> + *
> + * Returns: the size of the generated item data on success, -1 otherwise.

(4) I don't like ssize_t for a return value like this.

First, get_length() returns size_t, which may not be representable in an
ssize_t.

(Actually, it's worse than that; POSIX says, "the type ssize_t shall be
capable of storing values at least in the range [-1, {SSIZE_MAX}]" --
and if I run "getconf SSIZE_MAX", I get 32767. Indeed, _POSIX_SSIZE_MAX,
which is the minimum for any implementation's SSIZE_MAX, is 32767.)

Second, is a zero-sized blob useful in fw_cfg (from a generator)?

If it is not useful, then this function should return size_t, and use
retval=0 for signaling an error.

If a zero-sized blob is useful, then the function should return a bool
(in addition to producing "errp"), and output the blob size as a
separate parameter.

> + */
> +ssize_t fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
> +                                  const char *generator_id, Error **errp);
> +
>  FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>                                  AddressSpace *dma_as);
>  FWCfgState *fw_cfg_init_io(uint32_t iobase);
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 8dd50c2c72..e18cb074df 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -1032,6 +1032,30 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
>      return NULL;
>  }
>  
> +ssize_t fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
> +                                  const char *generator_id, Error **errp)
> +{
> +    FWCfgDataGeneratorClass *k;
> +    Object *o;

(5) Not sure about QEMU coding standards, but the above single-char
variable names (especially "o") terrify me. Please use "klass" and "obj".

Do ignore my request if these variable names are just fine in QEMU.

> +    size_t sz;
> +
> +    o = object_resolve_path_component(object_get_objects_root(), generator_id);
> +    if (!o) {
> +        error_setg(errp, "Cannot find object ID %s", generator_id);
> +        return -1;
> +    }
> +    if (!object_dynamic_cast(o, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)) {
> +        error_setg(errp, "Object '%s' is not a fw_cfg-data-generator subclass",
> +                         generator_id);

(6) We should probably not open code
TYPE_FW_CFG_DATA_GENERATOR_INTERFACE as "fw_cfg-data-generator" even in
the error message.

(7) If this branch is taken, would that arguably merit an assertion
failure? I mean, can the dynamic cast fail without QEMU having a related
bug somewhere? (Maybe this is going to be answered in the rest of the
series.) Because I see those OBJECT_CHECK macros near the top of
"fw_cfg.h", and those boil down to object_dynamic_cast_assert().

> +        return -1;
> +    }
> +    k = FW_CFG_DATA_GENERATOR_GET_CLASS(o);
> +    sz = k->get_length(o);
> +    fw_cfg_add_file(s, filename, g_memdup(k->get_data(o), sz), sz);

(g_memdup() takes a "guint" for "byte_size". Whether that matches
"size_t" is anyone's guess. I guess it can't be helped.)

> +
> +    return sz;

Right, this is the size_t --> ssize_t conversion that makes me
uncomfortable.

I'm OK if you ignore all of my comments, these are simply the thoughts
that crossed my mind.

Thanks
Laszlo

> +}
> +
>  static void fw_cfg_machine_reset(void *opaque)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
> @@ -1333,12 +1357,18 @@ static const TypeInfo fw_cfg_mem_info = {
>      .class_init    = fw_cfg_mem_class_init,
>  };
>  
> +static const TypeInfo fw_cfg_data_generator_interface_info = {
> +    .name = TYPE_FW_CFG_DATA_GENERATOR_INTERFACE,
> +    .parent = TYPE_INTERFACE,
> +    .class_size = sizeof(FWCfgDataGeneratorClass),
> +};
>  
>  static void fw_cfg_register_types(void)
>  {
>      type_register_static(&fw_cfg_info);
>      type_register_static(&fw_cfg_io_info);
>      type_register_static(&fw_cfg_mem_info);
> +    type_register_static(&fw_cfg_data_generator_interface_info);
>  }
>  
>  type_init(fw_cfg_register_types)
> 


