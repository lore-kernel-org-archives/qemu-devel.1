Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58602C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A562064C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ioi61CSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A562064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jif09-00065P-EW
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 10:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiezK-0005fV-3x
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 10:12:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55485
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiezJ-0007av-2D
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 10:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591711944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4Ch6MgFqMM/LC/nmJLaxCxxIkU7CWFPL8lzeYEaZWas=;
 b=Ioi61CSXofzP1/dGzqYGvY3cIagbWnx90TvP/I2akVOa/vAJN8mBGZbFecAYEQJc6+YwrV
 sgCEUGd4Hvz3ftME0CANwYHdiGFRyOfhPFRtgmdIrMK2tmlW0/y8ZDBopg1vri5S33OKzH
 vMrxAGquGdVL1OXTIfsJR0BBtTJacMM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-FcccE9EDObuV7Dq_S1GpIw-1; Tue, 09 Jun 2020 10:12:22 -0400
X-MC-Unique: FcccE9EDObuV7Dq_S1GpIw-1
Received: by mail-wm1-f70.google.com with SMTP id a18so665972wmm.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 07:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4Ch6MgFqMM/LC/nmJLaxCxxIkU7CWFPL8lzeYEaZWas=;
 b=rB5oPO/+tF5UrxdxnYHNVgh6cK8wds7IlVOiq1upUI6YLrmK5vgiH6CEk58v6LDsOg
 iciZ/JoLpxE2Jgu3VfkLqxB9uLd0hfm9r5E7NbmupqH64ByorTXIb9MsoNu7uco4ls1V
 JgPrHNPO3+VZ6oUzwKN0z68LT38EqhjVxboysJw97Qe/JkDlDtqNYHRmqT0/Jrh10rWl
 jro8NPM8VlbDevXPf5tkUe/lgTPPiGZa0tG4tHbDf/OEA6kEiC8kKUJG1i1rfa/2FnN+
 o/u3oddixtqTIL5dz18uFi45PAJzo1pEEmLFU8SZss4OcXSUKYh9HO758+kQhYD9wJ+u
 LtdQ==
X-Gm-Message-State: AOAM533NvI+GzLQ/REjW0PupEoRRYQS+mrbjTyYrhYX2ZWmgy4tcXe5V
 o1vCF2KNIEiWPjYMF8wOkdFdEyiyZq2L9g1v7D0/bgJ1330jmjRRNBogKbhmRGsA7yqH26U+plM
 nEbX0dT1DkUj15vo=
X-Received: by 2002:a5d:684a:: with SMTP id o10mr4504041wrw.4.1591711941289;
 Tue, 09 Jun 2020 07:12:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWorE6dCL6gKnPKJm3aUQdVyVjUDnLZ9alxtKJSzoCtKPCTsIwH85Zi602zBlyBINHou9YpQ==
X-Received: by 2002:a5d:684a:: with SMTP id o10mr4504008wrw.4.1591711940976;
 Tue, 09 Jun 2020 07:12:20 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id v66sm3119072wme.13.2020.06.09.07.12.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 07:12:20 -0700 (PDT)
Subject: Re: [PATCH v7 2/5] softmmu/vl: Let -fw_cfg option take a 'gen_id'
 argument
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Corey Minyard <minyard@acm.org>
References: <20200528173141.17495-1-philmd@redhat.com>
 <20200528173141.17495-3-philmd@redhat.com>
 <f3f6154e-bbc1-98bd-0f44-77b28c74915f@redhat.com>
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
Message-ID: <d8bc0e7b-4e18-c1f0-3046-7299dfd6de9e@redhat.com>
Date: Tue, 9 Jun 2020 16:12:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f3f6154e-bbc1-98bd-0f44-77b28c74915f@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 11:50 AM, Laszlo Ersek wrote:
> Gerd, Corey: there's a question for you near the end, please.
> 
> On 05/28/20 19:31, Philippe Mathieu-Daudé wrote:
>> The 'gen_id' argument refers to a QOM object able to produce
>> data consumable by the fw_cfg device. The producer object must
>> implement the FW_CFG_DATA_GENERATOR interface.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> v7:
>> - renamed 'blob_id' -> 'gen_id' (danpb)
>> - update comment in code (lersek)
>> - fixed CODING_STYLE (lersek)
>> - use Laszlo's if (SUM(options)) != 1 { error } form
>> ---
>>  softmmu/vl.c | 22 ++++++++++++++--------
>>  1 file changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>> index ae5451bc23..cdb1d187ed 100644
>> --- a/softmmu/vl.c
>> +++ b/softmmu/vl.c
>> @@ -489,6 +489,11 @@ static QemuOptsList qemu_fw_cfg_opts = {
>>              .name = "string",
>>              .type = QEMU_OPT_STRING,
>>              .help = "Sets content of the blob to be inserted from a string",
>> +        }, {
>> +            .name = "gen_id",
>> +            .type = QEMU_OPT_STRING,
>> +            .help = "Sets id of the object generating the fw_cfg blob "
>> +                    "to be inserted",
>>          },
>>          { /* end of list */ }
>>      },
>> @@ -2020,7 +2025,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>>  {
>>      gchar *buf;
>>      size_t size;
>> -    const char *name, *file, *str;
>> +    const char *name, *file, *str, *gen_id;
>>      FWCfgState *fw_cfg = (FWCfgState *) opaque;
>>
>>      if (fw_cfg == NULL) {
>> @@ -2030,14 +2035,13 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>>      name = qemu_opt_get(opts, "name");
>>      file = qemu_opt_get(opts, "file");
>>      str = qemu_opt_get(opts, "string");
>> +    gen_id = qemu_opt_get(opts, "gen_id");
>>
>> -    /* we need name and either a file or the content string */
>> -    if (!(nonempty_str(name) && (nonempty_str(file) || nonempty_str(str)))) {
>> -        error_setg(errp, "invalid argument(s)");
>> -        return -1;
>> -    }
>> -    if (nonempty_str(file) && nonempty_str(str)) {
>> -        error_setg(errp, "file and string are mutually exclusive");
>> +    /* we need the name, and exactly one of: file, content string, gen_id */
>> +    if (!nonempty_str(name) ||
>> +          nonempty_str(file) + nonempty_str(str) + nonempty_str(gen_id) != 1) {
> 
> (1) I believe the indentation of this line is not correct. I think it
> should be out-dented by 2 spaces.
> 
>> +        error_setg(errp, "name, plus exactly one of file,"
>> +                         " string and gen_id, are needed");
>>          return -1;
>>      }
>>      if (strlen(name) > FW_CFG_MAX_FILE_PATH - 1) {
>> @@ -2052,6 +2056,8 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>>      if (nonempty_str(str)) {
>>          size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
>>          buf = g_memdup(str, size);
>> +    } else if (nonempty_str(gen_id)) {
>> +        return fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);
> 
> (2) This is no longer correct: fw_cfg_add_from_generator() now returns 0
> on failure, but parse_fw_cfg() is supposed to return nonzer on failure.
> See the comment on qemu_opts_foreach() -- "parse_fw_cfg" is passed as
> the loop callback to qemu_opts_foreach().
> 
> Technically, we could simply write
> 
>         return !fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);
> 
> but that wouldn't be consistent with the -1 error codes returned
> elsewhere from parse_fw_cfg(). So how about:
> 
>         size_t fw_cfg_size;
> 
>         fw_cfg_size = fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);
>         return (fw_cfg_size > 0) ? 0 : -1;
> 
> I think your testing may have missed this because the problem is only
> visible if you have *another* -fw_cfg option on the QEMU command line.
> Returning the wrong status code from here terminates the
> qemu_opts_foreach() loop, without attempting to set "error_fatal".
> Therefore the loop is silently terminated, thus the only symptom would
> be that -fw_cfg options beyond the "gen_id" one wouldn't take effect.
> 
> 
> (3) I've noticed another *potential* issue, from looking at the larger
> context. I apologize for missing it in v6.
> 
> See commit bab47d9a75a3 ("Sort the fw_cfg file list", 2016-04-07). (I'm
> copying Corey; Gerd is already copied.) From that commit, we have, at
> the end of this function:
> 
>     /* For legacy, keep user files in a specific global order. */
>     fw_cfg_set_order_override(fw_cfg, FW_CFG_ORDER_OVERRIDE_USER);
>     fw_cfg_add_file(fw_cfg, name, buf, size);
>     fw_cfg_reset_order_override(fw_cfg);
> 
> This takes effect for "file" and "string", but not for "gen_id". Should
> we apply it to "gen_id" as well? (Sorry, I really don't understand what
> commit bab47d9a75a3 is about!)
> 
> *IF* we want to apply the same logic to "gen_id", then we should
> *perhaps* do, on the "nonempty_str(gen_id)" branch:
> 
>         size_t fw_cfg_size;
> 
>         fw_cfg_set_order_override(fw_cfg, FW_CFG_ORDER_OVERRIDE_USER);
>         fw_cfg_size = fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);
>         fw_cfg_reset_order_override(fw_cfg);
>         return (fw_cfg_size > 0) ? 0 : -1;
> 
> I think???
> 
> Or maybe even use FW_CFG_ORDER_OVERRIDE_DEVICE rather than
> FW_CFG_ORDER_OVERRIDE_USER? I don't have the slightest clue.
> 
> (I guess if I understood what commit bab47d9a75a3 was about, I'd be less
> in doubt now. But that commit only hints at "avoid[ing] any future
> issues of moving the file creation" -- I don't know what those issues
> were in the first place!)

Since the filename is not listed in fw_cfg_order[], it falls to
the "unknown stuff at the end":

   /* Stick unknown stuff at the end. */
   error_report("warning: Unknown firmware file in legacy mode: %s\n",
name);
   return FW_CFG_ORDER_OVERRIDE_LAST;

Which seems safe (we do not mess with firmware specific DEVICE/USER
entries).

Gerd?

> 
> With (1) optionally fixed, and (2) fixed, I'd be willing to R-b this
> patch; but I'm really thrown off by (3).

I addressed (1) and (2), thanks for your review :)

> 
> Thanks,
> Laszlo
> 
> 
>>      } else {
>>          GError *err = NULL;
>>          if (!g_file_get_contents(file, &buf, &size, &err)) {
>>
> 


