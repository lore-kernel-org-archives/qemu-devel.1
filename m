Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C83C3F68F
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3969021775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLpWaQvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3969021775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izl43-0004Gp-Cm
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:35:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izkzV-0006M9-TQ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izkzT-0004Xo-UX
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43303
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izkzT-0004TC-NT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581010258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i8JiYZVOJu5q//tmja+OBMF2YiOBbBgKePYXyDb7DGI=;
 b=SLpWaQvTeWFVseEkC1smdjbaI6M9wB2CikXWFFtHFJN+7h1bO4rpocxXd0PMJiYpJffFrh
 GQHukXpCcndche1ibWDF//fbO7HstND9lmY3eFQnqBBSo8JZ4dAI/kH/C9Of+I8IWg/F4W
 Q9QGD47K9l5/btKERO2ilM9IUztnhuA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-AaC2mE-kPSeZo4OowMOOaA-1; Thu, 06 Feb 2020 12:30:41 -0500
Received: by mail-wr1-f72.google.com with SMTP id l1so3874803wrt.4
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:30:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zKer39OlqBDoVg/X7loIhKNGNv4NijwSiS5IwOXSSWI=;
 b=p7zTfcxSIrJ+3n9pY0JwE0sGUNZkIi43a+iuqMePJvWysNzy4xBW2IocOKVaqNypt3
 +jD0GdvyKGIBq6QMsEiTJoKFp7evCGaZdCTFo1LQebIjk60GBqonCVtZkSaZtiDkVHBN
 kQcn9NDRMoYaurIsdUXKxuEYEr96/igNHXECqdkN7Kw92AW8y8HMtYL8avyh/ovARFNa
 aYksR3RI7DX1zqfOr1sG2ElNNvxnwYNuscWOS0wah9jEcp8gvjxzGphC/fsbrdWEwn60
 6vjXBF2U6h/vNKgmLH1PiMrfcxFneaepegpmNx4NLOYnQhn6ZfA9ugc5y1K/zQ9PwplL
 oHhw==
X-Gm-Message-State: APjAAAXFrxr0UKuqvrJ4lSN8zWTN1nLceMxv2iVpOdYlmvuLWcmg9T/i
 4YIiREqrcWSRLPGiCvMj4GgvjZqieo12+pKEC7UQhyXRRr4KGYxB41Fgz6Ep2UZB1VF6Dl7UhXi
 hWaGrFTJRckGECvQ=
X-Received: by 2002:a1c:8055:: with SMTP id b82mr5823959wmd.127.1581010238888; 
 Thu, 06 Feb 2020 09:30:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqzdpUEwpnSPms6bTRPpIIyv9V0mlsKGJVJRMdrgxjcvLrfLQC7vypawtm8XIz5SMBOUuqzxww==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr5823936wmd.127.1581010238663; 
 Thu, 06 Feb 2020 09:30:38 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id p11sm5014539wrn.40.2020.02.06.09.30.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 09:30:37 -0800 (PST)
Subject: Re: [PATCH] tests/acceptance/virtio_check_params: Disable test
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20200206171715.25041-1-philmd@redhat.com>
 <20200206182417.01de2834.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <69ccada3-d660-1938-6528-9711a0700e92@redhat.com>
Date: Thu, 6 Feb 2020 18:30:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206182417.01de2834.cohuck@redhat.com>
Content-Language: en-US
X-MC-Unique: AaC2mE-kPSeZo4OowMOOaA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 6:24 PM, Cornelia Huck wrote:
> On Thu,  6 Feb 2020 18:17:15 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> This test fails on various CI:
>>
>> - Using QEMU 4.0:
>>
>>    tests/acceptance/x86_cpu_model_versions.py:X86CPUModelAliases.test_no=
ne_alias:  ERROR: 'alias-of' (0.45 s)
>>
>> - On OSX
>>
>>     Unexpected error in object_property_find() at qom/object.c:1201:
>>     qemu-system-x86_64: -device virtio-blk-pci,id=3Dscsi0,drive=3Ddrive0=
: can't apply global virtio-blk-device.scsi=3Dtrue: Property '.scsi' not fo=
und
>=20
> Hm, but there was a fix for that, wasn't there?

Yes, the patch is on the list:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg675259.html

Michael S. Tsirkin takes virtio, I'll ping him to see if he wants a=20
respin or can take it and amend your suggestions.

>>
>> - When removing unavailable machine:
>>
>>    VirtioMaxSegSettingsCheck.test_machine_types: ERROR: list.remove(x): =
x not in list (0.12 s)
>>
>> - Using Xen:
>>
>>    xencall: error: Could not obtain handle on privileged command interfa=
ce: No such file or directory
>>    xen be core: xen be core: can't open xen interface
>>
>> - On PPC:
>>
>>    TestFail: machine type pseries-2.8: No Transactional Memory support i=
n TCG, try appending -machine cap-htm=3Doff
>>
>> - On S390X:
>>
>>    ERROR: qemu-system-s390x: -device virtio-scsi-pci,id=3Dscsi0: 'virtio=
-scsi-pci' is not a valid device model name
>=20
> Depends on how your QEMU is configured... does virtio-pci default to
> off on s390x? I use it all the time to test pci :)

Yes, this is a --without-default-devices job indeed.

>>
>> Disable it for now.
>>
>> Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> Series fixing the errors:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg675074.html
>> ---
>>   tests/acceptance/virtio_check_params.py | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>=20
> It seems reasonable though to disable it until the problems are fixed.

The patches are on the list, they simply need review :)

> Acked-by: Cornelia Huck <cohuck@redhat.com>

Thanks,

Phil.


