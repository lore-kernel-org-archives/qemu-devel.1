Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC62FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE3821548
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrAhA71/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE3821548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeHKl-0004lE-SP
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 08:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeHJb-0002mN-Cl
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:07:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29406
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeHJZ-0005le-Ld
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590667632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WhZ1PqdStw7dynAMKPNKscbS/4zMe+ZtwfVbjIlBU5g=;
 b=NrAhA71/1+R2ZMn9g2DQ93HtGqoimS5Yvb1WiXngzm5aSq0BUCwKiGJY2daYO31PonoHwL
 1JlGnBkzvyctZEwFqxrXtaPkKlvniihDT9FxBDvOyHhwtZoVD+6ghR5ylIWu1p58Wo9oxK
 LnwmJDI9xYlHsPNFWny9xH9avSVdnjA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-iOnhk7bZOuq7fyjjk740cg-1; Thu, 28 May 2020 08:07:10 -0400
X-MC-Unique: iOnhk7bZOuq7fyjjk740cg-1
Received: by mail-wr1-f71.google.com with SMTP id e1so10058354wrm.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 05:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=WhZ1PqdStw7dynAMKPNKscbS/4zMe+ZtwfVbjIlBU5g=;
 b=kvEf2/m2jGZoBn6HAn+pP8phPcAe0GUbrZH8t2t/Shai5BJn79SwLI9av71FdTBz8n
 94Pv4xRL5/TtI9QKB5WCkefE8IFdV1k7NBHHMcBWq56M1kk8JJoK3exaxU4U48qXAfbH
 l6ZeD7glsUxjBMHPM/2EKLj4nX+jrLUDJBfahEQmhXeiKeyY0qinMRCL76xjIo3kMWgI
 954t6blHye44XnFRMeTC1cHo1RhVb8KlHHPWwGY4HkRpcvZUBXQZV80Yigd188Pw3b7V
 f3xrGpEje8hIY/TqYEXd8ctbNOvChOG5UtZyibaonTx9PpyAp9Ee9fwzSDMoKjaIDYGx
 2bOQ==
X-Gm-Message-State: AOAM53220vb2s+Le93Fe4zrP24C3N/vwMSS0mOd7qEgJj8oXitaARAnl
 fMjPfkCcUD9Z4UVCG4yrpCIIuzqwzO1J6UML9WPOJQ0mjoaptI8p1v59VL65No36Xg0JS+WelC8
 n6Rj/3sHC+1GPOGY=
X-Received: by 2002:a1c:230f:: with SMTP id j15mr3268821wmj.100.1590667629057; 
 Thu, 28 May 2020 05:07:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8XPs8O9vT+FEEe6CRCk5LsomZzN0mmaZIbD+/omLy0bVxaHKh1/tkRHnxwnifcVtW+dFcNQ==
X-Received: by 2002:a1c:230f:: with SMTP id j15mr3268796wmj.100.1590667628762; 
 Thu, 28 May 2020 05:07:08 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id g82sm6573588wmf.1.2020.05.28.05.07.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2020 05:07:07 -0700 (PDT)
Subject: Re: [PATCH v6 2/5] softmmu/vl: Let -fw_cfg option take a 'blob_id'
 argument
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
References: <20200519182024.14638-1-philmd@redhat.com>
 <20200519182024.14638-3-philmd@redhat.com>
 <ce1f0c80-f26b-40de-6d5b-2dc8f92fcfa2@redhat.com>
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
Message-ID: <41f963dc-ac0f-7a7d-9d19-fcbd2e846926@redhat.com>
Date: Thu, 28 May 2020 14:07:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ce1f0c80-f26b-40de-6d5b-2dc8f92fcfa2@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 06:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 5/20/20 12:34 AM, Laszlo Ersek wrote:
> On 05/19/20 20:20, Philippe Mathieu-Daudé wrote:
>> The 'blob_id' argument refers to a QOM object able to produce
>> data consumable by the fw_cfg device. The producer object must
>> implement the FW_CFG_DATA_GENERATOR interface.
> 
> OK, this answers my OBJECT_CHECK() question under patch #1 (in the
> negative -- an assert would be wrong).
> 
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  softmmu/vl.c | 17 +++++++++++++----
>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>> index ae5451bc23..f76c53ad2e 100644
>> --- a/softmmu/vl.c
>> +++ b/softmmu/vl.c
>> @@ -489,6 +489,10 @@ static QemuOptsList qemu_fw_cfg_opts = {
>>              .name = "string",
>>              .type = QEMU_OPT_STRING,
>>              .help = "Sets content of the blob to be inserted from a string",
>> +        }, {
>> +            .name = "blob_id",
>> +            .type = QEMU_OPT_STRING,
>> +            .help = "Sets id of the object generating fw_cfg blob to be used",
>>          },
>>          { /* end of list */ }
>>      },
>> @@ -2020,7 +2024,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>>  {
>>      gchar *buf;
>>      size_t size;
>> -    const char *name, *file, *str;
>> +    const char *name, *file, *str, *blob_id;
>>      FWCfgState *fw_cfg = (FWCfgState *) opaque;
>>
>>      if (fw_cfg == NULL) {
>> @@ -2030,14 +2034,17 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>>      name = qemu_opt_get(opts, "name");
>>      file = qemu_opt_get(opts, "file");
>>      str = qemu_opt_get(opts, "string");
>> +    blob_id = qemu_opt_get(opts, "blob_id");
>>
>>      /* we need name and either a file or the content string */
> 
> (1) Please update this comment. If the option is given, we need the
> name, and exactly one of: file, content string, blob_id.
> 
>> -    if (!(nonempty_str(name) && (nonempty_str(file) || nonempty_str(str)))) {
>> +    if (!(nonempty_str(name)
>> +          && (nonempty_str(file) || nonempty_str(str) || nonempty_str(blob_id)))
>> +         ) {
>>          error_setg(errp, "invalid argument(s)");
>>          return -1;
>>      }
> 
> (2) Coding style: does QEMU keep operators on the left or on the right
> when breaking subconditions to new lines? (I vaguely recall "to the
> right", but I could be wrong... Well, "hw/nvram/fw_cfg.c" has at least 7
> examples of the operator being on the right.)

You are right, I have been confused with a recommendation from Eric
Blake, but it was about shell script, not C.

> 
>> -    if (nonempty_str(file) && nonempty_str(str)) {
>> -        error_setg(errp, "file and string are mutually exclusive");
>> +    if (nonempty_str(file) && nonempty_str(str) && nonempty_str(blob_id)) {
>> +        error_setg(errp, "file, string and blob_id are mutually exclusive");
>>          return -1;
>>      }
> 
> (3) I believe this catches only when all three of name/string/blob_id
> are given. But we should continue catching "two given".
> 
> How about reworking both "if"s, *and* the comment at (1) at the same
> time, into:
> 
>     if (!nonempty_str(name) ||
>         nonempty_str(file) + nonempty_str(str) + nonempty_str(blob_id) != 1) {
>         error_setg(errp, "name, plus exactly one of file, string and blob_id, "
>                    "are needed");
>         return -1;
>     }
> 
> (Regarding the addition, nonempty_str() returns a "bool", which is a
> macro to _Bool, which is promoted to "int" or "unsigned int".)
> 
>>      if (strlen(name) > FW_CFG_MAX_FILE_PATH - 1) {
>> @@ -2052,6 +2059,8 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>>      if (nonempty_str(str)) {
>>          size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
>>          buf = g_memdup(str, size);
>> +    } else if (nonempty_str(blob_id)) {
>> +        return fw_cfg_add_from_generator(fw_cfg, name, blob_id, errp);
>>      } else {
>>          GError *err = NULL;
>>          if (!g_file_get_contents(file, &buf, &size, &err)) {
>>
> 
> (4) The "-fw_cfg" command line option is documented in both the qemu(1)
> manual, and the "docs/specs/fw_cfg.txt" file.
> 
> I think we may have to update those. In particular I mean *where* the
> option is documented (in both texts).

Oh I forgot this part, thanks.

> 
> In the manual, "-fw_cfg" is currently under "Debug/Expert options", but
> that will no longer apply (I think?) after this series.

Well I'm not sure, the intent is the same, targeting mostly libvirt as
management interface; other uses are for "experts".

> 
> Similarly, in "docs/specs/fw_cfg.txt", the section is called "Externally
> Provided Items" -- but that might not be strictly true any more either.
> 
> Maybe leave the current "-fw_cfg" mentions in peace, and document
> "-fw_cfg blob_id=..." separately (in different docs sections)? The
> "fw_cfg generators" concept could deserve dedicated sections.
> 
> Sorry that I can't make a good concrete suggestion. :(

Thanks for the detailed review!

> 
> Thanks,
> Laszlo
> 


