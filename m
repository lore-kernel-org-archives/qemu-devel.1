Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F017C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDADA206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qldix5U+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDADA206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVy4b-0006AL-4P
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVy3N-0004uW-OM
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:56:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39896
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVy3M-00030O-Pl
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588686968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GqjJKj8vl5w2nF+/ZoGSPZtf7fkexGsWEfDvmSN8bf0=;
 b=Qldix5U+NQtbhry83Lxvc22NBsY5Vi5hSfV2C4Pwpm6mxM7lZzshlSOY9LfsdDWreZx160
 lfeKu4Z0wcbsls2Xpzlo+MpU+fKGePk/DO2iH8uo+mdvJzYEIuj0ItJUdshZGi6CJ0Uyi7
 6gvq+Qtno7bi5bWJrv5482qfeXo73RM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-ZRl3PRPVMLeTDKH-J6VZgA-1; Tue, 05 May 2020 09:56:03 -0400
X-MC-Unique: ZRl3PRPVMLeTDKH-J6VZgA-1
Received: by mail-wr1-f72.google.com with SMTP id v17so1240001wrq.8
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 06:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Odo0HaRODgXKYRiDbnYesTbfQvkc1Oe3VZx7d1vIliU=;
 b=U60NKubJSBjKT0EbAHz7Nx9K9nx2AtFCj+IIhGBkfiYx7+jGf1KvZNRUq1ONshB8oK
 xgmkC2j2BkBnG4KAqohH1QSH4O0hNfObs1ouHn3R5d0pSqfKYxCBvTZlLpleeH4ZMLx+
 HEdrjFDZOPm6NJZ1UmddXtN//NT1BBUmOngyS/y+tcxlKpY+vEdfcbIlF7BUYrXP33Vt
 mKRvKP56s+Q7AYaJ5u19nPr+X3wSrTygMPLiLQ6GViHWr1AMTaGP4CXQV5q+6hcpjVuq
 XDMmsDIreXruyWCELhb1DAApJ8Ftm/oHb25GszwSfz1IWHy9MrvbGotfn9ZA4+15HRSP
 1oSQ==
X-Gm-Message-State: AGi0Pubg04/URcU+bg9YnWaIqHsrsyCKgkRUuyWNMkHrNGEoYXXBmEm3
 014hKZAEmyEFnMCYKkstERGA4tVlgtfGlVXEgFRDSnXtIn/eKBJUiqXTsrI75IT0pypQms2D731
 oP971zwgIdG765RA=
X-Received: by 2002:a1c:5448:: with SMTP id p8mr3381228wmi.173.1588686962349; 
 Tue, 05 May 2020 06:56:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypKPG2+9WRhWYvVyd6+cVVkzlJpqzM/DeMz9N0fQiTyhE729YudHI0TEuEeDZJrelmcOZzK1Dg==
X-Received: by 2002:a1c:5448:: with SMTP id p8mr3381193wmi.173.1588686962125; 
 Tue, 05 May 2020 06:56:02 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id f63sm3863626wma.47.2020.05.05.06.56.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 06:56:01 -0700 (PDT)
Subject: Re: [PATCH 0/4] Add support for SafeStack
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
 <51f28cf2-0f34-508f-96f8-02c02b3c8a85@redhat.com>
 <20200505133111.GM764268@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c6ac2d0e-34bf-9927-f2fe-2ef0408dcbfb@redhat.com>
Date: Tue, 5 May 2020 15:56:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505133111.GM764268@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Tobin Feldman-Fitzthum <tobin@ibm.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Daniele Buono <dbuono@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 3:31 PM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, May 05, 2020 at 03:15:18PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> +Alex & Daniel who keep track on CI stuff.
>>
>> On 4/29/20 9:44 PM, Daniele Buono wrote:
>>> LLVM supports SafeStack instrumentation to protect against stack buffer
>>> overflows, since version 3.7
>>>
>>>   From https://clang.llvm.org/docs/SafeStack.html:
>>> "It works by separating the program stack into two distinct regions: th=
e
>>> safe stack and the unsafe stack. The safe stack stores return addresses=
,
>>> register spills, and local variables that are always accessed in a safe
>>> way, while the unsafe stack stores everything else. This separation
>>> ensures that buffer overflows on the unsafe stack cannot be used to
>>> overwrite anything on the safe stack."
>>>
>>> Unfortunately, the use of two stack regions does not cope well with
>>> QEMU's coroutines. The second stack region is not properly set up with
>>> both ucontext and sigaltstack, so multiple coroutines end up sharing th=
e
>>> same memory area for the unsafe stack, causing undefined behaviors at
>>> runtime (and most iochecks to fail).
>>>
>>> This patch series fixes the implementation of the ucontext backend and
>>> make sure that sigaltstack is never used if the compiler is applying
>>> the SafeStack instrumentation. It also adds a configure flag to enable
>>> SafeStack, and enables iotests when SafeStack is used.
>>>
>>> This is an RFC mainly because of the low-level use of the SafeStack
>>> runtime.
>>> When running swapcontext(), we have to manually set the unsafe stack
>>> pointer to the new area allocated for the coroutine. LLVM does not allo=
w
>>> this by using builtin, so we have to use implementation details that ma=
y
>>> change in the future.
>>> This patch has been tested briefly ( make check on an x86 system ) with
>>> clang v3.9, v4.0, v5.0, v6.0
>>> Heavier testing, with make check-acceptance has been performed with
>>> clang v7.0
>>
>> I noticed building using SafeStack is slower, and running with it is eve=
n
>> sloooower. It makes sense to have this integrated if we use it regularly=
. Do
>> you have plan for this? Using public CI doesn't seem reasonable.
>=20
> The runtime behaviour is rather odd, given the docs they provide:
>=20
> "The performance overhead of the SafeStack instrumentation is
>   less than 0.1% on average across a variety of benchmarks
>   This is mainly because most small functions do not have any
>   variables that require the unsafe stack and, hence, do not
>   need unsafe stack frames to be created. The cost of creating
>   unsafe stack frames for large functions is amortized by the
>   cost of executing the function.
>=20
>    In some cases, SafeStack actually improves the performance"

I'm sorry I was testing this with a single core instead of all of=20
them... Thanks for looking at the doc.

>=20
> Regards,
> Daniel
>=20


