Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46941C2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 18:31:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C9E2076E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 18:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8ye/B0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C9E2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLt0G-0004vu-6C
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 14:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jLsyp-0003rI-PF
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 14:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jLsyo-0003PG-31
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 14:29:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46674
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jLsyn-0003Ok-Sk
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 14:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586284185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bd2H+NTI2koe7NaQqDZlR02eOTqwCttD4aQTIMfQyQ=;
 b=K8ye/B0Xi6267eg0feF02qxHGf0699Jw57Y0RRgesmllZ4hYspeawf7ga8t1StghqCprMr
 tftASdSU41erxliybk7kiBNGW7tKNr1Fo34Ixjhtn+sHKNQLNpQipSDRGXbvOftoczCV5F
 so+rO40jfFYfczMy8r5FC5xMD1RGZp4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-L3x7v3IqNcm8LfQjdOqzEQ-1; Tue, 07 Apr 2020 14:29:43 -0400
X-MC-Unique: L3x7v3IqNcm8LfQjdOqzEQ-1
Received: by mail-wm1-f72.google.com with SMTP id s22so1294708wmh.8
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 11:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4bd2H+NTI2koe7NaQqDZlR02eOTqwCttD4aQTIMfQyQ=;
 b=QHT8tGQdfGOO+IJoZpQFz2MAY3VdWv1PaHUxXTGGcS7mL3Sx5yDGYv9OvHvKF9JPgq
 biONJ/DQKqaVJXFrpk2GEYnpkWFhfNcdTn6moSmztbxGKnz1ITxBY1rqlBVEpgQI9jkx
 BSRRC4kpl3vd+D2TQHdM8RkfPXkEBJA3Ort1s3jaSsnsoHbtfqR/BNmND0U+t+CVMFNo
 zQEbU0vIAHregRYBLdFR41KJ+4nAcFTHgtlepWZwRG67gV1WTiS9RaUJVERxltq8T1B1
 A8hma2/kPxwa94Q+l2f9kAR6gm1FDMo2xV6cMFDeNfi+mmh+nuuR6Y/2lgI18TJfrQwd
 L1eA==
X-Gm-Message-State: AGi0PuaR0SfGwSO/GAapxp1YZSOYq6sar++4AQy+wu52hA3q+CDvVeTv
 NriZgvoCuBkVJkRKMYqOrOu05Ujv+2x3Od0id7EtyVKxs8fY5zasoL4kJf4OtI6xP/PwqCZeyIf
 TsnRT473YJURU0SQ=
X-Received: by 2002:a05:600c:22ca:: with SMTP id
 10mr563832wmg.19.1586284181830; 
 Tue, 07 Apr 2020 11:29:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypI+RPBSiPm1RlD0aU/DKuXSw3HHAwl/vXtPdHnG7jbCv9/OHMBYNtB1aPhK2FDflxtXg1bjDw==
X-Received: by 2002:a05:600c:22ca:: with SMTP id
 10mr563808wmg.19.1586284181531; 
 Tue, 07 Apr 2020 11:29:41 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id d13sm5193207wrg.21.2020.04.07.11.29.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 11:29:41 -0700 (PDT)
Subject: Re: [PATCH] exec: fetch the alignment of Linux devdax pmem character
 device nodes
To: Joao Martins <joao.m.martins@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <20200401031314.11592-1-jingqi.liu@intel.com>
 <c906a3ae-c9d2-5802-5988-3c1d0302109b@oracle.com>
 <CAPcyv4igr9-DJx2ehoHj7sXk5g5GmgmivCqM3VpmJV7J4QM+kA@mail.gmail.com>
 <3873cb30-608c-6a27-c19f-f6446898796f@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6d9ef17e-315c-e01e-db56-bde97f0ab1a8@redhat.com>
Date: Tue, 7 Apr 2020 20:29:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3873cb30-608c-6a27-c19f-f6446898796f@oracle.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Jingqi Liu <jingqi.liu@intel.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/04/20 20:28, Joao Martins wrote:
> On 4/7/20 5:55 PM, Dan Williams wrote:
>> On Tue, Apr 7, 2020 at 4:01 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>> On 4/1/20 4:13 AM, Jingqi Liu wrote:
>>>> If the backend file is devdax pmem character device, the alignment
>>>> specified by the option 'align=NUM' in the '-object memory-backend-file'
>>>> needs to match the alignment requirement of the devdax pmem character device.
>>>>
>>>> This patch fetches the devdax pmem file 'align', so that we can compare
>>>> it with the NUM of 'align=NUM'.
>>>> The NUM needs to be larger than or equal to the devdax pmem file 'align'.
>>>>
>>>> It also fixes the problem that mmap() returns failure in qemu_ram_mmap()
>>>> when the NUM of 'align=NUM' is less than the devdax pmem file 'align'.
>>>>
>>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>>> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
>>>> ---
>>>>  exec.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>>>>  1 file changed, 45 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/exec.c b/exec.c
>>>> index de9d949902..8221abffec 100644
>>>> --- a/exec.c
>>>> +++ b/exec.c
>>>> @@ -1736,6 +1736,42 @@ static int64_t get_file_size(int fd)
>>>>      return size;
>>>>  }
>>>>
>>>> +static int64_t get_file_align(int fd)
>>>> +{
>>>> +    int64_t align = -1;
>>>> +#if defined(__linux__)
>>>> +    struct stat st;
>>>> +
>>>> +    if (fstat(fd, &st) < 0) {
>>>> +        return -errno;
>>>> +    }
>>>> +
>>>> +    /* Special handling for devdax character devices */
>>>> +    if (S_ISCHR(st.st_mode)) {
>>>> +        g_autofree char *subsystem_path = NULL;
>>>> +        g_autofree char *subsystem = NULL;
>>>> +
>>>> +        subsystem_path = g_strdup_printf("/sys/dev/char/%d:%d/subsystem",
>>>> +                                         major(st.st_rdev), minor(st.st_rdev));
>>>> +        subsystem = g_file_read_link(subsystem_path, NULL);
>>>> +
>>>> +        if (subsystem && g_str_has_suffix(subsystem, "/dax")) {
>>>> +            g_autofree char *align_path = NULL;
>>>> +            g_autofree char *align_str = NULL;
>>>> +
>>>> +            align_path = g_strdup_printf("/sys/dev/char/%d:%d/device/align",
>>>> +                                    major(st.st_rdev), minor(st.st_rdev));
>>>> +
>>>
>>> Perhaps, you meant instead:
>>>
>>>         /sys/dev/char/%d:%d/align
>>>
>>
>> Hmm, are you sure that's working? 
> 
> It is, except that I made the slight mistake of testing with a bunch of wip
> patches on top which one of them actually adds the 'align' to child dax device.
> 
> Argh, my apologies - and thanks for noticing.
> 
>> I expect the alignment to be found
>> in the region device:
>>
>> /sys/class/dax:
>> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus1/region1/dax1.1/dax1.0
>> $(readlink -f /sys/dev/char/253\:263)/../align
>> $(readlink -f /sys/dev/char/253\:263)/device/align
>>
>>
>> /sys/bus/dax:
>> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus1/region1/dax1.0/dax1.0
>> $(readlink -f /sys/dev/char/253\:265)/../align
>> $(readlink -f /sys/dev/char/253\:265)/device/align <-- No such file
>>
>> The use of the /sys/dev/char/%d:%d/device is only supported by the
>> deprecated /sys/class/dax. 
> 
> I don't have the deprecated dax class enabled as could you tell, so the second
> case is what I was testing. Except it wasn't a namespace/nvdimm but rather an
> hmem device-dax.
> 
> '../align' though covers only one case? What about hmem which '../align' returns
> ENOENT; perhaps using '../dax_region/align' instead which is common to both?
> Albeit that wouldn't address the sub-division devices (that I mention above)

Clearly a 5.1 patch then. :)

Paolo



