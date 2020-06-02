Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE997C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:17:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BBE20659
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drRSJT5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BBE20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg8fa-0001t2-TC
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 11:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jg8ed-0000wB-Jw
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:16:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48976
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jg8ec-0006nF-Ho
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591110997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5d0r4xpOaaozoK2FL/klQUzR7XC88uuoH579R6j7uQ=;
 b=drRSJT5Y6WrC9gYKSShCb47i7JKG3oodvTVX3zVtUfGdqG4+bSQPHEa84PElpLNcKQ30u/
 vumionq5uwy8rf5IIcsJ7dNn7Jt9fMpVRR9mvCLfXmKuIwmseS/Q860vir4STUZMQb0PT7
 SBY6PcULFyav/A85medG1VZTvk916cI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-9wC5EBKrOzq-0QIPxwlFjw-1; Tue, 02 Jun 2020 11:16:34 -0400
X-MC-Unique: 9wC5EBKrOzq-0QIPxwlFjw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B06E107ACCA;
 Tue,  2 Jun 2020 15:16:32 +0000 (UTC)
Received: from [10.36.113.56] (ovpn-113-56.ams2.redhat.com [10.36.113.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F5157E7E1;
 Tue,  2 Jun 2020 15:16:27 +0000 (UTC)
Subject: Re: [PATCH v3 1/4] acpi: Convert build_tpm2() to build_append* API
To: Stefan Berger <stefanb@linux.ibm.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200601095737.32671-1-eric.auger@redhat.com>
 <20200601095737.32671-2-eric.auger@redhat.com>
 <46c71777-b588-ce1f-eb8d-de1c5b3e2186@linux.ibm.com>
 <6bd7f3a0-5a40-823e-bf67-309c9995e18e@redhat.com>
 <a85cc67e-2d8a-2034-3b85-6e8c8d7dcad6@linux.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b1cf9216-39ff-c597-c919-b944f76ec9b0@redhat.com>
Date: Tue, 2 Jun 2020 17:16:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a85cc67e-2d8a-2034-3b85-6e8c8d7dcad6@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 22:14:55
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
Cc: marcandre.lureau@redhat.com, drjones@redhat.com, lersek@redhat.com,
 ardb@kernel.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 6/2/20 4:24 PM, Stefan Berger wrote:
> On 6/2/20 9:55 AM, Auger Eric wrote:
>> Hi Stefan,
>> On 6/2/20 3:30 PM, Stefan Berger wrote:
>>> On 6/1/20 5:57 AM, Eric Auger wrote:
>>>> In preparation of its move to the generic acpi code,
>>>> let's convert build_tpm2() to use build_append API. This
>>>> latter now is prefered in place of direct ACPI struct field
>>>> settings with manual endianness conversion.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>> ---
>>>>    hw/i386/acpi-build.c | 28 +++++++++++++++++++---------
>>>>    1 file changed, 19 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>>> index b5669d6c65..f0d35d7b17 100644
>>>> --- a/hw/i386/acpi-build.c
>>>> +++ b/hw/i386/acpi-build.c
>>>> @@ -2298,30 +2298,40 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker
>>>> *linker, GArray *tcpalog)
>>>>    static void
>>>>    build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>>>>    {
>>>> -    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data, sizeof
>>>> *tpm2_ptr);
>>>> +    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data,
>>>> sizeof(AcpiTableHeader));
>>> And now you want to build the data structure by pushing fields? I would
>>> definitely NOT do this.
>> If I didn't misinterpret things, this was recommended by Drew and Igor
>> as buid_append* API avoids to take care of endianness and this is the
>> API now used in the generic ACPI code. Besides I also think that in that
>> case it does not simplify things but maybe I did that the wrong way? Or
>> maybe I didn't understand your remark?
> 
> 
> If that's what they are saying... I would prefer filling out data
> structures with functions like cpu_to_acpi16() because that seems to be
> less error prone.
understood. Let's wait for other comments and we will make a decision
wrt direction.
> 
> 
>>>
>>>>        unsigned log_addr_size =
>>>> sizeof(tpm2_ptr->log_area_start_address);
>>>>        unsigned log_addr_offset =
>>>>            (char *)&tpm2_ptr->log_area_start_address -
>>>> table_data->data;
>>>> +    uint8_t start_method_params[12] = {};
>>>>    -    tpm2_ptr->platform_class = cpu_to_le16(TPM2_ACPI_CLASS_CLIENT);
>>>> +    /* platform class */
>>>> +    build_append_int_noprefix(table_data, TPM2_ACPI_CLASS_CLIENT, 2);
>>>> +    /* reserved */
>>>> +    build_append_int_noprefix(table_data, 0, 2);
>>>>        if (TPM_IS_TIS_ISA(tpm_find())) {
>>>> -        tpm2_ptr->control_area_address = cpu_to_le64(0);
>>>> -        tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_MMIO);
>>>> +        /* address of control area */
>>>> +        build_append_int_noprefix(table_data, 0, 8);
>>>> +        /* start method */
>>>> +        build_append_int_noprefix(table_data, TPM2_START_METHOD_MMIO,
>>>> 4);
>>>>        } else if (TPM_IS_CRB(tpm_find())) {
>>>> -        tpm2_ptr->control_area_address =
>>>> cpu_to_le64(TPM_CRB_ADDR_CTRL);
>>>> -        tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_CRB);
>>>> +        build_append_int_noprefix(table_data, TPM_CRB_ADDR_CTRL, 8);
>>>> +        build_append_int_noprefix(table_data,
>>>> TPM2_START_METHOD_CRB, 4);
>>>>        } else {
>>>>            g_warn_if_reached();
>>>>        }
>>>>    -    tpm2_ptr->log_area_minimum_length =
>>>> -        cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
>>>> +    /* platform specific parameters */
>>>> +    g_array_append_vals(table_data, &start_method_params, 12);
> 
> Maybe this should be wrapped in an inline function like
> build_append_array() or so.
Hum OK
> 
> 
>>>>    -    acpi_data_push(tcpalog,
>>>> le32_to_cpu(tpm2_ptr->log_area_minimum_length));
>>>> +    /* log area minimum length */
>>>> +    build_append_int_noprefix(table_data,
>>>> TPM_LOG_AREA_MINIMUM_SIZE, 4);
>>>> +
>>>> +    acpi_data_push(tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);
> 
> 
> At this point we have a double-allocation of log memory on x86_64. You'd
> need the patch I posted to create the TCPA table only for TPM 1.2.
This series applies on top of this patch (mentionned in the cover letter).
> 
> 
> 
>>>>        bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE,
>>>> tcpalog, 1,
>>>>                                 false);
>>>>          /* log area start address to be filled by Guest linker */
>>>> +    build_append_int_noprefix(table_data, 0, 8);
>>>>        bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>>>>                                       log_addr_offset, log_addr_size,
>>>>                                       ACPI_BUILD_TPMLOG_FILE, 0);
>>>
> 
> 
> 
Thanks

Eric


