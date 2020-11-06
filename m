Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B16C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 10:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E43D20720
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 10:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ejZ6JohK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E43D20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kayz5-0001Fj-Sy
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 05:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kayy4-0000nM-Jf
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 05:27:40 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kayy2-0000Sh-QB
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 05:27:40 -0500
Received: by mail-wr1-x443.google.com with SMTP id a3so727184wrx.13
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 02:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=SyBKF5lvpBcPf2igl0ogG/qJ4sn+brqfAU2r6HmwwSE=;
 b=ejZ6JohKG0rn5WQjVRFWJbtHCFsrWiqlveT4qu6dAxHWdIe/z6hoGvh+j+dvqZBsQs
 6CNA9CGpTD/0rr2V5PFwRIKF071QDT8Iocm29HCpZELu3WHs6kmBY7ovACtfc6Fcp5dj
 Eg1NpxjnRLMuzCOFUQo6BTgA1t31GjfUK9rlXZg/qz6U9AzPZfLtX1T0YHWCCLKA6m8Q
 6TC9GnP1DY7A1flkOXGdwv87t1lsdB7vaDmpwitbv9JFKcK1B/O1ThCk5TIrZNt2gNXP
 VJVYo5qlv0Ye2rjkJwfk8DApma5vT8SlTBs+usTLk1Vo/+JXiZ04DbmOMu8PTqZfsTEC
 j9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=SyBKF5lvpBcPf2igl0ogG/qJ4sn+brqfAU2r6HmwwSE=;
 b=VCtD/vAsTIqMZc7STKzdpsJrzRtjCPJVY9p6+u/cWSpAwdkTyniP1mUmEuzi7HkGNU
 Bnhz2W9pq5FV1F95m90WegiwfbZho2QCXrsOr+nVXi/3LMJGgrCGCECaycDjA6WwNJlT
 8rg8tvsxYgE7NhjE/nmm3jeAZdA++L+i6AppWH+43gYEorR8hGHMI14TtYKXYyA9E27m
 XylvvtfZxye0yH4R2y8v2IOrEHdClJKlA5I2WILv92LN72FA8E2Mrvui+0yvvZyDlraS
 qHx8KZ0wSI29H4+8u/fBOsomsMan1qpfzqO1vjQLan4DnBU2M8sTDSx6ySN3JTsk3ZZQ
 6uRw==
X-Gm-Message-State: AOAM530rC4y6fqwHIJaaHsS1FSz/kmYHzNP0miR9IE8w+xdm6BU+9T6c
 BAVXrYG3seHQcyKRH84Qqw9fbg==
X-Google-Smtp-Source: ABdhPJw553yGEbhizv9iCXBgj+jdsaxGTZUcWSpTtS2mWg52QvG6/RKniP75yXJMvBedSQPMaQAwbw==
X-Received: by 2002:a05:6000:8d:: with SMTP id
 m13mr1824130wrx.216.1604658457162; 
 Fri, 06 Nov 2020 02:27:37 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u6sm1526567wmj.40.2020.11.06.02.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 02:27:35 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 156E71FF7E;
 Fri,  6 Nov 2020 10:27:35 +0000 (GMT)
References: <20201105175153.30489-1-alex.bennee@linaro.org>
 <20201105175153.30489-13-alex.bennee@linaro.org>
 <11afa6f8-ec49-ab2b-2011-ef22665cd0c3@redhat.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH 12/15] stubs/xen-hw-stub: drop
 xenstore_store_pv_console_info stub
In-reply-to: <11afa6f8-ec49-ab2b-2011-ef22665cd0c3@redhat.com>
Date: Fri, 06 Nov 2020 10:27:35 +0000
Message-ID: <871rh6bx0o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, julien@xen.org,
 masami.hiramatsu@linaro.org, Paul Durrant <paul@xen.org>,
 andre.przywara@arm.com, stefano.stabellini@linaro.org, qemu-devel@nongnu.org,
 takahiro.akashi@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 stefano.stabellini@xilinx.com, stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 11/5/20 6:51 PM, Alex Benn=C3=A9e wrote:
>> We should never build something that calls this without having it.
>
> "because ..."?

  xen-all.c is only built when we have CONFIG_XEN which also gates the
  only call-site in xen-console.c

>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  stubs/xen-hw-stub.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>=20
>> diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c
>> index 2ea8190921..15f3921a76 100644
>> --- a/stubs/xen-hw-stub.c
>> +++ b/stubs/xen-hw-stub.c
>> @@ -10,10 +10,6 @@
>>  #include "hw/xen/xen.h"
>>  #include "hw/xen/xen-x86.h"
>>=20=20
>> -void xenstore_store_pv_console_info(int i, Chardev *chr)
>> -{
>> -}
>> -
>>  int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
>>  {
>>      return -1;
>>=20


--=20
Alex Benn=C3=A9e

